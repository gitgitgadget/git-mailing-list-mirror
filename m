Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF6F61F404
	for <e@80x24.org>; Wed,  7 Feb 2018 18:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754089AbeBGSKD (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 13:10:03 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:38412 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754002AbeBGSKB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 13:10:01 -0500
Received: by mail-pf0-f174.google.com with SMTP id q79so658726pfl.5
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 10:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eluvio.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kHyGYUWlp4oLbSt+1gzYVwnmM/3ChPANWi+1aFQavho=;
        b=jmoeOKgMJ9dsJjoYUCmPpiXhrRN+bJvYKZVHWIBX955BfUbPN8PBbw4d8bJeqwmAfB
         b6OAj5x0l/v5ESzRRPajmAlR8F+SEgz4hw02jlzgxRWoXmu8udF3AAqsbfFCPtZLsENn
         tp4WKhbg5syqo+RctUnwSx+n+HILdr71Tv72k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kHyGYUWlp4oLbSt+1gzYVwnmM/3ChPANWi+1aFQavho=;
        b=hzcwBCA7x7ojS0dW27+1Ft2hw/qf9SkyKahvQH9dNXKfdD47InVEu58xIKLimitQAs
         /U8h6ckpI3gVKN2a/OUmgsLsxyKcyAMrhZ6wG2X3gKhj+k6d2dMPSow2kUmA9BUFrIb5
         VZDpQi7rCNp/uXM7ZxFDDENh9NhRZ2Qfb/W1pjbaMgrBzh/F24+Y1lds7/GbpLNWTLIv
         F1yBzR9XlSVnilYXylKTn1IvycbSVgtt0oZrbr+nfwcySkrcPEOSHTBtDUgkODUoyq/8
         z8ZZijootSvCxut46T5CbHc7eN//16LHRsXYRLcSdjX9wthcwzN9nbVv3Orh9ofZD9Wk
         KSng==
X-Gm-Message-State: APf1xPBAqRBn3w+O4UEx9sM+OnKAjcvaJoVDD5ZnA/h/0ftELZzkcztL
        5NU6mxkWQCA27/0ol8a2ivDC+w==
X-Google-Smtp-Source: AH8x2265hyer80EDjZS7fjHr/yh+lbUVi3mGQirsx+r/XlOudi3zkO8p7Oc8VeU8jTq0HT61C+N6Vw==
X-Received: by 10.101.80.69 with SMTP id k5mr5632793pgo.431.1518027001204;
        Wed, 07 Feb 2018 10:10:01 -0800 (PST)
Received: from [10.235.220.255] ([216.9.28.192])
        by smtp.gmail.com with ESMTPSA id w10sm3913363pgc.69.2018.02.07.10.10.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Feb 2018 10:10:00 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: "git branch" issue in 2.16.1
From:   Jason Racey <jason@eluvio.com>
In-Reply-To: <5A7788B0-6250-4D1F-A86D-E3155C03EF0C@gmail.com>
Date:   Wed, 7 Feb 2018 10:09:59 -0800
Cc:     Stefan Beller <sbeller@google.com>, Todd Zullinger <tmz@pobox.com>,
        git <git@vger.kernel.org>, Paul Smith <paul@mad-scientist.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4F1475A5-DBD4-484A-9AB6-4DA57A8B8C7B@eluvio.com>
References: <2412A603-4382-4AF5-97D0-D16D5FAAFE28@eluvio.com>
 <20180206195754.GE1427@zaya.teonanacatl.net>
 <CAGZ79kaxf3qUyOe6R-LCgyLtwzrwhB=y767tk2qPbC_KR473ig@mail.gmail.com>
 <5A7788B0-6250-4D1F-A86D-E3155C03EF0C@gmail.com>
To:     Lars Schneider <larsxschneider@gmail.com>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lars,

Here=E2=80=99s what I=E2=80=99m certain of:

1. Just set up a new MacBook Pro at work. Git version 2.16.1 installed =
via Homebrew. =E2=80=9Cgit branch=E2=80=9D command always displays the =
list of branches in the less pager, regardless of number of branches or =
screen size. I=E2=80=99ve never seen this happen before.
2. Checked the =E2=80=9Cgit branch=E2=80=9D behavior on my personal =
MacBook Pro. Git version there is 2.16.0. Does not have this always =
paging behavior.
3. Ran "brew upgrade git" on personal MacBook Pro. Git upgraded to =
2.16.1.
4. Checked the =E2=80=9Cgit branch=E2=80=9D behavior on my personal =
MacBook Pro after version upgrade. Pager now always used regardless of =
number of branches or screen size. Oh no! Seems like there might be a =
bug in the new version, better email the git bug list in just to be =
safe.
5. Meanwhile research problem on Stack Overflow. Mitigated (though not =
really fixed) issue on both machines with this command: git config =
--global core.pager =E2=80=98=E2=80=99

Thanks!

- Jason


> On Feb 7, 2018, at 9:54 AM, Lars Schneider <larsxschneider@gmail.com> =
wrote:
>=20
>=20
>> On 06 Feb 2018, at 21:05, Stefan Beller <sbeller@google.com> wrote:
>>=20
>> On Tue, Feb 6, 2018 at 11:57 AM, Todd Zullinger <tmz@pobox.com> =
wrote:
>>> Hi Jason,
>>>=20
>>> Jason Racey wrote:
>>>> After upgrading git from 2.16.0 to 2.16.1 (via Homebrew -
>>>> I=E2=80=99m on macOS) I noticed that the =E2=80=9Cgit branch=E2=80=9D=
 command
>>>> appears to display the branch listing in something similar
>>>> to a vi editor - though not quite the same. I don=E2=80=99t know
>>>> the technical term for this state. You can=E2=80=99t actually edit
>>>> the output of the command, but you=E2=80=99re in a state where you
>>>> have to type =E2=80=9Cq=E2=80=9D to exit and then the list =
disappears.
>>>> It=E2=80=99s very inconvenient and it doesn=E2=80=99t seem like it =
was by
>>>> design. I=E2=80=99m using zsh in iTerm2 if that helps. Thanks.
>>>=20
>>> In 2.16.0 `git branch --list` is sent to a pager by default.
>>> (Without arguments, --list is the default, so this applies
>>> to `git branch`).
>>>=20
>>> You can set pager.branch to false to disable this in the
>>> config, or use git --no-pager branch to do so for a single
>>> invocation.
>>>=20
>>> I can't say why you're seeing this with 2.16.1 and not
>>> 2.16.0, but I'm not familiar with homebrew, so perhaps
>>> something didn't work as intended in 2.16.0.
>>>=20
>>=20
>> Maybe the number of branches changed since then?
>> As the pager only comes to life when the output fills
>> more than your screen. Quick workarounds:
>> * buy a bigger screen
>> * have fewer branches.
>=20
> Hmmm... there might be more to it. I just noticed the
> pager behavior on macOS, too. Consider this call:
>=20
> $ git diff --shortstat
>=20
> This should generate at most one line of output. On Linux
> the pager is never used. On macOS the pager is always used.
>=20
> I tried older versions of Git on macOS and experienced the
> same behavior.
>=20
> @Jason: That might be a bug on macOS. However, I am surprised
> you only noticed it after upgrading from 2.16.0 to 2.16.1.
> Do you recall anything else you've changed?
>=20
> - Lars
>=20

