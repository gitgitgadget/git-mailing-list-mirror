Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D25920248
	for <e@80x24.org>; Mon, 15 Apr 2019 14:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDOOYH (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 10:24:07 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:37842 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfDOOYH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 10:24:07 -0400
Received: by mail-yb1-f195.google.com with SMTP id p134so6443585ybc.4
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 07:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jip6AopZo7irlaz+MyYqpDwBfi9WtmwVcPO/N8lkNok=;
        b=tuncQrmgy69szKbIxrp8fNynXfqrQ2tpAdQ5o+yvLtyfCGwBXc2WJOA4ULpyVO0z3F
         9IBPKb2SiloOn/6Fyu6BJA5qffj/VkQsRXwCb2QS+fXqxBfcBcEESwJrJ5bCVm4sY21H
         kmLb3Etoy94zlBotNzC136Yv1AHIOBCTe6mSnmT8UYyHE+pDby4z2rCWUVnFJLnT96+D
         AU2RycRQEoTCiopHrE//R6mvzqtX0V+wdAGh5AA1BYosPNm823pauT7veSpWpAiJmeHF
         rmdO7zNYXu8gJB9hafv6DrvsYvoykiB+1qxHipdAEMlYKOkrla3amV0J45d7eVnAE1Xs
         ub7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jip6AopZo7irlaz+MyYqpDwBfi9WtmwVcPO/N8lkNok=;
        b=YQNGXVP9I7kXO4WbVl4L8/tRvzMDjsSwKpMjJ5E15UBRM8nSFzSow+ThnGG9iQ1YSp
         XeKa4DWu0dLFrjjXHfL9JH7wNDlRsXyI+ZDgLOacXbtCLv7JvmMHZh83BavQhEiEWTx/
         fJqlQh6ZCrK3yV8VtPJncLRuL+Qe4+1BmXXM7GUM9MdbT+231/bVbBjeAxaFppGcwsaw
         ViGGfp84Vk9b+J+Utv8+1nvJRc8XVwYB9hRaOS6nuLut5tlvlQmXwkxrllIq0+wGKy6D
         LHvBUv3g9vUDBB+Txjlh6eatpKMfDMQoSudoTFSuCXLNnGYVtWC6Y3GPVLhDGW9YxFDb
         vi1w==
X-Gm-Message-State: APjAAAWfDs6kd8X2xdxpsWp8XcPlOQiHDQPaW/XNv1iDXO/Cen44oo0o
        q8nAMFAzUfK/cDvwhvX10Xk=
X-Google-Smtp-Source: APXvYqxthAXtDJ2gq9/E3iNv2OArgK+ZnoU2MCNFIA8uJsmUrrgx9PGh0mpyIEoYME+08k/ERhcHgg==
X-Received: by 2002:a25:dc9:: with SMTP id 192mr60022675ybn.192.1555338246644;
        Mon, 15 Apr 2019 07:24:06 -0700 (PDT)
Received: from [192.168.1.14] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id 74sm13434924ywe.81.2019.04.15.07.24.05
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:24:05 -0700 (PDT)
Subject: Re: [PATCH v6 2/2] config: allow giving separate author and committer
 idents
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        William Hubbs <williamh@gentoo.org>, chutzpah@gentoo.org
References: <20190204184850.10040-1-williamh@gentoo.org>
 <20190205195212.25550-3-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <15f17152-fcec-ee9a-acd3-f36cf2c98030@gmail.com>
Date:   Mon, 15 Apr 2019 10:24:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:66.0) Gecko/20100101
 Thunderbird/66.0
MIME-Version: 1.0
In-Reply-To: <20190205195212.25550-3-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/5/2019 2:52 PM, Ævar Arnfjörð Bjarmason wrote:
> From: William Hubbs <williamh@gentoo.org>
> -const char *fmt_name(const char *name, const char *email)
> +const char *fmt_name(enum want_ident whose_ident)
>  {
> -	return fmt_ident(name, email, NULL, IDENT_STRICT | IDENT_NO_DATE);
> +	char *name = NULL;
> +	char *email = NULL;
> +
> +	switch (whose_ident) {
> +	case WANT_BLANK_IDENT:
> +		break;
> +	case WANT_AUTHOR_IDENT:
> +		name = getenv("GIT_AUTHOR_NAME");
> +		email = getenv("GIT_AUTHOR_EMAIL");
> +		break;
> +	case WANT_COMMITTER_IDENT:
> +		name = getenv("GIT_COMMITTER_NAME");
> +		email = getenv("GIT_COMMITTER_EMAIL");
> +		break;
> +	}
> +	return fmt_ident(name, email, whose_ident, NULL,
> +			IDENT_STRICT | IDENT_NO_DATE);
>  }

William and Ævar,

The "WANT_AUTHOR_IDENT" block of this switch statement does not
appear to be hit by any tests, despite the tests included in this
patch. My guess is that it is ignored because we have the following
code in builtin/commit.c:

static void determine_author_info(struct strbuf *author_ident)
{
	char *name, *email, *date;
	struct ident_split author;

	name = xstrdup_or_null(getenv("GIT_AUTHOR_NAME"));
	email = xstrdup_or_null(getenv("GIT_AUTHOR_EMAIL"));
	date = xstrdup_or_null(getenv("GIT_AUTHOR_DATE"));
...


This is likely overriding the need to use fmt_name. Should we
de-duplicate this use of the environment variable by using your
new method at this spot in builtin/commit.c?

Thanks,
-Stolee
