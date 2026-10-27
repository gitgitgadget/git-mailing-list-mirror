Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793126304;
	b=HUXhsCaaKZBekBLoeiHpPyUqD3zsMeaoChhfUAaxw9n5ZzMDrdht2e+0XYS8eV12vKu8
	 AIhZVNH6OPfzOtq1eaRlpxrUIxVzLnH1evV78ei8jg/Nbo4ElhkcNL09C85FMR33VdOts
	 vxmTa6MI2XElex4FZTrMTzbXOiJP4Gu9/jh/N/YuQbFzVrSDph1Gv9z1R2OE2/VGB/LnQ
	 UBtsYo6wVf/35l7YF8w1soAalcaPlGZ+ELbPI7P1EZZiI2exV8WHGFPKqDygw3lcFxjyx
	 NmLSnoNZY7gVeV8HOCMyRz3L/+vzBTd2YpF+a3FwDKjzwpV+lXDgxT+Ms3thehEFBeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793126304;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=FQs3hDl+N0svbtji+ORBAysEPem46sYb2N7wHo5IR84=;
	b=WMKce9nME7sYD/E/Oxse4kQ9G4DvjM42h3XoV9RTuHNKjd6/CMYmfHO1C94CLNj9nM6g
	 fPbXZKJyu0sXWGbHX3G86s9z9PSFVlouIq5FfBvs/BliQNBY1cWiyP47Rbm6zKJuib+43
	 Rl9qCbqWrOrH0KoEnmKg8H6QQW+5FWl4iJG3YXm+U70B+n0vZ94pNcLc/uzsdxz9zgQ83
	 EFwTFrX/zeq9kTezxBaXOdmmNCBL3IixImrq7Dc4Yhzd5hUsz+9O5TykLpkayPu2ue9CO
	 L+RScDdFQgGd4jp6mDwBq0t5nyFNNnLxqS0ojfiM7SG9Tvis3ITmKoE5mTZHk7eN9EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=mP8r0yFa;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=I9vMwjZM;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B5B606A31F
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 18:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7B5B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=mP8r0yFa;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=I9vMwjZM
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 3516C1D0011A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 14:38:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 27 Oct 2026 14:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793126302; x=1793212702; bh=FQs3hDl+N0
	svbtji+ORBAysEPem46sYb2N7wHo5IR84=; b=mP8r0yFapFhiPKjasm4SQlQpQP
	EVyi1Rd1cl8NmxKqBJxfLJhBpqP3boqhRRTOJ3S5cpbFJ/5+hSgCZl6FB967+z1/
	f4MqlGEXWI+Gh3tcPX/Hs8l2aWTHfUirh1Yw2L3XczmpT1bfPokqqX+g0DheMWPu
	SalXU5BWgRS7kTJq7bl9pFedrM93ROwpdWllxxxQ5GUpRrkEAhlkj8Z8pX1x2FCA
	6NEqU5HcK4svoMLa6a2VgHs5vJIs76LB/E6DRpCEE3LRxX8ysaII6PyPjeUVz6/x
	IwrAs+D0OvLsAyiBISO7gprjbo95XPEJQqKFV3Ul2iEKgeNBnBcPogiPy8Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793126302; x=1793212702; bh=FQs3hDl+N0svbtji+ORBAysEPem46sYb2N7
	wHo5IR84=; b=I9vMwjZMkGCVlKPnV90CTwTQJ3C/LjktY9QfCYjHzyE+XsKbW6W
	YAhWHwjgmD07jlGWYZOr0rB9B27vWAurpCdlTqDjUc3X0VSYwLORoC5CZayWLdVp
	jNSHnlXarGmkEoHr+bg5pKoSII/QqaOfIxzPkK8rPONZAsSqCGEWB6R5NxB2IzG1
	LpTk950ptLVx6CIh5mHS1I+oTbjGPYdr7PnrMB7C3plTy9msDUMxjDk7Pin9vlb/
	JrI9AXlvnEer8FT73gFwp5s4aw68FInQUMSLV7J/J8cDcWtvnq7VMLLpl8/eBcq4
	djVv/q/VADAhb5dlzMiVVJa3Zdd+gy48Lqw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793126302; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Rj68iGo8qYrIvfZvIaesEjCEtJUbYjgqt+h6C1yPyQKUxmO
	K02YFx5HOUb5yeXAin/YJVMwMtocflku3BzCCIsBFhMZWdKd8w5mbV3zAlP8MlZ3
	JRl353155LRgPANPSfZxi9OwYBHXHu/XDpiGt7txTfkx+1gznv8+GEoCODCg4HLw
	vgQYsqMmFIE/ovC8qidX0vb4vFQhMwXYntsZ5T8HtGzkNnJId0gxb2RBWp73HfVp
	dJMwhC+WFmPWtHrHMD7WfyhdXtBG9tP9OJ5Znb9lW4419K1+yELx3EPrJjk8IdT+
	S4CNutEoVG2boiwgF7RLSwoVxAL6PKkj/4626aQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ePzD6RcTctfEinRdRYsZGHWGq544HN61s6Mbyuq3q4Q=:0Z5y5SQw8Z9bZNORbD8Zm0JoQ+tZNuWUPKNrSnY6Af4=;
