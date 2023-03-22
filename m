Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6B3C6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 22:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCVWqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 18:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCVWqe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 18:46:34 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8816E90
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 15:46:34 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id z16-20020a170902d55000b001a06f9b5e31so11555875plf.21
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 15:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679525193;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UAHTzhBSPBx2yJGV9Tjycwm3t4rYJ9tWD/YJxvlxOOo=;
        b=gRv1CQsFB70tfs1wfLVl3VG9gQcchXmIbmUWgeIUXXLSuug6bFtRZ/9cDJp6ym7n65
         112nQD13p9P2SWs1xhrHYUltu4yfU9lEounxpmABozMA6+9kuEEeL50kVxAmstau8+Y9
         rsXasDmSkK7fhUIvl1nVZeL1gmjWXvwf1AF6H2BVLJEp8/7hbN9OkuHzvmLV5PGYrF6N
         hVAr1Hr+qViof/HNlGv3AfrPD9R3zjwcfRBPEXlUyKvUnfPqGgbCJTCkCxZ6DKBBzr/H
         gGl0pLDLxuHDKC5YP7lkF1YBcH69+3lBtPtK5cQUieOpmYHsEKM0KFpcDZ5YCYBN76y1
         f0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679525193;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UAHTzhBSPBx2yJGV9Tjycwm3t4rYJ9tWD/YJxvlxOOo=;
        b=XNj6WSxW61UgWPxi/4UQv0Ccjx99Shh6n2sTdDdbTp8czu0CZoDUy8DIQ80FiB7nPE
         LY3fS4W+53QLJnGMBFe92bBQTNn8fRG7pSO0ioRDBHHVrrTbIv0uf1gIwmL6SatM5LFU
         WCo+/3U7lHYyALbGVjF3lqGTiTxrkqsWC7I1VKcdTbo4ShkA80mQ9SuuyKBXKVDWj5lk
         cQsxBizkNTLBQUjIPvVVgIJvCl+Eh8H90rQ7QsxDeK15UcyZCfIpxE+J/4v8mGZ/jBDo
         w0bBCpJVNtVRySeniK+9wOYB2QeXRzGoouH2eol3vGR1PV2Ay2jT1iE56ZEBMNE5RnNz
         98zg==
X-Gm-Message-State: AAQBX9eXSqqCha+/IeNedgxF6IPOICy3HUsrkzAm9axUTy/8fWTRp9JO
        UWF3OEGZ4VfU2xtE9+Jg5j07TO/ATukrqw==
X-Google-Smtp-Source: AKy350YEhCjUMtroInIdHfptCe61Gs7UUW3ox5iEaURE9vq0DmUDsyq3yHvF2uLz575v9bLhkfsR+l2HCC86NQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:90a:e004:b0:240:c40:f325 with SMTP id
 u4-20020a17090ae00400b002400c40f325mr962110pjy.4.1679525193534; Wed, 22 Mar
 2023 15:46:33 -0700 (PDT)
Date:   Wed, 22 Mar 2023 15:46:23 -0700
In-Reply-To: <patch-02.17-1b1fc5d41f5-20230317T152724Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com> <patch-02.17-1b1fc5d41f5-20230317T152724Z-avarab@gmail.com>
Message-ID: <kl6ledpge75s.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 02/17] cocci: fix incorrect & verbose "the_repository" rules
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Every time I try to read cocci and spatch docs, I'm impressed at how
impenetrable they are ;) Nevertheless, I'd still like to understand how
the pattern works. I'll take a stab in the dark, and perhaps you can
correct me.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason         <avarab@gmail.com> writes:

> +(
> +- read_object_file
> ++ repo_read_object_file
> +|
> +- has_object_file
> ++ repo_has_object_file
> +|
> +- has_object_file_with_flags
> ++ repo_has_object_file_with_flags
> +|
> +- parse_commit_internal
> ++ repo_parse_commit_internal
> +|
> +- parse_commit
> ++ repo_parse_commit
> +|
> +- get_merge_bases
> ++ repo_get_merge_bases
> +|
> +- get_merge_bases_many
> ++ repo_get_merge_bases_many
> +|
> +- get_merge_bases_many_dirty
> ++ repo_get_merge_bases_many_dirty
> +|
> +- in_merge_bases
> ++ repo_in_merge_bases
> +|
> +- in_merge_bases_many
> ++ repo_in_merge_bases_many
> +|
> +- get_commit_buffer
> ++ repo_get_commit_buffer
> +|
> +- unuse_commit_buffer
> ++ repo_unuse_commit_buffer
> +|
> +- logmsg_reencode
> ++ repo_logmsg_reencode
> +|
> +- format_commit_message
> ++ repo_format_commit_message
> +)

I assume that `|` characters in parentheses are a logical OR, and each
of the expressions checks for the `-` side in the original and replaces
it with the `+` side.

> +  (
> ++ the_repository,
> +  ...)

Then this is another expression that matches literal `()` after the
previous expression? `+the_repository` adds `the_repository` right after
the opening `(`, then leaves the uninteresting `...` in place.

If so, I don't know how cocci/spatch tells the difference between
literal `()` vs an expression in the syntax (preceding whitespace?).

Either way, as Elijah said, your plain explanation is clear enough that
I feel comfortable with this.

> --=20
> 2.40.0.rc1.1034.g5867a1b10c5
