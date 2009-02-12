From: Jon Nelson <jnelson@jamponi.net>
Subject: git gc --prune consumes *lots* of memory with repos cloned with 
	--reference
Date: Thu, 12 Feb 2009 12:32:13 -0600
Message-ID: <cccedfc60902121032y17180739r2a049197323d3588@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 19:33:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXgNb-0008Ho-2K
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 19:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757800AbZBLScP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 13:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757076AbZBLScP
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 13:32:15 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:11058 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755237AbZBLScO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 13:32:14 -0500
Received: by yx-out-2324.google.com with SMTP id 8so439512yxm.1
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 10:32:13 -0800 (PST)
Received: by 10.100.143.12 with SMTP id q12mr1492812and.22.1234463533042; Thu, 
	12 Feb 2009 10:32:13 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109636>

The situation:

I cloned linux-2.6
Then I cloned netdev-2.6 with --reference $PWD/linux-2.6
Then I cloned net-2.6 with --reference $PWD/netdev-2.6

The problem:

git gc --prune on netdev-2.6 takes WAY more memory than git gc --prune
on linux-2.6
git gc --prune on net-2.6 takes WAY WAY more memory. 1.5G and counting.

Why does git gc --prune take 1.5G? (git pack-objects is the actual
memory-hungry process)

--
Jon
