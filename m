Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A6611F463
	for <e@80x24.org>; Wed, 18 Sep 2019 00:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfIRAfm (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 20:35:42 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:35157 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfIRAfm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 20:35:42 -0400
Received: by mail-vk1-f196.google.com with SMTP id d66so1157132vka.2
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 17:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=59hefivkyE5UjUWh8EGnZr4xfMqRXEcr+rTLhCgzUVg=;
        b=kItP6/cGlYGfduaZV+6BFl5GfICYeA2xau5qZDYaoIwYP2BkysF6UVhK1SJNQ2NLEH
         VYYCUeWuOwzLffcFtMlCSfTjTb35mK6KYXFGoiQzwbHHrc4K9wvkoE7bJ+i0S8b5px3G
         rhkZPSyEVq5j8TTrSTZWl1AO+4MiuDzEC52cE87FYGhUveTEKt4j5fsKUHNyhJOQEdcD
         TNtEj8WjnhuMGxYucppp0HXHSMaf8TQ9vzhHJqvbpCVkv38wfPk1JlPCc7p0xViGZDJN
         EFD2Tln4yeDZUF/w39t07f+SOuzSd+DMy80Hh0B+zdmeCDawr+U3nNiA0lniu9kAarSk
         N2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=59hefivkyE5UjUWh8EGnZr4xfMqRXEcr+rTLhCgzUVg=;
        b=DMoz4X7wrhq/jdoPE+QU2WqDCcVbJgisOJUguhc0FYWELkiv+9YRXIBPavWupRnIEe
         vdRlIviy1pd04IxqXDc5des/LlUhVLDw6JScB8bNmTWbGZUs72LM3d1/5VMbLq7h8430
         87HlSDu2t8BQUEJkucszAl09gXYA7MjvvRRuv7aKXEOYzYRNQg82UrjylwU9j9tpC3H3
         xRhaMm5YIZDCrm9+dDaxvc9MFio/MOibRrv87aiDeleOt1nT4PYs/CaCc0ZrwDxCST9X
         CUn9mIlMePMxyb0XBgJ/bMmoJ6iQrs1Q2npK52983yvkkWEpIvT3UbHCikITvnCtMYqI
         NbsA==
X-Gm-Message-State: APjAAAXZ+WgBDl6UXq0BdSwQwkQBg5kONtVST5VHRXFNDyz14gCmoJtR
        nDtUuU+/wci8yCtpQdC6R5HCNlGEei/kBgpbycA=
X-Google-Smtp-Source: APXvYqzjtuZHef0fqh9Y9KBqeTVrSPb0dZawfka41xhw9q5/9di803Hm3ZS1SP5APV/eWOaPfUVfuKORkqlVwy5cuAE=
X-Received: by 2002:a1f:b987:: with SMTP id j129mr764063vkf.27.1568766939605;
 Tue, 17 Sep 2019 17:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BHpXWF+1hKUTfn8s-y4MJZXz+jUVS_K10eKyD6PGwo=gg@mail.gmail.com>
 <20190917215040.132503-1-jonathantanmy@google.com>
In-Reply-To: <20190917215040.132503-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 17 Sep 2019 17:35:28 -0700
Message-ID: <CABPp-BEXjZCOOuDS4b1bajYvE-T0NVw32YCRMi9Ks8TikPhORg@mail.gmail.com>
Subject: Re: [RFC PATCH] merge-recursive: symlink's descendants not in way
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Tue, Sep 17, 2019 at 2:50 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> When the working tree has:
>  - foo (symlink)
>  - foo/bar (directory)
>
> and the user merges a commit that deletes the foo symlink and instead
> contains:
>  - foo (directory)
>  - foo/bar (file)
>
> the merge should happen without requiring user intervention. However,
> this does not happen.
>
> In merge_trees(), process_entry() will be invoked first for "foo/bar",
> then "foo" (in reverse lexicographical order). process_entry() correctly
> reaches "Case B: Added in one", but dir_in_way() states that "bar" is
> already present as a directory, causing a directory/file conflict at the
> wrong point.

I don't think the notes about hitting the "Case B: Added in one"
codepath help; that's only one codepath that calls dir_in_way(), and
I'm pretty sure with a little work we could trigger the same bug with
the other ones.

> Instead, teach dir_in_way() that directories under symlinks are not "in
> the way", so that symlinks are treated as regular files instead of
> directories containing other directories and files. Thus, the "else"
> branch will be followed instead: "foo/bar" will be added to the working
> tree, make_room_for_path() being indirectly called to unlink the "foo"
> symlink (just like if "foo" were a regular file instead). When
> process_entry() is subsequently invoked for "foo", process_entry() will
> reach "Case A: Deleted in one", and will handle it as "Add/delete" or
> "Modify/delete" appropriately (including reinstatement of the previously
> unlinked symlink with a new unique filename if necessary, again, just
> like if "foo" were a regular file instead).

I was trying to think of a way to summarize it a bit, and then Junio
later in the thread came in and provided a different and compatible
way to view the issue that summarizes it quite nicely:

"In any case, if the working tree has 'foo' as a symlink, Git should
not look at or get affected by what 'foo' points at."

We can probably make the commit message pretty concise using that
wording or something similar.  Maybe adding something like "In
particular, the presence of a symlink should be treated much the same
as the presence of a file; since dir_in_way() is only checking to see
if there is a directory in the way, we don't want symlinks in leading
paths to sometimes cause dir_in_way() to return true."

>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Thanks to Elijah for his help. Some of the commit message is based on
> his explanation [1].
>
> I'm finding this relatively complicated, so I'm sending this as RFC. My
> main concern is that whether all callers of dir_in_way() are OK with its
> behavior change, and if yes, how to explain it. I suspect that this is
> correct because dir_in_way() should behave consistently for all its
> callers, but I might be wrong.

Yes, we want all callers of dir_in_way() to get this change; if they
don't, I'm pretty sure with some work we could devise special
scenarios that exhibit the same bug.



Thanks for working on this,
Elijah
