Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 879C11FCC7
	for <e@80x24.org>; Fri, 10 Feb 2017 04:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbdBJEAT (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 23:00:19 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:33419 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbdBJEAR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 23:00:17 -0500
Received: by mail-io0-f174.google.com with SMTP id v96so41788796ioi.0
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 20:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ziEhJ7lMymenxR9Lz8CJ4YcXcPXtprGGDCQ4auRz0x0=;
        b=cd0uCQwDMvblMT8XgIetXRaq3sgszZ2o6NnbaeHPzOXtUOwhAWSUiWUeu5wQdqRygW
         Kn0fS0TzrZmdsnc7QRdCHAbmRB0kM4i3xnfldVPE58/2WI7/K/l44ucg+El2+TJkegEg
         71olwVSkHkhlEb0AFNFPXTLxwvaGEiLVnr4AxffXbFNSjqz4TvaPlgY7s5//mkR9ASbE
         qjRN9dgEx/cajljPAQ+zkUcF/jHmFLWQtjRMNDwOimeRIBaNg8WiCivSqV8DPmPOoj64
         PZ7iEk04q2CfYFxmTFz2l6TvlJn35Kpr9v6nNnECXu1lIeuvU6qta09Q987sHKuJON8i
         W/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ziEhJ7lMymenxR9Lz8CJ4YcXcPXtprGGDCQ4auRz0x0=;
        b=EyLBNW9bk/zM+NB1AqlsSkUm/atxhNDQcF2EKmIxzb3tYI1q1+5+/lxA+IWTeaD5CS
         BeJ/yFGxscPvgMG/8jNKSAY4y4ws0CbzvXj1yoRqxzgpJqLRBDCu7Zh8BYsIumUtxgXq
         pBm55XggWB1iBCQqrJbz0Ot4ukzorI8HmJW5e694R4hT97PT63jKAGnTYFZy1rxwPqOn
         Usu4jv8StNkw4H1br12LSTUGacBKX3fLpNebHIpo6N44LMADr3oOrIFzNoyfAycAa+6N
         Na8QRJO8G/2nEGgghGFA9pbHeXU5bXZrsXm3jwaMUnm5AgPKKQJbad62V4/uO0F+ZWzI
         Ggqg==
X-Gm-Message-State: AMke39mmKCVosiS265PhTHzlmxrxvCwcMubP0g61id7RDSIR4h9fR6/Re51EWLnJsZuZap3RepH4vtNN99UFIA==
X-Received: by 10.107.191.130 with SMTP id p124mr6637848iof.131.1486698776753;
 Thu, 09 Feb 2017 19:52:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.164.36 with HTTP; Thu, 9 Feb 2017 19:52:36 -0800 (PST)
In-Reply-To: <xmqqwpczm0vj.fsf@gitster.mtv.corp.google.com>
References: <50fe3ea3302c40f4c96eaa5a568837e3334f9dc4.1486555851.git.johannes.schindelin@gmx.de>
 <CACsJy8CigsWjAq5cmJ=cbBmj=DdJtHdMKxmoifftuz9+9kqJiQ@mail.gmail.com>
 <xmqqshnnnj6q.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702092304250.3496@virtualbox>
 <xmqqwpczm0vj.fsf@gitster.mtv.corp.google.com>
From:   Mike Rappazzo <rappazzo@gmail.com>
Date:   Thu, 9 Feb 2017 22:52:36 -0500
Message-ID: <CANoM8SV7oJ6YmKM-n63620EkODxD562BZnLZB6OvX8O6BmDT1A@mail.gmail.com>
Subject: Re: [PATCH] rev-parse --git-path: fix output when running in a subdirectory
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 9, 2017 at 5:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> That leaves what the right single-step behaviour change should be.
> As I recall Duy said something about --common-dir and other things
> Mike's earlier change also covered, I'd prefer to leave it to three
> of you to figure out what the final patch should be.
>

The tests which I covered in my previous patch [1] addressed the
places where we identified similar problems.  We should try to include
some form of those tests.  As far as implementation goes in rev-parse,
the version in this thread is probably better that what I had, but it
would need to also be applied to --git-common-dir and
--shared-index-path.


[1] http://public-inbox.org/git/1464261556-89722-2-git-send-email-rappazzo@gmail.com/
