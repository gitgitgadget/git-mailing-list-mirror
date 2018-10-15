Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 587FA1F453
	for <e@80x24.org>; Mon, 15 Oct 2018 16:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbeJPAky (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 20:40:54 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33333 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbeJPAky (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 20:40:54 -0400
Received: by mail-ed1-f66.google.com with SMTP id l14-v6so9542426edq.0
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZItUMb3cvCW8UIK1Fi4+9u0eTXC+T+j2ppp4VwQR9h4=;
        b=L2DFmJo03078awr7MW3T9Wq6aKdkDk6lFm79gQ7mowh+E+GMUD5l1u7+u6HB8x7vUK
         nGSypNv9H+8V1GcCj4p0Xu9vzaT5WUkifB0I1eoDlCQNdMCdVvcMKfEsm/tCmAPUtqW2
         NL5jjEPEqC3SXvqiwwhn5KwvtXpr7sRBk6ig2x+lra9UZH9QqPg1j0+DP2oB7lyS9qfT
         UG669zUpuLDGktJU2ZHvfiyhBcERUO95vmCyLTHLjc35iDyycZTxWtwo3c1IhWqWkt8C
         8nTq4mDFhxg9Hf54bJoTut1kjFm2iRYn1jqYA12I0Dr+eaLjlRGfrkkzOpoM3xEhSHhU
         iZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZItUMb3cvCW8UIK1Fi4+9u0eTXC+T+j2ppp4VwQR9h4=;
        b=k7i407VgDZNevJAx1k7N6VNJTBARFUA7zEf7WirK63y9QIyEMQLxmXDejvnUKI8r/b
         D6JF1/C+2BRLI3oX5jKrRPG+DxZ6JHjmU3mo/UNfFA7K8RSeKNyDVF3KN8JoL80/Ar0F
         fd5BGqzCQqxEAr+0yXccdNAZK2J9D+cs4bTpR+HJ2nz+bs5Y8YcB3kCX3Nrgc7TZ+PV/
         2Dbd8xuZDXyOQxPzEHTK+LQ7KHOnzlQHz6aRqhlkUMNrjlo+Yk9K4JdP4xF9ruIRgfx1
         X0jYYln3/DAf8XYojFpBpfPkKIpLW5oqw1G3nosWuC+lpAEzuun+0fprYWtiOokH2mhf
         EC3g==
X-Gm-Message-State: ABuFfohbOcefIeAiBaxhNqOFz6pcsvLrbkNKQ2dB2f38eYTkZYKJ+jwG
        KtiJMzeimztPJUejX1FMRs3I7p+N
X-Google-Smtp-Source: ACcGV60JSIIB9tNeP8t8WRQClg9b2+lzNUniVk2gxY3Q8qc1Qi+lU4LRiXcim0cUo9/AT9X2Xt2ZrA==
X-Received: by 2002:a50:930e:: with SMTP id m14-v6mr25613673eda.114.1539622490894;
        Mon, 15 Oct 2018 09:54:50 -0700 (PDT)
Received: from szeder.dev (x4d0c894f.dyn.telefonica.de. [77.12.137.79])
        by smtp.gmail.com with ESMTPSA id c24-v6sm4477286ede.73.2018.10.15.09.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 09:54:49 -0700 (PDT)
Date:   Mon, 15 Oct 2018 18:54:47 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 1/2] commit-graph write: add progress output
Message-ID: <20181015165447.GH19800@szeder.dev>
References: <CACsJy8A5tFxAaD-OqNNvMmX+KnbmW=O7JCCBbY-5dZa8Ta7QYg@mail.gmail.com>
 <20180917153336.2280-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180917153336.2280-2-avarab@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 03:33:35PM +0000, Ævar Arnfjörð Bjarmason wrote:

> @@ -560,6 +563,9 @@ static int add_packed_commits(const struct object_id *oid,
>  	off_t offset = nth_packed_object_offset(pack, pos);
>  	struct object_info oi = OBJECT_INFO_INIT;
>  
> +	if (list->progress)
> +		display_progress(list->progress, ++list->progress_done);

Note that add_packed_commits() is used as a callback function for
for_each_object_in_pack() (with '--stdin-packs') or
for_each_packed_object() (no options), i.e. this will count the number
of objects, not commits:

  $ git rev-list --all |wc -l
  768524
  $ git rev-list --objects --all |wc -l
  6130295
  # '--count --objects' together didn't work as expected.
  $ time ~/src/git/git commit-graph write
  Finding commits for commit graph: 6130295, done.
  Annotating commits in commit graph: 2305572, done.
  Computing commit graph generation numbers: 100% (768524/768524), done.

(Now I also see the 3x difference in the "Annotating commits" counter
that you mentioned.)

I see two options:

  - Provide a different title for this progress counter, e.g.
    "Scanning objects for c-g", or "Processing objects...", or
    something else that says "objects" instead of "commits".

  - Move this condition and display_progress() call to the end of the
    function, so it will only count commits, not any other objects.
    (As far as I understand both for_each_object_in_pack() and
    for_each_packed_object() iterate in pack .idx order, i.e. it's
    essentially random.  This means that commit objects should be
    distributed evenly among other kinds of objects, so we don't have
    to worry about the counter stalling for a long stretch of
    consecutive non-commit objects.  At least in theory.)



