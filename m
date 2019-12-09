Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87151C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 19:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49EA5206E0
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 19:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DZRozYOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfLITj3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:39:29 -0500
Received: from mout.gmx.net ([212.227.15.18]:42875 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbfLITj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 14:39:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575920356;
        bh=jHojRAdSgx3+tmeZPbgHhi5bvBtm38P0VuXHEvVqCfs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DZRozYOFH+Sa/STybizR0z35zvv07iEx0dIJi2maBEuETCnYtKhB1SfXkJU2b9xD0
         /aKbjM6dssT/P7SkfD5/JNjXV+BYb+NNMK7Od7mHoqu/hqp3aQYasl17lF7Kp7ZYzx
         iux8w3Uw6UuNZii+UN0UusYgThJlS2CbGQTkuO6A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mkpav-1hsfRz1EQp-00mMu9; Mon, 09
 Dec 2019 20:39:16 +0100
Date:   Mon, 9 Dec 2019 20:38:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Marc Balmer <marc@msys.ch>
cc:     "Strain, Roger L." <roger.strain@swri.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "ns@nadavsinai.com" <ns@nadavsinai.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>
Subject: Re: Regression in git-subtree.sh, introduced in 2.20.1, after
 315a84f9aa0e2e629b0680068646b0032518ebed
In-Reply-To: <7E95BE86-BD96-482F-9ECA-DBDD9C10D114@msys.ch>
Message-ID: <nycvar.QRO.7.76.6.1912092037540.31080@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1912091615200.31080@tvgsbejvaqbjf.bet> <7E95BE86-BD96-482F-9ECA-DBDD9C10D114@msys.ch>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1762787545-1575920355=:31080"
X-Provags-ID: V03:K1:KHsc1Z7Jz6G60BoxSHngRjER5qcjxZBhScX8MzLulgulRLeQXWu
 J3G20yP7Limu/2hkTHFXo9mQJdzteH+Z7wDIP19ef+xMPPCh8guYPfHbgEIiUPbG7AECjF2
 okJfMjTthsYGpvkQ4vjP9rHSr++MdQ2bOj44KZpBiOdHgJnAvT0fBfZwXkxmtuu4uemXghh
 EhdfWFQHtV1JgGYvPvHDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jGyz54l/iP8=:oQj99xOw3zp0TPPm73WsCY
 2n3dXuCdkxAMEy/eGw9rWYzhl/Q+JAGal29ltGZMRjKuR6jcwuRBVByQOuAwQj85zGInFvDOC
 I/oaHVrwyC0fuzGcT3zgN31a6Qn7qFjD4GINIbsTxtUXd/duQEXC3m/NVp5OEYzuY3HON32rI
 D5IatFUFrDsB7TzO7dOD4qumyL44NmSVZ0cgytKqmGfyVGBmzTPsEq/ZctWn+hKH+j7a/KT5V
 uf01B864vuhuvHcf4jIKRvNgZ0XzXyKQ8/NZofyrEuJVlaxjASE4Mmq1Hhs26c7rfvH0nIkks
 46cnqdtAf0KkQU5oCK8Aj7kx/VO9Ec4uhZGsbt9ZtpfKyKcYDlnPMgjX5+uw1LqBMcVmA6sjM
 LI6cPvf8KkEi8HWr65eZphLYwLjSoGkqLznqR6UTxGzzZ7YAyOSt2cQdholv4/LANOMAIrPz7
 JF0QYhQnd8MuTGcizriLicthIC5SeuYyjfS1IPcYKYy2DoXd68I6/jf7zx486vuwPfEUquHfi
 TAF84ytV3xapIKQenbUofa+eHaJaUKymlr/Ch79uDc8BR5+jxMfAyP6oAy/D+PiaHv8W05ajY
 8egt1F5camN4a1+1X3SK5pHvdblXhbzUkm+GuXjXyamFxfsDrK11spAjUL2SYyiyEkzB9Hn7k
 XidkXbcaKScZ/KkWUabx1PWT711pqF9kj5Tf+0kjJBTgKX3iUmBxIbilMJODzDneFzRZYRcTJ
 +j/IJzcmnyCSgt8nJ4mFHoD6K7/iGdJyfyOxQUX2LqrnezHyAnmo+2TLMOy3O3JdE0rv4/B3r
 6NjLK0rrLGskPh9eMW2mr7VAXvs6OAdCed5OMSxHLG+N1yWS6qr2uohZYSoH4uayKb/n2x0IH
 jk755MhIgzbdcOna5Y9bAKP/FkUM1ubpO/MrtzqNNPep7RlAFub29DjAZIFBmEYtDir4hXRyK
 PsFpA3Z/Z0MWSAyczGjuRAlFV0nH+8yX97dz/0OnJ4vJaE7dIUHWr/L9EELWQyfBAcAOYv7zR
 yhrtJUm8biFpQ07/fPJpMKUQvrr6Ut3jixZlsNTTD57mzfq0X2pWlEerQ8oXTx0MMmKvFTP2G
 evuYvVsYm5/Eef4sndW1rn+5MIvG367AVTXVCaT+fRXQP52+5BGHtOwLmBAyoPbbJoEPP50NE
 x+IvfV5imk5UjMKqTy1hN/J0eIOSNOWbm/q5M493bOlWQgkl8D0FZGBw2RrXbkzT1zZ9A/otV
 ZuaQM3qykY1rCx5mDHYzO0/IMF6/lSRbC55IAsTfhVJiwjqxetc4MEZqdHV4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1762787545-1575920355=:31080
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Marc,

On Mon, 9 Dec 2019, Marc Balmer wrote:

> Fwiw, I see the problem on Linux.

Okay, I must have overlooked that piece of information.

> It hay nothing to do with overzealos antimalware, it is a regression and
> it has been well documented.

Is there a minimal, complete and verifiable example that other developers
could use to analyze the bug?

Ciao,
Johannes

>
>
> > Am 09.12.2019 um 17:20 schrieb Johannes Schindelin <Johannes.Schindeli=
n@gmx.de>:
> >
> > =EF=BB=BFHi,
> >
> >> On Mon, 9 Dec 2019, Marc Balmer wrote:
> >>
> >> I am not familiar with the source code, so I can not send in that
> >> revert.  I can, however, say that I am grateful to whomever does it ;=
)
> >
> > I am against reverting the change without knowing the root cause.
> >
> > The recent reporter only compared Git for Windows v2.19.0 vs v2.20.1,
> > which is _quite_ a big difference.
> >
> > For what I know, the problem might be a change in the MSYS2 runtime th=
at
> > is mistaken by some malware for malicious code (we did introduce some =
code
> > to emulate Ctrl+C in MinTTY which injects a remote thread and executes
> > ExitProcess() there, which might very well be construed as an attack, =
even
> > if it is actually very much desired behavior).
> >
> > These segmentation faults in `git subtree` on Windows have traditional=
ly
> > been _all_ because of overzealous anti-malware.
> >
> > So first, a much more fine-grained analysis would be required, e.g.
> > comparing v2.20.1 against v2.20.0, then copying _just_ the `git-subtre=
e`
> > file from a working into a non-working version (or vice versa; I would
> > highly recommend using the portable versions for such side-by side
> > comparison).
> >
> > Ciao,
> > Johannes
> >
> >>
> >> - Marc
> >>
> >>
> >>>> Am 09.12.2019 um 15:18 schrieb Strain, Roger L. <roger.strain@swri.=
org>:
> >>>
> >>> As I said, I'm using a custom script here. I don't know if anybody e=
lse
> >>> benefited from the change and hasn't said anything, but I won't obje=
ct
> >>> to someone submitting that revert.
> >>>
> >>> --
> >>> Roger
> >>>
> >>> -----Original Message-----
> >>> From: Marc Balmer <marc@msys.ch>
> >>> To: "Strain, Roger L." <roger.strain@swri.org>
> >>> Cc: ns@nadavsinai.com <ns@nadavsinai.com>, git@vger.kernel.org <
> >>> git@vger.kernel.org>, Johannes.Schindelin@gmx.de <
> >>> Johannes.Schindelin@gmx.de>, gitster@pobox.com <gitster@pobox.com>,
> >>> pclouds@gmail.com <pclouds@gmail.com>
> >>> Subject: Re: Regression in git-subtree.sh, introduced in 2.20.1, aft=
er
> >>> 315a84f9aa0e2e629b0680068646b0032518ebed
> >>> Date: Mon, 09 Dec 2019 15:13:47 +0100
> >>>
> >>> Roger,
> >>>
> >>> I am all for reverting it. if that does not cause any other regressi=
ons
> >>> or headaches (or both...)
> >>>
> >>> - Marc
> >>>
> >>>
> >>>
> >>> Am 09.12.2019 um 15:11 schrieb Strain, Roger L. <roger.strain@swri.o=
rg>
> >>> :
> >>>
> >>> I haven't been able to find anything relating to the issue, but I al=
so
> >>> haven't had a repo that exposes the problem to test more thoroughly
> >>> against. If this happens to be a public repo somewhere, I'd be more
> >>> than happy to take a second look.
> >>>
> >>> That being said, if the community feels it would be better to revert
> >>> the changes that were introduced, I won't object. I've had to furthe=
r
> >>> customize the script for our internal use, and those changes aren't
> >>> something that would be useful for the public at large. (A few chang=
es
> >>> relate to the presence/absence of a specific file, which I certainly
> >>> wouldn't expect anyone else to have.) Short story is we're going to
> >>> have to use a custom script going forward, so keeping or reverting t=
he
> >>> changes here make no difference to us. I still feel that the changes
> >>> which were made make the script more correct, but clearly there's so=
me
> >>> undiagnosed logic error somewhere.
> >>>
> >>> Honestly, I'm surprised we didn't see this particular issue show up =
on
> >>> our own repo; it's ridiculously large and complex. At least if it ha=
d,
> >>> I'd be able to troubleshoot it more reliably.
> >>>
> >>> --
> >>> Roger Strain
> >>>
> >>> -----Original Message-----
> >>> From: Nadav SInai <ns@nadavsinai.com>
> >>> To: roger.strain@swri.org
> >>> Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.c=
om,
> >>> marc@msys.ch, pclouds@gmail.com
> >>> Subject: RE: Regression in git-subtree.sh, introduced in 2.20.1, aft=
er
> >>> 315a84f9aa0e2e629b0680068646b0032518ebed
> >>> Date: Sun, 08 Dec 2019 12:30:48 +0200
> >>>
> >>> [EXTERNAL EMAIL]
> >>>
> >>> Hi, I'm curious if any of you had any luck in preventing that
> >>> seg-fault in git-subtree script
> >>> I'm encountering it myself using git 2.24.0.windows.2., seg-fault is
> >>> in the same while loop (currently on line 757)
> >>> When I tried your suggestion of adding the ($parents) ($rev) to the
> >>> progress print I see that the last commit have only one revision
> >>> printed
> >>> like this:
> >>>
> >>> 259/290 (523) [271] (843dd34090d36dfabd6a2e3e8459a4887427313b)
> >>> (a69ee056f66acf66c63f89f55d26c0cc17036623)
> >>> 259/290 (525) [273] (f5eea1a3cbe1e16acba53e8a9fe07b6525a8b97c)
> >>> (843dd34090d36dfabd6a2e3e8459a4887427313b)
> >>> 259/290 (527) [275] (82303752a428cf1d789ac9f156008adb2798b7b5)
> >>> (f5eea1a3cbe1e16acba53e8a9fe07b6525a8b97c)
> >>> 259/290 (528) [276]
> >>> (7187897883c9fb4d33d4c87a02b876f8603728ff05f0945ae2ce9f98a35135)
> >>> 259/290 (529) [277]
> >>> (a00a3665343439a426671958dd90ed0407a22cad9ac9f156008adb2798b7b5)
> >>> 259/290 (530) [278]
> >>> (90beb94ebd331c457d79d05341453f5829a50bfcd4c87a02b876f8603728ff)
> >>> 259/290 (531) [279]
> >>> (9582e0acbed1910173564e250f350b5cc4291a7f671958dd90ed0407a22cad)
> >>> 259/290 (532) [280]
> >>> (f183930d6fabd3dccdddc5ec35d754ad28caf3b879d05341453f5829a50bfc)
> >>> 259/290 (533) [281]
> >>> (c9309f3a38c41f7991d9e78ddb47f7e85b8521eb564e250f350b5cc4291a7f)
> >>> 259/290 (534) [282]
> >>> (3bcf08f63a0e2b93ecc376bd679a16c80e99e7b1ddc5ec35d754ad28caf3b8)
> >>> 259/290 (535) [283]
> >>> (134621bb55a0470cdf6519ce08d6909af43ce0e5d9e78ddb47f7e85b8521eb)
> >>> 259/290 (536) [284]
> >>> (edb3471fbba29748f9784d29b3cee1dee2df4b37c376bd679a16c80e99e7b1)
> >>> 259/290 (537) [285]
> >>> (dd947a095df07a32dfd56666a395a7c42b25ca116519ce08d6909af43ce0e5)
> >>> 259/290 (538) [286]
> >>> (a639e09d2cbe1ea1149c080c1c95b8b018340ae2784d29b3cee1dee2df4b37)
> >>> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 757:
> >>> 8853 Done                    eval "$grl"
> >>>    8854 Segmentation fault      (core dumped) | while read rev
> >>> parents; do
> >>>  process_split_commit "$rev" "$parents" 0;
> >>> done
> >>>
> >>> I downgraded git to 2.19.0-windows.1 and it works now.
> >>>
> >>>
> >>> I'm thankful for your insights
> >>> Nadav Sinai
> >>> Web Tech lead
> >>> Philips-Algotec
> >>>
> >>>
> >>>
> >>>
> >>>
> >>
> >>
>
>

--8323328-1762787545-1575920355=:31080--
