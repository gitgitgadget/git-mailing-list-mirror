From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/14] Fix BASIC_LDFLAGS and COMPAT_CFLAGS for
 64bit MinGW-w64
Date: Wed, 08 Oct 2014 12:24:13 -0700
Message-ID: <xmqqa9569xgi.fsf@gitster.dls.corp.google.com>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
	<1412791267-13356-8-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,  msysGit <msysgit@googlegroups.com>,  Ray Donnelly <mingw.android@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBCG77UMM3EJRBYE622QQKGQEKYK4B3Q@googlegroups.com Wed Oct 08 21:24:21 2014
Return-path: <msysgit+bncBCG77UMM3EJRBYE622QQKGQEKYK4B3Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f189.google.com ([209.85.216.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBYE622QQKGQEKYK4B3Q@googlegroups.com>)
	id 1XbwqP-0001RU-Lz
	for gcvm-msysgit@m.gmane.org; Wed, 08 Oct 2014 21:24:17 +0200
Received: by mail-qc0-f189.google.com with SMTP id x3sf1528094qcv.26
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 12:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=kL1jDJltFqhKO0Y08Ja3qBMJRjjSC5yAO84NxjyH6rg=;
        b=Ey2Irf5bSwhkqFdFokOtwZtlfnhTu1ZwNGOAFQop1OoImijj1ot9mheJzJFc3MWmFG
         RpAFeGCgtX/H8VXPM/a1W5n21jz0TPJRDEDQF1tVNFpVWhlZrlpaQhsElVK6eDg+j33B
         3ws1k+2gWQczzLPD2DZAfIm4+cPKG+vvrnBBKHS6yfKDAHzCoqkErrznuSg67GSIv3ru
         nK2u6/1XqRTUIf4PQiIO2WVM57fGJcXg0e5gsx6s51Td2tGVYzlou3lATBzqhN2tR9Ax
         PIBNPNb93L1c5pvrB91INiqyNI8bBXqFespbLK5u+ojcfhbV0/i15ogVaH9/ndWky1wO
         TCdg==
X-Received: by 10.140.19.173 with SMTP id 42mr34828qgh.32.1412796256803;
        Wed, 08 Oct 2014 12:24:16 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.34.72 with SMTP id k66ls3143847qgk.78.gmail; Wed, 08 Oct
 2014 12:24:16 -0700 (PDT)
X-Received: by 10.236.63.197 with SMTP id a45mr8835961yhd.9.1412796256280;
        Wed, 08 Oct 2014 12:24:16 -0700 (PDT)
Received: from sasl.smtp.pobox.com (pb-smtp1.int.icgroup.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id w5si19035igz.3.2014.10.08.12.24.16
        for <msysgit@googlegroups.com>;
        Wed, 08 Oct 2014 12:24:16 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 350611479B;
	Wed,  8 Oct 2014 15:24:15 -0400 (EDT)
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CDB41479A;
	Wed,  8 Oct 2014 15:24:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A9C2F14798;
	Wed,  8 Oct 2014 15:24:14 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B08597A0-4F20-11E4-9F19-855A93717476-77302942!pb-smtp1.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>

Marat Radchenko <marat@slonopotamus.org> writes:

> Subject: Re: [PATCH 07/14] Fix BASIC_LDFLAGS and COMPAT_CFLAGS for 64bit MinGW-w64

Please prefix with MinGW: like you did for other changes.

> From: Ray Donnelly <mingw.android@gmail.com>

Needs a bit of explanation what breaks without this change.  I can
see that unconditional use of USE_32BIT_TIME_T probably goes against
a 64-bit platform by looking at the change, but "Fix Blah" is never
informative enough to justify any change in the log message.  We
want to be able to read "Fix Blah *how*/*why*" in our "git log" (and
prefereably in "git shortlog").

Thanks.

> Signed-off-by: Ray Donnelly <mingw.android@gmail.com>
> Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
> ---
>  config.mak.uname | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index 324a7fc..4470a928 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -6,6 +6,7 @@ uname_O := $(shell sh -c 'uname -o 2>/dev/null || echo not')
>  uname_R := $(shell sh -c 'uname -r 2>/dev/null || echo not')
>  uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
>  uname_V := $(shell sh -c 'uname -v 2>/dev/null || echo not')
> +CC_MACH := $(shell sh -c '$(CC) -dumpmachine 2>/dev/null || echo not')
>  
>  ifdef MSVC
>  	# avoid the MingW and Cygwin configuration sections
> @@ -509,12 +510,15 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>  	NO_POSIX_GOODIES = UnfortunatelyYes
>  	DEFAULT_HELP_FORMAT = html
>  	NO_D_INO_IN_DIRENT = YesPlease
> -	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
> +	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/win32
> +	ifneq (,$(findstring i686,$(CC_MACH)))
> +		COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
> +		BASIC_LDFLAGS += -Wl,--large-address-aware
> +	endif
>  	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
>  	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
>  		compat/win32/pthread.o compat/win32/syslog.o \
>  		compat/win32/dirent.o
> -	BASIC_LDFLAGS += -Wl,--large-address-aware
>  	EXTLIBS += -lws2_32
>  	GITLIBS += git.res
>  	PTHREAD_LIBS =
> -- 
> 2.1.1
>
> -- 

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
