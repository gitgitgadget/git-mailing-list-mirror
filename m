Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8E691F42D
	for <e@80x24.org>; Wed, 30 May 2018 16:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753307AbeE3QOJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 12:14:09 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33376 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753038AbeE3QOI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 12:14:08 -0400
Received: by mail-yw0-f196.google.com with SMTP id u124-v6so5040390ywg.0
        for <git@vger.kernel.org>; Wed, 30 May 2018 09:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j13FlyrzYQPo6CRwYBGSVn+4OdOWvTGZI5iBYyM98L8=;
        b=R6HHSQYaW8TnO1Y+DU+U/iIBcys/AWHvdiCpeN8w6fCGUs3jXtf6RQvXW+1XfQyfEY
         uhyEmb/Hx/zLtKY2dYO1IekF/JjRDJlxn0sF/rSFRZRcIbKDA5fSFPysaPusM842fcvI
         SDJ7lhgJ8utOFwk/8EilfZl35+ehvJbotjbpLzgORijaYoDXreOCInTdmaS49z7CMF6G
         ut9+JqIuTLih0wKEXhrNFEALW/y2Hfy88YHg1xuf0dGVRKpLoa4mdm8EjK+Yz/1brIBN
         +bh/z+GgRCqBiK4BS9lYTfHmpe/HsnX3WzJck3+ETHfD4SOpGhM9nJdfOwjgszL1yt1t
         gr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j13FlyrzYQPo6CRwYBGSVn+4OdOWvTGZI5iBYyM98L8=;
        b=WHujHZu0+q87mdmz7mv5ho9DgYyD+jMnYROrvw3xK+CEGqiYZSWnrktoWf1rfbYM3o
         25NxtWejQUbT/YCPe/uADS9Yv5UhuFFNKNYu8RezcsyNVIPYZ2IGOVX55OjMHWaqoUvj
         TbOv8jDkgqXdOctrJXqczhqOHCgiovuVrYPb1pgMcD7G7jXzLqmBGLX9/cpNv5ces452
         tVNHORFUvZ1tnnArMSfA1ToqU1xDwLKo/rxgxawQqVa5JQY72bq2j/WgEjgWcI93GSJu
         ajvs6BffJt2kmvcO1YgQUT2/v6mNyvbwxEDjh02aB0o/jxEmhvHwJnZls2G8QWw86uQG
         QXgw==
X-Gm-Message-State: ALKqPwf6JO9JCANQEtxZQu7lD5l8KE9fYaupUvBj7X4gwUBWbvCimp0x
        c9fzAD7Wer1KaAFu2jFOKw1aVGK8fSLe9TzZLS06lNll
X-Google-Smtp-Source: ADUXVKJSIVGdIJVF1x0T14jBHGyeMNk6tXW2SATm/qf8BeFFoJ/NvYHqTv71/AavZ6olursTMys8ux+GR58mlhEIANI=
X-Received: by 2002:a81:b205:: with SMTP id q5-v6mr1802510ywh.414.1527696847153;
 Wed, 30 May 2018 09:14:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Wed, 30 May 2018 09:14:06 -0700 (PDT)
In-Reply-To: <20180530135505.9569-1-szeder.dev@gmail.com>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de> <3f51970cbc44bfe34133c48c0844ed3723e83808.1525448066.git.johannes.schindelin@gmx.de>
 <20180530135505.9569-1-szeder.dev@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 30 May 2018 09:14:06 -0700
Message-ID: <CAGZ79kZ77qBuSDGBJa5b1AvKLBSOOnTad_UXm9EP0aJSrmEohw@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] Add a function to solve least-cost assignment problems
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 6:55 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
>> The Jonker-Volgenant algorithm was implemented to answer questions such
>> as: given two different versions of a topic branch (or iterations of a
>> patch series), what is the best pairing of commits/patches between the
>> different versions?
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>  Makefile    |   1 +
>>  hungarian.c | 205 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  hungarian.h |  19 +++++
>
> (Nit: I personally don't really like these filenames, I know they will
> surprise and distract me every time I notice them for years to come... :)

Good point. I remember my initial reaction to the file names was expecting
some hungarian notation, which totally didn't make sense, so I refrained fr=
om
commenting. Searching the web for the algorithm, maybe 'lapjv.c' is adequat=
e?
(short for "Linear Assignment Problem Jonker Volgenant") Matlab has a funct=
ion
named lapjv solving the same problem, so it would fall in line with the out=
side
world.

Out of interest, why is it called hungarian in the first place? (I presume =
that
comes from some background of DScho in image processing or such, so the
the answer will be interesting for sure:)
