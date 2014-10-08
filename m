From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/14] Makefile: introduce CROSS_COMPILE variable
Date: Wed, 08 Oct 2014 12:25:56 -0700
Message-ID: <xmqqvbnu8it7.fsf@gitster.dls.corp.google.com>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
	<1412791267-13356-11-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,  msysGit <msysgit@googlegroups.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBCG77UMM3EJRBRU722QQKGQET5VWWXA@googlegroups.com Wed Oct 08 21:26:01 2014
Return-path: <msysgit+bncBCG77UMM3EJRBRU722QQKGQET5VWWXA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f188.google.com ([209.85.220.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBRU722QQKGQET5VWWXA@googlegroups.com>)
	id 1Xbws3-0002En-Oz
	for gcvm-msysgit@m.gmane.org; Wed, 08 Oct 2014 21:25:59 +0200
Received: by mail-vc0-f188.google.com with SMTP id le20sf1526899vcb.5
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 12:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=2Q2aSrYWFbsYkP8BST1x5R3Sul2iwZ3Z004y1s2Hgb0=;
        b=MWMXPNjioyyvSs8UILDihlE9dWs1XY8RzqazBI0GIL8KcHTXN49TXf8T3ex6kXw9tJ
         LKZP/a+N6gPfPv+7h3yEfpVyhcmYHTj9aECd94hKxm9FzXhRbV/SRFo8qNGHc13zg1G4
         Fm8Dl5pVpM+OD6jWywF4VuVqDFUk5Lcnfpwb/xmoOO+F21pY+ED20LAYjT1JkweJ5+fN
         T9ZPviBU0eqEOJzh+jjUjX1SREJ0rpbGqN/5H0mQ47rizRuaRmz1PWD5Gte3vzD1zWHb
         Mt2qs2sC4oXolPB+OREbq9GlCFt9rWf4Q8U0kleTJD4Mzp+0Vf4ySmkQd8iWg7eV9GeR
         b7Lg==
X-Received: by 10.50.122.2 with SMTP id lo2mr188144igb.4.1412796358974;
        Wed, 08 Oct 2014 12:25:58 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.120.72 with SMTP id la8ls600486igb.13.gmail; Wed, 08 Oct
 2014 12:25:58 -0700 (PDT)
X-Received: by 10.66.222.100 with SMTP id ql4mr8232436pac.32.1412796358425;
        Wed, 08 Oct 2014 12:25:58 -0700 (PDT)
Received: from sasl.smtp.pobox.com (pb-smtp1.int.icgroup.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id fl6si393510qcb.0.2014.10.08.12.25.58
        for <msysgit@googlegroups.com>;
        Wed, 08 Oct 2014 12:25:58 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CECE14818;
	Wed,  8 Oct 2014 15:25:58 -0400 (EDT)
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 23AAF14817;
	Wed,  8 Oct 2014 15:25:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8CCDA14816;
	Wed,  8 Oct 2014 15:25:57 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EDD84EA4-4F20-11E4-99B7-855A93717476-77302942!pb-smtp1.pobox.com
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

> To ease cross-compilation process, introduce a single variable
> with the prefix to all compiler-related executables.
>
> Define CROSS_COMPILE=foo- if your compiler and binary utilities
> are foo-cc, foo-ar, foo-strip, etc.  More specific variables
> override this, so if you set CC=gcc CROSS_COMPILE=ia64-linux-gnu-
> then the compiler will be 'gcc', not 'ia64-linux-gnu-gcc'.
>
> Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
> ---
>  Makefile         | 19 +++++++++++++------
>  config.mak.uname |  2 +-
>  2 files changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index f34a2d4..c412996 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -339,6 +339,11 @@ all::
>  # return NULL when it receives a bogus time_t.
>  #
>  # Define HAVE_CLOCK_GETTIME if your platform has clock_gettime in librt.
> +#
> +# Define CROSS_COMPILE=foo- if your compiler and binary utilities
> +# are foo-cc, foo-ar, foo-strip, etc.  More specific variables
> +# override this, so if you set CC=gcc CROSS_COMPILE=ia64-linux-gnu-
> +# then the compiler will be 'gcc', not 'ia64-linux-gnu-gcc'.

I think you forgot the "default to empty", i.e.

CROSS_COMPILE =

somewhere to prevent stray an environment variable from affecting
the build (which you did correctly for RCFLAGS).

>  GIT-VERSION-FILE: FORCE
>  	@$(SHELL_PATH) ./GIT-VERSION-GEN
> @@ -350,7 +355,6 @@ CFLAGS = -g -O2 -Wall
>  LDFLAGS =
>  ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
>  ALL_LDFLAGS = $(LDFLAGS)
> -STRIP ?= strip
>  
>  # Among the variables below, these:
>  #   gitexecdir
> @@ -390,8 +394,12 @@ htmldir_relative = $(patsubst $(prefix)/%,%,$(htmldir))
>  
>  export prefix bindir sharedir sysconfdir gitwebdir localedir
>  
> -CC = cc
> -AR = ar
> +AR = $(CROSS_COMPILE)ar
> +CC = $(CROSS_COMPILE)cc
> +GCOV = $(CROSS_COMPILE)gcov
> +RC = $(CROSS_COMPILE)windres
> +STRIP = $(CROSS_COMPILE)strip
> +
>  RM = rm -f
>  DIFF = diff
>  TAR = tar
> @@ -404,13 +412,12 @@ XGETTEXT = xgettext
>  MSGFMT = msgfmt
>  PTHREAD_LIBS = -lpthread
>  PTHREAD_CFLAGS =
> -GCOV = gcov
>  
>  export TCL_PATH TCLTK_PATH
>  
>  SPARSE_FLAGS =
>  
> -
> +RCFLAGS =
>  
>  ### --- END CONFIGURATION SECTION ---
>  
> @@ -1669,7 +1676,7 @@ $(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
>  	mv $@+ $@
>  
>  git.res: git.rc GIT-VERSION-FILE
> -	$(QUIET_RC)$(RC) \
> +	$(QUIET_RC)$(RC) $(RCFLAGS) \
>  	  $(join -DMAJOR= -DMINOR=, $(wordlist 1,2,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
>  	  -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" $< -o $@
>  
> diff --git a/config.mak.uname b/config.mak.uname
> index f79c0e0..9f7037e 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -523,7 +523,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>  	EXTLIBS += -lws2_32
>  	GITLIBS += git.res
>  	PTHREAD_LIBS =
> -	RC = windres -O coff
> +	RCFLAGS += -O coff
>  	NATIVE_CRLF = YesPlease
>  	X = .exe
>  	SPARSE_FLAGS = -Wno-one-bit-signed-bitfield
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
