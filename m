Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D78C1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 18:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750765AbeBVSiD (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 13:38:03 -0500
Received: from mail-yb0-f194.google.com ([209.85.213.194]:46119 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbeBVSiC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 13:38:02 -0500
Received: by mail-yb0-f194.google.com with SMTP id z7-v6so2068870ybz.13
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 10:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TibsB0U3Fxt7LFQIj7SsHiKFx5PYbBC6wAp6u3yvqZE=;
        b=ZXR79iByLU+md0Y1MMXR5oznSoFbbCt0AUUeIygk+WGHiqUb/jwtmGuh5RPvyqovVC
         H2/ydbg8KIUEXhw+nSDexbxl2FTItODqQZ7d64wMbM64jZmqTBpEXyYeWUBGEF59sUOg
         nKGqQJ9dtG1K5fd4q0cDd9OEEIbaa9GQ0jl2i7EnTehfYYPaA0jX8on8veWQIe33OA6q
         MT7wbQWzO+KNG6Ka6gG54Y+jFeqImXwZ5CCVDo93LEGn+QVT2g1819Fi2Q1fSh1fzoQj
         pWshjGeQXHqIC5Asoe3Gl24NzNJNJ+n5Fo5LO97zxSPWrbhx3oGWXAx9VyZxe2ZuwBLp
         GAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TibsB0U3Fxt7LFQIj7SsHiKFx5PYbBC6wAp6u3yvqZE=;
        b=QH4Dr5bhVbl61fz7fZK6+ymGK3GTM3b1DKAbx0RtM2BkZ87C//cx+Un/my/5Zv9tyZ
         SVar1zF8Mc6rmD1sejEPgtKLithkNzFvOkz7Uu0NBe0vwzJJ8B7spP9OrM2/vkuOGbQM
         f75teJqPsQi2BU3fKyHnbVo91EkJA2dxVB2xsJQxLJNWMfl2PIuNytiyrkww/cdDfeNJ
         HATmYNkQXzWOg1PyJPrWc6/jVTEI1jAdWtB8SABiwY+lqQ+b4+OaFSSUCFhydzwQnevu
         9li+9t331u7BDIa3ysuCQCagmnEPP4F0Om7gnD3Bp0w5JxbF6VfIz4AAxz/YEeOzjG3B
         zDXA==
X-Gm-Message-State: APf1xPB3ZYe9lkdRJywYl0gWAfCjtozuiM+iJU/fyBG9y08yYBpvQMTY
        KLl1NN2Gkg+aOPbSM0e1lH3XC6LLhPUTIOY7Ogr/z8E6
X-Google-Smtp-Source: AH8x224sfTqpyjtSbwbO2AjgqnBgq7IurF20HXincy+Qqs9d9vPM9t/6Qsu5T6seNL14T5NIaL0mW7RwKe56mWJ/uCk=
X-Received: by 2002:a25:d9d6:: with SMTP id q205-v6mr1205684ybg.515.1519324681203;
 Thu, 22 Feb 2018 10:38:01 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Thu, 22 Feb 2018 10:38:00
 -0800 (PST)
In-Reply-To: <01020161bcb6b2b5-6a915ec6-57e5-4619-b281-0e2a193c69a2-000000@eu-west-1.amazonses.com>
References: <01020161b30b99df-5029ec2b-a5cb-475b-b54f-9879a117a7f3-000000@eu-west-1.amazonses.com>
 <01020161bcb6b2b5-6a915ec6-57e5-4619-b281-0e2a193c69a2-000000@eu-west-1.amazonses.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 22 Feb 2018 10:38:00 -0800
Message-ID: <CAGZ79kYLtXJZA865DS2JRi1RRw_L0t=f1iKJzvN+Uyroeg-pbw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Fix misconversion of gitsubmodule.txt
To:     marmot1123 <marmot.motoki@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 22, 2018 at 12:52 AM, marmot1123 <marmot.motoki@gmail.com> wrot=
e:
> In the 2nd and 4th paragraph of DESCRIPTION, there ware misconversions `s=
ubmodule=E2=80=99s`.
> It seems non-ASCII apostrophes, so I rewrite ASCII apostrophes.
>
> Signed-off-by: Motoki Seki <marmot.motoki@gmail.com>
> ---
>  Documentation/gitsubmodules.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodule=
s.txt
> index 46cf120f666df..0d59ab4cdfb1c 100644
> --- a/Documentation/gitsubmodules.txt
> +++ b/Documentation/gitsubmodules.txt
> @@ -24,7 +24,7 @@ On the filesystem, a submodule usually (but not always =
- see FORMS below)
>  consists of (i) a Git directory located under the `$GIT_DIR/modules/`
>  directory of its superproject, (ii) a working directory inside the
>  superproject's working directory, and a `.git` file at the root of
> -the submodule=E2=80=99s working directory pointing to (i).
> +the submodule's working directory pointing to (i).
>
>  Assuming the submodule has a Git directory at `$GIT_DIR/modules/foo/`
>  and a working directory at `path/to/bar/`, the superproject tracks the
> @@ -33,7 +33,7 @@ in its `.gitmodules` file (see linkgit:gitmodules[5]) o=
f the form
>  `submodule.foo.path =3D path/to/bar`.
>
>  The `gitlink` entry contains the object name of the commit that the
> -superproject expects the submodule=E2=80=99s working directory to be at.
> +superproject expects the submodule's working directory to be at.
>
>  The section `submodule.foo.*` in the `.gitmodules` file gives additional
>  hints to Gits porcelain layer such as where to obtain the submodule via
>
> --
> https://github.com/git/git/pull/459
