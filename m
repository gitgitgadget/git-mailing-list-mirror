Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A41C81F404
	for <e@80x24.org>; Wed, 20 Dec 2017 21:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755494AbdLTVk5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 16:40:57 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:41582 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754502AbdLTVk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 16:40:56 -0500
Received: by mail-wr0-f178.google.com with SMTP id p69so14668057wrb.8
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 13:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=nfcxuOOG61X1msw3dYfu7B7+NTYQZkSh//T6ZkcoohM=;
        b=lPjGep63Khiv5+EyPS/+XQtVCJAP7dyxhIzddoUtEspdw32lmuMMvbpnryC9Q13A3v
         16W3pV30vyHmwAy543V5tZzvtLjmH2zuVf5P/55tibmy6+CbukLIgt7nGDXViUOWaMkl
         Loplffx1bpzLFH+1tZIR3soiB5sDLJQrmYKbDtmcr0ni3GNaxzFI5JnIA3gL+3EXiHp1
         t0kSlbZINK1AHdCEx7wdOFl+GLYvorc9y0P6nT6eWbf5wR9mJLSmd1n3JZCtLeQ/8QrZ
         fb24etbXAH2jytZYG1tcuceeQqU289R+VL1QtAM+41lh9vVh0G2iV3I8zNoocd7pqN6z
         uRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=nfcxuOOG61X1msw3dYfu7B7+NTYQZkSh//T6ZkcoohM=;
        b=gQTtuh2OU3Nv2Lf8Qk13ZinD5RKeJADZo27xisCnq8nGW4LBuNwShrOVlho2FLzKSN
         eY0hjM9BO7a+B+ifP6X96gCHQ90EWWu37xgO5z+ZRDBbUzi8Jlk51JcBpPmhu8izhvqx
         QFgLP1CsZc8VXJEhdjBS6ZBnqM24qo3IkZRLnJPgKaCVgXKTEQdfZXWwXkJvB99JZwvK
         xsWXa7qe47dahe9yJautAxjOSnpIfGQGYTzcpbappl/gugVh+2rxCWMa/Vkm4oZQWvKW
         c8uVpw45Jh4Y1kE04ei9HULfbSsPO13hC0ZoUV04RY+AUwBS2jWk05faTLAzJ5y0j27K
         IaXw==
X-Gm-Message-State: AKGB3mLwplfujNEkjkbSQ3pIvQbzBzN9FHpi10aHdteAKC+5zTlcMTyK
        6fahVkNo+U7Bq9XnJMZHq94=
X-Google-Smtp-Source: ACJfBovKFFnMtqUTs0IkCuzcuLpBSigslfVDsVWnkXBMeAvB9OX4gKYlOQB6nitZ9vEZsGuK0iJe3A==
X-Received: by 10.223.177.150 with SMTP id q22mr9509921wra.87.1513806055636;
        Wed, 20 Dec 2017 13:40:55 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id u33sm20809332wrf.42.2017.12.20.13.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Dec 2017 13:40:54 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eRm6f-00084b-I2; Wed, 20 Dec 2017 22:40:53 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Pat Notz <patnotz@gmail.com>
Subject: Re: [PATCH 2/2] commit: add support for --fixup <commit> -m"<extra message>"
References: <20171220193845.11754-1-avarab@gmail.com> <20171220193845.11754-2-avarab@gmail.com> <CAPig+cSeRZR7J9WSozTETVu=Y9N2wMRpoCgUkLXyzAaBOmTNZw@mail.gmail.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <CAPig+cSeRZR7J9WSozTETVu=Y9N2wMRpoCgUkLXyzAaBOmTNZw@mail.gmail.com>
Date:   Wed, 20 Dec 2017 22:40:53 +0100
Message-ID: <87bmit5b8a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 20 2017, Eric Sunshine jotted:

> On Wed, Dec 20, 2017 at 2:38 PM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> Add support for supplying the -m option with --fixup. Doing so has
>> errored out ever since --fixup was introduced. Before this, the only
>> way to amend the fixup message while committing was to use --edit and
>> amend it in the editor.
>
> I can't tell, based upon this description, if '-m<msg> --edit' is a
> valid combination and, if so, does it correctly open the editor after
> appending <msg>?

Yes, that's works as expected for all the options, and this doesn't
break that.

>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>> diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
>> @@ -272,6 +272,14 @@ test_expect_success 'commit --fixup provides correct one-line commit message' '
>>         commit_msg_is "fixup! target message subject line"
>>  '
>>
>> +test_expect_success 'commit --fixup -m"something" -m"extra"' '
>> +       commit_for_rebase_autosquash_setup &&
>> +       git commit --fixup HEAD~1 -m"something" -m"extra" &&
>> +       commit_msg_is "fixup! target message subject linesomething
>> +
>> +extra"
>> +'
>
> Hmm, so the first -m appended to the "fixup!" line, but the second -m
> appended after a blank line? That doesn't seem very intuitive.
>
> Also, doesn't the text following "fixup!" need to exactly match the
> summary line of the commit message in order for "git rebase -i
> --autosquash" to work? Am I overlooking something obvious?

It does the right thing and it's actually
"$fixup_line\n\n$first_m\n\n$second_m" etc. It's just that this
commit_msg_is function is testing against the "%s%b" format, so the
first line of the body comes right after the subject.

Thanks for the review of both patches. I'll clarify the points raised in
commit message for v2 pending further feedback.
