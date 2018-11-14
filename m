Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 099291F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 09:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732501AbeKNTEQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 14:04:16 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51242 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeKNTEP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 14:04:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id w7-v6so14588630wmc.1
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 01:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ja+wWq4n6di7NjZ1xWSZ+Edg/ZTt2Kt9WtHyKPXxRk0=;
        b=Wle3QgHCLWKgjUnVJYSB3+2440dt53S+QvvgEyrqTI0Ix//iTT4YqQZoMEfs+93Nwl
         p/YNGoEhwYtWTx0jQoBV24yyDDP3lZUtHeYzu7rm59am2Kf/erql/Hvc1kL3RukR2BpJ
         iRSLtUvbP/xGIGK8NvMHpRvkwdBqbe6HiDyjYSZ+EuldlU/7AvFiy5PwEnAt7c10pD3j
         u1zkewOjNPUZaFoaO5bsT6L9Dd0S45/oaSbb6g+Ace4PgncIfIvAKh6abNtal1fBwtZ0
         KOIng8UebP7BLs6LOdnho9R0Lb3OT9kxNBSzJ56UOCfsLezXvif6Vfo2LB8MxfhNY1Zd
         mgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ja+wWq4n6di7NjZ1xWSZ+Edg/ZTt2Kt9WtHyKPXxRk0=;
        b=ktyTUT+Ro8nFmn8zqiRvsBbXfPpU2xnCy+eiDbE4TTV4ULS5FZlXEsIpMo5rI1RlL6
         jajY2qNAa3S4YaPuHcq+p3OHwYWrRIasOzXVU7t4S+cQG9Ke6j0nXue8YKaEe2YXEtOy
         Zrk7bajBrZ4/chTOO9EQk/8uoLMIoEqIQyxw5vwnbzrgfTs4ee0hujC6Mm8DXuC/Tb+0
         H8RshW1zqkT8TCq+UaCBY6pNHrYF9xhgmFiJke+WDhwvTGcvZ5YSnVv4+XwxBc8fquqy
         /H9OY5uLEsMB+1f44LBEcuVM4LhbQESEsd/+kMVAQDTUVEf3bcSABkc74PTzp7esm9nZ
         rkAg==
X-Gm-Message-State: AGRZ1gIIXqN3X6quUqLjRlYa7QnaBzhvRYQJP62JP/Hld0qObxFXbs0s
        NokyXIQ0Gzw8gdzzTH2kO7uCMjo/j8c=
X-Google-Smtp-Source: AJdET5entFsgW6ll1UMQUbJgK5btG3OX/H0LLim1mdOwh8/Bs3phL77s3DPyaIRFFgYaqRaa5W2zeA==
X-Received: by 2002:a1c:adc7:: with SMTP id w190-v6mr1024627wme.96.1542186113584;
        Wed, 14 Nov 2018 01:01:53 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e10-v6sm28782471wrp.56.2018.11.14.01.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 01:01:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitgitgadget@gmail.com, Pratik Karki <predatoramigo@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] rebase.useBuiltin doc & test mode
Date:   Wed, 14 Nov 2018 09:01:42 +0000
Message-Id: <20181114090144.31412-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.g4ecb1133ce
In-Reply-To: <CAGZ79kYX4vNMYgzitY1D8Bu7o=2oY6Aiq0d7KQdCTaC5eu=RYg@mail.gmail.com>
References: <CAGZ79kYX4vNMYgzitY1D8Bu7o=2oY6Aiq0d7KQdCTaC5eu=RYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 14 2018, Stefan Beller wrote:

>> But maybe I'm being overly paranoid. What do those more familiar with
>> this think?
>
> I am not too worried,
> * as rebase is a main porcelain, that is even hard to use in a script.
>   so any failures are not deep down in some automation,
>   but when found exposed quickly (and hopefully reported).
> * 5541bd5b8f was merged to next a month ago; internally we
>    distribute the next branch to Googlers (on a weekly basis)
>    and we have not had any bug reports regarding rebase.
>    (Maybe our environment is too strict for the wide range
>     of bugs reported)

I do the same at Booking.com (although at a more ad-hoc schedule) and
got the report whose fix is now sitting in "pu" noted upthread.

I fear that these sorts of corporate environments, both Google's and
Booking's, end up testing a relatively narrow featureset. Most people
have similar enough workflows, e.g. just using "git pull --rebase",
I'd be surprised if we have more than 2-3 internal users who ever use
the --onto option for example.

> * Johannes reported that the rebase is used in GfW
>    https://public-inbox.org/git/nycvar.QRO.7.76.6.1808241320540.73@tvgsbejvaqbjf.bet/
>    https://github.com/git-for-windows/git/pull/1800
>    and from my cursory reading it is part of
>    2.19.windows, which has a large user base.
>
>> (and would re-enable rebase.useBuiltin=true in
>> master right after 2.20 is out the door).
>
> That would be fine with me as well, but I'd rather
> document rebase.useBuiltin instead of flip-flopping
> the switch around the release.
>
> Have there been any fixes that are only in
> the C version (has the shell version already bitrotted)?

That's a good question, one which I don't think we knew the answer to
before the following patches. As it turns out no, we still run the
tests without failures with GIT_TEST_REBASE_USE_BUILTIN=false.

Ævar Arnfjörð Bjarmason (2):
  rebase doc: document rebase.useBuiltin
  tests: add a special setup where rebase.useBuiltin is off

 Documentation/config/rebase.txt | 14 ++++++++++++++
 builtin/rebase.c                |  5 ++++-
 t/README                        |  3 +++
 3 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.19.1.1182.g4ecb1133ce

