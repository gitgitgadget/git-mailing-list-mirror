Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346C6C433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 17:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA9BF61A1F
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 17:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237197AbhCXRlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 13:41:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52692 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237232AbhCXRky (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 13:40:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B82CBE294;
        Wed, 24 Mar 2021 13:40:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kE8QTlE5UrdkUDld1WweXh9T8u4=; b=bcQeKP
        K6bv3J4EICozXgYpICS6ilkTOijBNDVC1NkAFnRx16B79nCXA0KtoYS1BKXztN+L
        jy6GKh+vzcfDSBpzwvTVtZGe8aFDJmcpbvg2mAO17WyTOYKANDik0o9IAlmJvfEG
        bfNGanrMRwbldPepV62iVSiLYB/g/tI+JxKlA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NUdscxMzr3YhOnXsjJo9KtDDOPDSd9b4
        xd2GqW/Pd+XfNUDhKi7CyLQ7xFAd6S4LLnKLig49YcQdTpPHWCWnzZfhWlu6rzhk
        KC7DrIDlUhWjXZxFn6hU/diltIrohzUNNqnca6ADbUsm0fAS8K2qsIUVzmtM8XTq
        IMDxomuYmY0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3014BE293;
        Wed, 24 Mar 2021 13:40:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7C764BE292;
        Wed, 24 Mar 2021 13:40:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] git-format-patch: Include diff-generate-patch
 documentation
References: <20210324123027.29460-1-bagasdotme@gmail.com>
        <20210324123027.29460-2-bagasdotme@gmail.com>
Date:   Wed, 24 Mar 2021 10:40:52 -0700
In-Reply-To: <20210324123027.29460-2-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Wed, 24 Mar 2021 19:30:26 +0700")
Message-ID: <xmqqeeg4zbyz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14CD37F4-8CC8-11EB-9181-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> diff-generate-patch explains format of generated patch for text files.

That is true, but that does not justify this change.  In other
words, the sentence does not explain why is it a good idea to
describe the itty bitty details of what is in the format-patch
output (which is more for the consumption of somebody other than the
user who is running the format-patch command).

> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/git-format-patch.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 3e49bf2210..247033f8fc 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -718,6 +718,13 @@ use it only when you know the recipient uses Git to apply your patch.
>  $ git format-patch -3
>  ------------
>  
> +GENERATED DIFF FORMAT
> +---------------------
> +git-format-patch emits diff in generated patches. For text files, the
> +diff format is described as below:
> +
> +include::diff-generate-patch.txt[]
> +

I suspect that, rather than adding a new section, it would be a
better change to extend what the first parapgraph of the Description
says.

The current text says something called "patch" is prepared one for
each commit, it is suitable for e-mail submission, and "am" is the
command to use it, but does not say what that "patch" really is.
The description in the page also refers to "three-dash" line, but
that is totally unclear unless the reader is given a more detailed
overview of what the "patch" the first paragraph refers to (and
diff-generate-patch.txt will not be the place to talk about it).

In other words, something like this one.

----- >8 ----- ----- >8 ----- ----- >8 ----- ----- >8 ----- ----- >8 -----
From: Junio C Hamano <gitster@pobox.com>
Date: Wed, 24 Mar 2021 10:35:40 -0700
Subject: [PATCH] format-patch: give an overview of what a "patch" message is

The text says something called a "patch" is prepared one for each
commit, it is suitable for e-mail submission, and "am" is the
command to use it, but does not say what the "patch" really is.  The
description in the page also refers to "three-dash" line, but that
is totally unclear unless the reader is given a more detailed
overview of what the "patch" the first paragraph refers to.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-format-patch.txt | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 3e49bf2210..3db0e036d8 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -36,11 +36,28 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Prepare each commit with its patch in
-one file per commit, formatted to resemble UNIX mailbox format.
+Prepare each commit with its "patch" in
+one "message" per commit, formatted to resemble a UNIX mailbox.
 The output of this command is convenient for e-mail submission or
 for use with 'git am'.
 
+A "message" generated by the command consists of three parts:
+
+* A brief metadata header that begins with `From <commit>`
+  with a fixed `Mon Sep 17 00:00:00 2001` datestamp to help programs
+  like "file(1)" to recognize that the file is an output from this
+  command, fields that record the author identity, the author date,
+  and the title of the change (taken from the first paragraph of the
+  commit log message).
+
+* The second and subsequent paragraphs of the commit log message.
+
+* The "patch", which is the "diff -p --stat" output (see
+  linkgit:git-diff[1]) between the commit and its parent.
+
+The log message and the patch is separated by a line with a
+three-dash line.
+
 There are two ways to specify which commits to operate on.
 
 1. A single commit, <since>, specifies that the commits leading
-- 
2.31.0-464-gadc53f61d7

