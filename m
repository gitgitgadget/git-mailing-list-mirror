Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C07DF20D0C
	for <e@80x24.org>; Fri, 16 Jun 2017 17:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbdFPRjS (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 13:39:18 -0400
Received: from mail-yb0-f175.google.com ([209.85.213.175]:36046 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752498AbdFPRjC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 13:39:02 -0400
Received: by mail-yb0-f175.google.com with SMTP id t7so14375848yba.3
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 10:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hwXmwBaBIDFxFz7eU+A6HhNfF5KO2n9L72+PRKRmNNo=;
        b=EhpsPiFZHpjewiDeJCRTPowpeQzbfQinsCj8Dvc1Qw0sueWVXc2Eqed+pAJ6mUzdCs
         Rh7e934NRBKiKgzmuKoJ9VUckfpdPZL2syWbNwdM430773poufjvl553Vf480CeBd+Kd
         fx2nV4Vr0+4feRWWTFdRDrWJsGAdDM280upX7PzdWQmAGb7n6ZbWdq5vclzYzqkXmT8Q
         eEsfMFZjX65rwWFCHoH9AzXzAs2IoOxAYi5cT75GbosHAH3g9IlukqGFTTqweXnsUWfw
         4r5EfFu+1GCQtBWgI7KkuDmUkNpxfiDp7dYnojfkRiWjuvf+62EMgqGSR0P0bMPkVgMM
         xbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hwXmwBaBIDFxFz7eU+A6HhNfF5KO2n9L72+PRKRmNNo=;
        b=RcM8P02IGYgpNrANw1DdTLdDVbqT/WsMSDJGb1Sga7rT8aZAJn/lkgekihrUUy7gUS
         nMGN2dTWv1uUMCvKipjbywMeeCWGrmb3iQxbzL+LE9l/72pKx+t4XdZE0tTFTOp7sT6e
         dQcwFzhjQHZuJhFXb0QXeMCicgl1BI6ObFh8g/6+QsXu5bi8nf6qrlU6d/Z0QfJpmuI8
         zWP6oICLg3v/7Rzs+1jNeVW0CvlbfUsXzXIHjG8O0rrRzUfH4AUT+LrjTLoPWnHjXCUt
         Dd94WXYiy3Uv+jafT786XEmU9vt6BrN5xiFPLfWer7JM17yZyHfxPZdZ6O1isZOAU7Br
         omCw==
X-Gm-Message-State: AKS2vOyP2WfE9PiFFxBeFFq8P8vSGUh7sYSu7474AeRQzu0luFt7wrsQ
        KC6zF9xIR3yyOYB1fsTRSVTbOxCpN8K9
X-Received: by 10.37.216.4 with SMTP id p4mr9286442ybg.35.1497634741801; Fri,
 16 Jun 2017 10:39:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.59.65 with HTTP; Fri, 16 Jun 2017 10:38:41 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1706161438470.4200@virtualbox>
References: <20170306002642.xlatomtcrhxwshzn@genre.crustytoothpaste.net>
 <20170306182423.GB183239@google.com> <alpine.DEB.2.21.1.1706151122180.4200@virtualbox>
 <20170615110518.ordr43idf2jluips@glandium.org> <20170615130145.stwbtict7q6oel7e@sigill.intra.peff.net>
 <87shj1ciy8.fsf@gmail.com> <alpine.DEB.2.21.1.1706152123060.4200@virtualbox>
 <CAL9PXLzhPyE+geUdcLmd=pidT5P8eFEBbSgX_dS88knz2q_LSw@mail.gmail.com>
 <20170615224110.kvrjs3lmwxcoqfaw@genre.crustytoothpaste.net>
 <CACBZZX5Z3kQHe_5TgOeuJSgzuvpQdaLo6RrgX_EvuZfdz856sA@mail.gmail.com>
 <20170616001738.affg4qby7y7yahos@genre.crustytoothpaste.net>
 <87y3ss8n4h.fsf@gmail.com> <alpine.DEB.2.21.1.1706161438470.4200@virtualbox>
From:   Adam Langley <agl@google.com>
Date:   Fri, 16 Jun 2017 10:38:41 -0700
Message-ID: <CAL9PXLxMHG1nP5_GQaK_WSJTNKs=_qbaL6V5v2GzVG=9VU2+gA@mail.gmail.com>
Subject: Re: Which hash function to use, was Re: RFC: Another proposed hash
 function transition plan
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
        Brandon Williams <bmwill@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 16, 2017 at 6:24 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> And while I am really thankful that Adam chimed in, I think he would agree
> that BLAKE2 is a purposefully weakened version of BLAKE, for the benefit
> of speed

That is correct.

Although worth keeping in mind that the analysis results from the
SHA-3 process informed this rebalancing. Indeed, NIST proposed[1] to
do the same with Keccak before stamping it as SHA-3 (although
ultimately did not in the context of public feeling in late 2013). The
Keccak team have essentially done the same with K12. Thus there is
evidence of a fairly widespread belief that the SHA-3 parameters were
excessively cautious.

[1] https://docs.google.com/file/d/0BzRYQSHuuMYOQXdHWkRiZXlURVE/edit, slide 48

> (with the caveat that one of my experts disagrees that BLAKE2b
> would be faster than hardware-accelerated SHA-256).

The numbers given above for SHA-256 on Ryzen and Cortex-A72 must be
with hardware acceleration and I thank Brian Carlson for digging them
up as I hadn't seen them before.

I suggested above that BLAKE2bp (note the p at the end) might be
faster than hardware SHA-256 and that appears to be plausible based on
benchmarks[2] of that function. (With the caveat those numbers are for
Haswell and Skylake and so cannot be directly compared with Ryzen.)

K12 reports similar speeds on Skylake[3] and thus is also plausibly
faster than hardware SHA-256.

[2] https://github.com/sneves/blake2-avx2
[3] http://keccak.noekeon.org/KangarooTwelve.pdf

However, as I'm not a git developer, I've no opinion on whether the
cost of carrying implementations of these functions is worth the speed
vs using SHA-256, which can be assumed to be supported everywhere
already.


Cheers

AGL
