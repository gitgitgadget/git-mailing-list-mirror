Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95946C43214
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 05:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 735EC60F35
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 05:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhHIF4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 01:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhHIF4k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 01:56:40 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237E1C0613CF
        for <git@vger.kernel.org>; Sun,  8 Aug 2021 22:56:19 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id y1so25972695iod.10
        for <git@vger.kernel.org>; Sun, 08 Aug 2021 22:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ljI4dcBvi3UCJdOdCZM/lI2WWxztrYACrFgKV2xYQk8=;
        b=vT/nsBBe49nwoghEkRoiWXcOQctZUkKrfvoM19Cr9UM3cwsQrKjdcKHkP2IpPXyuUc
         /8VEWmcskyon5H5lOj1zaAZ9weykXWz7FVYOLhYz9opHSo0VRkAcGzrPykCgRVrO1Vg4
         MZy54VbS7ycrRmSmLrnBMvP8hBXkXrssMQrKyNJQPzs2+ZHQnagverCAucgFPo5aV3Tx
         IC81AVmezXNU8cHonEUQuIhcpsXMxoOVaKcudN4FJgdGqfdpExIm5Bx3X4Nhuy+oy7BE
         S2+cFD8z/H14ZF93+Ofh9s/L5JbSdLZuT54SsTyUBMWyfR/E6zhLNti0fCq7dob/4jA0
         WLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ljI4dcBvi3UCJdOdCZM/lI2WWxztrYACrFgKV2xYQk8=;
        b=WQBWkHqBCpWT2+ch4cDu5LZOIcfFOmpH5YpmunzbWO7YVcDJcXt/O5NN2R5eC67/Zi
         YPvtfjNmtsyRx+enkZdptfj+ypzeAFaZdVzaTMWg/1U3H4cvW1AegmzckEYntTEzu5Hg
         ifWDYOt1l20MrrPZY3rKCMuUgGJA5iqQKX3r4EJvn56RpvwSyrHf9DC9z42MU6bFqzP7
         T1zjEDk2swp9su03R+abJZ4PxrWMfebDt1dvtOt3A4FPoYlumvdZIzyaDgoycRHtT3O5
         IfYLKHZRhTcxIv7rJ4ZHI6GziCsjg3ME7/56nO5IlamlyOCIxx8omU3ZCSkcqhlghgrW
         ov9w==
X-Gm-Message-State: AOAM5327rKplHtypZWH/XMuge43JryCVVziBZF965JCNhk1rSr7031X2
        rkV9MO6uUAqBgJzHRyL0m7Q3+p0jS6+Bz7ceqjRtZjUUWpMzcVog
X-Google-Smtp-Source: ABdhPJwPrEIUAnKhVxfPh/bQgc0L1HQ5tWObvgx+CDDQ/84LrbQPjdTutLXfMg620RoD2vE0DKY5z4NSLushTonVd7I=
X-Received: by 2002:a02:b047:: with SMTP id q7mr21371666jah.130.1628488577536;
 Sun, 08 Aug 2021 22:56:17 -0700 (PDT)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 9 Aug 2021 13:56:06 +0800
Message-ID: <CAOLTT8TYiUbXbkSTPY50jCU1bYP3JFx2P+hVmGL58S8V=AUMbA@mail.gmail.com>
Subject: [GSoC] Git Blog 12
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My twelfth week blog finished:
The web version is here:
https://adlternative.github.io/GSOC-Git-Blog-12/

## Week12 Avoid repetitive parsing

After we brought around `10%` optimization to `git cat-file --batch`
through skip
parse_object_buffer(), let's take a look at the result of gprof again:

```
  %
 time     calls(before)       calls(after)     name
  1.24               0              349756     format_ref_array_item
  1.24               0              349756     get_object
  0.83         4184784             4534690     do_xmalloc
  0.83               0             1399028     parse_ref_filter_atom
  0.41         4184936             5932565     memory_limit_check
  0.41          701711             1400412     strbuf_add
  0.41               0             1399024     append_atom
  0.41               0             1399024     quote_formatting
  0.41              14              349770     strbuf_init
  0.41               0              349756     populate_value
  0.00         2100807             2449753     strbuf_grow
  0.00         1973422             1973568     xmallocz
  0.00               0             1399024     get_ref_atom_value
  0.00               0             1399024     grab_values
  0.00              77              699589     xstrdup
  0.00              46              699558     xcalloc
```

