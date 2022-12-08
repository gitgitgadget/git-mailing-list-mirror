Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A117C4332F
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 12:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiLHMER (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 07:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiLHMER (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 07:04:17 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E95085669
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 04:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1670501052; bh=vrfaUKWRM/xNWao5r3dpMlYG/jsMcr5St4RvyVWsMBg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LAieANdoSaJ2eunRn2CB42CUhcE/m4RtX9bP95aOuUZ622WLlR1aSvKpipxC4HXuu
         BltXEx78HMOt7phmSBjjEj4p8cR9CR7k8ARMnuzKEZHRjuhB6PBGhhx3YPMWi0HW8O
         Wlglw9gB0Oio2FkXsun4AlA1B/HHfAGRSOvvlcr2q7mG8oj3Ag48G7TJ4gS6Io6qJE
         uQrMQR/++uH+RRLCCGL6Hmy7aQs1dwGloTO3In4fZxtkZwwtVcO6kXKyeSXcGZwKvV
         nplNsoTQdRYnybmNwtMW6j4FSwznQRuL3/5RhI/RvGXS+jJVSVDqCcF/L1WlXctjCg
         RVulc44g0vNRg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.24.155.134] ([46.114.106.61]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdNY2-1oTuoe2L9E-00ZQJz; Thu, 08
 Dec 2022 13:04:12 +0100
Date:   Thu, 8 Dec 2022 13:04:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] t1509: facilitate repeated script invocations
In-Reply-To: <CAPig+cSfvgu8XjvmmAkFWe1G1VDRgrcx5GjUhr4xSDqoJ4cZOA@mail.gmail.com>
Message-ID: <n2586428-1r80-9s29-8345-7p2opnor5086@tzk.qr>
References: <pull.1425.git.1668999621.gitgitgadget@gmail.com> <97ada2a1202190776ce3989d3841dd47e2702316.1668999621.git.gitgitgadget@gmail.com> <221206.86ilipckms.gmgdl@evledraar.gmail.com>
 <CAPig+cSfvgu8XjvmmAkFWe1G1VDRgrcx5GjUhr4xSDqoJ4cZOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1993232286-1670501052=:3015"
X-Provags-ID: V03:K1:UhWBgyS0v/AJoNC5Dn8I1GGS+tCv2tljdJGHnHk/nFdzfEydj9I
 eLAvJHD9vZ1Yu6+oN/LvaIRrzqf4cnmYVycQnPV4ljvuIP46ymRfRCujRyTxqT/D43PU0uP
 a8xWj73bmYgYgaNZwFhbaH+gzibi3f7JN+oka/8L7mTGY3yQ5IGF2P46VLmf61vvb4sKA0/
 vIkxpbc+6tPVTxkNz0SVQ==
UI-OutboundReport: notjunk:1;M01:P0:LHKXV5n0/yM=;aTAnXk7h9flXYpSisHy6TggV5qt
 s9wOP4DJBUzk0ElQuIckFM5/W66ofpoUofxObGGqttTzPdxugw49tfBEYWdQPgwmUU0pOvXjS
 W4UQthP8cdSoT6z5WNXEC3f4ZJTxElyP7Siuo7UOakTq2rk1amFvqgGsHQ83i07F02ocfQvWe
 fqhMlXuPwRCof+pF1ByrHXHms2RXWojyUUE5dyMB/HfSWLzu0pesvdX537ehb8KfyxBZjufq7
 eCw3vaL2ulsnMRcGlLNjijsP+inmq0LGnJVW768s9iUv3YUtjSPU69agoFBviZCJu7YBmIolx
 Vk51cO7rFeZm5WNdM2SzSRPixHIyqhYPuyi0nDLwgz21Tfump1EPAgDatAwEaS8De1nFzz1Rm
 tRSBZpPDSuMV9rIDpMZFBLZ94Goyyn62nY9T4N1AESQ0FI23UCsPHvWXv8GNwqMqChBPfPYCh
 XS/YyZOXz0Moz8BTXKW9VGrqvniuYu2/012I+BOrXNjE8d0b2Vl1fkVbVRICmLIO03PKSU3s/
 mFXvz1dHbArFb0OxYcF5/PQZ+HRUSPE//hRa/i3kxvGdpq5p9wUuf1AS8lN2ZrN6Ik95XvdpG
 Exo8Ja/YTgBKQHe2RvAg5XnX87x9kbfjMHxklDGNo0cfn1LsCsxvqSxlvtAoiwi2ZJkvV3Pcg
 ceOUGlnzqG8wSTKnP6rjrhPi+gfv18dbjH2iSrWTrIxQSFT0ntj3G2z0AHMHiwAzD4vhqogfs
 Grcn8GsyVpIH2C2sqdDr6p4QsxBWvfIQ8QEAz+JMFb87Ia2JaOeWP+UWgroR5hSI/j4b0MFj+
 cYb23xjzGUFlX11CeQhVDc8nvZNSzBkbn22Pb/uYJwuaY3unbzZVW4sBxHRHkpdhcscRK+tO5
 ReMgkPo8Q6ovItxLVz525EmHH/doYyse3sNHXtkYgJ3nzfkudaRXn2ChNtaCqDoWqNqds+z3v
 KTRgtzkVHYcYpkJBR6efC6KzFyw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1993232286-1670501052=:3015
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 5 Dec 2022, Eric Sunshine wrote:

> On Mon, Dec 5, 2022 at 9:48 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> > On Mon, Nov 21 2022, Eric Sunshine via GitGitGadget wrote:
> > > t1509-root-work-tree.sh, which tests behavior of a Git repository
> > > located at the root `/` directory, refuses to run if it detects the
> > > presence of an existing repository at `/`. This safeguard ensures th=
at
> > > it won't clobber a legitimate repository at that location. However,
> > > because t1509 does a poor job of cleaning up after itself, it runs a=
foul
> > > of its own safety check on subsequent runs, which makes it painful t=
o
> > > run the script repeatedly since each run requires manual cleanup of
> > > detritus from the previous run.
> > >
> > > Address this shortcoming by making t1509 clean up after itself as it=
s
> > > last action. This is safe since the script can only make it to this
> > > cleanup action if it did not find a legitimate repository at `/` in =
the
> > > first place, so the resources cleaned up here can only have been cre=
ated
> > > by the script itself.

Makes sense.

> > This is an existing wart, but I also wondered why the "expected",
> > "result" etc. was needed. Either we could make the tests creating thos=
e
> > do a "test_when_finished" removal of it, or better yet just create tho=
se
> > in the trash directory.

An even better suggestion would be to use `test_atexit`, of course.

Ciao,
Johannes

--8323328-1993232286-1670501052=:3015--
