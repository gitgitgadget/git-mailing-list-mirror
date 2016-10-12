Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 155DF20989
	for <e@80x24.org>; Wed, 12 Oct 2016 06:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753315AbcJLGsO (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 02:48:14 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33537 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753126AbcJLGsN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 02:48:13 -0400
Received: by mail-qk0-f182.google.com with SMTP id n189so18056471qke.0
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 23:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a9BqryqF/JcSrn3Bi1wFp8C+Fzyfs6chlfxeFJzc/jQ=;
        b=fcy+mDI2rlfglaJK9zu5HDLruVWY6riZivvMWYAYOCRx2/+6UyJDlZyQMrz7ZqvCOB
         0xZEV34ucNqpuSK7c8qAvgyMJ2Vo6fx4aayImRRavqUFYe0F8HBHyVsG58/7jtRX9cB9
         t1o2aFLu+XM7dkpAn0KRprF0jSzsonOBD3VtYQ4u3/Z4P655vzhq4IQzSNwB7NAIZrxT
         0Ta00BFP8T0Sg+XnrH3SOji1ItXKe2elkhxb/qMEz6Un+3PhYe5IIMz5y8hO1CNcNi5Q
         qklXrfXMghN/U1Ay78EODPBlJbxaoGT+sh5lo8xC+FeoQUAOKqqC5J95tk2BEQ6FFrxs
         BOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a9BqryqF/JcSrn3Bi1wFp8C+Fzyfs6chlfxeFJzc/jQ=;
        b=EW1137IvX+CC1y53VCT0uRQfIZYNHxLNHscmapwTTjiarhltzKRv9U07BCU9ZbQOLY
         ojAKlFVbBAd4fC6kIR23YC+cgmwM3nz2yPnR+PXHuT4ZdvKOkm0zdyTcCEuOtLkY4T5K
         +UvilhS6DdbQXWpU64a2Gw9F8UPfvnT8yUqo/Kb3m5h+PuTt0dRsZus1rdGQd0Bs4fAm
         ukSppuaVrVuT8C116loUK0s+QNszkzVx3HDufMbxrFJyKaPExlSru6BwhU4PjJtAgCJl
         jP5NbFbrh0IqrmwOshdycyFEjFLnF8kkvo93Mj9SIAA5kxT8sGSAZdPboDU1i/DgUZCI
         SbyQ==
X-Gm-Message-State: AA6/9RmmnGt7Ohg+zMm7n0g1vLClufPltePnL4kQUGUTsL+tCFpOfTwGCAMWuR8Vt+ZJMXaxLAnu3oKJW/hyFPcw
X-Received: by 10.55.36.131 with SMTP id k3mr6517954qkk.86.1476254875722; Tue,
 11 Oct 2016 23:47:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 11 Oct 2016 23:47:55 -0700 (PDT)
In-Reply-To: <20161012015224.g2eb24jexepeewob@sigill.intra.peff.net>
References: <CANXboVZvfPkTQ10PWop+LgPFpc2bD3-u-e5ix0itGawiwCxOuQ@mail.gmail.com>
 <CAGZ79kZmrYZqi4+bSkRykn+Upt7bEyZ0N8VhiQ-h8DhSMym-FA@mail.gmail.com>
 <xmqqa8ea7bsh.fsf@gitster.mtv.corp.google.com> <CAGZ79kZNvTvk4uZa8xhxZABKtzS9A5HoumJ37AacuZnHaZ4+Xw@mail.gmail.com>
 <20161011225942.tvqbbzxglvu7lldi@sigill.intra.peff.net> <CAGZ79kaKOiy-HJboaujXXc66P6CLupteDw4JyPOGetREfz_q_Q@mail.gmail.com>
 <20161012013428.swxmrbyxv2wo37xf@sigill.intra.peff.net> <20161012015224.g2eb24jexepeewob@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Oct 2016 23:47:55 -0700
Message-ID: <CAGZ79kbvdEUj5JKQX2MJ9THG03Bwfr0nSE5z-VPTmE3H+6TY2g@mail.gmail.com>
Subject: Re: Make `git fetch --all` parallel?
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Ram Rachum <ram@rachum.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 6:52 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 11, 2016 at 09:34:28PM -0400, Jeff King wrote:
>
>> > Ok, time to present data... Let's assume a degenerate case first:
>> > "up-to-date with all remotes" because that is easy to reproduce.
>> >
>> > I have 14 remotes currently:
>> >
>> > $ time git fetch --all
>> > real 0m18.016s
>> > user 0m2.027s
>> > sys 0m1.235s
>> >
>> > $ time git config --get-regexp remote.*.url |awk '{print $2}' |xargs
>> > -P 14 -I % git fetch %
>> > real 0m5.168s
>> > user 0m2.312s
>> > sys 0m1.167s
>>
>> So first, thank you (and =C3=86var) for providing real numbers. It's cle=
ar
>> that I was talking nonsense.
>>
>> Second, I wonder where all that time is going. Clearly there's an
>> end-to-end latency issue, but I'm not sure where it is. Is it startup
>> time for git-fetch? Is it in getting and processing the ref
>> advertisement from the other side? What I'm wondering is if there are
>> opportunities to speed up the serial case (but nobody really cared
>> before because it doesn't matter unless you're doing 14 of them back to
>> back).
>
> Hmm. I think it really might be just network latency. Here's my fetch
> time:
>
>   $ git config remote.origin.url
>   git://github.com/gitster/git.git
>
>   $ time git fetch origin
>   real    0m0.183s
>   user    0m0.072s
>   sys     0m0.008s
>
> 14 of those in a row shouldn't take more than about 2.5 seconds, which
> is still twice as fast as your parallel case. So what's going on?
>
> One is that I live about a hundred miles from GitHub's data center, and
> my ping time there is ~13ms. The other side of the country, let alone
> Europe, is going to be noticeably slower just for the TCP handshake.
>
> The second is that git:// is really cheap and simple. git-over-ssh is
> over twice as slow:
>
>   $ time git fetch git@github.com:gitster/git
>   ...
>   real    0m0.432s
>   user    0m0.100s
>   sys     0m0.032s
>
> HTTP fares better than I would have thought, but is also slower:
>
>   $ time git fetch https://github.com/gitster/git
>   ...
>   real    0m0.258s
>   user    0m0.080s
>   sys     0m0.032s
>
> -Peff

Well 9/14 are https for me, the rest is git://
Also 9/14 (but a different set) is github, the rest is
either internal or kernel.org.

Fetching from github (https) is only 0.9s from here
(SF bay area, I'm not in Europe any more ;) )

I would have expected to have a speedup
of roughly 2 + latency gains. Factor 2 because
in the current state of affairs either the client or the
remote is working, i.e. the other sie is idle/waiting, so
factor 2 seemed reasonable (and ofc the latency), so I
was a bit surprised to see a higher yield.
