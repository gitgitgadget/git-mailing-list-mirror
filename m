Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 158841FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 17:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753498AbdFMRzK (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 13:55:10 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33146 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753164AbdFMRzG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 13:55:06 -0400
Received: by mail-pg0-f49.google.com with SMTP id f185so63937819pgc.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 10:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yBxQPV3CLtgdFcd6+d6xZAVjiBQpuTUHGqfgobtgKaE=;
        b=HPN/zv51tnM/lbNHW7vDxI9hXReL3v6JFcodiwkk2aGVHxtRO2ZM0rojsXx4t/PwGU
         DXiPv9Tjw7fJ3EVzS7r0MBB6ZtD/qR7GLflQAv7Ojn9g9vqA36lhiuW5USosi6+fIVtL
         SlhNEn/uu5JD2dr4HxejoihNrj4bJfJtJ/z9H4XC5wv74FeyIXgq0Pj4Vl7Skzqh72YW
         p81uPEUmLgDPEu7nIKs5YZHTTlPmyDHSfvQ5S0erXsx3RzZeWzgkZGBCZpopCxuC8TZO
         DOJsWUzIzkGHuFGY7O4b4NlhdS9/o8nrP6x9rclsjnioNqPfU6QO15KbpP++G9Ifzhut
         1MBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yBxQPV3CLtgdFcd6+d6xZAVjiBQpuTUHGqfgobtgKaE=;
        b=tRcUO6EeIjBU5QvbpKBh9Op3daeuiX/MTpnp2lhPodb/PvnkQ7cRpdjZt/u+BIqopt
         G8o8UjMdYUQbbYrYKWA8tMAP49GdExOeOWOLBOQcXMzKmPR2U9PmaKDq9YKq8mWubZOe
         9OatkoNGGAoJHTBO5EYgZFt0Y2pNP97je68CcC7NHPGM8uEq1E1LzjeQ273XyCd3qAaH
         C8APYwmMJgjhBrGzbTcTMa8yHGMRXMbCz326Pu0AorP0RjX+NNOA6CuaIRL8wTXhm/08
         Ngfn+FOizdItYvIBZH1fEAiuaS65CcKcMh9vFNatPWp9LXvI0A1SP1EwHQoRzDjDD+BG
         rBLw==
X-Gm-Message-State: AKS2vOztuU6NmfQgXy7mnLO+Qr+Dery6FERxmUzxH14Rvi5ZSFEeNmzB
        LhUn5YDFQ+cIAA==
X-Received: by 10.84.224.1 with SMTP id r1mr933642plj.262.1497376504699;
        Tue, 13 Jun 2017 10:55:04 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:e453:89d5:deb:c7b6])
        by smtp.gmail.com with ESMTPSA id b1sm30517820pfl.70.2017.06.13.10.55.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 10:55:03 -0700 (PDT)
Date:   Tue, 13 Jun 2017 10:55:01 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Sahil Dua <sahildua2305@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] branch: add tests for new copy branch feature
Message-ID: <20170613175501.GH133952@aiede.mtv.corp.google.com>
References: <0102015c5146c8ca-e5144538-326b-47b8-8c81-af31da4cdfe0-000000@eu-west-1.amazonses.com>
 <CACBZZX4LpRK5q+cxToWqGeW2ZgN4ggo4h9SJpx0mZkZUR15jNw@mail.gmail.com>
 <CALiud+mGovAoPriJxzCB93jwkChyRb49yxVtNijfag2zx-jZ0Q@mail.gmail.com>
 <CACBZZX6LcTzFKTe0fENj95Vm7GrxT5HHs3pzrqajG0XApN-rbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX6LcTzFKTe0fENj95Vm7GrxT5HHs3pzrqajG0XApN-rbw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> So the reason we have this for -m is:
>
>     commit 3f59481e33
>     Author: Jonathan Nieder <jrnieder@gmail.com>
>     Date:   Fri Nov 25 20:30:02 2011 -0600
>
>     branch: allow a no-op "branch -M <current-branch> HEAD"
>
>     Overwriting the current branch with a different commit is forbidden, as it
>     will make the status recorded in the index and the working tree out of
>     sync with respect to the HEAD. There however is no reason to forbid it if
>     the current branch is renamed to itself, which admittedly is something
>     only an insane user would do, but is handy for scripts.
>
> My understanding of that last part is that Jonathan/someone (see
> reported-by in that patch) had some script which was renaming
> branches, and it was easier for whatever reason to just make it no-op
> if the rename would have yielded the same result as doing nothing at
> all.
>
> Most likely your implementation will consist of just re-using the
> logic in rename_branch() (and renaming it to e.g.
> copy_or_rename_branch() ...) so you could just re-use the no-op
> behavior we use for -m, or if there's some reason not to no-op and
> error instead for -c we could just do that, but in any case this case
> of `git branch -c master master` or `git branch -c currentbranch`
> should be tested for.

I may be missing some context, but notice that the above mentioned
commit is about -M, not -m.

Thanks and hope that helps,
Jonathan