X-ME-Sender: <xms:nu_gauTRJ1QxiwZ71FISV22WG4L0IpU9K2MlZXT8A9ZxTKGYLWd_oQ>
    <xme:nu_gai0xIGBnl93TPM2YCJW5lGMchfNsHjBhzBfzWcoN4gwBkv6NkbbtdCdN-PO2Q
    oo6EMHESGe6cdzfiTMHUlHbTRWyKzfG-EBVe7EPD-B8fPrTwAVcrw>
X-ME-Received: <xmr:nu_gaiAc7MhZDStUkrESSJKDL1x-6S4zUSJnXNWGAS6_P819F5hAhnC9TiXmGf3Dg8MsnE_So8-CbOm7mnxxDYy5X1mCQGZ6noBq>
X-ME-Proxy-Cause: dmFkZTGx5oCJwBcPzxlWmBqJLby8UiwoRBELk5G7PslCAahHaGIO6/FtZ3LaI4NIs+lc3d
    yO9hZkFylA4KmY7K20StTFCb63be1typRNzPY4bEoZwVAicCXn+X3zfudoXvLiXolGyMcx
    Z0ACc/sj9lf9L7yQVnLd+vBECGjCSh9XYC36e7TdC2XXgCfZuO7AaNPX1e0y5r/87/M1jL
    a5BQmU05wbhJzizxZCezcAp8vNoxgT4Ue4MZPi1Ok2CZGH7vXPKlCV7YPH1X3zt+1A1drX
    Xw2BBCoRzBJ1Y2IxqwsKeiLR97zTKmVGVSpdbOtveTZMiuucbEY3d4dakh9j9sKKZ3PgcS
    woAa8865fBElSxxpllTydQOhAfvfdbGJ/h0Q7uefmwxDJEohV3Qce/0jD8GYqvifyEjYjq
    awvThaKhwM5uFIYIS6fRUQqh5PxWdm7B07RcnpvVmF1/TpD4Uq0JPUScftIN/BCzwAHspy
    2QsUus2wtVkm8o0kUtSj3sY7Iuuk9JymGGNva5qmXnfETaX8Fy2LGr7gPrVr1zxH97XOCN
    Pv0cAB8ErGgvxp7zDKrdB/y0uisu/VCuA4f73Yeex9WLEzKEFXbF8sjcUoLH1hvgoFo8m6
    HiM9QEVHwq8eBmLmtdaBk+hDgWoEpokid3cqnY176igVUtAoVry4aqcJevNQ
