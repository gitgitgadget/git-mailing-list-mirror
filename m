Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE7161F404
	for <e@80x24.org>; Mon, 19 Feb 2018 14:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752766AbeBSOuX (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 09:50:23 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:45886 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752609AbeBSOuW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 09:50:22 -0500
Received: by mail-qt0-f179.google.com with SMTP id v90so9711849qte.12
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 06:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gnustavo-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=lNGzFHeO2H911liR4G3mdlTAx2WACNvty9LpGnmmqKg=;
        b=sRgHvXXjf9bAFgY4SjzVNU7Z+1vViDY174JsefLf+pqKmDsNjxJMQC61Zpi9nGDrfB
         8c8/G31hKd33ftZOHAUcI1UIPmjl/o4cEiDBD2eJtVQSe3Vg5hbM0q9b1tNE2zZRemLq
         4td/qoAwLodfHh24zmw3dx3n5o2+zpzSNr1TCVmIpXzcfBox0+vhZvxwHZltLX9DwG0v
         LOdGq//qMzius0r8R+W1bz1+xJh3Evd8SpBI4441NUQ0lbetfAyalqSa2Q+7mom3EUFw
         ZSdiWQEljwRd5F9wtOQ5ekXmv9/qv/T9B17zYGkT3JaY/MMYRmSwnVvbtEKklogZFOaH
         O+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=lNGzFHeO2H911liR4G3mdlTAx2WACNvty9LpGnmmqKg=;
        b=pTj9d/2fvN1BJ0WJ13l64rKPGQ8rSqxhv34woUBs2kmwUdgu0gGPCoBNDPO4hr3cYD
         db0JgbohtbI7a0wlsh2xyU5MI2kByUFyd5fX64Vs9jR9cdDihs1f67zvCJ7vVIuUM8xX
         QEHVkpg953ASWOiT7uSekv7+B2T15CJqTB+vZIqSNL9FTeF3T2a+paafBcWul9ZA/lmP
         Si0785up1ccCWaoRg9jJBIsCDQa57tNfHJOy/6lDO7CM7kW9sYjSyAz5S4wS13ulxhy+
         g98whxP1UF5b/RrlrKOBp6qJ/6dgpWlJI0ppgnXtKw34sglg7klQDCiGhkKcTFYgvzSB
         JOAw==
X-Gm-Message-State: APf1xPC65bxkWLvupMOgPegEIWGa6Rc/9j/mOT/o9ncPCGlgmGk/qTGy
        DfUltWkhqvYMTAHAOXtSe9UNIRUbN2BlWvYWZ6irYNKFU/8=
X-Google-Smtp-Source: AH8x227+HLacXosbdCqD/Pbe8a6qkTrx+uf9mMesoldUT0UvkS+CKJtRc6NwW7lwYq4/LtYw5yYF2/iS09C1BK0PGU4=
X-Received: by 10.200.40.129 with SMTP id i1mr6095985qti.176.1519051821438;
 Mon, 19 Feb 2018 06:50:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.107.230 with HTTP; Mon, 19 Feb 2018 06:50:00 -0800 (PST)
In-Reply-To: <CAPx58qqv84+i0JbdsVzFqWB=bRDecWHxss8frD4=nWOsFj-NPg@mail.gmail.com>
References: <CAPx58qqv84+i0JbdsVzFqWB=bRDecWHxss8frD4=nWOsFj-NPg@mail.gmail.com>
From:   Gustavo Chaves <gustavo@gnustavo.com>
Date:   Mon, 19 Feb 2018 11:50:00 -0300
Message-ID: <CAPx58qoS-J+yJ_J4QOOnKyG=EOrT5J=UoCrXfXxEijq4Z2Z_3w@mail.gmail.com>
Subject: Re: Why git-revert doesn't invoke the pre-commit and the commit-msg hooks?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I asked this question on StackOverflow and got an answer:
https://stackoverflow.com/q/48852925/114983

The problem is that git-revert invokes git-commit with the -n flag,
explicitly avoiding the pre-commit and the commit-msg hooks.

This was originally introduced on commit 9fa4db544e2e, by Junio
Hamano, in 2005! The rationale in the commit message was the
following:

>> Do not verify reverted/cherry-picked/rebased patches.

>> The original committer may have used validation criteria that is less
>> stricter than yours.  You do not want to lose the changes even if they
>> are done in substandard way from your 'commit -v' verifier's point of
>> view.

I get it, but since by default you are allowed to edit the commit
message during a git-revert I think there's a case to be made to make
the pre-commit and the commit-msg being invoked by default. Also,
git-revert introduces new lines in the original commit message, and
they could be used to trigger specific checks, such as the one I
wanted to implement, to deny commits reverting merge-commits.

Shouldn't git-revert work exactly as git-commit? Instead of disabling
hooks by default, it could accept the --no-verify flag just like
git-commit to disable the hooks if the user wants it.

-- 
Gustavo Chaves
