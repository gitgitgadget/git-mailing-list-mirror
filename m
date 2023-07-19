Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6B9C001B0
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 22:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjGSWQb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 18:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGSWQa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 18:16:30 -0400
X-Greylist: delayed 697 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Jul 2023 15:16:26 PDT
Received: from mail-gateway-shared13.cyon.net (mail-gateway-shared13.cyon.net [194.126.200.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5581BCF
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 15:16:26 -0700 (PDT)
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared13.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <dev+git@drbeat.li>)
        id 1qMFHr-0008QZ-0j
        for git@vger.kernel.org;
        Thu, 20 Jul 2023 00:04:47 +0200
Received: from [10.20.10.232] (port=52338 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.96)
        (envelope-from <dev+git@drbeat.li>)
        id 1qMFHq-00GvZm-01;
        Thu, 20 Jul 2023 00:04:46 +0200
Message-ID: <98b86433-053b-c44e-05a9-b2e3afd4b4f0@drbeat.li>
Date:   Thu, 20 Jul 2023 00:04:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RFC] short help: allow a gap smaller than USAGE_GAP
Content-Language: de-CH
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq5y6gg8fn.fsf@gitster.g> <xmqqttu0esqb.fsf@gitster.g>
 <xmqqlefcesjr.fsf_-_@gitster.g>
From:   Beat Bolli <dev+git@drbeat.li>
In-Reply-To: <xmqqlefcesjr.fsf_-_@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On 19.07.23 00:58, Junio C Hamano wrote:

[...]
> diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
> index 00fa281a9c..a4f6e24b0c 100644
> --- a/t/helper/test-parse-options.c
> +++ b/t/helper/test-parse-options.c
> @@ -133,6 +133,8 @@ int cmd__parse_options(int argc, const char **argv)
>   		OPT_STRING(0, "st", &string, "st", "get another string (pervert ordering)"),
>   		OPT_STRING('o', NULL, &string, "str", "get another string"),
>   		OPT_NOOP_NOARG(0, "obsolete"),
> +		OPT_SET_INT_F(0, "longhelp", &integer, "help text of this entry\n"
> +			      "spans multiple lines", 0, PARSE_OPT_NONEG),
>   		OPT_STRING_LIST(0, "list", &list, "str", "add str to list"),
>   		OPT_GROUP("Magic arguments"),
>   		OPT_NUMBER_CALLBACK(&integer, "set integer to NUM",

I think this chunk should be part of the previous commit.

Beat

