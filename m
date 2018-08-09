Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E2641F405
	for <e@80x24.org>; Thu,  9 Aug 2018 21:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbeHJAUm (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 20:20:42 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34973 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbeHJAUm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 20:20:42 -0400
Received: by mail-yw1-f68.google.com with SMTP id s68-v6so6812358ywg.2
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 14:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PYqZfw6Ai76qfmUW0V9nbxdGWK1kAy5dGxPpSG+0ewE=;
        b=k0WfQJvc2tmIMj8/pCDWB1wu5OM84J846puABnFByVXzNxYI13IRZkN0lKZLYMqnrp
         vUt+SompNwWNMDyUE0VzSkauCyDLK7YNjIThL5aqgtjj2Cy9dOo28geWxpTlmFVH881Y
         AWFeNqKqRYr7Ll79vIFjQ09KvvYBTdO2vqMYSa5ni8NQVmALUGKRsmqXQvsZN2ASQiM8
         hi3jr5ODcwKEFBGGBWZwu8DwzAvIBWlKJYW/ygn4ohrgYupl3SafsNf7G4wFbjExuvgx
         wbh34137FvXJs/M7GHYO5oiXUgMojsTXbNzWpApgR9Papk0NpEuH6Ww+iAzPxI70uIzE
         rUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYqZfw6Ai76qfmUW0V9nbxdGWK1kAy5dGxPpSG+0ewE=;
        b=AXOWZiN9aToIRUOVjb5xZ+GfnfUhQWc7eDyBI4w8lfMXMEgnAbwNbYpvknJBazBXZ6
         k1IKHogjq9gUBtX7eCVW/TmcvrMbc2VzxT1JTwNxXR7wqcfgy9XLNJoShijqb1ShZie0
         6l2Z6jLAr3BSbPiq1xLcdK2iEzXvV9fCz68WRM3KcxMIVVDpuqJS2vo2uZPGYt4JFuMH
         Eh7yngrHZ0x9xd6x13JJfAON9K6p5PtCRUSDWU5zwzIdcnyawRj1K4oZydwBOe23vdQ5
         jAZG8knIFcoYb1k4IPTspBhMFcHh/Kr6PlJhk8ChruMkEMQkfAX+EsL2PSFdP8gzXqZm
         zKvQ==
X-Gm-Message-State: AOUpUlHhxxiQw1HR6hLnwtAjnIccxbTyGdycR1d1cSXsv+B9Txt18Ywo
        ETueFgexDN3sSuKld19CgQrkp/CBguuwBzq58cg=
X-Google-Smtp-Source: AA+uWPzs3A8fKGv/BdfowglaJa00btFInJJ/B+YtpsY+ufmRyDCe0Uj6Ykmz4vUwFRDe1V5S4XfTOhjhkU8gs/mpZ+g=
X-Received: by 2002:ab0:12e2:: with SMTP id o34-v6mr2719392uac.154.1533851634342;
 Thu, 09 Aug 2018 14:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180730152756.15012-1-pclouds@gmail.com> <20180807190110.16216-1-pclouds@gmail.com>
 <xmqq7el2km82.fsf@gitster-ct.c.googlers.com> <fc56d572-e333-2e05-2130-71b53e251a13@jeffhostetler.com>
 <20180808223139.GA3902@sigill.intra.peff.net> <xmqqbmace5i1.fsf@gitster-ct.c.googlers.com>
 <20180809142333.GB1439@sigill.intra.peff.net> <34b22185-a0bc-f712-b5e5-fc5e2697dcc2@jeffhostetler.com>
 <CABPp-BHiB_gR-dQbpJtSBYPJ5Om4Mv0ymnZFNocyTfbUotyBgw@mail.gmail.com> <20180809214430.GE11342@sigill.intra.peff.net>
In-Reply-To: <20180809214430.GE11342@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 9 Aug 2018 14:53:42 -0700
Message-ID: <CABPp-BEAybfJ8sojRwDbDjhcwk4VyQ26F1LnKyNLsg1fYS1fNA@mail.gmail.com>
Subject: Re: [PATCH v2] clone: report duplicate entries on case-insensitive filesystems
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        pawelparuzel95@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 9, 2018 at 2:44 PM Jeff King <peff@peff.net> wrote:
> > The error message isn't quite as good, but does the user really need
> > all the names of the file?  If so, we gave them enough information to
> > figure it out, and this is a really unusual case anyway, right?
> > Besides, now we're back to linear performance....
>
> Well, it's still quadratic when they run O(n) iterations of "git
> ls-files -s | grep $colliding_oid". You've just pushed the second linear
> search onto the user. ;)

Wouldn't that be their own fault for not running
  git ls-files -s | grep -e $colliding_oid_1 ... -e $colliding_oid_n | sort -k 2
?   ;-)
