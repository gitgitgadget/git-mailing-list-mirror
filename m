Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D9FB1F463
	for <e@80x24.org>; Tue, 17 Sep 2019 08:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfIQIxy (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 04:53:54 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:37674 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfIQIxa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 04:53:30 -0400
Received: by mail-wm1-f52.google.com with SMTP id r195so2111484wme.2
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 01:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IRNoG29OoMG9Ogrnctwhln6rSsaQRRVzVRi7gu0m9WE=;
        b=eVVwW5DOGL95YlhzkB2pQOo0MUXND1nQAmIEf/DBR8ND8WCY5EeaW+ADCEBKiWu9JA
         ffEiGF/HGxiZ7SYM0/01VcgnmBmKwhK9j0Dfr7KkKDL4iaZZLuZwHdsxF6KM/gNq9NDJ
         daoLzum2Zj600WeJMtcFyAaWxwCa1Dy9STthmQvZ2Ce04Zt+2noIl7W/RYcO5VvNfvzC
         KmT2+AR/iNxOo50yyBKXweZ+54KLtC9YMXSl22r2xY4Wg2HoqaKvquhnXksgeYCNYbcK
         3DguewKeZczqDjdLBwkQn86lPR+gDUi5VdiPbORVDSiDGVBztT2Hck8RRB8camIg973d
         LZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IRNoG29OoMG9Ogrnctwhln6rSsaQRRVzVRi7gu0m9WE=;
        b=APuHhx4pIfhAu5z6qCKxjyfYP1cigKBoOhF/5gpTS/1jVYYsJBSl6RNOqbdpBs6p5C
         GXD0rdCCg9ADqvQlrWnk/h1chkJkoNaC5nSjhS43BflHtboUbXum/hYy6K408/Af4cYt
         IzGnLLQeCTmcETGpn2oTZW5aM5tv79cDxMBNTR+Tv8VnsmIv6vCKuplDdIQlKy3iWYwO
         nKLam+ioxlSIcYKrafhKzhY45I9Y9SAeQLWPK1O/g4BmFPSf8//Bpdy0aTXXaMT9rCYO
         5yPu1oTGaotCj7j7WYHgkZLsXPDONNq+WpmdMM3xkxV4lRpiUXbeWYpjkwAfmKDcdQJd
         9tzw==
X-Gm-Message-State: APjAAAUbhFL7uDMRIoBUAqX3qXEZbl+h20OBPBd8ikAUB5g03GjmqTur
        5foC1rLkI18H7puN2n+ExcE=
X-Google-Smtp-Source: APXvYqwwdks74DQrVa9SaU2mCnC7eO8/p2TLi4BeuEBMvOlPMvatWFNyViWJRHl8yPBQlfazvdjh2Q==
X-Received: by 2002:a1c:9889:: with SMTP id a131mr2594953wme.38.1568710407945;
        Tue, 17 Sep 2019 01:53:27 -0700 (PDT)
Received: from szeder.dev (x4db91871.dyn.telefonica.de. [77.185.24.113])
        by smtp.gmail.com with ESMTPSA id q66sm2435312wme.39.2019.09.17.01.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 01:53:27 -0700 (PDT)
Date:   Tue, 17 Sep 2019 10:53:25 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [BUG] t7030 is flaky
Message-ID: <20190917085325.GG6190@szeder.dev>
References: <20190916235149.GA96478@dentonliu-ltm.internal.salesforce.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190916235149.GA96478@dentonliu-ltm.internal.salesforce.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Cc-ing brian, because I can vaguely remember (or misremember?) that
he cares about GnuPG.]

On Mon, Sep 16, 2019 at 04:51:49PM -0700, Denton Liu wrote:
> I just wanted to report that t7030 is flaky. I first noticed this on
> Szeder's Travis job[1]. I was also able to reproduce this on my Macbook
> with gpg (GnuPG) 2.2.17 and git version 2.23.0.248.g3a9dd8fb08 (latest
> master) by running `./t7030-verify-tag.sh --stress`.

