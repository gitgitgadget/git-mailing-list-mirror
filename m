Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E2AF20756
	for <e@80x24.org>; Mon,  9 Jan 2017 10:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935037AbdAIKJ1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 05:09:27 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:37773 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934636AbdAIKHu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 05:07:50 -0500
Received: by mail-it0-f44.google.com with SMTP id r185so19523336ita.0
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 02:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cDkDmw4Wwm3KXQIWDeNkUwcdnRkXS5epBRaRo1PthZc=;
        b=B+QOOoI6EuhNu3qfG+dcRMhWQLH88DQSq8CK/cqiJKG88Pxad1OR+vr3F///sAN9WD
         9RYA46SjVFGq30C8FIpVu7p15ZV+Gr4DUHYjHI4xSGFrutAm1rsH/tZzH2oQfQm1hn7n
         U0hp/dsQVlfIDxJ8bKHwOT1cQcDUKEONeaTsuzQBfvTGKo6hDFhoQ/0sKfgNfDEnpFPJ
         TbqxcrfEkV3IWYFL6edBAEtggcwQ5hv/sBDyubSM7OXFkhH16UM+F5OtSx0MFCqWckOJ
         ZlKAfoolpljMItop3rmMJACgMZ+wS51vKsX1OXhlbFdmWCxPfqR9HkNIwCo6p8fuyRtI
         /8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cDkDmw4Wwm3KXQIWDeNkUwcdnRkXS5epBRaRo1PthZc=;
        b=P7YyGmmDe1llrEqhy+1Lk7bCHR77R1/i6HDUIaTEDjogj8rc89ByGA51qpLaixRYkE
         tM5NxWkQqAev5eCuLk1SWrFM7qvPIs1+U7jzqRZ3m2eVJIjKa2EtidTvgmRuIW6pSSSb
         jRqlO3mUuk9HuMMUHnoyQuvpUU2cr1Kmufzh/jKlrPRrnkVh42GCodH9dsJglM3/05kE
         lawHxbrjsKocbckz4JKk8OxeY5ZSc0FLR17WbrxEUYAv6LO85y6zH9UnB6veUdrg/PH5
         +GV+m/7TFtiSVvos7GD63XCNjMR8todm04/q1AoOPa8Xf13p3+rcejL01UCfovfnCJwZ
         qbiw==
X-Gm-Message-State: AIkVDXJ5jo9pGw5N/xZOVc5Dx0A8GgZkqnWLUhiEyFV/C9UK1sz28+YTCZQWROlHRcfRnYDFVdC8sDQddG2cng==
X-Received: by 10.36.160.70 with SMTP id o67mr5098147ite.50.1483956469597;
 Mon, 09 Jan 2017 02:07:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Mon, 9 Jan 2017 02:07:19 -0800 (PST)
In-Reply-To: <CA+P7+xofFufcUMBJFqEcP=C5r80HCr1-j4210gOm7t=aLYw2zw@mail.gmail.com>
References: <4D106F0FF3D29E4FA1D91C1A31CE4C3501B8DEF2E6@email.novomind.com>
 <CAGZ79kaLpf1nzSAgRJQamMGk-327LO+qQYihYVVcU+86n92ivg@mail.gmail.com>
 <CACsJy8C6QWeHSwhsYyJnupkue=aoCG+3Tecytb_0p+gB-CuVKg@mail.gmail.com> <CA+P7+xofFufcUMBJFqEcP=C5r80HCr1-j4210gOm7t=aLYw2zw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 9 Jan 2017 17:07:19 +0700
Message-ID: <CACsJy8AfcZOR966ypfbZa1+7=tr2RVxPUk8+XmQkGeoMBJ7Z0g@mail.gmail.com>
Subject: Re: git branch -D doesn't work with deleted worktree
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Roland Illig <rillig@novomind.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 9, 2017 at 10:44 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> Why not just update the documentation to be "when you are done with a
> work tree you can delete it and then run git worktree prune"?

The document does say that (a bit verbose though):

When you are done with a linked working tree you can simply delete it.
The working tree's administrative files in the repository (see
"DETAILS" below) will eventually be removed automatically (see
`gc.worktreePruneExpire` in linkgit:git-config[1]), or you can run
`git worktree prune` in the main or any linked working tree to
clean up any stale administrative files.
-- 
Duy
