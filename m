Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 910DE2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 22:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbdBWWu2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 17:50:28 -0500
Received: from mail-ot0-f172.google.com ([74.125.82.172]:33119 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbdBWWu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 17:50:28 -0500
Received: by mail-ot0-f172.google.com with SMTP id k4so4040522otc.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 14:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=mOsA8l34lb8vq/cYM50r7SIfTYo7yw/2FUm8rnyLScc=;
        b=B0I6CZ7bxLdQiaTk5wxa+mg6rnrBgNS0W8MsiGPAzgWGheE1QgjuFE/KtSfS7notIL
         vLzsxIyhBdPhI5eV0uiobRtiuHz7NQ/rGOfYNcMJy90wnAeKWvHOgpqDBWQkCrRfHUkE
         GUHkgn9bXu4CiYNzsR1qrNO4fbTnoFNcDi2ykIkkwrpsHIquzGJ1iB0WTJph7gbvLfgm
         WRpWU7aVayusWiTDgQJxt62A4hbeUHCZnCm7ZkUgRtYfvoxPhvMx0Lt3J7hsC/5bfwfk
         DgcsAfmMVrPDfUKROixUjD40Mp/nuwrzf8lV5Wfvchl1GQnN0Kbhl30Q0usKzUxlFS0S
         jdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=mOsA8l34lb8vq/cYM50r7SIfTYo7yw/2FUm8rnyLScc=;
        b=ICy5UgwyzWHg7W3NmdppHDYOQvKgmIPyLtjbMtPD/A+stn6Q6m/F+dhy/V/k1i0MzF
         DykSVZmtrBPrAmsjFy+5vTrwynuDtPiGkRjMWu4lhNrlka6zgekFotml2t6QXgsFLKC2
         4ZMYjG5PQhhq78oM6H7PMWS/sf0J+m2h+AhR5CXRt+bcT3CT435/mnIZhIpS9L5vtDTL
         319tZd5FXXV+NWkWoGkvLjjO2Keu/w2vSmrmnNblI8ZJ0Gmwc0GK2BfsfP24EoNCyUGl
         Nbyr8smN3pBKDnUsXjDjPza2XE68KseczHMoqaDUWtzob1jcJzy00/W4MDYn70hJSLIs
         Hv6g==
X-Gm-Message-State: AMke39nozS3plK9hbwgHGjaBjrV77ZGdgKLPzlFwc4usuAdiB1CsPMuCTMYbB0a/jtUkcfHG2T1WaRF2Ms9byg==
X-Received: by 10.157.4.36 with SMTP id 33mr20582731otc.221.1487890227044;
 Thu, 23 Feb 2017 14:50:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.164.66 with HTTP; Thu, 23 Feb 2017 14:50:26 -0800 (PST)
In-Reply-To: <20170223224302.joti4zqucme3vqr2@sigill.intra.peff.net>
References: <20170223173547.qljypk7sdqi37oha@kitenet.net> <CA+55aFzFEpi1crykZ33r9f7BsvLt_kiB-CHXOkuCAX=fd4BU-w@mail.gmail.com>
 <20170223182147.hbsyxsmyijgkqu75@kitenet.net> <CA+55aFxckeEW1ePcebrgG4iN4Lp62A2vU6tA=xnSDC_BnKQiCQ@mail.gmail.com>
 <20170223184637.xr74k42vc6y2pmse@sigill.intra.peff.net> <CA+55aFx=0EVfSG2iEKKa78g3hFN_yZ+L_FRm4R749nNAmTGO9w@mail.gmail.com>
 <20170223193210.munuqcjltwbrdy22@sigill.intra.peff.net> <CA+55aFxmr6ntWGbJDa8tOyxXDX3H-yd4TQthgV_Tn1u91yyT8w@mail.gmail.com>
 <20170223195753.ppsat2gwd3jq22by@sigill.intra.peff.net> <alpine.LFD.2.20.1702231428540.30435@i7.lan>
 <20170223224302.joti4zqucme3vqr2@sigill.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Feb 2017 14:50:26 -0800
X-Google-Sender-Auth: 39Sc0sxOieersJpfsUamgI67kE8
Message-ID: <CA+55aFyfWVHYMC+sSyct=uNLK=mHV-NqyNQXXtFY5YX1Uc-tAw@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Jeff King <peff@peff.net>
Cc:     Joey Hess <id@joeyh.name>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 2:43 PM, Jeff King <peff@peff.net> wrote:
>
> Yeah. I started looking at that, but the ubc check happens after the
> initial expansion.

Yes. That's the point where I gave up and just included their ugly sha1.c file.

I suspect it can be done, but it would need somebody to really know
what they are doing.

            Linus
