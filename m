Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00E051F404
	for <e@80x24.org>; Thu, 15 Feb 2018 04:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966555AbeBOEuu (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 23:50:50 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37710 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966475AbeBOEut (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 23:50:49 -0500
Received: by mail-wm0-f44.google.com with SMTP id v71so25610145wmv.2
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 20:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9kt9cuSgAWdmIC6BDsUnQ1gi5aiHC2ShCVLFvvSMTqA=;
        b=q80iq/Y3oyRID3aWSYOT4lx0IqltdMXLVwb2WIlywixfrDfC/z3yZDhHRwe9A/BkJR
         tlpuEFXIt/hNtd+LxnL381+7Io6oohdR+GxtraxqKHkFSHcVXFuXp/graqtaxVxYNkfh
         Zu+j+MZ6pdS1T+0X7PokhgEacrrih5x9x8v/AylHnuqiLX7sOVGvdViQIpwGEn0klKI1
         CCdkcXSYlur65vdsfKVXAaOTVzs+7YsLM+iZqvhCA8UzTpfq4rNzu78ByzI4D9vqwPpD
         xbxZya+1kVXvfk3aaeec+rDwf8B22FtA1utvrRLOwJRXmb9/fFleNK5PFAfkKbbF2qlB
         2h2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9kt9cuSgAWdmIC6BDsUnQ1gi5aiHC2ShCVLFvvSMTqA=;
        b=htxRj6mLBWnZodz5YL3bmRUowsshbSrvfRV8HKqcI3A41GOJkO4KgcU/sr997fDYPp
         EHlRbgG4CjbP8bYYCGcwXFmYyYS07bq9D42+J/QYjYT+X6NwNa2j3Tzo66DhjQ1kZqJR
         dRbjeQ8Zej1BGKwcMnvn/+6XgPjOvJU/4YNuTym5hYaAiQZ5y1+RT0qy/77Ic4DkRE+s
         pvADoXSH+cAJm5pWANItK1WPCLuqyMzCCVnIZWI1AOyr5VgI1Kxtfn6Rdgs7ZoGidBVI
         S83+YSApHJkBaIdWInASn6A5AXdTZ+thkEIIiRR3S4zRUa6BVJE3JYfptl5RSi44xdtr
         qU7g==
X-Gm-Message-State: APf1xPAZHKIxN0RjmN986xB2TNmK3GE8rh+FziBiYQV9eaG4AD0YDIwM
        zwNXDAdOy8xy1ZfuJZMV2hLMxxkmtCc5kjvrMtQxpA==
X-Google-Smtp-Source: AH8x224fBvYg73oyG88dygj4LhG9RX8FzwOOdsVNe9Xb+HXGe1iAH/TRjYPCMqMn5S0cU9hvd6b+8n6tWPaZqL4dnVA=
X-Received: by 10.80.136.46 with SMTP id b43mr1666280edb.252.1518670248192;
 Wed, 14 Feb 2018 20:50:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.149.220 with HTTP; Wed, 14 Feb 2018 20:50:27 -0800 (PST)
In-Reply-To: <CAEWZXo74Z0PRkVPzkrMDdKNhLzyKL03vUYiN=SEnt5MBdXT81A@mail.gmail.com>
References: <CAEWZXo7KiRWK7ddyZgQKs=F+sHY7TtFsXTMXyE-57=FRr6kf6w@mail.gmail.com>
 <CAGZ79kZf1UKsBEJXuwAH+EWr+ZKj-FE8DuBvcM2nJeNhLEA4CQ@mail.gmail.com>
 <CAEWZXo6ws5q-73AP6+Ru39a+drO88fRO49_QGJbQXfOYRpqKwg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802150148040.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CAEWZXo74Z0PRkVPzkrMDdKNhLzyKL03vUYiN=SEnt5MBdXT81A@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 14 Feb 2018 20:50:27 -0800
Message-ID: <CA+P7+xpBW7Sq89f5RK6cCcLYGR0Rh0aWdWrhqjerKUi5xUUKtQ@mail.gmail.com>
Subject: Re: git-rebase --undo-skip proposal
To:     Psidium Guajava <psiidium@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Paul Tan <pyokagan@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 14, 2018 at 5:50 PM, Psidium Guajava <psiidium@gmail.com> wrote:
> 2018-02-14 22:53 GMT-02:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> Now, when is the next possible time you can call `git rebase --undo-skip`?
>
> What if the scope were reduced from `--undo-skip` to `--undo-last-skip`?
> Also, further reduce the scope to only allow `--undo-last-skip` during
> a ongoing rebase, not caring about a finished one?
>
> But, this could be so niche that I have doubts if this would ever be used;

I think this is too niche to actually be useful in practice,
especially since figuring out exactly what to replay might be tricky..
I suppose it could keep track of where in the rebase the last skip was
used, and then just go back to rebase and stop there again? That
sounds like just redoing the rebase is easier.. (ie: use the reflog to
go back to before the rebase started, and then re-run it again and
don't skip this time).