X-ME-Proxy: <xmx:nu_gamjXNdC0s2ZDSC-Zez8thYiiIkNoShdqaxuuTMb1uupmrEiaxQ>
    <xmx:nu_gasO1kvLpYtfZ5gE6yExVJVzUw5Gk6cOsH6x9HHQTWC9Kelm2Ag>
    <xmx:nu_gau-TQKLpuuIysjdKg5csipz54SyM4LHrI7uIrolhFmzlAqBOZw>
    <xmx:nu_galcHfz9ay3FcubDtHJwukvC6vKPt1b8UXNZPiwSI5AMagpf8HQ>
    <xmx:nu_gapTg0aN9wmG7b1qZL3phpLsP3lbiAVLXp08vYL4CJC1-yum2kzUp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 14:38:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Shashank S via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
  Christian Couder <christian.couder@gmail.com>,  Siddharth Asthana
 <siddharthasthana31@gmail.com>,  Usman Akinyemi
 <usmanakinyemi202@gmail.com>,  Shashank S <shashu8660@gmail.com>
Subject: Re: [PATCH] test-chmtime: use parse_options() to parse command-line
 flags
In-Reply-To: <pull.2280.git.1793099688076.gitgitgadget@gmail.com> (Shashank
	S. via GitGitGadget's message of "Tue, 27 Oct 2026 11:14:48 +0000")
References: <pull.2280.git.1793099688076.gitgitgadget@gmail.com>
Date: Tue, 27 Oct 2026 11:38:20 -0700
Message-ID: <xmqqzevzj8f7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Shashank S via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Shashank S Mogaveera <shashu8660@gmail.com>
>
> cmd__chmtime() currently parses the '-v'/'--verbose' and '-g'/'--get'
> flags manually using strcmp() checks and manual index tracking.
>
> Refactor cmd__chmtime() to use parse_options() and usage_with_options()
> instead. Pass PARSE_OPT_KEEP_UNKNOWN_OPT so that negative relative time
> offsets (such as '-86400') are not rejected as unknown short options
> and remain in argv for timespec_arg() to parse.

I somehow find the verb "refactor" used to describe a change like
this slightly awkward, but it is excellent to reminder readers why
it is necessary to use PARSE_OPT_KEEP_UNKNOWN_OPT.

>  t/helper/test-chmtime.c | 46 +++++++++++++++++++----------------------
>  1 file changed, 21 insertions(+), 25 deletions(-)
>
> diff --git a/t/helper/test-chmtime.c b/t/helper/test-chmtime.c
> index 0e5538833a..dc6281b1d6 100644
> --- a/t/helper/test-chmtime.c
> +++ b/t/helper/test-chmtime.c
> @@ -38,10 +38,13 @@
>   */
>  #include "test-tool.h"
>  #include "git-compat-util.h"
> +#include "parse-options.h"
>  #include <utime.h>
>  
> -static const char usage_str[] =
> -	"(-v|--verbose|-g|--get) (+|=|=+|=-|-)<seconds> <file>...";
> +static const char * const chmtime_usage[] = {
> +	"test-tool chmtime (-v|--verbose|-g|--get) (+|=|=+|=-|-)<seconds> <file>...",
> +	NULL
> +};

Is it necessary to spell out the options like verbose and get, once
you switch to the parse-options API?  What does "test-tool chmtime -h"
say with this patch applied?  I think it is common to say [<options>]
instead and let the list of options produced by the parse-options API
to take it from there.

>  static int timespec_arg(const char *arg, long int *set_time, int *set_eq)
>  {
> @@ -68,40 +71,37 @@ static int timespec_arg(const char *arg, long int *set_time, int *set_eq)
>  
>  int cmd__chmtime(int argc, const char **argv)
>  {
> -	static int verbose;
> -	static int get;
> +	int verbose = 0;
> +	int get = 0;

There is no reason why these two need to be static, but as a
"main()" function for a run-once-and-exit program, there is no
reason why they should not be static, either.  With this change,
you are forced to explicitly initialize them to 0.

> -	int i = 1;
>  	/* no mtime change by default */
>  	int set_eq = 0;
>  	long int set_time = 0;
>  
> -	if (argc < 3)
> -		goto usage;
>  
> -	if (strcmp(argv[i], "--get") == 0 || strcmp(argv[i], "-g") == 0) {
> -		get = 1;
> -		++i;
> -	} else if (strcmp(argv[i], "--verbose") == 0 || strcmp(argv[i], "-v") == 0) {
> -		verbose = 1;
> -		++i;
> -	}
>  
> -	if (i == argc) {
> -		goto usage;
> -	}
>  
>  	if (timespec_arg(argv[i], &set_time, &set_eq)) {
>  		++i;
>  	} else {
>  		if (get == 0 && verbose == 0) {
>  			fprintf(stderr, "Not a base-10 integer: %s\n", argv[i] + 1);
> -			goto usage;
>  		}
>  	}
>  
>  	if (i == argc)
> -		goto usage;
>  
>  	for (; i < argc; i++) {
>  		struct stat sb;

I agree that the original was horrible in that it did not allow -v
to come before -g etc.

Now, let's read the updated code.

> +	int i = 0;

>  	/* no mtime change by default */
>  	int set_eq = 0;
>  	long int set_time = 0;
>  
> +	struct option options[] = {
> +		OPT_BOOL('v', "verbose", &verbose, "print the mtime and the file name"),
> +		OPT_BOOL('g', "get", &get, "print only the mtime"),
> +		OPT_END()
> +	};
>  
> +	argc = parse_options(argc, argv, NULL, options, chmtime_usage,
> +			     PARSE_OPT_KEEP_UNKNOWN_OPT);
>  
> +	if (argc < 1 || (!get && !verbose && argc < 2))
> +		usage_with_options(chmtime_usage, options);

I am not sure what is going on here.  The command, when parsing out
the -g and -v options, expects to have <seconds> and 1 or more
<file> arguments.  Why should it reject argc==2 when neither -g nor
-v is given, but allow argc==2 when -g and/or -v is?

OK, the usage of this command is a bit opaque.  The command works in
two ways.

 * When -v/-g is given, it is a request to show the timestamp of the
   file, so <seconds> becomes optional (i.e., when given, it sets
   and then shows).  We still want at least one <file>.

 * Otherwise, it is a request to set the timestamp, so <seconds> is
   required, and we want at least one <file>.

Not the best way to design an end-user UI, but this is merely a test
helper, so let's not complain too much ;-).

>  	if (timespec_arg(argv[i], &set_time, &set_eq)) {
>  		++i;
>  	} else {
>  		if (get == 0 && verbose == 0) {
>  			fprintf(stderr, "Not a base-10 integer: %s\n", argv[i] + 1);
> +			usage_with_options(chmtime_usage, options);
>  		}
>  	}

This is largely the fault of the original, but I wonder if we can
avoid the "without -v/-g, timespec is required" logic in two
separate places like this (and the earlier one that puzzled me)?


>  	if (i == argc)
> +		usage_with_options(chmtime_usage, options);

And we want at least one <file> in any case.

>  	for (; i < argc; i++) {
>  		struct stat sb;

OK.  We will iterate over the <file> arguments given.

> @@ -110,7 +110,7 @@ int cmd__chmtime(int argc, const char **argv)
>  
>  		if (stat(argv[i], &sb) < 0) {
>  			fprintf(stderr, "Failed to stat %s: %s. Skipping\n",
> -			        argv[i], strerror(errno));
> +				argv[i], strerror(errno));
>  			continue;
>  		}

This fixes a whitespace breakage, which is an unrelated change, but
I'll let it pass.

> @@ -150,14 +150,10 @@ int cmd__chmtime(int argc, const char **argv)
>  			}
>  #endif
>  			fprintf(stderr, "Failed to modify time on %s: %s\n",
> -			        argv[i], strerror(errno));
> +				argv[i], strerror(errno));
>  			return 1;
>  		}
>  	}

Likewise.

>  
>  	return 0;
> -
> -usage:
> -	fprintf(stderr, "usage: %s %s\n", argv[0], usage_str);
> -	return 1;
>  }

We exit via usage_with_options() with 129 now, but used to exit(1)
upon a command line error.

Looking good.  Thanks.
