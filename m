Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B36E208E9
	for <e@80x24.org>; Sun, 22 Jul 2018 18:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbeGVTw3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 15:52:29 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37273 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730506AbeGVTw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 15:52:28 -0400
Received: by mail-wm0-f50.google.com with SMTP id n11-v6so3217043wmc.2
        for <git@vger.kernel.org>; Sun, 22 Jul 2018 11:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ghx8PkbDWIrVp9bwzBDFXErvPxKG09VcnKmeY1+iXFY=;
        b=i4In1R3Pn3k4ry0x7oALjBg3ypJm2Lg2euLsKGjoM95AUoEdzmXDYP2Aqjp8t5DSSz
         kJ9ph17Kyw15KCsmhmfJFzMwCvqdqg6GgPfw/1+wTgO5WwHbxfZj12DYH6acyihs58tP
         Qf7EXHtwVfGMIfuwOaTk3B2mfVbDqFMeom0fG5vYLCL0NCQj3zpshUCiBFhukO6htJ5l
         aV+NLlKD9YqWhDPJKot+87tjnKH5QTeCryD7n0RQwPtmpiJKJvFcQ52c2T+YH4aAspw7
         +tkABu+DRkxG+x7YOurKegXsiiQH1LPx+xUW3ersinHiea7oRaE7cBpmbpRug1hQ9Gix
         vdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ghx8PkbDWIrVp9bwzBDFXErvPxKG09VcnKmeY1+iXFY=;
        b=lit8a8Qxf1sby12AASiG6hfcb+Fx34b/PVHvsDMg8sv1dh0KG4BfSWTSveC4ep2vwQ
         1AfAmDnBFU9H/RKm3cDbrJZXRguygj1fbH0MXhgjXAGCPVs84YAnzcxR/cUoCrK+csl7
         FA6lbIve4b+Mq9thh3dakZj07YBrAvqMdRr1M/jCVhOJ4xAJ9lo+WuCy6dI4Ah730GKt
         2Z7/xeP4KsF3vaqPUGB92EJ8mBv54NCSFdiFW91OO7BxA9IUgQ10jsi2Fijg8sIAqzdT
         NB2Q6TYN257uag/gnJJsys0sjxEJ/r1/VFUe3Abu23jUEQtGfAPVj0fO7+qIsWNS4z/I
         OktA==
X-Gm-Message-State: AOUpUlEZjvhmpgiUAxNp9r2g4+74Ei/DlaFw6cJ4lXFpf7Pk2/h2ZVPF
        O9Y7O05QRcdKgddPX4vl1e2e1qznLThdAFFPaQDzIQ==
X-Google-Smtp-Source: AAOMgpexQlFmrP/e5/EppaNsLcDIBXj36abg9Bug2JqvYIxkOjTFIqh9JCd+fWxpLr/H6CoQfitVFRlBATRQaDoYn4c=
X-Received: by 2002:a1c:e146:: with SMTP id y67-v6mr5587375wmg.108.1532285689451;
 Sun, 22 Jul 2018 11:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180609224913.GC38834@genre.crustytoothpaste.net> <20180611192942.GC20665@aiede.svl.corp.google.com>
 <20180720215220.GB18502@genre.crustytoothpaste.net> <nycvar.QRO.7.76.6.1807220036340.71@tvgsbejvaqbjf.bet>
 <20180721235941.GG18502@genre.crustytoothpaste.net> <f5bb91e8-5189-7f61-e018-91447c42845e@noekeon.org>
In-Reply-To: <f5bb91e8-5189-7f61-e018-91447c42845e@noekeon.org>
From:   Adam Langley <agl@google.com>
Date:   Sun, 22 Jul 2018 11:54:36 -0700
Message-ID: <CAL9PXLyNVLCCqV1ftRa3r4kuoamDZOF29HJEhv2JXrbHj1nirA@mail.gmail.com>
Subject: Re: Hash algorithm analysis
To:     jda@noekeon.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, demerphq@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>, all@keccak.team
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Somewhere upthread, Brian refers to me as a cryptographer. That's
flattering (thank you), but probably not really true even on a good
day. And certainly not true next to Joan Daemen. I do have experience
with crypto at scale and in ecosystems, though.

Joan's count of cryptanalysis papers is a reasonable way to try and
bring some quantitative clarity to an otherwise subjective topic. But
still, despite lacking any counterpoint to it, I find myself believing
that practical concerns are a stronger differentiater here.

But the world is in a position where a new, common hash function might
crystalise, and git could be the start of that. What that means for
the ecosystem is is that numerous libraries need to grow
implementations optimised for 3+ platforms and those platforms (esp
Intel) often need multiple versions (e.g. for different vector widths)
with code-size concerns pushing back at the same time. Intrinsics
still don't cut it, so that means hand-assembly and thus dealing with
gas vs Windows, CFI metadata, etc. Licensing differences mean that
code-sharing doesn't work nearly as well as one might hope.

Then complexity spreads upwards as testing matrices expand with the
combination of each signature algorithm with the new hash function,
options in numerous protocols etc.

In short, picking just one would be lovely.

For that reason, I've held back from SHA3 (which I consider distinct
from K12) because I didn't feel that it relieved enough pressure:
people who wanted more performance weren't going to be satisfied.
Other than that, I don't have strong feelings and, to be clear, K12
seems like a fine option.

But it does seem that a) there is probably not any more information to
discover that is going to alter your decision and b) waiting a short
to medium amount of time is probably not going to bring any definitive
developments either.


Cheers

AGL
