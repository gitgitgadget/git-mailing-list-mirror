Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2B4D20987
	for <e@80x24.org>; Fri, 21 Oct 2016 15:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755768AbcJUPaL (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 11:30:11 -0400
Received: from mail-yb0-f178.google.com ([209.85.213.178]:32973 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755735AbcJUPaK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 11:30:10 -0400
Received: by mail-yb0-f178.google.com with SMTP id g68so43650861ybi.0
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 08:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fC+FSnzuNKLx0icOnvwMpudv64zCer6yOgB40tF1iOg=;
        b=GonyPnJCTc79Agf6LhZonidi9P9PcZI/lpdRINVer45UtbcKAn1CFL+OsNtg8mMZZK
         uS5aZKJ8lV/sdUXR8CGnmmqUvRxA6Mdakp9v52w+R50xAu3hQLy0MxyO57ZqyxBKl53O
         Cxv5BVNUHfMu7A89sqmhk455kApBn8fi20eiGQUF9YZ6g7r2IKMzvwytTetfDV9aT4xL
         PxDcn9sTVhiV7PExpzJbpeJLaAPwzZNSYUv3eu5rRloQ39Lx1b/wrpzlyu5M0SOLrxik
         RvJO3oa5wXC5SAH2BH0pZRgxNacMOJsRjNw3Z8QLQ0WrX69FzXYPzBUXqh1zz9TALMAM
         LtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fC+FSnzuNKLx0icOnvwMpudv64zCer6yOgB40tF1iOg=;
        b=PZpHnZxHndsBRpgqq2ACkrktTWOFjgwEvHTMVMHvylyVVxSonex+gst9ZeJAxNCBjB
         +7HL7humVDGF0dgZbYP15/fJN68prESxC1nmTTKBpIKlVgiVWVi+TVoXK7ccYvU1I0tv
         EBVwcPIkNEGW9jIlqKVCBh8MdsW6yWVpGXyb2bc/QEbW2VTMPWS5NDggjzpmVkLXSZr2
         J/iGmbZc3YPh3YYISWRO8S7RW1l9LTQfyQeS3aRv1dJSGre/WAS6iMGmNu0KAY2hvu3D
         fg07qLVbD9K3B9SkgV1y3ohdLaP80GTreDS/Iei6dHYkDNMBPAbsaiW2GGgMaCdiyGdS
         xWqw==
X-Gm-Message-State: ABUngveB+i+Te6VlLQs4mOPrBmjAH55UhSwtGQ+AcWy/lm1hawTR0OwAgAYQK5nPMwfaFy7Q33GBhTptYkDWuw==
X-Received: by 10.37.61.198 with SMTP id k189mr1709268yba.57.1477063810100;
 Fri, 21 Oct 2016 08:30:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.10.2 with HTTP; Fri, 21 Oct 2016 08:29:49 -0700 (PDT)
In-Reply-To: <20161021084348.dp4jfpfownodl7nz@sigill.intra.peff.net>
References: <D9C1E13F-88A2-483E-A549-1C2294EACFEB@gmail.com>
 <CAGZ79kZo3LdcRmrjQTAvgx=H6U2tdjASK3qv5A2K5J2HQ2NvSw@mail.gmail.com>
 <20161021082035.xad6wfny5i6wtshh@sigill.intra.peff.net> <20161021084348.dp4jfpfownodl7nz@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 21 Oct 2016 08:29:49 -0700
Message-ID: <CA+P7+xozpk2-WZUYtaKmCazG3Owzpa3bsDejyUuGj0YEQnJWJg@mail.gmail.com>
Subject: Re: Prove "Tests out of sequence" Error
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2016 at 1:43 AM, Jeff King <peff@peff.net> wrote:
>   prove t5547-push-quarantine.sh :: -v
>
> The Travis tests do exactly this (along with --tee to actually save the
> output). It seems like a minor miracle that this is the first test
> output that has actually triggered as TAP input. I'd suggest that the
> problem is not in the test, though, but that our "--verbose" option is
> unsuitable for using with a TAP harness.
>
> The obvious fix would be to send "--verbose" output to stderr, but I
> suspect that would end up annoying for people who do:
>
>   ./t5547-push-quarantine.sh -v | less
>
> to read long output. Probably we need some option like "--log" which
> logs in the same way that "--tee" does, but _without_ sending the data
> to stdout. Naively, that just means replacing the "tee" invocation with
> "cat", but I suspect it will be a lot more complicated than that,
> because we still need to let the TAP output go to stdout.
>
> -Peff

Can we determine that we're running with something monitoring the TAP
output? Because then we could make verbose go to stderr instead
dynamically?

Thanks,
Jake
