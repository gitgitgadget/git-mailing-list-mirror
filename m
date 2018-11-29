Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 713B4211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 15:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbeK3CjP (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 21:39:15 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45135 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728693AbeK3CjP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 21:39:15 -0500
Received: by mail-io1-f68.google.com with SMTP id w7so1869070iom.12
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 07:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SzuBBiYBRa9pa5SYT84tv1ckEDZaqauNcIEE1SFDJd4=;
        b=dri/FHuHisEzQDrUx2wf5pyc2n+zSGBgsOvFUKbqV++qwQy2cq/mtqck9IUb6gUkvi
         JVBcTwX9z9r5AgoiVpVgsNME2UI8dGdR+ml0DyFky1lxFqA5KMysZNInyigmx56//XjU
         Gfij+Zsqtg5q6f4kjNGlp5U278Ss5yFmaBl6jrNmFnCqZvb2MsL/n5Pib43G9kOt8AWD
         54FYV+vfrjecReuw9m//9NM8+UOHgcXiDRia5SX+stG7sqcCoku4qQJ7vu0BykyRCUPJ
         tuaQo8xCmzfPwBbSBsyFKJDmvUdqK7B/rBW2tc/Jt8SwIfMjpcoAnkpXabhldtjAh7gM
         gCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SzuBBiYBRa9pa5SYT84tv1ckEDZaqauNcIEE1SFDJd4=;
        b=ZWUBMR4aCFkJKMlZY79oMVQDt3nubUFYK3qcRMjMyo3M/0gKYT02jXEyqGatEXuxkT
         KVuC0O/50wXwj6m8Je22IlAgfSyz3VpjRC4G3/KCQZ61KAGdXwrsjeXNYSKGBrBgZDdi
         R3xrF2mifcL/I9RYN4R6OVzxHxXswD8FszjF+2NffQBPWPY4mPqWKbEUJ1yTIpUdjMKj
         J/eqgk3JDX39t7XId1DwMEFiAkjIAVv6gGgOR/IylMN0WGJ1dtV/ga+fSNNJX38Cbazz
         YncFW3ZCh/yAbRUN9tPHBi/x1KVW3Nk52X4eGpxVoI9p4w3KFJ06P8IwRSh+B9ZL0l4U
         VNWA==
X-Gm-Message-State: AA+aEWaEdoeAXpBajNPVKUqmSQEFQlHFEXdfDwYvC4GntwJ2qNdb9WFA
        oWZq0OduLj28NRAbgiGbXhcvyOa0yeBCNT3YOis=
X-Google-Smtp-Source: AFSGD/UapGkkdrokWrHeBJAHxth+6uhSVoYjJUz4TDd9xqHWvEGckHCjsU9qlX7AtePDI6h7lB8XVdMxXAK3lDwAEY4=
X-Received: by 2002:a5d:9455:: with SMTP id x21mr529855ior.282.1543505609823;
 Thu, 29 Nov 2018 07:33:29 -0800 (PST)
MIME-Version: 1.0
References: <20181120174554.GA29910@duynguyen.home> <20181127165211.24763-1-pclouds@gmail.com>
 <CACsJy8D2gxPj4u0_eEg-_x-Z3S3+5FdTU6Su4VQM113nQq=PYg@mail.gmail.com>
 <CACsJy8Cv9ZwWEs-wsOtms3JCXo7x8fL_PBatcb0TgvrrQuMUdg@mail.gmail.com> <CAGZ79kYiMObOHAuf+01r0-YVWHBk-6NpceXh9Z25dx9JZsP62Q@mail.gmail.com>
In-Reply-To: <CAGZ79kYiMObOHAuf+01r0-YVWHBk-6NpceXh9Z25dx9JZsP62Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 29 Nov 2018 16:33:03 +0100
Message-ID: <CACsJy8CkBV48Yd9FHfLVQSHJ630uw8icn128xjAPUOeWJVWfVA@mail.gmail.com>
Subject: Re: [PATCH/RFC v2 0/7] Introduce new commands switch-branch and checkout-files
To:     Stefan Beller <sbeller@google.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 28, 2018 at 9:30 PM Stefan Beller <sbeller@google.com> wrote:
>
> On Wed, Nov 28, 2018 at 12:09 PM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Wed, Nov 28, 2018 at 9:01 PM Duy Nguyen <pclouds@gmail.com> wrote:
> > > should we do
> > > something about detached HEAD in this switch-branch command (or
> > > whatever its name will be)?
> > >
> > > This is usually a confusing concept to new users
> >
> > And it just occurred to me that perhaps we should call this "unnamed
> > branch" (at least at high UI level) instead of detached HEAD. It is
> > technically not as accurate, but much better to understand.
>
> or 'direct' branch?

makes me think, what is an indirect branch?

> I mean 'detached HEAD' itself is also not correct
> as the HEAD points to a valid commit/tag usually, so it is attached to
> that content. The detachment comes from the implicit "from a branch".

Yeah I guess it's short for "HEAD that is detached from a branch"
-- 
Duy
