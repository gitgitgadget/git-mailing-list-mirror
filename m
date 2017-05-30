Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,PI_IMPORTANCE_HIGH,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83E3820D0A
	for <e@80x24.org>; Tue, 30 May 2017 00:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750908AbdE3ADW (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 20:03:22 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34698 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbdE3ADV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 20:03:21 -0400
Received: by mail-pf0-f196.google.com with SMTP id w69so13966713pfk.1
        for <git@vger.kernel.org>; Mon, 29 May 2017 17:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:importance:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=OTh6bU6ZY6ywVlT3Gnx3X2LrokgeJn8jszNBcqH00cY=;
        b=QEzzYsxvaH4qjQnU6qJvtJDDBMddLPdt8lb6cQaM/zfmmichtAtLlgF5rXC4l4xOuL
         2OvWP5A+m6V1PTPrcmMre9belK9Yue3cObkFTuSlXmw63P0f2g9vYsU8dDcB/vie6nB0
         XpvNiO0jE7NYBTBeM2jk4AZa/l22Is2cpW9tpjUKttgnCdnc30C0rNYshMzCa+8QpmiX
         y6arca54ZHjIk1LJMe/0F9a8AVkmbDr7jUHtXYrTMEaJCp0uPen9UgJPI3BAX+AYA0SP
         WnJNteIeEZbYgzID4MgtHAtCMjZdLOAHx4NOtZVD7vXm5DZ3SXaGccfSf8MDRzI8lWIJ
         Jigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:importance
         :date:in-reply-to:message-id:user-agent:mime-version;
        bh=OTh6bU6ZY6ywVlT3Gnx3X2LrokgeJn8jszNBcqH00cY=;
        b=Vpu7vGseomO7s2SI5OFOW3kL6SrcfGTIBu/WFIsYsEHp9LQcyca59eHvOEwbivJEAL
         EwDvz7+UR1f+WMFtWYkXlk7TRxB4LdXV00AG4dHAfh+s/Lin42Dn2+uzhOCB2WuStk63
         YMmltgGuZ8nvxr0a/Ni9LVmDGUZB6of2XO4lnmo4xgbh8ARyW1sh8h5kwCAD6la2h3+B
         N1aPJ2JWljY4HEDsD0aCjvJ4rNffDoWTTmDk2PzIuvFdoTT2lRCu5Pf27wEQ0kyDSlgI
         u4wuOzRUzuEjgHXwgnHGxBJVXL+p8tuz4hXQWgfcAva4pveCanIQovVrEzlb/Tf3C9Ci
         cBWg==
X-Gm-Message-State: AODbwcA0tOfzKwSGd6YmNIqNjMfAdbkW577c81FCqEi+sMxFYUY0GG8z
        aLbki/ATjNpStQ==
X-Received: by 10.99.23.100 with SMTP id 36mr21822953pgx.118.1496102600396;
        Mon, 29 May 2017 17:03:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f830:fc5f:a16b:f475])
        by smtp.gmail.com with ESMTPSA id e76sm16692912pfh.121.2017.05.29.17.03.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 May 2017 17:03:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] mingw: verify that paths are not mistaken for remote nicknames
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
        <20170526033510.1793-1-gitster@pobox.com>
        <20170526033510.1793-14-gitster@pobox.com>
        <17b3d445-0cc7-2000-dc67-11fb53c7040b@kdbg.org>
        <CACBZZX5BgVbUFEwQjHqJVfHFUitTJRaCx-Lg+j7q54uErEpqcg@mail.gmail.com>
        <34029b29-9f65-78c0-c2ed-649b179a79ac@kdbg.org>
        <bc145b9d-96cc-325a-8df3-af87d23c8727@ramsayjones.plus.com>
Importance: high
Date:   Tue, 30 May 2017 09:03:18 +0900
In-Reply-To: <bc145b9d-96cc-325a-8df3-af87d23c8727@ramsayjones.plus.com>
        (Ramsay Jones's message of "Mon, 29 May 2017 22:59:51 +0100")
Message-ID: <xmqqo9ubfby1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> See commit c7018be509 ("test: allow skipping the remainder", 18-05-2017)
> which is currently merged to the 'next' branch (merge 03b8a61e47 of the
> 'jc/skip-test-in-the-middle' branch).
>
> (see also http://testanything.org)
>
> If you look at http://testanything.org//tap-specification.html, it shows
> that you are allowed to annotate a plan of '1..0' with a SKIP directive
> to explain why no tests in a file were run. However, a plan with '1..n'
> (for any n > 0) must not have any annotation. (Back in 2012, when I wrote
> commit bf4b721932, I found much better documentation than the above!)
>
> So, after commit c7018be509, you can now use the 'skip_all' facility
> after having run some tests; it now converts that into an 'SKIP comment'
> just before the test plan, effectively skipping the remainder of the
> tests in the file. (since we are using a 'trailing plan', and have thus
> not declared how many tests we had intended to run, we can output an
> accurate plan).

Yes, but I consider that c7018be509 is an ugly workaround, not a
part of a properly designed framework.  Unless it is absolutely
necessary to run some tests before we may conditionally want to say
"skip_all/test_done", we should strive to add tests _after_ these
conditional skil_all/test_done is done.

In this case, I do not see there is a strong reason why the new test
must come before the "setup" test.  Sure, it does not use UNCPATH so
the new test may be able to run even when the current path cannot be
spelled as UNC, but that is a natural fallout of (ab)using the test
script that was meant for UNC testing for something else, so I think
a proper way out would be either (1) to use a separate script, if
the new test wants to run whether UNC path can be determined, or (2)
just accept the fact that the new test will only be run when UNC
paths are tested.  Relying on the hack c7018be509 did is much less
appealing.
