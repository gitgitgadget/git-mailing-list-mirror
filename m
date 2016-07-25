Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3E8F203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 17:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326AbcGYReH (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 13:34:07 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35998 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322AbcGYReG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 13:34:06 -0400
Received: by mail-wm0-f68.google.com with SMTP id x83so17663660wma.3
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 10:34:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=/FRh1FhYPhU7TUetTfdeAAxYvJ+o4H0IdWAzfH6SzR4=;
        b=VQ91rR1cB1C1jPKmeSmok/i9rZWi+qXjPL6WDeXqiTHncrw40Dd9br+QuaXf8QbEI3
         QYCa6NyN8qAuZ0zh/Nm2b0P0/jC3FAgKWDOAYlXr5GGW4sxUvz9GqJgwjlm36QKXezGA
         PPAD04jfiMpPZ+TSmqDb5NzZdLuWdD56QQiuBl8xudtMHw2t8qqfBWVoAA7vit3yWjmn
         nSdFAODcJgaJWfZUZG+61l8r408stMhiYr8KmzYrSthbcZ/jqZD9U7U4qiG+7VCEXC4w
         8J9yTWve7pN2ulDAde+dKjYiDhUUR5oP9pc9zJ8H2crhkI9vfojaNAMnoH6DRFkZ8E5P
         TSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=/FRh1FhYPhU7TUetTfdeAAxYvJ+o4H0IdWAzfH6SzR4=;
        b=gjkimXMwrVayLxQzMDs44YYdyNt9awoD9+qRohAG/exb1Ir1ThSqFyjnz21H9qLd6t
         l+SRc6Qtt5gAUAzUN0nRQIRRe02Dx2T05BZ5VKdlw5sR8cgrHyk/Mt08EdmUe9qTemOE
         hX1r/NCkgS81cTl2JMWzKi82q+7K4UKw5GkQukCUVgSjm1Gu9TPqnsdpcfgmd52/MYo8
         1K2FuYhIiENRyi/YLsPi57kN/trjKJ+UCEIj2G290Nqi8B7hsII1Z/yGA/8JVSeLQGl5
         5qju4NphX3fuyKWceWvWPYBpM5643/AYWta844NwqNT70Zoz2TFWUw3472V0gFnOC0s7
         zzZQ==
X-Gm-Message-State: AEkoouuBEupj3ay8jXpM3rharJdBT2Nr8Ondc5cN5wnRdb1D5fqSbxMLzZZ5qXnwE0oyGQ==
X-Received: by 10.28.48.71 with SMTP id w68mr20371698wmw.4.1469468044071;
        Mon, 25 Jul 2016 10:34:04 -0700 (PDT)
Received: from [192.168.1.26] (dax80.neoplus.adsl.tpnet.pl. [83.23.23.80])
        by smtp.googlemail.com with ESMTPSA id e65sm28534825wmg.3.2016.07.25.10.34.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jul 2016 10:34:03 -0700 (PDT)
Subject: Re: [RFC] git subcommand to check if branch is up-to-date with
 upstream
To:	Junio C Hamano <gitster@pobox.com>,
	Sidhant Sharma <tigerkid001@gmail.com>
References: <57960CFF.5060104@gmail.com>
 <xmqqd1m17iyb.fsf@gitster.mtv.corp.google.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <57964D7F.90402@gmail.com>
Date:	Mon, 25 Jul 2016 19:33:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqd1m17iyb.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-25 o 18:58, Junio C Hamano pisze:
> Sidhant Sharma <tigerkid001@gmail.com> writes:
> 
>> I was wondering if it would be a good idea to have a command to check if a
>> push or pull is required. Perhaps it can also suggest if changes are
>> fast-forward or the branches (local and remote) have diverged.
> 
> Doesn't "branch -v" give that information these days?  You'd need to
> "fetch" first to get the up-to-date worldview before running it, of
> course.

You need "branch -v -v". For current branch, you can simply run "git checkout".
All this is the information for end user, not scripts.

$ git branch -v -v
* gitweb-docs   4ebf58d [origin/master: ahead 1] gitweb(1): Document query parameters
  master        08bb350 [origin/master] Sixth batch of topics for 2.10

$ git checkout
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)

-- 
Jakub Narêbski

