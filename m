Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 075F01F404
	for <e@80x24.org>; Wed, 15 Aug 2018 22:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbeHPBrH (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 21:47:07 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42848 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbeHPBrG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 21:47:06 -0400
Received: by mail-yw1-f67.google.com with SMTP id y203-v6so2084765ywd.9
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 15:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T71WHe6fEVbWAZCn1s3S6qSYWKNRudolgobzKNwCaFA=;
        b=TUf+Rbkf0Q91SdhYoY7pOJYyPo5tV6UKgNt/tI+ORc2LyYAOODl7Mnaz+z7/ZHO2mJ
         Vjwf25iMYEmcLk8EN0GuG5wavbdZKPPJz7t5uUjEbgx5oHC8/fbjb9KE1OZQDtLZKd+n
         nPpD4Mtu93/KLVDM16Be7YbCyrofk7R/GmQ+NLsqmPH+ouR2S+QC9ErG+Tx5KO//+Cuz
         LypKEV66UJJ2/ON4zLmu83OENzuPgX7TAl8mI6IZHDu2b+OD12z/n79n0I0KofR5xdR0
         33davXg4uOhFO8jeUD+wkuUyUxPA777BTwyoFYeQuTL1bfA2MaDrs74ILXU6VGiN2zdL
         fFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T71WHe6fEVbWAZCn1s3S6qSYWKNRudolgobzKNwCaFA=;
        b=QDvdxJEVE1aOeyXJV75ItNUpf/1/PalECN39j1uY3jAVHmH0PRrqy028z/7g4ENzU6
         kIK3XOH2+c1CrIQY/Wv4zT6TN0SxM/hF7AJNYglBXNhQQMu1STNN3aS+fbmxZp64UBMX
         fj1x84O0P2SVRb4YsIQdemqGrWRNkeQ2EfIokjwgNqHBfalUGy/gSmbQLryBMZng9By2
         QCz/EftFRXDCEOY0rTrHEpViMU/y0BhM0YYK5oegbjbNz4/f/JHHhkprzFffody/jTNq
         ylUQHJJBpTFmMH+Duj7AejypzCHz6y+0ofMdSV2qQKtLsnFMSe3w7LjzSr5dG7YncgOo
         6j2Q==
X-Gm-Message-State: AOUpUlG0UfUEq9lElXuN+XYQwa83qm5aF882p4HfhctlHBthFuI5fRa9
        7Z9oM6b8/MWNSFovDhmOIyGxjoSIJch6ULTK6+oeHQ==
X-Google-Smtp-Source: AA+uWPwAZMCHlsQ5JLHyFUXiL+4slNYzUsSBTlN09LazitiqNtLB2lnEQv1MyYhePKemYRDeZgUICl9BCuZ9HpC8n88=
X-Received: by 2002:a25:cc03:: with SMTP id l3-v6mr15074046ybf.334.1534373571455;
 Wed, 15 Aug 2018 15:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <929572FA-6B1D-4EC7-825B-93B96053A82C@gmx.de> <20180814182202.59442-1-sbeller@google.com>
 <trinity-1b5bee3c-e801-483f-b555-7ad0b97f5239-1534314471150@3c-app-gmx-bs78>
In-Reply-To: <trinity-1b5bee3c-e801-483f-b555-7ad0b97f5239-1534314471150@3c-app-gmx-bs78>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Aug 2018 15:52:40 -0700
Message-ID: <CAGZ79kZdeqHrc0aREuez9FQjEc=2-b2+t3FGCd01ob+1aAX65g@mail.gmail.com>
Subject: Re: [PATCH] git-submodule.sh: accept verbose flag in cmd_update to be non-quiet
To:     jochen.kuehner@gmx.de
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 11:27 PM "Jochen K=C3=BChner" <jochen.kuehner@gmx.d=
e> wrote:
>
>
>
>
> We use git for windows, there I cannot fin the git-submodule.sh! How can =
I fix it there?
>
>

It probably doesn't have the .sh extension. I don't know where all git
executables are located in GfW.

Maybe "dir /s git.exe" can give you a starting point to look for the
executables of Git.
(courtesy stackoverflow, I am no expert on Windows)

As git-submodule is a shell script and doesn't need compilation, you
can just edit
this in to see if it fixes the problem; mind to use a text editor that
doesn't put CRLF,
but LF line endings only in that file ... shell script is not the most port=
able.
