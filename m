From: "Aaron Gray" <angray@beeb.net>
Subject: Re: GIT on MinGW problem
Date: Fri, 25 May 2007 22:37:18 +0100
Message-ID: <075401c79f14$deff63f0$0200a8c0@AMD2500>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl>  <4656A304.AF39A0B6@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>, "Johannes Sixt" <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Fri May 25 23:37:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrhTv-0005hE-AB
	for gcvg-git@gmane.org; Fri, 25 May 2007 23:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761766AbXEYVhu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 17:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761928AbXEYVhu
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 17:37:50 -0400
Received: from lon1-mail-1.visp.demon.net ([193.195.70.4]:19223 "ehlo
	lon1-mail-1.visp.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762506AbXEYVhs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 May 2007 17:37:48 -0400
Received: from mwgray.force9.co.uk (EHLO AMD2500) ([212.159.110.144])
	by lon1-mail-1.visp.demon.net (MOS 3.7.5a-GA FastPath)
	with ESMTP id FGJ94057 (AUTH angray);
	Fri, 25 May 2007 22:37:46 +0100 (BST)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.3028
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48421>

> Han-Wen Nienhuys wrote:
>> 
>> Aaron Gray escreveu:
>> > Hello,
>> >
>> > I have installed the git-1.5.1-1.mingw.exe from
>> > http://lilypond.org/git/binaries/mingw/.
>> >
>> > On typing 'git' I get a message box saying :-
>> >
>> >        The procedure entry point libiconv could not be located in the
>> > dynamic link library libiconv-2.dll.
>> >
>> > I cannot seem to find libiconv-2.dll anywhere either.
>> 
>> This should be fixed in
>> 
>> http://lilypond.org/git/binaries/mingw/git-1.5.1-2.mingw.exe
>> 
>> it should also set $PATH.
> 
> I gave this some more testing and it turns out to be a well working
> toolset. Thank you very much!
> 
> There were still some issues remaining. These are the ones that should
> be fixable easily:
> 
> * git version reports just:
> 
> git version -dirty
> 
> Since git-gui parses the output of git version, but does not expect it
> to be of this format, and fails with an error message that it cannot
> parse the version.
> 
> * git without an correct git subcommand should list 20 or so commands,
> but it doesn't. The list is just empty.
> 
> * I personally think that the files should go into
> 
> $PROGRAMFILES/Git/{bin,share,lib}
> instead of
> $PROGRAMFILES/Git/usr/{bin,share,lib}
> 
> The more difficult to solve problems are:
> 
> * git-gui and gitk don't work out of the box because they have the path
> to wish hardcoded. They can't be started from CMD at all. I have written
> wrappers gitk.cmd and git-gui.cmd with these 2 lines:
> 
> @echo off
> start wish84 D:/MSYS/1.0/git/bin/gitk %*
> 
> But as you can see, the path is still hard-coded (but it is good enough
> for me for the moment).
> 
> * perl scripts like git-remote contain a hard-coded path to the
> installation directory and don't work for this reason.

Are git init and git clone working for you ?

Aaron
