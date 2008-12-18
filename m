From: jidanni@jidanni.org
Subject: git-rm -n leaves .git/index.lock if not allowed to finish
Date: Fri, 19 Dec 2008 04:02:48 +0800
Message-ID: <87prjptfo7.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 23:21:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDRFe-0000HG-Bh
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 23:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965AbYLRWUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 17:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752899AbYLRWU3
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 17:20:29 -0500
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:55906 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752811AbYLRWU3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Dec 2008 17:20:29 -0500
Received: from jidanni1.jidanni.org (122-127-37-70.dynamic.hinet.net [122.127.37.70])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id 05505D26B0
	for <git@vger.kernel.org>; Thu, 18 Dec 2008 14:20:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103503>

Bug: if git-rm -n is not allowed to write all it wants to write, it
will leave a .git/index.lock file:
# git-rm -n -r . 2>&1|sed q
error: '.etckeeper' has changes staged in the index
# git-rm -n -r . 2>&1|sed q
fatal: unable to create '.git/index.lock': File exists
