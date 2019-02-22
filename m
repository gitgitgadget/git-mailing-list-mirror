Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A310F1F453
	for <e@80x24.org>; Fri, 22 Feb 2019 00:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfBVAV1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 19:21:27 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46754 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfBVAV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 19:21:27 -0500
Received: by mail-io1-f66.google.com with SMTP id k21so364396ior.13
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 16:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KFgfn1/CH4aTGJsptZ1sMrVRtnRi9guZzRVr3LjxrZg=;
        b=AVMPeN7qFVH8Xr6sTLvyRiDi2Jm+ibEkvI4Yx+v5rhchzJNoguI8z4MdLbTqS7s0hS
         hOiFLpM+daYd0/cbnYpWH8P3qce31LaBrHmLh3LFcZ/BI1cCZJGJ26E9CVzVGTH1IOey
         bBB42j9vBGj1N9dUnwqYVRTQ1aY3P4yKQPf/S1bVFXgNX/xLbvE2QJ7FlNuAj/5yU3ux
         AMyQa5l0Vdy7tbDz8kOjnnGoj4IbGwvmo44k+9LGCqAlA57dLeWO2CWjBjOke0SEaJb4
         faRUjFYqxE6/eDaNMTHek6O2sfZw33Y2rGIqnIBuQ6dzuA/sfDlvC8hgkgN4wUUUWhSc
         ZeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KFgfn1/CH4aTGJsptZ1sMrVRtnRi9guZzRVr3LjxrZg=;
        b=g4Ot5crERKxus2Et8bCoABGaciQy4T52VJe+6Mdy+t3853tCX9y9arhDvG/+0EJON+
         pTN9KSlmo29Zf7ROoumOVGOlMRDTOhekgzbwGkIa/WErJMh6SDDqLU9e9giruvNuRGer
         Y9sa/DkY1kta0oF1YhepoVOJteAi31CAfj1RIH5eXkKaklBtyVlQ1BVSEuqKQ/otjoIl
         KCGnpDqICxVmcNq32juc82kGFTZXoJ7T9p8dwEELiMVdiMgXd+k21C2nghOzdHecRX6g
         Ux1gXQAIgIhnR2I+NWGzREBD2q4YBm+B+8yyfKoMkIGrMe7sZ58eCBCYManH6Xg+pNv8
         f6Fw==
X-Gm-Message-State: AHQUAuYxVH3xzs06nFLZOpMSX+ay+uaopBz3RZv/RJWjY8z8Z7cY+o0B
        G3FpNFfnv3Qk5E9YWavrlZwcI3QR/pXfQ0FgSoM=
X-Google-Smtp-Source: AHgI3IZq7F6nLR6/DjTRZAPmoVIgT1zKHzq5ymK+Ca/MAZZ1fOzxuzQ42j1Qmg8iNc9h3ovzW6l4za6zBMVF+ao7Alg=
X-Received: by 2002:a6b:b70d:: with SMTP id h13mr832273iof.288.1550794886564;
 Thu, 21 Feb 2019 16:21:26 -0800 (PST)
MIME-Version: 1.0
References: <20190215154913.18800-1-matheus.bernardino@usp.br>
 <20190215154913.18800-3-matheus.bernardino@usp.br> <20190216143824.GJ6085@hank.intra.tgummerer.com>
 <CAHd-oW60a+zz9J+u0HiRuTy-FKYN4s95fCcR3mgJz0hUokhTCQ@mail.gmail.com> <CAMy9T_GzgPPMFLrPNbtf4zaYtyCoUDjXQbd2z8JeXFYogvfrVQ@mail.gmail.com>
In-Reply-To: <CAMy9T_GzgPPMFLrPNbtf4zaYtyCoUDjXQbd2z8JeXFYogvfrVQ@mail.gmail.com>
From:   "Daniel Ferreira (theiostream)" <bnmvco@gmail.com>
Date:   Thu, 21 Feb 2019 16:22:39 -0800
Message-ID: <CAEA2_RL2ZxfjW5fU9sWeAovEHExptNDxOeQAiAtDqjLdz0bBuw@mail.gmail.com>
Subject: Re: [GSoC][PATCH 2/2] clone: use dir-iterator to avoid explicit dir traversal
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there! I'm happy to see this series has gotten renewed attention.

The series was fine per se, and it even got through to the pu branch.
But then it got ejected since it conflicted non-trivially with another
patch series that was added along the way (see
https://lwn.net/Articles/724166/). At that point I did not keep
pushing it forward.

I'd be happy to help anyone willing to make some progress on this! (Or
even ultimately solve the conflict myself, if it serves a greater goal
than just being a GSoC microproject.)

Best,
-- Daniel.
