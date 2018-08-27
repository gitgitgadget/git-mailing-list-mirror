Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 011EC1F404
	for <e@80x24.org>; Mon, 27 Aug 2018 17:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbeH0VpQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 17:45:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39519 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbeH0VpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 17:45:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id o37-v6so14438066wrf.6
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 10:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lvSOhXBnvh4bVsJP7i5FsKcxVUEw8UeZ66CbTO8yu8A=;
        b=TlJg9bnFt+R1lrUETvjj8MOLa8YlqgkQH6u0Iku8icyAgmmSfMuaclX9XTMAekSJwr
         vQIZzlJeUiefp7DW7+BamJRbGjvRpB6ZfIq5/Pq7vFhsgwqsKEGPibVYPiCjFzJBvE6l
         6z3Ym8gDA2jrP8PdjD63u0NA/GNlWWiUKnzdJ1SGzgQi0QbsYLu/uWYD6/V30qT13WfR
         UYBOGR2/d9+btkoP8NOQEiCsW8h2lNsVq/n0cN+g8gRRabLGUc+lYEBZVKFWoojEDiAi
         JZtP9CCOEVCUeFeLHJNSUrXm2OG8GxMddGzLjSjn3qMmoV+SqxnXxGVLLLxfc/e+Gfpe
         GYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lvSOhXBnvh4bVsJP7i5FsKcxVUEw8UeZ66CbTO8yu8A=;
        b=nwMEmZy68RWF/NomKOl4CAG7BSpkFFtUpOwju4ZnDp7o3i0m3Zrf41dxD3lro9Uzt/
         oHpmv7hYFE7yg8r+WAI2EwQpIGyQb6+XPU04xr2i9ZDAZ57/pZSWc1bAM05if1ul/asP
         reRFYrDnM0E2NWHr2DlRXzd+cP6dimk9nEyTfOukZC1l7Rmr6oOJZHZbEXpkORMXOSJS
         u2LoGwSw68ftEWbXmkia3qoDNoNcAmgMC/weya3XMQ924qxKfz63aWlRnShK5p+ni29U
         zNxtGjo8d26Z8ePIZlDZtVq0UcnwzFfXqWcg5GyXzLs5eHIqpakGTXcv36tUs2tvylM1
         y3yw==
X-Gm-Message-State: APzg51D9fuCv/Amrbca46q568zC5P1fFrHX4aW3fO9EFuCm5wzIc8MgE
        hByHTN9W+Hwh8bYHQTsm1AM=
X-Google-Smtp-Source: ANB0VdYv+ORkwCkpB7Zljns4W/utXsxTCv1OmAHDZyzf3xscSA1quZHRHfJZHl9pdJe58EMjokhC3w==
X-Received: by 2002:a5d:5450:: with SMTP id w16-v6mr9944586wrv.4.1535392658524;
        Mon, 27 Aug 2018 10:57:38 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h73-v6sm4753318wma.11.2018.08.27.10.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 10:57:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v3] range-diff: update stale summary of --no-dual-color
References: <20180823211028.GA99542@aiede.svl.corp.google.com>
        <20180823215748.3474-1-kyle@kyleam.com>
        <20180823220207.GC99542@aiede.svl.corp.google.com>
        <xmqqo9dshh1j.fsf@gitster-ct.c.googlers.com>
        <20180823221152.GD99542@aiede.svl.corp.google.com>
Date:   Mon, 27 Aug 2018 10:57:37 -0700
In-Reply-To: <20180823221152.GD99542@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Thu, 23 Aug 2018 15:11:52 -0700")
Message-ID: <xmqq5zzvlmjy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>> Kyle Meyer wrote:
>
>>>> Subject: [PATCH v3] range-diff: update stale summary of --no-dual-color
> [...]
>>> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>>
>> Sorry, too late.  I'll revert the merge of the previous round out of
>> 'next' and requeue this one, but that will have to wait until the
>> next integration cycle.
>
> Thanks for the heads up.  Sounds like a fine plan.

Having said that, I do not think the change from v2 to v3 is an
improvement.  At least the one in v2 explained what the input is to
the logic to determine colors, helping the users to understand what
is painted and why and decide if that coloring is useful to them.

The phrasing in v3, "use simple diff colors", does not give much
information over saying something like "paint it differently" (which
is silly because "differently" is a given, once you give an option
to cause a non-default behaviour).

Not limited to this particular case, but in general, subjective
words like "simple" have much less information density than more
specific words, and we need to be careful when spending bits on a
limited space (like option description) to them.

