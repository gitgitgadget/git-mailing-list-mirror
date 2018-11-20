Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-13.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE4AB1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 20:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeKUGzf (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 01:55:35 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44198 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeKUGzf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 01:55:35 -0500
Received: by mail-lf1-f68.google.com with SMTP id z13so2277263lfe.11
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 12:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JYW/v5zVWYECKf+mATX+OGusgCiiaj7W5RVI2eYRBWk=;
        b=tBJkiubhNdf4yD7m7D1oPZTaYnMb+Wt4vFyxpqKxHTz/iYcsQ26xKKH243Btxep2Bn
         VodcwEt/hT/i05LGoX3JImxdyPFMYDMrBSefO7WWDCmuFWcQawTFilkHlkkIQ/RfA0ki
         dE9/YlI+T7VQtkiiha9CFJvGRGr0lR2PIx29gUfShgPBttfbL9xlyjKK+gJfjby7jc7/
         tFTwPyCH1Px2oG8Tb2CqS4vjaWYIcKn4g+MeoQv4vTe+BryybAkFCaYh3T+kxxXCWOUt
         guTP0KP3FVe87LUZTzt+eJ6SSze4CnlemeWl8RrJZu0WAQNLIPP6ycGpk9Cjv+rHhNYc
         p4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JYW/v5zVWYECKf+mATX+OGusgCiiaj7W5RVI2eYRBWk=;
        b=GEolXLdHZu7sqveYxNHrQ1MYi8mNNxywvguatOqwaXt4dn+70ZgLdcxQYTOBG0lIqV
         20w/IrT8u5UZHxeul0GpEaLTbIOWubJXdHo2qdJ1YdLiKia8d7j9t0MvZw3RpvjEDFfT
         P7nqztK5GY23kAws3PE3fNDL4n0oyNxXbIIufcHtwuhrC1Xl9Aa4BSmF49uAZJSCvDJm
         jr4baiNajulzArJH/BVFJNUsjuLM+MPWdcD09E7N2DHi6wmo5ioBj6C8tqy+/ceFjuZA
         MGRcALjR5pwpo4oHPNUl2yURy7KB/eSb7CDVIKnxL67yc3appgJH9sme9d5gN591fj7D
         poaA==
X-Gm-Message-State: AGRZ1gIomLx+aB4QzzqLLwVpbKjVkyJ0H+d4NTvqkU5gK9w5NBkomW5P
        XJMg1PeqRz6G96HZGOckLW0JeXfS9ivvN84A8pAryA==
X-Google-Smtp-Source: AJdET5csRNVeMt9d8f0VqerkHAHojO8Q50jzbVNW9jKX1q2wp3HtWZPV/4CeSXX7xASK3cP1mPTB0/D/dWLV0Hs86DU=
X-Received: by 2002:a19:e601:: with SMTP id d1mr2073222lfh.71.1542745476204;
 Tue, 20 Nov 2018 12:24:36 -0800 (PST)
MIME-Version: 1.0
References: <20181115005546.212538-1-sxenos@google.com> <d77c4aa6-be5e-a6fe-1d43-6cfa28161ae1@talktalk.net>
In-Reply-To: <d77c4aa6-be5e-a6fe-1d43-6cfa28161ae1@talktalk.net>
From:   Stefan Xenos <sxenos@google.com>
Date:   Tue, 20 Nov 2018 12:24:23 -0800
Message-ID: <CAPL8ZiukW+mkYBpk-qSmpy3o8u0-mVtcytKLHMz8wpkDd+mRKQ@mail.gmail.com>
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Junio C Hamano <jch@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Carl Baldwin <carl@ecbaldwin.net>,
        Dave Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> If a merge has been cherry-picked we cannot update it as we don't record
> which parent was used for the pick, however it is probably not a problem
> in practice - I think it is unusual to amend merges.

I've read and reread that sentence several times and don't fully
understand it. Could you elaborate?

It sounds scary, though. With the evolve command, amending merges will
need to be supported. If you create a merge and then amend one of its
parent commits, the evolve command will need to rebase the merge and
point one or both parents to the replacement instead.

  - Stefan
On Tue, Nov 20, 2018 at 5:03 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>
> On 15/11/2018 00:55, sxenos@google.com wrote:
> > From: Stefan Xenos <sxenos@google.com>
> >
> > +Obsolescence across cherry-picks
> > +--------------------------------
> > +By default the evolve command will treat cherry-picks and squash merges as being
> > +completely separate from the original. Further amendments to the original commit
> > +will have no effect on the cherry-picked copy. However, this behavior may not be
> > +desirable in all circumstances.
> > +
> > +The evolve command may at some point support an option to look for cases where
> > +the source of a cherry-pick or squash merge has itself been amended, and
> > +automatically apply that same change to the cherry-picked copy. In such cases,
> > +it would traverse origin edges rather than ignoring them, and would treat a
> > +commit with origin edges as being obsolete if any of its origins were obsolete.
>
> If a merge has been cherry-picked we cannot update it as we don't record
> which parent was used for the pick, however it is probably not a problem
> in practice - I think it is unusual to amend merges.
>
> Best Wishes
>
> Phillip
