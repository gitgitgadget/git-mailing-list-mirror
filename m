Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AF4D20281
	for <e@80x24.org>; Wed, 20 Sep 2017 20:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbdITU5l (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 16:57:41 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:52182 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbdITU5j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 16:57:39 -0400
Received: by mail-qt0-f175.google.com with SMTP id q4so4138456qtq.8
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 13:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mSBLQvFTI9ChEFKBb+E1U1b6YMzvahImwKN5zzFiRpM=;
        b=EEGEanoolceVtNFq2ts+zPdkRJGYCfIAE7Z4IEhypTHBM7jC5jxPn9GR0MQCMeuWCm
         TSRelkSkF+z+ZeAedW1YcaamppfcmLG6whiDAuqPvAUs5Wb11sZRY6nDBfqzzgyHfr+8
         2IiDfkIP3HIBAYhRjGZEspmF2B//3sFSfa4y1SRPcEzvkS1xlpF7DDnZqIjMmedi3ETH
         A0SM2WOhnyjUTVS1uWwZG3lWGmwoGGM2tif+I5UmfYiG02+K7xM0jjf1X9Gnyi4jzXEX
         5SPt5GbvYpLuoEL8qtyvYJED2HEj5B7/mezcKMSgQk58fNISkioOW/C6tUWCnzFOsoUY
         ZLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mSBLQvFTI9ChEFKBb+E1U1b6YMzvahImwKN5zzFiRpM=;
        b=PcapFzSzCev2H8i1sdfcqTyOTHIIfbu0IN/BU/mlcsPsMTKB/AdF5tufA/otRyZtG9
         OwsjVdojVFOm2+iiOtI/1E7XkUGc7ghCOq/GqrHcbQgpjNP01OW4SsWcwKHpbDC5/4Gf
         NtY9xilYwWtwn74flMiBz5FcOynLHzxiznoiDDbHjOLeix5qaMegtVbxAOc5eOEdfa7I
         t7Go8NwIKLKsLNExFPnUIWTRVw8EkAjfls+dv42s9eDPmTBbVLLgRUM68cOPGyW/v5di
         zjNDfJMicHitFwTBLAerVtPTuFic6e2L8GKk+wQUpS1HgW/SeJe5OS67sfBFOmlaVpWb
         Q6Pg==
X-Gm-Message-State: AHPjjUiE5srHgKCfXvX/ACaHtDsfFxLlpX0CR484LvKVtaGHQ6W3wQzb
        57J9FSwRBeaA6Og91Ax5gf/gMqWJHML/7LaEzB6FH1BkZPk=
X-Google-Smtp-Source: AOwi7QCqRyP++ZF6Kk9ZmUdUQmPFFprN8oxCkzWYl7L5lOIQlbdjCQd+V6eshaTLkqW0T179465LD9k7h4F2VGoifNE=
X-Received: by 10.200.48.49 with SMTP id f46mr15941qte.260.1505941058680; Wed,
 20 Sep 2017 13:57:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.51 with HTTP; Wed, 20 Sep 2017 13:57:38 -0700 (PDT)
In-Reply-To: <20170919071525.9404-6-kaarticsivaraam91196@gmail.com>
References: <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com> <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
 <20170919071525.9404-6-kaarticsivaraam91196@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 20 Sep 2017 13:57:38 -0700
Message-ID: <CAGZ79kYMagCFS765NtOBDxDJYaXMyA4-=xxi3JMxbga638b6Yg@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] builtin/branch: give more useful error messages
 when renaming
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 19, 2017 at 12:15 AM, Kaartic Sivaraam
<kaarticsivaraam91196@gmail.com> wrote:
> When trying to rename an inexistent branch to an existing branch
> the rename failed specifying the new branch name exists rather than
> specifying that the branch trying to be renamed doesn't exist.
>
>     $ git branch -m tset master
>     fatal: A branch named 'master' already exists.
>
> It's conventional to report that 'tset' doesn't exist rather than
> reporting that 'master' exists, the same way the 'mv' command does.
>
>     $ git branch -m tset master

This is not the 'mv' command as promised? So this is just
to demonstrate the (still fictional) better error message?
Maybe use a real 'mv' command here?

>     fatal: branch 'tset' doesn't exist.
>
> That has the problem that the error about an existing branch is shown
> only after the user corrects the error about inexistent branch.
>
>     $ git branch -m test master
>     fatal: A branch named 'master' already exists.
>
> This isn't useful either because the user would have corrected this error in
> a single go if he had been told this alongside the first error. So, give
> more useful error messages by giving errors about old branch name and new
> branch name at the same time. This is possible as the branch update validation
> function now returns the reason it was about to die, when requested.
>
>     $ git branch -m tset master
>     fatal: branch 'tset' doesn't exist, and branch 'master' already exists
>
> Note: Thanks to the strbuf API that made it possible to easily construct
> the composite error message strings!

This shall be read as an apology to all translators out there. ;)
Playing sentence lego in source code is not optimal, as other
languages are very different and you cannot assume even simplest
things about them (because of their variety).

In this case it might not be as bad, because we're providing a
whole sentence per _(translatable) unit.
