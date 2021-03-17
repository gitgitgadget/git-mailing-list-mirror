Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1871C433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 17:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A025F64F17
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 17:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhCQRzN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 13:55:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55597 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbhCQRym (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 13:54:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DCEDA84D9;
        Wed, 17 Mar 2021 13:54:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fiabnFcW03iR8O0xVhTM5PFPWEA=; b=VCbHt+
        yxPsF/recQCj/zA5vyxlempTeWy1QJaX0l3zaaIxnZMUKlpWJ0fm1RByK6sQUDof
        UvUJuOHA+d9y08JnLFlKGbqQo2OD7lM/fxNbCa1h6SArJwV4lM2468BCzs0aHSLD
        5//I4uisi0wmW7ZxIeVIZTpWvJAqGNhgsqp7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EskACJjwgiH9kjEN3LxrZbYrANJwWpa2
        H15PiHWg2hY6lR7tN9+c3k0rrK41qyM7QPIpEaFAeKuhNcoeV3/mzgEqxhHVvKMm
        2F0ijViX6Sj8MJJUDKIUsePpx+CVozoRtGv42S4zQOPFxKs66dH/jMjo1LdWfXXw
        sFQUOjzRl9c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54E8BA84D7;
        Wed, 17 Mar 2021 13:54:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C0475A84D6;
        Wed, 17 Mar 2021 13:54:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/7] test-tool.h: ASCII-sort list of functions
References: <cover.1615856156.git.liu.denton@gmail.com>
        <b817541c2754ec8fc4edc1ae774e460912e7c0a8.1615856156.git.liu.denton@gmail.com>
Date:   Wed, 17 Mar 2021 10:54:41 -0700
In-Reply-To: <b817541c2754ec8fc4edc1ae774e460912e7c0a8.1615856156.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 15 Mar 2021 17:56:23 -0700")
Message-ID: <xmqqczvxy8bi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D99AB3BA-8749-11EB-87B1-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> The list of test-tool functions have, over time, gotten slightly out of
> ASCII order. Sort this list to bring them back into order.
>
> ASCII sorting was chosen over strict alphabetical order for the same
> reason as 805d9eaf5e (Makefile: ASCII-sort += lists, 2020-03-21): the
> purpose of maintaining the sorted list is to ensure line insertions are
> deterministic. By using ASCII ordering, it is more easily mechanically
> reproducible in the future, such as by using :sort in Vim.

Likewise.  The rationale 805d9eaf (Makefile: ASCII-sort += lists,
2020-03-21) applies better for Makefile's "X += <name>" as the
prefix before the <name> are all common, while in the header files,
you have to depend on their return type being the same and '('
sorting before '_'.

Now I am inclined to say that it may be worth mentioning in the log,
both for this step and the previous one.



> This patch is best viewed with `--color-moved`.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  t/helper/test-tool.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index 28072c0ad5..9856e84149 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -22,14 +22,15 @@ int cmd__example_decorate(int argc, const char **argv);
>  int cmd__fast_rebase(int argc, const char **argv);
>  int cmd__genrandom(int argc, const char **argv);
>  int cmd__genzeros(int argc, const char **argv);
> -int cmd__hashmap(int argc, const char **argv);
>  int cmd__hash_speed(int argc, const char **argv);
> +int cmd__hashmap(int argc, const char **argv);
>  int cmd__index_version(int argc, const char **argv);
>  int cmd__json_writer(int argc, const char **argv);
>  int cmd__lazy_init_name_hash(int argc, const char **argv);
>  int cmd__match_trees(int argc, const char **argv);
>  int cmd__mergesort(int argc, const char **argv);
>  int cmd__mktemp(int argc, const char **argv);
> +int cmd__oid_array(int argc, const char **argv);
>  int cmd__oidmap(int argc, const char **argv);
>  int cmd__online_cpus(int argc, const char **argv);
>  int cmd__parse_options(int argc, const char **argv);
> @@ -52,7 +53,6 @@ int cmd__run_command(int argc, const char **argv);
>  int cmd__scrap_cache_tree(int argc, const char **argv);
>  int cmd__serve_v2(int argc, const char **argv);
>  int cmd__sha1(int argc, const char **argv);
> -int cmd__oid_array(int argc, const char **argv);
>  int cmd__sha256(int argc, const char **argv);
>  int cmd__sigchain(int argc, const char **argv);
>  int cmd__strcmp_offset(int argc, const char **argv);
> @@ -62,8 +62,8 @@ int cmd__submodule_nested_repo_config(int argc, const char **argv);
>  int cmd__subprocess(int argc, const char **argv);
>  int cmd__trace2(int argc, const char **argv);
>  int cmd__urlmatch_normalization(int argc, const char **argv);
> -int cmd__xml_encode(int argc, const char **argv);
>  int cmd__wildmatch(int argc, const char **argv);
> +int cmd__xml_encode(int argc, const char **argv);
>  #ifdef GIT_WINDOWS_NATIVE
>  int cmd__windows_named_pipe(int argc, const char **argv);
>  #endif
