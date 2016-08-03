Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C6DD20AA0
	for <e@80x24.org>; Wed,  3 Aug 2016 15:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756867AbcHCPdf (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 11:33:35 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35944 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755671AbcHCPde (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 11:33:34 -0400
Received: by mail-yw0-f195.google.com with SMTP id u134so17084416ywg.3
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 08:33:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CKh4Aa86b+UU7YsBceeBfFGElweBaS4zvUcWXN9FQb4=;
        b=tNdVUJ+oSDfCmePMP8qukrBgMl6Bj0/NJJEXYiUzyZ4ABa+DDmWkYQT277rPglRVyZ
         MXuEMjCB2c6iOSTMfAMb/XlUCz+vzSMWFeKCH4U4zzTFKCx5RwvEzQJbpF3IJchJAlWP
         CCFsV38qEw2YxEd1R00D8bisFC2UAjoYEv/TBKKaVpoxTovW3UsxkkqHsJU4v6WlF9BL
         KxBhMODP/QKP/mAAByu9agfeRGfbBkqK8NlUrLLrqZVM7pTDG4lcNMtjSLrArwdnNHQR
         LA8psYdWXA61V9yWKt/QmojBJ1rP3wTQ3J1NdwDm7vvl+9QpfqI5QXHYIfbx0wALuw02
         12xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=CKh4Aa86b+UU7YsBceeBfFGElweBaS4zvUcWXN9FQb4=;
        b=ZTFwFPyPv+QJMGp8ATt2fHzsh+EMPaDhrL/ogwInkOR0H0vDqkBXd13bkpo06k+C/z
         UPAWsA3k6bU7ThW7/UOpYvs1dODwIAyyRG+x5BXNSazfeiTthc6kRrP3BdTXIcL790J8
         iEb7o+Phqe0VJpjk0RarVO12bHx2/hwtI6FZujzENXFz01dZJptKXQiut9geV3TBC20l
         WNeAxjwktuCzQT+EttXyHZz04efgo9F0N6g7YovsOSzr911h66fGfN3zD2qt6XthpoT1
         QcmyV2wEjih5sP3wJQ4FjWeB35Vu8JPk7CtxjsVWDa8DatPxGGt5Fr7hndr1iF6aTK9/
         25Mg==
X-Gm-Message-State: AEkoous/7RPFzpbD+xh+LaLgNZrUrwDpSbvyvQaPEwCmKaeeX8Hcz2cSVHEYRv+uP5qG3e9SFJCCYmFDIZVV/w==
X-Received: by 10.129.106.139 with SMTP id f133mr55449386ywc.163.1470238413088;
 Wed, 03 Aug 2016 08:33:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Wed, 3 Aug 2016 08:33:12 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1608031021050.79248@virtualbox>
References: <cover.1469547160.git.johannes.schindelin@gmx.de>
 <cover.1470051326.git.johannes.schindelin@gmx.de> <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de>
 <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608031021050.79248@virtualbox>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Wed, 3 Aug 2016 08:33:12 -0700
X-Google-Sender-Auth: -VKxsVGI9E0MIG3s9jdEn4kyySE
Message-ID: <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 3, 2016 at 4:59 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> I disagree, however, with the suggestion to sift through your `pu` branch
> and to somehow replace local branches with the commits found there.

To be more in line with the "e-mailed patch" workflow, I think what I should
do is to send the version I queued with fixups back to the list as follow-up.
Just like reviewers review, the maintainer reviews and queues, the original
author should be able to work in the same workflow, i.e. reading and applying
an improved version of the patch from her mailbox.
