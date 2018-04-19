Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCB8F1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 17:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753242AbeDSRws (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 13:52:48 -0400
Received: from mail-yb0-f178.google.com ([209.85.213.178]:37797 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752887AbeDSRwr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 13:52:47 -0400
Received: by mail-yb0-f178.google.com with SMTP id i13-v6so2114071ybl.4
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 10:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+UM3avhtRHO2n0lFR7LgfcjLfmaraWwRf8TVzR0ZzzQ=;
        b=jtgpB1ZyO7Yh5cKL73dDPAHZbugZudvwfzszL2VxiG2QvnqU+MNYXiZEiVa7NhCZxV
         kst73xFn+U2GcK2J3aGma6QqJaWZMP+RmJdJMH6j3MDHtkeAMF/3UAqAnLd4+OoO+hVO
         vB7xp36V83EYd/NAfIUTVT3Ha6q+qbLo0dFQXUJ3rkgMTva3Y0uSu+RQTkc9uhEc4S40
         5TLkKMo8z3N9rqqw3qoFP/8u7Va3EPgY1khbqPlB+bKMFyUfwBuP4POVlgRlZnSGlMsq
         OtvzUNSxoyrEaqToiHlG7gNIFIkcmLHr7+J4W0pERd99WUpxsjjW7qIxD7ca7MGy+eBp
         NDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+UM3avhtRHO2n0lFR7LgfcjLfmaraWwRf8TVzR0ZzzQ=;
        b=IWTo3nIfssoPvS7heRs47FBCdmXiywO9+nLCpCifqh1IqnamsJ26A189lGJpvwJuAA
         N/3YtB/i+olnpqh0smSACev24uVzWr7rB0ROIFIRPskHnB5SCGt7EZQ4Ntp/8jUPZeG9
         4qiPexJCiHQHQgjN8F8hcvxrzowEqTVoDnTODHqkbdGfbDVP6FPGMGxKr8NyvLNT3Rw8
         AeObgxfbTxyKgh8GVu3Oze6zA3G/7Lms3waoYCJw/6pWi71R+Wbi1wXZMK6yFHYMRsYc
         9hn0GBsdRnfZ6MXH1vHESGl4dT/e84KRcMt5FiuhlQiZH6T2bbsU1bLt2/87SgnTQMKV
         Dlig==
X-Gm-Message-State: ALQs6tA3WKw+hNK7coHqr9aEtMCcbx60rZ02/WHa6UPIFuFLHjA9GEHA
        Ynmtiiy4k594CogIdiAcxxo/bK+SvIO7NfJ/EZgG/g==
X-Google-Smtp-Source: AIpwx48eWyoLrqUzm/PEWd3FN/hMjzLkh/QUTchHQByTa+GmvjQp5jgqek0sIwT5ble+eMvILrK+sqfw6IK2kArfSzk=
X-Received: by 2002:a25:8e09:: with SMTP id p9-v6mr4493160ybl.352.1524160366785;
 Thu, 19 Apr 2018 10:52:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Thu, 19 Apr 2018 10:52:46
 -0700 (PDT)
In-Reply-To: <CAK0XTWecZASWULXYXGauV5WKhYinD7HXyXSTJntocQt3vzr4AA@mail.gmail.com>
References: <CAK0XTWdpKnMbXs5sq2qsERxQO20sQW6YwL=2kfBHmSwHMmunBg@mail.gmail.com>
 <20180403222053.23132-1-eddy.petrisor@codeaurora.org> <20180403222053.23132-2-eddy.petrisor@codeaurora.org>
 <CAK0XTWf=ubDK-4=FknLSFObZrShg=7UDgR5c6iNSjrwiDngayA@mail.gmail.com>
 <CAGZ79kYu-9vzee=R7uE4fhhrRj19ZT0Z5+7fPLwOpXhEr7aqUw@mail.gmail.com>
 <CAK0XTWdSQmfqo2-WuiPtOcn_4cf60jNZ_j9Uh_HpzxUwSpA7bw@mail.gmail.com>
 <CAGZ79kbT+AnVu-AJ9=OSt=Z2ErM5ocfoLfgx=qmHFfbnkqJqwg@mail.gmail.com> <CAK0XTWecZASWULXYXGauV5WKhYinD7HXyXSTJntocQt3vzr4AA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Apr 2018 10:52:46 -0700
Message-ID: <CAGZ79kaCW=iK3-Aq41Z5=WOz8hgrbo41XDCmnTVsAeqKwOuydA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] t7406: add test for non-default branch in submodule
To:     =?UTF-8?Q?Eddy_Petri=C8=99or?= <eddy.petrisor@gmail.com>
Cc:     =?UTF-8?Q?Eddy_Petri=C8=99or?= <eddy.petrisor@codeaurora.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eddy,

> I suspect that in the tests, because the "server side" repos are
> local, the git fetch-by-sha1/cloning by hash will be done correctly,
> without the need of a branch hint, but the problem will still exist
> for servers such as github which do not support fetch-by-sha1.
> In case I realize that a server-side repo that doesn't support
> fetch-by-sha1 is needed, is there a mechanism to set that up in the
> test case, or do I have to rethink my approach?

You can force a clone (at least, not sure about fetch) to use the
git protocol by --no-local, and then you can set
uploadpack.{allowTipSHA1InWant, allowReachableSHA1InWant,
allowAnySHA1InWant} as neded by the test.

From the fetch man page:
For local repositories, also supported by Git natively,
the following syntaxes may be used:

       =C2=B7   /path/to/repo.git/

       =C2=B7   file:///path/to/repo.git/

These two syntaxes are mostly equivalent, except
when cloning, when the former implies --local option.

Thanks,
Stefan
