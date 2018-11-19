Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB7FF1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 16:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbeKTC0N (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 21:26:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41783 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbeKTC0M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 21:26:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so3995667wrs.8
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 08:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=h44Ul6G0LRyxSYfOGfGekB8a6LkRLX/oIvUOz/MZimU=;
        b=Xaew9xrvYZx3vnbG/UfPQbLUuk6oqIzjyTcUyjxxCKsvuqWLonnWeDVLXiua0XLqZs
         DXVtCTq971laHXO7SY+5K4oPIE+ZW25bhy+g6uA92gPowJYTz7WQCwyfl0SnlJUcu5dh
         DaGxzUdZkAFSDwbx2uYFNwLKbZ3QVBrAWTxtFa9KOGRrFUY/IRUnM+P9+HgOFLYOJZmZ
         9UzxO5QgAa5XYMjgOvsyECibsU/V3SF261+htxYtKLlgYC1unWmWdFcrRZTBp4625C/Q
         lPXjLZYldO+XVjTv0Zga2apeOvPMiQv83FpYEDgfmO+hwS6D5Dft5VYgEhBd7l5GTw1f
         y14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=h44Ul6G0LRyxSYfOGfGekB8a6LkRLX/oIvUOz/MZimU=;
        b=eKIewpFqwWTTbPiAQfHSbdLjBLdZKrBIC9kPgF/Nb9jv9tSI8clLwl2FQYG5Hm07/I
         JYWQIk3XATNCa3To+0kM+nYsqt5b7lplh/W8/CCq0zjFyIOFgLjdYGIlYTuHS2yqDW1m
         66J/ylVAt4rMyiIMCXKMH7Y2VUskyUzJTt1c/RrFVJNGNHjuaxswSkxqhN0cxoDchsAe
         8vahHjY3FaSfRaAg1nVs4P5iU7OgmAW3I8N8S3DH5lK8p/2SXrgJ1xcxCNouw800VQhI
         +MXeR+ZPjzK40pEy6T8LxI3kt4qUTPVF+OZuXoPkvU/R13RUomJkdW077S7RFxPtCrsG
         CLiQ==
X-Gm-Message-State: AA+aEWYgNXO8aDFs+eEaCoAJNM/+YXN8zEX+V8ao3T5OAoOhjTBZlohO
        1TUFIItcPBkikN4TP1o46Bk=
X-Google-Smtp-Source: AFSGD/UPUN9NYllZDUk1K1WGJWLIwN8A2sk5X6L6aPbV+yqYraoOnTjG2QMuIVlyrMsOZ4VgYHkVLg==
X-Received: by 2002:adf:9071:: with SMTP id h104-v6mr3253152wrh.65.1542643330753;
        Mon, 19 Nov 2018 08:02:10 -0800 (PST)
Received: from szeder.dev (x4db04f16.dyn.telefonica.de. [77.176.79.22])
        by smtp.gmail.com with ESMTPSA id e7-v6sm30674094wra.10.2018.11.19.08.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 08:02:09 -0800 (PST)
Date:   Mon, 19 Nov 2018 17:02:07 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 1/2] commit-graph write: add progress output
Message-ID: <20181119160207.GU30222@szeder.dev>
References: <CACsJy8A5tFxAaD-OqNNvMmX+KnbmW=O7JCCBbY-5dZa8Ta7QYg@mail.gmail.com>
 <20180917153336.2280-2-avarab@gmail.com>
 <20181015165447.GH19800@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181015165447.GH19800@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ping?

We are at -rc0, this progress output is a new feature since v2.19.0,
and the numbers shown are still way off.


On Mon, Oct 15, 2018 at 06:54:47PM +0200, SZEDER Gábor wrote:
> On Mon, Sep 17, 2018 at 03:33:35PM +0000, Ævar Arnfjörð Bjarmason wrote:
> 
> > @@ -560,6 +563,9 @@ static int add_packed_commits(const struct object_id *oid,
> >  	off_t offset = nth_packed_object_offset(pack, pos);
> >  	struct object_info oi = OBJECT_INFO_INIT;
> >  
> > +	if (list->progress)
> > +		display_progress(list->progress, ++list->progress_done);
> 
> Note that add_packed_commits() is used as a callback function for
> for_each_object_in_pack() (with '--stdin-packs') or
> for_each_packed_object() (no options), i.e. this will count the number
> of objects, not commits:
> 
>   $ git rev-list --all |wc -l
>   768524
>   $ git rev-list --objects --all |wc -l
>   6130295
>   # '--count --objects' together didn't work as expected.
>   $ time ~/src/git/git commit-graph write
>   Finding commits for commit graph: 6130295, done.
>   Annotating commits in commit graph: 2305572, done.
>   Computing commit graph generation numbers: 100% (768524/768524), done.
> 
> (Now I also see the 3x difference in the "Annotating commits" counter
> that you mentioned.)
> 
> I see two options:
> 
>   - Provide a different title for this progress counter, e.g.
>     "Scanning objects for c-g", or "Processing objects...", or
>     something else that says "objects" instead of "commits".
> 
>   - Move this condition and display_progress() call to the end of the
>     function, so it will only count commits, not any other objects.
>     (As far as I understand both for_each_object_in_pack() and
>     for_each_packed_object() iterate in pack .idx order, i.e. it's
>     essentially random.  This means that commit objects should be
>     distributed evenly among other kinds of objects, so we don't have
>     to worry about the counter stalling for a long stretch of
>     consecutive non-commit objects.  At least in theory.)
> 
> 
> 
