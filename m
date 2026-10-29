Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793253168;
	b=0PB95vxJwhmnRQMrRpveZE1uYiAhSNO8d/c8aAGFdL7qoVdo3g1IaXnZNYR790J94Y0s
	 XAqx70nQcra5KoAf8fKNDeNvTgM2FeLVsWJOJ31/1UazAvOWESY2f1dIoBrz1Dt1W8osy
	 N6bISKse19d4nEf052+CnY413gFWIifakr2eh5G/MKTl3nWfJhJDc9WYKwNSTH78RFZ7I
	 5DXeuigPcUc87eMO5qfxdzHpwNrJX4gmiNchIBqKBEWK4u0kVfWtWN7RxJ3FjTLXXp8bw
	 gucxUudQxRYg/GyDQnEDQbwWRa1dZIqZBOhwg0kh5mcclKafVuzF4SqwaYv987Bs5ug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793253168;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=L66vZuGRx6pPPexmAvCTP52tqRLfdcBsY/Zxls4w9yQ=;
	b=q+FDlK5U68aeSnXW2GJ2SfTk/ppNmdjPJNhLHXqDV2Ss1ixwQw2YUVI4by7zqL/VFmQa
	 /FIa4NWrmB74YxmNwNLpdVXBVp8BBKSlp9UYFDqkiEyjD0Ovq9wtNeFKliQSczhmuenik
	 DZgIPo5bZAt20COQNH057nSwNdqioL3MToAcLEes269iimsxaxZyy8gp2tOWkupGXSciT
	 xa7UUJeJlfW3B75o2ad9S0Oshq1jiQZxa5xZFljIMKUUptUmVGXV13rZ+BSsbdrFFH4UO
	 qr6bUx+iGibwlc8J1XVHghNH8zXK9hrauSTpw2jYcRgjhAQEdxCM5AGeBR8j9dNy1Ng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n6xywctK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8EE606A33C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 05:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE8EE606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n6xywctK
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7cb6dc850c7so569141137.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 22:52:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793253167; cv=none;
        d=google.com; s=arc-20260327;
        b=NwyrUhxEtJynYC4bgxe439Nj/8Yv4oFDAbXWA1zXeI+2QVcuBByw8CJjliFA2DPLEk
         5+AajFaDbYTY52SZlZt/FeyUGRyRwbuHr8Coem0t+bXfozyZNTqebq4LzggLSX7bsYUv
         42f/0rpklMaMzLlkJkUUazXXItX/7Y3aRIv9nJXKaDsrrv3EUi+nzNUAc0TWjexCEUfW
         epYN5PKv2rdjdVbLlIGR+60n6nb1T7nQe/9M0LLEK+9ZJaAM662WHTqqTkdk+7RzqVFz
         uoiZP00pRDS50IWqjSdb5qiIFIoG7P3Ek++6WZGmZlZnglcZeBWw1WYatEt4FTipQPue
         LMJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L66vZuGRx6pPPexmAvCTP52tqRLfdcBsY/Zxls4w9yQ=;
        fh=seSHNth4cqs44JqgUVc9d6HiuUxwB5UoKEh0HXhB454=;
        b=Z4XL7/s0clac3wwxB/ccKK6K7SO2JIL68R31cBU8bxuzCLFWr94eX2muwRWXwgLyeB
         58WAMXUGYI1LYnbV4NuUTRfva7Pz0DDlys7h9nqEuauIbV5PqJIvColAtVTEYPeliw/S
         x1/HSkGUvp+MLAdYW/3vRWV8NKG6QBeAsRAuyG1lza843HUSleFaBwHqPyED36wbXUde
         Dg4gG34pybyg1PXvGqlAY1dKvlwdBtyQjb2Supeyg6HGTCFmOUD3s3enH5IAGxDiaOOD
         1c4jET4f/Sydf9iSAoxoF91oXhKX4fp3Ged0YlOSwaFS5JNPZbc9BXTyXtLLCmVDYykx
         E/BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793253167; x=1793857967; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L66vZuGRx6pPPexmAvCTP52tqRLfdcBsY/Zxls4w9yQ=;
        b=n6xywctKJQ5dkkLuvUxRMoaYFGFHvGDcqDcptkK7uym6yrzv1qNfuy2xj7V6qQQUaT
         FtyZ6L5pEIvRjyZp4lwGDbdyRHhpoBICYqbjz5fQ/dSfwYdyqXfshFtHvgOxtEnxZyej
         g2STBmUvORtEsr5z5HMoRcyMpXc6wEhX4jEMKPrWtEI0d4SqIT1QdEttFY261usCqD+N
         MGCO4dHm2qaH7QndSHNYpMGmFE0uNcgkB2l9u4/P8N+6R01IES51Uw7KwjlWxcBDwEnE
         hkFmzO0cicb+Ns+lZk/lvuvgHLH7RXeaxbJSbSHXB3Ttnac2lVFzJi7r2+jcCDS8y0OJ
         A24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793253167; x=1793857967;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L66vZuGRx6pPPexmAvCTP52tqRLfdcBsY/Zxls4w9yQ=;
        b=zQn+0GaG6lmgovdVJ4kbG3wrILPewRq7atbaODx5cIYWl37XNizWwUH7Ec70oS5Suf
         4neFGe86VNccYp925woS5n88sjp/nIyeMXjtJxdKTNv5pZYaqBjRf5fHJv8/kdwHLnQj
         5SZkATHeNVIKB6mY5T9fHYcPPVVev8VqeSwsYL30DmHegKKW+vd5YDmsNbbNuWxmYitM
         L2djt/Hxs0YDynWFoqm2FXuY5bYrNl8agk7Dkkxc1qoEcZMg5khf7TsLsN99lYY5hr0A
         TUWzIGRL5EBj4e1Lphx+weBZdNg+yM3re0RzTl756jqXNRh+VYC5AGjApMzkPziYe8zg
         M+ww==
