Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08E6C33CAA
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 23:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0D220718
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 23:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R0fZwDtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbgAWXCe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 18:02:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56070 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbgAWXCe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 18:02:34 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3162639CA7;
        Thu, 23 Jan 2020 18:02:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6PBiR3oFrgI9oNaIujh6Z3F+S/c=; b=R0fZwD
        tERo+2+uczNjbsLzdYsKHivOurrx3YU/ot/rx1slIPHsoYJncSZ0eZqR9Qspcgfh
        nmVBBoi/nmHBNFa6nLJBvYzdr9jtVkgyWt4E9PbmCFznWnFapVf0vui3tBxe65/t
        VL2TW06n+jAtQKmx1Bep9fPEOr5qbZB1FNI3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TtpXLAJfjtrHZ2OegRhwYJSLDS3UPl+4
        y8B2DAJMKcdK5Upf4j4K7MzLkMeJVW20Qncqn78ptfpjC37ys2qu8ko7S5/gd790
        4rgdbZLe52Z43ijH6M5zFqPXEejiascPrTpfBBISbz8shh5k6qsKx2aW6SFvSFlZ
        DXgwZkRhhcw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 281AA39CA4;
        Thu, 23 Jan 2020 18:02:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B5D939CA0;
        Thu, 23 Jan 2020 18:02:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/7] remote: clean-up by returning early to avoid one indentation
References: <cover.1579598053.git.bert.wesarg@googlemail.com>
        <59b97032fa158ccc9aee9d52b9cb969cd8df6a5f.1579598053.git.bert.wesarg@googlemail.com>
Date:   Thu, 23 Jan 2020 15:02:30 -0800
In-Reply-To: <59b97032fa158ccc9aee9d52b9cb969cd8df6a5f.1579598053.git.bert.wesarg@googlemail.com>
        (Bert Wesarg's message of "Tue, 21 Jan 2020 10:24:50 +0100")
Message-ID: <xmqqk15h3hfd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F5DB006-3E34-11EA-A456-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>
> ---
> Cc: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/remote.c | 86 +++++++++++++++++++++++++-----------------------
>  1 file changed, 44 insertions(+), 42 deletions(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 2830c4ab33..a8bdaca4f4 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -263,50 +263,52 @@ static const char *abbrev_ref(const char *name, const char *prefix)
>  
>  static int config_read_branches(const char *key, const char *value, void *cb)
>  {
> -	if (starts_with(key, "branch.")) {
> -		const char *orig_key = key;
> -		char *name;
> -		struct string_list_item *item;
> -		struct branch_info *info;
> -		enum { REMOTE, MERGE, REBASE } type;
> -		size_t key_len;
> -
> -		key += 7;
> -		if (strip_suffix(key, ".remote", &key_len)) {
> -			name = xmemdupz(key, key_len);
> -			type = REMOTE;
> -		} else if (strip_suffix(key, ".merge", &key_len)) {
> -			name = xmemdupz(key, key_len);
> -			type = MERGE;
> -		} else if (strip_suffix(key, ".rebase", &key_len)) {
> -			name = xmemdupz(key, key_len);
> -			type = REBASE;
> -		} else
> -			return 0;
> +	if (!starts_with(key, "branch."))
> +		return 0;

That's way too early.  We must have all decl/defn before the first
statement (see Documentation/CodingGuidelines).

> -		item = string_list_insert(&branch_list, name);
> +	const char *orig_key = key;
> +	char *name;
> +	struct string_list_item *item;
> +	struct branch_info *info;
> +	enum { REMOTE, MERGE, REBASE } type;
> +	size_t key_len;