It's not only t7030, but verifying multiple signatures at once in
macOS and GnuPG 2.2, i.e. these tests fail occasionally:

  t7030-verify-tag.sh:
    8 - verify multiple tags [2]
    9 - verify multiple tags x509 [1]

  t7004-tag.sh:
    92 - verifying two signed tags in one command should succeed [3]
         (nowadays it's the 94th test)

Note that these are all about tags; as far as I can tell we have no
tests that verify multiple signed commits at once.

I tried to reproduce it on Linux, with GnuPG v1.4 and v2.2, no luck so
far.

> I'll try to investigate later but for now but at the bottom of this
> email is the trace I obtained.
> 
> [1]: https://travis-ci.org/szeder/git-cooking-topics-for-travis-ci/jobs/518540359

[2] https://travis-ci.org/szeder/git-cooking-topics-for-travis-ci/jobs/514969530#L3183
[3] https://travis-ci.org/szeder/git-cooking-topics-for-travis-ci/jobs/487665767#L3891

> expecting success of 7030.9 'verify multiple tags x509': 
> 	tags="seventh-signed nineth-signed-x509" &&
> 	for i in $tags
> 	do
> 		git verify-tag -v --raw $i || return 1
> 	done >expect.stdout 2>expect.stderr.1 &&

Sidenote: oh, look, a shell loop with its standard error redirected to
a file.  Normally we shouldn't do that, because with '-x' tracing it
records the trace output of the commands executed inside the loop as
well.  Luckily, in this case it's not a big issue, because:

> 	grep "^.GNUPG:." <expect.stderr.1 >expect.stderr &&

this 'grep' throws away all that trace, so it doesn't interfere with
the test's correctness.

> 	git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr.1 &&
> 	grep "^.GNUPG:." <actual.stderr.1 >actual.stderr &&
> 	test_cmp expect.stdout actual.stdout &&
> 	test_cmp expect.stderr actual.stderr
> 
> ++ tags='seventh-signed nineth-signed-x509'
> ++ grep '^.GNUPG:.'
> ++ git verify-tag -v --raw seventh-signed nineth-signed-x509
> ++ grep '^.GNUPG:.'
> ++ test_cmp expect.stdout actual.stdout
> ++ diff -u expect.stdout actual.stdout
> ++ test_cmp expect.stderr actual.stderr
> ++ diff -u expect.stderr actual.stderr
> --- expect.stderr	2019-09-16 23:48:06.000000000 +0000
> +++ actual.stderr	2019-09-16 23:48:06.000000000 +0000
> @@ -8,7 +8,6 @@
>  [GNUPG:] TRUST_ULTIMATE 0 pgp
>  [GNUPG:] NEWSIG
>  [GNUPG:] VERIFICATION_COMPLIANCE_MODE 23
> -[GNUPG:] PROGRESS starting_agent ? 0 0
>  [GNUPG:] GOODSIG F8BF62E0693D0694816377099909C779FA23FD65 /CN=C O Mitter/O=Example/SN=C O/GN=Mitter
>  [GNUPG:] VALIDSIG F8BF62E0693D0694816377099909C779FA23FD65 2019-09-16 20190916T234804 30000101T000000 0 0 1 8 00
>  [GNUPG:] TRUST_FULLY 0 shell

This is interesting, I only remember these tests fail because the 'git
verify-tag' command failed.  I thought that the error message shown by
'git verify-tag' might give a hint about what went wrong, but
'actual.stderr.1' (i.e. its original stderr) contains this:

  [GNUPG:] NEWSIG committer@example.com
  [GNUPG:] KEY_CONSIDERED 73D758744BE721698EC54E8713B6F51ECDDE430D 0
  [GNUPG:] SIG_ID 2Eg0F1yiJ07HcOjvjO96x2wJvvs 2019-09-17 1568707912
  [GNUPG:] KEY_CONSIDERED 73D758744BE721698EC54E8713B6F51ECDDE430D 0
  [GNUPG:] GOODSIG 13B6F51ECDDE430D C O Mitter <committer@example.com>
  [GNUPG:] VALIDSIG 73D758744BE721698EC54E8713B6F51ECDDE430D 2019-09-17 1568707912 0 4 0 17 2 00 73D758744BE721698EC54E8713B6F51ECDDE430D
  [GNUPG:] KEY_CONSIDERED 73D758744BE721698EC54E8713B6F51ECDDE430D 0
  [GNUPG:] TRUST_ULTIMATE 0 pgp
  [GNUPG:] NEWSIG
  [GNUPG:] VERIFICATION_COMPLIANCE_MODE 23
  [GNUPG:] PROGRESS starting_agent ? 0 0
  [GNUPG:] GOODSIG F8BF62E0693D0694816377099909C779FA23FD65 /CN=C O Mitter/O=Example/SN=C O/GN=Mitter
  [GNUPG:] VALIDSIG F8BF62E0693D0694816377099909C779FA23FD65 2019-09-17 20190917T081152 30000101T000000 0 0 1 8 00
  [GNUPG:] TRUST_FULLY 0 shell

IOW no error message from 'git verify-tag' itself whatsoever, only
output from GnuPG, which, to my untrained eyes, looks OK.

> error: last command exited with $?=1
> not ok 9 - verify multiple tags x509
> #	
> #		tags="seventh-signed nineth-signed-x509" &&
> #		for i in $tags
> #		do
> #			git verify-tag -v --raw $i || return 1
> #		done >expect.stdout 2>expect.stderr.1 &&
> #		grep "^.GNUPG:." <expect.stderr.1 >expect.stderr &&
> #		git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr.1 &&
> #		grep "^.GNUPG:." <actual.stderr.1 >actual.stderr &&
> #		test_cmp expect.stdout actual.stdout &&
> #		test_cmp expect.stderr actual.stderr
> #	
