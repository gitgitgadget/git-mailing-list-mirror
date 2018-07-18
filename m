Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 237081F597
	for <e@80x24.org>; Wed, 18 Jul 2018 16:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbeGRQxY (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 12:53:24 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35623 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeGRQxX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 12:53:23 -0400
Received: by mail-qt0-f194.google.com with SMTP id a5-v6so4532156qtp.2
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 09:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=d/7H8FhryQb9+/mG64JLJOFRBcNjL0H60MY5+Jf2/Wo=;
        b=bQaKtQUX1dh3hsSiYQSHArO5YCYP2fo58Wk4yKboLTI7NwcWRIilytz8nn/y7Fjkzy
         1kuv8iybeSKOJ4B1jkFVUFCsbWOBMZWblEaGNjGn3G/w/S1ivL/EkaSCWONyssZX/oCE
         feWQrVFCDlr4vuqkUz0/UGa+YXuqbOCkkmz4tQ5gCLxcPkgkrE2aZ8/ajqEe0HsE2xyy
         5FljPPriTJ2y63pNIJiBYGRIJJc/BQ4OZ+jX/oF4mv7mRVBQ5ygbZXXijC+h9ZgJWq6Z
         yOJn6T8tJ10j6ehUmo1yc1PuxnM95DTbU+z/sdge6n1SgGcjj7KXSXP42L5kGr1JqU42
         NGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=d/7H8FhryQb9+/mG64JLJOFRBcNjL0H60MY5+Jf2/Wo=;
        b=Lk3Sk9YvPr8ra0UkPx5GNhxpZIvfgxASuruajUve4kRypCi07wosm+0SCMS8YA4LA1
         RC1PeWTn6NjVdYYihbNwS1cyyhV9CvHH5kaa4dYSC7bPE5z44YU5vsOlrR4Aq2WWvllb
         5R36S6sx7RSM2vtH2rWT3rI/pt/23T0yrYV6lvZLMQ9SPlxJeCmqAtGPkiL323h7+X9Y
         40xDwLZcBxWknitUTpod9hMxE2/qrq21DcvB/zyaHPt09kFGDPaGzJpsPA2PRwysIkFn
         mFJqVFSRFE5OY/wBBvhNar0UKvJ2FTZJeaDzWdK3lmJ54Ff3fzV2aSVHh3AkDLH9baf8
         I6og==
X-Gm-Message-State: AOUpUlEj8iy0aVZXXfgQezg6+pEMeETnyzLG7iiG2CQs6B105CrOML9g
        iBmRhN2i2VIz0dSgTAHpYNk=
X-Google-Smtp-Source: AAOMgpdlaRLfO4JZqEZoUtrMiea6GbHjqO142a11OOu2CFU8I7Au7lgnLfphjf9+3rGRWblwEtQq6w==
X-Received: by 2002:ac8:2191:: with SMTP id 17-v6mr6441589qty.279.1531930486519;
        Wed, 18 Jul 2018 09:14:46 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d070:73be:3735:cf07? ([2001:4898:8010:0:b9a6:73be:3735:cf07])
        by smtp.gmail.com with ESMTPSA id i32-v6sm2520713qtb.21.2018.07.18.09.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:14:45 -0700 (PDT)
Subject: Re: [PATCH 08/16] test-reach: create new test tool for ref_newer
To:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, dstolee@microsoft.com
References: <6acc5e804ea7beabc7c813e4c1c067915a16087b.1531746011.git.gitgitgadget@gmail.com>
 <20180716230019.257742-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <043a5a75-6181-6a4c-e81f-9d82645d8f1b@gmail.com>
Date:   Wed, 18 Jul 2018 12:14:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180716230019.257742-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/16/2018 7:00 PM, Jonathan Tan wrote:
>> To use the new test-tool, use 'test-tool reach <method>' and provide
>> input to stdin that describes the inputs to the method. Currently, we
>> only implement the ref_newer method, which requires two commits. Use
>> lines "A:<committish>" and "B:<committish>" for the two inputs. We will
>> expand this input later to accommodate methods that take lists of
>> commits.
> It would be nice if "A" and "B" were "ancestor" and "descendant" (or
> something like that) instead, so that I don't have to check which
> direction the reach is calculated in.

Different methods will use different combinations. I do notice that I 
forgot to list the method parameters as part of the test-tool output. It 
should print "ref_newer(A,B)" so you know which input goes in which place.

>
>> +int cmd__reach(int ac, const char **av)
>> +{
>> +	struct object_id oid_A, oid_B;
>> +	struct strbuf buf = STRBUF_INIT;
>> +	struct repository *r = the_repository;
>> +
>> +	setup_git_directory();
>> +
>> +	if (ac < 2)
>> +		exit(1);
>> +
>> +
>> +	while (strbuf_getline(&buf, stdin) != EOF) {
>> +		struct object_id oid;
>> +		struct object *o;
>> +		struct commit *c;
>> +		if (buf.len < 3)
>> +			continue;
>> +
>> +		if (get_oid_committish(buf.buf + 2, &oid))
>> +			die("failed to resolve %s", buf.buf + 2);
> You can also use skip_prefix() instead of using arithmetic to determine
> the start of the OID.
>
>> +# Construct a grid-like commit graph with points (x,y)
>> +# with 1 <= x <= 10, 1 <= y <= 10, where (x,y) has
>> +# parents (x-1, y) and (x, y-1), keeping in mind that
>> +# we drop a parent if a coordinate is nonpositive.
>> +#
>> +#             (10,10)
>> +#            /       \
>> +#         (10,9)    (9,10)
>> +#        /     \   /      \
>> +#    (10,8)    (9,9)      (8,10)
>> +#   /     \    /   \      /    \
>> +#         ( continued...)
>> +#   \     /    \   /      \    /
>> +#    (3,1)     (2,2)      (1,3)
>> +#        \     /    \     /
>> +#         (2,1)      (2,1)
>> +#              \    /
>> +#              (1,1)
> This is quite a good design, thanks.
>
>> +# We use branch 'comit-x-y' to refer to (x,y).
> s/comit/commit/
>
>> +	git show-ref -s commit-7-7 | git commit-graph write --stdin-commits &&
>> +	mv .git/objects/info/commit-graph commit-graph-half &&
> My understanding is that this writes for 7-7 and all its ancestors,
> but...
>
>> +test_expect_success 'ref_newer:hit' '
>> +	cat >input <<-\EOF &&
>> +		A:commit-5-7
>> +		B:commit-2-3
>> +	EOF
>> +	printf "ref_newer:1\n" >expect &&
>> +	test_three_modes ref_newer
>> +'
>> +
>> +test_done
> ...both 5-7 and 2-3 are ancestors of 7-7, right? Which means that you
> don't test the "half" commit graph here. (It's probably sufficient to
> just adjust the numbers.)

Good point! Thanks. I'll just write the commit-graph starting at 
commit-5-5 and that should satisfy the point of the "mixed-mode" tests.

-Stolee

