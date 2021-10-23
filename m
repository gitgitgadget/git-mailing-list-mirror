Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919ADC433F5
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 21:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6154260F25
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 21:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhJWVD4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 17:03:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52658 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbhJWVDz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 17:03:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E004FE67B;
        Sat, 23 Oct 2021 17:01:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WHJ9NO+y4Pe/CqmfjINCjLVEnULIQD93O2LZay
        0/Zbs=; b=RHSovyaFLgQUIUxLMTiw45N01fVb3ZIRjaJ97mMfdjgwc7bJ5KUZdy
        wlXypNLhKgwHxtzn3B17lTklpS9oCnfJJJO2lAUQdZX05p6OM5OIlgfaxL0ATUT5
        90aAWTXiwnO/Y0SoA90PaSibmXv5KfovX1LAA42QF8VgQEf2KAkm4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6559DFE67A;
        Sat, 23 Oct 2021 17:01:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C0AA5FE679;
        Sat, 23 Oct 2021 17:01:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] MyFirstContribution: teach to use "format-patch
 --base=auto"
References: <20211022064044.28761-1-bagasdotme@gmail.com>
Date:   Sat, 23 Oct 2021 14:01:33 -0700
In-Reply-To: <20211022064044.28761-1-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Fri, 22 Oct 2021 13:40:46 +0700")
Message-ID: <xmqqlf2jbglu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67F3D4BE-3444-11EC-B11C-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> From: Junio C Hamano <gitster@pobox.com>
>
> Let's encourage first-time contributors to tell us what commit they
> based their work with the format-patch invocation. As the example
> already forks from origin/master and branch.autosetupmerge by
> default records the upstream when the psuh branch was created, we
> can use --base=auto for this.  Also, mention to the readers that the
> range of commits can simply be given with `@{u}` if they are on the
> `psuh` branch already.
>
> As we are getting one more option on the command line, and spending
> one paragraph each to explain them, let's reformat that part of the
> description as a bulletted list.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> [Bagas Sanjaya: fix grammar in commit message and explain `auto` value]
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>


Hmph, the log message changes, relative to what is queued, look like
so:

    Let's encourage first-time contributors to tell us what commit they
    based their work[-on-] with the format-patch invocation. As the example
    already forks from origin/master and branch.autosetupmerge by
    default records the upstream when the psuh branch was created, we
    can use --base=auto for this.  Also, mention {+to the readers+} that
    the range of commits can simply be given with `@{u}` if they are on the
    `psuh` branch already.

    As we are getting one more option on the command line, and spending
    one paragraph each to explain them, let's reformat that part of the
    description as a bulletted list.

Contributors will tell us what commit they based their work on, and
removal of "on" does not look like fixing grammar to me (it looks
more like breaking).  Adding "to the readers" is not _wrong_ per-se,
but given that everything you write in the documentation is telling
to the readers and to nobody else, it does not seem to add anything.
It is something different from "fix grammar".

In short, I do not think anything needs to be changed in the
proposed log message in the version that has been queued.

> + . The `--base=auto` option tells the command to record the "base
> +   commit", on which the recipient is expected to apply the patch
> +   series. The `auto` value will cause `format-patch` to track
> +   the base commit automatically, which is the merge base of tip
> +   commit of the remote-tracking branch and the specified
> +   revision range.

Everything after "The `auto` value will..." is new and is a welcome
addition, as I agree that giving a brief explanation of the option
is a good idea.  Thanks for highlighting the careless addition I
made in the original version.

But use of verb "track" in the format-patch documentation that was
copied to this patch should be fixed first.  format-patch does not
change any history and it does not track anything.  Perhaps "track"
-> "compute", e.g.

    The `auto` value will cause `format-patch` to compute the base
    commit automatically, which is the merge base of tip commit of the
    remote-tracking branch and the specified revision range.

And the matching correction to the existing documentation should
look like the attached patch.

Thanks.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
Subject: [PATCH] format-patch (doc): clarify --base=auto

What --base=auto tells format-patch is to compute the base commit
itself, using the tracking information.  It does not make anything
track anything.

Tighten the phrasing so that it won't be copied and pasted to other
places.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-format-patch.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git c/Documentation/git-format-patch.txt w/Documentation/git-format-patch.txt
index fe2f69d36e..113eabc107 100644
--- c/Documentation/git-format-patch.txt
+++ w/Documentation/git-format-patch.txt
@@ -689,10 +689,10 @@ You can also use `git format-patch --base=P -3 C` to generate patches
 for A, B and C, and the identifiers for P, X, Y, Z are appended at the
 end of the first message.
 
-If set `--base=auto` in cmdline, it will track base commit automatically,
-the base commit will be the merge base of tip commit of the remote-tracking
+If set `--base=auto` in cmdline, it will automatically compute
+the base commit as the merge base of tip commit of the remote-tracking
 branch and revision-range specified in cmdline.
-For a local branch, you need to track a remote branch by `git branch
+For a local branch, you need to make it to track a remote branch by `git branch
 --set-upstream-to` before using this option.
 
 EXAMPLES

