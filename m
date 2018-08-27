Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE0721F404
	for <e@80x24.org>; Mon, 27 Aug 2018 23:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbeH1DM0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 23:12:26 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:36833 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727128AbeH1DM0 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Aug 2018 23:12:26 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C3C392A8
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 19:23:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 27 Aug 2018 19:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stason.org; h=
        content-transfer-encoding:content-type:date:from:message-id
        :mime-version:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=y/sFiB8NBIy2tOmkL503S0476xXcJiLoDjD4iW139P8=; b=JCo3l8qN
        Qxk6/SxpbEm6QkmTRs0n1yXCxhXvTVvzb5Q2ZYTc54vl4pBp4DVWdKbnd1izBCiX
        mz5pAzEWTSk8qBy5zZUx3Ktx3kEv8OGWjik9JvNh1hS/DG74DdScIvuCcKhnMwL5
        1MwUEJYuCNirT9+9j+w3+pg04f3kTtrJzEnd+IqJyI2KHmEKtRVOZvEg4N+ci4lv
        VQ+I8s80Qpgs4ol5oM45cT8XwwbOgFVF6+Kys1cnOQjushoMemL9ReKpzLiune8v
        5t90FtCoMGAWxmrr4zhHxZZU7uEEb5qboK0K2BO6DwS0j2v9MI8npabuPwrlGglg
        SfzNSUigOas9xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=y/sFiB8NBIy2tOmkL503S0476xXcJ
        iLoDjD4iW139P8=; b=VVVPOMsiBVHLq7exsjplQCQWOy58iunD2B3l4vRNPHTCV
        V7SaROhPyTMjIQWfQ20TnPwnY9vvUb3De1wAJpsVaYfaN40SNwJHI4ggWjo3TnA5
        lF2It9CRbSa07M3y+kZ4lHCbdS/cxaBmEsjTdTC2oGIC4U7fs+xrZysu0quesyEK
        AFybuzgIiYZLaBdZPAHn2vbVmXpCsH7TKY4yrG1cj8feZUb2yp/TvYkydzgMkm1f
        qpmKWKMqR6M2AZK0ASR+rgody7XUfKQxs9Uut0xO2anGupudZAaihKZ0jwkk0oah
        Tc1Rv9GqIUGEwhzQRVvaBzve0Y5IQTy6YUoB64X0Q==
X-ME-Proxy: <xmx:94eEW6IseLGPr9iAUq0dr8WjNUngLfhhRjnRu52DqbV0JRnriq0MIQ>
    <xmx:94eEW4muZjMwhDVsJWi2JK84NQpR69WoFVeuPM3qVU6HnMEakqVT2A>
    <xmx:94eEW4Ma4qG5mKvENtnULy5_63G_OWTFn9EkXFEJFxcWd3uUuYufYw>
    <xmx:94eEW3wJlZpID1JiCLj6-Z9vTLbGXxvKzH4QAJd6HCIWX7wGgbY8CQ>
    <xmx:94eEWwkjHJxUuh5LGu-mjclU5GG7ueChxgadodw0iPL_1DyMQpJATw>
    <xmx:94eEW__a2MoOoSOzuy35ZWlGOIqapSripGijRj3WYaA454w-vZ2lvQ>
X-ME-Sender: <xms:94eEW5Xct2acmO6TjX5UC3hZmfnXYhvTSeiKxICJ8vTd5awblbtMMA>
Received: from [192.168.0.10] (s0106f0f249e4dad3.gv.shawcable.net [96.54.245.187])
        by mail.messagingengine.com (Postfix) with ESMTPA id C92BEE46A1
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 19:23:34 -0400 (EDT)
To:     git@vger.kernel.org
From:   Stas Bekman <stas@stason.org>
Organization: Hope, Humanized
Subject: GIT_TRACE doesn't show content filter files it's operating on
Message-ID: <3fdc0c24-bbee-e7b3-ec43-7e926cee71e1@stason.org>
Date:   Mon, 27 Aug 2018 16:23:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm debugging the workings of a configured git content filter
(nbstripout) and I'm trying to get GIT_TRACE to show me the files it's
operating on, but it doesn't. Consider:

$ GIT_TRACE=1 git pull origin master
[...] removed irrelevant sections of the output
16:49:28.846707 run-command.c:640       trace: run_command: git merge
FETCH_HEAD
16:49:28.849309 git.c:344               trace: built-in: git merge
FETCH_HEAD
Updating 1ea49ad..ae0ba93
16:49:28.863291 run-command.c:640       trace: run_command: nbstripout
16:49:28.864700 run-command.c:640       trace: run_command: nbstripout
16:49:28.866060 run-command.c:640       trace: run_command: nbstripout
[...] many more of the same

How can I get GIT_TRACE's run_command to show the arguments passed to
the filter? I looked at various other debug environment variables in
git's manual, but I don't see anything that would enable that level of
debug.

I'm aware of git check-attr, but I'd like to see the run time trace on
which files it's running the filter on and with which arguments.

git version 2.17.1

I originally posted this as a question here:
<https://stackoverflow.com/questions/51995773/getting-git-to-show-specific-filenames-it-is-running-content-filters-on>
and it appears that sq_quote_argv_pretty() doesn't get argv when a
content filter is invoked, so it doesn't show this information.

Would it be possible to make the files and any other passed arguments
show in the trace?

Thank you.

-- 
________________________________________________
Stas Bekman       <'))))><       <'))))><
https://stasosphere.com  https://chestofbooks.com
https://experientialsexlab.com https://stason.org
https://stasosphere.com/experience-life/my-books
