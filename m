Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA7F1095F
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="jqjey0IB"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88561BE4
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 04:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1699446314; x=1700051114; i=johannes.schindelin@gmx.de;
	bh=r6RYQGvzu8X/gOENRa+E7ZyJETOOPIKhv6rSbm4xEHw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=jqjey0IBus+Tu5loHe1kcm5M2vsaStASLmTuXZGIr8lQhkTANf9yZMyohPPgc6K9
	 iNhpdPoEXdj9U4K2/jgnm5V3e6AE7lIs+YWMjjdeZ53mfEmISFC74Ss3jUWD9Posy
	 Kq0xD4TJn+olRPVOwLf58KCRGrqMyiXUN0Ok5YXpUk7gCB5v+6P6D10avZ2yQqall
	 d9pVtuM7ocUjlCIXjIiOBjANz0oWjyNPKV+uFaFt3O6bodakvXGkSAUIjx1ib7pqB
	 +EoeyE2xKMLIb9LF6SPaI0XWFyL52Rg4IMxujBXKHM206eBWsExQTewjjybzcZUhQ
	 YSoe2nZtNyOmnLSGPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.49]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mnaof-1rjcoJ2i4D-00jZER; Wed, 08
 Nov 2023 13:25:14 +0100
Date: Wed, 8 Nov 2023 13:25:13 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <christian.couder@gmail.com>
cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org, 
    Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
    John Cai <johncai86@gmail.com>, Derrick Stolee <stolee@gmail.com>, 
    Phillip Wood <phillip.wood123@gmail.com>, 
    Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>, 
    Dragan Simic <dsimic@manjaro.org>, Linus Arver <linusa@google.com>
Subject: Re: [PATCH v5 00/14] Introduce new `git replay` command
In-Reply-To: <CAP8UFD04PbOLgep3-s-_4_fMbqtrWMR87K1cG-DsKnbyHEBT_w@mail.gmail.com>
Message-ID: <cdb9e449-8c60-b21e-bcd3-0944d2b744b5@gmx.de>
References: <20230907092521.733746-1-christian.couder@gmail.com> <20231010123847.2777056-1-christian.couder@gmail.com> <bd872b81-80a9-5e4e-dcb6-faebc9671848@gmx.de> <CABPp-BFrVfGHOrBk7g=4TkGxDv=oSqF1FOkhp6WVbxUV-2yveQ@mail.gmail.com>
 <CAP8UFD04PbOLgep3-s-_4_fMbqtrWMR87K1cG-DsKnbyHEBT_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-326024308-1699446314=:511"
X-Provags-ID: V03:K1:UT630hiMJajaqb1xXjfH9X/BqFjd+c2nE0jottR7Dvx+5Np9FrU
 c5gGx5SlPRjW1paJTvn2wvISSMVmjCDFAOYJwk7Wka6shkkra0EjIKtdpJ/SG6Raj1lmPXS
 NuVY0JdujSFoTT3ijezT5yqmkdmhp4rcsdH3YwvINg7BjjGaAMFYp+QvS+CUr/1sGY6cNCr
 qBb04Q/EmZ6hYyZtHa5jA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:U0PG4vHVw/Q=;H/M82/WGOirQbSHUL4jcXRyhuqW
 IVFA8WO5JIAoEmBCL3S7UAr/QwPJfFoDBPQMecQglcOdeP0cjsZQSp4U0C+JB8Sjh7XBtYrnx
 HImIEv1duDYyvFLNRgTwqYcb9K5CIeXFqFgRxgq9YY8zZd0x/QNFwv+8VJmgZPlx++pWMl609
 dDeUye2oN9qUvVOTZoL4WrwqfiKmY2MG2bjsKTyzEyJtaWx6WqTa7v5+SDuUf04OV7KkwKnk0
 MWejVbzX3OWxGED4nES8KMqOKuf3sDcmFqdazRk0yzrNFQ4w4P0psWpZGzxy9K2PtCUOW2+W9
 uHOTvtOniYLNVpYINuAag/vBJzHpIBVq6ttQ6S5KmRPNmNSZbEczV1JeXQ+IN5qP9gb8SFdVT
 87R5dVV8AT4FFWsqnyDjeiUjcqWP/xjVsSXa5uYb0l0FgzxqkXwOEQBxSCUudgH2uRDC0XYxP
 y7Iaq1aZKGGNnTfcNW4MSeLvK0jYJ/rwmCpRzWaQXob35L3+3JBnS5o50d94D7va9BTUnE0iW
 UeEwCRHStB2bg4Z43Stdzvy1X+T4kldHu4D2lhvFwANRtb8WQ9fplo5KkhYUF0IMX06uiG8/e
 nRwHNa8Hhvzy1hW32xEm2d99/YnFbgmVzscu7K5+Why4mNbPsADCObYtOvkYIf3RZ7b5VX2+W
 alTH2w+9ZzN/aLv4oZ+h1TF/bUiJFkAOHZNwcsNhzs70aLdS8hU6DXoxMy3o2+lbJCLx04CvL
 iyMQo80tXs5xCqSpCT4N2AZyJCQSUxIOTs9ogo7u8RMbRClQHWQtrdcUh7JJNK/weTokw61V4
 ljaWEVVO59XeFw8tTElY1yHPihVUy7v37JPd+e9OcnmC/+tDnytM+cnoSzqIc3PZfF34QOr3S
 lD9GmKBXAalbiilJC1mNSq4Yx4Z4PoRo94ek7u1K8wGtP7cDA0GHbJshvLrXj3mq1F0wGmsS9
 78Axuw==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-326024308-1699446314=:511
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Thu, 2 Nov 2023, Christian Couder wrote:

> On Sun, Oct 29, 2023 at 7:02=E2=80=AFAM Elijah Newren <newren@gmail.com>=
 wrote:
>
> > On Thu, Oct 26, 2023 at 6:44=E2=80=AFAM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > As mentioned in
> > > https://lore.kernel.org/git/03460733-0219-c648-5757-db1958f8042e@gmx=
.de/,
> > > I would like the `EXPERIMENTAL` label to be shown prominently here.
> > > Probably not only the `SYNOPSIS` as I had originally suggested but
> > > also in the `NAME`.
>
> Ok, I have made changes in the v6 I just sent, so that there is
> EXPERIMENTAL both in the NAME and SYNOPSIS.
>
> > > Otherwise we may end up with the same situation as with the (from my
> > > perspective, failed) `git switch`/`git restore` experiment, where we
> > > wanted to explore a better user experience than the overloaded `git
> > > checkout` command, only to now be stuck with having to maintain
> > > backward-compatibility for `git switch`/`git restore` command-line o=
ptions
> > > that were not meant to be set in stone but to be iterated on, instea=
d. A
> > > real-life demonstration of [Hyrum's Law](hyrumslaw.com/), if you lik=
e. Or,
> > > from a different angle, we re-enacted https://xkcd.com/927/ in a way=
.
>
> Nit: Hyrum's Law says:
>
> "With a sufficient number of users of an API,
> it does not matter what you promise in the contract:
> all observable behaviors of your system
> will be depended on by somebody."
>
> The doc is part of the contract, which according to this law doesn't
> matter. So I don't see why you use this law to suggest a doc change.

You're right. In addition to the documentation (where we definitely need
to state the experimental nature of the command), we may want to consider
adding the `EXPERIMENTAL` label not only to the output of `git replay -h`,
but show also a warning for every `git replay` invocation cautioning users
against depending on the current command-line options of this command.

Ciao,
Johannes

--8323328-326024308-1699446314=:511--
