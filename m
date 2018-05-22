Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5143200B9
	for <e@80x24.org>; Tue, 22 May 2018 11:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbeEVLAt (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 07:00:49 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35210 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751240AbeEVLAs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 07:00:48 -0400
Received: by mail-pg0-f67.google.com with SMTP id 11-v6so6086968pge.2
        for <git@vger.kernel.org>; Tue, 22 May 2018 04:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=duSkUwdMV8PcROxBNw1XyDKk5PpJEyWhCHvdwNlysj0=;
        b=gXjH0s144p6c+2pNd1Qza+AiRaVtsWV8JevaR2RxVKRHpO9ec9E10vHIiPx5786x5h
         8X/oY6tfaDx/tV11F3E+oPUoNn49qqRnCSFkATBmUBUPRW8RohkTx3hurq54CoHBpw8U
         ONRyv4p38fk3xssdGDskglYgOuAN82mvvFnRAKLRBuVXbeZrMNkGgIkmF6prvEQ79Hbq
         sTBUKuBTTneKS8nYuo4DdMT3S3G112ic4C9Dlim7PER7jzVPu62eMbAqfAY2nnSXq2u8
         DcFkwH5Pz987/ftcuaJEBBgY5GyYSS497JisU/C+cmzpFb9I3nqa+KWlqd92Cf2wjbx6
         O29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=duSkUwdMV8PcROxBNw1XyDKk5PpJEyWhCHvdwNlysj0=;
        b=hUD1BRQQfaUtya6h1ZUF/SXmxae3cD49WaPb1YzOZdDH71dvIcyTQW9E95KVVvpAjh
         v0n0w3Z46srA4lZGZ/QgwfqsazSHhe3dD8JJN0gDDCt2FzpCkzQ1zoVJEZpGToVxc0/d
         XMJDE6RqZ+BUNSzH+2IxpPomALAKgfgI0sh/YITViglo0qujqhjMPV+rQE0RKwtLLvmA
         BpVDjMKklH45Gp9OSo65LSPfbe6SbHqXcswAr1ewphNEPsIjlIVyQ4cm2Ei4Y6vu9GHR
         MmQm8m5pPd4haLCkByQIG3cQmHFX2v42+Qn9G+PXpPyuTDvzq40Bb+hxltwUZcpjK2A2
         eFiQ==
X-Gm-Message-State: ALKqPwd7Za12vD5DwFy2VX5sKJmGjc3A4D0enZpXn8P8k1V/HoriWY9B
        1Ca9j9JjRvwwMjSOVy6kf+o/YvCehGH0IuqCnxk=
X-Google-Smtp-Source: AB8JxZoYRpoNM5lSlTq4JJN28QUfcfPAs6WLoxifMb37P1pXU6Diq/grBRMQVcqLrKWLtjde3V5NDxuSn3g8XXLd6fU=
X-Received: by 2002:a63:7209:: with SMTP id n9-v6mr8266350pgc.146.1526986847883;
 Tue, 22 May 2018 04:00:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:bb8b:0:0:0:0 with HTTP; Tue, 22 May 2018 04:00:47
 -0700 (PDT)
In-Reply-To: <CAPig+cQevUoYJOisFt9BDhLP1_SjPqX+2hmFKDPcBvAh2D7ksA@mail.gmail.com>
References: <CAPig+cQaJmsJe=E6HdBw0s6eN-qW0OCezBacRcQ+UnJYMbODsw@mail.gmail.com>
 <20180520105032.9464-1-martin.agren@gmail.com> <CAGZ79kZotwAFauTkCJ6YZ_C-MuaQpNaaS8LCniL_Or=_ccfC4w@mail.gmail.com>
 <CAPig+cQevUoYJOisFt9BDhLP1_SjPqX+2hmFKDPcBvAh2D7ksA@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 22 May 2018 13:00:47 +0200
Message-ID: <CAN0heSr1BzF2xZ=rRHUDOv3R7dLSHSJzK-QpAc11ARzkXC8UDQ@mail.gmail.com>
Subject: Re: [PATCH] regex: do not call `regfree()` if compilation fails
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22 May 2018 at 04:20, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, May 21, 2018 at 2:43 PM, Stefan Beller <sbeller@google.com> wrote=
:
>> On Sun, May 20, 2018 at 3:50 AM, Martin =C3=85gren <martin.agren@gmail.c=
om> wrote:
>>> It is apparently undefined behavior to call `regfree()` on a regex wher=
e
>>> `regcomp()` failed. [...]
>>>
>>> diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
>>> @@ -215,7 +215,6 @@ static void regcomp_or_die(regex_t *regex, const ch=
ar *needle, int cflags)
>>>                 /* The POSIX.2 people are surely sick */
>>>                 char errbuf[1024];
>>>                 regerror(err, regex, errbuf, 1024);
>>> -               regfree(regex);
>>>                 die("invalid regex: %s", errbuf);
>>
>> While the commit message is very clear why we supposedly introduce a lea=
k here,
>> it is hard to be found from the source code (as we only delete code
>> there, so digging
>> for history is not obvious), so maybe
>>
>>      /* regfree(regex) is invalid here */
>>
>> instead?
>
> The commit message doesn't say that we are supposedly introducing a
> leak (and, indeed, no resources should have been allocated to the
> 'regex' upon failed compile). It's saying that removing this call
> potentially avoids a crash under some implementations.
>
> Given that the very next line is die(), and that the function name has
> "_or_die" in it, I'm not sure that an in-code comment about regfree()
> being invalid upon failed compile would be all that helpful; indeed,
> it could be confusing, causing the reader to wonder why that is
> significant if we're just dying anyhow. I find that the patch, as is,
> clarifies rather than muddles the situation.

Like Eric, I feel that the possible leak here is somewhat uninteresting,
since the next line will die. That said, I seem to recall from my
grepping around earlier that we have other users where we return
with a failure instead of dying.

Any clarifying comments in such code would be a separate patch to me. I
also do not immediately see the need for adding such a comment in those
places. We can do that once we verify that we actually do leak (I would
expect that to happen only in some implementations, and I think there is
a fair chance that we will never encounter such an implementation.)

Martin
