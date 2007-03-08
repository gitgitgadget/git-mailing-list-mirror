From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Git building is borked
Date: Thu, 8 Mar 2007 15:10:46 +0000
Message-ID: <16571667-1962-4BB1-824A-9D7DD0A32747@cam.ac.uk>
References: <4BBB354C-B000-4EF7-B3FF-7B2A4D6DE538@cam.ac.uk> <F0177878-0A2B-43B0-9838-E032FB3A0A58@cam.ac.uk> <20070308145532.GA30674@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 08 16:11:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPKHQ-0008H0-7W
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 16:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbXCHPLa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 10:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbXCHPLa
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 10:11:30 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:44040 "EHLO
	ppsw-9.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbXCHPL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 10:11:29 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from pcuxsup2.csi.cam.ac.uk ([131.111.10.66]:49813)
	by ppsw-9.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:587)
	with esmtpsa (PLAIN:aia21) (TLSv1:AES128-SHA:128)
	id 1HPKGV-0006l3-Vf (Exim 4.63)
	(return-path <aia21@cam.ac.uk>); Thu, 08 Mar 2007 15:10:47 +0000
In-Reply-To: <20070308145532.GA30674@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41748>

btw. Would it be an idea to maybe make building/installing git-gui  
optional?

I actually did "make configure" and then the configure script...  It  
should not be too hard to make that detect whether it is running in  
the git repository and if not and the files are not there either  
automatically disable git-gui.  Or at least allow a "--disable-git- 
gui" switch to ./configure or something.

Would make the lives of weird people like me easier.  (-:

Best regards,

	Anton

On 8 Mar 2007, at 14:55, Shawn O. Pearce wrote:

> Anton Altaparmakov <aia21@cam.ac.uk> wrote:
>> But now I put the git-gui mentions back into the Makefile and tried
>> again it still fails.  Looking at it closer it actually requires me
>> to compile within a checked out git tree, i.e. including the .git
>> directory and all its contents!  That seems even weirder than
>> requiring git to be installed in the first place...
>
> What version of Git specifically are you building with?  How did
> you obtain these source files?
>
> Release tarballs of Git contain a git-gui/credits file that makes
> CREDITS-GEN avoid invoking the not-yet-existing Git.  Building
> git-gui without this file does require not only a working Git
> installation, but also the git-gui object database.  Both of these
> are readily available on a Git hacker's system, and on any system
> that is attempting to create a release tarball.
>
> There are other files included in the release tarballs (version,
> git-gui/version) that are also required to get a correct build when
> you don't have Git installed, or are missing its object database.
> Having these missing does not stop the build process, but it does
> make the output of `git version` and `git gui version` relatively
> useless.
>
>
> So you need to be bootstrapping from a released *.tar.{gz,bz2},
> which can be found here:
>
>   http://www.kernel.org/pub/software/scm/git/
>
>
> Sadly, simply downloading the source files from a random gitweb
> doesn't work anymore.  Yes, I know, my fault.  ;-)

-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
