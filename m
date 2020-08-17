Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B611AC433E3
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 16:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 781E620825
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 16:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n5RbrFsI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbgHQQTz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:19:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55725 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731104AbgHQQS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 12:18:56 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE5356DFBB;
        Mon, 17 Aug 2020 12:18:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=j4mdEln8A78yQxk6/d6E4+H6tmI=; b=n5RbrF
        sI5BS+MR7IQVr3+DlmlsqyUNT+whn+axUw8JkW+ayLF1U2UZoWVu13JnAjyK9cE0
        /s959M1qjm8T7oC7+tTy7Sb1McaDkBnEYlq1QDxapU0JQ5M5YaOehLVfT+sHzKsr
        kaNQwqKIdon7EmdVeWW+VNtSeXROD9vb4yEVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H9CuSYaUYNWfy+rjc+2Rjocee18JraRD
        sBjXMlS/TlaGlvArRs3XNe821eHk8deSqU9DZgs4N7fWSufHIAhqYmUHZDrlJEXO
        enjkIl18wKALPCj+aoFg7unj0Fra57TPqBDVSY42vBRrkENI+kackPo9/+/W0xU0
        N9r2NLFjOmA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A5F036DFB8;
        Mon, 17 Aug 2020 12:18:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2C8446DFB7;
        Mon, 17 Aug 2020 12:18:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC 1/3] refspec: fix documentation referring to refspec_item
References: <20200815002509.2467645-1-jacob.e.keller@intel.com>
Date:   Mon, 17 Aug 2020 09:18:37 -0700
In-Reply-To: <20200815002509.2467645-1-jacob.e.keller@intel.com> (Jacob
        Keller's message of "Fri, 14 Aug 2020 17:25:07 -0700")
Message-ID: <xmqqk0xx455u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4EA6F57A-E0A5-11EA-9DDA-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> In commit d27eb356bf25 ("remote: move doc to remote.h and refspec.h")
> the documentation for the refspec structure was moved into refspec.h
>
> This documentation refers to elements of the refspec_item, not the
> struct refspec. Move the documentation slightly in order to align it
> with the structure it is actually referring to.

Makes sense to me.

>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  refspec.h | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/refspec.h b/refspec.h
> index 23e1555b88ac..8d654e3a3ac4 100644
> --- a/refspec.h
> +++ b/refspec.h
> @@ -4,6 +4,19 @@
>  #define TAG_REFSPEC "refs/tags/*:refs/tags/*"
>  extern const struct refspec_item *tag_refspec;
>  
> +/**
> + * A struct refspec_item holds the parsed interpretation of a refspec.  If it will
> + * force updates (starts with a '+'), force is true.  If it is a pattern
> + * (sides end with '*') pattern is true.  src and dest are the two sides
> + * (including '*' characters if present); if there is only one side, it is src,
> + * and dst is NULL; if sides exist but are empty (i.e., the refspec either
> + * starts or ends with ':'), the corresponding side is "".
> + *
> + * remote_find_tracking(), given a remote and a struct refspec_item with either src
> + * or dst filled out, will fill out the other such that the result is in the
> + * "fetch" specification for the remote (note that this evaluates patterns and
> + * returns a single result).
> + */
>  struct refspec_item {
>  	unsigned force : 1;
>  	unsigned pattern : 1;
> @@ -21,20 +34,8 @@ struct refspec_item {
>  #define REFSPEC_INIT_PUSH { .fetch = REFSPEC_PUSH }
>  
>  /**
> - * A struct refspec holds the parsed interpretation of a refspec.  If it will
> - * force updates (starts with a '+'), force is true.  If it is a pattern
> - * (sides end with '*') pattern is true.  src and dest are the two sides
> - * (including '*' characters if present); if there is only one side, it is src,
> - * and dst is NULL; if sides exist but are empty (i.e., the refspec either
> - * starts or ends with ':'), the corresponding side is "".
> - *
> - * An array of strings can be parsed into an array of struct refspecs using
> + * An array of strings can be parsed into a struct refspec using
>   * parse_fetch_refspec() or parse_push_refspec().
> - *
> - * remote_find_tracking(), given a remote and a struct refspec with either src
> - * or dst filled out, will fill out the other such that the result is in the
> - * "fetch" specification for the remote (note that this evaluates patterns and
> - * returns a single result).
>   */
>  struct refspec {
>  	struct refspec_item *items;
>
> base-commit: 878e727637ec5815ccb3301eb994a54df95b21b8
