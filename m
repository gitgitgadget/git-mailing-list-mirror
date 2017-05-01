Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9D531F829
	for <e@80x24.org>; Mon,  1 May 2017 03:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163934AbdEADSP (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 23:18:15 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35053 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162660AbdEADSO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 23:18:14 -0400
Received: by mail-pg0-f66.google.com with SMTP id c2so3985984pga.2
        for <git@vger.kernel.org>; Sun, 30 Apr 2017 20:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YKWpI5toJzxmgiRQ69NiJ/NiYRsjOBfeeRLLqEXf6CE=;
        b=Mkfn76VGIFmNRgb9NuXvWJ7WLCXzi1Dmns7HFcBe/kwGKpj/oQCbHgg5NjZdGCUdSN
         0IjYGUKDsZP2wjdKVsSYl3CFLw5UyJYbDvG3YFf7LTLBv5sT5pUPLsJQ/6BLxIZ/DjO6
         6o4N2oWPxxA17auVi457LrVadk66ly9/b0XTLiETEoRX7UAUfGj1fH/5rRihCXo1dnqB
         yG/pbCfsirr1jHySgxg+19WDgFthOeynUII5L06RQlp7I9+O5ywAP3FMJGlibYOmt9Ut
         qUZHZNinv5jElTOMQXWAW8zWfLEEhrAoQ4AIUnlRY/mhZ3z8r7yxuEduTmwXol1vljVy
         RaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YKWpI5toJzxmgiRQ69NiJ/NiYRsjOBfeeRLLqEXf6CE=;
        b=QOZkY6x3GClR9CuD2LMI6UOnh7T5Mp0DDz+ELIDy9QvxdACLLQa/FlrNKCC56o7qPs
         9Qf8XQHYUzWtJyHGlNrCgdlOrOiUxaWXnKSWJG8oupujtvfAYJiwTp0n/auenco1s5Bs
         LT0fYCeJdydP7P7KrA9C9G3fapGX0D25NEx79sedhwrA6k13jhB4lguSnpkcxHvtG7qv
         45rGNLGVKlgxqFxvyimabvlHGqdfnrN1nWIHu1zWQKHe/BmWc2TT3qsC+1G+D5FWjfVu
         8rTapQ9RXL+8YYYkfmrGI+q7f1z5DvN7IE43n41mNMoiMJKQNCXoxaaRGlZERgvauxqD
         f8aw==
X-Gm-Message-State: AN3rC/5T2BhtlKSpMpaq61WTtW5Y9d9V+JL5Za3tyS/+ve+6MKHzUf7z
        AVfzdJYnnzq8HQ==
X-Received: by 10.99.113.75 with SMTP id b11mr24476802pgn.173.1493608693367;
        Sun, 30 Apr 2017 20:18:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:216d:aa3e:248d:bf63])
        by smtp.gmail.com with ESMTPSA id n77sm15237457pfj.66.2017.04.30.20.18.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 30 Apr 2017 20:18:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/6] submodule: rename add_sha1_to_array
References: <20170428235402.162251-1-bmwill@google.com>
        <20170428235402.162251-2-bmwill@google.com>
Date:   Sun, 30 Apr 2017 20:18:12 -0700
In-Reply-To: <20170428235402.162251-2-bmwill@google.com> (Brandon Williams's
        message of "Fri, 28 Apr 2017 16:53:57 -0700")
Message-ID: <xmqqvaplgt8r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Rename 'add_sha1_to_array()' to 'append_oid_to_array()' to more
> accuratly describe what the function does since it handles 'struct

accurately.   Will fix while queuing.

Makes sense.  Thanks.

> object_id' and not sha1 character arrays.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  submodule.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index d3299e29c..be0f5d847 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -951,17 +951,18 @@ static void submodule_collect_changed_cb(struct diff_queue_struct *q,
>  	}
>  }
>  
> -static int add_sha1_to_array(const char *ref, const struct object_id *oid,
> -			     int flags, void *data)
> +static int append_oid_to_array(const char *ref, const struct object_id *oid,
> +			       int flags, void *data)
>  {
> -	oid_array_append(data, oid);
> +	struct oid_array *array = data;
> +	oid_array_append(array, oid);
>  	return 0;
>  }
>  
>  void check_for_new_submodule_commits(struct object_id *oid)
>  {
>  	if (!initialized_fetch_ref_tips) {
> -		for_each_ref(add_sha1_to_array, &ref_tips_before_fetch);
> +		for_each_ref(append_oid_to_array, &ref_tips_before_fetch);
>  		initialized_fetch_ref_tips = 1;
>  	}
