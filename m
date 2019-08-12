Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,SUBJ_ALL_CAPS shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A5BC1F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 12:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbfHLM2T (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 08:28:19 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34824 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbfHLM2T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 08:28:19 -0400
Received: by mail-ot1-f65.google.com with SMTP id g17so7021113otl.2
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 05:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wk6Pkb/wm5aM7xZggv7bI4AGjwLjZQ4yvsqceaVuuVI=;
        b=HyM1CdhfTXzjQ5pScnKl3gHga3108WJx2U2kHBmtYz9lFik2Die6ZhZsour3XYZoFU
         YJVEXGlAyT0sOZfTogQ/o3OiPXRWx8EORu7rSFrHHDi6IXimTtWrY4KbS9R8nX+m0mfl
         cBEUr6w0B+2TQHYLlc7a2puLjXXVNQ6lGVNxIUUoMKc6JIw/4hGtwXVqfd17PRS2Bq5z
         W4ZDdvuvH/dlfa2zxw2qulpUcydPeQ38mPz6gH74/Wq9+2rCL7q+JNP7d+gwttmOH+ic
         lhJVso77WPBj8/1+mJPH/Iiq+pJ7oFbbE4JZ8HsU/k0Mrpr8epdKxpiqrUODINlkdViO
         hPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wk6Pkb/wm5aM7xZggv7bI4AGjwLjZQ4yvsqceaVuuVI=;
        b=qLj1cRSgESnlZ/ZVgRIfX/nuaIS2bw+aXEkut9TZYV4Y4p342HrZNLB8SWbtYNy1S3
         JSJFYp5sBhXxTUZLDIDZmLbUV6tyUf/uO9u7nX7OqB30b0GkgaNYpFcqlZCjRsLmosV/
         NfCuzsuGhNiopZ/NfnWGVp3cDJU5MnQ1lIZZwJCEKPwk4DSKOi7KWLZ6ZRwl6g92+IT4
         ob0oEwlxl5Vh6AQJ3z9lEpL89cKaHDy0mxrH5ZoxJnOhUOjSQfiN7SpjNsVOCIuesoCG
         43rmiiu/0I/7e1GiAO4tR6T6T+p+Dc8qcbs2+B95MOHSocOydN6j/kFHH6g49nzKpekh
         0rCQ==
X-Gm-Message-State: APjAAAX6zza4EyhayIQNON9a5WytPfLFJ7HPHFHEurrAxd//pA6dvuPW
        hC4YmmAGDJbJUNjPDb2bFfDD+ysbGkeQ0ORPlCY=
X-Google-Smtp-Source: APXvYqy5RA431m3YODE9ZRNnuFfUN3c3/6vvkOPKLymhkH3ov5B/ppJjyjIIgdE+t3CgRCUwy33JJamAtJ0qB+1/Wo8=
X-Received: by 2002:a05:6602:2413:: with SMTP id s19mr34741157ioa.161.1565612898155;
 Mon, 12 Aug 2019 05:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.QRO.7.76.6.1908092325480.46@tvgsbejvaqbjf.bet>
 <20190810030315.7519-1-carenas@gmail.com> <f78b57a6-9ede-c87c-fc42-292851d79fad@web.de>
 <CAPUEspjtZhhynEmJu_weROaao=1zL+De1h50R-grG36ok+EAyw@mail.gmail.com>
 <501f946a-1f18-7c6a-2d15-8ff6375c4192@web.de> <CAPUEspiuuCWgjuHZ7DLyH+0hXt7MqeP++xyZuB+Zd5t-H_d69Q@mail.gmail.com>
 <370b308e-40a2-4edd-b0db-ab0fb84d1c9e@web.de>
In-Reply-To: <370b308e-40a2-4edd-b0db-ab0fb84d1c9e@web.de>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 12 Aug 2019 05:28:06 -0700
Message-ID: <CAPUEspiFuvgMQ3W1se1B=8aTTrQsJSZTyQTzG1TpiyN8HTOpkA@mail.gmail.com>
Subject: Re: [PATCH] SQUASH
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     johannes.schindelin@gmx.de, avarab@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, michal.kiedrowicz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 12, 2019 at 5:14 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> That looks like an issue worth its own commit.

OK, but then will make my topic interesting; indeed it almost feels
like it should be 3 different topics all depending of each other in a
chain:

* really use the match context
* move to xmalloc (2 patches, one for each PCRE library)
* fix leak

Which then will conflict with ab/pcre-jit-fixes before it can get merged to=
 pu

> I wonder if we'd want to pass pcre2_match_context to pcre2_match() a few
> lines down as well, for consistency.

yes, that is actually what was tested[1] as can be seen in github
where Dscho integration did most of the heavy lifting with Windows

Carlo

[1] https://github.com/git/git/pull/627
