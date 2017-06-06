Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32FE6209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 22:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbdFFWpz (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 18:45:55 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36378 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751424AbdFFWpy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 18:45:54 -0400
Received: by mail-pg0-f50.google.com with SMTP id a70so32081411pge.3
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 15:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FWwHay4UvvcatCGXnunlQwm7VQ0C6rQrFzY1Vp4o9b8=;
        b=AeLYseTlkpD2AyGvAbAfNKp12BxxBRpx9XgFJOOWZuAm8T4pssdRxJPcPWE/Cg4VN/
         qg/7RWDIpByz4PPGiMxp6JbErzF0xNWru6fOUJr0PEEr1HnoSiEVHC7SoS2jE36n+H40
         TFyYlqcPUz0/bmREev04F11kldWV2kaUEFF4R9CoKsT8w6Hg2SU1e6Zq/W1nM+7J/eXb
         0g/OrUxf7UKKEjhc76rYbs753nkrcwb/0VZhv6sRKsmG8DyReoT8nyDsqgqGdUd+/vcT
         c6uUyIXNiVXtJJhCAIcDlcYYc4yR1uSTgJ+TDwQOS008M5F/GBflR1JL6vDQLhRnIGw5
         NFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FWwHay4UvvcatCGXnunlQwm7VQ0C6rQrFzY1Vp4o9b8=;
        b=Dn06Q5TnWmrFOrcpVpwt0U7tru+LBrZgfONf3XhASIHJeNO9k0GjeyIap2BbivThgD
         aVS/XMRqg/a7KfMOGKpp49WpFfUe/eVEsUQh3/69FLKlM/lVdR6ZrBOHjzh9mqNFmfmn
         wrHDg3kyUrAY+scFH0YJN+UWjGIIDalSx9ZFZf6TIniG1dwtmsEV8hszNHxZKOaIewaE
         kK9kcuno4TglPZUazle8k9i1O31eHxoFSp7L6zHLuYUlHoSHsvN3gCfQsnamaAzDOLJw
         01psAGYue+8I4fgRcl6y0ggd0SJNyjQibv8+uguzNyps8MZeM9XEV/qxZs7E7s9IRSMw
         YoYw==
X-Gm-Message-State: AODbwcAHKzefflBGvbeTVKVOO+/5ZLD16fbnFYJ5K2mh1i8bEAr4DqQq
        /56CBddQpaWVn5eSaTZdPy/ohzC7QVDD
X-Received: by 10.101.76.201 with SMTP id n9mr29517997pgt.40.1496789153312;
 Tue, 06 Jun 2017 15:45:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Tue, 6 Jun 2017 15:45:52 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1706070008440.171564@virtualbox>
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
 <20170531104213.16944-3-phillip.wood@talktalk.net> <alpine.DEB.2.21.1.1706011329350.3610@virtualbox>
 <xmqq7f0v46q3.fsf@gitster.mtv.corp.google.com> <CAGZ79kaM9ryT1gWx=L6S90HPCaDPNZ6H124HAJscpeJCQFDN8Q@mail.gmail.com>
 <alpine.DEB.2.21.1.1706021442190.171564@virtualbox> <20170602175455.GA30988@aiede.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1706070008440.171564@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Jun 2017 15:45:52 -0700
Message-ID: <CAGZ79kaYMR9uB0G911yRPXeZjbCeef2LHz4J2FLDOEj+mYkmqQ@mail.gmail.com>
Subject: Re: pushing for a new hash, was Re: [PATCH 2/3] rebase: Add tests for
 console output
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 6, 2017 at 3:22 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> Thanks for offering. ;-)
>
> Undoubtedly my lack of command of the English language is to blame for
> this misunderstanding.

Sometimes it is best to not be a native speaker, just fluent enough to
get by. :)

> What I wanted to suggest instead was that the current direction looks very
> unfocused to me

That is unfortunate but reality of being a *real* community project.
Neither you nor me (nor Junio) can command people to do things.
The best we can do is reject an idea going off.

>, and that I do not see anything going forward in a
> coherent manner.

But is this bad?

> 1) this cannot be a one-person effort, it is too large

I agree. But there are efforts by multiple people.
See Brians series (lots of different reviewers), also Brandon picked
up parts of it (origin/bw/object-id). Or the design that was discussed
on list, which was lots of people participation.

>
> 2) it cannot even be as uncoordinated an effort as it is now, because that
> leads only to bikeshedding instead of progress

Jonathan presented a list of things, that can be done in parallel in an
uncoordinated effort, because that is how the project works.
(C.f. he mentioned "rogue agents")

> 3) the only person who could make that call is Junio

Occasionally I think the same, but in fact it is not true. As said above,
Junio has strong veto power for things going off rails, but in his role
as a maintainer he does not coordinate people. (He occasionally asks
them to coordinate between themselves, though)

>
> 4) we still have the problem that there is no cryptography expert among
> those who in the Git project are listened to

I can assure you that Jonathan listened to crypto experts. It just did not
happen on the mailing list, which is sad regarding openness and transparency.


5. The timeline you seem to favor would be really great for people working
on Git at $BIG_CORP, as big corps usually plan things by the quarter. So maybe
by having a timeline (known in advance of the quarter) can convince managers
easier.

>
>> How did you get the impression that their opinion had no impact? We have
>> been getting feedback about the choice of hash function both on and off
>> list from a variety of people, some indisputably security experts.
>> Sometimes the best one can do is to just listen.
>
> I did get the impression by talking at length to a cryptography expert who
> successfully resisted any suggestions to get involved in the Git mailing
> list.
>
> There were also accounts floating around on Twitter that a certain
> cryptography expert who dared to mention already back in 2005 how
> dangerous it would be to hardcode SHA-1 into Git was essentially shown the
> finger, and I cannot fault him for essentially saying "I told you so"
> publicly.

Heh. The community between 2005 and now has changed. (I was not there
for example. ;-) ) So let's hope the community changes for the better.

> In my mind, it would have made sense to ask well-respected cryptographers
> about their opinions and then try to figure out a consensus among them (as
> opposed to what I saw so far, a lot of enthusastic talk by developers with
> little standing in the cryptography community, mostly revolving around
> hash size and speed as opposed to security). And then try to implement
> that consensus in Git.

Sounds good to me. That is why I personally think point (4) from
Jonathans list above over-emphasizes performance/size over security.

On the other hand if we find a smart way now, then this hash function
transition will open the road to switching the hash function down the road
once again with less or even no penalty if we make mistakes in choosing
yet another bad hash function now.

> Given my recent success rate with SHA-1 related
> concerns, I am unfortunately not the person who can bring that about.
>
> But maybe you are.
>
> Ciao,
> Dscho

Thanks for bringing the discussion back to life,
Stefan
