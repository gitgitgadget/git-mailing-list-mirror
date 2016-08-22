Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35AEE1F859
	for <e@80x24.org>; Mon, 22 Aug 2016 13:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755282AbcHVNQg (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 09:16:36 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:33972 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932339AbcHVNQU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 09:16:20 -0400
Received: by mail-io0-f175.google.com with SMTP id q83so109631073iod.1
        for <git@vger.kernel.org>; Mon, 22 Aug 2016 06:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4vCJEG+3W6JCEcVe1Q0Uh8cpN2yRNxCzQixvn2RgOmg=;
        b=dGLClMIUUitEOmnZjBxIm1yE/JFCN248KszjE39D1wjPLg2ldnCQMRu6YqJ801zTsM
         OECJfZ8RLOrQYWDgonJ8+OyQKVQ2DtiCf7R6oMUXNM+bBL+hmp/02znqQgal93IzuslA
         7O/bbi62pDIuhBmnfLeikYOXR+Ga7LuJfk76A1FTTDnN4FkuwTclcxj6uhJbj4shdH+x
         gyHuCqHjwLq8Sd59MNqZcn+OdW6dN9xRCLtD18eP4wZpVF/ln4jUUxYu92j75+5INfB1
         9s5uIr37IAW/ANSWiOIHdB6IH0xrl/ffECfdD76e0h9RMG0KyNj6zY2d8hUHtZHL52BX
         UtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4vCJEG+3W6JCEcVe1Q0Uh8cpN2yRNxCzQixvn2RgOmg=;
        b=isH3+hGVXalcWgfw6bopiEVwKF51ubRdhKwe+1+JWtx8XmGrCwLwnnqDJ4Bu+PIHFq
         1GUY0h8MROkmsa92gh23d9kwQxG8ePh1a6BwLhb+BC9DWHJMGWZSyQ6zVRx3J62Q7UFO
         oWM7XXI1n5Aeqx2M2I8AmzloFvx8f2SBxItVrMZgGTZ1tKHin2g4CbGtEQJLRUshPI8A
         lDptWowGLOd4ELiwYphvUGWjAKH1cL6BoIst8SkKhRY/mrinx09ZcgmqE//jQ9fK9IeT
         C3Q0MzZ6e5MhowR/e8sl3lulAjrlpHU3td7RysWz8pTrKV2K1RKaXh2TXGtU9eJfbpoM
         fAiA==
X-Gm-Message-State: AEkoousu4DQxyLMH9Lr1RmPWa2giSebc0d87OMK22sD8UO523kHD2JTvEspx14cssSvrtx2mJ/XrU3sdYg5O2g==
X-Received: by 10.107.8.140 with SMTP id h12mr24750909ioi.95.1471871779596;
 Mon, 22 Aug 2016 06:16:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.125.199 with HTTP; Mon, 22 Aug 2016 06:15:49 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1608221450250.4924@virtualbox>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <alpine.DEB.2.20.1608181430280.4924@virtualbox> <20160819150340.725bejnps6474u2e@sigill.intra.peff.net>
 <alpine.DEB.2.20.1608221450250.4924@virtualbox>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 22 Aug 2016 20:15:49 +0700
Message-ID: <CACsJy8BG63oaLbw0f7try3OpzdphLC7UGAaJ=vgikEB36Pagqg@mail.gmail.com>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        meta@public-inbox.org, "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 22, 2016 at 8:06 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> My point stands. We are way more uninviting to contributors than
> necessary. And a huge part of the problem is that we require contributors
> to send their patches inlined into whitespace-preserving mails.

We probably can settle this in the next git survey with a new
question: what's stopping you from contributing to git?
-- 
Duy
