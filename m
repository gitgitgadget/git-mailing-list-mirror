Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1327CC4338F
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 07:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2E0860462
	for <git@archiver.kernel.org>; Sun, 15 Aug 2021 07:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbhHOHIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Aug 2021 03:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbhHOHIq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Aug 2021 03:08:46 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1358C061764
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 00:08:16 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id v16so4551681ilo.10
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 00:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=NgroJKDo6BnrtmrRpLQNzfpZiEvbZOJOt4vghpmw04g=;
        b=YzFikBVRh6Fe22Uhgf6TpAFxUQ6rFLonDzaJbzaiqC/rjU8ly5TDHZsoAsOyEEaLD/
         +5RO5OoOTBjXyWSBBedtddk9q/p6VzbKo6gVA+blZxLpKMdwxv0gmDNR3i0hvT/uZWv5
         PqHhwFs1d4A7E7CCz0tUbTPVewkr5JsSX2XdieLvcgRrceNd1YqeSLbmrv7omaFTfaUx
         nQkbHCmjENcu2oTq+WG3mv3G/+7FP58II1L4uitdrg2njxC1PjWmK8I969dVRkq7suE/
         x4Ck44Nfu2F74NiZ67WEb4y6XJ2U5MhNyho7sF6P/5haUS89J/voM99hQKVK60jZjDb3
         AChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=NgroJKDo6BnrtmrRpLQNzfpZiEvbZOJOt4vghpmw04g=;
        b=tOl82v1/7ilvGktavqtZCLxj4cXabYITeQJH+MLLlRVj1iYMpc/id9oiZmQugVOFd1
         9CKiKqh7Cd0Y35VnIX2gNR63XHsnAZ7qkX0iScXGjbE4FTrwzlMTvKhZNnUJrebudraa
         T1QibCsOEBBsroZ53/yCfiWu5lPKXJOxoD6u0nS1DcdFB4D8VB3h7jReLnH+2VuqoyWh
         gVCreAvtvGhQvIOySj40ntltFjkIFBt3B+SQphw/bapvmkZyemL2vDB52WtR1FOzSxsB
         tgDm2/bYlSPC+35HQn8y/jnokTh6h1F6TW9JkDKoTNRYxqBVRPAat9ihjhEhOeB9GP22
         cV0g==
X-Gm-Message-State: AOAM530/hNJGBq0OkWF1FV/mAmNvTO+n+PIMiOcMqpCe2vAfAIYFvHFW
        zntMlVLAvuTlSJhYHjrYcAB0eQlLVLo/dztI6nLxJjsE8QOP6HeNd0w=
X-Google-Smtp-Source: ABdhPJxqN0lsmsyQYN9c72jtzwjmf6MhCSCqjwwGxcLHWN57BjO5KpW8ZN/MdtanF+ytp2ndjCbAMNXkaf1tb4zgIfw=
X-Received: by 2002:a05:6e02:5aa:: with SMTP id k10mr7582631ils.301.1629011295934;
 Sun, 15 Aug 2021 00:08:15 -0700 (PDT)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 15 Aug 2021 15:08:04 +0800
Message-ID: <CAOLTT8Q6f-B05bQ+XCDuGGk5KTS1o3QatGbeJ-FQiqFCYGW7Og@mail.gmail.com>
Subject: [GSoC] Git Blog 13
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My thirteenth week blog finished:
The web version is here:
https://adlternative.github.io/GSOC-Git-Blog-13/

### Project Progress

This week I continue to try to optimize the performance of `git
cat-file --batch`.

You can see them here:

```bash
git fetch git@github.com:adlternative/git.git cat-file-reuse-ref-filter-log=
ic
git rev-list  2c6ce95c82..8591897fbc
```

Or here:

[[PATCH 00/27] [GSOC] [RFC] cat-file: reuse ref-filter
logic](https://lore.kernel.org/git/pull.1016.git.1628842990.gitgitgadget@gm=
ail.com/)

Several of these commits are critical:

* 31acac9fde `[GSOC] ref-filter: remove second parsing in
format_ref_array_item`:
It use a `parsed_atom_list` to save the parsed state after
we calling verify_ref_format(), so we can reduce second
parsing in format_ref_array_item(), which brings 1.9%
performance improvement.
* 4602b62a92 `[GSOC] ref-filter: reuse finnal buffer if no
stack need`=EF=BC=9AIt can reduce some unnecessary copies,
which bring 2% performance improvement.

This time I made sure that there was not too much noise,
to ensure the stability of this performance test=EF=BC=9A

#### Test Examples=EF=BC=9A
* upstream/master: `5d213e46bb (tag: v2.33.0-rc2, upstream/master) Git 2.33=
-rc2`
* 898e36a92b (before performance optimization): `898e36a92b [GSOC]
cat-file: re-implement --textconv, --filters options`
* this tree (after performance optimization): `8591897fbc (HEAD ->
cat-file-reuse-ref-filter-logic) [GSOC] ref-filter: add
need_get_object_info flag to struct expand_data`


#### Test Results=EF=BC=9A
```bash
$ GIT_PERF_REPEAT_COUNT=3D50  GIT_PERF_MAKE_OPTS=3D-j8 ./run
upstream/master . ./p1006-cat-file.sh

Test                                        upstream/master   this tree
---------------------------------------------------------------------------=
---------
1006.2: cat-file --batch-check              0.08(0.06+0.01)
0.08(0.07+0.01) +0.0%
1006.3: cat-file --batch-check with atoms   0.06(0.05+0.00)
0.07(0.06+0.01) +16.7%
1006.4: cat-file --batch                    0.48(0.45+0.03)
0.50(0.46+0.03) +4.2%
1006.5: cat-file --batch with atoms         0.47(0.43+0.03)
0.49(0.46+0.02) +4.3%

$ GIT_PERF_REPEAT_COUNT=3D50  GIT_PERF_MAKE_OPTS=3D-j8 ./run
upstream/master 898e36a92b ./p1006-cat-file.sh

Test                                        upstream/master   898e36a92b
---------------------------------------------------------------------------=
---------
1006.2: cat-file --batch-check              0.08(0.07+0.00)
0.09(0.09+0.00) +12.5%
1006.3: cat-file --batch-check with atoms   0.06(0.04+0.01)
0.07(0.05+0.02) +16.7%
1006.4: cat-file --batch                    0.48(0.44+0.03)
0.60(0.58+0.02) +25.0%
1006.5: cat-file --batch with atoms         0.47(0.44+0.02)
0.58(0.56+0.02) +23.4%
```

The performance of `git cat-file --batch-check` is very close
to `upstream/master`!

The performance difference of `git cat-file --batch` has also
changed from 25.0% to 4.2%!

This result is far better than my expectations, I have reason to
believe that the performance of `git cat-file --batch` can be
improved again!

Good job!

I think the key to continuing to optimize is still to reduce unnecessary co=
pies.

### Additional advice

During the optimization process this week, I found that I might want
to use a `strbuf_move()` function, although I did not adopt it in my work
(because it did not allow my work to be greatly optimized), but I think it =
might
be useful in some situations: We don=E2=80=99t want to copy the data of str=
buf,
but just want to move its buf pointer:

```c
void strbuf_move(struct strbuf *sb, struct strbuf *sb2)
{
strbuf_release(sb);
*sb =3D *sb2;
strbuf_init(sb2, 0);
}
```

Yes, it's like `std::move()` in c++.
[std::move](https://en.cppreference.com/w/cpp/utility/move)
Maybe we can use strbuf_move() in some scenarios.

Thanks, Git!
--
ZheNing Hu
