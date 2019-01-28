Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,URIBL_DBL_SPAM shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FEBE1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 02:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfA1CFQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 21:05:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33976 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfA1CFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 21:05:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id f7so16361906wrp.1
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 18:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=yXVlwczpTEv2NRGY6lLJiMotuJGO6GuzXWsffOyXr6c=;
        b=FMTKCL+IpGud/S6ahy/8SfbNVlQDn8rojXFIJctuZV3KkntJKo/Ot+LFITJXKyTnt2
         uxZ9qsBp9OiqHLFZxZdQDm/UDsPWaTNqpfPjxs8mI7wWCslxP3slY/hYbJYj8np8myaU
         3WnCtuJwyEA1kR0EbBg+DnefmgiIvz7S6omUu1vySimABx7vA5WTFknro/O2sQmlkKWY
         hKY7yX6LFa1xGef3wGnEgsdjkIsjOb61x0K1og9BukyQKIW0ZA/O9n5MxRrM8Z7it2A1
         vw+HFjEpPQF7zRYs2HctlmB5H14VJcBNCacuTOFIofdO65m7cf7ClGd7y4qIEBE1dpo9
         5VGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=yXVlwczpTEv2NRGY6lLJiMotuJGO6GuzXWsffOyXr6c=;
        b=VaKBvvkBn7hHsTf6ZeJQD/kU82PxlgUlc9tAymRAfAfCKzAJa53IxzbEVWBGBnVZtY
         NKbn//HQ/3vWRsn9RummkRcn/+s//zGh8b9UXNL009VbzM/8OAQ6KK5rL6b7CdhrKdBt
         HqPXpKgNyBsnLCZiZ7cSehwsRoOKDocMIZsAwY8CmpWcASFIuX7xON5h4OE4yo6kVwrn
         ZsaGY6gF0WMBQ7yqz62y+d8EQBbWYV6hPfBfW2fpXrPbS2PMoZvLnnZj+ATYXlYzaWSS
         SgVUc7nfoTydVxiTlWv5Yq6sk8+ULAN8Z019Z98ut/509zaOwV8ZFbDP791Ob4mdoBJ+
         FmuQ==
X-Gm-Message-State: AJcUukd3t86PHzmAO/D82Jo3ZJnfb21AeyYiQMDPp9XW0d/PksU1UhUh
        nOj8LeCbr7j610n/YYL2urU=
X-Google-Smtp-Source: ALg8bN6iwdTY3JUaAn7lp3zgoiNOxRVwJTmxDxBORENs/xuwJb0XuAPGmvT8kPR8sLk+gKTRvwc5lg==
X-Received: by 2002:a5d:4b01:: with SMTP id v1mr18955860wrq.5.1548641113487;
        Sun, 27 Jan 2019 18:05:13 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a8sm47252450wme.23.2019.01.27.18.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 18:05:12 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     sxenos@google.com
Cc:     git@vger.kernel.org, Stefan Xenos <sxenos@gmail.com>
Subject: Re: [PATCH v3 2/8] sha1-array: Implement oid_array_readonly_contains
References: <20190127194415.171035-1-sxenos@google.com>
        <20190127194415.171035-2-sxenos@google.com>
Date:   Sun, 27 Jan 2019 18:05:12 -0800
Message-ID: <xmqqlg35czaf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

sxenos@google.com writes:

> Subject: Re: [PATCH v3 2/8] sha1-array: Implement oid_array_readonly_contains

Style: s/: Implement/: implement/

> From: Stefan Xenos <sxenos@gmail.com>

This line wants to say "Stefan Xenos <sxenos@google.com>" to match
S-o-b below (I am assuming that you are following your employer's
open source recommendation to contribute under your corp address).

Perhaps you would want user.email set to the corp address?  I am
taking the above as an indication that the commits we are seeing
here have been made under your @gmail.com address and that is why
git-send-email is adding the in-body header.

> diff --git a/sha1-array.c b/sha1-array.c
> index b94e0ec0f5..071fce7e90 100644
> --- a/sha1-array.c
> +++ b/sha1-array.c
> @@ -26,6 +26,21 @@ static const unsigned char *sha1_access(size_t index, void *table)
>  	return array[index].hash;
>  }
>  
> +int oid_array_readonly_contains(const struct oid_array* array,
> +	const struct object_id* oid)
> +{
> +	int i;

Style: blank between decl and first stmt, perhaps?

> +	if (array->sorted) {
> +		return sha1_pos(oid->hash, array->oid, array->nr, sha1_access) >= 0;

No need for {} around a single statement.

> +	}
> +	for (i = 0; i < array->nr; i++) {
> +		if (hashcmp(array->oid[i].hash, oid->hash) == 0) {
> +			return 1;

Likewise.

> +		}
> +	}
> +	return 0;
> +}
> ...
> diff --git a/t/t0064-sha1-array.sh b/t/t0064-sha1-array.sh
> index 5dda570b9a..c1bac6fcdd 100755
> --- a/t/t0064-sha1-array.sh
> +++ b/t/t0064-sha1-array.sh
> @@ -32,6 +32,28 @@ test_expect_success 'ordered enumeration with duplicate suppression' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'readonly_contains finds existing' '
> +	echo 1 > expect &&

Style: no SP between redirection operator and its target, i.e.

	echo 1 >expect &&

> +	echoid "" 88 44 aa 55 >> expect &&

Likewise.

	echoid "" 88 44 aa 55 >>expect &&

