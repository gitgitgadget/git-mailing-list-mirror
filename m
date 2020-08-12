Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903FAC433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 00:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 350152076C
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 00:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OAnb/hsG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgHLAHD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 20:07:03 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58335 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgHLAHC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 20:07:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 09DC7F6B94;
        Tue, 11 Aug 2020 20:07:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=thZLOKJVvJsA4EZnzqdt66Kq4lw=; b=OAnb/h
        sGCDHdln5pHzPU/qsDZiCIU08hy6FDwUZw3rv+rlQVv/JMuYKhcA/YhjspG/Zv8x
        r2RF3AFYZURk+sh+iXaIRQ1RbSKjMN+gmQu4Xu3qudRmdJoGc5gMfSDr47HJ+9bV
        1hzUhsT8+wdb82LHQ3pjyYe5tyA1IuPd0H0bQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M0RRUfHdTeu3Ki6ASyl4Hi4yyObY1kGk
        WyKD8Q11ZQPduVbKpyvAcBKCWuiQQV2L0x1uBFIKf8BXRbpImnAkAcNlvsmtJ6Fo
        Pi5Kzzi+0byiRQ5rr+p0VWbAUak0xbEvj6OAR2a4+i+8fPG23S0E6niDAJwQmb6J
        r0x/ylpi/kk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E3C77F6B93;
        Tue, 11 Aug 2020 20:07:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 257A8F6B91;
        Tue, 11 Aug 2020 20:06:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH  2/3] doc/git-log: describe --diff-merges=off
References: <20200805220832.3800-1-sorganov@gmail.com>
        <20200805220832.3800-3-sorganov@gmail.com>
Date:   Tue, 11 Aug 2020 17:06:56 -0700
In-Reply-To: <20200805220832.3800-3-sorganov@gmail.com> (Sergey Organov's
        message of "Thu, 6 Aug 2020 01:08:31 +0300")
Message-ID: <xmqq8sek917j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD0EC6A2-DC2F-11EA-98DF-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  Documentation/git-log.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index 9ccba65469d7..f3727c786453 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -145,7 +145,6 @@ combined-diff option or with `--no-diff-merges`).
>  	rename or copy detection have been requested).
>  
>  -m::
> ---diff-merges::

Shouldn't this "--diff-merges" be removed from here?  As [1/3]
updated it like so:

-	} else if (!strcmp(arg, "-m") || !strcmp(arg, "--diff-merges")) {
+	} else if (!strcmp(arg, "-m")) {
 		revs->ignore_merges = 0;
+	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
+		if (!strcmp(optarg, "off")) {
+			revs->ignore_merges = 1;
+		} else {
+			die(_("unknown value for --diff-merges: %s"), optarg);
+		}
+		return argcount;

"git log --diff-merges" would get either an "option --diff-merges
requires a value" error from diff.c::parse_long_opt(), or an
"unknown value for --diff-merges: <opt>" error from the above code.

Other than that, I think 1&2/3 looks good, and we've covered the
tests with 3/3 already, so we are in a reasonably good shape.

Thanks.


>  	This flag makes the merge commits show the full diff like
>  	regular commits; for each merge parent, a separate log entry
>  	and diff is generated. An exception is that only diff against
> @@ -153,6 +152,11 @@ combined-diff option or with `--no-diff-merges`).
>  	in that case, the output represents the changes the merge
>  	brought _into_ the then-current branch.
>  
> +--diff-merges=off::
> +--no-diff-merges::
> +	Disable output of diffs for merge commits (default). Useful to
> +	override `-m`, `-c`, or `--cc`.
> +
>  :git-log: 1
>  include::diff-options.txt[]
