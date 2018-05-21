Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29D321F51C
	for <e@80x24.org>; Mon, 21 May 2018 18:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753557AbeEUSQC (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 14:16:02 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:43445 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753545AbeEUSP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 14:15:59 -0400
Received: by mail-yw0-f176.google.com with SMTP id r202-v6so4753827ywg.10
        for <git@vger.kernel.org>; Mon, 21 May 2018 11:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qAONgp7NTkYeY3ZTryYh3iclkT+JQzrPod3XL5OVEZE=;
        b=e2560wN29sT8UI6DrMJfBv5EYXfcNSbvIgvOgs9w1aTGgDCWuLCP5G6pPbId+TxUrN
         v7Sa+N3SbXmCEVNr/7dkyLDKfbmd5DVihsgYXjyMNMxdkYA5NiX8IznqtzRUNx0i1Vce
         65c2wNplKNQP82KLx/mh8SogFC8kehWns5D7tzVl5ANGxc7RcELthuNwdfoj/I00+vtc
         nStjIBJ8OluaCrLmusW/45zvaZ7OLNmTAk7+cH5xVrmYCd1WCfOFsIsUngq8T+Cnc74z
         ocXvtTojrVpjVyVS86POboPmtuvkn5F20Pg1fSfO5k1+fXkbNnktDmdt5FCPrGHdyhXj
         GNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qAONgp7NTkYeY3ZTryYh3iclkT+JQzrPod3XL5OVEZE=;
        b=Kk9F6pILPD5cD7lBcu5PamdLTblS+UOTbuXNXJgpnk3Ciiy0bFxItgvzu6bP3tg2Vu
         fKrMA9iNkWYq6YA23J6amh8GE+Lja6B3MurGOfGLF93fJpigTIOnchGuX0409hpUaXik
         Spcs+y9a+xlaDpvw1K52erTsePp+8ir+k2k1VNs5cPBjM9IVKL+tJmOzaZoiO7Ld0YY7
         PICZWZJs0bINF6IFXkHOGVVhmf8KZa5/keEh24rbl3K+wM07pGvcWtP4psS4dOyr3Yxh
         V7e7QWWgOVLLWsGE+e8xn8hxj/AWUnasKvQkR0qCiTF/n8PueJcG+qijrEf8QflHT3Gp
         zYFA==
X-Gm-Message-State: ALKqPwfFZ5UGMbmhxF6zjEqPk1GjQwtqMaowBHOaJ2gT9HWx9rFJeJfH
        ptt+LfKK3uOGo7Ye1e6Wy44pERy1KmftnMeak3fYew==
X-Google-Smtp-Source: AB8JxZo2/XIKNeIuKAJvKl6Hb/+RrHdSL8iYGhtJrq/cTeo9YBKwMQNqD4PLrxcNb8jvDskjwcpCNo5IG6cqazstWsY=
X-Received: by 2002:a0d:e28e:: with SMTP id l136-v6mr10622483ywe.500.1526926558377;
 Mon, 21 May 2018 11:15:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Mon, 21 May 2018 11:15:57 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.21.1805211335250.21160@localhost.localdomain>
References: <alpine.LFD.2.21.1805210717040.9926@localhost.localdomain>
 <CABPp-BH0bw3m5Ubz2+-XyFGwoHD96sAaSen9-SHQSBqMS-9u5w@mail.gmail.com> <alpine.LFD.2.21.1805211335250.21160@localhost.localdomain>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 May 2018 11:15:57 -0700
Message-ID: <CAGZ79kZ7_QJk7BaZ2R7W=9fvNtbyeM9O9qvXdPcHsUXgD=93Aw@mail.gmail.com>
Subject: Re: which files are "known to git"?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 21, 2018 at 10:40 AM, Robert P. J. Day
<rpjday@crashcourse.ca> wrote:
> On Mon, 21 May 2018, Elijah Newren wrote:
>
>> Hi Robert,
>>
>> I had always assumed prior to your email that 'known to Git' meant
>> 'tracked' or 'recorded in the index'...
>
>   i *know* i've been in this discussion before,

https://public-inbox.org/git/alpine.LFD.2.21.1711120430580.30032@localhost.localdomain/

via

git clone --mirror https://public-inbox.org/git git-ml && cd git-ml
git log --oneline --author=rpjday@crashcourse.ca
/ known # search for "known" in message subjects

I really value the public inbox to work as a git repo, as then you
can dig though it just as you dig through commits.
