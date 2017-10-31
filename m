Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B67420437
	for <e@80x24.org>; Tue, 31 Oct 2017 16:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753510AbdJaQl2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 12:41:28 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:56825 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbdJaQl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 12:41:27 -0400
Received: by mail-qk0-f177.google.com with SMTP id l194so21204553qke.13
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 09:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3r/iT9GoVrnSlJ0gMXyNJ3l6LqXmhp31haCiJfBzvKo=;
        b=X5me4rgiE7dWaZ9RZUx2mF+C4aBambW/Zxd0t2v4jH5oGhzKemgqz84jSTBVeNgDVp
         vpLhtYV4lkLNHFLkUDx8bOpWbNsll7YWdroaqWoPZrK9HYOejkTebWwFuZI9PuDJE7jX
         gxeeq9P0+hbDQHTgxui+4wCYKOSrXIxqsSVewPzcH9Rpxtj3KMjx5QnpAaVcouxLqGLb
         moM1LmNWPEiInKCwhXbWizA1QMFC1+farhgjcV16xzBrFk8Sc+jDjqnXXgbeaWPifvEv
         f/kWm7q30btGz9qDiy8m33HUbeDMw8/kFKGOhBYvuX26JsYfQQb4uCSrHi2zJZ5NMNHC
         5X0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3r/iT9GoVrnSlJ0gMXyNJ3l6LqXmhp31haCiJfBzvKo=;
        b=ZaDZrnaMcFiWfQy4fq1DEUNJc9po8akKEqvOkfPEDuh6ar37Quwo7Z+QWaEpo+vm4P
         wNx4jyXLSiBBJrDanEUPa244q6XzsmNdIhUwZ71H4Hbvm33z0lInL0eJjshfaDvfqPz0
         6dfoXHHYcagsEiJnh8eomGkeJxVXCT0ZEnDvw60fTN0bR2LZEuLVyu+N5iZxP8ERBcoN
         dLtaD4K37AFVT+OiETIpmqGjAuZV72+X1DlA+3Kk7Lc7eBZrf1Kv2s/8bjbvYsJAKXML
         wvElx1uY9Hhr5VXvlXm5NItLk/Jni+uZJ0Sqg2Y0ARwYx4MDwiH2uKPPz8BGC2UhI5Sz
         JqFg==
X-Gm-Message-State: AMCzsaUKjTLOs5xzofZOpk0mwfy9AQAhwV6zn5IXAUFu69LOub3V9gEC
        Koph30nDxONMfD/4JDLfdeUfLrsdMLU7StJkDwl5LA==
X-Google-Smtp-Source: ABhQp+Q+VhRhYm+0iRKYsFHCatV3UnHQHJvAkDDJDYrhHh2OgDBn/onnr5axzuSGeAwqitnhyMduWwsyARr8cANHA/s=
X-Received: by 10.55.111.3 with SMTP id k3mr3556987qkc.332.1509468086169; Tue,
 31 Oct 2017 09:41:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Tue, 31 Oct 2017 09:41:25 -0700 (PDT)
In-Reply-To: <xmqqpo942fzk.fsf@gitster.mtv.corp.google.com>
References: <xmqqinf1ce3i.fsf_-_@gitster.mtv.corp.google.com>
 <20171027170745.2125-1-sbeller@google.com> <CAGZ79kbNMWqPkk9PGDH44YYPC=Mgqk4+sTmRwQUGKF_JCmbpLA@mail.gmail.com>
 <xmqqpo942fzk.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 31 Oct 2017 09:41:25 -0700
Message-ID: <CAGZ79kaSQzLEjmD3+YgQOz5cety9Y3MZmUo7EkKA-JdQRt_Diw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Re* Consequences of CRLF in index?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 30, 2017 at 7:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> (I note this as you regard your patches as a lunch time hack
>> in the cooking email; I am serious about these patches though.)
>
> We do not want to touch borrowed code unnecessarily.  Are these
> lines and bits hampering further progress we are actively trying to
> make right now?

No they are not, you are correct.

I differ in opinion on 'borrowed code'. The latest release of xdiff
(v0.23) was in Nov 13, 2008 according to http://freecode.com/projects/xdiff-lib
or on March 23, 2006 according to https://directory.fsf.org/wiki/LibXDiff
and given that we incorporated so many changes already to xdiff,
I would argue it is sufficiently different from the original, we'll probably
never import another upstream version (if there will be a release at all).

So the code was rather taken and now we are the bag holders in
maintaining it, so we can make it pretty even only for the sake of
pleasing ourselves (or rather: not confusing ourselves with too
many unused flags).

Thanks,
Stefan
