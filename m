Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 240311F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 22:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387459AbfJOW7D (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 18:59:03 -0400
Received: from mail-gateway-shared12.cyon.net ([194.126.200.65]:51350 "EHLO
        mail-gateway-shared12.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727120AbfJOW7D (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 Oct 2019 18:59:03 -0400
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Oct 2019 18:59:02 EDT
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared12.cyon.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <dev+git@drbeat.li>)
        id 1iKVgA-0004h2-Ce
        for git@vger.kernel.org; Wed, 16 Oct 2019 00:52:38 +0200
Received: from [10.20.10.233] (port=16832 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.92)
        (envelope-from <dev+git@drbeat.li>)
        id 1iKVg9-0007eG-67; Wed, 16 Oct 2019 00:52:33 +0200
Subject: Re: Adding a line after the signed-off git am -s
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, git@vger.kernel.org
References: <6797ef7d-5444-4c77-59e6-1d78fd3ccb0c@linaro.org>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <8089dfce-0183-b7fb-cab8-0a71404b6584@drbeat.li>
Date:   Wed, 16 Oct 2019 00:52:32 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6797ef7d-5444-4c77-59e6-1d78fd3ccb0c@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-OutGoing-Spam-Status: No, score=-1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11.10.19 16:43, Daniel Lezcano wrote:
> 
> Hi all,
> 
> Is there a way to specify a line to be added in the change-log after the
> SOB with git-am ?
> 
> I would like to do something:
> 
> git am -s -l "Link: https://lore.kernel.org/r/<msgid>"
> 
> Which will give:
> 
> blabla
> 
> Signed-off-by: author@kairnail.org
> Signed-off-by: commiter@kairnail.org
> Link: https://lore.kernel.org/r/<msgid>
> 
> This way it is compatible with patchwork, git-pw, etc...

I think something like

    git interpret-trailer --trailer Link:https://lore.kernel.irg/r/msgid
<patch | git am -

should work.


Cheers,
Beat
