Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFB9C54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 02:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjAICgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 21:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjAICgK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 21:36:10 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A1965EA
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 18:36:08 -0800 (PST)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 3092a6IP092425
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 8 Jan 2023 21:36:06 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'fawaz ahmed0'" <fawazahmed0@hotmail.com>, <git@vger.kernel.org>
References: <PH7PR12MB779560B6C003FEE76E4F2471F1FE9@PH7PR12MB7795.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB779560B6C003FEE76E4F2471F1FE9@PH7PR12MB7795.namprd12.prod.outlook.com>
Subject: RE: Reducing Git Repository size - git-filter-repo doesn't help
Date:   Sun, 8 Jan 2023 21:36:02 -0500
Organization: Nexbridge Inc.
Message-ID: <017d01d923d3$20b90bd0$622b2370$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQLFZwar+6Vda1cHq6+VSciPpAhKjqy814uA
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 8, 2023 9:22 PM, fawaz ahmed0 wrote:
>I have this huge repo: https://github.com/fawazahmed0/currency-api#readme
>and I am trying to reduce its size.
>
>I have run filter-repo script on this repo (
>https://github.com/fawazahmed0/currency-
>api/blob/1/.github/workflows/cleanup-repo.yml ) The commits were reduced
>from 1k to 600 , but the space used is still same. (i.e size-pack: 6.47 GiB
,
>https://github.com/fawazahmed95/currency-
>api/actions/runs/3865919157/jobs/6589710845#step:5:1498 )
>
>Almost all commits of this repo were applied on partially cloned
repository: (
>https://github.com/fawazahmed0/currency-
>api/blob/1/.github/workflows/run.yml ) So I guess it had never run any git
>maintenance task in it's life.
>
>I am not sure what needs to be done to reduce it's space utilization. (
>https://docs.github.com/en/repositories/working-with-files/managing-large-
>files/about-large-files-on-
>github#:~:text=less%20than%205%20GB%20is%20strongly%20recommended )

The first thing you can try is 'git gc --aggressive' to reduce the clone
size. Github automatically does garbage collection. If this is a question of
the size of the working index, look at the sparse-checkout command.

--Randall

