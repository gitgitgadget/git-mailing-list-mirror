From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: GIT on MinGW - No symbolic links support
Date: Tue, 29 May 2007 09:11:01 +0200
Organization: eudaptics software gmbh
Message-ID: <465BD205.5D7BDF5D@eudaptics.com>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl>
	 <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org>
	 <4659D306.6030803@xs4all.nl> <f3cnm6$gda$1@sea.gmane.org>
	 <00a601c7a09f$218c1020$0200a8c0@AMD2500> <4659F5D0.2070406@xs4all.nl>
	 <00b901c7a0a5$77983420$0200a8c0@AMD2500> <00c401c7a0a7$8a5690a0$0200a8c0@AMD2500>
	 <f329bf540705271455m4c0f5a55v14b9a8cc6bd7778d@mail.gmail.com>
	 <00ef01c7a0ad$78508e00$0200a8c0@AMD2500>  <465A061C.7010803@xs4all.nl>
	 <012d01c7a0b2$374eea50$0200a8c0@AMD2500> <Pine.LNX.4.64.0705280054140.4648@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 29 09:22:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hsw1x-0004Fs-7h
	for gcvg-git@gmane.org; Tue, 29 May 2007 09:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754101AbXE2HWG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 03:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754135AbXE2HWF
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 03:22:05 -0400
Received: from main.gmane.org ([80.91.229.2]:52616 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754101AbXE2HWD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 03:22:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hsvvn-0008ST-PG
	for git@vger.kernel.org; Tue, 29 May 2007 09:15:47 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 May 2007 09:15:37 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 May 2007 09:15:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48670>

Johannes Schindelin wrote:
> 
> Hi,
> 
> On Sun, 27 May 2007, Aaron Gray wrote:
> 
> > Bit of a dampener on GIT on MinGW :-
> >
> >        $ git clone git://git.kernel.org/pub/scm/git/git.git
> >        Initialized empty Git repository in C:/MSYS/src/git/.git/
> >        error: git-checkout-index: unable to create symlink RelNotes (Function
> > not implemented)
> >
> > No Symbolic links !
> >
> > There are symbolic links provided by Windows by SFU (Services For Unix)
> > apparently.
> 
> Does not work on FAT. Has lots of problems.
> 
> That's why Johannes Sixt pushed for core.symlinks, and got it. So maybe
> the templates should set core.symlinks=false?

This setting should be placed into $(sysconfigdir)/gitconfig. I'll hack
up something in the next days. The "challenge" is that $(sysconfigdir)
must not be hardcoded (because the installation location is not known
until runtime). A similar thing I have already done with
$(template_dir).

-- Hannes
