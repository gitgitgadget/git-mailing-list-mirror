Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3ED91F461
	for <e@80x24.org>; Wed, 26 Jun 2019 16:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfFZQr2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 12:47:28 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43399 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfFZQr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 12:47:28 -0400
Received: by mail-qt1-f195.google.com with SMTP id w17so3078429qto.10
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 09:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+5r33IBAArBigNx3jnF5jKaRtlXnTZ1h8uTWV64hiNs=;
        b=l7lPBDwi4DGhym+v35dufwIITinqscCYVDkjXNnjcRRJrRrCMsCB8uugKzVOx91D7B
         TPDuXMKWWVPYmiN5OfKLnTYX+EGWOOCDTW/ZpZ8gBQbtJgiTg3JHHz06wFKcUrxGBDZY
         f6YHUemWkWc+NPghnMzH2y7NKGh9XFm30uxfVsxYWb4FvkwBEG1FcLUAwEqxL958K63W
         9gKZ1XCKbD5N03kkjtOFwEVV2DLAavy5rHvTGmcfs+eTFb9og7nT6e5PsGlKZZos40aR
         Puw6hr7SgktcWamCkUaggm5oRzwJRrAEzwR4/KNcW+2tKYr9oWs4GH4nBS9QCms+C4W4
         2P+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+5r33IBAArBigNx3jnF5jKaRtlXnTZ1h8uTWV64hiNs=;
        b=ahK8rU4IAXPTo2fhGXqCyP9btki8Y5N+jfOyO6+wrLY8MF6tiK5r7V9HTwdXlj39z5
         dH7bWMkMp/Wia/upAJtSk9dkL+d3H+vbIBlRsHN/rvAstmEMzAyuJ25SHQ2GmYELmMeM
         9R0fNDCAAvL0/7vld6At1xeR3dgcmCjrhbvwJyLOiez38EcxJMvxgKVGKM9/6eY1zShA
         Z+qAxBldYfNPUINby7EnQ+RXaqs0JFT0lvCW3cZdtroKKsxw+fkjrAHC6vbsOOXnHo0Y
         7I3DU/q71Z2OoZunyer4j+WE5BLsg1DTopeHo7AX1sWpBva2BFvUUIPO6gqbfYExwqBp
         PHFg==
X-Gm-Message-State: APjAAAXVRtLFM3qcaw7Kr+2YMCcywOy60ENEA5zKSTwK5Z4bpn5gSlN7
        AL6bQI+0i7M3JoC0tSl9d2wjryZW
X-Google-Smtp-Source: APXvYqyt9ObjB8d3g84LTqrMT9Fhc+PF52/3diabZnjkXkCodqBZWhsI+Q10NmnBeqn9gwflzl/UZQ==
X-Received: by 2002:a0c:93a3:: with SMTP id f32mr4387186qvf.14.1561567647278;
        Wed, 26 Jun 2019 09:47:27 -0700 (PDT)
Received: from [10.0.1.15] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id v17sm10744762qtc.23.2019.06.26.09.47.25
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 09:47:26 -0700 (PDT)
Subject: Re: [PATCH 2/6] tree-walk.c: remove the_repo from
 fill_tree_descriptor()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20190624095533.22162-1-pclouds@gmail.com>
 <20190624095533.22162-3-pclouds@gmail.com>
 <a2d91c63-86ca-90e7-0087-09df269d3865@gmail.com>
 <xmqqblyke2hx.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2f4c3024-d787-6865-f3f9-a3f43a27a94f@gmail.com>
Date:   Wed, 26 Jun 2019 12:47:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <xmqqblyke2hx.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/26/2019 12:27 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>>> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
>>> index 34ca0258b1..97b54caeb9 100644
>>> --- a/builtin/merge-tree.c
>>> +++ b/builtin/merge-tree.c
>>> @@ -205,6 +205,7 @@ static void resolve(const struct traverse_info *info, struct name_entry *ours, s
>>>  static void unresolved_directory(const struct traverse_info *info,
>>>  				 struct name_entry n[3])
>>>  {
>>> +	struct repository *r = the_repository;
>>
>> I like this trick to make the change below minimal:
>>> +	buf0 = fill_tree_descriptor(r, t + 0, ENTRY_OID(n + 0));
>>> +	buf1 = fill_tree_descriptor(r, t + 1, ENTRY_OID(n + 1));
>>> +	buf2 = fill_tree_descriptor(r, t + 2, ENTRY_OID(n + 2));
>>
>> I wonder if _every_ conversion should include this trick,
>> so when we move to change that method we simply move the definition
>> from the method block to the prototype. (No need to adjust what you've
>> done already, just an idea for future conversions.)
> 
> Hmm, interesting.  So those callers in builtin/rebase.c::reset_head()
> and other places that adds the_repository as the new first parameter
> can take a local variable "r" (or perhaps a bit more descriptive,
> e.g. "repo") that is initialized to "the_repository" (and never
> reassigned at least at this step) in this same patch?

Yes, that is what I was thinking. It means that we can stop munging
the function calls for the method that is converted. When the caller
is updated, the call site already uses "r" but we change how "r" is
initialized (as a parameter instead of a local variable).

Thanks,
-Stolee
