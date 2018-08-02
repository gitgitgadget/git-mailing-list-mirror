Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00A911F597
	for <e@80x24.org>; Thu,  2 Aug 2018 18:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeHBUvp (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 16:51:45 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:38457 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbeHBUvp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 16:51:45 -0400
Received: by mail-yb0-f195.google.com with SMTP id i9-v6so1673626ybo.5
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 11:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cfl828lR3jmcNMQQwp7YA8FQnaPIGoS28w5HSbA5Dts=;
        b=kmH8p3+su78CPQ4QZ8oQCp3oQsYFlkHqMt3p3zgdd3HZ3DqI5IxpIzx8oHHl4h1MwX
         fVImPSap30DN/mB6pPeUREhixctO4QWbJGOG5WXVYw8LvbrXe08H3JX/hudiGN+x641n
         BOYTY8jeBDGmbsLOg9G4x6GBQ4MyQvKfBQ01xbDTgkAmdzEUUI0XGO8zxsAKuTEm0Ut9
         o/EF16Uf/JipRsa9t+wc0vE6sOTsOydJqYdrVJJHn9pZToqSGtlOi6vYAAuMBMnLYJ7H
         Z1VdGyRpMiB4XzKtBvpyqMIBsGJiPAEvu5rjII/ICwyhRl0tDX5DHUupPyO3an48dKA4
         AavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cfl828lR3jmcNMQQwp7YA8FQnaPIGoS28w5HSbA5Dts=;
        b=j+y5CMCUXLHtmvLlpyB4ho4Hwnv4ONppRS6hb1vnHIriogDG2GOn9ryF7+4uE8l2mj
         UOh/gwE4wdz/dWK3cIF7cdF1nhoOh6IqLDiMyaeRjtMdAwZ07dMX8AQ8SakWtXlXf8zT
         sbyA/M1Ptx5jBiysCwB7VH3ULNBIkTpvUYkWhc35lZVTMhBuXiJmapuoprQfda+J0h71
         Eb6odRanVd5NZdEbQe6NpDm8K3gK7zBSy0A8X5Ey0h6EJH74aIHb60NOuYLnC+kgrUw/
         ftwNCcGnfhr1oLnuBA9iRjmGiN2olHqRfP1iXQ6SKLw6PmS363Su+5yLLCB2IdiQrt3P
         9sXw==
X-Gm-Message-State: AOUpUlEccWsKbGmcXpDuaaG2GqG6IXOQeTOWewBg+cLEH6zdDMlqiF1Y
        0vBnujjf0k7lcBA5YL1S2SG8h4rDeUjsib+tiM3zlQ==
X-Google-Smtp-Source: AAOMgpe+Kqe77Fx/beNrtJZWI180NWwBcZ6wnQnbM66b48DTEK5i6NauKCXkHO2mayKQS0b4OLrTtnzuORqHHO1tkIU=
X-Received: by 2002:a25:a263:: with SMTP id b90-v6mr447523ybi.247.1533236360498;
 Thu, 02 Aug 2018 11:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180802134634.10300-1-ao2@ao2.it> <20180802134634.10300-6-ao2@ao2.it>
In-Reply-To: <20180802134634.10300-6-ao2@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 2 Aug 2018 11:59:09 -0700
Message-ID: <CAGZ79kbwK1Kf2Oov9W9+UBBJpiOfDgZjZakmGP3iqxPPAhAUPQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 05/12] submodule: use the 'submodule--helper
 config' command
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        =?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 2, 2018 at 6:47 AM Antonio Ospite <ao2@ao2.it> wrote:
>
> Use the 'submodule--helper config' command in git-submodules.sh to avoid
> referring explicitly to .gitmodules by the hardcoded file path.

ccol! This is the corner stone to the work of the previous patches. Nicely done!

> This makes it possible to access the submodules configuration in a more
> controlled way.
>
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> ---
>
> Note that there are other instances of "git config -f .gitmodules" in test
> files, but I am not touching those for now.

I just checked and this converts all of git-submodule.sh which would
have been my expectation as that is the real product.

The tests are fine to use "git config -f .gitmodules" as there we want to
setup a specific environment to be tested? So I would think even future
patches in this series will not touch test files for such a conversion
as in here.

Stefan
