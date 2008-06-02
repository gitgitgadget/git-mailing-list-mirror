From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [Bug] vfat: Not a git archive
Date: Mon, 2 Jun 2008 13:39:09 +0300
Message-ID: <20080602103909.GB11287@mithlond.arda.local>
References: <873anwt9ya.fsf@debian.erik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Christensen <thomasc@thomaschristensen.org>
X-From: git-owner@vger.kernel.org Mon Jun 02 12:40:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K37SP-0004HA-SW
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 12:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbYFBKjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 06:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbYFBKjM
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 06:39:12 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:45122 "EHLO
	kirsi1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752111AbYFBKjM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 06:39:12 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.rokki.sonera.fi (8.5.014)
        id 483E837C002DDB4E; Mon, 2 Jun 2008 13:39:06 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1K37RV-00035h-G4; Mon, 02 Jun 2008 13:39:09 +0300
Content-Disposition: inline
In-Reply-To: <873anwt9ya.fsf@debian.erik.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83510>

Thomas Christensen wrote (2008-06-02 12:20 +0200):

> I am having this issue on Debian with kernel 2.6.25 (2.6.24 works fine)
> and git 1.5.5.3.
> 
>   $ git push /media/KINGSTON/foo.git
>   fatal: '/media/KINGSTON/foo.git': unable to chdir or not a git archive
>   fatal: The remote end hung up unexpectedly
> 
> A notable difference between these 2 kernels is this line:
> 
>   [   62.575939] FAT: utf8 is not a recommended IO charset for FAT
>   filesystems, filesystem will be case sensitive!
> 
> which appears in 2.6.25.
> 
> If this bug should be filed against Debian I will do so.

Hmm, for example KDE automatically mounts VFAT filesystems with mount
option "utf8" when using UTF-8 locale. VFAT uses UTF-16 in filenames and
the only way to convert filenames losslessly (apart from the case
insensitive issue) between Linux and VFAT is to use UTF-8 locale in
Linux. I have described the subject in the Debian bug #417324:

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=417324

What locale are you using? What mount options did you use when you
mounted the /media/KINGSTON/ filesystem?
