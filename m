Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA99AC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 02:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F7B160FC0
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 02:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239346AbhHaCmb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 22:42:31 -0400
Received: from sender-of-o51.zoho.in ([103.117.158.51]:2050 "EHLO
        sender-of-o51.zoho.in" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236452AbhHaCma (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 22:42:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1630377689; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=QiiegGvlmnljG9hz+FGRnVu9Jx491DRr3wfyDMx9Z3meJEcHx+zIZHRPp1qjykqBnui3OJb82WxZKugUbtdEQpcOnH1KbCUVGqsq+XZZ/u79Z3iTkCE8bM7L1Y23tdVb9SkGvLdsuxZeflUwoXrpElneHRv+MgyPLZWk4iJebHM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1630377689; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=pbbysYtCCsinH0MvUp3WjdooLMGs/3Tuwyh+UZy6QBM=; 
        b=RN2g0vPWQUY1UaXVGOrPqYHPEjWpN/nv7o2kkaMpD43tZAfF3PiO2sWHRWLrsN7Fe9NXSoe6AeVxhWo3cu4xs2Dkui/Jt5O4WkcLMFFhvQQG2t3ZHjl4r6LdMMae4WlCUAdFcoiOBy79c++WtIR1E3gINgKd1OYAKxnotI528sg=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=pugzarecute.com;
        spf=pass  smtp.mailfrom=me@pugzarecute.com;
        dmarc=pass header.from=<me@pugzarecute.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1630377689;
        s=zmail; d=pugzarecute.com; i=me@pugzarecute.com;
        h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=pbbysYtCCsinH0MvUp3WjdooLMGs/3Tuwyh+UZy6QBM=;
        b=ngtyrFbwv2ZHXwJwCisO+l3dCR3VOqsCrOuJBudZDGJVaDyUZ8rGVEFP7ZjlwwE6
        Q+p44S+oV4/uAtZ8niktS7HzhTZqwbvbdj5+Ky1cu36Rg5hnbJ8SZoRot7M0DcU868o
        JVbfVAyPTBgOUFHSfGCq7qe1l12lrMwgVaa3K9Cc=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1630377688391878.8412141762577; Tue, 31 Aug 2021 08:11:28 +0530 (IST)
Date:   Tue, 31 Aug 2021 08:11:28 +0530
From:   PugzAreCute <me@pugzarecute.com>
To:     "Torsten =?unknown-8bit?Q?B=C3=B6gershausen?=" <tboegi@web.de>
Cc:     "git" <git@vger.kernel.org>
Message-ID: <17b9a153d45.50a7d553139551.115021994511161928@pugzarecute.com>
In-Reply-To: <20210830191712.4nufzooxfoyuh5yc@tb-raspi4>
References: <17b982ef1f2.b8f13d4136798.2688982303431691937@pugzarecute.com> <20210830191712.4nufzooxfoyuh5yc@tb-raspi4>
Subject: Re: Bug with line endings on git.
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using Debian 11 (amd64)
The only thing that was changed in the comments were the line endings. ie: CRLF to LF and vice versa

I can confirm this is only effecting installs with autocrlf disabled. On my local machine, I have enabled autocrlf and I cannot reproduce the bug.
But if you want to test it, you could use https://github.dev/ as it has autocrlf disabled.

Ouptput of git config --get core.autocrlf:
pugzarecute@debinax:~$ git config --get core.autocrlf
input

Thanks,
PugzAreCute
---- On Tue, 31 Aug 2021 00:47:12 +0530 Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de> wrote ----

 > On Mon, Aug 30, 2021 at 11:20:18PM +0530, PugzAreCute wrote: 
 > > Hello, 
 > > I want to report a bug with git that causes "empty" commits if the line ending of a file is changed. 
 > > 
 > > For example: https://github.com/PugzAreCute/RFOEC/commit/31f5189cac3e076252372d634708b875a364dece.patch (patch) / https://github.com/PugzAreCute/RFOEC/commit/31f5189cac3e076252372d634708b875a364dece (commit) 
 > > 
 > > First seen by me on https://github.com/PugsMods/WoneWay/commit/fe58a091498eb5d891e351dba0273fd8e6d4d283 / https://github.com/PugsMods/WoneWay/commit/fe58a091498eb5d891e351dba0273fd8e6d4d283.patch 
 > > 
 > > 
 > > Happy to provide more info! 
 >  
 > More info would be appreciated. 
 > Are you working under Windows ? 
 >  
 > Both commits (31f5189cac3e076252372d634708b875a364dece and 
 > be50904c84b56926f9f7f9912af6456edab82ca1) have the same content: 
 >  
 > git ls-files -s 
 >  
 > 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       COMMIT 
 > 100644 0eb95c07f7dd518679684826ff9ea516010c3847 0       README.md 
 >  
 > So what exactly did you change ? 
 > The line endings in the working tree ? 
 > What does 
 > git config --get  core.autocrlf 
 > give you ? 
 >  
 > > 
 > > Thanks, 
 > > PugzAreCute(Murali H.) 
 >  

