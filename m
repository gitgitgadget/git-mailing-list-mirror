Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E87C433F5
	for <git@archiver.kernel.org>; Thu, 12 May 2022 22:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359242AbiELWmO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 18:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiELWmN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 18:42:13 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C9D28244B
        for <git@vger.kernel.org>; Thu, 12 May 2022 15:42:12 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id c1so5865984qkf.13
        for <git@vger.kernel.org>; Thu, 12 May 2022 15:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fgNFWBpcCPgrhhyJjPDS1vi3h1PtoWORwDUhSwREwts=;
        b=m0FCiV5bW64TZfGc7EplqHmMOFV/GVpjvqNkfOiWWpSCZgEHDeVRqjtQX+z6d+bGm0
         fcoYua3kSDRoamN/SKvV82RWr8fjfUtjCF9daUDsikH7M/ixCnkW6k7XGzP+rmdaTbFW
         lNs5oETWlaUMSEPGPqSJ9W814BDNi5NOW1Xd686IGy+X2Ox+m+3QxaOV04nMurrEEeGu
         oa+a8/D0auxMxUWGYU5/8tEOnog88SOP/yIz2XbVrV2TUQ4pakLJs2DIVr6leNuDZ+9a
         Eh8GRZBOMBRDkZTEE08m2WXX1csnBgYsA58JQylY9ySrojrCeJ/dcXh0tnK2R/sZJYuy
         PnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fgNFWBpcCPgrhhyJjPDS1vi3h1PtoWORwDUhSwREwts=;
        b=kO9omdCwlhnARtH82JSPFSFugQI7hf5dV8uC02dFBYbB0/YTFHLrEGrVx99SZ+mXOX
         uqXdzXXeHfRI/sFy/LSY0BZjsfbJNJ7Hjz8qtNViHaUbRPBuQsda396ulQM9OntkrNsa
         4cICuvmZfZPp4AyzZJTpCzSkQ6G8KWxplPl+WAEcqM1wxAFCQkLJz6BT2wIPrGHLqaC8
         hLfIcvyU5Hi3Xqyx4+wsxEHJlG/ALS+H0M0oa/isslYeCC4+OLc3Vrg2zj+CVgscZNOS
         NuEmKJHHwXI9iarBDOC1By3X2IcXi5PWuZ5tPKxtWAzCZTow5Id3fO5Pz6bXaFCp7364
         HFJw==
X-Gm-Message-State: AOAM533rCwCqO34hjqd55+aYmwgOBtjptg5r2eCeeigOTFSu8AF6DPdD
        cYK9+SA5focDF+xyVELjr3k/m6eVML4V3A==
X-Google-Smtp-Source: ABdhPJzm03lBSjHzJdyZzWSTJHyb7A8Alv5lfVfny7dq6zUp7nUcqpJOVN8EROHcq0uqDfs6JaNO5g==
X-Received: by 2002:a05:620a:1529:b0:69f:e354:c71f with SMTP id n9-20020a05620a152900b0069fe354c71fmr1720611qkk.375.1652395331471;
        Thu, 12 May 2022 15:42:11 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id a18-20020a05622a02d200b002f3f087c919sm540795qtx.97.2022.05.12.15.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 15:42:10 -0700 (PDT)
Subject: Re: Git Submodules ref setting
To:     =?UTF-8?B?0JLQsNC00LjQvCDQptCy0LXRgtC60L7Qsg==?= 
        <vadim.tsvetkov80@gmail.com>, git@vger.kernel.org,
        Philip Oakley <philipoakley@iee.email>
References: <F20FCD5B-7788-4D4C-8402-2C4CF447B2F5@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <88fa7138-cb3f-ab88-525c-198396b0a262@gmail.com>
Date:   Thu, 12 May 2022 18:42:09 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <F20FCD5B-7788-4D4C-8402-2C4CF447B2F5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, 

Le 2022-05-12 à 16:01, Вадим Цветков a écrit :
> Hello,
> 
> I've started a small project which involves several git repositories, which depends on each other.
> For dealing with these repos I wanted to use git submodules as a simple package manager.
> However, it seems impossible to lock a submodule to particular ref, only to a branch.

Submodules are recorded in the superproject *at a specific commit*.
That's the data model. There is no other options.

There is a 'branch' setting that you can put in '.gitmodules'.
This *only* affects the command 'git submodule update --remote', nothing else.

If you mean that you would like to have a non-branch ref recorded in '.gitmodules'
i.e. something like refs/other-refs/example instead of 'some-branch' that corresponds
to 'refs/heads/some-branch', then no this is not possible either.

> I would like to ask if this is deliberate design choice?

Yes, it was a deliberate design choice to have a deterministic state
of a repository using submodules upon 'git clone'. Recording a submodule
at a specific branch instead of at a specific commit would make this design
choice impossible to achieve.

> And if it's not, may I contribute this feature?
> 

It depends on what you mean by 'lock submodule to a specific ref'.

I encourage you to read the "Git Submodules" chapter of the Pro Git book [1]
for an in-depth overview of how submodules work. And after that, for reference
the Git documentation:

- git-submodule(1): https://git-scm.com/docs/git-submodule
- gitsubmodules(7): https://git-scm.com/docs/gitsubmodules
- gitmodules(5): https://git-scm.com/docs/gitmodules

I hope that helps,

Philippe.

[1] https://git-scm.com/book/en/v2/Git-Tools-Submodules
