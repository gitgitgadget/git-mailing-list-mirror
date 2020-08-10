Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A443C433DF
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 16:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C0CF20838
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 16:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t3bjYNRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgHJQSt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:18:49 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50724 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgHJQSt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 12:18:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 469EFEB726;
        Mon, 10 Aug 2020 12:18:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VAxruYglf0XymhlW2g943FDCexA=; b=t3bjYN
        RsZ8xhAoGlXD/XV9bWaIudJcnln96XJEVcDPYffUPEn86b10geQA/fxjZGGuINdT
        On3gLQMkC4BSlk+lbgsLK/ci+mGR+8bLByx8PumnuAiTwkYYd7zaSXEmx00tqOaG
        xvHBnzggDyfU8n+6jjvFHAur9okgSSU5849ow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Akddu6rANjpEzc+S67ouif6KL/FQQB6r
        +Ur3QeRs4QqgR9p5an33/eO5Svr7aLHnMBJN/nP9/GOL5q/ytNtn6HZ2Sx1qTlwH
        PtK/6NdWNGw2NG2XQD8NVz8w8ROwUOkvsmCZ9SWmUrmETvxC/3RbxTEe3JQaAV6P
        /oRC8arlxSk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3EE24EB724;
        Mon, 10 Aug 2020 12:18:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 83B75EB723;
        Mon, 10 Aug 2020 12:18:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Raymond E. Pasco" <ray@ameretat.dev>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] git-apply.txt: correct description of --cached
References: <C4RO9JSUGPKG.2UQX61X628B6P@ziyou.local>
        <20200810110338.52203-1-ray@ameretat.dev>
Date:   Mon, 10 Aug 2020 09:18:41 -0700
In-Reply-To: <20200810110338.52203-1-ray@ameretat.dev> (Raymond E. Pasco's
        message of "Mon, 10 Aug 2020 07:03:38 -0400")
Message-ID: <xmqqeeoecw4e.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28F395C0-DB25-11EA-8D3F-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Raymond E. Pasco" <ray@ameretat.dev> writes:

> The blurb for "--cached" says it implies "--index", but in reality
> "--cached" and "--index" are distinct modes with different behavior.
>
> Remove the sentence "This implies `--index`." to make the description
> accurate.
>
> Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
> ---
>  Documentation/git-apply.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
> index b9aa39000f..373a9354b5 100644
> --- a/Documentation/git-apply.txt
> +++ b/Documentation/git-apply.txt
> @@ -72,7 +72,7 @@ OPTIONS
>  --cached::
>  	Apply a patch without touching the working tree. Instead take the
>  	cached data, apply the patch, and store the result in the index
> -	without using the working tree. This implies `--index`.
> +	without using the working tree.

The updated text is not wrong per-se, but I have a feeling that this
is barking up a wrong tree.  The implication is probably referring
to the fact that "--index" does certain verification and "--cached"
does the same (i.e. the patch must be applicable to what is in the
index).  We may want to update the description for both options.

How about simplifying them like this, perhaps?

 Documentation/git-apply.txt | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index b9aa39000f..92b5f0ae22 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -58,21 +58,18 @@ OPTIONS
 --check::
 	Instead of applying the patch, see if the patch is
 	applicable to the current working tree and/or the index
-	file and detects errors.  Turns off "apply".
+	file and detects errors.  Turns off `--apply`.
 
 --index::
-	When `--check` is in effect, or when applying the patch
-	(which is the default when none of the options that
-	disables it is in effect), make sure the patch is
-	applicable to what the current index file records.  If
-	the file to be patched in the working tree is not
-	up to date, it is flagged as an error.  This flag also
-	causes the index file to be updated.
+	Apply the patch to both the contents in the index and in the
+	working tree.  It is an error if the patched file in the
+	working tree is not up to date.
 
 --cached::
-	Apply a patch without touching the working tree. Instead take the
-	cached data, apply the patch, and store the result in the index
-	without using the working tree. This implies `--index`.
+	Apply the patch only to the contents in the index but not to
+	the working tree.  It is OK if the contents in the index
+	and in the working tree are different, as the latter is
+	never looked at.
 
 --intent-to-add::
 	When applying the patch only to the working tree, mark new
