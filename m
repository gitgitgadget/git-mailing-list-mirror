Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40897C3A5A7
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 07:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiLFHsu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 02:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiLFHss (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 02:48:48 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF2C12634
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 23:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1670312901; bh=zoLSjFYMObSOb5JHXmdut2NFY8O1Vv306hUJODiRcnk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=rdYwKOAKGZ9aX8GtnLp6w7UIcAMLLYdF6cEv9dr4YYC+mOW1oubvD5Pf9XPoYXej9
         hA/g5ggBFgHLfZypS+YdskeJIRBNVGtTlSCgYj66Myx6TmxCTADZjFEKqJgpfKuxBP
         NoVdKJq4UNwYGNFl3XYUfevAhULuysezKzJ1nwTmpYnJIalZo/rcQBeMgYGlRZcSYp
         hPx7y5tlsypDaA0TFjYjHZuK8vxTAJxLFSWjM3/PzlYbUyuTCyzDaGbFBa1f75ww5e
         jtRpEVlDPobT00t4rjRi0PMzMcRAXeC91CvGL3/Hr0dD8tWx4Hajh0Wz65JTjJo//N
         +YnnqNampGBRw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.24.155.134] ([89.1.213.44]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3KPg-1osrvr0CJO-010IED; Tue, 06
 Dec 2022 08:48:21 +0100
Date:   Tue, 6 Dec 2022 08:48:18 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>,
        Pratyush Yadav <me@yadavpratyush.com>
cc:     Paul Smith <psmith@gnu.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] Makefiles: change search through $(MAKEFLAGS)
 for GNU make 4.4
In-Reply-To: <xmqqpmd4ulnj.fsf@gitster.g>
Message-ID: <1rq7o244-pos8-rp21-1q49-3210454n89nr@tzk.qr>
References: <cover-v2-0.4-00000000000-20221129T140159Z-avarab@gmail.com>        <cover-v3-0.1-00000000000-20221130T081835Z-avarab@gmail.com>        <patch-v3-1.1-432518b2dd7-20221130T081835Z-avarab@gmail.com>        <006f10e84c9108a7be7315fec753316ca743386c.camel@gnu.org>
 <xmqqpmd4ulnj.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1742479060-1670312900=:3015"
X-Provags-ID: V03:K1:bjRJ1O3s9pMLwx5D9RZWyx2kK9aHm+rNw0+G4eMCNvF+lJDieTO
 w8CpWo/f6246eT90m8ASXwaU3XRCpgkydineJvA4tcZKc/B0KhBNr5/Cvz3Unz78Y23L+6a
 VCBk0bd+O0zEQl9IJp+LuHUBCDbvwSV/EEZlXMudhmfFGKdLx5yVMA9J3yYfGnvwzM9qesN
 VnxZ/vnjOAyAYuHMXyliw==
UI-OutboundReport: notjunk:1;M01:P0:LSxcg+Yp38E=;W0+1zUz561HJDNLb5AOtD0cLlya
 AaMcHd1RRSt8GBQkzjSiVCNrkAIN5S7680P2MDdnmGNjcTTzT0tF2BltYdFOlyn6f0dlf/byF
 w1L6or+00qRhcueTZHT79j7kuh1IQn15hMgkjCDLHItD+HU529ti/e2LN0vsYtcIocsmc1omx
 v07NaNL2s90h2UJokZt5XGIYbR4eGJYgStzK+NsyIHZbeRrftV0aTRHE2YxeGvMDm9D+qzd5k
 Gn6YvfklR0N/uTfe3VxNwnIezOu2HUzPL0/phXUdX4g/rv9CUyJXhv68DOgzxB66pAgZfyrLS
 3etAWpix+4qyzVKIdNQedM6guEaoSwN7ttBx5WOcIKI1i63SmknOdW3wOFZVPdWGbqsiXWlrY
 tnJljxnIp1ipLf/Wpe7dGaH7ioUj08lp2MLspmQsj6cPYLVADv995hsLaU6e9BnIpogHLUq6S
 I45uxJYD6fPPEVCRz4YQDwvSIp9DRUBxgohTGNnVZTk/XmFwVuklOIa5HeZCdsuVb0WTMTdtd
 33kHRGb/i88V9LoYMAm+TZaf9KBvqY9BHvd/qnD7ECaCVgyoAAJSY0qTB9vMZHZkkNrWMOVPd
 Rg2yxsi7bmWGC8CjR03yNAphzS9Zyq1D9oGzaJR9st+oKINlm6fGT999ooC3oec7lPKJoHlC8
 nV2S5Vt3hDacQA2uncE6mcc9A3ivhj6dGZ8ugJeFbHNEVazWLXT8OLszgxcwtgsZcTJFQ2ZwT
 i5YpZQFrWZDf/S/9sIjxQmJdPY5inhdvDuTRnKuWqmR2TOBGuY6vmkkxF+kqGwvBS4VSLj3tt
 ASGDbQccJEfIWeppsDDth1dIc1vu2pol63xxbyCFMx6e1gBiGaMODRok1ybKny6m75PEvOdAa
 UaFNNOUiTezVzkfkCiANOR4BZdUo4BFyIIkcOmqlp74I1xCl9cEwq1/LPBJKrazznq1bfQB5S
 KWMhQiCQNIDe0tCX0dsc4WDyjzU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1742479060-1670312900=:3015
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Thu, 1 Dec 2022, Junio C Hamano wrote:

> Paul Smith <psmith@gnu.org> writes:
>
> > On Wed, 2022-11-30 at 09:23 +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son wrote:
> >> Since GNU make 4.4 the semantics of the $(MAKEFLAGS) variable has
> >> changed in a backward-incompatible way, as its "NEWS" file notes:
> >
> > Hrm.  I did try to look through the other makefiles to find similar
> > constructs and get them all, but apparently my grep fu was
> > insufficient.  Bother.
> >
> > Thanks.
>
> Thanks, both.  Will queue.

I noticed that this patch also touches Git GUI, a change which technically
should have come in via https://github.com/prati0100/git-gui, not directly
via git/git.

So let's make Pratyush [Cc:ed] aware of this change.

We probably want to avoid applying Git GUI changes directly to git/git in
the future. In the meantime, because I know that Pratyush is busy, I
opened https://github.com/prati0100/git-gui/pull/83 with a (partial)
backport of this patch.

The following command demonstrates that this change is the only divergence
that would need backporting into Git GUI (the first SHA is the current tip
of git/git's `main` and the second SHA is the latest git-gui tip that was
merged into git/git):

	git diff 2e71cbbddd6:git-gui df4f9e28f64:

For the record, there is one change in git-gui's main branch that has not
yet made it into git/git [*1*], but it merely appends a full stop
character to the end of a sentence in the `README.md` file, therefore
there is probably no urgency in pulling git-gui into git any time soon.
That typo fix waited over a year to make it into git/git, it can easily
wait some more.

Ciao,
Johannes

Footnote *1*: https://github.com/prati0100/git-gui/commit/8cf36407cab

--8323328-1742479060-1670312900=:3015--
