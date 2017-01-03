Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 640D11FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 19:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933499AbdACTsl (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 14:48:41 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34902 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760396AbdACTsh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 14:48:37 -0500
Received: by mail-qk0-f171.google.com with SMTP id u25so375109749qki.2
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 11:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dBw4PYJ4P9/9P2a6pWX2taPAWTFgHA/CuXynfrOLrbU=;
        b=Jaio6j7CQvzOmBCry5/KbxDkOnroVu5a9/lGYRueoEXie0hAhSi6FrtiOYEFeA37KT
         j6HgAKaxDNcBlDFMtNLm7ZyfwuzrQroQZ9oQkyZRu9BwpTnSzHED0TZn9Sob5TK/Q9h0
         kM1qtCe/+2x6tfMndT8199PsO/9Wlhb4TyKVqBfSQLJ/N7HTiMQTaSIyry4sNJdHOG+1
         bg3qgrq17ddvrZN+78yKsQwoooeAtqGK8Maz+H4+sEtC7P38stERx+TOpkoeG3N6TU12
         cFRvDXDK4AJmCSNDL/pfUA9fgYF6npYt4/UF13Wdy/kltWxpo9S5HFoPP4M6Ii2cbMcW
         v+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dBw4PYJ4P9/9P2a6pWX2taPAWTFgHA/CuXynfrOLrbU=;
        b=IjV2zXEYglPt/LfwvBpCZcYDo6d7rJaIejxe6j5iMmr4KcwpVZeO1PCwCGjmuDShPW
         0wFgyvc54hpC8A5Z7r9upeQVdyyLPS428ckaPcLS9mDet9qMiJXBFJlaXptkgYBjAdC9
         pjgQip289Iq55ZjjU4s0VdTR4p+OqEp27S7WDUKw3OUZzzvTNgfcrol/YvWouIoyvS8y
         XzdHNSs+uPmVhSEV7y7esyKJZXXpsWVuZ55FpekvBIUeKO2FFdlu+oL+hrbbmIauIy/f
         1bzmNSwgCTlHcknbf+W2vwORkn+wFhh38qY0b3wqzFpiO0ih/GdN3czCe9slli0ydVPE
         hfYA==
X-Gm-Message-State: AIkVDXL2uug24rXrT9FIleWUbOpOnd7lLMRdNZYb1pso1PXZzeyLPSZITsmki1+TNBs3Lc7XNy8MY/EE+7RnnGX6
X-Received: by 10.55.197.28 with SMTP id p28mr61369951qki.255.1483472916373;
 Tue, 03 Jan 2017 11:48:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Tue, 3 Jan 2017 11:48:35 -0800 (PST)
In-Reply-To: <CAFZEwPPfE_WSn2QbmER+5mkaC8RnVDs5gsSJE+Y0v-CfYaZB2w@mail.gmail.com>
References: <20161231114412.23439-1-pranit.bauva@gmail.com>
 <20170102184536.10488-1-pranit.bauva@gmail.com> <20170102184536.10488-2-pranit.bauva@gmail.com>
 <CAGZ79kZRFLzD7wcAnFvke9vBxxTAgE7=Ud7F_O95EfkWqz=LJw@mail.gmail.com> <CAFZEwPPfE_WSn2QbmER+5mkaC8RnVDs5gsSJE+Y0v-CfYaZB2w@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 3 Jan 2017 11:48:35 -0800
Message-ID: <CAGZ79kYS9QGea57R5PnbXWdUnHH+=vw+E4_=eqUPd1LoW_7r0A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] t9813: avoid using pipes
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>, luke@diamond.org,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> git p4 commit >actual &&
> grep "git author derek@example.com does not match" actual &&
>
> What do you think?

From the travis logs:

    'actual.err' is not empty, it contains:
    ... - file(s) up-to-date.

I think(/hope) such a progress is tested for at another test,
and not relevant here so I'd think the proposed

    git p4 commit >actual &&
    grep "git author derek@example.com does not match" actual &&

is fine here.

Thanks,
Stefan