gprof tells us that cat-file --batch will make a lot of copies by
`xstrdup()`, `strbuf_add()`... after
using the logic of ref-filter. But at present, the overhead of these
copies cannot be easily avoided
due to the inherent logic of ref-filter. So there are no good
optimization points in ref-filter ? We must
re-observe the whole problem from a macro perspective.

`oid_object_info_extended()` can get some metadata of the object, e.g.
`size`, `type`, `deltabase`,
then we can use `grab_common_values()` to grab them. And those data in
the content of the object
like commits' `tree-oid`, `parent-oid` or tags' `deref-oid`, which are
parsed by `parse_object_buffer()`,
then in `grab_tag_values()` or `grab_commit_values()`, we can grab
them. But many attributes of
commit and tag are not obtained through `parse_object_buffer()`, such
as `author-info` ,`commiter-info`,
`tagger-info` etc.

We need to call grab_sub_body_contents(), grab_person() to rescan the
buffer and extract the data.
What if we can combine these multiple scanning and parsing into one completion?
At least intuitively, this has an opportunity to improve performance.
So I check the implementation
details of `parse_commit_buffer()` and `parse_tag_buffer()`, maybe we
can pass some "hook pointer"
to these parsing functions like `oid_object_info_extended()` does to
extract only the information we need?
The commit-slab caught my attention. It can be used to get some
specified data content from the object.
I am thinking about whether it is possible to design a `struct
object_view` (temporarily called
`struct commit_view`) to store the offset of the parsed data in the
object content. `parse_commit_buffer()`
will check whether we need something for in-depth parsing. Like this:

```c
struct commit_view {
int need_tree : 1;
int need_parents : 1;

int need_author : 1;
int need_author_name : 1;
int need_author_email : 1;
int need_author_date : 1;

int need_committer : 1;
int need_committer_name : 1;
int need_committer_email : 1;
int need_committer_date : 1;

int tree_offset;
int tree_length;

int parents_nr;
int *parents_offset;
int *parents_length;

int author_offset;
int author_length;

int author_name_offset;
int author_name_length;
int author_email_offset;
int author_email_length;
int author_date_offset;
int author_date_length;

int committer_offset;
int committer_length;

int committer_name_offset;
int committer_name_length;
int committer_email_offset;
int committer_email_length;
int committer_date_offset;
int committer_date_length;
};

define_commit_slab(commit_view_slab, struct commit_view);
static struct commit_view_slab view_slab = COMMIT_SLAB_INIT(1, view_slab);

int parse_commit_buffer()
{
...
if (view->need_author) {
view->author_offset = bufptr - head;
view->author_length = ident_len;
}
if (view->need_author_name || view->need_author_email ||
    view->need_author_date) {
if (split_ident_line(&ident, ident_line, ident_len) ||
!ident.date_begin || !ident.date_end)
return error("bad author line in commit %s",
     oid_to_hex(&item->object.oid));
if (view->need_author_name) {
view->author_name_offset = ident.name_begin - head;
view->author_name_length = ident.name_end - ident.name_begin;
}
if (view->need_author_email) {
view->author_email_offset = ident.mail_begin - head + 1;
view->author_email_length = ident.mail_end - ident.mail_begin + 2;
}
if (view->need_author_date) {
view->author_date_offset = ident.date_begin - head;
view->author_date_length = ident.date_end - ident.date_begin;
}
}
...
}

```

It's still in WIP, hope it can bring some help!

There seems to be no tag-slab similar to commit-slab, do we need to invent it?

It seems that GSOC has only the last few weeks left, I'm not sure how
far this patch series is from
being merged by the master branch. Performance optimization may have
no end. By the way,
is there a chance to avoid a large number of copies in the ref-filter?
This may be another direction.

Thanks.
--
ZheNing Hu