X-Forwarded-Encrypted: i=1; AKwUvByFYteYbY8a/BW3Dp1aLnTqvo5VWbmmcsICeU/i1ZfM3bvdY22ciOI3sa1Cp67MEepzVCI=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5R0EyE59dv53SeLljoDrvlVoJwXKhIPwqE7j55iUEoTwZT9Jz
	Z6IehJ1/dFpdMsvGQgOwfLJpAnNnZJt5o//6YQrDudngAXVzIU6RGhUI1XLhFPjzJs5QQ0Zb6NF
	5ytKFRB4W+tFlOHczq38IabqN4bula3w=
X-Gm-Gg: AYBFou3AXwwebg4sCKxBdn8TqNlx/QbJGs3bCUxLJ2TmlAKgfmKJX+Wq8DRAwiZsRqb
	p/ikk4gS4FscAJxy4cZXbfsDC0A+2KNn/0Ls/5ComwuK7coNKv/8+25DDwuipb3F+3qAn/OZ0Rw
	6E3Lf/ia0OMlHu95+RMbsZLeMsSZjJTSvK7uG2ccnzMcXKFHBGLaxtPN0b7X8SffYXsXcnLPqS3
	PwMyzzgAXVV/IUAh1dj9gaoROExqs3396haJuXAowceEP7r5wKWI/TZdkipdBWYgIkXYBw8MwiQ
	nJ6TjTc7eKCHIr562C5JcH9HYGnKMDfTnXdSSF+4S5rv2IOcWHNgh85fAm14IV5ohZYyR8qthOw
	Gf4sXf8ShbRdFsHTWorJbSYmxCojk7Iod4k4fJh/+e8FA7Q7EXVgPvtDT1hjDA74QAdAu+j2Wzu
	KeW1rpmxW1a8W9a8mX9UH8hlXn
X-Received: by 2002:a05:6102:dc9:b0:7cc:1d0b:6d33 with SMTP id
 ada2fe7eead31-7d03a5eb01fmr1972763137.26.1793253166661; Wed, 28 Oct 2026
 22:52:46 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2280.git.1793099688076.gitgitgadget@gmail.com> <xmqqzevzj8f7.fsf@gitster.g>
