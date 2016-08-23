Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 425071FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 22:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757803AbcHWWjg (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 18:39:36 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:36645 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753885AbcHWWjf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 18:39:35 -0400
Received: by mail-yw0-f180.google.com with SMTP id u134so81559258ywg.3
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 15:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Mnyket1eUnTa07HMh78Cyz0ff2ubC0pp3cbaulARjaU=;
        b=jI6QOXcCYd5/dttE319/rg/yIP+Y9EdIFSEfDYPLnKs5tTsto7sCzudMtYyrEcswa1
         7C1GVUg6Dm6o29IhF5ne+vWxezb3EHisVKmxxT0JWPNCFROY9PIIdJRVtex1m+n57sIY
         U41sBtjRXhX4e2QuHvXyBIHPW7u4MPpDOaMzZnEW2XwC396wdrg4o+X3TpPp7X1Dy55m
         RKuH34sfRBYLyO5B3sLELYDpNpE8cTsg7oEle+69tL9WX1azta9f4NI5rQpecowhr0og
         8lknRzRq1tTd2ftY0OmloNpUaPXOJKffG8NtMWna4y9enMz9PxouAV7abzXQn085364b
         FUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Mnyket1eUnTa07HMh78Cyz0ff2ubC0pp3cbaulARjaU=;
        b=VzE2pI9M2+cbTHp8yMYodLKv0+V1Vv8MxoOjRN3InddmfuEe9pGNtktnuAs9BKP4P+
         iIYj8MlYyggZ/EXZImqsMMbp0Qj4iDOzntNYUooONHoflohxmPFHMF/rbk0pL/RcdyG/
         pjIwZRvlT1kjK342+XfcJji7FuTpdIKfJTEM1wo4x7MMGJdNqOmC/v/lDGQik/MPaPmG
         GuV+TZ0tRUqgYP/GwpQn5TGs4BiQb03cSqAuZO5BFKPhYVLmiwPIxaALdQ/tPkqHiJ7J
         B01CUga7RncF7zTMnLMeHeVnKGlqv1Gq0WsKgenx5GtuIKFqMekHNnOyg49CkGatz5eV
         ESaw==
X-Gm-Message-State: AEkooutgK0sued6Y8hoTEd/C8mN3chBugl7v9aakms+3PREBUrB2CtTsnRqnDugteGWdIoXsQxThGW2DOt1EbA==
X-Received: by 10.13.197.195 with SMTP id h186mr23733742ywd.54.1471991494919;
 Tue, 23 Aug 2016 15:31:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Tue, 23 Aug 2016 15:31:14 -0700 (PDT)
In-Reply-To: <20160815215327.15682-7-sbeller@google.com>
References: <20160815215327.15682-1-sbeller@google.com> <20160815215327.15682-7-sbeller@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 23 Aug 2016 15:31:14 -0700
Message-ID: <CA+P7+xo0Rpva_jkfyk8+eAn6cKLS4kBgHwvTvzj+2A1mp=iG0A@mail.gmail.com>
Subject: Re: [PATCHv5 6/8] clone: clarify option_reference as required
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 15, 2016 at 2:53 PM, Stefan Beller <sbeller@google.com> wrote:
> In the next patch we introduce optional references; To better distinguish
> between optional and required references we rename the variable.
>

Makes sense. It's a bit weird to process "option_required_reference"
but I think it is reasonable.

Regards,
Jake
