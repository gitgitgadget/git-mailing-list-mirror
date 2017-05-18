Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 404D62027B
	for <e@80x24.org>; Thu, 18 May 2017 04:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753924AbdERENs (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 00:13:48 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33851 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752632AbdERENr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 00:13:47 -0400
Received: by mail-pf0-f195.google.com with SMTP id w69so4202323pfk.1
        for <git@vger.kernel.org>; Wed, 17 May 2017 21:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0CB7xw9ObAxT1Tgqtq2vEOwvuGYYmyDK9JVX7KY2/9c=;
        b=EJF1QtoYe9mtBKjOqV4ceVnA5pGkebkF10bvAW5QKEdo8npMHgZBuUik0a8nAnCnCf
         Rfjfa2DTu35BYqTwozPg5S3DYjhtW03OaurVcNrHPs1tvfmhJsT5iSkbj5BJV6vbCTAM
         V7cI8AATAH88XAjHTprr+75l81Uv5CtWQ76Sq734B/t252Arm3rIY7+nqgLTqX8o5ZSq
         DZrJW6m782V5jnualvK7IE2MHO8CufsVW8wKUBd5UVBV8aw5Rr+VVP4L9+TLxhkBZZsX
         dR96Js0TQTPJYGuoQ5fdO5e3vHqD2VVY1CWnw5FWW/3ob5qjac6erYz7M9VhmLz0XH9z
         ye9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0CB7xw9ObAxT1Tgqtq2vEOwvuGYYmyDK9JVX7KY2/9c=;
        b=E+hu+8zzvCNbmvcesH+Xj14lRPGh2THLldMtWGFifqP/o461kJpfvRfu3xDCXInTf3
         RmuKSvKnJgDawRmmvmT6Yqd/CvS+dStRqMFoCRpedC7EUOlGVVA+shpFp87MizFW0LZP
         foPWCX3JU+QIkuHqBByA5GoSSGfloVcupHy4yIVQtyt4RhSNTJbAK9yGzZmrwnHPJ/h9
         rAoAxE5eID9OXLKNaR+ATMBH/osKt8myTdmap2QfWrqSuSoyEGHWIoa+W4LGhsj1Dk8h
         ZTIobmbNVarMGg7tNfKiImSEZtj+91fRZNCOExGkHB9ONnb1LNIMR+NlZtDLOdIdZ0MR
         odMQ==
X-Gm-Message-State: AODbwcD4hnZACrC94qhs1u8wdT1tumT0KoFMTGRdIkQ51TMUXIYzbqpP
        v0m6hjOcFiKp009Xbmg=
X-Received: by 10.99.160.68 with SMTP id u4mr2207170pgn.39.1495080826781;
        Wed, 17 May 2017 21:13:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f155:f4fa:305b:79e3])
        by smtp.gmail.com with ESMTPSA id m25sm6220983pfk.15.2017.05.17.21.13.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 17 May 2017 21:13:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 02/23] refs.h: clarify docstring for the ref_transaction_update()-related fns
References: <cover.1495014840.git.mhagger@alum.mit.edu>
        <f56871ab01d7a9b07631f143ae902605a1e247f4.1495014840.git.mhagger@alum.mit.edu>
        <CAGZ79kaMYVp7SLq3MspC6f45=QUZM=mJMxNDfwVj+1cgEhMQ6Q@mail.gmail.com>
Date:   Thu, 18 May 2017 13:13:45 +0900
In-Reply-To: <CAGZ79kaMYVp7SLq3MspC6f45=QUZM=mJMxNDfwVj+1cgEhMQ6Q@mail.gmail.com>
        (Stefan Beller's message of "Wed, 17 May 2017 09:46:20 -0700")
Message-ID: <xmqq60gyvm2u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Wed, May 17, 2017 at 5:05 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> In particular, make it clear that they make copies of the sha1
>> arguments.
>
> A couple weeks ago we had plans on getting rid of SHA1 in
> "the near future" IIRC.  Would it make sense to not go down
> the SHA1 road further and document this in a more abstract way?
>
>     s/SHA1/object name/
>
> essentially, but I guess one of Brians future series' may pick this
> up as well.
>
> I am just hesitant to introduce more sha1-ism at this point.

Don't worry too much about it.  These new paragraphs explain
existing new_sha1 and old_sha1 parameters, and when they are updated
to new_oid/old_oid, the comment will get updated at the same time to
match.
