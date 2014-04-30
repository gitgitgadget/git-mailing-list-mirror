From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Makefile: do not depend on curl-config
Date: Wed, 30 Apr 2014 08:27:24 -0700
Message-ID: <xmqqfvkuhm77.fsf@gitster.dls.corp.google.com>
References: <1398702545-9860-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,  patthoyts@gmail.com,  marat@slonopotamus.org,  tuomas.silvola@knowit.fi,  msysgit@googlegroups.com,  johannes.schindelin@gmx.de
To: Erik Faye-Lund <kusmabite@gmail.com>, Dave Borowitz <dborowitz@google.com>
X-From: msysgit+bncBCG77UMM3EJRBY5MQSNQKGQEUBWKYFQ@googlegroups.com Wed Apr 30 17:27:35 2014
Return-path: <msysgit+bncBCG77UMM3EJRBY5MQSNQKGQEUBWKYFQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ve0-f183.google.com ([209.85.128.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBY5MQSNQKGQEUBWKYFQ@googlegroups.com>)
	id 1WfWQ1-0007BS-R3
	for gcvm-msysgit@m.gmane.org; Wed, 30 Apr 2014 17:27:34 +0200
Received: by mail-ve0-f183.google.com with SMTP id oz11sf425285veb.10
        for <gcvm-msysgit@m.gmane.org>; Wed, 30 Apr 2014 08:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=y3VwFPKOiSV+ml0CyeXjXWEpeBO+v3nVbnuD/BzZIT0=;
        b=vP75t9ytA93Sx6HINadHu/8NivZP8r0Y/rXI1DJ4+CLtW2rWfKHYDivL14ltWojm+0
         cP9eeV2cyJ2a9cn8FAlwUM1VPJUXBuUJilx3RhW8sUPGEkW+p3EIfV7BKtdZHoxfOwpM
         i3iGG2Lf9mM6xh1ZurFolb02seEFWc6QR4WazldQsswY8gBsjo9RVgqJtnjsDBd/ycJW
         krSoNSD+/m49UkJQLooT45n7/ytaJpXDOsXo1i2It/j0qAiTfYw9hO91OO/OY5vA13WE
         Ik8B6HT8dMVGgOA7dYMGZpJggpmJXAzsb0oxGaOzBn0/QoFvDdc9BzfV3lapAIa+3Oap
         Z2wQ==
X-Received: by 10.50.39.3 with SMTP id l3mr124584igk.3.1398871652408;
        Wed, 30 Apr 2014 08:27:32 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.138.194 with SMTP id qs2ls2811302igb.37.canary; Wed, 30 Apr
 2014 08:27:30 -0700 (PDT)
X-Received: by 10.42.87.140 with SMTP id y12mr2183929icl.31.1398871650595;
        Wed, 30 Apr 2014 08:27:30 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id n7si3661389qcz.2.2014.04.30.08.27.30
        for <msysgit@googlegroups.com>;
        Wed, 30 Apr 2014 08:27:30 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C0737F7FC;
	Wed, 30 Apr 2014 11:27:30 -0400 (EDT)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D65357F7FB;
	Wed, 30 Apr 2014 11:27:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E837A7F7F7;
	Wed, 30 Apr 2014 11:27:26 -0400 (EDT)
In-Reply-To: <1398702545-9860-1-git-send-email-kusmabite@gmail.com> (Erik
	Faye-Lund's message of "Mon, 28 Apr 2014 18:29:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EF9F6C32-D07B-11E3-A8FD-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
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
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247720>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> MinGW builds of cURL does not ship with curl-config unless built
> with the autoconf based build system, which is not the practice
> recommended by the documentation. MsysGit has had issues with
> binaries of that sort, so it has switched away from autoconf-based
> cURL-builds.
>
> Unfortunately, broke pushing over WebDAV on Windows, because
> http-push.c depends on cURL's multi-threaded API, which we could
> not determine the presence of any more.
>
> Since troublesome curl-versions are ancient, and not even present
> in RedHat 5, let's just assume cURL is capable instead of doing a
> non-robust check.
>
> Instead, add a check for curl_multi_init to our configure-script,
> for those on ancient system. They probably already need to do the
> configure-dance anyway.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
>
> OK, here's a proper patch. I've even tested it! ;)
>
>
>  Makefile     |  8 +++-----
>  configure.ac | 11 +++++++++++
>  2 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index e90f57e..f6b5847 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1133,13 +1133,11 @@ else
>  	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
>  	PROGRAM_OBJS += http-fetch.o
>  	PROGRAMS += $(REMOTE_CURL_NAMES)
> -	curl_check := $(shell (echo 070908; curl-config --vernum) 2>/dev/null | sort -r | sed -ne 2p)
> -	ifeq "$(curl_check)" "070908"
> -		ifndef NO_EXPAT
> +	ifndef NO_EXPAT
> +		ifndef NO_CURL_MULTI
>  			PROGRAM_OBJS += http-push.o
>  		endif

Dave's "ask curl-config about proper compilation options if
available" and this change does *not* semantically conflict, as the
former should stress "if available" part (but note that the key word
is "should").

How old/battle tested is this change?  My inclination at this point
is to revert the merge of Dave's series from 2.0 (yes, I know we
have been looking at fixing it and I _think_ the issue of unpleasant
error message you reported can be fixed, but at this rate we would
not know if we eradicated all the issues for platforms and distros
with confidence by the final), kick it back to 'next'/'pu', and
queue this change also in 'next'/'pu' and cook them so that we can
merge them early in the 2.1 cycle.

This new makefile variable needs a comment at the top, no?

 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index f7d33da..3164b62 100644
--- a/Makefile
+++ b/Makefile
@@ -34,6 +34,10 @@ all::
 # git-http-push are not built, and you cannot use http:// and https://
 # transports (neither smart nor dumb).
 #
+# Define NO_CURL_MULTI if your libcurl is sufficiently old and lacks
+# curl_multi_init ("git http-push" to run the deprecated dumb push over
+# http/webdab will not be built).
+#
 # Define CURL_CONFIG to the path to a curl-config binary other than the
 # default 'curl-config'.  If CURL_CONFIG is unset or points to a binary that
 # is not found, defaults to the CURLDIR behavior.

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
