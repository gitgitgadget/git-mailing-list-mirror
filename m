Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B1BC2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 13:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D71920870
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 13:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TnTNOaTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbgKDNnv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 08:43:51 -0500
Received: from mout.gmx.net ([212.227.15.19]:49779 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbgKDNnu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 08:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604497424;
        bh=yAg8oiEHsEFYZWZcAJ4V+8XM3DvDQXd/8Uho1zfVAnc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TnTNOaTA0Rc5ktSLJuW5S7dIJ9NyVUEMxs17lW952399Z8+aapHS0VfRX7by7zFt7
         GDyOtG0G2VIH2o7aRFIbjkls8u7Op//zxwIEj+UDjGbFi3kxFuCDPjzCsjy7SCg/ta
         EiRBFgTZ6yPb4mCobiVlL42a/6ELDFbef8nlWn9I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([89.1.214.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvK4Z-1kIuqc3oTB-00rGpW; Wed, 04
 Nov 2020 14:43:43 +0100
Date:   Wed, 4 Nov 2020 14:43:43 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] Makefile: enable -Wsparse-error for DEVELOPER build
In-Reply-To: <43aadae9-a4c1-f1e4-6902-c05af36fcf19@ramsayjones.plus.com>
Message-ID: <nycvar.QRO.7.76.6.2011041431370.18437@tvgsbejvaqbjf.bet>
References: <eaf5ac83-af3f-5028-3a9e-1669c9cde116@ramsayjones.plus.com> <xmqqsg9uxchb.fsf@gitster.c.googlers.com> <6676a08d-0c25-14ba-4ea6-677bc7ab0e20@ramsayjones.plus.com> <xmqqh7q7vbah.fsf@gitster.c.googlers.com>
 <43aadae9-a4c1-f1e4-6902-c05af36fcf19@ramsayjones.plus.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CeZu0k2BlGZ9JBIPZ5Rxt2gdwsllDUGIn5LKf1zpcPDm+Y/RcRs
 74xtGFX+492ZqzCyMWj3eIRAQFPCoYX5w6WJbKUH4vmOOjgLhVhrjEZ7JoLhacqJ3pNJxqm
 /8hr3nEaO4NbeB3av3XR13NREma7Ezx+3qjLEtq/9aRq92Ud8Q3uvj0yYqsZ6nbRpLd19Te
 T+G8MZeytBoiB5nomB5Dg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fnMfvGlB2aE=:C0+nrTASDu5ZZWK1TwRnr+
 jjYpoxpeOVyeluOuo30TaRxz0+uSAD315mtPMImTdt1r6epj539gNV32B2gThD0wzH1W+TXWG
 x/mEzDDnTHHVfsSuS5AOJkqx9AMVj+i1tS9WhkVQjOU5og3Qomxcabdrx+jx5xBDsTsW1dB88
 ZQFbqj5v6PAp8ol1359pSxgmHF3s2lql/oZke3eRrg0CYrHhm672GzZbOGfNYW8oB5PvSAQGC
 aIdkCrRzR+3UcD3KhaqhiUUFjhFv+0+T+0C8K7ciE1VAzHwtic0ACkJxyF9j5M9pueiZfc3Or
 1/91A0Hjj+bvRBM9iDHZZq+MKdwWWLlToQKqyQorYvAtUpDw0LYMUbtqjyRobFMDf9ahUNmZf
 3iRalepoo94yJas9LHvbEDc5mkvJLuNjJrDyVNwCCVfduZiTu0js5YbOHUiWZUQ4RIH2gAX6N
 3gi68fuhFfWkc/O3uAArGjAiSJAWXTVaZjI+0++lx3IUS7+TSOrcDUei9AbfML9WqXygopN4p
 yZw4rQyMj21u7+ivzDalN6/OSM2cL8j+UXiA2qp+7bZH4whtri4Gv/95eBG+1RjXYIC4IXPbo
 glZP+Nc7At8HjIrvvtgZys9C42pMVW5P1eRkg7o7SGcJQj5hhS8GyR76qsabAIDZBq0VT+uV4
 dY172Il3dpZcKtk0WnHAdlb/nArtP3+/Ry7iocir3DO58hJDPw+omyrvCYmn5l9/T6Ue/yIfH
 8t1siK5sancOdYhcUwdgduHlsXKhC0oy9gfOxRnK7+OZQUad8/KgUymRaKhvB0UiVT4mFHkdt
 BrELFgliKidlL2UzzILakthnw6nQ3Xc241+lnXRGs9yDg7odoW5htBX+ejyXOTbqTHSZ19MYc
 1oaDcta5OBSFpuLSnVLFO59OSZn+QZNletbtlRuIw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,

On Tue, 3 Nov 2020, Ramsay Jones wrote:

> On 02/11/2020 18:55, Junio C Hamano wrote:
>
> > CI builds already have enough stuff around invocation of "make test"
> > etc., and it would be trivial to pass SPARSE_FLAGS from the command
> > line when adding "make sparse" invocation to one of the scripts in ci/
> > directory, so from that point of view, this patch is not needed for
> > them, either.
>
> My concern was more about how the CI system obtains/installs/builds a
> sufficiently new version of sparse. Otherwise, 'make sparse' won't do
> very much. ;-)  As I said, I don't know what's involved in getting that
> to work.

As mentioned in https://github.com/gitgitgadget/git/issues/345, there is a
Pipeline that builds sparse packages for Ubuntu, ready for use in our CI
build: https://dev.azure.com/git/git/_build?definitionId=10&_a=summary.
Currently, it is scheduled to run every weekday at 5:00am (I assume that's
UTC).

So I went ahead and added more details to the ticket, essentially
demonstrating how the `sparse` package can be downloaded and installed in
the CI build in a Bash step:

-- snip --
urlbase=https://dev.azure.com/git/git/_apis/build/builds
id=$(curl "$urlbase?definitions=10&statusFilter=completed&resultFilter=succeeded&\$top=1" |
	json_pp |
	sed -n 's/^         "id" : \([1-9][0-9]*\).*/\1/p')
download_url="$(curl "$urlbase/$id/artifacts" |
	json_pp |
	sed -n '/^      {/{:1;N;/\n      }/b2;b1;:2;/"name" : "sparse"/{s/.*"downloadUrl" : "\([^"]*\).*/\1/p}}')"
curl -Lo sparse.zip "$download_url"
unzip sparse.zip
sudo dpkg -i sparse/*.deb
-- snap --

It is quite likely that the ugly and unwieldy `json_pp | sed` things could
be replaced by elegant `jq` calls.

Ciao,
Dscho
