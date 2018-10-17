Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16CFE1F453
	for <e@80x24.org>; Wed, 17 Oct 2018 01:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeJQJUE (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 05:20:04 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50823 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726936AbeJQJUD (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 Oct 2018 05:20:03 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 8039521F73;
        Tue, 16 Oct 2018 21:26:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 16 Oct 2018 21:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stason.org; h=
        subject:to:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=l
        MQ89ta2bwiXiqJ7/gWiMnTktQhe9qxcH1icImuPmmk=; b=hagir1GDrfeOryceB
        8nYOcRtBxn2Cm12O2ONmWxMzmCVgFEUmLs5yOUVTA6MWxkp/BaJQZ7CW7VESL5jH
        sH3Uwp1T9YBekJJwHekkdUBHhUD/ZGJQ5LRBqqhF4H6G7+OBESnSGAn3PmKL0eXm
        z242nKQMcTz1pj+h7vKyIuWrUVFnaqvQ8CruoR0GF7bywO89jjj8q6334bpiXEYT
        bZlcQ0MtbJGr03XG9wEH0tTSzZs6CxcN3+ydqXFNqyYVvnZaUvAIfDmuLorZdcYP
        5LuPJ9VabegGJapI+OJ42bUZVW35J16Gn+TeCj508Y1bUC4B7NZVi2cLJ9aiQp9+
        x2b1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=lMQ89ta2bwiXiqJ7/gWiMnTktQhe9qxcH1icImuPm
        mk=; b=T+8fCnxZlpCExdUAhXKCJUzj1fbAi6SQTpGD6G4QbgA4Nq2edH+VlgSw8
        yvMWOOOykfHjnCZIATnx5UmE0wVirVMyHFlh2C2XvIuMRuJ54ui4FItTubnR4McF
        deZ+W0+RRn+95EhOnm6c/HxscunglRMgkPlLLfOsBNPWssrsy/FiUGG8vMPOYnUv
        FAd9VpzjM303h5KpKSNzahoGifd1K9T9eCRfEIyd8s/38yK5zTCJ6rYnQsIua1cW
        TEumEhLiyP2/AVB5o+4uNFs3WBNFjfNnGJkfevb502829WAkEGec/byUqWLYJVvl
        9de/ihlgmjlcP7FAc+0ZjbfIK1b4g==
X-ME-Sender: <xms:24_GWx3XBLGFTOQ91TCG4lJNpm-gtQ3SzAQ5AXGRKgcFHv9SVyL_Kg>
X-ME-Proxy: <xmx:24_GWzFb89L5GjrECT_8I_fsEwq1ONCDq60kZtyVNfIMX5oBc7ZM2g>
    <xmx:24_GWzKFeJBplNY3bX269H_yZSLChUu6MlAPFXz8C__T9_qcslWlxg>
    <xmx:24_GW36rhjKD5uOyAA1MBxKbu3BBtumPLpRIheNMdvPhlRbk6ztZWw>
    <xmx:24_GW0loVwsKjdAQBtKWJaX4tkq_1MWs3AZob1wr7K2bm9D_vcMZJw>
    <xmx:24_GW0ST0xKXILwJZwrHaK8mQqoiFi6azwxpgc1EkMbcmdAIPnJikg>
    <xmx:24_GW33mjVewmENtedBn-ZUm5z7FiGsOTjWyHmIAoI0sHO7SVfhwXQ>
Received: from [192.168.0.10] (s0106f0f249e4dad3.gv.shawcable.net [96.54.245.187])
        by mail.messagingengine.com (Postfix) with ESMTPA id D0159E405D;
        Tue, 16 Oct 2018 21:26:50 -0400 (EDT)
Subject: Re: problem with not being able to enforce git content filters
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <5d4966c8-8171-9a0a-5120-f7c151c2b81f@stason.org>
 <20181016232636.GF432229@genre.crustytoothpaste.net>
 <038d40b9-0b35-b93f-9377-7c0bb12bce8e@stason.org>
 <20181017005424.GH432229@genre.crustytoothpaste.net>
From:   Stas Bekman <stas@stason.org>
Organization: Hope, Humanized
Message-ID: <8660554f-9f48-af67-fbe2-f5aee5e61b09@stason.org>
Date:   Tue, 16 Oct 2018 18:26:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181017005424.GH432229@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-10-16 05:54 PM, brian m. carlson wrote:
[...]
>> It doesn't help with direct commits to master, since CI would be
>> detecting it after it was committed. And when that happens we all know
>> that already because 'git pull' fails.
> 
> Typically projects that have CI set up don't allow direct pushes to
> master, since that tends to allow to bypass CI, or they allow it only in
> exceptional circumstances (e.g., reverts).  Also, typically most
> projects want to have some sort of review before code (resp. documents,
> other contributions) are merged.  Most Git hosting platforms, including
> GitHub, offer protected branches, so it's something to consider.
> 
> There is a possible alternative, and that's that if your project has
> some sort of build file (e.g., a Makefile), you can set it up to
> automatically insert hooks or git configuration into developers'
> systems, optionally only if it's in a Git repository.  For example, you
> could add a pre-commit hook that fails if the filters are disabled.
> 
> These are the approaches that tend to work well for most projects.  I
> tend to prefer the CI approach with restricted branches because often I
> want to customize my hooks, but your project will decide what works best
> for it.

Yes, Brian, what you're sharing makes total sense when things are setup
this way, but this is not the case with the project I'm contributing to.
This one is setup, commit first, review later, due to having too few hands.

And I have already setup a CI to detect misconfigured systems. It'll
catch RPs in time, and everything else post-commit. Let's hope the
developers will watch the status of their commits and will react quickly
to fix their setup and mend the broken commit, when they see their
commit broke things. That's as good as it can get in this particular
situation I understand.

Thank you, Brian and Ævar for your support and very helpful suggestions.

-- 
________________________________________________
Stas Bekman       <'))))><       <'))))><
https://stasosphere.com  https://chestofbooks.com
https://experientialsexlab.com https://stason.org
https://stasosphere.com/experience-life/my-books
