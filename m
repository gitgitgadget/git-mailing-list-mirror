Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD62C1F404
	for <e@80x24.org>; Wed, 12 Sep 2018 18:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeILXH6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 19:07:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41530 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbeILXH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 19:07:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id z96-v6so2988315wrb.8
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 11:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HQobuk8Zqlrl4wJ/rRlfSj3r7GrCVy83LT8e1RUO0QI=;
        b=tfB+2wD+FYf8FTbrDkjyk0wINCbUHj5Si4tQ5D3ZPMKWRyjqxKfza906LFMhPIItMT
         DwTiDmzwEY6gACj6+5uD9JRqAYUC2TX2cS/ZRuvcfjcy8xGAMdWCO5e/FHKJlHklq9s/
         QBWLOUeykv6ym0TlEEu6eKRLM12pZDlPEvhXzmxzR54SFPfngk0bO6SOH/0/NoiAXlnH
         8ULjOKsT/5+RlAIsBZ9ciU4XOl7cjjFspnRS8khaJDxF3LP1yZPWpHL1ky2iMSzA4OhN
         EL1e7SaC71nl6Z3fLBQ6ayUS1NpYgoQtwooXottXtSXkV/k8JTwnhgKOrwplnRtnkKNm
         hQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HQobuk8Zqlrl4wJ/rRlfSj3r7GrCVy83LT8e1RUO0QI=;
        b=KGY0nByMMu3VGvw4sc4prvPiXaS1N1fCuqaOXX6yvhKuoF5mfYEiWcs2s0wATqrqQX
         rDSK00Qs8yUhInSGniJiwpnHHBVRarMJIsXwmc3OxDTzoCtsCozbhOHrHek6nTf7OlfZ
         3Xt4J0XX/kdPyLcL5d3yZkMYH3+05CKWyTsBmJefxB0xNVzmKm9KTv+WVdzoikZ8xTVK
         Sk7YvAKRVgGsjLf66mom9zZYvKC/R6hndDqRpWPCMDzv8cTVtk8DDgdx7JBj69uuRlEd
         kEokzFcVa3f1ZPjy1p1ZiS3P885I5pa0qWQe/KTutIqL/8kuQZbvLLWcCWG87P9P+srS
         50zA==
X-Gm-Message-State: APzg51C9/shkMeZ1Ihji5ZJIFiOhg7Rz2CsRYC9tE2QE0YgBfdQYz2r8
        mEEN6d/SG4LOvuiNngBz2eeVEXeZzVM=
X-Google-Smtp-Source: ANB0VdZUNdQPTiydkJh2s8gsMVGhiXftL+vL05chK5L9cx2IN3NftvsLh9NNQYD5/Z5wkkUlcJ4Y3A==
X-Received: by 2002:adf:bacf:: with SMTP id w15-v6mr2570900wrg.203.1536775337444;
        Wed, 12 Sep 2018 11:02:17 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a184-v6sm2257914wmh.41.2018.09.12.11.02.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 11:02:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/9] sha1-array: provide oid_array_filter
References: <20180911234951.14129-1-sbeller@google.com>
        <20180911234951.14129-3-sbeller@google.com>
Date:   Wed, 12 Sep 2018 11:02:16 -0700
In-Reply-To: <20180911234951.14129-3-sbeller@google.com> (Stefan Beller's
        message of "Tue, 11 Sep 2018 16:49:44 -0700")
Message-ID: <xmqqzhwmlhlj.fsf@gitster-ct.c.googlers.com>
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
>  sha1-array.c | 18 ++++++++++++++++++
>  sha1-array.h |  5 +++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/sha1-array.c b/sha1-array.c
> index 265941fbf40..76323935dd7 100644
> --- a/sha1-array.c
> +++ b/sha1-array.c
> @@ -77,3 +77,21 @@ int oid_array_for_each_unique(struct oid_array *array,
>  	}
>  	return 0;
>  }
> +
> +int oid_array_filter(struct oid_array *array,
> +		     for_each_oid_fn fn,

It probably makes sense to call it "want" instead of "fn" to match
object_array_filter().

> +		     void *cbdata)
> +{
> +	int src, dst;
> +
> +	for (src = dst = 0; src < array->nr; src++) {
> +		if (fn(&array->oid[src], cbdata)) {
> +			if (dst < src)
> +				oidcpy(&array->oid[dst], &array->oid[src]);
> +			dst++;
> +		}

In fact, matching the implementation of object_array_fiter() may
also make sense, as I do not see a strong reason why the resulting
code would become better by rewriting "dst != src" over there to
"dst < src" here.

> +	}
> +	array->nr = dst;
> +
> +	return 0;
> +}
> diff --git a/sha1-array.h b/sha1-array.h
> index 232bf950172..a2d7c210835 100644
> --- a/sha1-array.h
> +++ b/sha1-array.h
> @@ -23,4 +23,9 @@ int oid_array_for_each_unique(struct oid_array *array,
>  			      for_each_oid_fn fn,
>  			      void *data);
>  
> +/* Call fn for each oid, and remove it if fn returns 0, retain it otherwise */

Also perhaps mimic the wording of object_array_filter()'s comment?
I find it easier that the latter says "retaining only if X" instead
of saying "remove if !X, retain otherwise"; it's both shorter and
more to the point.  It also is nicer that it notes that the order is
preserved.

> +int oid_array_filter(struct oid_array *array,
> +		     for_each_oid_fn fn,
> +		     void *cbdata);
> +

Other than that, the function makes sense very much, and the
callsite we see in patch 8/9 does, too.

Thanks.

>  #endif /* SHA1_ARRAY_H */
