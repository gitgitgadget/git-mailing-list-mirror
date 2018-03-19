Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5856E1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 13:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933002AbeCSNKQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:10:16 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35952 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932883AbeCSNKP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:10:15 -0400
Received: by mail-qt0-f196.google.com with SMTP id a20so829196qtj.3
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=P1ZASZzHQtcJHu6jHsQtSKODPflI1Lm7YVYeMOD2SCA=;
        b=VyZILW57ZCCw1aYKgOemtH00mEvU8U/vblfEeQ3360lcFQFTAVi1pV6pfosTCCxudP
         2R87fO67gIciRPPKCUnDnrdOEA0MAPakLKIqXD06Wop5Ncj0x6kVngHcp3OtFRbo18wm
         4eZHvde3c/A94AIunjMgIB4kuotXliDkZ322NW9O1SP38uxaa05j+rrfuOG6+xMwoGMs
         M+hM+TQUCeEMQsUOvG9236WHLMQi2rwIX1xDDFe2w9awsBl67q3HLq4yxx/u+3/EkUfJ
         REG5zfQAXP9RsKB8e7ECEJuHPyW/q/HHnTUTIeN3mMEVTFBYAriZRVRJgYJVdFVSzb8+
         Wqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=P1ZASZzHQtcJHu6jHsQtSKODPflI1Lm7YVYeMOD2SCA=;
        b=oaqBZ6PCVvpQaUOEZvp+FodBI1Gca4HgkI9C4MWv3TGSzOQGThJW6Qmw1+eBd2HbUq
         Aaaw4A9FQd9srrBtayGo6pmm6pn9mu+izXjEiHJZjpDzV0MF/HYy89cvSkieYUl2hOVN
         NCCWhO7qNHdcCE35R/fZHPztfJqAptSyA08+1Qb7zRVbiv8iQo8hk08IwyVBQGKOBj00
         a9fOdpDZKI2yqIB7i+l2A37gYwoliy0HSxY7bS2xYE1L5AuATwPu8u6Qnhd7fesSoRRC
         U/WMoPjZdKtfDG/TUV/Z/8ibWjygJRbKB2LSgzcWRugimqwxqDe7CZMlKXnWpfTGtC0O
         I2bA==
X-Gm-Message-State: AElRT7H8NCoiI70dMM4oT1e/1O71krNUfTxXNPvv/0LTmT+tZ50feR0O
        s6YHX1ZAcPMz05HFdmvKHsg=
X-Google-Smtp-Source: AG47ELutHByf+XqeIdUqRGjjSOMmbg6EPawS5BgbVgWmENqryX4SG1buGaNwRxoNKQlRIq8gm5NSrA==
X-Received: by 10.200.58.229 with SMTP id x92mr18180088qte.46.1521465014148;
        Mon, 19 Mar 2018 06:10:14 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id 61sm4460630qtc.49.2018.03.19.06.10.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:10:13 -0700 (PDT)
Subject: Re: [PATCH v6 00/14] Serialized Git Commit Graph
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
 <20180314192736.70602-1-dstolee@microsoft.com>
 <xmqq605yz8ue.fsf@gitster-ct.c.googlers.com>
 <54BC2335-72B3-404E-AA4A-368DEB121C8E@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e9062408-0983-2e47-4338-4ab1823bb9bd@gmail.com>
Date:   Mon, 19 Mar 2018 09:10:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <54BC2335-72B3-404E-AA4A-368DEB121C8E@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/16/2018 12:28 PM, Lars Schneider wrote:
>
>> On 14 Mar 2018, at 21:43, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Derrick Stolee <stolee@gmail.com> writes:
>>
>>
>>> Hopefully this version is ready to merge. I have several follow-up topics
>>> in mind to submit soon after, including:
>> A few patches add trailing blank lines and other whitespace
>> breakages, which will stop my "git merge" later to 'next' and down,
>> as I have a pre-commit hook to catch them.
> @stolee:
>
> I run "git --no-pager diff --check $BASE_HASH...$HEAD_HASH" to detect
> these kinds of things. I run this as part of my "prepare patch" [1] script
> which is inspired by a similar script originally written by Dscho.
>
> Do you think it would make sense to mention (or even
> recommend) such a script in your awesome GfW CONTRIBUTING.md?
>
>
> - Lars
>
>
> [1] https://github.com/larsxschneider/git-list-helper/blob/master/prepare-patch.sh#L71
>

Thanks for the suggestions. Somehow I got extra whitespace doing 
copy/paste in vim and I never re-opened that file in my normal editor 
(VS Code with an extension that shows trailing whitespace).

On 3/15/2018 1:23 PM, Johannes Schindelin wrote:
> git log --check`
> was introduced to show you whitespace problems). If all of those
> whitespace issues are unintentional, you can fix them using `git rebase
> --whitespace=fix` in the most efficient way.

Thanks for both of the suggestions. The `rebase` check was already in 
the document, so I put the checks immediately above that line. PR is 
available now [1].

Thanks,
-Stolee

[1] https://github.com/git-for-windows/git/pull/1567
