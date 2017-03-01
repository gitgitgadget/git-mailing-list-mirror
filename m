Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32ED42027B
	for <e@80x24.org>; Wed,  1 Mar 2017 23:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753487AbdCAXNH (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 18:13:07 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57083 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753424AbdCAXNG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 18:13:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DC4D791FA;
        Wed,  1 Mar 2017 18:08:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lVA7A1kh7k2h
        iDTWUs1V4Zsz7wg=; b=xgKdun2jslhypdnwxWPjHN7xxXKyCKJSGFltaGJGEerD
        Bye8bQ22LsdT4DdyRVrK9vaicdC/zalusQohhz9immvDwkkwRjbdrmrykLDyjYqd
        uSz4h4L3WuS8b8HPe1csX9UBirRWUfxcMahqyJ6cWwcsP1i+XUNU/tkT8tRRSOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=GLkkbX
        S+zIrkl633nwbjlzd/0Z0yNIUA7/WHsfKpARpWCdkJKzM4E69jr9l/FAM6jU6+n5
        OcxAg2QxeblHzMMomuqbOKaizJ+Ihzz/u/N8OjWw0x54SOEaYR8xgW5HvdY7ltJr
        up9dL7b9SAot550727sXLbca7XlK+YQrZP6MY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9529B791F9;
        Wed,  1 Mar 2017 18:08:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 02A28791F8;
        Wed,  1 Mar 2017 18:08:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2017, #01; Wed, 1)
References: <xmqq60jsfww5.fsf@gitster.mtv.corp.google.com>
        <52f043cc-7b39-5ab7-bcdc-894aeb402c12@web.de>
Date:   Wed, 01 Mar 2017 15:08:10 -0800
In-Reply-To: <52f043cc-7b39-5ab7-bcdc-894aeb402c12@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 1 Mar 2017 23:57:52 +0100")
Message-ID: <xmqqefygegth.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F13CA74C-FED3-11E6-B609-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 01.03.2017 um 23:35 schrieb Junio C Hamano:
>> * rs/log-email-subject (2017-03-01) 2 commits
>>  - pretty: use fmt_output_email_subject()
>>  - log-tree: factor out fmt_output_email_subject()
>>=20
>>  Code clean-up.
>>=20
>>  Will merge to 'next'.
>
> Could you please squash this in?  We only use a single context (as
> opposed to an array), so it doesn't have to be especially compact,
> and using a bitfield slows down half of the tests in p4000 by 3%
> for me.

I thought I saw the keyword "bitfield" to the solution for that 3%
somewhere in the thread and forgot when I updated the "What's
cooking" report.

Will do.  Thanks for being careful. =20

>
> ---
>  commit.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/commit.h b/commit.h
> index 459daef94a..528272ac9b 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -154,7 +154,7 @@ struct pretty_print_context {
>  	int preserve_subject;
>  	struct date_mode date_mode;
>  	unsigned date_mode_explicit:1;
> -	unsigned print_email_subject:1;
> +	int print_email_subject;
>  	int expand_tabs_in_log;
>  	int need_8bit_cte;
>  	char *notes_message;
