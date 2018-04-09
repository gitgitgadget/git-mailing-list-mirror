Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E77CC1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 22:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeDIWGI (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 18:06:08 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:42766 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbeDIWGH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 18:06:07 -0400
Received: by mail-io0-f195.google.com with SMTP id d5so11459059iob.9
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 15:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=4TLDDhLcHJ3vaolzSK+BcIE8KYWAE6X19bPCW2RGISI=;
        b=VlIxUdhRTsqpcmBQyKkuSjCeB2XYh59+KYXHHkA2ct7uvPDJ6RCnSuWdnCvSZoPUxY
         DbxtrZv9Yf2g1KtjwtAm6vaxRAZs8/REugDr9csJ3+1E2X857QcsvJLrXyVadmnSA7mW
         AxD/irZ21nTJuZjUVOHjnjvHtcBEWJizQpdlE4TUIi1mOTmfUT+DTWiuoPQQqUehQwBF
         AdkJPhGZX8B2ZY0ROO3BYpsWqXN1U2twIGx4tReplva/nIARdQYMWBzUSVbTL/QxgA/y
         bNh1rw+NJG470Z6KNdH5biGozbGJEnLCq2/+AkqzLWwZyeTM46Dm7Wf3qi2VKIQZxjQ7
         XFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=4TLDDhLcHJ3vaolzSK+BcIE8KYWAE6X19bPCW2RGISI=;
        b=fqHNB97TIqhltGTpKo/RU7uaUGkoM+i/biGMHM/P29kpa1L8AFo7rXUp/77klDz65y
         HG1s67pp5uLtNQ8hs33sfYovD8Li84DXWtRkDJ6ipO3Z1EudVQSSAsor9bt7c8pP8dO6
         x3/cJ3X3b9IWUQMUeJ7PEnT9+rxhUju+qYyc1LBxaNSDCkqdLBE7IQuJGO85UqMF+eoy
         NEDDKoL/1IyObXduDu5v99KSV6F+jIdf5aagjOzDBSAdzemzYN/cjzS8b3gygKlHnlji
         Q7PWQme9CNnTvVtiDx+XKfe2gBaqDf0SQjxESd4MenzYX+uKnhg5eDq1+dPdXmtKC74n
         /+qQ==
X-Gm-Message-State: ALQs6tAuoMXk7ZJhA1f8K4m2u/9iM+ZGWTaVkOxlGVpxFzsUsmjp+3lo
        KMqvjiNJMfwkwXwJ36a7M1a0PX2KtuZUrUpfwpE=
X-Google-Smtp-Source: AIpwx49T2rr433PmeNSJAoS4tTUIFwQF+MDO9pUYgex7tTSTLwdXtUIvsbpXoUkPWqJO60IvcImxnLrswE/lxtkP9S4=
X-Received: by 10.107.12.230 with SMTP id 99mr730733iom.117.1523311567075;
 Mon, 09 Apr 2018 15:06:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Mon, 9 Apr 2018 15:06:05 -0700 (PDT)
In-Reply-To: <20180409193007.GL2629@hank>
References: <20180325134947.25828-1-t.gummerer@gmail.com> <20180331151804.30380-1-t.gummerer@gmail.com>
 <CAPig+cQ8VzDycUMo-QOexNDBgQGEGj2BPmPa-Y0vhGCt_brbhg@mail.gmail.com> <20180409193007.GL2629@hank>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 9 Apr 2018 18:06:05 -0400
X-Google-Sender-Auth: _7nNivKXhX6KVXlberK8LH3D1CQ
Message-ID: <CAPig+cRXsir3siZ5eArk6k1mF9kaDfFe1mL+T9faR6dxSUez7w@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] worktree: teach "add" to check out existing branches
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 9, 2018 at 3:30 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> On 04/08, Eric Sunshine wrote:
>> As with Junio, I'm fine with this hidden option (for now), however, I
>> think you can take this a step further. Rather than having a (hidden)
>> git-reset option which suppresses "HEAD is now at...", instead have a
>> (hidden) option which augments the message. For example,
>> --new-head-desc="New worktree" would make it output "New worktree HEAD
>> is now at...". Changes to builtin/reset.c to support this would hardly
>> be larger than the changes you already made.
>
> Something else I just noticed that may make this a worse solution is
> that this breaks the sentence in two pieces for translators.  I guess
> we could somehow get the "New worktree" part of the option translated,
> but that still means that if some language would require to move parts
> of the sentence around that would be less than ideal for translation.

Good point.

One solution would be to have the new hidden option replace the string
entirely: --new-head-msg="New worktree HEAD is now at %s", which would
allow translators to deal with the entire sentence. Even clearer would
be to drop "now", as in "New worktree HEAD is at %s". (Default in
reset.c would still be "HEAD is now at %s", of course.)

Another solution would be not to augment the "HEAD is now at..."
message at all. I realize that that augmentation was one of the
original motivations for this patch series, but with the upcoming
restoration of the "Preparing worktree" message:

    Preparing worktree (_branch disposition_)
    HEAD is now at ...

it seems clear enough (at least to me) from the context introduced by
the "Preparing..." message that "HEAD is now at..." refers to HEAD in
the worktree. (But that's just my opinion.)

> Would factoring out what we have in 'print_new_head_line()' into some
> common code, maybe in 'pretty.c', and still doing the printing from
> here be a reasonable tradeoff?

Isn't that getting uglier again? Not only would you have to publish
that function, but you'd still need the hidden git-reset
--show-new-head-line option.

Also, you'd end up calling that function from within low-level worker
worktree.c:add_worktree(), thus making it take on UI duties, which
would be nice to avoid if possible. (Unfortunately, the alternate idea
of having worktree.c:add() handle this UI task doesn't quite work
since add_worktree() doesn't return sufficient information for add()
to know whether or not it should print "HEAD is now at..."; however,
add_worktree() could be augmented to return more information.)

So, I don't presently have a good answer. I'm partial to the idea of
not augmenting "HEAD is now at...", partly because context makes it
relatively clear that it applies to the new worktree and partly
because it's simpler (less implementation work for you) to leave it as
is. If that choice isn't desirable, then next best would be for
--new-head-msg= to replace the entire "HEAD is now at..." string
rather than augmenting it.
