Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DDA21F453
	for <e@80x24.org>; Wed, 26 Sep 2018 22:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbeI0EdB (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 00:33:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52843 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725722AbeI0EdB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 00:33:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id l7-v6so3854182wme.2
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 15:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ygmxzF97bnf81xA0/8/VL48O7MJnKdDQhoue7YFdk/o=;
        b=IXzAGI0hOyB5sLjTvbZJKm33NSacKsow8ZVWMKgAnCOYbFtBWqxWGhz1YcksMvIAOn
         +Yzcnb2DUmcaqeej1pF2IVSo5dXyWrUEqk0xAoU92k1Jxccml8i9ztKOpUx5aYIinnc2
         YXNcCDuJC9lxJg3Otg9F25qbDC35UrGc/5ZZL+yId0BMPm/LZJOIWeQFg/fAx8KWFdpF
         InLWtVUQYaeDMLGlJNSTRhqnX1PGfj3YM5n9FAfdfrdJPeP34vXYcVuATkn3lUW3F/wO
         TwQQIyQtatozEDcMNKJkYfb3GPcSekKLoUgzIH0kds7GwtOnvLt01gZhijj69548RWdW
         2SVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ygmxzF97bnf81xA0/8/VL48O7MJnKdDQhoue7YFdk/o=;
        b=N1m+RqIJ/1RVqDEJGlZNe8WxTmlrK02XHQMAvIx9XPb2qsAJEK9mBSJhTBtRRC2/4Q
         b+Lb/ggnnVDY7BaIbdnGD+4cPIh401vvkvpKHxGd+xNZwQnzS1H+CHWhfuW6AqHIqV8J
         wO8mJK1yq+bybbiR96KextByPB/As2HYfVWHL2/ynRrGqQ/j8Va8es5xV35LsXH1Ahna
         EBP+VoNGKaGtPKVf98h7IeKJuIBKBG1SV6ZjXd9i3qNJOUqyqQE1X6DBgAAxVLbyWNQP
         SWXt1V8GvqtGTAf0DFQKTtdPLsygC4J1Oc8o13/CM2GX9xldjrNyJRXLecBSn/dunBYG
         zjaQ==
X-Gm-Message-State: ABuFfohlBxn4015A7I0ScpveNakRxxpaqqEp2jxqReIBJZbT49zfpFdd
        Eu4A/38Az6dIbE7UyPBeA+A=
X-Google-Smtp-Source: ACcGV62XKGI34PwNQf42QwY+d8+tq4NW84a2s15GFJ0KSN06bKgdB4Qo6U1DoYAf61kNXopoMjqr7w==
X-Received: by 2002:a1c:1d58:: with SMTP id d85-v6mr5930023wmd.142.1538000274075;
        Wed, 26 Sep 2018 15:17:54 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 144-v6sm758152wma.19.2018.09.26.15.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 15:17:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 1/9] sha1-array: provide oid_array_filter
References: <20180925194755.105578-1-sbeller@google.com>
        <20180925194755.105578-2-sbeller@google.com>
Date:   Wed, 26 Sep 2018 15:17:53 -0700
In-Reply-To: <20180925194755.105578-2-sbeller@google.com> (Stefan Beller's
        message of "Tue, 25 Sep 2018 12:47:47 -0700")
Message-ID: <xmqqwor7j432.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/technical/api-oid-array.txt |  5 +++++
>  sha1-array.c                              | 17 +++++++++++++++++
>  sha1-array.h                              |  3 +++
>  3 files changed, 25 insertions(+)

Perfect ;-)

>
> diff --git a/Documentation/technical/api-oid-array.txt b/Documentation/technical/api-oid-array.txt
> index 9febfb1d528..c97428c2c34 100644
> --- a/Documentation/technical/api-oid-array.txt
> +++ b/Documentation/technical/api-oid-array.txt
> @@ -48,6 +48,11 @@ Functions
>  	is not sorted, this function has the side effect of sorting
>  	it.
>  
> +`oid_array_filter`::
> +	Apply the callback function `want` to each entry in the array,
> +	retaining only the entries for which the function returns true.
> +	Preserve the order of the entries that are retained.
> +
>  Examples
>  --------
>  
> diff --git a/sha1-array.c b/sha1-array.c
> index b94e0ec0f5e..d922e94e3fc 100644
> --- a/sha1-array.c
> +++ b/sha1-array.c
> @@ -77,3 +77,20 @@ int oid_array_for_each_unique(struct oid_array *array,
>  	}
>  	return 0;
>  }
> +
> +void oid_array_filter(struct oid_array *array,
> +		      for_each_oid_fn want,
> +		      void *cb_data)
> +{
> +	unsigned nr = array->nr, src, dst;
> +	struct object_id *oids = array->oid;
> +
> +	for (src = dst = 0; src < nr; src++) {
> +		if (want(&oids[src], cb_data)) {
> +			if (src != dst)
> +				oidcpy(&oids[dst], &oids[src]);
> +			dst++;
> +		}
> +	}
> +	array->nr = dst;
> +}
> diff --git a/sha1-array.h b/sha1-array.h
> index 232bf950172..55d016c4bf7 100644
> --- a/sha1-array.h
> +++ b/sha1-array.h
> @@ -22,5 +22,8 @@ int oid_array_for_each(struct oid_array *array,
>  int oid_array_for_each_unique(struct oid_array *array,
>  			      for_each_oid_fn fn,
>  			      void *data);
> +void oid_array_filter(struct oid_array *array,
> +		      for_each_oid_fn want,
> +		      void *cbdata);
>  
>  #endif /* SHA1_ARRAY_H */
