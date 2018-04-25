Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87CF51F424
	for <e@80x24.org>; Wed, 25 Apr 2018 00:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750841AbeDYAVI (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 20:21:08 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33583 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeDYAVH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 20:21:07 -0400
Received: by mail-wr0-f195.google.com with SMTP id o4-v6so1341009wrm.0
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 17:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nRZEh9XXSVKyiGvEL8/lBeywjOxSXKyN3WR5g+XqrKY=;
        b=Lcw2mzHw5D7kpLyI4bkayENkvZD2PftaxCWPT68Jtwvv96QbS48wBN3epXfesE2Jg6
         M/l610Xklep1ygI3QqpDFWDVeZN23kttrsXzjEeMc6Th6UzK9b4i+jngBkGlbHvTg/YE
         /LZ5lyJuOZR1BZ4qwLabrB7n0E8lmH0gC0T7vuBXT/uca6eyGurPG9VmM+Akm76ubUV+
         BXFGyIBU+2dPqyAQ/+wn5tqUzYoaiPlmT97P/jCoTp7PIdKpY7I4lOdLVK5dp8BgYZnT
         6r0JiWAw1wIvK0cMtJslgUq9TdFpTSmjE2HgSN+Dvrl4VUR+zHkyFHPU1mf73RjKJ0xd
         /W1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nRZEh9XXSVKyiGvEL8/lBeywjOxSXKyN3WR5g+XqrKY=;
        b=uFU8H4dZM937hZ+TxnKH0Lm4kZHP3YcmdbneKODKK+FK6VkMpAfKD8I9tP79WC2rR6
         o3VUP3R2BkUUIEPY9mN0i9j27lvp8jXeEMeKK/14C44z6zg2Frc95Yh4/OYRI8RVhgQh
         E+3bg8QN/reZ/HB3RpgLkNzt2ZJyBI5Lyw4n1CvL5ovTW1ndjeDNTdaNO/HJPhgT4Mz/
         2JOQbfcho+mfJdfFJjIZvhKvsFdGM9ri7PyiYOzcttSgdA92w+YNpVaLIvLM3oHJAlrh
         lK/BHiKNfgZkh4v//GgimcJMgRF5K2n9dlxpwvYMoSk6QDdxni3apcf1Xq52uGzMGtPM
         oFrg==
X-Gm-Message-State: ALQs6tC13k/G+stR7olnWyO6c/OzRJ9JfZWhuWFl1hZ7OHu7i9PDsX7I
        G/eFfTbjGZ8r/2kwR7S4+7I=
X-Google-Smtp-Source: AIpwx4+TS1aVXxYY2uP1s3kRAMF+T4NiDFP0ZQbLutQ0su+sVgkSsNNcTQoYj3Yb9RgStB65LWreRw==
X-Received: by 2002:adf:9986:: with SMTP id y6-v6mr21794099wrb.40.1524615665726;
        Tue, 24 Apr 2018 17:21:05 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l15-v6sm15280029wrb.85.2018.04.24.17.21.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 17:21:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/9] packfile: add repository argument to packed_object_info
References: <20180423234327.250484-1-sbeller@google.com>
        <20180423234327.250484-6-sbeller@google.com>
        <20180424111616.bc81c1d16f1c511a497891ed@google.com>
Date:   Wed, 25 Apr 2018 09:21:04 +0900
In-Reply-To: <20180424111616.bc81c1d16f1c511a497891ed@google.com> (Jonathan
        Tan's message of "Tue, 24 Apr 2018 11:16:16 -0700")
Message-ID: <xmqq8t9c5e6n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> On Mon, 23 Apr 2018 16:43:23 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
>> diff --git a/sha1_file.c b/sha1_file.c
>> index 93f25c6c6a..b292e04fd3 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -1307,7 +1307,8 @@ int oid_object_info_extended_the_repository(const struct object_id *oid, struct
>>  		 * information below, so return early.
>>  		 */
>>  		return 0;
>> -	rtype = packed_object_info(e.p, e.offset, oi);
>> +
>> +	rtype = packed_object_info(the_repository, e.p, e.offset, oi);
>
> Extra blank line introduced.

Yes, but from the way this function is formatted, I think the
new paragraph break there makes sort of sense.
