From: Vijay Lakshminarayanan <laksvij@gmail.com>
Subject: Re: [PATCH 2/2] On Cygwin support both UNIX and DOS style path-names
Date: Wed, 10 Aug 2011 08:14:51 +0530
Message-ID: <871uwunfx8.fsf@gmail.com>
References: <1312560614-20772-1-git-send-email-pascal@obry.net>
	<1312560614-20772-3-git-send-email-pascal@obry.net>
	<4E416D4A.40602@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pascal Obry <pascal@obry.net>, git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Aug 10 04:45:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqynH-0002w7-7a
	for gcvg-git-2@lo.gmane.org; Wed, 10 Aug 2011 04:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568Ab1HJCpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Aug 2011 22:45:00 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:37838 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab1HJCo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2011 22:44:59 -0400
Received: by yie30 with SMTP id 30so422256yie.19
        for <git@vger.kernel.org>; Tue, 09 Aug 2011 19:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1xk3XkmIQFT6K+MV0XI8TlxHoEpsmMutQ0wcwPC6iXQ=;
        b=SFnHyvpXyhP5rf+KAnFZhd9TSxXSAE6SU3rqcSXMbsqcqnyV6D2jZOq7V9TKWPCxC6
         QYo0XBQQaoFEXPuI54Lkf6SKMuGTrqnXs29az+tMcJoZ4wgM6NycWtJh4eemfM+qej7W
         +PN5omV6m1PwW8e7F3xD6/MkkTjsEhr3JfBGU=
Received: by 10.142.50.11 with SMTP id x11mr3983779wfx.147.1312944298650;
        Tue, 09 Aug 2011 19:44:58 -0700 (PDT)
Received: from BALROG ([59.92.59.141])
        by mx.google.com with ESMTPS id f8sm470028pbk.6.2011.08.09.19.44.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 09 Aug 2011 19:44:57 -0700 (PDT)
In-Reply-To: <4E416D4A.40602@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Tue, 09 Aug 2011 18:24:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (windows-nt)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179054>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Pascal Obry wrote:
>> In fact Cygwin supports both, so make Git agree with this.
>> The failing case is when a file is committed in a sub-dir of the
>> repository using a log message from a file specified with a DOS
>> style path-name. To reproduce:
>> 
>>    $ cd src
>>    $ git commit -F c:\tmp\log.txt file.c
>>    fatal: could not read log file 'src/c:\tmp\log.txt': No such file \
>>    or directory.
>
> Hmm, are you using bash or cmd.exe? Using bash I get the following:
>
>     $ cd src
>     $ git commut -F c:\tmp\log.txt file.c
>     fatal: could not read file 'src/c:tmplog.txt': No such file or directory
>     $ 
>
> Which is what I would expect of (any) posix shell, viz:
>
>     $ ls c:\
>     > ^C
>     $ ls c:\\
>     AUTOEXEC.BAT*            NTDETECT.COM*               WATCOM/       msysgit/
>     CMPNENTS/                Program Files/              WINDOWS/      msysgit-old/
>     CONFIG.SYS*              RECYCLER/                   boot.ini*     ntldr*
>     Documents and Settings/  SUPPORT/                    cygwin/       pagefile.sys
>     I386/                    SWSTAMP.TXT*                cygwintemp/   ssl/
>     IO.SYS*                  System Volume Information/  dm/           uname/
>     MSDOS.SYS*               TOOLSCD/                    dm840/        zlib/
>     MSOCache/                VALUEADD/                   hiberfil.sys
>     $ 

FWIW, I use git on Cygwin and it works quite well.  Cygwin supports
Windows paths when quoted.  So

$ ls 'C:\Users\vijay\Desktop'

works as expected.  This is very useful when you're copying paths from,
say, Windows Explorer, to Cygwin.

> ATB,
> Ramsay Jones
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Cheers
~vijay

Gnus should be more complicated.
