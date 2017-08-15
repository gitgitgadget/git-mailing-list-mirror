Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBBF6208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 18:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbdHOS35 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 14:29:57 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:33047 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbdHOS34 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 14:29:56 -0400
Received: by mail-yw0-f175.google.com with SMTP id p68so9706874ywg.0
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 11:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xmVDVdmum/Q+LYcvrNc3SJW78HrH/BfOsKpOEOy7WBc=;
        b=PwCOed37P2sNI3S0swgQrfiRmicSrD4vy8ms/9n0YhdHS/CkHjL+JGFwYP/GYn4A73
         ykzgY73MEo34/mFITcFwEuhEVqANWW3jRX02KK9r8f7q6VHKtc6MacuRkYHtrwIOq5yj
         YQ9fEE2+aTHrauTMS7FsaIbAGn50GQb8tTZrE1e+0lQdvZEGLU5aW+47G+pSGF/Up3BZ
         26Z8BLtCTUaCHLQu2mWCq//qld2KvykVPAlPkF5sYonj5Fa72rtleb8Xp79MWXGY8R0E
         KKzjf1KB+LB0xWqxMlDOfPJnfD9DabiNjYdJhU5c8k0Vj5SR7Kq5z0ObpsBNm/es70pk
         Bf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xmVDVdmum/Q+LYcvrNc3SJW78HrH/BfOsKpOEOy7WBc=;
        b=TSs75VfWIDgc8i+rWm/svRNxDOBSCubRrQfm5KfuRGbZDwRWQ2SGrdUAwrGhI+ve1v
         ed/hiW8Pze9iRS2xttOCZ86zwESz1PPdK332GzEys7FKYyOMEFLm5pFjsk2j6d4a2g3E
         03HejPwZEfAMETFXvAPfNH6R/sn6cOdEFCSc0T5Pm/c59mTR9CDrmfb2hM12wr2Ls0UD
         Fz6Ni6BM6OsctJBi35O4BGXhbaN5n4lgXuvBJLRIDaqKQ36kP3xxXXUNhKqgsPDa2f/S
         I98FFpXs3ECoy+gR/wCZwKgHOfcZ52ah5b3qOUgrnwss9IYn0PM89fY2CAw71aManCEY
         arsw==
X-Gm-Message-State: AHYfb5iEfsbR+FmNyEPbIdyFj0vVuFvBHFihi3BNj9zwGUgO/bmfQCjV
        AyEUwfqvUaSgtf49aSdYaf+XA7w6XOWV
X-Received: by 10.37.55.79 with SMTP id e76mr23745640yba.215.1502821795634;
 Tue, 15 Aug 2017 11:29:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Tue, 15 Aug 2017 11:29:55 -0700 (PDT)
In-Reply-To: <xmqq1socsnay.fsf@gitster.mtv.corp.google.com>
References: <cover.1502796628.git.patryk.obara@gmail.com> <a21088f049390828cdee957f88503e8466e1d34e.1502796628.git.patryk.obara@gmail.com>
 <xmqq1socsnay.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Aug 2017 11:29:55 -0700
Message-ID: <CAGZ79kaCA29j6ON4KSsB=EH8FPfZGE56hVGSAAepcPiH952v6g@mail.gmail.com>
Subject: Re: [PATCH 2/5] sha1_file: fix hardcoded size in null_sha1
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Patryk Obara <patryk.obara@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 11:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Patryk Obara <patryk.obara@gmail.com> writes:
>
>> This prevents compilation error if GIT_MAX_RAWSZ is different than 20.
>>
>> Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
>> ---
>>  sha1_file.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I think this is OK for "null" thing, but in general I feel
> ambivalent when I see the use of "MAX" thing.
>
> Use of "MAX" here implies that we wish to support multiple hashes at
> the same time in a single binary, so that longer or shorter hashes
> fit there.  But in such a case, the callers would want a union of
> some sort so that they can say "I am using SHA2, give me the null
> thing"?
>
> I said this is OK for "null" because we assume we will use ^\0{len}$
> for any hash function we choose as the "impossible" value, and for
> that particular use pattern, we do not need such a union.  Just
> letting the caller peek at an appropriate number of bytes at the
> beginning of that NUL buffer for hash the caller wants to use is
> sufficient.
>
> Thanks.

Once we have 2 hash functions usable in a local Git installation,
this would be wasteful for the smaller hash function (and the
related grafts).

I think Jonathan once envisioned an 'optimized' version as a
second step, maybe this is a good time to discuss how we'd
get the right size for e.g. allocating memory, as _MAX_ seems
to be not the correct solution long term?
