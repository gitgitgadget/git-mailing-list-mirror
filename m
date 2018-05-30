Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00ED01F42D
	for <e@80x24.org>; Wed, 30 May 2018 13:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbeE3NzQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 09:55:16 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33641 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751794AbeE3NzP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 09:55:15 -0400
Received: by mail-wr0-f194.google.com with SMTP id k16-v6so2400833wro.0
        for <git@vger.kernel.org>; Wed, 30 May 2018 06:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bug8iMLJuCTOUcvH0glkcTzMCfazLUSYjTwe4TcRe1E=;
        b=XujmodCt6nirLX2pi66BTaPjW72isFAMuPD4+3ZzngrtbK87/sNt5zJZn4N9Y8teIi
         mVqCsIh1ww8GYG0cLGU9Jw8jrGZ5QaPMLkG7Xa7Ph4D7/JJtRMfVJ3dfQG6VyXBVqmVY
         nqgehWNAYAdhDl+7jxaVq4H2QpbypGTPmRrV9cDL5W8El/Lxqk9Hovkxp49sf18vxTQ6
         y8Mnah80L0SFo67DQUna0fLyD5ugtwKe2QZGa5H56HkHfFOAvm70iuHQR8a5b4g3KMGk
         RFeoiiTe1JPt1VOICQ30vTWZFYLCtDW3rV8bTeOdjEZBDiq1ks6JCpvvFahhH9jpYoNa
         7jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bug8iMLJuCTOUcvH0glkcTzMCfazLUSYjTwe4TcRe1E=;
        b=BQW1G+MSr2z3wlyCwdVnQ+D4O6v5CWWcfAhaSQUu1opjeixyPyAKM1/SNM3EBUOSEv
         484eNTUhgf22YcXSJ7qZ+qZ6omN2iAc/RiFjTfPdNC3Roh/Y2ph4ZJ/PCdNIemOdcnvy
         lMVoiQ8ypA1Sj7xleUMwmgBqQvWJ8SshoKm6FBNiby+lLEv9lLkFEHHW3eXZYVlRGm3y
         VJM7FvYomNG1Hl5PsvA08AYUqquVCoeq8dClGf24t+FnzaQ3mJ6i7BFZjDtge6k2Reb3
         vD/EZMgMSWOy4AiPBuHPuk77Shvl0kHFaNVrhuGLNBY+Ik2MRRcSRl/5naTOEVYRIiX5
         7/Eg==
X-Gm-Message-State: ALKqPwflsjibtgD+z3ORIxow8308xjrbUk/wf2VmKyNuiyuUz4F2dgbv
        V7xCOfamkvo1HwkijrdQVnQ=
X-Google-Smtp-Source: ADUXVKKCn9nyNFO3DdmMaVIryXx5W+N0LnxU1qKMEqxm28lYUA10KIMDYVPb2dKjKfC7U6y3JpSKrQ==
X-Received: by 2002:adf:d192:: with SMTP id h18-v6mr2170865wri.198.1527688514117;
        Wed, 30 May 2018 06:55:14 -0700 (PDT)
Received: from localhost.localdomain (x590c60bd.dyn.telefonica.de. [89.12.96.189])
        by smtp.gmail.com with ESMTPSA id e14-v6sm2280582wmh.17.2018.05.30.06.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 May 2018 06:55:13 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 01/18] Add a function to solve least-cost assignment problems
Date:   Wed, 30 May 2018 15:55:05 +0200
Message-Id: <20180530135505.9569-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.1.1124.gac09da1361
In-Reply-To: <3f51970cbc44bfe34133c48c0844ed3723e83808.1525448066.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de> <3f51970cbc44bfe34133c48c0844ed3723e83808.1525448066.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The Jonker-Volgenant algorithm was implemented to answer questions such
> as: given two different versions of a topic branch (or iterations of a
> patch series), what is the best pairing of commits/patches between the
> different versions?
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Makefile    |   1 +
>  hungarian.c | 205 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  hungarian.h |  19 +++++

(Nit: I personally don't really like these filenames, I know they will
surprise and distract me every time I notice them for years to come... :)

> +int compute_assignment(int column_count, int row_count, double *cost,
> +		       int *column2row, int *row2column)
> +{
> +	double *v = xmalloc(sizeof(double) * column_count), *d;
> +	int *free_row, free_count = 0, saved_free_count, *pred, *col;
> +	int i, j, phase;

<snip>

> +	for (free_count = 0; free_count < saved_free_count; free_count++) {
> +		int i1 = free_row[free_count], low = 0, up = 0, last, k;
> +		double min, c, u1;

<snip most of the loop's body>

> +		/* augmentation */
> +		do {
> +			if (j < 0)
> +				BUG("negative j: %d", j);
> +			i = pred[j];
> +			column2row[j] = i;
> +			k = j;
> +			j = row2column[i];
> +			row2column[i] = k;

Coccinelle suggests to replace the last three lines above with:

  SWAP(j, row2column[i]);

I think it's right, using the SWAP macro makes the resulting code not
only shorter and clearer, but it also saves the reader from thinking
about whether it's important to set 'k = j' (I think it's not), or 'k'
is just used here in lieu of a dedicated 'tmp' variable (I think it
is).

> +		} while (i1 != i);
> +	}
> +