In-Reply-To: <xmqqzevzj8f7.fsf@gitster.g>
From: Shashank S <shashu8660@gmail.com>
Date: Thu, 29 Oct 2026 11:22:35 +0530
X-Gm-Features: AclHuK_B0XZtd--pV7CeNmjI_YvmE3hWVbSCVgo9HUUQSl6oANfo5B0Gc41YoHg
Message-ID: <CANHmUQSEoz=NFH0KV9bNyTz9_gUVPhicUeHdJr2yp1q6iVaDWA@mail.gmail.com>
Subject: Re: [PATCH] test-chmtime: use parse_options() to parse command-line flags
To: Junio C Hamano <gitster@pobox.com>
Cc: Shashank S via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Christian Couder <christian.couder@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Oct 2026 at 00:08, Junio C Hamano <gitster@pobox.com> wrote:

Thank you for the detailed review and for pointing these out!

> > and remain in argv for timespec_arg() to parse.
>
> I somehow find the verb "refactor" used to describe a change like
> this slightly awkward, but it is excellent to reminder readers why
> it is necessary to use PARSE_OPT_KEEP_UNKNOWN_OPT.
>
Understood! In my v2, I will change the commit message to use "update"
instead of "refactor".

> >  t/helper/test-chmtime.c | 46 +++++++++++++++++++----------------------
> >  1 file changed, 21 insertions(+), 25 deletions(-)
> >
> > diff --git a/t/helper/test-chmtime.c b/t/helper/test-chmtime.c
> > index 0e5538833a..dc6281b1d6 100644
> > --- a/t/helper/test-chmtime.c
> > +++ b/t/helper/test-chmtime.c
> > @@ -38,10 +38,13 @@
> >   */
> >  #include "test-tool.h"
> >  #include "git-compat-util.h"
> > +#include "parse-options.h"
> >  #include <utime.h>
> >
> > -static const char usage_str[] =
> > -     "(-v|--verbose|-g|--get) (+|=|=+|=-|-)<seconds> <file>...";
> > +static const char * const chmtime_usage[] = {
> > +     "test-tool chmtime (-v|--verbose|-g|--get) (+|=|=+|=-|-)<seconds> <file>...",
> > +     NULL
> > +};
>
> Is it necessary to spell out the options like verbose and get, once
> you switch to the parse-options API?  What does "test-tool chmtime -h"
> say with this patch applied?  I think it is common to say [<options>]
> instead and let the list of options produced by the parse-options API
> to take it from there.
>
You are completely right. Hardcoding the flags in the string is
redundant now that `parse_options()` handles the `-h` output. I will
update the usage string to `[<options>]` in v2.

