Return-Path: <SRS0=UUNX=3P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D466C2D0DB
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 21:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3FD206F0
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 21:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="b4Znyxt3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgAZVbB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jan 2020 16:31:01 -0500
Received: from mout.gmx.net ([212.227.15.15]:38373 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgAZVbB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jan 2020 16:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580074254;
        bh=NNF1GSUPdUcdmUiasEaAw/sED8ztbbeamR7G0Hb+6R8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=b4Znyxt3BYRxDFArt2f1N8ZoCmwrwQPjP3Vez3ViGgpDn3xxDy6s45qNlgrPLWrKC
         EyXemcfhfwMfA4N9b/xIC1BjiJV9K/iff4PAWls32ZpGg0jo/ja0OIXYW1wDnsruDX
         4x8Y0WsKnIk8DThV+a5x6fITwtLbzaI0i90IHIzo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUosN-1j50SV0ADJ-00Qk3J; Sun, 26
 Jan 2020 22:30:54 +0100
Date:   Sun, 26 Jan 2020 22:30:54 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/23] SHA-256 test fixes, part 8
In-Reply-To: <20200126194233.GD4113372@camp.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2001262230420.46@tvgsbejvaqbjf.bet>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net> <nycvar.QRO.7.76.6.2001261120430.46@tvgsbejvaqbjf.bet> <20200126194233.GD4113372@camp.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wKUIPuO2LS+7uH9zx/15G3tP459K4o0pAD2CyQEBBqm7i3S5Ca5
 DMFmMK+IYNi2KlWuf5NZOBjptjfgK+8kvtwqDAEOpHpHEu2uCPjq/A6j684QTrUL9rSgcZX
 NnslcKZkli5tnVHp6558BCEMhZhgEFw9SmyBNj/7wLmhEJmTkh1iAypMm6nTQVoG3S8QfQb
 LZLZ4vzHJDh1l83xZbrJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DwdIbxEcUAM=:63L1NWtK8EfwNsnsAHq95v
 D6bf82kqF2W7xkqnY+hDe0wVljhIAj163bUlMaeXDQGz1K5halSyNYzegjnsuLiil3uTDLtMh
 IzGKYPb+wq2PbTD9gJ8QZ6xE+crMGnlaa1r1Yj7/OrgPM+9xJImyYO5WcYZU7gZ5TuWwcmZg1
 ap5VK1i51cJbW3ZwmgBmiuuSu5U2Og4waQG5ZKoEOh8VGwqdsb07AItVl6xmPCtJgpg9y6tbR
 IHQqf+WIvf7fzJ/Dia4cLdElWElPCL1fBxhyK+aYfulxk4Hj2MJqo4+ddAJOIecwdNrFKnzln
 hTQLu2taGZZPtpWMBwextVeO9Ct3qv8Y1eYxwIHtJePKUb79feOd2pnWeRfbKjP9RT1NxXt+I
 RUgLYwyeTaWldyWl2YxeMOZzulgTZsKkbGCJ88siqRldNN3ytyqbAY5W9ayxJ1JUmAysxoklL
 RO66HVgLfrGolZwkr+zVcBbbi5ZGv+IGC43OvHfWIPVVNMyPSjSLzf4IKq4tTr9FW2+Jz3SCQ
 gXgNWbr0oSx3Imk/0IadqTo3KRIOwAZthNlETKVhiAciRwEKxszg454WHW1z+cFIc6BgXi3h0
 G+VOMwCHY1z4wbRh9h4ai4cjQZA/EyvyxewlBRmUduoWw4UrpdKxZFQjK5s1D8r4aSzEYu+OZ
 PxtoA34gFtjZLdnC8e7dLtR9D6ZFI03MpcFqjWreJJe2RbaB6nMJlTwPX/QeEwG4IJj7gQ09v
 1O7lYwRxVRfOioD19X67ANXp4jipBPUqj/BFKcnG1gHAAPKLmJQAnwdkiaqS1531VuO+Pb6XL
 gYB857eOdGcPJ/MHdTOwOnK1O7/ONKL6nUrDDEnaghMlfKUjD7Llgg5Qa6oZnDf8FibTJzlhm
 2rUV/lR+KRpsOSUXolN6czlyaA94fwJTg3yC0woxLhKGgmxRh3Z2wDjeMW2X2l8E5+8lq0MPf
 Mv6D/3zYsvP6lnszi1VyHHT0P5ZT9k4cZnrchlE0OCumFw87QtR8Zs7vZcb7gfWUd0SJnhcn8
 DNnH1W0kLQqvQcbsz9D2o9Iy8QAb0WU7dZbVT3o2DL+f8b8rZgv7o4ctCyyEb4ozGj53Xof3E
 LYanaf5Ifc5oyJvZiV6dl0xUk5b6bAD7olVcKAoiXJgR3BbArO1Ot1H/dDW6W1NMwNMBy+1FI
 aauRGCTJ4M4vMJg5uEIgAebLIRLcvUcEmt0wq02PAa/HKs069UBygwKf1kogitOe/WneUnqpZ
 VTafU/Mc7NSYPv0JV
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Sun, 26 Jan 2020, brian m. carlson wrote:

> On 2020-01-26 at 10:25:31, Johannes Schindelin wrote:
> > Hi brian,
> >
> > On Sat, 25 Jan 2020, brian m. carlson wrote:
> >
> > > This is the second-to-last series of test fixes for SHA-256.
> > >
> > > As mentioned previously, the patch for t3305 seems to indicate a bug=
 in
> > > the notes code and I'm not familiar enough with that code to apply a
> > > fix.  This is a band-aid to get it working with SHA-256, but any
> > > comments on a more robust approach would of course be welcome.
> > >
> > > Changes from v1:
> > > * Drop patch for t3404 in favor of Dscho's fix.
> > > * Drop patch for t5616 in favor of Jonathan Tan's fix.
> > > * Add missing sign-off.
> > > * Move test_oid_init into the correct patch.
> >
> > Would you terribly mind pushing up your local branch to a public place=
? I
> > used the apply-from-public-inbox.sh script I maintain at
> > https://github.com/git-for-windows/build-extra to apply your patch ser=
ies
> > on top of v2.25.0, but I got this:
> >
> > 	Applying: t5607: make hash size independent
> > 	Using index info to reconstruct a base tree...
> > 	M       t/t5607-clone-bundle.sh
> > 	Falling back to patching base and 3-way merge...
> > 	No changes -- Patch already applied.
> >
> > (I want to have a look at the notes fanout. Will keep you posted on my
> > investigation there.)
>
> The branch is test-fixes-part8 on https://github.com/bk2204/git.git.
> It's currently based off master.

Thank you!
Dscho
