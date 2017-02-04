Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB6661F9AF
	for <e@80x24.org>; Sat,  4 Feb 2017 13:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750876AbdBDNRp (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 08:17:45 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33681 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750808AbdBDNRo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 08:17:44 -0500
Received: by mail-wm0-f65.google.com with SMTP id v77so10988303wmv.0
        for <git@vger.kernel.org>; Sat, 04 Feb 2017 05:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aNFA7Hb2X+hTxVKWXMc/1PGQeszdfgwZtEQSk4gtHrk=;
        b=j7mY7pOmN9NSavhydIhiYxOmRR9MTgAqTFNd1BtRWsj6HIML/B28drYVKo49LQuooR
         yltmZ6zkoenefhoZsqIiXu2jl3KjFD6ybEbrw/GRhL1xKperVw2Jr7gzun6b1bSpkk9Q
         Cvyd/GzEjQtZ2FUAOhkLwU9EvFG+fPxwPoaTSiiImxgif1OksV0ofk+RxUCACIbkcY3E
         p7bYe94IyXeBqX9LsJdmrXJTE8IT7whYgsL63SobW0576CSHyItKhIarqSTRGbCHhrD6
         ZsUPFVmpAf+xCH+gTreWCvda1VJfZGyKReEkqHZzGPPnn0Q906fz2iTIvB4nS0wS8U1b
         9wqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aNFA7Hb2X+hTxVKWXMc/1PGQeszdfgwZtEQSk4gtHrk=;
        b=tsnvlTRUOavTHxfLL4DsFKfRhWZFPRhvIK1wIixNQN2UJuC3eu9aDT7G6B/mujTG7E
         JSS2C+PPfggRZCw8FrU9CexdIk1v4gO8gSN8k/T9n6Au3MyDJty6UA0IRAmydeCGV99q
         ootFpXLPrJ85vgqF+ADzC5GZJEwm+i35AAdjjF/Zy2AD16pODCls/x+MOe9fZ53IE4Qy
         +l/7clEYDYPwaIQgqEvd7o3dql9U5Ob21uBAbLadvq04BDlkT6SleeqkZC1Spby93ioZ
         Kv01UQv8BpsS9dGUELeJWp0io9s6YL1s64yxvlRZ2SiCRvIyj4nU/6jxlzYwSXTy2lgR
         +4ng==
X-Gm-Message-State: AMke39mFaYWiLkDEM1CCnPUcGWIjq0ps/XyWj8gQPg9OPclGMtWxdVhaWKhWo4lY3JVgfw==
X-Received: by 10.28.212.84 with SMTP id l81mr2065692wmg.119.1486214262696;
        Sat, 04 Feb 2017 05:17:42 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id b87sm2630002wmi.0.2017.02.04.05.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Feb 2017 05:17:41 -0800 (PST)
Date:   Sat, 4 Feb 2017 13:18:09 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=D8yvind_A_=2E?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 3/4] introduce new format for git stash create
Message-ID: <20170204131809.GF31189@hank>
References: <20170121200804.19009-1-t.gummerer@gmail.com>
 <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170129201604.30445-4-t.gummerer@gmail.com>
 <xmqqtw8guwfm.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtw8guwfm.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/30, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> >  create_stash () {
> > -	stash_msg="$1"
> > -	untracked="$2"
> > +	stash_msg=
> > +	untracked=
> > +	new_style=
> > ...
> > +	while test $# != 0
> > +	do
> > +		case "$1" in
> > +		-m|--message)
> > +			shift
> > +			stash_msg="$1"
> 
> 	${1?"-m needs an argument"}
> 
> to error check "git stash create -m<Enter>"?
> 
> > +	if test -z "$new_style"
> > +	then
> > +		stash_msg="$*"
> > +	fi
> 
> This breaks external users who do "git stash create" in the old
> fashioned way, I think, but can be easily fixed with something like:
> 
> 		stash_msg=$1 untracked=$2
> 
> If the existing tests did not catch this, I guess there is a
> coverage gap we may want to fill.  Perhaps add a new test to 3903
> that runs "git stash create message untracked" and makes sure it
> still works?

No I don't think this breaks.  It was never possible to add an
untracked argument to git stash create.  The difference is in a part
of this patch that is snipped out in your reply:

@@ -697,7 +739,7 @@ clear)
        ;;
 create)
        shift
-       create_stash "$*" && echo "$w_commit"
+       create_stash "$@" && echo "$w_commit"
        ;;
 store)
        shift

If I understand this piece correctly (I'm not very proficient in
shell, but my testing seems to agree with me), previously we used $*,
which transformed all arguments to git stash create into one argument
in create_stash.  This needed to change to $@, as otherwise we can't
pull the arguments apart for the new calling style.  The two argument
version of create_stash was only used internally in the save_stash
function.

> > diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> > index 0171b824c9..34e9610bb6 100755
> > --- a/t/t3903-stash.sh
> > +++ b/t/t3903-stash.sh
> > @@ -784,4 +784,22 @@ test_expect_success 'push -m shows right message' '
> >  	test_cmp expect actual
> >  '
> >  
> > +test_expect_success 'deprecated version of stash create stores correct message' '
> > +	>foo &&
> > +	git add foo &&
> > +	STASH_ID=$(git stash create "create test message") &&
> > +	echo "On master: create test message" >expect &&
> > +	git show --pretty=%s ${STASH_ID} | head -n1 >actual &&
> > +	test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'new style stash create stores correct message' '
> > +	>foo &&
> > +	git add foo &&
> > +	STASH_ID=$(git stash create -m "create test message new style") &&
> > +	echo "On master: create test message new style" >expect &&
> > +	git show --pretty=%s ${STASH_ID} | head -n1 >actual &&
> > +	test_cmp expect actual
> > +'
> > +
> >  test_done

-- 
Thomas