> >  static int timespec_arg(const char *arg, long int *set_time, int *set_eq)
> >  {
> > @@ -68,40 +71,37 @@ static int timespec_arg(const char *arg, long int *set_time, int *set_eq)
> >
> >  int cmd__chmtime(int argc, const char **argv)
> >  {
> > -     static int verbose;
> > -     static int get;
> > +     int verbose = 0;
> > +     int get = 0;
>
> There is no reason why these two need to be static, but as a
> "main()" function for a run-once-and-exit program, there is no
> reason why they should not be static, either.  With this change,
> you are forced to explicitly initialize them to 0.
>
That is a great point about the automatic initialization of static
variables. Since it isn't strictly necessary to change them for
`parse_options()` to work, I will revert this specific change in v2 to
keep the diff as small and focused as possible.

> > -     int i = 1;
> >       /* no mtime change by default */
> >       int set_eq = 0;
> >       long int set_time = 0;
> >
> > -     if (argc < 3)
> > -             goto usage;
> >
> > -     if (strcmp(argv[i], "--get") == 0 || strcmp(argv[i], "-g") == 0) {
> > -             get = 1;
> > -             ++i;
> > -     } else if (strcmp(argv[i], "--verbose") == 0 || strcmp(argv[i], "-v") == 0) {
> > -             verbose = 1;
> > -             ++i;
> > -     }
> >
> > -     if (i == argc) {
> > -             goto usage;
> > -     }
> >
> >       if (timespec_arg(argv[i], &set_time, &set_eq)) {
> >               ++i;
> >       } else {
> >               if (get == 0 && verbose == 0) {
> >                       fprintf(stderr, "Not a base-10 integer: %s\n", argv[i] + 1);
> > -                     goto usage;
> >               }
> >       }
> >
> >       if (i == argc)
> > -             goto usage;
> >
> >       for (; i < argc; i++) {
> >               struct stat sb;
>
> I agree that the original was horrible in that it did not allow -v
> to come before -g etc.
>
> Now, let's read the updated code.
>
> > +     int i = 0;
>
> >       /* no mtime change by default */
> >       int set_eq = 0;
> >       long int set_time = 0;
> >
> > +     struct option options[] = {
> > +             OPT_BOOL('v', "verbose", &verbose, "print the mtime and the file name"),
> > +             OPT_BOOL('g', "get", &get, "print only the mtime"),
> > +             OPT_END()
> > +     };
> >
> > +     argc = parse_options(argc, argv, NULL, options, chmtime_usage,
> > +                          PARSE_OPT_KEEP_UNKNOWN_OPT);
> >
> > +     if (argc < 1 || (!get && !verbose && argc < 2))
> > +             usage_with_options(chmtime_usage, options);
>
> I am not sure what is going on here.  The command, when parsing out
> the -g and -v options, expects to have <seconds> and 1 or more
> <file> arguments.  Why should it reject argc==2 when neither -g nor
> -v is given, but allow argc==2 when -g and/or -v is?
>
> OK, the usage of this command is a bit opaque.  The command works in
> two ways.
>
>  * When -v/-g is given, it is a request to show the timestamp of the
>    file, so <seconds> becomes optional (i.e., when given, it sets
>    and then shows).  We still want at least one <file>.
>
>  * Otherwise, it is a request to set the timestamp, so <seconds> is
>    required, and we want at least one <file>.
>
> Not the best way to design an end-user UI, but this is merely a test
> helper, so let's not complain too much ;-).
>
I completely agree, the original logic was very opaque. By removing
the initial `(!get && !verbose && argc < 2)` check, we can rely
entirely on the `timespec_arg()` check to validate the `<seconds>`
argument, and then simply use `if (i == argc)` at the end to ensure
`<file>` arguments were provided. I will clean this flow up
significantly in v2.

> >       if (timespec_arg(argv[i], &set_time, &set_eq)) {
> >               ++i;
> >       } else {
> >               if (get == 0 && verbose == 0) {
> >                       fprintf(stderr, "Not a base-10 integer: %s\n", argv[i] + 1);
> > +                     usage_with_options(chmtime_usage, options);
> >               }
> >       }
>
> This is largely the fault of the original, but I wonder if we can
> avoid the "without -v/-g, timespec is required" logic in two
> separate places like this (and the earlier one that puzzled me)?
>
>
> >       if (i == argc)
> > +             usage_with_options(chmtime_usage, options);
>
> And we want at least one <file> in any case.
>
> >       for (; i < argc; i++) {
> >               struct stat sb;
>
> OK.  We will iterate over the <file> arguments given.
>
> > @@ -110,7 +110,7 @@ int cmd__chmtime(int argc, const char **argv)
> >
> >               if (stat(argv[i], &sb) < 0) {
> >                       fprintf(stderr, "Failed to stat %s: %s. Skipping\n",
> > -                             argv[i], strerror(errno));
> > +                             argv[i], strerror(errno));
> >                       continue;
> >               }
>
> This fixes a whitespace breakage, which is an unrelated change, but
> I'll let it pass.
>
> > @@ -150,14 +150,10 @@ int cmd__chmtime(int argc, const char **argv)
> >                       }
> >  #endif
> >                       fprintf(stderr, "Failed to modify time on %s: %s\n",
> > -                             argv[i], strerror(errno));
> > +                             argv[i], strerror(errno));
> >                       return 1;
> >               }
> >       }
>
> Likewise.
>
> >
> >       return 0;
> > -
> > -usage:
> > -     fprintf(stderr, "usage: %s %s\n", argv[0], usage_str);
> > -     return 1;
> >  }
>
> We exit via usage_with_options() with 129 now, but used to exit(1)
> upon a command line error.
>
which is a nice bonus of migrating to the parse-options API.

> Looking good.  Thanks.

Thanks
Shashank S Mogaveera
