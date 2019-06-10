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
	by dcvr.yhbt.net (Postfix) with ESMTP id A99F71F462
	for <e@80x24.org>; Mon, 10 Jun 2019 10:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389549AbfFJKkU (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 06:40:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46231 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389476AbfFJKkU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 06:40:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so8585384wrw.13
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 03:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mUtzsLC9xlEY6SY4UHvzVhelZZDxKZTPxxbaALtdfaM=;
        b=rW+c3mh2upXNgcJP3dqffFqK+s3ztyPQCzAm57g1MX+KKW0zi5ez6+UPZOil34fDzq
         Cvdt9LM6X4vylQV9LI0L3roin5fV3GWiOA2xayLwg71qa2UhZZ2wrjmbW4+QzALX76g4
         EHeZdLrkScVzmnozBzcE+u9aSJ4SStxTvx50tJ6ZKFx31DF0iuz0DHmkXKuAKEsWnqFX
         8TiJkjgnBaBqiTHI+GwXRLdWSHYp0CYrasL7P0f4ARzS/cIuFL2qnLhTaPbFExu0qYtj
         MvjyS+sepJFuIGBPWD9XLlmRsQwSqO7QX8q/PU5+9WoIQOcTRnRv3oJJq7k4iLtdPPqR
         AJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mUtzsLC9xlEY6SY4UHvzVhelZZDxKZTPxxbaALtdfaM=;
        b=e97bexpOmVnu7Zs8LulzyrTHYXAjp/vZ2n1yHoJhEZKi5MKCfr5gDlu7rv8HVQRPvJ
         rW05OwzRK2CKiZoRrZYbF6iT5RI0QeOfr2PYUz/6KmvfCin9bB0PatvucfqQwdpUHXmC
         eI/+TV+Qp7MmOHOHMKj2ooaFrMpJkr/bltE/fgwzhkrBlmBdEOoIPD1/nQSHhPTL5aD3
         ZNd6luw5JuEjhpdDDOuY8WnXAdXi0gFNOg+1OrxHEQy75YTO7j74ehlKVk8oQ/XMcFs9
         Cz9CVXrJ21LzJM3D1k7Ar+E2Ss3e0tivTn5MAw7JY0sbe/lgKRZYlIziIpbE+Ni5Ciwq
         nSjA==
X-Gm-Message-State: APjAAAXV+br3FGqF4hryg/xmdy/OaFF9rZxJnfXLhplMFXqeGBSq54+b
        wotVQ1ylnX0nR3v6PhDAz1UKzwPN
X-Google-Smtp-Source: APXvYqzv1x7D+xDILxbmkNLakwDno/XCOJdAP3USC9IRBFBBeZnYZdPgApZ5T4GQUuAQYS27hRyYLQ==
X-Received: by 2002:adf:f18d:: with SMTP id h13mr13382328wro.120.1560163219061;
        Mon, 10 Jun 2019 03:40:19 -0700 (PDT)
Received: from [192.168.2.201] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.googlemail.com with ESMTPSA id d10sm15402857wrh.91.2019.06.10.03.40.18
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 03:40:18 -0700 (PDT)
Subject: Re: [GSoC][PATCH 3/3] cherry-pick/revert: update hints
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com
References: <61a8bfde-018c-5a69-5abd-89d4a332e39e@gmail.com>
 <20190610052823.17013-1-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <72b44513-1182-8172-94aa-ca69730d9a22@gmail.com>
Date:   Mon, 10 Jun 2019 11:40:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610052823.17013-1-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit

On 10/06/2019 06:28, Rohit Ashiwal wrote:
> Hey Phillip
> 
> On Sun, 9 Jun 2019 19:03:02 +0100 Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Rohit
>>
>> On 08/06/2019 20:19, Rohit Ashiwal wrote:
>>> [...]
>>> @@ -2654,8 +2654,8 @@ static int create_seq_dir(void)
>>>  {
>>>  	if (file_exists(git_path_seq_dir())) {
>>>  		error(_("a cherry-pick or revert is already in progress"));
>>> -		advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
>>> -		advise(_("or  \"git revert (--continue | --quit | --abort)\""));
>>> +		advise(_("try \"git cherry-pick (--continue | --skip | --quit | --abort)\""));
>>> +		advise(_("or  \"git revert (--continue | --skip | --quit | --abort)\""));
>>
>> If the user has already committed the conflict resolution then we don't
>> want to recommend --skip as there is nothing to skip.
> I think it is more about suggesting what are all the possibilities
> you can try and not about intelligently suggesting what you should
> do.

Previously all the suggested options were viable, --skip is not
applicable if the user has committed a conflict resolution. The idea of
the advice is to help the user, suggesting options that wont work is not
going to help them.

> ofc, we can not use `revert --<option>` while cherry-picking.(

As I suggested in patch 1 we should tailor the error message to the command.

> we should not be able to do so in ideal conditions, but the world
> does not work as we think it should). Still we are suggesting so
> here.

Yes because you have the power to easily make that change. It is normal
to try and improve the code base when we make related changes.

> Also, I think it is more reasonable to make "this" a part of patch
> which will cover "tailored" advice messages which is also a topic
> of discussion as I described here[1].

That might make sense, but it is a pretty self contained change as part
of this patch.

Best Wishes

Phillip

> 
>> Best Wishes
>>
>> Phillip
> 
> Thanks
> Rohit
> 
> [1]: https://public-inbox.org/git/20190609200038.GD28007@hank.intra.tgummerer.com/T/#mbb071f6e29c69f291ecd9c61c71b889774ff33b2
> 

