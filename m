Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFA8F20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 18:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbeLJSZT (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 13:25:19 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:33702 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbeLJSZT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 13:25:19 -0500
Received: by mail-vk1-f193.google.com with SMTP id d201so2766333vka.0
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 10:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q+hwM1rt22wJFJkfG2Pry1pL1pPMhzPNwt23LxJk0Wk=;
        b=luNNLFp3QwMUlp3bRd7tJXMsI+thZTAKiJr6fGFc5NcoyRra69LL3EjTTiGjQjUoxs
         b0QKDvyd0kA8JOgukX+FASpjYfK1HrNypkpaC4szs/q3hWrc0c+Fqpu3F9d/xR5n9erU
         xiyI3J8gjMSN9XIIzU9X+5Wlv4udD/uUp24faR7fUuan/w+YteF+g+U3aOcpge3opKMs
         7YAM1LOit7foxzQpB1+YoqVnJNzaxmuMq0q3SMuwX7G01G7Xh3bCPSmXVuRt2KQvhvd2
         jEj7g8eQ5t4a30w9P4uOYd86k7lLPVFJIfTIzqRC/nS2ZH5XjYPpmrIIbhN2luoNuiT4
         yNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q+hwM1rt22wJFJkfG2Pry1pL1pPMhzPNwt23LxJk0Wk=;
        b=ndOz7MAnCwI1ZAbQHfvWLtUTcWNSJZPqFPqQGwiXJmv8xVII5J4ViTgltJDedVMaTZ
         x9Y+LVodAhB9uVc/vNIQpIXZX9rLPT/ciDwGGQAis7jFUsi+dA9ngbzxvVOIxNN2FvzE
         O/RvYl3e0rXHir7TthmOoySZORg5wgxNoGjHNkkMy6oXP5PM4LOPdGCOgSIQ3WFFeXvT
         Im2D4WQazoy7PM18fPnlhZ5OWMt29iGIPANowQYFrYG05i+beLkC2cvloim8WiSz2udn
         OOvUTbqC30/N+E6FYWZUrspQ2gD1n9Od2cE+JnpXG/KldIVqSfe/eOyJ8HRFTarpZemn
         PrZw==
X-Gm-Message-State: AA+aEWbpkiY1CGFMyt6Ke6GxSLlE5eKdz4QD4SEL0VkT1vl1yF/H7xg0
        Jdhp8RwCEgOF0Uvk9BHPI6hT602EUcmORAxZGxU=
X-Google-Smtp-Source: AFSGD/Vf8yxYzJYvUI9UXyzMcBofVaAGpG1AyjuYvoFwYviwcu43VDlZhPbG0B45HFQpLGyWMJFCei1kcVHx0FLLGAg=
X-Received: by 2002:a1f:e7c5:: with SMTP id e188mr3027618vkh.92.1544466316737;
 Mon, 10 Dec 2018 10:25:16 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-5-t.gummerer@gmail.com>
 <CACsJy8AiQvu8W4=2HLKMdg+n2HiDrcLvKPRurKvziXaJdqefRg@mail.gmail.com>
 <CABPp-BEkeRa7jOkDcNNpZMY9J9JmNGtMKjZeNv8i_u7jUFihcw@mail.gmail.com> <CACsJy8BG5ri=UMeOPqLTqxcOYqPsc9BdY4pxgQA8pfb+rE1MyA@mail.gmail.com>
In-Reply-To: <CACsJy8BG5ri=UMeOPqLTqxcOYqPsc9BdY4pxgQA8pfb+rE1MyA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 10 Dec 2018 10:25:05 -0800
Message-ID: <CABPp-BH7CuNy-6wg1jnxytuwEF9Vw=8Y0N8dUhdCJJbyps2kyw@mail.gmail.com>
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

On Mon, Dec 10, 2018 at 10:19 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Mon, Dec 10, 2018 at 7:09 PM Elijah Newren <newren@gmail.com> wrote:
> > > > For the two current callsites, unpack-trees seems to do this
> > > > invalidation itself internally.
> > >
> > > I'm still a bit scared of this invalidation business in unpack-trees.
> > > The thing is, we handle two separate index_state there, src_index and
> > > result and invalidation has to be done on the right one (because index
> > > extensions are on src_index until the very end of unpack-trees;
> > > invalidating on 'result' would be no-op and wrong).
> > > remove_marked_cache_entries() seems to be called on 'result' while
> > > invalidate_ce_path() is on src_index, hm....
> >
> > Is Thomas avoiding problems here simply because merge is the only
> > caller of unpack_trees with src_index != dst_index?  Or does src_index
> > == dst_index for checkout not actually help?
>
> I think it would not help. 'result' is a temporary index where we copy
> things to (and it does not have anything from the beginning). If you
> invalidate stuff in there, you invalidate nothing, regardless whether
> dst_index == src_index.
>
> > If that does help with the checkout case, then allow me to find a
> > different way to muddy the waters...  I think I might want to make use
> > of this function in the merge machinery at some point, so I either
> > need to figure out how to convince you to verify if all this cache
> > tree invalidation stuff is sane, or somehow figure out all the
> > cache_tree stuff stuff myself so I can figure out what is right here.
> > :-)
>
> I'm not the unpack-trees man (I think that would still be Junio). And
> I'm not saying it's sane either. I think it's just some leftover
> things since Linus split "the index" in unpack-tree operation to
> 'src', 'result' and 'dst' many years ago and nobody was brave enough
> to clean it up (then I piled on with untracked cache and split index,
> but I did not see it clearly either). That person could be you ;-)

Hmm, might make a good New Year's resolution: Enter the abyss, find
out if one can return from it...  or maybe I could just sanely run
away screaming.  We'll see.
