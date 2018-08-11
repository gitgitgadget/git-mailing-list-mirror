Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C469E1F404
	for <e@80x24.org>; Sat, 11 Aug 2018 14:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeHKRMv (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 13:12:51 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:32973 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbeHKRMv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Aug 2018 13:12:51 -0400
Received: by mail-io0-f169.google.com with SMTP id z20-v6so10300603iol.0
        for <git@vger.kernel.org>; Sat, 11 Aug 2018 07:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qED8cA8+INJtsH0jD9Rd+dWQm8Bx51LWe+INJDm6iWA=;
        b=UdE6PkoKDkaqnlpnEDVnmrjcSJ/6Ro0aCiYM7KA/TQi99nrNkw71qrIDZhtKrdN7Np
         jyPug9MhHNWi11r02/bIB4Mk1IxAeDRRXgyOv7s9S42LxZwWbPBTmeWtKwxHS+MacGXz
         9pRIt11rCCuvZyNPlT+d0qvYkftw0j340OEvzQNW5UTehsauWecRihLkFhBJwZ0tiBMh
         SWuEoVzdZGIelU2ei+CDi4TEP3cr9kO96/QLfg3zdELaqlbcoqQFgig72bc9oixqNgfR
         H9jP1IhHaqGPW6pDpzclXOmilFw/1N3G9g031hv5ssNFWfxrAruvuUBohuNKybL7UFUH
         G4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qED8cA8+INJtsH0jD9Rd+dWQm8Bx51LWe+INJDm6iWA=;
        b=RdM83/m7+AbAd+KRlqWqjyMF6XT1Bxi1y5OJIeFO60vMcodLqeEWAAyLahlGKrjAUy
         Bg9pt9P7e/VWS/XxzuzQSivlwMUP7oHQlJeiweFZMlokmxTHm9DohJRrJqdTM9lRaffd
         IpuCVI4FROpb9ELERb31tjNxmFHXKgw10zzITSJ4BfCpQVcH4WG28CJALJh8mvn064ln
         WU23r/W2Z5L/GturO9wvk79g3kJSHKjFcnBSQP37L99Aj0LIuAR1A1oiQokY8XqvFuHA
         CLhBhCSmw0BzS5OmMt1XpmkeTx+ska7DhZZ5LMUnZ4KAEtLa1uieRObp516NMD9eFieG
         TOWA==
X-Gm-Message-State: AOUpUlHcDDmVLhKF9pfxN9CsPfESSWMUxTlu1OoHvYotrTGvvsc+FDCI
        DMNFbQSoSLCn0HJzIFDLdt1weWSeqYpvlSMcyIE=
X-Google-Smtp-Source: AA+uWPxzmNEhTeiml1sV+ZrtY8zCRHtvEK2HBt9zdmPaiI94EPaGm1ttbuKvdDaa5oniyCXjm5nLMUIJjL3cSthyEXw=
X-Received: by 2002:a5e:d809:: with SMTP id l9-v6mr8297067iok.236.1533998306387;
 Sat, 11 Aug 2018 07:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <1b2f649f0ece2ff46801c7bbd971c736e257af83.camel@mad-scientist.net>
 <20180808160612.GC1607@sigill.intra.peff.net> <b247434b62ccd30f32adbebb83fa6ea12b51b6ff.camel@mad-scientist.net>
 <20180808182436.GA19096@sigill.intra.peff.net> <be46349efde84f158b80e96f2fbbcf4304a71208.camel@mad-scientist.net>
 <20180811142341.GA17605@sigill.intra.peff.net> <20180811142527.GB17605@sigill.intra.peff.net>
In-Reply-To: <20180811142527.GB17605@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 11 Aug 2018 16:38:00 +0200
Message-ID: <CACsJy8DE+V3GK0f3fDAtjseLYU_5Ct3V0RHxs3N=aNmA0hO3cw@mail.gmail.com>
Subject: Re: Help with "fatal: unable to read ...." error during GC?
To:     Jeff King <peff@peff.net>
Cc:     Paul Smith <paul@mad-scientist.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 11, 2018 at 4:25 PM Jeff King <peff@peff.net> wrote:
> Responding myself and adding Duy to the cc to increase visibility among
> worktree experts. :)

I do silently watch this thread (and yes I still have to fix that fsck
thing, hit a roadblock with ref names but I should really restart it
soon). Now you have found one more thing for me to do. Why Jeff why?
j/k
-- 
Duy
