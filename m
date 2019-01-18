Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 765641F453
	for <e@80x24.org>; Fri, 18 Jan 2019 22:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbfARWRw (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 17:17:52 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42727 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729865AbfARWRw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 17:17:52 -0500
Received: by mail-qt1-f195.google.com with SMTP id d19so16938713qtq.9
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 14:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vmdae9N3t3FhuspN63Q3jMSJkVWag6FPKVKqFzoTx1A=;
        b=n1KB6V+dbzIGnPNMqC6ysXfrH79pRo73GaSJR3OhPsql62hsvsz7e4C0qk2LFEUax+
         66B1fmL6LLMEn7gl1FsrjwRBtxUhDAapcGwvmjuNCAkrnRm6dunt2cHMVzb+fb3Gy2Pg
         uFQzWs4OkMuGMbCr64tzuO/HT/zJ9Hk61/h/RNGFxZr51rKEs8tDqG0QFuBDzfZbL7SX
         +QL8cVFbJp7ui6cjg9GGzaTY8V7wDOp/DuCvs8QJn53ZK71gJGdR6iLSbC2BgtFMxrj6
         jL3qNk9pbPdpObUKj3HwIhAmnfn5BK8izu5/OcxNnxcbAAsTllIJ9WYHcj6Asb4llmHu
         StBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vmdae9N3t3FhuspN63Q3jMSJkVWag6FPKVKqFzoTx1A=;
        b=dw7oWSTJRudcq3KF4oG9Rm5rWauzQn8Ni/iFQO+M0qpzxdDdao4RwIYrjN5KCK1v/f
         A4QFoqWjtsb0n18u46pjivrpocW5b2LYQ9WwDBE1LWPOWYE/rhRmgNPx80q0gfi083IT
         WxvsKCkS75rzfNrPecLpDjnvTi9IXNOYUzBCZes7RexKB5yemKum0Uxc00KTwlMjTApn
         YVGEt4Zud9L8NGnkE34Ph+emchEW2nL6GtSfXnvBr1wkg3Kifg9I+fPwZAO2N5gZF/K4
         4E4jz5SmOI4U+XYWumvOf3qf1JZ7fhrD8tXoGjc4tM+ZbhVHhghXJbFZIpLKx9ca1rIi
         BzmA==
X-Gm-Message-State: AJcUukdNLDzwg19U4OlGH9nw3nrtafOdr5ng4k/g0eQjb+5aFmED1BFm
        nOjjBWSw/T+0XAcbGi2CBYEpZ5uzNOxvWSs8W3w=
X-Google-Smtp-Source: ALg8bN7Diwu1UNlMgw3JISaoteAgI6hAzBtt/wSCXjKN8ItNr76F5YJLkxoBzREcl+/Z+QvlhnFyLUR+7AMRwb1u3wo=
X-Received: by 2002:a0c:fa8f:: with SMTP id o15mr17635378qvn.135.1547849870708;
 Fri, 18 Jan 2019 14:17:50 -0800 (PST)
MIME-Version: 1.0
References: <20190106002619.54741-1-nbelakovski@gmail.com> <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190106002619.54741-2-nbelakovski@gmail.com> <xmqq5zv09vns.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq5zv09vns.fsf@gitster-ct.c.googlers.com>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Fri, 18 Jan 2019 14:17:24 -0800
Message-ID: <CAC05386ZxQsCPAV+nEXr2LJv-y48qL+YT3E+wg2T8Pf0fPRDsQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] ref-filter: add worktreepath atom
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 7, 2019 at 10:20 AM Junio C Hamano <gitster@pobox.com> wrote:
> When seeing a tag or note ref, by definition that's not something we
> can have checked out in any worktree.  I wonder if it is worth to
> optimize further by omitting this lookup when ref is not a local
> branch?
>
> IOW, with a typical number of worktrees and refs, how costly would ...
>
> > +     hashmap_entry_init(&entry, strhash(ref->refname));
> > +     lookup_result = hashmap_get(&ref_to_worktree_map, &entry, ref->refname);
>
> ... this sequence of calls be.
>

It certainly wouldn't be free. Every check would compute the hash of
the refname and do a lookup into the hash table. If the bucket it
looked up was empty that'd be it, but if it were non-empty a few more
comparisons would happen.

I think avoiding this would be check, we can simply check ref->kind ==
FILTER_REFS_BRANCHES ahead of calling into get_worktree_path and
provide an empty string otherwise.

> >               free_array_item(array->items[i]);
> >       FREE_AND_NULL(array->items);
> >       array->nr = array->alloc = 0;
> > +     if (worktrees)
> > +     {
>
>
> What's the point of ref_array_clear()?  ...  If that
> is the case, then the added code breaks that hope, as it leaves a
> dangling pointer in the worktrees variable.
>

Discussion of the point of ref_array_clear would be out of scope of
this change, but your point is well taken that setting worktrees to
NULL would be consistent with the rest of the function. Will
implement.
