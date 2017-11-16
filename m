Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22E34201C8
	for <e@80x24.org>; Thu, 16 Nov 2017 01:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933224AbdKPBWz (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 20:22:55 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:45542 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932650AbdKPBWx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 20:22:53 -0500
Received: by mail-qt0-f175.google.com with SMTP id n32so22789055qtb.2
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 17:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KBFa3rsRGmMo3P7ezStz1P11+KSQpqI6hMcl3AKzsEE=;
        b=H+cmJ5yL2PB9/ztieDMb4uh3A4OLWXMxsby7fZuDdkqw8Jzd6rAkB89eoep1qQXEp1
         MZuNWJjcUbq1mVzJb62yxM3IqdmfB/RBfuP8OoeP/alEo1RRaaO9rH9EQtTPTigdFd3i
         ZuPjQDcPZj/Hbj1Ow1K2FO02nMl3hBkxK6RFQNjPT4ABaBXLKvUiOo0kYYduwNsPT0+4
         iB/LN2xDNQ4+302yjwmXnZijvaSPBe8iPNCMT5ZszLmVdk8ywiQkwFWFkjelso0PMcmk
         Ly3JNbuBLgyc2TyeJosYwUeuD2lR7ZH9A1DI6a7WpGmQ+3q7X211M0gHR0h2I+9ozWDN
         ANQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KBFa3rsRGmMo3P7ezStz1P11+KSQpqI6hMcl3AKzsEE=;
        b=V3OMI1RNvVIdq1HHCEF014Ai+yYBKl8lpgX5Uq7bORN92017JqoY3MeqL7/sGffQ4E
         IbCm67ztnmoAlZ26YclKiBFCnFRyMmrqG8kscuG61ToSXB/dRQo3iGbkXCyGVdDl2tfz
         DrmpmyQttIRVt5FU4ts3qwQJ/0p+TAd8Qr929vxhD81VR9Gc0Ldq6zHlmvQgiAY4B6mn
         XauBEzwng7ls0X3cbDsrHCB/6u9Y7HQn6qG4DqzXt/GV6t1Y1EOtyak5JTO6jo6TVH+F
         gmBxUXnWT5zeco8zPvnGFJwYB8bC+1j14MD9c38zuSDKRMixKIP8bSIoa2UIGEug6c6y
         povA==
X-Gm-Message-State: AJaThX6izvLHM+schN8jMIxIaeuaGFTXNZIEodgaKvc81S3/iYOwv84e
        2ZTTxkfjmnxB5xYLK79dQCmJieSs/sMkLG5/+gvMbnGcfXo=
X-Google-Smtp-Source: AGs4zMZycnWEy4IgCevua3Ef/KtgALcjFMvRDweGPznpUJQeLxbkbx3jfaebnKE+66gDZntn2zw+MAO8Ao/vBAhWRck=
X-Received: by 10.55.119.70 with SMTP id s67mr20043221qkc.45.1510795372907;
 Wed, 15 Nov 2017 17:22:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.96.118 with HTTP; Wed, 15 Nov 2017 17:22:51 -0800 (PST)
In-Reply-To: <20171114175207.f23d492045d52b8aa16c00be@google.com>
References: <20171115003043.24080-1-sbeller@google.com> <20171115003043.24080-8-sbeller@google.com>
 <20171114175207.f23d492045d52b8aa16c00be@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Nov 2017 17:22:51 -0800
Message-ID: <CAGZ79kaum5py=14kdFy1a+K_0MzfaD5boYStixh=1aY2tUCV-Q@mail.gmail.com>
Subject: Re: [PATCHv4 7/7] builtin/describe.c: describe a blob
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 14, 2017 at 5:52 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Tue, 14 Nov 2017 16:30:43 -0800
> Stefan Beller <sbeller@google.com> wrote:
>
>> The walking is performed in reverse order to show the introduction of a
>> blob rather than its last occurrence.
>
> The code as implemented here does not do this - it instead shows the last
> occurrence.

fixed to show the first occurrence.

>
>>  NAME
>>  ----
>> -git-describe - Describe a commit using the most recent tag reachable from it
>> +git-describe - Describe a commit or blob using the graph relations
>
> I would write "Describe a commit or blob using a tag reachable from it".

using a ref, as we also can use refs.
I think 'the graph' is technically correct here, but may be too confusing.

>
>> +If the given object refers to a blob, it will be described
>> +as `<commit-ish>:<path>`, such that the blob can be found
>> +at `<path>` in the `<commit-ish>`. Note, that the commit is likely
>> +not the commit that introduced the blob, but the one that was found
>> +first; to find the commit that introduced the blob, you need to find
>> +the commit that last touched the path, e.g.
>> +`git log <commit-description> -- <path>`.
>> +As blobs do not point at the commits they are contained in,
>> +describing blobs is slow as we have to walk the whole graph.
>
> I think some of this needs to be updated?

fixed.

>
>> +static void process_object(struct object *obj, const char *path, void *data)
>> +{
>> +     struct process_commit_data *pcd = data;
>> +
>> +     if (!oidcmp(&pcd->looking_for, &obj->oid) && !pcd->dst->len) {
>> +             reset_revision_walk();
>> +             describe_commit(&pcd->current_commit, pcd->dst);
>> +             strbuf_addf(pcd->dst, ":%s", path);
>> +             pcd->revs->max_count = 0;
>> +     }
>> +}
>
> Setting max_count to 0 does not work when reverse is used, because the
> commits are first buffered into revs->commits (see get_revision() in
> revision.c). There doesn't seem to be a convenient way to terminate the
> traversal immediately - I think setting revs->commits to NULL should
> work (but I didn't check). Remember to free revs->commits (using
> free_commit_list) first.

This does work indeed.

>
>> +test_expect_success 'describe a blob at a tag' '
>> +     echo "make it a unique blob" >file &&
>> +     git add file && git commit -m "content in file" &&
>> +     git tag -a -m "latest annotated tag" unique-file &&
>> +     git describe HEAD:file >actual &&
>> +     echo "unique-file:file" >expect &&
>> +     test_cmp expect actual
>> +'
>
> This is probably better named "describe a blob at a directly tagged
> commit".

ok

>  (Should we also test the case where a blob is directly
> tagged?)

We do a bad job at describing tags that point at a blob currently:

  git tag test-blob HEAD:Makefile
  git describe test-blob
error: object cd75985991f4535c45e2589222a9e6a38fb1d613 is a blob, not a commit
fatal: test-blob is not a valid 'commit' object

This series changes this to

  git describe test-blob
  v2.15.0-rc0-43-g54bd705a95:Makefile

which might not be expected (you'd expect "test-blob"),
so I think I can write a test telling that this is suboptimal
behavior?

>
>> +test_expect_success 'describe a blob with its last introduction' '
>> +     git commit --allow-empty -m "empty commit" &&
>> +     git rm file &&
>> +     git commit -m "delete blob" &&
>> +     git revert HEAD &&
>> +     git commit --allow-empty -m "empty commit" &&
>> +     git describe HEAD:file >actual &&
>> +     grep unique-file-3-g actual
>> +'
>
> The description is not true: firstly, this shows the last occurrence,
> not the last introduction (you can verify this by adding another commit
> and noticing that the contents of "actual" changes), and what we want is
> not the last introduction anyway, but the first one.

fixed.
