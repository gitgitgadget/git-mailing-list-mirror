Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8E4B20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 18:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbeLJSrZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 13:47:25 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:32820 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbeLJSrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 13:47:25 -0500
Received: by mail-vs1-f66.google.com with SMTP id p74so7308492vsc.0
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 10:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fH2+MKc6MMpMbtKrdSxCrkxcnnu09nJDxgJpq7Oc3D0=;
        b=VeIUE8nMKVtS+vhQm5XAxeHQ+uylxKGTzJB4sR5t4YYyFqOC1ikUdrzp/kbA3nklkr
         3JJ1RA23QECXN0sNxn8zpN000bGsE5okVrHmVSfZN3i3d5G8La9oSgJA4Zsm7HoqqLPU
         aVJgm2LoiQmaXBFwIHd5Yt5Bs5bR80srVqfY70zwEPxI413b758hQYRZs4qG5OztR0/F
         3/Sw6saQ435twrsiwxypEmP6dEz9so8+5YjXmBtFiQEC5A2eenLgOFGu15u/4IZD45bF
         et4kC0SL2Ndy0tbcJQ5oKpGSlfSL8fT0bCL1eEAdSibNhcGTsVNHCfX9qc9J5b73BTCu
         Uq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fH2+MKc6MMpMbtKrdSxCrkxcnnu09nJDxgJpq7Oc3D0=;
        b=rwzzztuQGhRdHCzTYYGs58MKJfMhOJ58T5QHcCIB+f7HqHS+xNxgUCLOanxOp062Zl
         mO19KLLenKk7baPjEH+InwsTd22d7D0csm5P0GqBLco4aSwYOqwrBACTBeS6b1VHXkRU
         UuvMKTMDmIsYyLiNfZhV6DKlIgMbd9qJPWmjpqBgwgY3ciJ6oXSx53Vk/yJzPWjIwcjn
         Qh3nZOrGDBoFAhLxQKBTVwj7ga84VnlkbaTuh0G8kSugVrTbY7f8tZstIhXAuXkfduDX
         B9YeNRwHqIhC07IrVcY5MgXzjpuv2oAuK75ID7vtCkntZeTs0bfewRKG62r8HFan0Zdj
         DO5Q==
X-Gm-Message-State: AA+aEWaL5n0vGKeNhQdOcqBR/OjrepF8Jax+/VKjQIjYe1VrrUgGN1+r
        msWDDW2mbWYWD8l2+bvTqFHmY2HXmhTAYDLx4DE=
X-Google-Smtp-Source: AFSGD/UYNi64/jBrpOCKFwn6Vwqbfpwovn80566Igd5vO8MU06c+zwEdQgUL+sIqrEzVczlBi0BhFyD0F9bJZDybEwk=
X-Received: by 2002:a67:f696:: with SMTP id n22mr5945320vso.175.1544467643662;
 Mon, 10 Dec 2018 10:47:23 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-5-t.gummerer@gmail.com>
 <CACsJy8AiQvu8W4=2HLKMdg+n2HiDrcLvKPRurKvziXaJdqefRg@mail.gmail.com>
 <CABPp-BEkeRa7jOkDcNNpZMY9J9JmNGtMKjZeNv8i_u7jUFihcw@mail.gmail.com>
 <CACsJy8BG5ri=UMeOPqLTqxcOYqPsc9BdY4pxgQA8pfb+rE1MyA@mail.gmail.com>
 <CABPp-BH7CuNy-6wg1jnxytuwEF9Vw=8Y0N8dUhdCJJbyps2kyw@mail.gmail.com> <CACsJy8CR2p4784PxX2o+t4QcgyiU=QoiqLeB5o86cdyd5_fHEA@mail.gmail.com>
In-Reply-To: <CACsJy8CR2p4784PxX2o+t4QcgyiU=QoiqLeB5o86cdyd5_fHEA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 10 Dec 2018 10:47:09 -0800
Message-ID: <CABPp-BE-O-zMyndzqtyy9L6JM5HYAzOcA-Y9ffP_4ZMhm1FqcA@mail.gmail.com>
Subject: Re: [PATCH 4/8] read-cache: add invalidate parameter to remove_marked_cache_entries
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 10:34 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Mon, Dec 10, 2018 at 7:25 PM Elijah Newren <newren@gmail.com> wrote:
> > > I'm not the unpack-trees man (I think that would still be Junio). And
> > > I'm not saying it's sane either. I think it's just some leftover
> > > things since Linus split "the index" in unpack-tree operation to
> > > 'src', 'result' and 'dst' many years ago and nobody was brave enough
> > > to clean it up (then I piled on with untracked cache and split index,
> > > but I did not see it clearly either). That person could be you ;-)
> >
> > Hmm, might make a good New Year's resolution: Enter the abyss, find
> > out if one can return from it...  or maybe I could just sanely run
> > away screaming.  We'll see.
>
> I'm getting off topic. But my new years resolution would be optimize
> for the case where src_index == dst_index, which is somewhat ironic
> because we used to do everything in the same index, but it was a messy
> mess and had to be split up.

Ooh, that sounds cool too.  I look forward to seeing it.
