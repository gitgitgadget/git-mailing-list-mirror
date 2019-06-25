Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AAC81F461
	for <e@80x24.org>; Tue, 25 Jun 2019 01:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfFYBLx (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 21:11:53 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43278 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfFYBLx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 21:11:53 -0400
Received: by mail-vs1-f68.google.com with SMTP id j26so9809932vsn.10
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 18:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EIPC038DRACQNJS5lhgAe3fFFfufrwtwOSxJ3CUfagA=;
        b=QO/PqxuYY61Ch1trMZDGCLlhDQqBgRlkQUQ+x0Ci+ko0+6qIcqv6yY/OEaUQgwXH6D
         3J1lKE1nJph11bpkHO4cd1Oy+QFdcCn14GX37qxxH1JICOtiRtpAYmIK294/2dPWvYx1
         q7DV/CQHRWg7prNt6yHdwddntwNmHN83b0WzcfMqZNWVvIw4vjfuHTGlFGzIRcANFdf+
         zUF21y8zCyBQGzhSHvxOWi/z+XrzlYsGNjukR9uAuLWfVDmkR4aLKN3wfvcsxWT0BLw/
         3r0BfHK22Lrs5keFEREqOS38h2CDPiz1xy8/axh8Rfqm7/NpzZEGnfvtAYC3KZHcv8pP
         T5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EIPC038DRACQNJS5lhgAe3fFFfufrwtwOSxJ3CUfagA=;
        b=GJXGvhgbLgV2tqIwGDZ4pK3WJ9pTa4ibLHHd59jxuWKbLZxNBb1ojU/bKs/vFCB9k1
         aKoD1X5tV2trR7j1RZUayLEdvL5I6RDIfHM/8VTrfYTUH/+2EfZzSec0gWaIIecUAjpb
         ltU3Ju97amkm2Wu9cy4TdtZTI1IqLVtcu9sTE/pWufSfVS3uhVcsGvai3Ack4mK+OUvH
         +08+YfGtsCNAGMZSA7R8XWNKznNc4DIHcD2IQjJaGIOnXoveIKBLI0NmO37sYnQbxlJ+
         GOYj+zXZ6/r4qjlsQLr48ZJLc654WVrwlBRAFl2KpdKG5ZA8X2J4nPNlspuNFwPy/71x
         3Hhg==
X-Gm-Message-State: APjAAAVT3URoxLtQf3wPpcBVKIJmFFOw07a1TCcT4SzDVReqvYTP5giE
        B+vHTFX+Dh5a32hFwsdU6oQ5W+M1CV4bakrrgQk=
X-Google-Smtp-Source: APXvYqzzroDSVKnSlUIMXm4wVlmlyeYIrzGccjUjko0bme0sc4Cnau/LdviNdn0qEgJQxIeMpcL7qbMsD5JdafO9+7U=
X-Received: by 2002:a67:e355:: with SMTP id s21mr40870420vsm.12.1561425112204;
 Mon, 24 Jun 2019 18:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
 <20190621223107.8022-15-felipe.contreras@gmail.com> <xmqq5zouj3rl.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq5zouj3rl.fsf@gitster-ct.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 24 Jun 2019 20:11:40 -0500
Message-ID: <CAMP44s0y_3Ltv_hnoVByTRwZrDU0+PfRo3R=Lxm6wDk+=sypJg@mail.gmail.com>
Subject: Re: [PATCH 14/14] completion: add default merge strategies
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 24, 2019 at 12:24 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > In case the command fails.
>
> It is unclear what you wanted to say with this.  What command?
> After "git merge" fails?

Yes. The command that __git_list_merge_strategies() uses.

 % cd /tmp
 % git merge -s help
fatal: not a git repository (or any parent up to mount point /)
Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).

-- 
Felipe Contreras
