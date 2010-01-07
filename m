From: Andreas Gruenbacher <agruen@suse.de>
Subject: base85: Two tiny fixes
Date: Thu, 7 Jan 2010 15:58:29 +0100
Organization: SUSE Labs
Message-ID: <201001071558.30065.agruen@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 07 16:01:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NStrf-0003Jw-Po
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 16:01:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013Ab0AGPBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 10:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752946Ab0AGPBN
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 10:01:13 -0500
Received: from cantor.suse.de ([195.135.220.2]:51527 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752590Ab0AGPBL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 10:01:11 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 188279417A
	for <git@vger.kernel.org>; Thu,  7 Jan 2010 16:01:11 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31.5-0.1-desktop; KDE/4.3.1; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136347>

While looking at the base85 code I found a bug in the debug code and an 
unnecessary call.  You may want to have a look at the two fixes here:

  http://www.kernel.org/pub/scm/linux/kernel/git/agruen/git.git

There is another little oddity in the way the de85 table is set up: 0 
indicates an invalid entry; to avoid this from clashing with a valid entry, 
valid entries are incremented by one and decremented again while decoding.  
This leads to slightly worse code than using a negative number to indicate 
invalid values (and avoiding to increment/decrement).

Andreas
