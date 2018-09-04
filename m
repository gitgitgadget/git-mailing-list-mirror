Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBF341F404
	for <e@80x24.org>; Tue,  4 Sep 2018 22:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeIECeZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 22:34:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37977 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeIECeY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 22:34:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id w11-v6so5506564wrc.5
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 15:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Fdz+S0BJB9hGQcfk+xKWrR41ffMkj8E8cRdlA5xp4C4=;
        b=RZvhsMOyDAQkXL2mQmE7BxKhKdYYcns09+s8xE9z2JB4CiTmtHfRsZHPOn16JskJIg
         JWO91S1CRL6KBvLvvZQ/TL02wQK9/9EuO48ezO5KV5CKtHrLwaV7oiHSGrCXHPNmp/RP
         OwkFGv/D7lKzg9jSvsuF6Rw8vbZuWNJrqJPiL/BBMekDYgjEFyvPC6QgK6zgbO7lZOhg
         0MDzljqfNACkZu2h1JnLN/7AjtzrcnM8ZVcRRVMObuu0pdL7YrRteANaDGfR+xLXdtsm
         kxqVk/lNG/tWCeCmIjd+QWsdaMZdl0CCAypGkk2qmIMhxiLT7XSzPSLgTRlcYSDaPHNm
         /msQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Fdz+S0BJB9hGQcfk+xKWrR41ffMkj8E8cRdlA5xp4C4=;
        b=K2PnYeyoLI9f8kVR9+y2/V4H9+UryksBN3QRY9IZfeaBG4Nnjo/UPJWMFNkU0407u7
         k2o1vUn+Qxp7B9EdyPiRQZBayeKRrnAjCctq5WBdKy69FHeaiak3k0udCirLgNlA/GfH
         tfadKsUqPJh71gLc/RKIs4nMBTwVDwfXydBO0zjNTdObtsVYcCe5FPH4dNRPBuG0FE2p
         dpp4cCu3HHUGxn0jzKOoRTiFiVY85KbBMxt/zMcyeIJ/BDwOkcWaFlvYxrrpA+qOEltJ
         q8RDlTioEIJPQLERV5wvL4hUbPSunqnaMTY/t0KbuFpRhrN4Hgbl6+o4+2ZZqZ33nQZ+
         lt2Q==
X-Gm-Message-State: APzg51Df54opIu4kQKT6IepWnR4M9dGNMwbRSD10adTKwhQ63mI8wskW
        BZVU1KPVbPX0b4rBBhEKUK4=
X-Google-Smtp-Source: ANB0VdZQVjJeGibtkzXllLzxcWEGWTzSt0QzOVS+cOzSje5vl9VtpmQRE1U4ncIPqD1G5DIcCgh10A==
X-Received: by 2002:adf:a292:: with SMTP id s18-v6mr25456041wra.100.1536098837380;
        Tue, 04 Sep 2018 15:07:17 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j133-v6sm314158wmd.12.2018.09.04.15.07.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 15:07:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/2] commit-graph write: add progress output
References: <20180904202729.13900-1-avarab@gmail.com>
        <20180904202729.13900-2-avarab@gmail.com>
Date:   Tue, 04 Sep 2018 15:07:16 -0700
In-Reply-To: <20180904202729.13900-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 4 Sep 2018 20:27:28 +0000")
Message-ID: <xmqqin3k7w8b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Before this change the "commit-graph write" command didn't report any

Please describe the pre-patch state in present tense without "Before
this change".

> progress. On my machine this command takes more than 10 seconds to
> write the graph for linux.git, and around 1m30s on the
> 2015-04-03-1M-git.git[1] test repository, which is a test case for
> larger monorepos.
>
> Furthermore, since the gc.writeCommitGraph setting was added in
> d5d5d7b641 ("gc: automatically write commit-graph files", 2018-06-27),
> there was no indication at all from a "git gc" run that anything was
> different. This why one of the progress bars being added here uses

"This is why", I guess.

> start_progress() instead of start_delayed_progress(), so that it's
> guaranteed to be seen. E.g. on my tiny 867 commit dotfiles.git
> repository:
>
>     $ git -c gc.writeCommitGraph=true gc
>     Enumerating objects: 2821, done.
>     [...]
>     Total 2821 (delta 1670), reused 2821 (delta 1670)
>     Computing commit graph generation numbers: 100% (867/867), done.
>
> On larger repositories, such as linux.git the delayed progress bar(s)

"such as linux.git, the delayed ..."

> With --stdin-packs we don't show any estimation of how much is left to
> do. This is because we might be processing more than one pack. We
> could be less lazy here and show progress, either detect by detecting
> that we're only processing one pack, or by first looping over the
> packs to discover how many commits they have. I don't see the point in

I do not know if there is no point, but if we were to do it, I think
slurping the list of packs and computing the number of objects is
not all that bad.

>  static void compute_generation_numbers(struct packed_commit_list* commits)
>  {
>  	int i;
>  	struct commit_list *list = NULL;
> +	struct progress *progress = NULL;
>  
> +	progress = start_progress(
> +		_("Computing commit graph generation numbers"), commits->nr);
>  	for (i = 0; i < commits->nr; i++) {
> +		display_progress(progress, i);
>  		if (commits->list[i]->generation != GENERATION_NUMBER_INFINITY &&
>  		    commits->list[i]->generation != GENERATION_NUMBER_ZERO)
>  			continue;

I am wondering if the progress call should be moved after this
conditional continue; would we want to count the entry whose
generation is already known here?  Of course, as we give commits->nr
as the 100% ceiling, we cannot avoid doing so, but it somehow smells
wrong.
