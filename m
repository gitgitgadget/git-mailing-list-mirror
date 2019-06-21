Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AEE01F461
	for <e@80x24.org>; Fri, 21 Jun 2019 11:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfFULxS (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 07:53:18 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44646 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfFULxR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 07:53:17 -0400
Received: by mail-lj1-f196.google.com with SMTP id k18so5673862ljc.11
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 04:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=oNMfdCvAq64SRI4VdA0/6v1oZg22VaQLa3OpE11G39Q=;
        b=o1dZWNF538n9bFBRWgTKmsWdzuoanPuvSwIWn9E8NkmoZ0jyuNL91ST0VNwoidYmOC
         zxsWDbHCkTyzNbG6j0O5ErtMNBcUhPDJeJQz+Fa/xkf1+kG4G8rpDzDjF3TTExMV6AWt
         2udZblkQOufmHmi3AAsW5wOOEi7lf6u0BuA+0Y2B32YWfdOVzuSLlC6iX0T5nHKPFHxx
         ECVRy4eNOq1EQDdezloOcmjbkysH+W63nT10VzjqkAtYuU4/5gsDRqhhZrfm0biS6Ukv
         DMvpw3mYrkwOg80HDJoliVoxOo6mNXmWrybddmWlBZMz2eXGVhm4nebACIJI5t45lGtw
         pI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=oNMfdCvAq64SRI4VdA0/6v1oZg22VaQLa3OpE11G39Q=;
        b=rPnogPQNC9Vdt7Sy32zkbpKjH6jvHGLov12g7kji0fywQZc4ejDsbXq1C2lsxVu84v
         P4YbXtieSaifR08m3WRTrvSfh+qult8l98GZcmqPbKOkUvPMIwOIlHRwjGXd6cp4Kmzf
         md4EUjEoUSRWgRChsS/vHKdhq6v1nh1gASz+dh6kPFbBZmSFP+mq48ANV5uoUR6yk7L7
         62qOUUxeX8EKHoni9HAWSs//DLmqERR8wafG/5SsBxVBE92t2MgfSmGeuGR93xwoiYfu
         dD3CiwcKhUMg01cSVWM18FQm1H2NvtfBeXAl7LVVvqColQ+eBMuPOPfPBk0lo2ir0IU9
         mbeg==
X-Gm-Message-State: APjAAAXA/LSgYG5Gy7fUJfUL2SVj+9qjxdhYymrxTptu1oNN+9dcVOeA
        8gRPkdnTtOJYdE9Z7bBKkqQ=
X-Google-Smtp-Source: APXvYqxJY1/JTwXCBVlvZOhBaGkGf3lTvVUDTMxkwk/SkY+eUWJUVCiUACEw/yHOB7L1pvXkzhk3dQ==
X-Received: by 2002:a2e:858b:: with SMTP id b11mr627815lji.159.1561117995787;
        Fri, 21 Jun 2019 04:53:15 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 ([158.75.2.128])
        by smtp.gmail.com with ESMTPSA id i1sm349712lfc.86.2019.06.21.04.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Jun 2019 04:53:14 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [RFC PATCH 3/3] trace2: add a schema validator for trace2 events
References: <cover.1560295286.git.steadmon@google.com>
        <7475c6220895d96cdc7d25d6edea70e2f978526b.1560295286.git.steadmon@google.com>
        <87v9xb7x0q.fsf@evledraar.gmail.com>
        <20190612162341.GA42943@google.com>
Date:   Fri, 21 Jun 2019 13:53:12 +0200
In-Reply-To: <20190612162341.GA42943@google.com> (Josh Steadmon's message of
        "Wed, 12 Jun 2019 09:23:41 -0700")
Message-ID: <86y31vxihj.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:
> On 2019.06.12 15:28, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:=20
>> On Wed, Jun 12 2019, Josh Steadmon wrote:
>>=20
>>> trace_schema_validator can be used to verify that trace2 event output
>>> conforms to the expectations set by the API documentation and codified
>>> in event_schema.json (or strict_schema.json). This allows us to build a
>>> regression test to verify that trace2 output does not change
>>> unexpectedly.
>>=20
>> Does this actually work for you? As seen in my code at
>> https://public-inbox.org/git/87zhnuwdkp.fsf@evledraar.gmail.com/ our
>> test suite emits various lines of JSON that aren't even validly encoded,
>> so I can't imagine we're passing any sort of proper parser validatior,
>> let alone a schema validator.
[...]
> The problem with the existing validators is that they expect each file to=
 be a
> complete JSON entity, whereas the trace output is one object per line. Yo=
u can
> of course loop over the lines in a shell script, but in my testing this a=
pproach
> took multiple hours on the full test suite trace output, vs. 15 minutes f=
or the
> implementation in this patch.

Isn't this JSON-Lines (http://jsonlines.org/), also known as
Line-delimited JSON (LDJSON), newline-delimited JSON (NDJSON) format?

Best,
--
Jakub Nar=C4=99bski
