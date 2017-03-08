Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE05A20135
	for <e@80x24.org>; Thu,  9 Mar 2017 00:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932144AbdCIAJc (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 19:09:32 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33127 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752378AbdCIAIr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 19:08:47 -0500
Received: by mail-pf0-f179.google.com with SMTP id w189so21062001pfb.0
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 16:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lswR2mIS5au+AiJ/kBYreQS+rO7KmLDf+Oxn8B3raL4=;
        b=HrB/5w1IaaL4/FWpWzUDFlL5/CwpZqjZRY7t4cysjPoTD2EiIj7ga+iygUGEO2zBvi
         Qj2V5BJ4x5qPWYnvAy2brlVQiQpChLJBNjT8vFl+qyhArn2+bQGPC++UM3gbsb+xm8GC
         tZQMrtf3MTd+Bvyockka1PRj1/NVF+kBsId3Khq4JsPMx7kpN//jmlsUAv89KE1mojFk
         JzprYiW7LthtGzoPfjGVBcvoR+JNOA5Swd0eHxTpYYfqis3BEwkE5TbexThZFh0p8SvK
         BTUhoBCZwBMnpLNxwwbs5vrdt7GvObxeVPMoSD8MNrhEfFtlXsF3mlgBVPtF5fmDsBvl
         TSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lswR2mIS5au+AiJ/kBYreQS+rO7KmLDf+Oxn8B3raL4=;
        b=Fp1eDsxYkIouyxk7h6en5lJQhF2g1jwZnjjFYa2Q4/pf1UN2vop1b82uEy85rW/Y6I
         Mqcr7WFxsMXCO2kT9QQArf4TrqB4aYsDxRs1iJoVmOZXWPKBXBjt2ppT41vE3C6SDHhk
         x2qV1B+poHTUZfmIpSdahX+rod9JZVrXOpEE0BhB3fA3xBEP78WmXPETncza6rmALBt9
         6gTQJsUEZKyW8LtjjL4ZUPnF6xmZkRshf39KMgr1sHdkmb3iC5gL5WvGcoAx9S30a3Kh
         QdefNfiAOCmD4VfvDVXCP1TVsz4uSJ11hW2I2p0h3oWa0bTMBK60zep+66CjjIXMmpYF
         zCsw==
X-Gm-Message-State: AMke39m2xpSlK0VeqN8CqG7pCAxKDw/eUZwn6dws4wP2NUacuDs8mHsvIHsrW5mEDfZG1ieUgQCBT60ZalSX8nY5
X-Received: by 10.98.63.24 with SMTP id m24mr10406991pfa.143.1489016067856;
 Wed, 08 Mar 2017 15:34:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Wed, 8 Mar 2017 15:34:27 -0800 (PST)
In-Reply-To: <xmqq60jj1heh.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kbnpUtrKdjQdQ-r6rRuVvnawooLFk1bO8jOSgxNkx2Dbg@mail.gmail.com>
 <20170308230512.30572-1-me@vtolstov.org> <CAGZ79ka7PNKq5JWLPujvVHJWf6eEUadaJXd5AmKEvKT_y1ghOA@mail.gmail.com>
 <xmqq60jj1heh.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 8 Mar 2017 15:34:27 -0800
Message-ID: <CAGZ79kZY+cyPBGDmhYfJNtaS4UgUp-2nsOKLBgNzwfRpuCn7PA@mail.gmail.com>
Subject: Re: [PATCH] submodule--helper.c: remove duplicate code
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Valery Tolstov <me@vtolstov.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 8, 2017 at 3:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> Also,
>>> should I start new thread for new patch series?
>>
>> As you like.
>> As far as I understand, it is very easy for Junio to take a whole
>> (sub-)thread of patches and apply that and make a branch with
>> multiple commits out of it as he has tooling for that.
>
> Note that the world does not revolve around _me_.  I was once asked
> for my preference and I responded and that is what you are recalling
> here.
>
> Others on the list do review and keeping it easy for them to is also
> important.  What's _your_ preference?
>

I use gmail, that has a broken threading model
(it groups emails by subject lines; apparently not using any "in-reply-to"
relationship to build up a thread), so I do not care. At all.

I do not know about the preference of the next most likely
people to review submodule code, so I refrained from giving advice
depending on reviewer preference, but instead gave advice that would
ease your work as I recall.

After thinking about it further, you may want to make sure that the
topic is coherent and it is easy to discover all related emails in an
archive of the mailing list. https://public-inbox.org/git/

So in the cover letter you could link to the previous thread,
https://public-inbox.org/git/20170308174449.24266-1-me@vtolstov.org/
or just continue that thread by replying to an email that is appropriate for
the series.

Thanks,
Stefan
