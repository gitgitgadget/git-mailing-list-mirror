Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ABCC1FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 22:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751806AbdBHW2m convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 8 Feb 2017 17:28:42 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:23519 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751433AbdBHW2l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 17:28:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id CDBD21E1872;
        Wed,  8 Feb 2017 23:28:37 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jLsgrYRvIH6B; Wed,  8 Feb 2017 23:28:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 32C0D1E3038;
        Wed,  8 Feb 2017 23:28:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xIWXejO1XUU2; Wed,  8 Feb 2017 23:28:37 +0100 (CET)
Received: from [192.168.178.36] (aftr-185-17-206-26.dynamic.mnet-online.de [185.17.206.26])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id BF8351E1872;
        Wed,  8 Feb 2017 23:28:36 +0100 (CET)
Subject: Re: [PATCH v4] tag: generate useful reflog message
To:     Junio C Hamano <gitster@pobox.com>
References: <20170206222416.28720-1-cornelius.weig@tngtech.com>
 <xmqqpoiv15ew.fsf@gitster.mtv.corp.google.com>
 <20170206222416.28720-2-cornelius.weig@tngtech.com>
 <xmqqshnov0c4.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, karthik.188@gmail.com, peff@peff.net,
        bitte.keine.werbung.einwerfen@googlemail.com
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <d0170d3a-3022-3bca-7c80-7ef0b1cf62a0@tngtech.com>
Date:   Wed, 8 Feb 2017 23:28:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqshnov0c4.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 02/08/2017 10:28 PM, Junio C Hamano wrote:
> cornelius.weig@tngtech.com writes:
> 
>> From: Cornelius Weig <cornelius.weig@tngtech.com>
>>
>> When tags are created with `--create-reflog` or with the option
>> `core.logAllRefUpdates` set to 'always', a reflog is created for them.
>> So far, the description of reflog entries for tags was empty, making the
>> reflog hard to understand. For example:
>> 6e3a7b3 refs/tags/test@{0}:
>>
>> Now, a reflog message is generated when creating a tag, following the
>> pattern "tag: tagging <short-sha1> (<description>)". If
>> GIT_REFLOG_ACTION is set, the message becomes "$GIT_REFLOG_ACTION
>> (<description>)" instead. If the tag references a commit object, the
>> description is set to the subject line of the commit, followed by its
>> commit date. For example:
>> 6e3a7b3 refs/tags/test@{0}: tag: tagging 6e3a7b3398 (Git 2.12-rc0, 2017-02-03)
>>
>> If the tag points to a tree/blob/tag objects, the following static
>> strings are taken as description:
>>
>>  - "tree object"
>>  - "blob object"
>>  - "other tag object"
>>
>> Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
>> Reviewed-by: Junio C Hamano <gitster@pobox.com>
> 
> This last line is inappropriate, as I didn't review _THIS_ version,
> which is different from the previous one, and I haven't checked if
> the way the comments on the previous review were addressed in this
> version is agreeable.

Sorry for that confusion. I'm still not used to when adding what
sign-off is appropriate. I thought that adding you as reviewer is also a
question of courtesy.

A version with revised tests will follow.
