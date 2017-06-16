Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDAD71FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 21:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750907AbdFPVMQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 17:12:16 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36291 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbdFPVMP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 17:12:15 -0400
Received: by mail-pf0-f194.google.com with SMTP id y7so8148187pfd.3
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 14:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aByNl3DYpKIrPVBnt+Q4jRJkJWBEBMojMFlJVOFix6Q=;
        b=dIph/eGPpHqyF2TveZq2+JZNakhFNkxgY0I3wY6rLDIY0Xd8Gu/qn9x+nI5I8Q2WFl
         v0o6ujv3WOKv8kZv+iqJ/d5bZcgeXCd7DqL/WelAoossO/dbDhsXXuK/ztE0ZNYXdUth
         xfrpUOI5qVlIOSjF2KRAWlJ+LxsM1PUyEy0jWZTvzgwV6uI5HkjQgz99H7Q/BAYmz2pO
         BkJ9jXROumrVXt2vbddPBg6tBICcCJp6APNtDnT4TD11uvkOoeTALTk60jFSbT17++Mi
         j9nQhZLCsT0K5YfILOgDPvd3UB4g+3IkQoQg3j/+b+6NOGY4PgZQnw0bm5pW/EVQY2mo
         h7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aByNl3DYpKIrPVBnt+Q4jRJkJWBEBMojMFlJVOFix6Q=;
        b=mcWpkc0gWbIwclMzNkNLB8KlF3ihH7ffnoen8owKCgdd2hjPGVvqsC4wNO36z6huVI
         Bk598+8X3mQ/A4cwHUqmM2m2QTlW++OwTCvtEORz506g05i+OL2mTZPc0EgahT0XyR/c
         pBnHanZKcs4WzHXZrwo/8X5HeF0GPyMtL4aIH+LZiZTBV9uB13OWVv8mV/gcd0wGXG8V
         zxCLy4ygk/U2V8bLMfg07UAsOIVgWIFT/9B6a3PKV+g5iz8Yc2Dg2FVCbezRxXMz7bti
         I4S7jsIsEzh+O22D+FQy/efY9PZCv5NS2uAV96pinWTpUTmJxYO2OMSy36Uiq6aQDwXi
         J/Lw==
X-Gm-Message-State: AKS2vOy1zVMKpGSc6xW5LKC11EPUkFTvAnHaDEYzPmsIbsa12izpDbhx
        4tSUiPHlI0VCpw==
X-Received: by 10.101.70.193 with SMTP id n1mr13585050pgr.249.1497647535249;
        Fri, 16 Jun 2017 14:12:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3047:3460:ee36:a98a])
        by smtp.gmail.com with ESMTPSA id l22sm6363938pfb.55.2017.06.16.14.12.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 16 Jun 2017 14:12:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Langley <agl@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
        Brandon Williams <bmwill@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Which hash function to use, was Re: RFC: Another proposed hash function transition plan
References: <20170306002642.xlatomtcrhxwshzn@genre.crustytoothpaste.net>
        <20170306182423.GB183239@google.com>
        <alpine.DEB.2.21.1.1706151122180.4200@virtualbox>
        <20170615110518.ordr43idf2jluips@glandium.org>
        <20170615130145.stwbtict7q6oel7e@sigill.intra.peff.net>
        <87shj1ciy8.fsf@gmail.com>
        <alpine.DEB.2.21.1.1706152123060.4200@virtualbox>
        <CAL9PXLzhPyE+geUdcLmd=pidT5P8eFEBbSgX_dS88knz2q_LSw@mail.gmail.com>
        <20170615224110.kvrjs3lmwxcoqfaw@genre.crustytoothpaste.net>
        <CACBZZX5Z3kQHe_5TgOeuJSgzuvpQdaLo6RrgX_EvuZfdz856sA@mail.gmail.com>
        <20170616001738.affg4qby7y7yahos@genre.crustytoothpaste.net>
        <87y3ss8n4h.fsf@gmail.com>
        <alpine.DEB.2.21.1.1706161438470.4200@virtualbox>
        <CAL9PXLxMHG1nP5_GQaK_WSJTNKs=_qbaL6V5v2GzVG=9VU2+gA@mail.gmail.com>
        <xmqq37azy7ru.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 16 Jun 2017 14:12:13 -0700
In-Reply-To: <xmqq37azy7ru.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 16 Jun 2017 13:52:53 -0700")
Message-ID: <xmqqr2yjwsb6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Adam Langley <agl@google.com> writes:
>
>> However, as I'm not a git developer, I've no opinion on whether the
>> cost of carrying implementations of these functions is worth the speed
>> vs using SHA-256, which can be assumed to be supported everywhere
>> already.
>
> Thanks.
>
> My impression from this thread is that even though fast may be
> better than slow, ubiquity trumps it for our use case, as long as
> the thing is not absurdly and unusably slow, of course.  Which makes
> me lean towards something older/more established like SHA-256, and
> it would be a very nice bonus if it gets hardware acceleration more
> widely than others ;-)

Ah, I recall one thing that was mentioned but not discussed much in
the thread: possible use of tree-hashing to exploit multiple cores
hashing a large-ish payload.  As long as it is OK to pick a sound
tree hash coding on top of any (secure) underlying hash function,
I do not think the use of tree-hashing should not affect which exact
underlying hash function is to be used, and I also am not convinced
if we really want tree hashing (some codepaths that deal with a large
payload wants to stream the data in single pass from head to tail)
in the context of Git, but I am not a crypto person, so ...


