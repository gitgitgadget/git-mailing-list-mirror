Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9832D1F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 18:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755718AbcIFSuN (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 14:50:13 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36046 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755253AbcIFSuM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 14:50:12 -0400
Received: by mail-wm0-f54.google.com with SMTP id b187so79617411wme.1
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 11:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bErmHj6H+1Ovc5ZxPcvlW+9z7dthslvGG77gQwPmDno=;
        b=BC3xMpTlMnr/oo8UPN0qwQhsvK6TF+0mDyCVDPqpqguucX3F1PJIq0IcpjQERiJo9Y
         v1+JYHFKNZVBQRpJ6C8sLRsdAasu96+Ek9Eb/bwnM6nCR05PCGM1qFKdRDQclbizid0H
         0+4vM91KA3EViPb7fKmcGQk2/2iGGbd/LT9pco8909sOY5ir2K/F4p4gCfTb7mRDq6Ho
         0aD5TlZ3ZdQO5EEhVHB1sjRBPnCNB9XhzKqzmKUaUYUFG89ZN3jTl9PA1lPv6H9KvN3J
         3F9aknsKNZMMJ8vHvDzLJnfx0U873wC1AG2pT7Rc26cD8BviTNsnvNEfCXQdcugqtiZe
         mhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bErmHj6H+1Ovc5ZxPcvlW+9z7dthslvGG77gQwPmDno=;
        b=Wl8Rx7LSFq7dsXksHZ2yJ0mD8IxkJ+dOppxcnxSUNUdlfARalXZZ6uJQVtMBhSTs3S
         IPKGcFfWIKnkO7VirEKdBi+17VKVSm3ynRLv25BWhiPKBJmGaET0lpOO4Mvv50jrkW5e
         eMEAdCyN4j6lE3qA3iQoYPg/37PtpJvxcwGCUyh6FpxrN8+SswpJmNxPXrP2u0+aW/iJ
         OGXd4/tFSfJ0UWOWdDpz0YHbtQr6kWdg2vmhi1WSMmcLAdGT6668MwxxUNe3AzGqHj9x
         f4X6rO7I4DD0ZHGkPpqK2Fx9SCw4xmJfrQNezLDcskk0URE3a1F3maNEYj4Fl4ZbRYe5
         CuzQ==
X-Gm-Message-State: AE9vXwNxgP6ZwlWYtNKvVvEKKgfOPhQ2lClTcPpj8V0YpROIlzA+K4piq8iMkMqBIyP7k3tV93DPKZ4yQoM2AA==
X-Received: by 10.28.93.20 with SMTP id r20mr113608wmb.89.1473187811179; Tue,
 06 Sep 2016 11:50:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.234.212 with HTTP; Tue, 6 Sep 2016 11:50:10 -0700 (PDT)
In-Reply-To: <20160906180838.865-1-ralf.thielow@gmail.com>
References: <20160906180838.865-1-ralf.thielow@gmail.com>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Tue, 6 Sep 2016 20:50:10 +0200
Message-ID: <CAN0XMOJofQwsPJvoHLZJ-fT6SudtquatYV=GwpGb6FkF4aXcxg@mail.gmail.com>
Subject: Re: [PATCH] rebase -i: improve advice on bad instruction lines
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2016-09-06 20:08 GMT+02:00 Ralf Thielow <ralf.thielow@gmail.com>:
> -               warn "$(gettext "You can fix this with 'git rebase --edit-todo'.")"
> +               warn "$(gettext "You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.")"
>                 die "$(gettext "Or you can abort the rebase with 'git rebase --abort'.")"

Please don't apply as is. There are some test failures due to the text change.
I'll send an updated version.
