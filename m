Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 143A41F463
	for <e@80x24.org>; Fri, 13 Sep 2019 18:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388516AbfIMSDn (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 14:03:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64983 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387935AbfIMSDm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 14:03:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C017A2F365;
        Fri, 13 Sep 2019 14:03:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2MBQog860IMC6WkWdqyePMKVCjc=; b=kyBY1n
        jkmHLmmgyQGxIiUWMu/1AO1quu0BoqEMds6oxqDZwSe8sz13UX16oAegRebynVva
        t8Unavql7RNZrpf2UsUCj/y/vFsW/Yurqx1B2iV+xtwvFu9r+32tLuU4b/vlerO/
        ryhDmyoLCc/tDcfvhtSvCJ7wH4Fw7jKyHImpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dlJN9WXqR4yno2RpmpKP39HaGe4o0bpx
        4qgmjmTjGMSucgW2m9Su5ysCFqURPmYvghgrc1j0W3RxByfum0CnuDPM6s6Jh5vo
        R9PcBsYzifHNlcoGLBBzovgZnf9zacHZP0XLQr1ZBoYOeu1mwxSA81bdFll7AreT
        Ruu/2PvO8r8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B7AAD2F364;
        Fri, 13 Sep 2019 14:03:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 20EEA2F362;
        Fri, 13 Sep 2019 14:03:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] git-submodule.txt: fix AsciiDoc formatting error
References: <796a25ee1e9a9c0421d42ab6644e81d23a9bd99b.1568142486.git.liu.denton@gmail.com>
Date:   Fri, 13 Sep 2019 11:03:39 -0700
In-Reply-To: <796a25ee1e9a9c0421d42ab6644e81d23a9bd99b.1568142486.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 10 Sep 2019 12:09:18 -0700")
Message-ID: <xmqqk1acdqf8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0DEF2BE-D650-11E9-BC6E-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Remove surrounding parentheses so that the "index term" syntax is not
> triggered (and because it looks nicer without them anyway ;) ).

"Correct" always trumps "nicer", though ;-)

The $USAGE string in the script describes the available options to
this subcommand like so:

    or: $dashless [--quiet] set-branch (--default|--branch <branch>) [--] <path>

which is, "you can give either --default or --branch <branch>, but
not both".  What the original, if there were no special meaning in
double-paren, meant to say seems to (almost) match that.

> -set-branch ((-d|--default)|(-b|--branch <branch>)) [--] <path>::

I say "almost", as it gives a wrong impression that you can give
"-b" without "<branch>" X-<.

Now what does the updated text say to us?

> +set-branch (-d|--default)|(-b|--branch <branch>) [--] <path>::

I think the attempt to cram the short-form is unnecessarily
cluttering and making the result incorrect.  How about doing
something like this instead?

 Documentation/git-submodule.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 0ed5c24dc1..816baa7dd0 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -173,10 +173,12 @@ submodule with the `--init` option.
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
 --
-set-branch ((-d|--default)|(-b|--branch <branch>)) [--] <path>::
+set-branch (--default|--branch <branch>) [--] <path>::
 	Sets the default remote tracking branch for the submodule. The
-	`--branch` option allows the remote branch to be specified. The
-	`--default` option removes the submodule.<name>.branch configuration
+	`--branch` option (or its short-form, `-b <branch>`)
+	allows the remote branch to be specified. The
+	`--default` option (or its short-form, `-d`)
+	removes the submodule.<name>.branch configuration
 	key, which causes the tracking branch to default to 'master'.
 
 summary [--cached|--files] [(-n|--summary-limit) <n>] [commit] [--] [<path>...]::
