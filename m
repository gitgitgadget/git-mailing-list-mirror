Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1415BC3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 14:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAE520848
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 14:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ZMvaf39B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgCCOIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:08:16 -0500
Received: from mout.gmx.net ([212.227.17.21]:37875 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729134AbgCCOIP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 09:08:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583244489;
        bh=/O6Cmo3KUDmP7NQjdEuPvhw9bAWmUiLLAeyuVX0Z7kk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZMvaf39B3AYG/FxptEWN585F5Otaxd3zYpDMUjoEKLFmgwGjBx1ts+rW73VaQx6RD
         segpu1EPTipt6U5LNqyqXXqOTrsDcFp+K0mdzjXtndwZV/4SSKNRNV0C8LQmqXjwj6
         yfNG0O6hqUycqSBZO83X/15f5aGC09YEybrCj+/c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.213.69]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MDysm-1jGnCH2dls-00A0Ik; Tue, 03 Mar 2020 15:08:09 +0100
Date:   Tue, 3 Mar 2020 15:08:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bryan Turner <bturner@atlassian.com>
cc:     Takuya N via GitGitGadget <gitgitgadget@gmail.com>,
        Git Users <git@vger.kernel.org>,
        Takuya Noguchi <takninnovationresearch@gmail.com>
Subject: Re: [PATCH] doc: use 'ref' instead of 'commit' for merge-base
 arguments
In-Reply-To: <CAGyf7-Ez1Fx-VUVmDWxRxLaZcU+Tu4kZ+F2+0uNKkx2oftjEJQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2003031507500.46@tvgsbejvaqbjf.bet>
References: <pull.719.git.git.1583220197856.gitgitgadget@gmail.com> <CAGyf7-Ez1Fx-VUVmDWxRxLaZcU+Tu4kZ+F2+0uNKkx2oftjEJQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:R3Zag7yLcqVH+KgMydd/Llat1p6Qk5ZQ1WkaID7VYYCeqiFASES
 93QaVh5LV9tMVMfXZ6jm/3jUjQy79xmO5xnzT2+oXD8IDeU/Z8qQaw4mDuK/VrN1NIs9sWG
 iRz5MDsREESb/9GxnpSlUH5Ub+aZkCZzaSMEmxdGiEiSQWGhNSi8b0EAISXRDTpAPbwL/th
 Nzcm25ikRd6lIl5vd5kqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p9SVG4gVCEg=:lnMPbHjt3JZOE0YTJ738XG
 ZV+cSa/zHQBhn6K0p6xVFObiO5N5FTLfBCeVyGri9UAdSNqDA7PbYFpjZnC5KLB7sWtCpkkgQ
 kjzKB6KmoAY//WByv6Ny42rgD1Ib/QTtx7q+0FRo/y2jbgEr+0mpRB/uaWt+KJ8w+aFjBDPZO
 OQlOQEAoeQrezLmc64KyMIxlgri2ZDbsVGMjA8FBZJniyA0sqCAZu8L6jIplzkW+6PIp4Ah16
 XMdSRJ4Y5LLp2TFtMbIT4qZnAhvTRXKs+F6rQC1MoS0q9RVE5KRP/gK7Ieu1U8FFuLF9kuode
 vXxlXE8UKkN9GYbQm0eXddyI8kNqbE6w68YWe5XAWnIlp86Ghd6Ew/cPyLW8e5jJ8aLRQJtmE
 IwaL+nys7WwoGhVFLaMjaUaiMIlmP7PscgIwBUxxvEm744XZ5JYbhpVQ52AFoteMrr/ivmZlA
 OE0oKxI9W+lCIyBBR3ob2Ckyafuqw8gtG4iiEwtjjOyh86GX0FqIMCqkyNwsgosfJXEa3ztA3
 x0ZeQELtpVtaALZwC6lpOOs1yHT857Ljwd4pRj1F07belayRPqu/c8w1RCX3LjhsGEoFXSXw5
 rPEKuhnXBxSEP+xNduHJibWHP0ECq61RXKt8n0d5ktk3sHXtIjMwhCm25R7aBXcVPj4Ci0hMN
 upcE6FR9MYoJMOajsfNsncElZYXQycuXaBpgQbK0MaWApRZHmt9PkKH0WBeAmSGJNfK746bNT
 Sz6G/ggf1ySJcMOgNv20njHi+6z6Ra/Fuetwd7zbWK14Hjt52AbOSWgnZMRYHkSaOtD3OcgGq
 Xvgzar/vsNg8CUcbMeFqktxUlQNfyQU2C80Wmg2MSrqM0xrLGKLPxC/5r49m/Jqz/U/uIWyDN
 lF7PR5fppk6urvEAmFkBsbL1J3BdcNTCq8+MRqSpOonah6S5XQl66IZak6Wjmo2LO1KDjDDxe
 YBrIwdNw34+NriC3rGnWzCliUDpYhHdpqlK+tlYAKceMnVGldOZR8U1eMTa+hVYsl3aTp11oS
 md9xq3NIFcsIAlbxmA2Cpz1jklJ8D48ZCLfgqtqkMv1u/+6lSO6qlzfxEaC/xYDx0LtWp/hiE
 eSvP35TGGS/GU9AmfkOE77hfHs3MtTFZvX+2EAddF3TQ+vCmrfAmkHzqS5u3LTpytLBfF+wVN
 pHErXzO7WQhSiY6QHShK5qfK/bkT0z4P7wy6gqMBEHHc71porBomq1NO9Tuo3s44yCady1CV3
 f/FBCunTdZXbFDHGy
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 3 Mar 2020, Bryan Turner wrote:

> On Tue, Mar 3, 2020 at 12:23 AM Takuya N via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Takuya Noguchi <takninnovationresearch@gmail.com>
> >
> > The notation <commit> can be misunderstandable only for commit SHA1,
> > but merge-base accepts any commit references. Like reflog, the name of
> > arguments should be <ref> instead of <commit>.
>
> To me, this change goes too far in the opposite direction: Now it
> sounds like the command only accepts refs, when it actually accepts
> any "commit-ish"--i.e., anything that can be coerced to a commit.
> ("git worktree" uses this term in its usage for "add", for example.)

Maybe we can go for `rev` instead of `ref`?

Ciao,
Dscho
