Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A5221FAE2
	for <e@80x24.org>; Wed,  7 Feb 2018 18:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754215AbeBGSGp (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 13:06:45 -0500
Received: from mail-yw0-f176.google.com ([209.85.161.176]:39493 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753965AbeBGSGp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 13:06:45 -0500
Received: by mail-yw0-f176.google.com with SMTP id v196so682862ywc.6
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 10:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f4ZNg2hSxJ1vJuUfzkEc0ppatLp8XVvqb6MUln1cpAo=;
        b=qoqXQbNS0gCW2BHqs3wJxLpWRUr/WRXurIajOYwG0fBsmPVZRaYUtKPBj/CZjAgBvC
         EsG8hRtPDxTCyR1xJ9FoYLo0uf+lnULM9Ppurwd7O28tr2ZIzefmpRbmZLlIPBzEcC3B
         cMhfhe5atWvn0aa7SSf5QC8GBHLBNns7MwhG+gY1pute6uzPEszwLq1BeAC9HTFEuVBY
         aCDDlvrDgKWfRppnwuzLFB1g7xjqoXBuqUL5P+yfM3dQkqputiu+X1ZIbNfUUso5mlf2
         5Ss9SjZ2ZuGMdsjjUvQuoOu61/dpDkjABetbs3sUZTCaJ/lLHCuFP0ufN02a5xF59vPC
         ILZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f4ZNg2hSxJ1vJuUfzkEc0ppatLp8XVvqb6MUln1cpAo=;
        b=cKJcCzSCpLokSSZSPu/+LsxI1uVoODzJ7xDmtTl+odJLrRE7Vb9JbbSsiKovL+Yuo8
         k+ZCTBrZh8CPJkvRQNvNIaZHTRrVDPn1Yqm+lOxBmuIGwPg4RbO3LZLDYAdGJh8p7Uma
         8rikGypoeEbmSmGDisevPvSGv0YfvPJhiw231vP2O2S6Iml+1V+kX5LVxRqrcmy2pRNV
         txZ/2OegrPH6gbDQvCSNeJ/Kz4ToHSJeRIJUgCAVbw60irh8VGbw0b2RpDL3uDXEr4Z3
         176yxEG1N4SZaMXZLRY3FTzxW/L5nJ6dh9ZGcOuFF3P2ae5ygw1wdHyudhiZfQyAIP2a
         KwZA==
X-Gm-Message-State: APf1xPA0F1XUFe2dLfjYHpjDS5ME04+OLZSZpoGK0w2X1JJhAZFlanFZ
        KO7cCDks++1kwP2i7A5YvlL/54cdPFCpiarWmWKH3Q==
X-Google-Smtp-Source: AH8x225faT8+o3Jf9F7/xGnDnfGDFzgLWt9zFzw6yzPhsF/Kl2YHzSqjsfDiedqSy5NJ0uKEWy6vFALBe8uJDmej+WI=
X-Received: by 10.129.108.149 with SMTP id h143mr4517151ywc.373.1518026803807;
 Wed, 07 Feb 2018 10:06:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Wed, 7 Feb 2018 10:06:43 -0800 (PST)
In-Reply-To: <CACsJy8CGgekpX4cZkyyTSPrj87uQVKZSOL7fyT__P2dh_1LmVQ@mail.gmail.com>
References: <20180205235508.216277-1-sbeller@google.com> <CACsJy8CGgekpX4cZkyyTSPrj87uQVKZSOL7fyT__P2dh_1LmVQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 7 Feb 2018 10:06:43 -0800
Message-ID: <CAGZ79kabQ1WvxxjFV+fgq8b142yNrtGZC_Vqac+5b3CkUpbi2w@mail.gmail.com>
Subject: Re: [RFC PATCH 000/194] Moving global state into the repository object
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 7, 2018 at 3:48 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Feb 6, 2018 at 6:51 AM, Stefan Beller <sbeller@google.com> wrote:
>> This series moves a lot of global state into the repository struct.
>> It applies on top of 2512f15446149235156528dafbe75930c712b29e (2.16.0)
>> It can be found at https://github.com/stefanbeller/git/tree/object-store
>>
>> Motivation for this series:
>> * Easier to reason about code when all state is stored in one place,
>>   for example for multithreading
>> * Easier to move to processing submodules in-process instead of
>>   calling a processes for the submodule handling.
>>   The last patch demonstrates this.
>
> I have a mixed feeling about this. The end game is to keep
> "the_repository" references as minimum as possible, right? Like we
> only need to mention in in cmd_xxx() and not all over the place. If
> so, yay!!

Yes. And the super-end-game long after this series is to have
    cmd_xxx(struct repository *r, argc, argv)
or so.

> Something else.. maybe "struct repository *" should not be a universal
> function argument to avoid global states. Like sha1_file.c is mostly about the
> object store, and I see that you added object store struct (nice!).
> These sha1 related function should take the object_store* (which
> probably is a combination of both packed and loose stores since they
> depend on each other), not repository*. This way if a function needs
> both access to object store and ref store, we can see the two
> dependencies from function arguments.

I tried that in the beginning and it blew up a couple of times when I realized
that I forgot to pass through one of these dependencies.
Maybe we can go to the repository and shrink the scope in a follow up?

> The alternate object store, if modeled right, could share the same
> object store interface. But I don't think we should do anything that
> big right now, just put alternate object store inside object_store.

yup that is the case, see struct raw_object_store at the end of the series
https://github.com/stefanbeller/git/blob/object-store-v2/object-store.h

> Similarly those functions in blob.c, commit.c, tree.c... should take
> object_parser* as argument instead of repository*. Maybe there's a
> better name for this than object_parser. parsed_object_store I guess.
> Or maybe just object_pool.

Note that the initial few patches are misleading in the name,
https://public-inbox.org/git/20180205235735.216710-59-sbeller@google.com/
which splits up the object handling into two layers, the "physical" layer
(where to get the data from, mmaping pack files, alternates, streams of bytes),
which is "struct raw_object_store objects;" in the repository, and the
"object" layer, which is about parsing the objects and making sense of the data
(which tree belongs to a commit, dereferencing tags)

So maybe I'll try to make the first layer into its own series, such
that we'll have a smaller series.

Thanks,
Stefan

> --
> Duy
