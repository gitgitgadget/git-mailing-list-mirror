Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A723B1F403
	for <e@80x24.org>; Mon, 11 Jun 2018 22:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932414AbeFKW43 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 18:56:29 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:41466 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752521AbeFKW42 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 18:56:28 -0400
Received: by mail-yw0-f195.google.com with SMTP id s201-v6so6881225ywg.8
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 15:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pbiBagSQRoJJfAnK6gX7NZ0zpmCJJslsFI2HcAKh1Hs=;
        b=otsoa1rCRuxKJ7hdGXVEvq0qzLyto/1HwAEuwx+1bonrzlm1zKSD9GZFIKzcUfYLAg
         RXoz0mK0CPsQ8GGdLJIsHQL7Ypms0mXTiFFf02Q+oZGF8BFzWpfhdfUfEIHzBYVOm18M
         xyKUnBOM9rYsN4nXaZjT5Slrd+6YXvpm37mnD3bC8pZ9+oLoeiqh/RHLpaiPfNUl/2Iq
         OTx7WEV75rTdVlNuXNqHuQuH+cpfhGu3FHXcuoLRvsb3V+6EdxozP9wZQHmISbBpJu04
         9UOwFwY5fMy88B1nMcIvdY9qk7SKBNHCn17nUBgTwYwDBSKBeRFlF1Lagu4ws/RNnZlW
         kG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pbiBagSQRoJJfAnK6gX7NZ0zpmCJJslsFI2HcAKh1Hs=;
        b=h4SdoOfMT0TNOyr7hcZQpnwVQkgmKCxpFitHNU2alMEAq5pZhedKiXdSBznXhoSHWA
         h9DZlJg4gfQvzzHnSeuXy6JQiuKPyPJORzvSyN8gemXyw7VgOSD43yqzl/HMySgQZRzw
         5cGsF69HajVnX+WrA7w1D9zYRQMu0xuZWXsW2ee6d7qfDYLwKNGkkCcDMDByUrzRPqT+
         m9dbeF77Izf3+XPPPKossgauIVApOUUmwkRwXMPZbrdnO2oY9dG5sRqP9Ial3IzliZUE
         b9vP1VSeM+dx6Q2G3uFNwnl7qSgoGaCzZcELAugpt0l4PBjL8BltGUL7nkb+PBAAE8iW
         wVOA==
X-Gm-Message-State: APt69E28XsZ3MHjO7AN+jwKwzumquF4Xx/xQuD9citKDlP8RFZZcWArb
        9fYEACzVBp+D/Qy+9Q4prrwBLoVkQ3Jv9rA9Yz2XeMvaThU=
X-Google-Smtp-Source: ADUXVKKodZ9e0gMhEDdLnjq0mafJSqfCtSaDomGgweM5EvY0jhOTO+N7o4Z5frWnSpeCH0rr/1xc8amTifYSuArrSIg=
X-Received: by 2002:a81:4d43:: with SMTP id a64-v6mr506611ywb.33.1528757787829;
 Mon, 11 Jun 2018 15:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <CACsJy8CNrQ-CKoJ+1NCR1rsO+v0ZNZ9CVAFsJpmcRWZY6HUtKw@mail.gmail.com>
 <20180609110414.GA5273@duynguyen.home>
In-Reply-To: <20180609110414.GA5273@duynguyen.home>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 11 Jun 2018 15:56:16 -0700
Message-ID: <CAGZ79kZk=OGPJdsDEHtgmPUrO7P2rOLSV40aJawdLs5e0=Kduw@mail.gmail.com>
Subject: Re: BUG: submodule code prints '(null)'
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 9, 2018 at 4:04 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Tue, Jun 05, 2018 at 05:31:41PM +0200, Duy Nguyen wrote:
> > I do not know how to reproduce this (and didn't bother to look deeply
> > into it after I found it was not a trivial fix) but one of my "git
> > fetch" showed
> >
> > warning: Submodule in commit be2db96a6c506464525f588da59cade0cedddb5e
> > at path: '(null)' collides with a submodule named the same. Skipping
> > it.
>
> The problem is default_name_or_path() can return NULL when a submodule
> is not populated. The fix could simply be printing path instead of
> name (because we are talking about path in the commit message), like
> below.
>
> But I don't really understand c68f837576 (implement fetching of moved
> submodules - 2017-10-16), the commit that made this change, and not
> sure if we should be reporting name here or path. Heiko?
>
> diff --git a/submodule.c b/submodule.c
> index 939d6870ec..61c2177755 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -745,7 +745,7 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,

[Not in the context of this patch, but in the code right before the
context starts:]

            name = default_name_or_path(p->two->path);
            /* make sure name does not collide with existing one */
            submodule = submodule_from_name(the_repository, commit_oid, name);
            if (submodule) {

Currently I see 4 callers of default_name_or_path and the other 3 except this
one have checks against NULL in place, which is good.
However I think we have to guard this even more, and have to check
for !name before we call submodule_from_name.

It is technically ok to call submodule_from_name with a NULL name,
but it is semantically broken, see the comment in config_from that
is called from submodule_from_name:

    /*
     * If any parameter except the cache is a NULL pointer just
     * return the first submodule. Can be used to check whether
     * there are any submodules parsed.
     */
    if (!treeish_name || !key) {
        ...


>                                 warning("Submodule in commit %s at path: "
>                                         "'%s' collides with a submodule named "
>                                         "the same. Skipping it.",
> -                                       oid_to_hex(commit_oid), name);
> +                                       oid_to_hex(commit_oid), p->two->path);

This is correct for the error message, both in terms of not crashing as well
as correctness, we really need to report a *path* here and no the name_or_path,
which  default_name_or_path gives.
