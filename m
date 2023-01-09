Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489C1C54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 07:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbjAIHhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 02:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236440AbjAIHgw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 02:36:52 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C751114F
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 23:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1673249802; bh=meW36P9mke3FEUTTfHdq960ROxHxM7zyOg4VMCY3Hoo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FrHBiuOobtkN/+10E2uVbXiAOEFoD0mPeh+QQpL7lF+Yb+ylKOXbJNr/ITIuVmmBa
         fGLPXImdG0+JT8QyawYyl7EF601ePIesqtlQxZvR54BieFwgFd470fkP0d53iYpFlC
         pVjN2i9JL7aP7CeMqLPg45VUpcyRQ687KdP9ll2ViDtdRGoqYdrYdxb6CRXFT3latd
         cbWHWuFWBpUiFkPGcMlbWIX0AHblsZIC+Kp/onJu3Lk0KE2brdPSfU3fivW6wKH0ck
         40SNjl/N6KSIGby0CxbtmxR/ajYJsjNtI/rmTXX0/MTDoeim3HdxqdfIY9oxf2qTDw
         qmfhJ2OK22WqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.31.64.27] ([89.1.212.243]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxDou-1oqPGk2DFI-00xZdt; Mon, 09
 Jan 2023 08:36:42 +0100
Date:   Mon, 9 Jan 2023 08:36:40 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Harshil Jani via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Harshil Jani <harshiljani2002@gmail.com>
Subject: Re: [PATCH 0/2] Remove MSys Support
In-Reply-To: <xmqqmt7lxxr6.fsf@gitster.g>
Message-ID: <9933d992-ffd3-b43c-559e-0de819408cda@gmx.de>
References: <pull.1433.git.1670274213.gitgitgadget@gmail.com> <xmqqmt7lxxr6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Dz8lM9zSksFPZaag0XBamhHgdAW0SBLHGiP8LDiOFPIPkN/XRD0
 4tIMOQzi52SQ9xNnMXAuiUOvlBhIuftLDx0Dhnou3rqS/P1S01L2AgFvaiT+4RIiqx3ic8F
 0J4z1uI79gnAWG7LflAw/nmIZWfodPk8GEtmQtlMQdSic3LY2J5aRDpe4i8pQ4/hBvieDSZ
 EyvSs5/DYbSo857UrVXKg==
UI-OutboundReport: notjunk:1;M01:P0:leste/8rpFc=;m8qoJb3y7oKn9b6buNHRGFG1c73
 yYCgNPY57rOv7994Ic/CTKZXcJq4LFPnWFFJiq9CvFpXbrp0cC7eagnBYzo4MT0wQxfEzbNez
 PT/BjPASfBNjdRc9rxdtmN08xfkQi/qAAk8zX17PlUVCFO3ccaG6xR0qRQ76u6f7dtofpndhR
 Lg3AnnJau3UCDIqEoEBUae6MRCECfThv8F8i+PaceUpX91CXHi1jHJjyCwhojFu3DAtgexOm/
 RBteu/Jw694GPsjyjuZU3dSFi2BaG3Vl4x5FPN9QKlbLrcJ03Ph1ulqToLToX0UR4QDir1VaB
 u3ictulsm3rar8aaJvwXmZAAIOaS99jjbJylSNUssMn/NnUb3eqU1SxVQWM0MmgaU0ArvtYIH
 cgddgyR5zwckLWVoQjEPVB05Z6SQQZpJq5CTT+cpmp5xM63UGNtw2MPtG1pNmeZ0Vc7gpAkI2
 Z+NoWgoujzQgXf9MHxqRHgpU86riDl0XHuHkbgXIjtr9JVkC3ph87YM8jK8IwcoUbcmKj7XEt
 fsYi54o6BH90bkKDcOzqGGhvEfMJUUyM1f9dmehAn4r1klMHXjKhn3pPiUVKs+eZMKffZlpFo
 T4UdYQ2D/fPmGh18YtMthGC4vIAndXHFg6OP51NOR2DtvPD46wE3el27otKENLke30JN9SIzQ
 NDBFSwrehkjoMr3viIj412+ZMhsMV0H4vBhpQWR5g7BDxYSDl4sSQa0hFNuq3oZ3dkeFMm1IY
 Qu1gjAaUGsm+U61LNHkig3Y1irW61ccNLg/LdOCJ5ND31wlzBJ0JUdjIHPJcJ2Qo7bQAKUIEt
 Hseapmt7HjnsNoiiaeF/h2qEO2/b4grXrNl5QFJ6ZCO/qZzL/uYGIg/muQyl+KYkpWNHE+IJI
 Rv3m93wLgr/PaDZu5LQMHaT1X1pqW0zc5HMHW/YlDFd2IeOWX6Hf19ulEqXZFnHBLo5RzoIMc
 ZoRbTQrCeaeidf6zCO98KHg0vt4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 18 Dec 2022, Junio C Hamano wrote:

> "Harshil Jani via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > The msysGit and the MSys v1.x has been dropped into this patch and the
> > USE_NED_ALLOCATOR variable was duplicated here in the implementation s=
o its
> > deduplication was also made in this patch.
> >
> > Signed-off-by: Harshil-Jani harshiljani2002@gmail.com
>
> Thanks, Harshil.
>
> I do not do Windows, so I sent a few drive-by comments to suggest
> improvements that may help to make the patch more understandable,
> but more importantly, I did not see the patch asking input from
> anybody who have worked on the port of Git to the Window system, so
> I ran the following
>
> $ git shortlog -sn --no-merges v2.39.0 -- compat/win\*\* compat/mingw.\*=
 | head -5
>    100	Johannes Schindelin
>     56	Johannes Sixt
>     41	Karsten Blees
>     23	Erik Faye-Lund
>     13	Jeff Hostetler
>
> and then picked those names we still often see on the list to
> attract their attention.

I need to note that Harshil and I have been communicating about this
patch before it was submitted. So here is my explicit ACK.

Ciao,
Johannes
