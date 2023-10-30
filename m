Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3742D308
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5UKvJUC"
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945691989
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 02:59:46 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32f70391608so1768820f8f.2
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 02:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698659985; x=1699264785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oxpaBgGpqbYmIPBNnpTFuC9gY15+SKCfjC/2+0k39Po=;
        b=F5UKvJUCpGtPJsvJlNwuc6u40Q02xFE+HzRvX6olutA6pSqR688O51R6Ji8jRTbpWk
         hzu4IlxTwjJXYQydheh7H2pinXQtrsgQUNXuXXFGJYPF/audPEvu1JHZjutJ4Oe4OAQK
         vEqMJpX6B3HuBg3nXuOWdT1XvcZK91DdaA3rwOHDYHkaYZS6aeUYmfgrspFyT1aAtH88
         KC5PSYWvhwuxcKe/HB/MU4eccaLI8/eXQ4vqG9GteDSgI8SNN4vF4dy0RbwYlK3wLGrs
         +GspgU6DNmxj7Q1Im0OPSveL1187kQaQMqRrR7D3EttdygiQY1jg5YiGFfpr5wELHBQ/
         9zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698659985; x=1699264785;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxpaBgGpqbYmIPBNnpTFuC9gY15+SKCfjC/2+0k39Po=;
        b=B4LYQGc1T952Dbla3wq72N0WY5+LAlMk7w5+2tv3FjBjmdQYupiF/L74FffEcKWGMW
         VefjlecsGr8mBZ9h9P5Ai6eaXK7eZFa7Dq8HOj0Do1rnjpUoMB3UtHURHp2NQVLotmuz
         49lsJafoT8vxeCbhwp7W/DASNgkGKAXy4wxj4pFfnC55JjhI+2UC5K3qUzDhO34ZKK7y
         N0VLrChWjag8rbWhtkBeSmvpw87P2tGCT6uGMGtE0IU9rrYl92B77wZzUrjZIgKayLi6
         310m8AJGCbIPvIcWxsaJTN4i+bLpc8N0SHKle+rqLPffVdj4yyAkSVUQ3poFnw36A6Mu
         oZnQ==
X-Gm-Message-State: AOJu0YwD8cpypZtQUm6qWGCwWzpATWz90NqLhKWtgf9mLXwjgPHjv5PH
	ncpQT+zuBRboLyk8gvLPif+v60caPkw=
X-Google-Smtp-Source: AGHT+IHbTmCaB1eDvaYxvkp9gI/1blBnsw1WhMc3kFTZcHVeTH0bwU4wEkhT7SsrIETe9ro8cYtPfA==
X-Received: by 2002:adf:d1e8:0:b0:32f:7d50:267e with SMTP id g8-20020adfd1e8000000b0032f7d50267emr4509685wrd.9.1698659984624;
        Mon, 30 Oct 2023 02:59:44 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id k23-20020a5d5257000000b0032db8cccd3asm7822482wrc.114.2023.10.30.02.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 02:59:44 -0700 (PDT)
Message-ID: <db6702ba-11a7-44c1-af2a-95b080aaeb77@gmail.com>
Date: Mon, 30 Oct 2023 09:59:44 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/2] Avoid passing global comment_line_char repeatedly
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20231030051034.2295242-1-gitster@pobox.com>
Cc: Calvin Wan <calvinwan@google.com>, Jonathan Tan <jonathantanmy@google.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20231030051034.2295242-1-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 30/10/2023 05:10, Junio C Hamano wrote:
> Two strbuf functions used to produce commented lines take the
> comment_line_char as their parameter, but in practice, all callers
> feed the global variable comment_line_char from environment.[ch].
> 
> Dropping the parameter from the callchain will make the interface
> less flexible, and less error prone.  If we choose to change the
> implementation of the customizable comment line character (e.g., we
> may want to stop referencing the global variable and instead use a
> getter function), we will have fewer places we need to modify.

While I agree with your reasoning here, I think that parameter was 
recently added as part of the libification effort - I can't remember 
exactly why and am too lazy to look it up so I've cc'd Calvin and 
Johathan instead.

Best Wishes

Phillip

> Junio C Hamano (2):
>    strbuf_commented_addf(): drop the comment_line_char parameter
>    strbuf_add_commented_lines(): drop the comment_line_char parameter
> 
>   add-patch.c          |  8 ++++----
>   builtin/branch.c     |  2 +-
>   builtin/merge.c      |  8 ++++----
>   builtin/notes.c      |  9 ++++-----
>   builtin/stripspace.c |  2 +-
>   builtin/tag.c        |  4 ++--
>   fmt-merge-msg.c      |  9 +++------
>   rebase-interactive.c |  8 ++++----
>   sequencer.c          | 14 ++++++--------
>   strbuf.c             |  9 +++++----
>   strbuf.h             |  7 +++----
>   wt-status.c          |  6 +++---
>   12 files changed, 40 insertions(+), 46 deletions(-)
> 
