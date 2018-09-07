Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 511D11F404
	for <e@80x24.org>; Fri,  7 Sep 2018 17:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbeIGWEE (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 18:04:04 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43398 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeIGWEE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 18:04:04 -0400
Received: by mail-yw1-f68.google.com with SMTP id l189-v6so5649239ywb.10
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 10:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bycun0zd5QlaKi54t+k9qLZgj2KYTO+Fyjq2c0pZIbk=;
        b=sH9l8E6x8B4Buht8eU6d35wVBWHpfwS0vXfoVnRhpjkye3yyraIxxFU1EmwOOl7A7y
         mLfhLV9BVnzpNIK0mb/rLBRlGH6MAGe3bJZc1+DM3mERvrpZ0EJkHTO+q5SLWVs5KffE
         Mockb+NMnkmRKDcRTHUDpbTCyOz+9tEepA8Y3yx41YuaGr6dS9jmR1TFIB2Xm/iaGX3g
         vxy/5Xz1HSOpTElgSJhDOc47/q4g/9PO5KaHEgJxdMRVP/IqbQm/aXDOgyr4VDfMYDWb
         WEZ62WT/AZXU5vrRVEfz+aKGCbSNpAbbxWc29XMOz6Vj4op0w9uCLOt44BbdGqiLDhhv
         6TjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bycun0zd5QlaKi54t+k9qLZgj2KYTO+Fyjq2c0pZIbk=;
        b=S/VA0/Q+zRjPvot1o0YVQBC/oJj3vanOXk+Z8OIlMSm4yUAC6voMkiQm8e114gAH9d
         myPZZPe0Y2iwG+rastZe2nDPJmKmiPGra345bVmpWi/5O2q94hT3x8LEtvdmqGYGoz9p
         0XGYDKJcrp36WhOZdaQS0YKWBbmZZ8anJKwEmRh3xROeAtbm/peZ8INrteD5cLPT4t+3
         myV2nUBmX6VxLk0OmXser57GwmxtbboaEWd3Ft1RdOypZDw5+wfJb4AOIG4gxF/KSsY/
         EWA/Py1eBV+++0WsKGRa+2d8Wkx0IqjR/hfEuGh2NjetqxxzAVsYMEDDpSK7/jIIe18t
         3suw==
X-Gm-Message-State: APzg51A4s10IGUHfBBXpz7OdS0CTbunpgNirVMFPEnDHwLn391ralJbF
        v8e5bUi9IZXKblI+ooDlyILitsAMYfeTj6f5aoqRf+T9ovw=
X-Google-Smtp-Source: ANB0VdaKzeFgMtpBGXq/QdyoH/cZHXZA3zRMGrhhKCPNJPMiGQ6fXMqeyNrSojE0mxamjWY+zoVzUfGfmjwbvVC8TK4=
X-Received: by 2002:a0d:e6c8:: with SMTP id p191-v6mr4790614ywe.119.1536340928358;
 Fri, 07 Sep 2018 10:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180904230149.180332-1-sbeller@google.com> <20180904230149.180332-2-sbeller@google.com>
 <xmqqh8j236wj.fsf@gitster-ct.c.googlers.com> <20180906165602.GA19367@sigill.intra.peff.net>
 <CAGZ79kbRyVZ_1QpX0pPigN+2Pt2dV1eYvLyoWeSWejbLxko4YQ@mail.gmail.com>
 <20180907000423.GA16764@sigill.intra.peff.net> <xmqqo9d9y6oy.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo9d9y6oy.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 7 Sep 2018 10:21:57 -0700
Message-ID: <CAGZ79kbObDXyaRLADQpvMMSitOLCDwb030Q6UBiX-7Y-XWnqog@mail.gmail.com>
Subject: Re: [PATCH 01/11] string_list: print_string_list to use trace_printf
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 7, 2018 at 2:53 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > I guess the question is: is this a thing we would want to make available
> > to code to leave in all the time? Or is it just for sticking in
> > temporarily for a quick dump?
> >
> > If the former, then I think it needs the early-return at the least (and
> > probably _should_ have the key parameter).
> >
> > But I get the feeling that you really just want the latter, and are only
> > grudgingly being pushed into the former by Junio's suggestion.

That is not quite the case. I did take all but the one suggestion
as I think they are good suggestions and I appreciate it.

However having the trace key is not useful I would think.
(I did not need it for debugging, but presented an API
of what I would have found useful)

If the key is really that useful, I would just think we can add it on top.

> Well, if that is the case, I'd change "my suggestion" (although I
> didn't mean to suggest anything concrete).  If this was needed
> and/or was useful only during the defvelopment of the remainder of
> the series, and if this is known to be a half-hearted change that is
> not meant to be useful as a general solution, then let's not take
> the main part of the series a hostage to this step; rather, we
> should drop this change and leave it to another series that is
> willing to do it right.  It would save both author's and reviewers'
> time if we did so.

In that case, would we be interested in a separate patch
that kills off that function instead?

Stefan
