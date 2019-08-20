Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D99D91F461
	for <e@80x24.org>; Tue, 20 Aug 2019 18:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbfHTSa7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 14:30:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53467 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTSa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 14:30:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id 10so3472657wmp.3
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 11:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U6hWL3Ue+oxEI9WZi127v5jRWq9AW0F7DJl4afDJKzA=;
        b=OmC8NrQFCl0R5XcMDly5pVOYOo2b8zv/Tzc38YkWMa0bYFBGr5AcM/CQNAWNbZOtUt
         QmIDKFrRU3gKsbDy+bnxZRZQ2fAxtIi2EEuEp5vE16+u2XR2EZtTiiW0EvyNyg+OqfGw
         x2dK++ztzrX+gj/CMo9MfL1WQ20oEk8c/0+0qZn4ONGTW5u5FWmivFpGWVMvSld/G8/s
         HqN/1khQ9BjWwriEZFXvHQmlu4xicDe+WRF+CGRByKdtMI3vMkGHzTXPthuIMEph5sYM
         0YVey/4MmffuhyeUr6/DBtsbNJpea5bKaQ5LIVDvkVkkJ2swe2m+eBF320E8vyBkzI1G
         yY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=U6hWL3Ue+oxEI9WZi127v5jRWq9AW0F7DJl4afDJKzA=;
        b=S3Ocn5FMmKL3sAz++r5bCFpCRohei1o5Nr3U1mUtHeJa6OiZd+anPkwZMmGF1BumxJ
         NwFaElbm99G8FyjpO+zuOPXNGUX64tOm+gSKEbbai2vvH684EnGyU61VY0Hj+HQdCEcB
         cEjBLewJwpZWXj8TURcd9DTkHzQwO9KZF1PMMHhFA+8b31O1AceNm2frEKiEVc+S5HN2
         ghE/rKZR6P9iCVng1wke4nDDxTaCcgILj3bzXCt0j9cDvvpWLlDdSC9YUYa+xAtyLKEX
         Kpvr8a2juXXYhA4hXhLGfRCU+834wcGwJ+4i8gEntjuL+F69wutjQHu/Sc2bdd2YiXxT
         DpsQ==
X-Gm-Message-State: APjAAAVrDdJiH9b5eW5AmsBtKNALYaJb79rwW7m/SERQH/ennHgL2Kpf
        6mZJJhwtu7UqnaL9np8AARUTdgpLEYU=
X-Google-Smtp-Source: APXvYqwKr58pw9l7FYRPpmNSKu9/bi5ivZaZXDMqHsoO4lsSlAfbE03OitWv5pc/1KSIzbAJNb/FlA==
X-Received: by 2002:a05:600c:24cf:: with SMTP id 15mr1468805wmu.76.1566325856569;
        Tue, 20 Aug 2019 11:30:56 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-13-95.as13285.net. [92.22.13.95])
        by smtp.gmail.com with ESMTPSA id o9sm30367638wrm.88.2019.08.20.11.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 11:30:56 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 5/6] rebase -i: support --ignore-date
To:     Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        martin.agren@gmail.com, newren@gmail.com, t.gummerer@gmail.com
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190820034536.13071-1-rohit.ashiwal265@gmail.com>
 <20190820034536.13071-6-rohit.ashiwal265@gmail.com>
 <xmqqwof7vim6.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <3bdbcc74-0252-3d07-02b9-84789386fec6@gmail.com>
Date:   Tue, 20 Aug 2019 19:30:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqwof7vim6.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/08/2019 18:42, Junio C Hamano wrote:
> Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:
> 
>> +/* Construct a free()able author string with current time as the author date */
>> +static char *ignore_author_date(const char *author)
>> +{
>> +	int len = strlen(author);
> 
> Mental note: ignore_author_date() would not allow author==NULL as its input.
> 
>> @@ -1020,10 +1047,20 @@ static int run_git_commit(struct repository *r,
>>   
>>   		if (res <= 0)
>>   			res = error_errno(_("could not read '%s'"), defmsg);
>> -		else
>> +		else {
>> +			if (opts->ignore_date) {
>> +				char *new_author = ignore_author_date(author);
>> +				if (!author)
>> +					BUG("ignore-date can only be used with "
>> +					    "rebase, which must set the author "
>> +					    "before committing the tree");
> 
> Yet, author is used and then checked for NULL-ness, which is
> backwards.  Before we have a chance to issue this BUG(), we would
> already have segfaulted inside ignore_author_date().
> 

Good catch!
