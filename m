Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D278420248
	for <e@80x24.org>; Mon, 25 Mar 2019 19:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbfCYT3b (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 15:29:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43067 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbfCYT3b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 15:29:31 -0400
Received: by mail-pl1-f193.google.com with SMTP id m10so418325plt.10
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 12:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NteGGH/VCZueRxjFQ/5RremK0JaWznak9Jw+Na5Qh3M=;
        b=N+wKd8rWc4orxdvv/VMt7qZGgkHU+XENTr4jhPUgirNowSqQ+bQVdfVFGaFKjTuMmi
         vqDwe2uhVQbKLdoyDFZ30KLVZ8PRN5OH3w4EXSf0V6pZImuwwDIi6I4GCH5s9lC0GK2K
         jchtphU6QoHjnPPD7PmvwFE8sN9W+vHpuzGl5/xAAHEkEXtliUMDjbb6CbRj1y/oxi+K
         vMLphU0U3+uKeJ+PewU9vu4N9AGNeRcEgBp2qvpfIkWW73hbvzQCNOT/TXU1MAo6A1Cg
         niszTLsymwrDn1vDce5/6/qxR8Aiier6CjTd7/61n/uzYhd2RMVgQQhxGdeIIFDG/W6a
         hNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NteGGH/VCZueRxjFQ/5RremK0JaWznak9Jw+Na5Qh3M=;
        b=JwT6HJuTK5fj42ZMJu9bNtKJLmEy3PYewpQeYNYs0UOl22uyFcFnyY6P3E+lTd873J
         FU2a/60v6MOqDPyJw02kInLcfxCul5+TZSy1XAabog3njKYYVPSYdcntnfRWv4lQzXWH
         7P3P6a+7LORphwrB2tsVLw4tWEuEH9DVUwVVFhy/lvXQWI+kLrOulKV9MA/f3WU5H17/
         XBONX9cz+S3PcmNKUTwjgGvkrc0H4ITEi3TWpefJ+uvEh99Jj9zZ1PgST/1Y1rixQQcA
         mtneC23IHLjsQEzGm1HB8avtId09GealsRdlnXZRtIIFk+X9Xnm91hnDC/2T5iVIW0Pm
         1q1w==
X-Gm-Message-State: APjAAAU61YuRqTgdXq6tA4DrfsAW9RzkEOggx8YPIUPw5ceuhYWfH6xE
        0yDNgHjB0F/7oJq+bJoR76E=
X-Google-Smtp-Source: APXvYqwq5nCwrJ4oVqI8BFIpCFLb5XrQz1BXBgNajcHbCyHOOVebKBxWFPXAzKkhf2cFsjaas8+G9w==
X-Received: by 2002:a17:902:4101:: with SMTP id e1mr27616742pld.25.1553542170977;
        Mon, 25 Mar 2019 12:29:30 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id s6sm39647995pgi.56.2019.03.25.12.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 12:29:29 -0700 (PDT)
Date:   Mon, 25 Mar 2019 12:29:28 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] rebase: teach rebase --keep-base
Message-ID: <20190325192928.GA31067@dev-l>
References: <cover.1553354374.git.liu.denton@gmail.com>
 <f802e5442013613221a4efd8ef1fecce0f3a9914.1553354374.git.liu.denton@gmail.com>
 <nycvar.QRO.7.76.6.1903251948200.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903251948200.41@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Mon, Mar 25, 2019 at 07:50:38PM +0100, Johannes Schindelin wrote:
> Hi Denton,
> 
> On Sat, 23 Mar 2019, Denton Liu wrote:
> 
> > [...]
> >
> > This allows us to rewrite the above as
> >
> > 	git rebase -i --keep-base master
> >
> > and
> >
> > 	git rebase -x ./test.sh --keep-base master
> >
> > respectively.
> 
> Just a quick note: this breaks t5407 because that test uses `git rebase
> --keep` and expects that abbreviated option to be expanded to
> `--keep-empty`, which is now no longer the only possible expansion.
> 
> I just submitted a patch series to fix that, and other uses of abbreviated
> options in the test suite, in
> https://public-inbox.org/git/pull.167.git.gitgitgadget@gmail.com/T/#t

Thanks for catching this. I replied with a (tiny) review.

> 
> Ciao,
> Johannes
> 
> P.S.: Did you run the test suite before submitting your patches?

Usually I'm more diligent about running tests but I wrote this patchset
in the back of a car when I was running low on batteries. I only ran the
rebase-related tests but I guess that wasn't enough.

My mistake, though. I'll be sure to _always_ run tests in the future.

Thanks,

Denton
