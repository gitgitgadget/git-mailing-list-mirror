Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C39F21FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 19:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbdFMTbi (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 15:31:38 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35399 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753549AbdFMTbh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 15:31:37 -0400
Received: by mail-pg0-f67.google.com with SMTP id f127so20438707pgc.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 12:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HJeBlsTOCGpb4ci49IcOc8/zbCvA+e25HWlP++6hV6c=;
        b=sJi2bUETsgrZKivSypSqG5/z5fMacpYYsU1Ry+bc11Di51uJ98UxEwNBJSyy2Txoxf
         BdFv1DL9EH4AnDAE2TuyK1d4sywus9CbAF2Sb6yVAHQ40Cq+IzJnM3CidzHgeDTZJbEK
         ufZU+vH+sR6/qJW0alTW+8CqfintaeOQV30XO+hWmlU4JLhY1vkWODJyI0SNPdvpgzs5
         ALNpCfcPwlQWfcwuzjaxHztxmiPpBY+UDkEp5PO8xadY5M2zO2L6+O9zs+1AEwHQYZg9
         /Zf6Dix0lY7TB/9w1h9JUGqL8a9IFAI3IjQId2eK4fzYwabnNrmU4AoBBDACDGqZFKnZ
         8Ccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HJeBlsTOCGpb4ci49IcOc8/zbCvA+e25HWlP++6hV6c=;
        b=AQG8F3UQVZk2lPMD61UoUs+5CfsCF0qNJweupkrnmQOnCGeEv4slsXFZQVh5Ecyoc0
         TfwgF+KaOXdrWm2ZXraiPV/eW8p6lIm1YBF9bDMfMAXtkl1gAiA4vHVnpux2PK520s/X
         9qW9UjxGDE/cA7bFXeQ+Loxpk3dKYiTpHRSsZu6wDAalYbLd8CXdNfmb3lZ1t1c1CQkw
         IAT0f9xOIaD4bHRabN74Y+AN/ejEYhOBBOI3ZPvx89Vgam7yIvmgJjHPHtDMA+qKbRN5
         oCUQ2bkAT4Tdvs8KkB3tafNRqfnmmC9oQmI3I4+Mmf+Iz8e2cxk59m7bJq3cKdJB78hI
         rkgQ==
X-Gm-Message-State: AKS2vOwAw+MYju/IqzSGdKZMMTbTbbsHGazFiZO0SHKds47n5GnEw3n/
        n/9AjTja+JLNAHkIHik=
X-Received: by 10.98.218.65 with SMTP id w1mr1049142pfl.234.1497382296915;
        Tue, 13 Jun 2017 12:31:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id 189sm30253165pgi.66.2017.06.13.12.31.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 12:31:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 1/5] stash: add test for stash create with no files
References: <20170608005535.13080-1-joel@teichroeb.net>
        <20170608005535.13080-2-joel@teichroeb.net>
Date:   Tue, 13 Jun 2017 12:31:35 -0700
In-Reply-To: <20170608005535.13080-2-joel@teichroeb.net> (Joel Teichroeb's
        message of "Wed, 7 Jun 2017 17:55:31 -0700")
Message-ID: <xmqqk24f65wo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Teichroeb <joel@teichroeb.net> writes:

> Ensure the command gives the correct return code

OK.  When you know what the correct return code is, we'd prefer to
see it spelled out, i.e.

    Ensure that the command succeeds.

Or did you mean that the command outputs nothing?

The test itself looks obviously correct ;-)

> Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
> ---
>  t/t3903-stash.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 3b4bed5c9a..cc923e6335 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -444,6 +444,14 @@ test_expect_failure 'stash file to directory' '
>  	test foo = "$(cat file/file)"
>  '
>  
> +test_expect_success 'stash create - no changes' '
> +	git stash clear &&
> +	test_when_finished "git reset --hard HEAD" &&
> +	git reset --hard &&
> +	git stash create >actual &&
> +	test_must_be_empty actual
> +'
> +
>  test_expect_success 'stash branch - no stashes on stack, stash-like argument' '
>  	git stash clear &&
>  	test_when_finished "git reset --hard HEAD" &&
