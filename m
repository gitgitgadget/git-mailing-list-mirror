Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67A8F1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 18:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753448AbdFMSCB (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 14:02:01 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:35006 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753800AbdFMSBh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 14:01:37 -0400
Received: by mail-wr0-f169.google.com with SMTP id q97so154860231wrb.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 11:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Vs5cJLrkPt9QrRzUzFJPfXOg1lJGWoWNnMKEVflbKE8=;
        b=f3iMSMk8dmOU78pB67+4/8aJzPK1Ug9DONiwSVR5yGk/VG33oli3LW7DZQwB5I4SkD
         u8FOPEMdUcv3Z1vGUbNnLOLJm5wtBC3Br4RVARrprmVF/b2Ap+S/ibVL0YUtjGJPgsvS
         KuHxrD5gYF1F6OeB2oZWRnYq6esBxBkYBbaP1q0Vp/2uyyO5DRFZENSWi/CkTv60It4W
         yG95M/l1rIMq7lBiKJTCi6AiXmbBOjclyJvixFQ0WXRqpZVYbnix/ZVhKwy75NFEy2U4
         FcWpu/liR1Co/TkOd8wey7J9/uxnBSXIUhTR8z9TK2NhYXtbU6PpfJhhy9W5s4r+GYnB
         X9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Vs5cJLrkPt9QrRzUzFJPfXOg1lJGWoWNnMKEVflbKE8=;
        b=a2Q/cyKE3zhkSW9xX+9DAvQGviesxBjbBNH4T2H5CJbhOwBW4hER/kAJtD+1lsQCKv
         nT+Dh7gSNgKj3GuJpO43sUxGZ1qbh4FxZbmDdbQI3Rx/Nt0GDSv1E4W0WdBfqTbgrk5E
         SC+Rw4dW93imKpj2EDVqkXPGb8OO3y8E79WnZu8M2YzLyXApDM6Qz/OMSkTVE/7c1C1j
         2isBfzYyeXr7ogpIRjVoaOu4d3JkJB4qFxvvoK2l0Sx6oWJ7EabzaFSrM4FfaRC3Icdb
         B+08PSvDSxtGWkQi3ncOouMgxcfPRU/k/Mpp7c4acot/ZpWwOUb7PWLWgJIsgWK0gCNd
         Yj9w==
X-Gm-Message-State: AKS2vOz5u3UXy4UQNM5didLaeKeJtllYpgtTkVO8/90QWCRZ0PjUDZfi
        RXORpX3BkMTm8Q==
X-Received: by 10.80.154.65 with SMTP id o59mr816639edb.181.1497376896561;
        Tue, 13 Jun 2017 11:01:36 -0700 (PDT)
Received: from snth ([92.109.130.42])
        by smtp.gmail.com with ESMTPSA id d1sm6678184ede.46.2017.06.13.11.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jun 2017 11:01:35 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dKq8F-0000jL-5U; Tue, 13 Jun 2017 20:01:35 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Sahil Dua <sahildua2305@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] branch: add tests for new copy branch feature
References: <0102015c5146c8ca-e5144538-326b-47b8-8c81-af31da4cdfe0-000000@eu-west-1.amazonses.com> <CACBZZX4LpRK5q+cxToWqGeW2ZgN4ggo4h9SJpx0mZkZUR15jNw@mail.gmail.com> <CALiud+mGovAoPriJxzCB93jwkChyRb49yxVtNijfag2zx-jZ0Q@mail.gmail.com> <CACBZZX6LcTzFKTe0fENj95Vm7GrxT5HHs3pzrqajG0XApN-rbw@mail.gmail.com> <20170613175501.GH133952@aiede.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20170613175501.GH133952@aiede.mtv.corp.google.com>
Date:   Tue, 13 Jun 2017 20:01:35 +0200
Message-ID: <87o9tr3gxs.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 13 2017, Jonathan Nieder jotted:

> Hi,
>
> Ævar Arnfjörð Bjarmason wrote:
>
>> So the reason we have this for -m is:
>>
>>     commit 3f59481e33
>>     Author: Jonathan Nieder <jrnieder@gmail.com>
>>     Date:   Fri Nov 25 20:30:02 2011 -0600
>>
>>     branch: allow a no-op "branch -M <current-branch> HEAD"
>>
>>     Overwriting the current branch with a different commit is forbidden, as it
>>     will make the status recorded in the index and the working tree out of
>>     sync with respect to the HEAD. There however is no reason to forbid it if
>>     the current branch is renamed to itself, which admittedly is something
>>     only an insane user would do, but is handy for scripts.
>>
>> My understanding of that last part is that Jonathan/someone (see
>> reported-by in that patch) had some script which was renaming
>> branches, and it was easier for whatever reason to just make it no-op
>> if the rename would have yielded the same result as doing nothing at
>> all.
>>
>> Most likely your implementation will consist of just re-using the
>> logic in rename_branch() (and renaming it to e.g.
>> copy_or_rename_branch() ...) so you could just re-use the no-op
>> behavior we use for -m, or if there's some reason not to no-op and
>> error instead for -c we could just do that, but in any case this case
>> of `git branch -c master master` or `git branch -c currentbranch`
>> should be tested for.
>
> I may be missing some context, but notice that the above mentioned
> commit is about -M, not -m.

The context was just that that commit added a change in how -M
interacted when clobbering the current HEAD, and that -C should have a
test for that behavior, which the patch now submitted to the list has:

    +test_expect_success 'git branch -C master master should work when master is checked out' '
    +       git checkout master &&
    +       git branch -C master master
    +'
