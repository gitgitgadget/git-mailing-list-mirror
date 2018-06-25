Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 960EE1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 18:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934891AbeFYSJj (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 14:09:39 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:48893 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934731AbeFYSJi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 14:09:38 -0400
Received: by mail-yw0-f202.google.com with SMTP id r139-v6so5921413ywg.15
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 11:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=DmB7T7ku++aHEjfnWndjkJxunBwbGs6tXrc/EhrjRS8=;
        b=W7wKIyqSLJJDAwHMIdLRNb+eQf/eLWaGPgeJJ5WQtmhCo2okhj+BCDjAXHJ2IBzzYh
         iUANmr80FUgLrAdu2mj88N4SyM3+JuB9BzAiCeDfadJGXw4+cI+xDpr/PUF5wLTA2NqU
         t5pTGeMkark9IVyWSacaHXlItmzLXJ4vXf8CEHiTdwFBYQKolexPnTPJTO+P4uNRA5vo
         1yyHVOXSqLvxkmBWWQ+d4L7Xg7/DnKEXWcEClvKMud0QUOfwqTQNhwDa7ANnvlZoJx+F
         529BhS0PTFFhCrCOCgWccuVHBD+9eQcIBeeehsBoaaNsSgOR8OKQ1hUvdAFQl2hWI294
         6dRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=DmB7T7ku++aHEjfnWndjkJxunBwbGs6tXrc/EhrjRS8=;
        b=g0VAtuSkqdeodWc1cfUdTaPuMqwaxk7+hQmp+EpLtWG5QUHUTrQc5LLCoqHd/V1IUs
         HaP3wYpN0tyN0rFurlfFI5fNxrz4bE3m4Wax+gn2KR0s7nKcABpiPCt8Opm/qXy1KO6V
         y+TzTKHEaJ2U5mJpNQtT0Msu46DMBSx5P8cS5MYmoqdJyBybgQ+qgRoPVjk/rImJV2Gx
         9OVdkye061l8DtLE01BRLSPQlx2gM0b4V7DFap6D73saqwBP7mTeSRK1580avlpQVKwU
         BPiDp1aSXb1Nep55RSiHU0KwsIl+tq4G5hQRcVLNmS8OiHy1IHhpeLlG/DWxqt7RD4Dj
         XbWg==
X-Gm-Message-State: APt69E1lKuNIWV8GSGOKBz/zv/oar9XPAXqeg9IhjA6f9355kf5N0Qn2
        pGoWBS+bTqsSye9kjFjq6CJ5U7xsB/Bl8TxWj/Tm
X-Google-Smtp-Source: ADUXVKIbzPp7AeDZBBPUOORS4xdOXTsHYs8NvwdHMUM9VfKMJVf6FsbCgtFqZANnBfAdjP3QXjQaCBBLiQrAg1mrREvc
MIME-Version: 1.0
X-Received: by 2002:a0d:e9c7:: with SMTP id s190-v6mr4027211ywe.108.1529950177912;
 Mon, 25 Jun 2018 11:09:37 -0700 (PDT)
Date:   Mon, 25 Jun 2018 11:09:34 -0700
In-Reply-To: <20180620213235.10952-3-bmwill@google.com>
Message-Id: <20180625180934.229573-1-jonathantanmy@google.com>
References: <20180620213235.10952-3-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc2.347.g0da03f3a46.dirty
Subject: Re: [PATCH v3 2/8] upload-pack: implement ref-in-want
From:   Jonathan Tan <jonathantanmy@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com,
        sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +static int parse_want_ref(const char *line, struct string_list *wanted_refs)
> +{
> +	const char *arg;
> +	if (skip_prefix(line, "want-ref ", &arg)) {
> +		struct object_id oid;
> +		struct string_list_item *item;
> +		struct object *o;
> +
> +		if (read_ref(arg, &oid))
> +			die("unknown ref %s", arg);

One more thing - if you're planning to "die" here, also write out an
error to the user, just like in parse_want().
