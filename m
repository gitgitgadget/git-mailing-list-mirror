Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49B1E20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 18:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbeLJSTv (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 13:19:51 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38866 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbeLJSTu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 13:19:50 -0500
Received: by mail-it1-f194.google.com with SMTP id h65so19742179ith.3
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 10:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2QuUE1/s6vglfUbWQyJ3rhNFH88lLExmWVMiL0vF5bc=;
        b=ghw4fSQSwIb3UP1m7aK/irb18Jy11sc8J71U1B3CrcXv6xVHbURjL+y7OmHmIjf5oo
         89CqFKypdPbvxrKdFn34antupDfIVhPJX9xa0Ay7SWidj1+AqC0QeYFY4Bp0pODD9Hc9
         Vn5mk974StmPuLJSG3kWVxwAYhoRNQW7J6rAW7x1GFMjxln+EvxtAIMx6CD7emomTBIl
         c2BKYLGX7dRUliRAual4gJqNnE+SnMsD6R0V7GUfocV9MOV424V+3g3t+TOf2VM/TzTQ
         vXWGw33O8lsN/nAdlo/Lk6IF+0DjlN5Bbm38GQr/MxTZ/39SE81VFzKkqu2/2uSCMTdI
         ETFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2QuUE1/s6vglfUbWQyJ3rhNFH88lLExmWVMiL0vF5bc=;
        b=A+UyrbaLjk9OUMfhg99MGKU5Mj8aDIk7jYDDIxzhvigSEtDYlSfoZIn8XOh2tRB873
         Nsom+1DLydQVO2S3kWXPjTfm/1xEm1jQZNSknUtsh9xGhFXiUmEt2NM4LDrOvqesOU/3
         okzFDj0cR2Mw/sd4TZEn+AgGBd0eoeuxqF6Lvk3u9eba5nHY4LxfoOuo4emH9u73uvYH
         Gh5Kh7GKnvykRlC8v0LYeivtAO1pO+2dwYlSKRDQAohp2bH4wb2AlsXKsE3Hk6oqLX8F
         gyNTc7X8e0RvPMXfg9MUwuTjnNrW4Qjo3991117yblcdKRuFUiZdUTdE8HHiUU6DnR+0
         k1bA==
X-Gm-Message-State: AA+aEWZN6gdpcS7OErMCPGpM+AcTE7xDgkZ7gKcznpzyU0mDmxBnVsgb
        GL0sThq8rG0WADqwEfv/4TnQzh981N/tFLpwz+8=
X-Google-Smtp-Source: AFSGD/WozF2/Yw9QPgt2WG6yqB6fjHCIJ8cJwv4sHuYd0Yp8FBB0Bp/lT+Qhwj3o3TjN/Be2pq9CXR3S3Eq5LbL0UVY=
X-Received: by 2002:a24:e1ce:: with SMTP id n197mr11903054ith.123.1544465988359;
 Mon, 10 Dec 2018 10:19:48 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-5-t.gummerer@gmail.com>
 <CACsJy8AiQvu8W4=2HLKMdg+n2HiDrcLvKPRurKvziXaJdqefRg@mail.gmail.com> <CABPp-BEkeRa7jOkDcNNpZMY9J9JmNGtMKjZeNv8i_u7jUFihcw@mail.gmail.com>
In-Reply-To: <CABPp-BEkeRa7jOkDcNNpZMY9J9JmNGtMKjZeNv8i_u7jUFihcw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 10 Dec 2018 19:19:21 +0100
Message-ID: <CACsJy8BG5ri=UMeOPqLTqxcOYqPsc9BdY4pxgQA8pfb+rE1MyA@mail.gmail.com>
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

On Mon, Dec 10, 2018 at 7:09 PM Elijah Newren <newren@gmail.com> wrote:
> > > For the two current callsites, unpack-trees seems to do this
> > > invalidation itself internally.
> >
> > I'm still a bit scared of this invalidation business in unpack-trees.
> > The thing is, we handle two separate index_state there, src_index and
> > result and invalidation has to be done on the right one (because index
> > extensions are on src_index until the very end of unpack-trees;
> > invalidating on 'result' would be no-op and wrong).
> > remove_marked_cache_entries() seems to be called on 'result' while
> > invalidate_ce_path() is on src_index, hm....
>
> Is Thomas avoiding problems here simply because merge is the only
> caller of unpack_trees with src_index != dst_index?  Or does src_index
> == dst_index for checkout not actually help?

I think it would not help. 'result' is a temporary index where we copy
things to (and it does not have anything from the beginning). If you
invalidate stuff in there, you invalidate nothing, regardless whether
dst_index == src_index.

> If that does help with the checkout case, then allow me to find a
> different way to muddy the waters...  I think I might want to make use
> of this function in the merge machinery at some point, so I either
> need to figure out how to convince you to verify if all this cache
> tree invalidation stuff is sane, or somehow figure out all the
> cache_tree stuff stuff myself so I can figure out what is right here.
> :-)

I'm not the unpack-trees man (I think that would still be Junio). And
I'm not saying it's sane either. I think it's just some leftover
things since Linus split "the index" in unpack-tree operation to
'src', 'result' and 'dst' many years ago and nobody was brave enough
to clean it up (then I piled on with untracked cache and split index,
but I did not see it clearly either). That person could be you ;-)
-- 
Duy
