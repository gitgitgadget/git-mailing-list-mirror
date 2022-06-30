Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873F3C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 23:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiF3XFE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiF3XFD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 19:05:03 -0400
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3278A53ECD
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:04:59 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id z66so723327vsb.3
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+PAempMlur94wWKpwHk+1G5SOPQHuKwumEu3YJ080Qg=;
        b=4tmjXcAwQ2XbIR6S2tr1jtWNEhGDfvXnt9/m8/14+OSBkuZe7RKlNPQmYwerwiRdw3
         myDtgxTWWvNcj3v4yuTeO/WBDnzJjW5RJRzm2tANNTdgbZR3+OxmlayCp+iAuO2C6dEE
         dIhb4Occ5GENtFmv5N30lRR310BzrBDvS73jtmODBb2GH05lEEEZz3pn0IuBmxiBWWIu
         mjWLzoWtWegPGrTgMIvt9EVN4ylX+dVWhVP7mVCs0fbCrfLYDXR3aN6FYbXwYNyB2fON
         3j7zlCCfySEx9L/lORcP5D8OEvYPhVvKf/SV2w3crr2rtyfyybPEB5UIta0ecHDrxfw9
         9BYA==
X-Gm-Message-State: AJIora/i3onAeCAKr7A1wNM/hsNDEHiiADxOyBGjsBRWkZKxJFfW2vdk
        WH6swnHyGFTH6X2hCW8G1mvFot9Bz6fmX+yKrF/TNacPSjI=
X-Google-Smtp-Source: AGRyM1vVUIEBSFP+0PeSlfWOspPg1FLKEq3Tehh5IT/d6ZK9q0hZRVmZbFVMjJGY7gI/xxofhvKb5+DpKeMkMe3mURQ=
X-Received: by 2002:a67:fd07:0:b0:356:94c6:8640 with SMTP id
 f7-20020a67fd07000000b0035694c68640mr3077773vsr.29.1656630298272; Thu, 30 Jun
 2022 16:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <202206281608475079493@oschina.cn>
In-Reply-To: <202206281608475079493@oschina.cn>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Fri, 1 Jul 2022 01:04:21 +0200
Message-ID: <CA+JQ7M_rd_SdzLOL=a0ok=HL9AZ-q=V2Bc2aTuLRrPW8j7DOqA@mail.gmail.com>
Subject: Re: let git-ls-files suppress the expanding of all files in sub directory
To:     "lilinchao@oschina.cn" <lilinchao@oschina.cn>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2022, 8:26 AM lilinchao@oschina.cn <lilinchao@oschina.cn> wrote:
>
> As subject said, is this possible for git-ls-files to work like this?:
> " $ git ls-files --no-recursion
>     a.txt
>     b.txt
>     dir/
> "

An alternative
  git ls-tree --name-only HEAD
is suggested here
https://stackoverflow.com/a/10453994

Maybe that works?
