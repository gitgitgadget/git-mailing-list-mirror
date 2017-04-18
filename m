Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74E35207B9
	for <e@80x24.org>; Tue, 18 Apr 2017 23:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932795AbdDRXal (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 19:30:41 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34867 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758185AbdDRXah (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 19:30:37 -0400
Received: by mail-pf0-f179.google.com with SMTP id i5so3505717pfc.2
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 16:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=503mvEkcSJr+p5Ztwj8MIeGW8plO7snmWPLjRV6KQ/8=;
        b=e8svb0r+UN3dP9e/MrXIUfyWJSMxitMnvHK3V3frD6qvh/ybpA6WPCMg/DvB1qQV/I
         5ukprfFuk/VfbPCChLO0iSBx8ICRzD00YC76DfjJJjKyPP541uNCzX6jP+liESvnut+X
         JtiUX0ZqFqW7+XcxDb1HIFv5vDRong5SFc9YKYzFjxKhUrc5zycYAS0PL870e+fjlZFL
         wBpjq6CGEtD7oLY+/Ks5RnsyCVwbkb/Xav+ijCflEt5wb9xwUYlX7XuePY2KCgVhviE9
         EdMd6f3UJhu6/88xgx9/lNVJ7Pds+O0pNxDV7nE11XgFcSltKVOVKZ7ytL61HxX/CLT7
         OtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=503mvEkcSJr+p5Ztwj8MIeGW8plO7snmWPLjRV6KQ/8=;
        b=mH+IeGa6C1/mlOvJFxiOQsMcfsTcJVP2vJ1Q9amu/UbebMjIcNuGSf2nlNqmz6W6ax
         83j/4IZFTl8SDODgm6KB4Y0vJebza8L419vMR0ObcI5Q9CH6/yULGuGDxs94jO95WHYB
         pZPM8sEzmu5qo3UfkIXYmbg8Sm5m49MIl+M+lY22Oz6EA4wlH0XNmGPRS9nXgzg0yP9C
         tftM+KVApOTO/9QU4lby5ua24XH4r/fc7E7gZPDZZaIEyO4o/whPxBk3ptztXQYFnNfh
         naMJYHBByF6gp2dDMF34JEugLBy8ykAvc1sY1K0w0xip0ejul75VN9olFVtH2gn7ce7d
         nmXg==
X-Gm-Message-State: AN3rC/4BmPcF/QOr2sf+pTNBEfkx711JBsB2AZS/rEvBUybttU3JBjFl
        D0JaIC1EKbBUsSzs
X-Received: by 10.84.217.12 with SMTP id o12mr27239533pli.87.1492558232078;
        Tue, 18 Apr 2017 16:30:32 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c085:9655:b875:4bbf])
        by smtp.gmail.com with ESMTPSA id k23sm537074pfg.26.2017.04.18.16.30.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Apr 2017 16:30:31 -0700 (PDT)
Date:   Tue, 18 Apr 2017 16:30:30 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] clone: add a --no-tags option to clone without tags
Message-ID: <20170418233030.GA41018@google.com>
References: <CACBZZX584QwjphGfEgTn2V9P0yVkYSxfE1_Gp96bno8186SDyA@mail.gmail.com>
 <20170418191553.15464-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170418191553.15464-1-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/18, Ævar Arnfjörð Bjarmason wrote:
> Add a --no-tags option to "git clone" to clone without tags. Currently
> there's no easy way to clone a repository and end up with just a
> "master" branch via --single-branch, or track all branches and no
> tags. Now --no-tags can be added to "git clone" with or without
> --single-branch to clone a repository without tags.
> 
> Before this the only way of doing this was either by manually tweaking
> the config in a fresh repository:
> 
>     git init git &&
>     cat >git/.git/config <<EOF &&
>     [remote "origin"]
>         url = git@github.com:git/git.git
>         tagOpt = --no-tags
>         fetch = +refs/heads/master:refs/remotes/origin/master
>     [branch "master"]
>         remote = origin
>         merge = refs/heads/master
>     EOF
>     cd git &&
>     git pull
> 
> Which requires hardcoding the "master" name, which may not be the same
> branch, or alternatively by setting tagOpt=--no-tags right after
> cloning & deleting any existing tags:
> 
>     git clone --single-branch git@github.com:git/git.git &&
>     cd git &&
>     git config remote.origin.tagOpt --no-tags &&
>     git tag -l | xargs git tag -d
> 
> Which of course was also subtly buggy if --branch was pointed at a
> tag, leaving the user in a detached head:
> 
>     git clone --single-branch --branch v2.12.0 git@github.com:git/git.git &&
>     cd git &&
>     git config remote.origin.tagOpt --no-tags &&
>     git tag -l | xargs git tag -d
> 
> Now all this complexity becomes the much simpler:
> 
>     git clone --single-branch --no-tags git@github.com:git/git.git
> 
> Or in the case of cloning a single tag "branch":
> 
>     git clone --single-branch --branch v2.12.0 --no-tags git@github.com:git/git.git
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---

Patch seems sane to me.

-- 
Brandon Williams
