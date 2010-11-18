From: Norbert Nemec <Norbert@Nemec-online.de>
Subject: Re: patch for AIX system
Date: Thu, 18 Nov 2010 08:35:29 +0100
Message-ID: <4CE4D741.2070307@Nemec-online.de>
References: <4CE38472.8070206@Nemec-online.de> <7vr5ejg7oi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 08:35:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIz1y-0002tj-Dj
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 08:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900Ab0KRHfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 02:35:36 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:62328 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754848Ab0KRHff (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 02:35:35 -0500
Received: by ewy8 with SMTP id 8so1792078ewy.19
        for <git@vger.kernel.org>; Wed, 17 Nov 2010 23:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=mLyBWhCnPioKoiTT260TaZQIRT6RpTidfb/rS/M3mjY=;
        b=R4903+K9p6MRnPhN2rpMuk0pxp0P/t0QuYbSFGlnf/NDJrCslcl7Xq8Uh+46BGuf1p
         nAjJE3UqeJ62pUmg2au7ejWPYQJ0wHcjM2d5AvBQGneKiok53qPnouB2IwNvLPcTFICZ
         tEmihPNVgUeUAC9M9OCyo6vJoZXdCWsrMHps4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=f1nqcfpnKnwXOjso5g4+4jjkhh/OR3bejgUlzih78ycMrHNdMxdzHyQdchC4vCPN6x
         9QyGmAlIVnxeesWHUpeURHwNtH8IdSVw4UlVd8GGjSF+Ff0dBQO1MC5o5gaKZgyZCYY1
         p9FTXlaQ9gK05ttP6053HLQVHTFA6c97S95RY=
Received: by 10.213.103.74 with SMTP id j10mr218886ebo.46.1290065733914;
        Wed, 17 Nov 2010 23:35:33 -0800 (PST)
Received: from [141.14.151.101] (marble.rz-berlin.mpg.de [141.14.151.101])
        by mx.google.com with ESMTPS id b52sm105294eei.19.2010.11.17.23.35.31
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Nov 2010 23:35:32 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <7vr5ejg7oi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161652>

Sorry about that and thanks for the patient reply. I'll crank up my 
standard of quality and address the issues with another submission.

Greetings,
Norbert


On 11/17/2010 06:51 PM, Junio C Hamano wrote:
> Norbert Nemec<Norbert@Nemec-online.de>  writes:
>
>> Find attached a small patch to make git install cleanly on an AIX system
> A few comments, some from Documentation/SubmittingPatches.
>
>>  From def4428ad827d1e6550634a2fe1f035c1b148426 Mon Sep 17 00:00:00 2001
>> From: Norbert Nemec<Norbert@Nemec-online.de>
>> Date: Wed, 17 Nov 2010 08:25:44 +0100
>> Subject: [PATCH] Fix for installation on AIX
> Please don't do this; instead, make sure that From/Date/Subject of your
> e-mail usable as the metainfo for the resulting commit (in this case only
> the Subject needs a change) and drop these lines, i.e. make the patch
> inline, not an attachment.
>
> Also make the subject more specific, to make it clear _what_ you fixed;
> phrase it like "Makefile: On AIX, bsdinstall does not understand -d" or
> something, perhaps.
>
>> The BSD style 'install' command is call 'installbsd' and does not support the -d option.
>> Therefore '$(INSTALL) -d' is replaced by a new variable '$(INSTALLDIR)' in all Makefiles
>> which can be changed independently of $(INSTALL).
> These lines are tad too long; please wrap at around 66-72 cols.
>
> Missing sign-off.
>
>> ---
>>   Documentation/Makefile |   10 +++++-----
>>   Makefile               |    7 +++++--
>>   git-gui/Makefile       |    4 ++--
>>   gitk-git/Makefile      |    2 +-
>>   gitweb/Makefile        |    4 ++--
>>   templates/Makefile     |    2 +-
>>   6 files changed, 16 insertions(+), 13 deletions(-)
>>
>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>> index e117bc4..c2db8db 100644
>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> ...
>>   install-pdf: pdf
>> -	$(INSTALL) -d -m 755 $(DESTDIR)$(pdfdir)
>> +	$(INSTALLDIR) -m 755 $(DESTDIR)$(pdfdir)
>>   	$(INSTALL) -m 644 user-manual.pdf $(DESTDIR)$(pdfdir)
>>
>>   install-html: html
> In the main Makefile, we have this line:
>
> 	export DIFF TAR INSTALL DESTDIR SHELL_PATH
>
> so that they can be used in "$(MAKE) -C Documentaiton install-frotz"
> invocations in subdirectories, but I do not see an addition of export in
> your patch, and you do not define INSTALLDIR in Documentation/Makefile
> either.  I wonder how this could possibly work...
>
>> diff --git a/Makefile b/Makefile
>> index 1f1ce04..2664d7c 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -953,6 +954,8 @@ ifeq ($(uname_S),AIX)
>>   	NO_MKSTEMPS = YesPlease
>>   	NO_STRLCPY = YesPlease
>>   	NO_NSEC = YesPlease
>> +	INSTALL = installbsd
>> +	INSTALLDIR = mkdir -p
>>   	FREAD_READS_DIRECTORIES = UnfortunatelyYes
>>   	INTERNAL_QSORT = UnfortunatelyYes
>>   	NEEDS_LIBICONV=YesPlease
> I'd defer this section to AIX experts; I've always assumed that people
> on non-gnu platforms used ginstall, but perhaps AIX doesn't have one?
>
> Other changes looked mostly OK, but I am still wondering how your
> INSTALLDIR is passed down to submakes.
>
>   ... spends quality 30-minutes digging ...
>
> No, your patch does not work.  Have you even tested it?
>
> The attached patch on top of yours makes things working, it seems.
>
> Points to note:
>
>   - People may have already used "make INSTALL=ginstall" and been expecting
>     it to work.  Defining "INSTALLDIR = install -d" as the default will
>     break them (see how I defined it in the attached);
>
>   - "cd gitweb&&  make" is supposed to work, so you would need fallback
>     definitions in Makefiles in subdirectories; and
>
>   - When coming from the toplevel make, submakes do want the INSTALLDIR
>     definition passed from it (see how "export" is used).
>
> Thanks.
>
>   Documentation/Makefile |    3 ++-
>   Makefile               |    4 ++--
>   git-gui/Makefile       |    3 +++
>   gitk-git/Makefile      |    1 +
>   gitweb/Makefile        |    1 +
>   templates/Makefile     |    1 +
>   6 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index c2db8db..5c8aacc 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -44,7 +44,8 @@ ASCIIDOC=asciidoc
>   ASCIIDOC_EXTRA =
>   MANPAGE_XSL = manpage-normal.xsl
>   XMLTO_EXTRA =
> -INSTALL?=install
> +INSTALL ?= install
> +INSTALLDIR ?= $(INSTALL) -d
>   RM ?= rm -f
>   DOC_REF = origin/man
>   HTML_REF = origin/html
> diff --git a/Makefile b/Makefile
> index 2664d7c..b91de40 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -308,7 +308,7 @@ DIFF = diff
>   TAR = tar
>   FIND = find
>   INSTALL = install
> -INSTALLDIR = install -d
> +INSTALLDIR = $(INSTALL) -d
>   RPMBUILD = rpmbuild
>   TCL_PATH = tclsh
>   TCLTK_PATH = wish
> @@ -1573,7 +1573,7 @@ endif
>   ALL_CFLAGS += $(BASIC_CFLAGS)
>   ALL_LDFLAGS += $(BASIC_LDFLAGS)
>
> -export DIFF TAR INSTALL DESTDIR SHELL_PATH
> +export DIFF TAR INSTALL INSTALLDIR DESTDIR SHELL_PATH
>
>
>   ### Build rules
> diff --git a/git-gui/Makefile b/git-gui/Makefile
> index b96b3df..be8bd2d 100644
> --- a/git-gui/Makefile
> +++ b/git-gui/Makefile
> @@ -44,6 +44,9 @@ endif
>   ifndef INSTALL
>   	INSTALL = install
>   endif
> +ifndef INSTALLDIR
> +	INSTALLDIR = $(INSTALL) -d
> +endif
>
>   RM_RF     ?= rm -rf
>   RMDIR     ?= rmdir
> diff --git a/gitk-git/Makefile b/gitk-git/Makefile
> index b838d87..473c500 100644
> --- a/gitk-git/Makefile
> +++ b/gitk-git/Makefile
> @@ -11,6 +11,7 @@ msgsdir_SQ  = $(subst ','\'',$(msgsdir))
>   TCL_PATH ?= tclsh
>   TCLTK_PATH ?= wish
>   INSTALL ?= install
> +INSTALLDIR ?= $(INSTALL) -d
>   RM ?= rm -f
>
>   DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
> diff --git a/gitweb/Makefile b/gitweb/Makefile
> index 3f1ac82..ee6dcc1 100644
> --- a/gitweb/Makefile
> +++ b/gitweb/Makefile
> @@ -16,6 +16,7 @@ gitwebdir ?= /var/www/cgi-bin
>
>   RM ?= rm -f
>   INSTALL ?= install
> +INSTALLDIR ?= $(INSTALL) -d
>
>   # default configuration for gitweb
>   GITWEB_CONFIG = gitweb_config.perl
> diff --git a/templates/Makefile b/templates/Makefile
> index 3808b04..953037c 100644
> --- a/templates/Makefile
> +++ b/templates/Makefile
> @@ -5,6 +5,7 @@ ifndef V
>   endif
>
>   INSTALL ?= install
> +INSTALLDIR ?= $(INSTALL) -d
>   TAR ?= tar
>   RM ?= rm -f
>   prefix ?= $(HOME)


-- 
_______________________________________________Norbert Nemec
   Lilienstr. 5a ... 12203 Berlin-Lichterfelde ... Germany
       Tel: +49-30-5483 3143 Mobile: +49-176-5502 5643
           eMail:<Norbert@Nemec-online.de>
