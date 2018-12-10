Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73E7F20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 18:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbeLJSeH (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 13:34:07 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55427 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeLJSeG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 13:34:06 -0500
Received: by mail-it1-f194.google.com with SMTP id o19so18847057itg.5
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 10:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0iuVamSPT/g1GC7+kaJDCuqXv69YwPg5PNHovMcQceA=;
        b=Xvmc81tB5uIMSgdTDL7H178pModSsfSnAb6RPpxW1NVX2ananw0lvzVwzxSlZHBWrs
         zkyMVeHk8Zihh4bR0wHkdSF0SGiU7+O+CQY5l3fl6qBTY0zc4fSVKAd1gT6h0yHjgeLX
         U4X9vzshyC7DZhDXNaZhzOPNhT2G8KrIFuBzpbN6aYBGgrEUHhX9ApAO60pZa1/p5YjY
         POpOyLaE2X6stSGXtXSbQiIfmpCEyyQOY7V5QFFUbW4G4tXqhZDKEMXkKuGwr5G5KIDk
         5qSvGSaW2/WYKDBjDmtpYnAKuEc4WS/5dnPaiqUawOCzKvf+WNfAhBiSV1R7AaslduNE
         v5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0iuVamSPT/g1GC7+kaJDCuqXv69YwPg5PNHovMcQceA=;
        b=twagKRUrzWl05fo3kJQg1DkvWZWDPJjIkpPJHImEnpJgvz4/Cz1HUnMqTXNBxhwgZf
         snf9s+zEKcOJMeH6zND01X7hv1z6enVK/AUNLu63zgAl89/mM8mv4AfWqX4Xo6yKxAaI
         0koAg4XkBPUHzadAn+66nkyLBLPBJ19eyFicrnclw8fx5nuztYqc2og7ihSpgWIukNwJ
         mByzbm/RfyjNEB+TK6APQvS70D/EZeFbLvsSmDHA8F89WQ46PGE/bP8jzgyw1kmlsuRd
         oSBrIGVWUazEuVg6NGFpBAhYiAGMO4viV1Sr7eFII8FmUwLbPsFo/oFJnftAffzP7TCl
         9FPA==
X-Gm-Message-State: AA+aEWZXrE47guQuQT/vtTHV40FXNN1uh7pEMB5+YWsVNqs5TGXpSHrS
        h4kEjGHuybGcMYF9IlaPr/3gSOrpbA9wPypRBfk=
X-Google-Smtp-Source: AFSGD/V5Hzyfp4oKOOGCw5PQ44OrZANOV0Ts0hgobqfXkagu0Fz6uwKijcSLB5RDT8FPhdsT3jAlTMUvxWlermgdr2s=
X-Received: by 2002:a24:4606:: with SMTP id j6mr10403776itb.10.1544466845955;
 Mon, 10 Dec 2018 10:34:05 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-5-t.gummerer@gmail.com>
 <CACsJy8AiQvu8W4=2HLKMdg+n2HiDrcLvKPRurKvziXaJdqefRg@mail.gmail.com>
 <CABPp-BEkeRa7jOkDcNNpZMY9J9JmNGtMKjZeNv8i_u7jUFihcw@mail.gmail.com>
 <CACsJy8BG5ri=UMeOPqLTqxcOYqPsc9BdY4pxgQA8pfb+rE1MyA@mail.gmail.com> <CABPp-BH7CuNy-6wg1jnxytuwEF9Vw=8Y0N8dUhdCJJbyps2kyw@mail.gmail.com>
In-Reply-To: <CABPp-BH7CuNy-6wg1jnxytuwEF9Vw=8Y0N8dUhdCJJbyps2kyw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 10 Dec 2018 19:33:39 +0100
Message-ID: <CACsJy8CR2p4784PxX2o+t4QcgyiU=QoiqLeB5o86cdyd5_fHEA@mail.gmail.com>
Subject: Re: [PATCH 4/8] read-cache: add invalidate parameter to remove_marked_cache_entries
To:     Elijah Newren <newren@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 7:25 PM Elijah Newren <newren@gmail.com> wrote:
> > I'm not the unpack-trees man (I think that would still be Junio). And
> > I'm not saying it's sane either. I think it's just some leftover
> > things since Linus split "the index" in unpack-tree operation to
> > 'src', 'result' and 'dst' many years ago and nobody was brave enough
> > to clean it up (then I piled on with untracked cache and split index,
> > but I did not see it clearly either). That person could be you ;-)
>
> Hmm, might make a good New Year's resolution: Enter the abyss, find
> out if one can return from it...  or maybe I could just sanely run
> away screaming.  We'll see.

I'm getting off topic. But my new years resolution would be optimize
for the case where src_index == dst_index, which is somewhat ironic
because we used to do everything in the same index, but it was a messy
mess and had to be split up.
-- 
Duy
