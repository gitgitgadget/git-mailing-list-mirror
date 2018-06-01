Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0BFF1F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 23:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751135AbeFAXF0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 19:05:26 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:42306 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751123AbeFAXF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 19:05:26 -0400
Received: by mail-wr0-f178.google.com with SMTP id w10-v6so37691091wrk.9
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 16:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UA58q2OCBcTPU2TTab1fkJOotWrhIVDzezGco76Pwjc=;
        b=oIEbwc6q+gklq0dnC91dThUtl5q/nnb5BtUprmWiz9Duo9Taq9xK/WKL1YtwCyueTG
         CbBRaLcBpuCr2wFxZtRDuCuFHbJwyh79gWa7uBBpD+TghdWcNC64PL1Lzbdkq3E/nkjx
         3nMUCK6ncaorvX0sOsAzF8H2hfY0CwonSsJfwmdH9judJeJQ1SRcnmKFzuOY+tLg6OF+
         cgCrbxtqODpTHX9/HWt9JzWGmjMO2pwIy5U3Xi1gohyw4KtzZuMSUtvrE+StrF0x0v59
         c8W2ngI3wMezdmvq+9FfWBxwxmQ/VFzR/KCYkxV1bJzdhYjFp5OUspudVqHl4VBj13s1
         Q9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UA58q2OCBcTPU2TTab1fkJOotWrhIVDzezGco76Pwjc=;
        b=gcJHByzviLsslialFuIq51X2xnEDeDDXpso/8OizdodeE5gI3W/1LcMxCFGwImO+Sy
         esAvM0jypIBb3cnsiYFefghMpFCUqoJWN9E2R//0R8VD6RF6SJ8Au0o7MzcrqWsQcrdp
         y0mRrNXLLbTvR/J8Bbkjx2Z/XHLU6bEtHg1+Nl13FT0VXVsse2dtYb8SsVReShvgTLR7
         dUnA4OljemzhpoM/LWDBdOxKDZ4wAAIA1JXWupiTbtcrD4HAehs7hoWGpINhPn/IUnZi
         CPyfOMRqwBikbDPK8fyHCUHugh5BUZvrCcE4hbtSixhEHKam+E6/t/eB5K2P2nreV+BR
         2LLg==
X-Gm-Message-State: ALKqPwcD7lE6pLSFCDA3n8S88Kf1+aEj8gpYtZpYSvu9FOdWtZz1baka
        O04J+4bo4KBX8JuMARgsFhM=
X-Google-Smtp-Source: ADUXVKIz/I1iIm1HqqQ6/pkWg5mVTom+QyVfiQVY/WU5YFhTpljs2WH3+akiXCgA1qrjDg9zZEzATg==
X-Received: by 2002:adf:de82:: with SMTP id w2-v6mr10503823wrl.88.1527894324467;
        Fri, 01 Jun 2018 16:05:24 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n18-v6sm18641689wrj.58.2018.06.01.16.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Jun 2018 16:05:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: how exactly can git config section names contain periods?
References: <alpine.LFD.2.21.1806011606490.11215@localhost.localdomain>
        <20180601210731.GA20974@sigill.intra.peff.net>
Date:   Sat, 02 Jun 2018 08:05:22 +0900
In-Reply-To: <20180601210731.GA20974@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 1 Jun 2018 17:07:31 -0400")
Message-ID: <xmqq36y685vx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Syntactically we do allow:
>
>   [foo.bar]
>   key = true
>
> in the config file, which should equivalent to:
>
>   [foo "bar"]
>   key = true
>
> This is mentioned later:
>
>   There is also a deprecated [section.subsection] syntax. With this
>   syntax, the subsection name is converted to lower-case and is also
>   compared case sensitively. These subsection names follow the same
>   restrictions as section names.
>
> This has been deprecated since 2011. Maybe it's time to finally get rid
> of it.

Sure, but is it worth the transition noise?

The way we lightly utter the word "deprecated" around here probably
does not align well with the way how end-users perceive the word.
Just marking something deprecated in a corner of the documentation
set, without actively making an effort to wean the existing users
off, while happily accepting the existing "deprecated" practice, is
what we've done.

In those repositories people have with "[foo.bar] key" syntax that
were created before or after 2011, we first should start issuing a
"that syntax will no longer be valid---I'll update it for you if you
want (y/n)?" warning and keep it for a release or three before
finally removing the "feature".
