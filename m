Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5824C1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 16:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeCPQ2l (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 12:28:41 -0400
Received: from mail-pl0-f41.google.com ([209.85.160.41]:33685 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752666AbeCPQ2i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 12:28:38 -0400
Received: by mail-pl0-f41.google.com with SMTP id c11-v6so6212742plo.0
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 09:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hxTqgT89VNWLzOSoB8rIFY21B+9+cI8T4JMu3b06qNo=;
        b=o7x3NEgOQKdih3eN13pB3jI48Q4BANqJq2syojgvQ5XXpItSbvicUYWn3PThQx6W+o
         ZRM8csrgGQq2kQ+oMLppNTu5+hZi2YaFJ54/dqBdxSjQg4QhG4inPveiIprbTPVePnJ1
         jaf3L9ImHbD2Y09viU00pmwvSfL2GKCz5R6/EPZ5dCdz2m3Hgto9fhN71rCNX9Stzh9i
         eGlXhxnD9OztdBoGIwXi5m4xf+S9eof3DfPfa8ckdFSkTBaIs1C5dWHBrLeeh+UiQ2cl
         gAfYLvPCxT3YlJaRf6j/OLOhIxTh4xVWl5AUMt0npcEvWdHpdCFNQoXDz4Gf8ZBMWt24
         +vOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hxTqgT89VNWLzOSoB8rIFY21B+9+cI8T4JMu3b06qNo=;
        b=r9cD4NFRJpjLbA+j4w9fqcsOFaC42xi61meWQI7R/PrLk6oZE87NNdNXoHSevs0LEP
         fN8dxF9nyyxuZI9PMjASGeQXJzJ03/WMpMMcK1y6q4Su36EEtIFXlWCxxv2VP6eNGYDM
         tAUgPLImEuXmmfAVX/mFKdFH26oNIzbrKpldyod9S3Q3L4C4j62GxxXNtUYT8N8k0RD9
         i1QNcnHR7hDotudd9bRse7LrUSuyiU/0y/rU/4/NofIZoFtx23NKnHVM/P9UtJ9JNGFU
         gU0V3gVa13FXBAFR9BrVb15ss7X8iQEfeysCs5vNa/yXkfSDDZxlB8JoG0IXPSecsYnc
         Vsrw==
X-Gm-Message-State: AElRT7FqRF10kdy3HuEA3G5/emx/PfkMAf+2GpQ0L/z4Sr0wrIPOdkR/
        bO52oHgEKE/0awv/46vRLCE=
X-Google-Smtp-Source: AG47ELtpiW28clKRsQFIzNwpAodb6IebbZmV/cEmUaAtyZ2qWyRTIIfYWuYJp+tUN+fD6M7b+uIkLA==
X-Received: by 2002:a17:902:d20a:: with SMTP id t10-v6mr2776244ply.123.1521217717588;
        Fri, 16 Mar 2018 09:28:37 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id a3sm13143716pgw.10.2018.03.16.09.28.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Mar 2018 09:28:36 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v6 00/14] Serialized Git Commit Graph
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq605yz8ue.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 16 Mar 2018 17:28:32 +0100
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <54BC2335-72B3-404E-AA4A-368DEB121C8E@gmail.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com> <20180314192736.70602-1-dstolee@microsoft.com> <xmqq605yz8ue.fsf@gitster-ct.c.googlers.com>
To:     Derrick Stolee <stolee@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 14 Mar 2018, at 21:43, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Derrick Stolee <stolee@gmail.com> writes:
>=20
>> This v6 includes feedback around csum-file.c and the rename of =
hashclose()
>> to finalize_hashfile(). These are the first two commits of the =
series, so
>> they could be pulled out independently.
>>=20
>> The only other change since v5 is that I re-ran the performance =
numbers
>> in "commit: integrate commit graph with commit parsing".
>=20
> Thanks.
>=20
>> Hopefully this version is ready to merge. I have several follow-up =
topics
>> in mind to submit soon after, including:
>=20
> A few patches add trailing blank lines and other whitespace
> breakages, which will stop my "git merge" later to 'next' and down,
> as I have a pre-commit hook to catch them.

@stolee:=20

I run "git --no-pager diff --check $BASE_HASH...$HEAD_HASH" to detect
these kinds of things. I run this as part of my "prepare patch" [1] =
script
which is inspired by a similar script originally written by Dscho.

Do you think it would make sense to mention (or even
recommend) such a script in your awesome GfW CONTRIBUTING.md?


- Lars


[1] =
https://github.com/larsxschneider/git-list-helper/blob/master/prepare-patc=
h.sh#L71


