From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/2] On Cygwin support both UNIX and DOS style path-names
Date: Thu, 11 Aug 2011 21:35:39 +0100
Message-ID: <4E443D1B.60306@ramsay1.demon.co.uk>
References: <1312560614-20772-1-git-send-email-pascal@obry.net> <1312560614-20772-3-git-send-email-pascal@obry.net> <4E416D4A.40602@ramsay1.demon.co.uk> <4E419AB3.7090405@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Sat Aug 13 19:02:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsHbT-000748-7f
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 19:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351Ab1HMRC0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Aug 2011 13:02:26 -0400
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:33707 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751201Ab1HMRCZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2011 13:02:25 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1QsHan-0004cT-cr; Sat, 13 Aug 2011 17:01:49 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4E419AB3.7090405@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179280>

Pascal Obry wrote:
> Le 09/08/2011 19:24, Ramsay Jones a =E9crit :
>> Pascal Obry wrote:
>>> In fact Cygwin supports both, so make Git agree with this.
>>> The failing case is when a file is committed in a sub-dir of the
>>> repository using a log message from a file specified with a DOS
>>> style path-name. To reproduce:
>>>
>>>     $ cd src
>>>     $ git commit -F c:\tmp\log.txt file.c
>>>     fatal: could not read log file 'src/c:\tmp\log.txt': No such fi=
le \
>>>     or directory.
>> Hmm, are you using bash or cmd.exe? Using bash I get the following:
>=20
> bash.

Ah, OK. The example in your commit message looked odd (ie incorrect) wh=
ich
made me think that you were probably using cnd.exe, so ...

>>      $ cd src
>>      $ git commut -F c:\tmp\log.txt file.c
>>      fatal: could not read file 'src/c:tmplog.txt': No such file or =
directory
>>      $
>>
>> Which is what I would expect of (any) posix shell, viz:
>>
>>      $ ls c:\
>>      >  ^C
>>      $ ls c:\\
>>      AUTOEXEC.BAT*            NTDETECT.COM*               WATCOM/   =
    msysgit/
>>      CMPNENTS/                Program Files/              WINDOWS/  =
    msysgit-old/
>>      CONFIG.SYS*              RECYCLER/                   boot.ini* =
    ntldr*
>>      Documents and Settings/  SUPPORT/                    cygwin/   =
    pagefile.sys
>>      I386/                    SWSTAMP.TXT*                cygwintemp=
/   ssl/
>>      IO.SYS*                  System Volume Information/  dm/       =
    uname/
>>      MSDOS.SYS*               TOOLSCD/                    dm840/    =
    zlib/
>>      MSOCache/                VALUEADD/                   hiberfil.s=
ys
>=20
> Exactly, \\ this is what I have used and this is the bug. Cygwin=20
> supports ls c:\\ so should Cygwin/Git. My quoted example was missing =
the=20
> escape \.

 ... could you please correct your commit message. Thanks!

ATB,
Ramsay Jones
