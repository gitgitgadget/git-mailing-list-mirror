Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17D4F2022A
	for <e@80x24.org>; Wed, 26 Oct 2016 20:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934192AbcJZUn2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 16:43:28 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34051 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933406AbcJZUn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 16:43:27 -0400
Received: by mail-qk0-f171.google.com with SMTP id x11so19160174qka.1
        for <git@vger.kernel.org>; Wed, 26 Oct 2016 13:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3/uYE4zT7n9Mbiy0/YCCQn6eSwPPnHefZopVijnKnsA=;
        b=Pk0SaOktYOSIk7yf9+mJl/CqP24JSbkQZbWuJjmmLSJL/iNNiiee/i9MTyBIkP9deA
         EZOhdTHhyU46ipNaOp0Mj5gbtUb4Nl5uiLxR5ApwwnwVwsUXht1NG9H9XJk6Obeehiql
         lSIOuXu2+uei9DOGO6YvQ45I78BccbjgzrGBLGvEcI6umeVI+xtF2J1vPZxOkVloqYzr
         KrROB6bYgD7hMntUiOsimuQaSvh+s+qwV8vFPnj3N5n8lZWXcimeDffJxkFpeh2ZmesA
         sKrO9RlX3MGbvnEKvfkmlV2Yhvscd1FoQHniYFR7Ut3FSxWVFivAMjGAVxvC5EluY2wS
         GUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3/uYE4zT7n9Mbiy0/YCCQn6eSwPPnHefZopVijnKnsA=;
        b=h4KLUOynncPT1d3amxV8MvaN4+JrrgL1y8rSlf2cDHhHuAK3/DqImZhkd4M2PMroEl
         gYkdqqDBk37Xwxi+hiGHlh9O5PjVY0YXN8W7xp9BWGBGrMGDlsVk5civo219uS2bW8ik
         zP/52TnJ7BW1ikpvay/o8zIkZ/HJAqYFDY0mMeAAV3wtinYGcOm16SoM8nFpUPZlIZyK
         aMgSY58FFr6ZNY3UJx8YOlS5Mw1xoShXEbOXPubx4Iqt8Ct1P1mVSCJ8bWtH1AvQi9dd
         j8NGAWj6hwEbcwROHDAqVQYxguhdEZqPMrXTXMA3XcjaKddDl8mEBz0DdU+hg2ncAwE/
         /l1w==
X-Gm-Message-State: ABUngvdQKw72EFaVqtv72ldCbys55x2Avnn2HAbofB2zmhT4TBDoM/0zhAxlnSrW/y33PbJbLPyCICLQ/B2ZfOhX
X-Received: by 10.55.20.164 with SMTP id 36mr3124422qku.86.1477514606200; Wed,
 26 Oct 2016 13:43:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Wed, 26 Oct 2016 13:43:25 -0700 (PDT)
In-Reply-To: <20161026202652.kz63mxqqjan7swvl@sigill.intra.peff.net>
References: <20161022233225.8883-1-sbeller@google.com> <20161022233225.8883-28-sbeller@google.com>
 <alpine.DEB.2.20.1610261049470.3264@virtualbox> <20161026093558.drsdwn2hm7bbcktt@ruderich.org>
 <20161026121525.twgiavpgfbr2ahvn@sigill.intra.peff.net> <CAGZ79kYgk9rQDju0MT2uniaxhAWpzJ9f1T9czgNnxfq+Wz6m+A@mail.gmail.com>
 <e1f760f5-27a7-8266-5d6c-d61fab7e194d@kdbg.org> <20161026202652.kz63mxqqjan7swvl@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 26 Oct 2016 13:43:25 -0700
Message-ID: <CAGZ79kYNLrkTMg97QU6xwC+zh=hW4LHuyPxwQkkLLaKyYO5sOA@mail.gmail.com>
Subject: Re: [PATCH 27/36] attr: convert to new threadsafe API
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>, Simon Ruderich <simon@ruderich.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2016 at 1:26 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Oct 26, 2016 at 10:25:38PM +0200, Johannes Sixt wrote:
>
>> Am 26.10.2016 um 21:51 schrieb Stefan Beller:
>> > it is
>> > very convenient to not have to explicitly initialize mutexes?
>>
>> Not to initialize a mutex is still wrong for pthreads.
>
> I think Stefan was being loose with his wording. There would still be an
> initializer, but it would be a constant (and in the case of pthread
> emulation on Windows, would just be NULL).

Exactly, so we would do

/* as per the man page of pthread_mutexes: */
pthread_mutex_t mymutex = PTHREAD_MUTEX_INITIALIZER;

int somefunction()
{
    pthread_mutex_lock(&mymutex); /* threadsafely initialised on first use */
    ...
    pthread_unlock(&mymutex);
}

and for the Windows compat we'd do


#define PTHREAD_MUTEX_INITIALIZER NULL
#define pthread_mutex_lock emulate_pthread_mutex_lock

int emulate_pthread_mutex_lock(volatile MUTEX_TYPE *mx)
{
    if (*mx == NULL) /* static initializer? */
    { /* this stackoverflow magic to initialize threadsafely if not init'd */}

    EnterCriticalSection(mx) /* as it currently is in compat/win32/pthread.h */
    return 0;
}






>
> -Peff
