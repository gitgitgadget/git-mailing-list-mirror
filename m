Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64FBE1F955
	for <e@80x24.org>; Fri, 29 Jul 2016 18:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753602AbcG2SXd (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 14:23:33 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35868 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592AbcG2SXb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 14:23:31 -0400
Received: by mail-wm0-f45.google.com with SMTP id q128so299559987wma.1
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 11:23:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SIizTEnIUAC24PQwhFDwnGDvoBUOtQk0ut5QZyCKNVo=;
        b=YRy8n3wk4xrg8yqEhoKEBaHa/9UbWWXsuAn7LBVdgoy3uF9xR31xAPzbCwyt5SX84T
         L5Ma1EZBBNgYY4OG2H6/ElrK07MuAE6RrZdqRRAE8bxI+msb5K6x68tEUNGOc2P0r0It
         PXFShnq8swQcz8fA/8n7ttxUFTnqIiH5y5fteDALoqanaODy0z4eGI7odWLLjmzgpbzT
         nRipY4G6+HILfF3Ntzh3ybz68dane+8CtUsS7e1GJv2cOJDlVO3A2DaQWFpGQcI/RFVC
         H0YMKoQZSGCNTASZgmzDSTOsiGMqs7R8fVq8NHVpbBygEFPBGiNXRgNSmku1k56YjyfR
         4Dpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SIizTEnIUAC24PQwhFDwnGDvoBUOtQk0ut5QZyCKNVo=;
        b=Ey1A4X6mdZh1nOfsvb24kk3QRt9CS8fyArJZ1ONQ9v5vB8gQVmmPmwqZQfgrT75nZT
         OisBl+Xyf6Y7ZR92pe/qAp+/ST2uCXE+BXe9sAflKCqC5t1KB5piquymrb9I6eqIRYSS
         Vy3rGD0yTnPkdnVW/zKiDNU4OaWE6626YF7iX6YFxYGpi3WJUg/Pqeqy3Sfi7bjoWeBx
         vF7jAb09t/BP86db8nAbIOGfgabGOzJEFwxAOde4ijFuLtkEqMitgb6unreJL5zKVrrA
         OiWjn9uoUWRe44DFn4HOhj1PE08GRme2K6XoKtFGv2J9h4Ok6ReotLC46XkNWZAhRXNQ
         zVSg==
X-Gm-Message-State: AEkoouuhNdewTAS3SM5dFCw8JJDZLBRWBb7LguxQnELrWp5PopARy7vy/iZ7S7hMDY69qYzyqHDFVHmb/Hj3uQ==
X-Received: by 10.28.167.80 with SMTP id q77mr2561038wme.62.1469816609367;
 Fri, 29 Jul 2016 11:23:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Fri, 29 Jul 2016 11:23:28 -0700 (PDT)
In-Reply-To: <CACsJy8CT2r1MKE_bQotPzKEWi10QB81sNn6w7H23GxRkEYRFfg@mail.gmail.com>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
 <20160627182429.31550-33-chriscool@tuxfamily.org> <xmqqinvs19ng.fsf@gitster.mtv.corp.google.com>
 <CACsJy8Bi00yBb6UPm7_x8BDnwQKCXXpOPbswKtayRofmSOstcg@mail.gmail.com>
 <CAP8UFD1SSjSGV+1e+zP4s=p+ohgSz6mct3EhPXqbde_y48ST7g@mail.gmail.com> <CACsJy8CT2r1MKE_bQotPzKEWi10QB81sNn6w7H23GxRkEYRFfg@mail.gmail.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Fri, 29 Jul 2016 20:23:28 +0200
Message-ID: <CAP8UFD3pZedUPWTj1A8q0zBGhR5ATL3CXOCxHf1_4Fuo+Uu4UQ@mail.gmail.com>
Subject: Re: [PATCH v8 32/41] environment: add set_index_file()
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 5:34 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>
> Yeah. If the libification movement is going strong, we can start
> converting and at some point should be able to define
> NO_THE_INDEX_COMPATIBILITY_MACROS globally (and avoid the_index along
> the way)
>
> Without that, there is a risk. I looked at 'nm apply.o | grep ' [Uu]
> '' and I don't see any external functions that would potentially
> access the index, except ll_merge. Again there's a good chance I may
> have missed something.
>
>> So it looks like it is a very big and different project to make the
>> current libified code be explicit about which index it is using.
>> And by the way perhaps this other project should just remove the
>> "the_index" global altogether.
>
> This is probably the way to go. But it's the boring sort of work that
> nobody wants to do :(

Do you mean that it might be a source of micro-projects for the next
GSoC or Outreachy? ;-)
