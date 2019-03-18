Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84D8520248
	for <e@80x24.org>; Mon, 18 Mar 2019 03:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfCRDC1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 23:02:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44686 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfCRDC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 23:02:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id h34so10334267pgh.11
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 20:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xxM/XJ5rggMJxHfyHIrilmuuthdRvIQ0nmR0VWQVnOs=;
        b=he5MWaxai+e4MI3SKH55X61ePkrSU+a/Waqe5mXul3E9mDOys6w9JVS3gDJeYrGh/j
         84he34RHdkUeLx7KyIjznUFSt5pqdYyhPQpisiDBcITzfj88jlnO2u8E8KHlp2G/yex8
         8CdCtuZt2CAGfvwr5cixRXjIuZc45Vvoj3erGIp7p6gICgsfsb44xDLVYTOVpVSw124i
         KUHp7wo1qT8tjqdFtGbRP5/xMCOodVDlZrLbdYYiodO7KSg0URWsS0ILYZH5ygZ6HcfQ
         gw0g5gCnEZ4otr8na7sMSkQ0efFLnyKhmOQS1zcgwMAtENvAyJ+htXqRlu7AnVbC/Abm
         kz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xxM/XJ5rggMJxHfyHIrilmuuthdRvIQ0nmR0VWQVnOs=;
        b=ZfyHCzZjb2uFskiTbUkW0RR5FALRYvACZskZVI0hjDxPSMTGwESE18Z15HUibX6hSd
         2OoSoW98d6zaYjUj1Jt9LLUhE74Q8ACvPLJ+Mz1PAkLl62ibyxsPJafw7/JtSX0LV3HQ
         GSTLe1AZUUjWQWKlYnAZEkTJs4km9vA9ZAKPKLNrSq6bgLf6HSOvRbAE8u13ksA5DL8q
         9DHAGjsilQveIAPpi6lD0GV5RhUMkX1Zz3rxVf6Sy1K3oM793Der1auqWyFI7KgJGRCu
         7vFbBeh5tfkzN1eyTwHPAMC81CvbJnUkXW4RUqbf6emYSlrXZmBx2VjFQiu/NUXPQmVA
         rPww==
X-Gm-Message-State: APjAAAX8ofVfSLIqETqibJcdw9tY3DnByCZWQtnMWH7SSROYVlviRS4z
        eENqyRCPzrUtP+1B6e2Jc/8=
X-Google-Smtp-Source: APXvYqyeEPROYcGMc26vGh4bSMmtn7bdbBt7qEe5dPKd7XmjP3pW2HDu7FB1Xg8Q3GVXcuQzNRmAFg==
X-Received: by 2002:a17:902:a612:: with SMTP id u18mr17278470plq.145.1552878146239;
        Sun, 17 Mar 2019 20:02:26 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id u18sm16779649pfa.176.2019.03.17.20.02.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 20:02:24 -0700 (PDT)
Date:   Sun, 17 Mar 2019 20:02:20 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v8 00/11] Fix scissors bug during conflict
Message-ID: <20190318030220.GA14098@archbookpro.localdomain>
References: <cover.1552275703.git.liu.denton@gmail.com>
 <cover.1552817044.git.liu.denton@gmail.com>
 <20190317130539.GA23160@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190317130539.GA23160@szeder.dev>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Szeder,

On Sun, Mar 17, 2019 at 02:05:39PM +0100, SZEDER Gábor wrote:
> On Sun, Mar 17, 2019 at 03:15:50AM -0700, Denton Liu wrote:
> > Sorry for taking so long to do a reroll, I've been pretty busy this week
> > and I've only been able to find the time now.
> 
> No problem, and thank you for sticking with it!
> 
> 
> > diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
> > index ca4a740da0..f035e4a507 100755
> > --- a/t/t7502-commit-porcelain.sh
> > +++ b/t/t7502-commit-porcelain.sh
> > @@ -16,7 +16,9 @@ commit_msg_is () {
> >  # Arguments: [<prefix] [<commit message>] [<commit options>]
> >  check_summary_oneline() {
> >  	test_tick &&
> > -	git commit ${3+"$3"} -m "$2" | head -1 > act &&
> > +	git commit ${3+"$3"} -m "$2" >act &&
> > +	head -1 <act >tmp &&
> > +	mv tmp act &&
> 
> Here you could swap the order of when you write to 'act' and 'tmp',
> and thus make the 'mv' unnecessary, like this:
> 
>   git commit [...] >tmp &&
>   head -1 act >tmp &&
>   [...rest of the test...]
> 
> Note also that 'head' (or 'sed' in later tests) can open its input
> file on its own, there's no need to redirect its standard input.
> 
> This is a recurring pattern in patches 1, 4, 8, and 9.
> 

The reason I did it this way was because earlier, Junio said:
> > -     git cat-file commit HEAD | sed -e '1,/^$/d' >actual &&
> > +     git cat-file commit HEAD >tmp &&
> > +     sed -e '1,/^$/d' <tmp >actual &&
> 
> The intermediary file may want a name better than 'tmp', if it is to
> be left behind, but this will do for now.

So I opted to write the tests in a way where a tmp file won't be
produced. This pattern was shamelessly stolen from 
'set up mod-256 conflict scenario' in t7600 where it does the following:

	# 256 near-identical stanzas...
	for i in $(test_seq 1 256); do
		for j in 1 2 3 4 5; do
			echo $i-$j
		done
	done >file &&
	git add file &&
	git commit -m base &&

	# one side changes the first line of each to "master"
	sed s/-1/-master/ <file >tmp &&
	mv tmp file &&
	git commit -am master &&

Good point about the heads and seds, though. I completely forgot that
they accept a file argument.

> > @@ -142,8 +144,8 @@ test_expect_success 'sign off' '
> >  	>positive &&
> >  	git add positive &&
> >  	git commit -s -m "thank you" &&
> > -	actual=$(git cat-file commit HEAD | sed -ne "s/Signed-off-by: //p") &&
> > -	expected=$(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/") &&
> > +	actual=$(git cat-file commit HEAD >tmp && sed -ne "s/Signed-off-by: //p" <tmp && rm tmp) &&
> > +	expected=$(git var GIT_COMMITTER_IDENT >tmp && sed -e "s/>.*/>/" <tmp && rm tmp) &&
> >  	test "z$actual" = "z$expected"
> 
> May I ask you to go one step further in restructuring this and the
> following tests? :)  Instead of using 'test' to compare the contents
> of the $actual and $expected variables, use 'test_cmp' to compare the
> 'actual' and 'expected' files, something like:
> 
>   git cat-file commit HEAD >tmp &&
>   sed -ne "s/Signed-off-by: //p" tmp >actual &&
>   git var GIT_COMMITTER_IDENT >tmp &&
>   sed -e "s/>.*/>/" >expected &&
>   test_cmp expected actual

Will do.

Thanks,

Denton
