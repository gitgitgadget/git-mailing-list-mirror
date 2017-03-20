Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAA3B20958
	for <e@80x24.org>; Mon, 20 Mar 2017 17:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755729AbdCTRoC (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 13:44:02 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36498 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755673AbdCTRn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 13:43:57 -0400
Received: by mail-pf0-f182.google.com with SMTP id o126so68887964pfb.3
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 10:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QV38nndu68oDcXUO8InmvSn/7URl3OzHuosT90ggzsI=;
        b=BCM6QwQoJi01k/VAS7mnx4SP/aPpl+XAdr3pKmQ6kUc41HNTqq+by2sfJ7/bxOG7k2
         dyIpE4f5rSCsQw4xEs4WhKj1rv/fb5Jd2S33cAXu0987Egy+rJKdmTcnOVbAbT100g1F
         V3Zff2aI7BvvyvB2wqdkmYDeIb0V9Vn5Fd4czkym1pjK1UO3X44MZHZ57F1gdcEgRc7X
         Vklb+mS1WaU3yP2QpeJB+DuCP4CIM2ux0XcAlU2Cr5EDxjtI0LeVDlbjdbQbKltBxDvE
         67sLvZddRTMAKLG86d1eXI8CRewOdQwIfuIt+MgneUWYlKneLyJAsgZIwwyt9x0ygYaa
         aFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QV38nndu68oDcXUO8InmvSn/7URl3OzHuosT90ggzsI=;
        b=mgcBbWE2rEyOO9VVTcQWKS4Wi1fH0tJj53EUhVlcOHQhNmCR7rPIcLHGLSp9yvTbz2
         47uJth3kyZ5gakCPxPEXrmKndya6RHR3fKee/HaSw7wdzv+Xh8AN96XTQdH0B4Io6dBv
         519sGoGWIzh8sumGCoKbv5H9dOSAwNd3OrBYyuXzolYxrAtLqQc666WswdcWgms8kpqj
         QB/1+KZCc1rp5KqiYZtexhSYVwbQ3iZ0YG1IQ3dVBwY7ZYFLOP085nF0eC2ko93lziK9
         iuXVJwWR1nuYZ4gGSon4STuErr/AwxzqtRUHXr7YLs/1Q7L/czirW7fWPre2ln/vWpCr
         0XIQ==
X-Gm-Message-State: AFeK/H2Abeps/6I6Ab44ElPsUvf1nN0eP42NjPE9NDLSNwbWuqXLx8HPsp9193v3+TltMv8nArLZHlZSfP8SV/Zo
X-Received: by 10.84.128.75 with SMTP id 69mr6920734pla.111.1490031836344;
 Mon, 20 Mar 2017 10:43:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Mon, 20 Mar 2017 10:43:55 -0700 (PDT)
In-Reply-To: <oaotoa$qkp$1@blaine.gmane.org>
References: <oaotoa$qkp$1@blaine.gmane.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 20 Mar 2017 10:43:55 -0700
Message-ID: <CAGZ79kY7bCt_3Fse_Qi43Aej=MgN1ABLTx7eLmPCs+aP2e9ZwQ@mail.gmail.com>
Subject: Re: Regression: Reword during rebase -i does not seem to trigger
 commit-msg hook anymore
To:     Sebastian Schuberth <sschuberth@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 8:50 AM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> Hi,
>
> I'm using
>
> $ git --version
> git version 2.12.0.windows.1
>
> With this version, when I do a "reword" during an inteactive rebase session,
> the commit-msg hook doe snot seem to be triggered anymore. This was
> particularly useful to let Gerrit's commit-msg hook add missing ChangeId
> footers.
>
> I can work-aorund the issue by doing an "edit" and "commit --amend".
>
> Is anyone else seeing this?

In 2.12 RelNotes:

 * "git rebase -i" starts using the recently updated "sequencer" code.

+cc Johannes
