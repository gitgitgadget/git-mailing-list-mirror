Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FBB41F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 11:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393537AbfJXLEH (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 07:04:07 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:23642 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393455AbfJXLEG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 07:04:06 -0400
Received: from [92.30.121.54] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iNauS-0001N3-7S; Thu, 24 Oct 2019 12:04:04 +0100
Subject: Re: [PATCH 1/1] repo-settings: read an int for index.version
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.420.git.1571863137.gitgitgadget@gmail.com>
 <095b43f606a352527c9e0551adbd8a6af2061176.1571863137.git.gitgitgadget@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <e32c2694-e86c-0b93-a680-36b367f4258e@iee.email>
Date:   Thu, 24 Oct 2019 12:04:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <095b43f606a352527c9e0551adbd8a6af2061176.1571863137.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

spelling nit.

On 23/10/2019 21:38, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee<dstolee@microsoft.com>
>
> Several config options were combined into a repo_settings struct in
> ds/feature-macros, including a move of the "index.version" config
> setting in 7211b9e (repo-settings: consolidate some config settings,
> 2019-08-13).
>
> Unfortunately, that file looked like a lot of boilerplate and what is
> clearly a factor of copy-paste overload, the config setting is parsed
> with repo_config_ge_bool() instead of repo_config_get_int(). This means

s/_ge_bool()/_get_bool()/
> that a setting "index.version=4" would not register correctly and would
> revert to the default version of 3.
>
> I caught this while incorporating v2.24.0-rc0 into the VFS for Git
> codebase, where we really care that the index is in version 4.
>
> This was not caught by the codebase because the version checks placed
> in t1600-index.sh did not test the "basic" scenario enough. Here, we
> modify the test to include these normal settings to not be overridden by
> features.manyFiles or GIT_INDEX_VERSION. While the "default" version is
> 3, this is demoted to version 2 in do_write_index() when not necessary.
>
> Signed-off-by: Derrick Stolee<dstolee@microsoft.com>
> ---
Philip
