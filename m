Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54E271FADF
	for <e@80x24.org>; Tue,  9 Jan 2018 01:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756577AbeAIBYq (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 20:24:46 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39727 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752960AbeAIBYn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 20:24:43 -0500
Received: by mail-oi0-f66.google.com with SMTP id r63so9456740oia.6
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 17:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1Mf5JTcqZVSpD/P+GxaZPZ0NcLzvc0cUgIQUMCF8kH8=;
        b=TxCDaK5m6KcVHU/ZFO6Tai9d660BGJ2w0eH/JanCtvgAdwj+sELEMp73JPpqgA91tJ
         AcudTFZnmYCVhzxESJ6+c6uGT3OdtptLFZaQLfWWAc8SXIIWE69BkR1z71FKoM/HInEq
         zX7Eo4EaedieGuJ9nV4R37rNEgaJJrTz1/UgXGHJFMnCuW5xUwAQRWGu4YwhvkTbn3S2
         XhihBoSXiHyzuLCSv7o3H06qjK7goURwkYwIg+XZBMzmmEO+GP2xqL4tS6KO87MiFZqt
         OKVFtFczWpj2Jb4o61LV6BKKj2251UX3ICA4vs209ki9o+s4hD/0kByojDBva81rHAHk
         1ZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1Mf5JTcqZVSpD/P+GxaZPZ0NcLzvc0cUgIQUMCF8kH8=;
        b=TCe/a7k+ae8QsnONRPhpbtoN7GYz9nZyD73c5IVOwlhoAW/pewcMowPHiQM/Aoe9wA
         BL6birdWsn6q8Tynxuh61xPSsbyewr1Tji99EpmPPc3r5EOuoOQzKLDr51l0PcIDi2uj
         E/OpG0Xp8aDJtXYL0LQ7gnXsZ7XasipuqqvIj/hv7jbUxSpwsV82nFYRPW5bW8ckPtEO
         P0cYrjzdZyu8yN5Tpj2TWITnizS2q9vqNV5rqbMvc3GTLi93fwkEP16CLwZsr+p41RJS
         Tq17EsujbnmA098uRX13rJByaR2pFIbce87T633T7JtBINvTCqz2TeM2LzBDmDdtXhaO
         QTRg==
X-Gm-Message-State: AKwxytcdkg+ZgQ+QGWigSRjiASvF8cNEE4hzYNre2vBvGDcXyW6RPKAu
        /7g5KK6Ju3IQoqHakobTY8QYlN4w//xvLa6DQHw=
X-Google-Smtp-Source: ACJfBou3yOCS44M6se1MxKNhHawVkyvrjYVQ6odh0EbQqIAPPbBNO+3PlShR1D5EOcthYZrRB9/bESbdkmwcTJMBOoE=
X-Received: by 10.202.68.2 with SMTP id r2mr1289939oia.351.1515461082396; Mon,
 08 Jan 2018 17:24:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Mon, 8 Jan 2018 17:24:11 -0800 (PST)
In-Reply-To: <20180108233840.GB156560@google.com>
References: <20171217225122.28941-1-t.gummerer@gmail.com> <20180107223015.17720-1-t.gummerer@gmail.com>
 <20180107223015.17720-2-t.gummerer@gmail.com> <CACsJy8DBkAwoNWSma-+WkOUkQrenbkT5c1-Ez2jmmf-+wGRbxQ@mail.gmail.com>
 <20180108233840.GB156560@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 9 Jan 2018 08:24:11 +0700
Message-ID: <CACsJy8AkbMdQZq85N_LSvkM+JN4E2mkEUfaHHGTvrNJ4yCPs2Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] read-cache: fix reading the shared index for other repos
To:     Brandon Williams <bmwill@google.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 9, 2018 at 6:38 AM, Brandon Williams <bmwill@google.com> wrote:
> On 01/08, Duy Nguyen wrote:
>> On Mon, Jan 8, 2018 at 5:30 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> > @@ -1896,16 +1895,17 @@ int read_index_from(struct index_state *istate, const char *path)
>> >                 split_index->base = xcalloc(1, sizeof(*split_index->base));
>> >
>> >         base_sha1_hex = sha1_to_hex(split_index->base_sha1);
>> > -       base_path = git_path("sharedindex.%s", base_sha1_hex);
>> > +       base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_sha1_hex);
>>
>> Personally I prefer the repo_git_path() from v2 (sorry I was away and
>> could not comment anything). The thing is, git_path() and friends
>> could do some path translation underneath to support multiple
>> worktrees. Think of the given path here as a "virtual path" that may
>> be translated to something else, not exactly <git_dir> + "/" +
>> "sharedindex.%s". But in practice, we're not breaking the relationship
>> between $GIT_DIR/index and $GIT_DIR/sharedindex.* any time soon, doing
>> manual path transformation here is fine.
>
> My biggest complaint about v2 is that we still don't quite know the best
> way to integrate worktrees and struct repository yet so I was very
> reluctant to start having them interact in the way v2 was using them
> together.

This will be on my todo list (after I have finished with
nd/worktree-move which has been on 'pu' for too long). I'm ok with v3
then.

> I'm very much in favor of this version (v3) as each worktree
> can explicitly provide their gitdir to be used to determine where to
> read the shared index file without having to replicate a struct
> repository for each.

Isn't that the end goal though (I vaguely recall this discussion when
'struct repository' was an idea), that we will pass struct repository
around [1] rather than relying on global objects.

[1] or in this case struct worktree-something because the index
belongs more to a worktree than the object/refs database.

>> What about the other git_path() in this file? With patch applied I still get
>>
>> > ~/w/git/temp $ git grep git_path read-cache.c
>> read-cache.c:           shared_index_path = git_path("%s", de->d_name);
>> read-cache.c:   temp = mks_tempfile(git_path("sharedindex_XXXXXX"));
>> read-cache.c:                         git_path("sharedindex.%s",
>> sha1_to_hex(si->base->sha1)));
>> read-cache.c:           const char *shared_index = git_path("sharedindex.%s",
>>
>> I suppose submodule has not triggered any of these code paths yet. Not
>> sure if we should deal with them now or wait until later.
>>
>> Perhaps if we add a "struct repository *" pointer inside index_state,
>> we could retrieve back the_repository (or others) and call
>> repo_git_path() everywhere without changing index api too much. I
>> don't know. I like the  'struct repository' concept but couldn't
>> follow its development so I don't if this is what it should become.
>
> I'm not too keen on having an index_state struct contain a back pointer
> to a repository struct.  I do think that we may want to have worktree
> structs contain a back pointer to the struct repository they correspond
> to.  That way there is only one instance of the repository (and
> object-store once that gets integrated) yet multiple worktrees.

Yeah back pointer from worktree struct makes sense.
-- 
Duy
