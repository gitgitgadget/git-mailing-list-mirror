Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 715C01F404
	for <e@80x24.org>; Thu, 19 Apr 2018 21:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753473AbeDSVGW (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 17:06:22 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:38710 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753187AbeDSVGV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 17:06:21 -0400
Received: by mail-ua0-f194.google.com with SMTP id q38so4377570uad.5
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 14:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PWw3JMBpP+KlI22Cd/EAD/JGLKFnHdXDV2wKVv6WN0w=;
        b=snEyHhvedi7oIL6GkbKmWm1X617sTykmNXTA4EqhS/fAKow843415tt1Zb51iJQTyt
         TpvMsp/D7nOFxakA2pzYpZ8FiudrjtR5AQq93/PcK1zoX58ObM3P8vb2vexO+X7wG358
         uxnQ6PCpEEttQtsAoUlaDADGnlqKDb8Sy5p0uqwUVrxKKW50vHKyjS/IfCzT9FIIfz0Q
         dtF8Zxie6vf5TH6+67/pjhT2L4XIVspr2fqVJWkajpmrV/ImBH+xBD0Frhhjac0Yt7MJ
         snU3a5KuAfb6rQjc6rcvvkew8AgkV58ePcQOlcs2d0dy6GrQZWy0zeXzKqb6T9OxeZLd
         uhug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PWw3JMBpP+KlI22Cd/EAD/JGLKFnHdXDV2wKVv6WN0w=;
        b=N3u84a5boNDpQTY8EPiLDOLPe2JdJYSu5tqSJnKvk7yvXlflG0v34hVlgwUm7teHIt
         /Ed6+WHAtPBXE/HKBm1fNpSmL1NC8dewt2V5d5yajog3By/vWHMRuRhaUv7iY6r7d8ns
         0g6sD8w8s1Ia3lp+6VTiRE7FPmStRj4kxIw/G1YExQm6vg9+vbQ7c6pCPUG3fFOu/y23
         0JI2ao9hVO+Wu9fVs4Jf21uxQeWrt8MN47z4xaTAas0dMqkMjSzif5IOKtoo66eOpvj1
         zBJBMAtD4Ini0jcNSLdsCkbge+9QoONR8b3i9Q/dq3XgZXg3GZZ+SpQaL0diGZX7a1Gm
         vQwQ==
X-Gm-Message-State: ALQs6tBwtP+X9xV3ipAcutHb1djQZmiWTxSjU6UQz1mmK1zM3/86zEaD
        myrwUyf1CCWcsDAS1cyHUVJ73sG9xIbyhzNUbuk=
X-Google-Smtp-Source: AIpwx48D2I/pa/Ympo66eZW8X/weUhmR4PloOV2wiBRzMu/ZL/UfC6gyZ2GpZAYVizBrZltKSxUjAc0SE2HtXNtW3ZI=
X-Received: by 10.176.30.132 with SMTP id o4mr5842892uak.154.1524171980134;
 Thu, 19 Apr 2018 14:06:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Thu, 19 Apr 2018 14:06:19 -0700 (PDT)
In-Reply-To: <CAN0heSrSn1wYGoRD6+c_Jk+rAUTbY94JLspwfiki6z4h=mnPSQ@mail.gmail.com>
References: <20180419175823.7946-1-newren@gmail.com> <20180419175823.7946-26-newren@gmail.com>
 <CAN0heSrSn1wYGoRD6+c_Jk+rAUTbY94JLspwfiki6z4h=mnPSQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 19 Apr 2018 14:06:19 -0700
Message-ID: <CABPp-BHTVx40_Azdk1fh9ydc10FvP6sAasPNLc7y8UH3=_nBpg@mail.gmail.com>
Subject: Re: [PATCH v10 25/36] merge-recursive: fix overwriting dirty files
 involved in renames
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 19, 2018 at 1:48 PM, Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
> On 19 April 2018 at 19:58, Elijah Newren <newren@gmail.com> wrote:
>> This fixes an issue that existed before my directory rename detection
>> patches that affects both normal renames and renames implied by
>> directory rename detection.  Additional codepaths that only affect
>> overwriting of dirty files that are involved in directory rename
>> detection will be added in a subsequent commit.
>>
>> Reviewed-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  merge-recursive.c                   | 85 ++++++++++++++++++++++-------
>>  merge-recursive.h                   |  2 +
>>  t/t3501-revert-cherry-pick.sh       |  2 +-
>>  t/t6043-merge-rename-directories.sh |  2 +-
>>  t/t7607-merge-overwrite.sh          |  2 +-
>>  unpack-trees.c                      |  4 +-
>>  unpack-trees.h                      |  4 ++
>>  7 files changed, 77 insertions(+), 24 deletions(-)
>>
>> diff --git a/merge-recursive.c b/merge-recursive.c
>> index c1c4faf61e..7fdcba4f22 100644
>> --- a/merge-recursive.c
>> +++ b/merge-recursive.c
>> @@ -337,32 +337,37 @@ static void init_tree_desc_from_tree(struct tree_d=
esc *desc, struct tree *tree)
>>         init_tree_desc(desc, tree->buffer, tree->size);
>>  }
>>
>> -static int git_merge_trees(int index_only,
>> +static int git_merge_trees(struct merge_options *o,
>>                            struct tree *common,
>>                            struct tree *head,
>>                            struct tree *merge)
>>  {
>>         int rc;
>>         struct tree_desc t[3];
>> -       struct unpack_trees_options opts;
>>
>> -       memset(&opts, 0, sizeof(opts));
>> -       if (index_only)
>> -               opts.index_only =3D 1;
>> +       memset(&o->unpack_opts, 0, sizeof(o->unpack_opts));
>> +       if (o->call_depth)
>> +               o->unpack_opts.index_only =3D 1;
>>         else
>> -               opts.update =3D 1;
>> -       opts.merge =3D 1;
>> -       opts.head_idx =3D 2;
>> -       opts.fn =3D threeway_merge;
>> -       opts.src_index =3D &the_index;
>> -       opts.dst_index =3D &the_index;
>> -       setup_unpack_trees_porcelain(&opts, "merge");
>> +               o->unpack_opts.update =3D 1;
>> +       o->unpack_opts.merge =3D 1;
>> +       o->unpack_opts.head_idx =3D 2;
>> +       o->unpack_opts.fn =3D threeway_merge;
>> +       o->unpack_opts.src_index =3D &the_index;
>> +       o->unpack_opts.dst_index =3D &the_index;
>> +       setup_unpack_trees_porcelain(&o->unpack_opts, "merge");
>>
>>         init_tree_desc_from_tree(t+0, common);
>>         init_tree_desc_from_tree(t+1, head);
>>         init_tree_desc_from_tree(t+2, merge);
>>
>> -       rc =3D unpack_trees(3, t, &opts);
>> +       rc =3D unpack_trees(3, t, &o->unpack_opts);
>> +       /*
>> +        * unpack_trees NULLifies src_index, but it's used in verify_upt=
odate,
>> +        * so set to the new index which will usually have modification
>> +        * timestamp info copied over.
>> +        */
>> +       o->unpack_opts.src_index =3D &the_index;
>>         cache_tree_free(&active_cache_tree);
>>         return rc;
>>  }
>
> As mentioned in a reply to patch 33/36 [1], I've got a patch to add
> `clear_unpack_trees_porcelain()` which frees the resources allocated by
> `setup_unpack_trees_porcelain()`. Before this patch, I could easily call
> it at the end of this function. After this, the ownership is less
> obvious to me.

I wouldn't put the call to clear_unpack_trees_porcelain() at the end
of this function, but rather at the end of merge_trees().
merge_trees() is the only caller of git_merge_trees() and it continues
using o->unpack_opts until the end of that function.  At the end of
that function, there is no further need for o->unpack_opts.
Basically, put it right where I put the "FIXME: Need to also free data
allocated by setup_unpack_trees_porcelain()" comment.
