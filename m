Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A2AC47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3C05611BD
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFGMzP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 08:55:15 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:40688 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhFGMzO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 08:55:14 -0400
Received: by mail-pg1-f180.google.com with SMTP id j12so13726556pgh.7
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 05:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FzBIPr+0PGcB/ZbzC7fUfCczg73Z9ss9rX+LCS/lcu8=;
        b=J1UqdmEUqrVDZ7zVa8u6aoYNUbw9UgDm8C4B5f9MMQSXOHq1PpyFPDk2TMNUep8FlV
         krdB2f6GyaGBz3yUqm8vFxkiKOQ7clsZRcn8e+81IO1MY2GIa3h46ElTW6mXXqTouFd5
         U0mBSPd52Nc6s6FgcDJ4BbiE5AaH1qm8QI9QzZipOcqs99Sn13/HgqRh1jW/MVfFVhpF
         0rY36qXI7rgPDaeSkZXcOgIGSW90eFbP0gRFU3c6eX4wJz7CzkwF/Ng25+oA3s18/5YM
         sKaxCL3/G4+GpoMTnS+5JhB/VN/3stPMnzDb8wiOdxIHT4w4EIVEZR10ZBEpU+h9gdtj
         /Szw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FzBIPr+0PGcB/ZbzC7fUfCczg73Z9ss9rX+LCS/lcu8=;
        b=du5auRwcxN222qKh9sRJyA+DpoyR5yHwXYwDanp1vj/qJkqiK1GyETghmesnHhsDP7
         YmoSqgniopwQeylHF/rb3o1p+4o46y3YUi5c+xv0rVWm0ViAwRlCu0F/AKnO1loNebTv
         +CQNas9GJyAq5B+SW2Gj3wNMbnBrhWSRUnrTY6swgH3jTZRbTyRHRzY2qhoJOQ6nXiiP
         FBB9wTHemHcGC0H7+jT2uNeP8Is/W0kHUnu/rt2jUbxXhewZUlbjby8HB33GcmfDXo3o
         Rbg0EWJReVXMoTuKAvzxGEpCB0oYqBXNy4nTNS+mhL/53gsoTCQgrSJFlABWx3fGPRue
         3GcA==
X-Gm-Message-State: AOAM531h/n2GZCM9MWIUbWun901hbXr70upk81Sa7y0tv868SJbFhwli
        J1oYFBBgAfjazndsDWfQSkyJVnoIWB1B7g8s
X-Google-Smtp-Source: ABdhPJz085eIBpSIYrxkQJnlEMwQA54FwGLU59eaLN7P+XWvEJwJsLFbllsfWhjTlSIqmSiUgVjMxg==
X-Received: by 2002:aa7:8426:0:b029:2e9:bc0e:5c3f with SMTP id q6-20020aa784260000b02902e9bc0e5c3fmr17195454pfn.22.1623070343580;
        Mon, 07 Jun 2021 05:52:23 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id c25sm8145917pfo.130.2021.06.07.05.52.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jun 2021 05:52:23 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [GSoC] My Git Dev Blog - Week 3
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <37725450-9769-01f1-d615-b3869ebbb33d@gmail.com>
Date:   Mon, 7 Jun 2021 18:22:20 +0530
Cc:     git <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D56DACFE-1E85-4765-80AC-0B60C2403CC8@gmail.com>
References: <FC56DF49-CEC5-4C9F-BDE4-B0119558E4B2@gmail.com>
 <37725450-9769-01f1-d615-b3869ebbb33d@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07-Jun-2021, at 14:27, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>=20
> Hi Atharva,
>=20
> On 06/06/21 19.26, Atharva Raykar wrote:
>> Hi,
>> Here is my latest instalment in my weekly Git blog:
>> http://atharvaraykar.me/gitnotes/week3
>=20
> You said:
>=20
>> Simple enough, I thought. Just fast-forward merge (A) on master, and =
then, uhh, cherry pick and apply (B) on top of the newly merged (A). =
Resolve any conflict in this stage. That way I get (A) and (B) in their =
pristine individuality, as well as a third branch that combines both the =
changes.
>=20
> But before, you said:
>=20
>> Once it was becoming clear that would not happen, I thought of =
combining those two branches on another branch (that would hold all my =
patches so far).
>=20
> Are you merging two branches that contains your separated patchsets =
directly to your own `master` branch, or are you merging them to =
temporary branch that is branched directly from `master`?

I actually created another branch based off master, and then applied
those two patches on them. Me mentioning 'merge (A) on master' was a
mistake. I'll correct it.

> Also, you advised that:
>=20
>> Check your resolved conflict before continuing the merge
>=20
> IMO, once you have resolved all the conflicts, compile and test before =
commit the resulting merge. This way, it will be nicer for review.

Agreed.

> Thanks.
>=20
> --=20
> An old man doll... just what I always wanted! - Clara

