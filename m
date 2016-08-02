Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD9892021F
	for <e@80x24.org>; Tue,  2 Aug 2016 22:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755832AbcHBWpw (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 18:45:52 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36434 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755280AbcHBWps (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 18:45:48 -0400
Received: by mail-yw0-f196.google.com with SMTP id u134so15684224ywg.3
        for <git@vger.kernel.org>; Tue, 02 Aug 2016 15:45:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=z37pL8PWl7ovOSD7I+pP2BpXFJaL93SOulhdhWsK8II=;
        b=bLYxcFrC4czUOyoknf0TvbZ0Ev7ahRm78BK+DoUiPNcZpb0K1dwIHXQbyX9qzRHlI5
         ktZxmQ4LmyvUuOUuna5WYWI5d65QP9m3Fbl9NRNVvNKqZES3h31ghEfnMT+8hoZRr6gR
         /9EJsrAiIUM+s7b8K7D06+hzJ1KTqbyTkP+4BfPuYiwe6mnQT591x55f5oH33Fa0dKN1
         7Hp01sXg1kMlbg8UaeDAAfQ//1q+Qt1gaGAx3dz8hJCvpHXqrQrjPafTNxtMDxgQAihv
         U8jUXNZEt+lJNgjSzvG5jazUm7N8lOPKwRfkGopJamsD/IsUTkavZj2BrQ9jChjpRhG5
         titQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=z37pL8PWl7ovOSD7I+pP2BpXFJaL93SOulhdhWsK8II=;
        b=j67YvIDbnOegSjoX1dJ7zRqp18cWOjfZAXhFHTC0J6MUTMTVefybSvFeWgK1RW75f9
         qY16x4V/+Gt139Pm4QvqjkNMd4q9XgZzacSGCoah3ialfGneevIcI9i2LDT0A3rtQlbM
         OGy4ErF1QbGI29LL32sjNrzNxZ/VNZl4IsohGdTFhND7nK0VaFfzbNEglQk/m1OMVYDV
         eEAaueSGGUD47WygdpNB8wlp0R8olymhU+1eL3vq9hZJQ1BnP9xlHittuzu7uEpKHeUi
         jhCLrZniDyeKcmSu+XmJjAozhVlBJKpKVloLl0s4J6IwPrt1Uldd2UmcBuUHay+6y6Z6
         6Psw==
X-Gm-Message-State: AEkoouskJhltGmy9sgl8Sw8x6/u5YkX0rcIC3/ncHA8vRV8HwUJzKd5Xaf1+TiaMyooqmns3Hcru74oXzynnjQ==
X-Received: by 10.129.83.213 with SMTP id h204mr54574457ywb.317.1470177905975;
 Tue, 02 Aug 2016 15:45:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Tue, 2 Aug 2016 15:44:45 -0700 (PDT)
In-Reply-To: <a2b34209-2244-d498-6ed2-4f9fbf9f7ed1@ramsayjones.plus.com>
References: <a2b34209-2244-d498-6ed2-4f9fbf9f7ed1@ramsayjones.plus.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Tue, 2 Aug 2016 15:44:45 -0700
X-Google-Sender-Auth: 4zYdvD9Nmu4B4jlXX20S5o3dtdw
Message-ID: <CAPc5daVo2o7zxTGVARoZc8AmX2WAJC1cWB4R=9sG8TH8ddKkuA@mail.gmail.com>
Subject: Re: [PATCH] apply: mark some file-local symbols static
To:	Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:	Christian Couder <christian.couder@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 2, 2016 at 3:33 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Christian,
>
> I had intended to ask you to squash this into your 'cc/apply-am'
> branch, specifically commit 4d18b33a (apply: move libified code
> from builtin/apply.c to apply.{c,h}, 30-07-2016).
>
> However, having read that commit a little closer, it seems that
> you deliberately made these symbols public. The commit message
> does not mention this issue at all, and it is not clear to me
> why these symbols should be public.
>
> What am I missing?

Their exports have been made obsolete by the reroll we have
in 'pu' when "builtin/am: use apply api in run_apply()" was
redone in a way not to duplicate the argument parsing.

They should have been cleaned with 4820e13, but I think
Christian did not carefully review the whole series before
sending it out and did not notice that they no longer need
to be extern.
