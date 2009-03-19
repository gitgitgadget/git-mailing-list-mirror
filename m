From: Andreas Gruenbacher <agruen@suse.de>
Subject: git am from scratch
Date: Thu, 19 Mar 2009 16:09:24 +0100
Organization: SUSE Labs / Novell
Message-ID: <200903191609.24812.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 19 16:15:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkJvo-0007o8-Pe
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 16:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098AbZCSPLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 11:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753915AbZCSPLH
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 11:11:07 -0400
Received: from cantor.suse.de ([195.135.220.2]:48823 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424AbZCSPLG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 11:11:06 -0400
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 2C0585F8FF
	for <git@vger.kernel.org>; Thu, 19 Mar 2009 16:11:04 +0100 (CET)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113776>

Hello,

lates git (e986ceb0): there is a bug in git am when trying to recreate the 
entire history of a repository:

	$ git format-patch --stdout rcs-history \
		| ( rm -rf fOo && mkdir fOo && cd fOo && git init && git am )
	Initialized empty Git repository in /home/agruen/git/patch/foo/.git/
	fatal: HEAD: not a valid SHA1
	fatal: bad revision 'HEAD'

When the first commit is added by hand instead, git am will import the rest of 
the mbox without problems. This is annoying because it's at least not 
immediately obvious how to recreate the initial commit with all the metadata.

Is this easily fixed?

Thanks,
Andreas
