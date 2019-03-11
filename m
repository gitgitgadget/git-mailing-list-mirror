Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B047B20248
	for <e@80x24.org>; Mon, 11 Mar 2019 22:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbfCKW2N (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 18:28:13 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:52103 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfCKW2N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 18:28:13 -0400
Received: by mail-it1-f180.google.com with SMTP id e24so1295870itl.1
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 15:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XErCsY1Fq/b8pgMXjVYkICWvQeuKYWlt6SVhqn8o9aw=;
        b=vXktv0Paj6M44WXdjee+ZEhYc4TF8PoGD8hadxqv/0VZ/EIAgR3IqnWH+OuuyLBgkd
         gTki3nH/QkPg+CqqfNuVMeDX/ev7V62gB8jlwZFBoqqt/E71v6LVOGs9OKmXBdtkDBEs
         2zsW9ivLeJYFYfd44xv9aYtgceFPis398TzepZ6FPyWAES6ZpsYsJdF3AW7aS72W4jRD
         6RNz+T+2dvxFF94xPTuyXjcNnZxaSPovvjbrgxeEGIqqSvpklvuZLHulKrorSJRJ7rYs
         FRDEwCGuzIeCZGjUAmGI8sbTFMQ53aQuSS0sgUZ/hFY38JHgh1MVbQeUTBClMYBRO0QZ
         t4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XErCsY1Fq/b8pgMXjVYkICWvQeuKYWlt6SVhqn8o9aw=;
        b=riuJu143nq17OfMMZ0rE1r+E5sH2yP1pTWhT6LnZZFtKbuat6ZWjQPz8eCzSs6qvMA
         xw6pA0NWB2Hk1qXiWjO8XREX+3eLWB1PQGIzb1GTHlnlqS0E2QpN+mUu34Kw78DPjwf8
         oZAY/3BpAgmTkDP4tuORVVNzJATzIF/tRHoN/KTT3Aw6UeiO0CfgYd3VbmxMNwL8Iktp
         lbWRW9phZPU4X9CyN3vqFkqaCfCN5TQn1T40TowKpZFiiYwMnXgd45aC1gqx5973F1vd
         ZOA+zMLkpEMVFsMU9VgarUYTb4FHfZteXs06TmpNe8RFUt5SpWDeXRkcjXb0y4knepkt
         MCag==
X-Gm-Message-State: APjAAAX0bpR1nBRh/gqxrzFt+gV4QdYLtelY2NSJIsAYwlRF7Q1A70w2
        GQD7e2DYxmRT5Ydy2KCq+VX0WJ87
X-Google-Smtp-Source: APXvYqz39fEb4HnRuKyv1plzxDlV5o43iIbs0kLhipkxyxvKTCQT4CLFtjyC2yG0KJsSeqXx0HcMBQ==
X-Received: by 2002:a24:c6:: with SMTP id 189mr333996ita.84.1552343291935;
        Mon, 11 Mar 2019 15:28:11 -0700 (PDT)
Received: from flurp.local (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id v10sm589127itv.8.2019.03.11.15.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 15:28:11 -0700 (PDT)
Date:   Mon, 11 Mar 2019 18:28:05 -0400
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: Solaris and sed: Too many commands, last: s/\n//
Message-ID: <20190311222805.GA6215@flurp.local>
References: <CAH8yC8nnFYt0raL+twrG_v8XZn_FDJWyM=tH=QL13Z70_bHRiQ@mail.gmail.com>
 <CAPig+cTCOfDCv=L3EWUqgVZx1VCdqt5ZjmSQMwHLX=R4C4hgTA@mail.gmail.com>
 <CAH8yC8=jtBURyr-mFJSe_cd4zNJfJDt672jZ+izo=z75ZBheug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH8yC8=jtBURyr-mFJSe_cd4zNJfJDt672jZ+izo=z75ZBheug@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 05:43:55PM -0400, Jeffrey Walton wrote:
> On Mon, Mar 11, 2019 at 5:15 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Mon, Mar 11, 2019 at 4:32 PM Jeffrey Walton <noloader@gmail.com> wrote:
> > > I enabled self tests for Solaris. Solaris has some anemic utilities so
> > > I put /usr/gnu/bin first on-path.
> >
> > The first question is if you are really running GNU 'sed'? My guess is
> > "no, it's still picking up Solaris's 'sed'".
> 
> I believe so. After modifying PATH, command -v returns:
> 
>     Solaris tools:
>          sed: /usr/gnu/bin/sed
>          awk: /usr/gnu/bin/awk
>         grep: /usr/gnu/bin/grep
> 
> (This was added to my scripts to confirm).

Can you doubly confirm by having t/Makefile tell us itself? I ask because that error message in your original email is exactly the error spit out by Solaris 'sed'. Perhaps apply this patch:

diff --git a/t/Makefile b/t/Makefile
index c83fd18861..d22eff4463 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -70,6 +70,7 @@ clean-chainlint:
 
 check-chainlint:
 	@mkdir -p '$(CHAINLINTTMP_SQ)' && \
+	printf 'SED VERSION: ' && sed --version && \
 	err=0 && \
 	for i in $(CHAINLINTTESTS); do \
 		$(CHAINLINT) <chainlint/$$i.test | \

If it reports "SED VERSION: sed (GNU sed) x.y", then we can feel reasonably assured that it's using GNU 'sed', however, if it errors out or prints something else, then it's not picking up your PATH for some reason.

> Maybe Git would benefit from SED, AWK and GREP variables like PERL.

Very possibly.
