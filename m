Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F858202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 17:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752332AbdKAR6g (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 13:58:36 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:45440 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbdKAR6f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 13:58:35 -0400
Received: by mail-io0-f178.google.com with SMTP id i38so7924872iod.2
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 10:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vtiLlkedyLY7R3UkxblC/D2yMiVxMlMtD6S1AXcXUlQ=;
        b=nx482TDdJdHwHV3b+CBU+ACouUCjIsN6xHBeIM3PwDxRp0camHRIH75MIcQeovrW/3
         9v+e39ihxoruIHua0YHohYkJ0DlIu7nyJmmb1++yOk+Dp0raebnXywTC/qQSn5Rpmxth
         ngYbt+Q3kSRg6SPmL9L9nXEzxcvykinzKoJEV3RjAJTqdlWrKxdgYbge/zvOCOi9j/id
         iWG0tlcrj+0kYjQ+1l1tAJV7LfXbenewOJ9hnxPD4Q5cErGObgpMdML2kqEuvVnrjE/6
         nHQ/xB6dmkUsJM1XrYOmH+kX+8GWMkYNKbZxlcCguZE+0Q/7qvmw/AaiDErINsyqOa7Z
         rFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vtiLlkedyLY7R3UkxblC/D2yMiVxMlMtD6S1AXcXUlQ=;
        b=lLU4W8IhIeDXsohoqqbs8R4/Za91rK4Qp59pMQCD2+WwHH+JFiH+T7lb+qr7RZO/YQ
         pWyFDodk1klVL9efgBR2fozhrPXTtxsB4HTkeESyw7U5L7ZMMRAaWSVq7ix5LDMUw2l1
         s8cuR2LCI6ATB2HhkzgZ8rAb48IhJIFKCs/suCeWPCKRaJoQKDoGZ9DINz7skjpsLJEh
         K9Ah9AwiQKptKvjEJRoKplCzI4lKyavlPjjHabTJsnGE0L26zSX2oKTbnaN9YZ9i1uUK
         acNsuuHtj+ZcQuxot7qlrCtsq8bcnC7jrk2mWMOvoTQyOFy+2xL+xj4YCp9Bmhsd9voT
         7YJg==
X-Gm-Message-State: AMCzsaWsIZW+ocmXIYAqYc/da+SHLITrCNgzoluMOFiPz886ZEfjiZ3g
        AFmSMKnsph41j/CPNBtYuvdgIA==
X-Google-Smtp-Source: ABhQp+RqcVFv1hKfPHkvhCBd11AUMUuYMVwWSfNzktLZDuHQRypfAmKUV5V5Adq1oyz92bkCI/9/9A==
X-Received: by 10.36.215.3 with SMTP id y3mr1637303itg.22.1509559114966;
        Wed, 01 Nov 2017 10:58:34 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:dd4d:38bb:92c6:6ccd])
        by smtp.gmail.com with ESMTPSA id e77sm661673itc.25.2017.11.01.10.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Nov 2017 10:58:34 -0700 (PDT)
Date:   Wed, 1 Nov 2017 10:58:33 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <Jeff.Hostetler@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Oct 2017, #07; Mon, 30)
Message-Id: <20171101105833.dddaadec0640b7e01962f900@google.com>
In-Reply-To: <xmqqd152yesv.fsf@gitster.mtv.corp.google.com>
References: <xmqqr2tl40pl.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1710301830210.6482@virtualbox>
        <f12353b6-cfed-722b-1386-d55700f21915@jeffhostetler.com>
        <xmqqtvyg2g6y.fsf@gitster.mtv.corp.google.com>
        <SN4PR2101MB07369D19A150418D5ACB858B8A5E0@SN4PR2101MB0736.namprd21.prod.outlook.com>
        <xmqqd152yesv.fsf@gitster.mtv.corp.google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 01 Nov 2017 10:21:20 +0900
Junio C Hamano <gitster@pobox.com> wrote:

> Jeff Hostetler <Jeff.Hostetler@microsoft.com> writes:
> 
> >> Yes, that, together with the expectation that I will hear from both you and JTan 
> >> once the result of combined effort becomes ready to replace this placeholder, 
> >> matches my assumption.
> >> 
> >> Is that happening now?
> >
> > Yes, I'm merging our them now and hope to have a version to
> > send to Jonathan and/or the list sometime this week.
> 
> Thanks.

Junio, would you prefer that the combined effort be in one single patch
series or separated out into 3? The way I see it, there are two
independent patch series - this one (object filter support in rev-list
and pack-objects) and my one (repo extension for partial clone, fsck,
and gc), and one patch series that depends on these two.

I prefer to have smaller patch series as a patch author (for example,
less need to update later patches due to a design or API issue caught in
review), as a reviewer (for example, less things to keep in mind as I
review things patch by patch), and as an experimenter (assuming that
smaller patch series go through the "next" -> "master" process faster,
this means fewer locally-applied patches to juggle when testing out a
new feature, as Jonathan Nieder said [1]).

I understand if you prefer each patch set to have at least one useful
self-contained feature (or bug fix), though. (Having said that, I think
that this patch set, at least - object filter support in rev-list and
pack-objects - is useful enough on its own, but I understand if it
doesn't reach the bar.)

[1] https://public-inbox.org/git/20171030222726.g26nryjxktyj27sd@aiede.mtv.corp.google.com/
