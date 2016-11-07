Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A0CE2022A
	for <e@80x24.org>; Mon,  7 Nov 2016 18:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933278AbcKGSeq (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 13:34:46 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:33064 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933274AbcKGSen (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 13:34:43 -0500
Received: by mail-qt0-f174.google.com with SMTP id p16so92764039qta.0
        for <git@vger.kernel.org>; Mon, 07 Nov 2016 10:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l9zOeCqQUHDtgNbwWX2S/uV9iebzTlscdbELxCvENp0=;
        b=PLerjSb6invaFPSF7QauFeAdInzceefLIL6YBQ5H7Qm0zz16/begHnJd7TWkbHntBm
         ISkbv0TDFdDiZr0WcAUrszNTrZJ6uO2NGLJkEumqFeLlowROSaexb+jQXCeQYJRnbaz9
         xuqDkOE9oZ9p7Ie2id3p6/pnf1rXlbrtPK+HXEF3ZnvqDf5rEUWBq6fFvLRpIoQo/KbF
         H8eNvuFCblPt4Q4SJq/utSLHTWu7YkDv3nPZadQtxbppok+R6/498JJYJj+FfBUb5grn
         52motLLjMuX+kfQTjm1J0RC6GoKSIWaAQGrbXT2jVWJj+cO0ebndIn97g6XFQ5uqYeM0
         ZvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l9zOeCqQUHDtgNbwWX2S/uV9iebzTlscdbELxCvENp0=;
        b=S/tsLO/rGqHbNj1fA2Le/N/e9tiyqwHELY2ZyVHdxi9bIWskZXTI4BihT2NA1KObRX
         qNOeAJqbInaVb8V2WJIMYfgODXtabfltjQYoelweo9eIh3CkMFQW16uDyCpBJoYlrnFy
         kJx34i9vFbC2xp1al9a/HxW+oqkVlkcMopHeZJI+AxuXBg5ZrD6SzmwaS/j/E09FUmb+
         +zAha+zJzOrwrZ55dAHNmCsqaXneZ93a1/mceTGdFSbWLzTwilxt5zgcOn3M8psAvPuK
         aNze8Bck9Ib/In++Woursb3KH3u0lKwr1jfK8NnaQCq4q35Gdzig2MyO1PIV5nPcJyoO
         ORuA==
X-Gm-Message-State: ABUngvfyMHjYiGsuy96mlREEuZKqvHQFv1hWpH8RzrHOy7hJZIsRBOSv7vQoTbURivRHiddvBwxM3wnFxTdWZ388
X-Received: by 10.237.63.25 with SMTP id p25mr8301961qtf.18.1478543681123;
 Mon, 07 Nov 2016 10:34:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Mon, 7 Nov 2016 10:34:40 -0800 (PST)
In-Reply-To: <CA+dzEBnDZGsYyZkSO5E+3EX+d1j7Kb4kiY6OkC0mtwaq5px5aQ@mail.gmail.com>
References: <CA+dzEBmP2aUit00ukJyQeg=iqUJJLVaovafo2gngf9MvEqZDPA@mail.gmail.com>
 <CAGZ79kYbrDu=9Hw+SBnubSHKOc8HmGPb721ZJQxGWW2egqmuDg@mail.gmail.com> <CA+dzEBnDZGsYyZkSO5E+3EX+d1j7Kb4kiY6OkC0mtwaq5px5aQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 7 Nov 2016 10:34:40 -0800
Message-ID: <CAGZ79kbyM0ssz3JgeNHsUpvHnBsCbhm-tHvHRp3+6O1QvmkYpw@mail.gmail.com>
Subject: Re: git submodule add broken (2.11.0-rc1): Cannot open git-sh-i18n
To:     Anthony Sottile <asottile@umich.edu>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 7, 2016 at 10:30 AM, Anthony Sottile <asottile@umich.edu> wrote=
:
> This has worked great up until now (and is very convenient for trying thi=
ngs
> out without blowing away the system installation).  What changed?
>

(Just guessing myself:)

$ git log --grep git-sh-i18n v2.10.0..v2.11.0-rc0
commit da14d73d5eacfb2fa9d054f94d9eecb2244c3ce5
Merge: 2f445c17e5 1073094f30
Author: Junio C Hamano <gitster@pobox.com>
Date:   Mon Oct 31 13:15:25 2016 -0700

    Merge branch 'ak/sh-setup-dot-source-i18n-fix'

    Recent update to git-sh-setup (a library of shell functions that
    are used by our in-tree scripted Porcelain commands) included
    another shell library git-sh-i18n without specifying where it is,
    relying on the $PATH.  This has been fixed to be more explicit by
    prefixing $(git --exec-path) output in front.

    * ak/sh-setup-dot-source-i18n-fix:
      git-sh-setup: be explicit where to dot-source git-sh-i18n from.

commit 1073094f30a8dd5ae49f2146f587085c4fe86410
Author: Anders Kaseorg <andersk@mit.edu>
Date:   Sat Oct 29 22:10:02 2016 -0400

    git-sh-setup: be explicit where to dot-source git-sh-i18n from.

    d323c6b641 ("i18n: git-sh-setup.sh: mark strings for translation",
    2016-06-17) started to dot-source git-sh-i18n shell script library,
    assuming that $PATH is already adjusted for our scripts, namely,
    $GIT_EXEC_PATH is at the beginning of $PATH.

    Old contrib scripts like contrib/convert-grafts-to-replace-refs.sh
    and contrib/rerere-train.sh and third-party scripts like guilt may
    however be using this as ". $(git --exec-path)/git-sh-setup",
    without satisfying that assumption.  Be more explicit by specifying
    its path prefixed with "$(git --exec-path)/". to be safe.

    While we=E2=80=99re here, move the sourcing of git-sh-i18n below the sh=
ell
    portability fixes.

    Signed-off-by: Anders Kaseorg <andersk@mit.edu>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
