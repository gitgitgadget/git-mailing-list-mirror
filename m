Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9053D20756
	for <e@80x24.org>; Tue, 17 Jan 2017 21:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751030AbdAQVo6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 16:44:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54677 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750922AbdAQVo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 16:44:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C99D6146D;
        Tue, 17 Jan 2017 16:43:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cAxkKyUvYGPrEjqVtDsczIHA/44=; b=EuWGUQ
        9A24sFeCT9y2SNFGfdY0rAlFb20OvgAIIeo0LVwTp6EDDA4Ajm8iksJrtbEOb2Cj
        fEu/V7CEvz81RGXkwVPY2Q8QfGRpkTLK7hhmcyKqrwac3YScNlWHF8ce4Om8dAx6
        TlR/V0BbzCQXil0We5YQ1927yqhPrEUGF5/jM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tmETi189h8jqs9ot8W1HMjzcZfdHUWri
        kBx77J+ge8HCPJrJld5JyD97/043HAEbmowXoM1dSPSuEDV5prDFXZ8/NJBtkvx1
        oDpvJ3FGPgoRFTvldQ6t8aYctXpJsE3VbcK1jJmXSrnPwvNPuIyrOHuhDudOtcX5
        ZrMrSikAzuU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 641206146C;
        Tue, 17 Jan 2017 16:43:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BE05F6146B;
        Tue, 17 Jan 2017 16:43:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] document index_name_pos
References: <xmqqpojle85c.fsf@gitster.mtv.corp.google.com>
        <20170117204642.31514-1-sbeller@google.com>
Date:   Tue, 17 Jan 2017 13:43:15 -0800
In-Reply-To: <20170117204642.31514-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 17 Jan 2017 12:46:42 -0800")
Message-ID: <xmqqo9z5cqh8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F47B77A0-DCFD-11E6-A21D-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>> These placeholders are meant to encourage those people who dove into
>> the code to update it, so from that point of view, I think removing
>> it is backwards.
>
> Yes, I am currently understanding and writing up documentation for
> index_name_pos. If I recall the latest discussion where we want to have
> documentation, I think a quorum favored documentation in the header itself,
> c.f. strbuf.h, string-list.h for the most desired state. (Although we do have
> Documentation/technical/api-string-list.txt as well ...)
>
> So maybe starting like this?

That is very good.  Let's drop that file from Documentation/technical
and do it like this (meaning, take both patches from you).

Thanks.


>
> Thanks,
> Stefan
>
>  cache.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/cache.h b/cache.h
> index 1b67f078dd..e168e4e073 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -575,7 +575,20 @@ extern int verify_path(const char *path);
>  extern int index_dir_exists(struct index_state *istate, const char *name, int namelen);
>  extern void adjust_dirname_case(struct index_state *istate, char *name);
>  extern struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
> +
> +/*
> + * Searches for an entry defined by name and namelen in the given index.
> + * If the return value is positive (including 0) it is the position of an
> + * exact match. If the return value is negative, the negated value minus 1 is the
> + * position where the entry would be inserted.
> + * Example: In the current index we have the files a,c,d:
> + * index_name_pos(&index, "a", 1) ->  0
> + * index_name_pos(&index, "b", 1) -> -1
> + * index_name_pos(&index, "c", 1) ->  1
> + * index_name_pos(&index, "d", 1) ->  2
> + */
>  extern int index_name_pos(const struct index_state *, const char *name, int namelen);
> +
>  #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
>  #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
>  #define ADD_CACHE_SKIP_DFCHECK 4	/* Ok to skip DF conflict checks */
