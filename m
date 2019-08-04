Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7159D1F731
	for <e@80x24.org>; Sun,  4 Aug 2019 19:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfHDS4d (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Aug 2019 14:56:33 -0400
Received: from mout.gmx.net ([212.227.15.18]:47875 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbfHDS4d (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Aug 2019 14:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564944977;
        bh=Qy6GF67t3T7OtF9AORVl1HtmU29MEb+2o5Ifq2MojC8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bLM9pItXGGU6PNdd1Ht75E1Wv+fNOMLzE7C53BZ+vX0Rf/wPUmPBWw/KI/VmK4L9y
         u8rEpQbN8zjI3slw/Dhntd2DkaMRyxEyqcVBWvUNk8/RTndwDnXUcu95BjeS01tihv
         9OT/XZQkF6X1O55Xra6wT7VJAJzS7fesmL8m6HKQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDysg-1i21Bt0bVE-009zF1; Sun, 04
 Aug 2019 20:56:17 +0200
Date:   Sun, 4 Aug 2019 20:56:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Mark Levedahl <mlevedahl@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] git-gui: Perform rescan on window focus-in
In-Reply-To: <a143dcfd-8067-34f7-97f3-c4482dca5819@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.1908042048100.46@tvgsbejvaqbjf.bet>
References: <20190728151726.9188-1-me@yadavpratyush.com> <20190728213634.GB162590@genre.crustytoothpaste.net> <e3f296a6-f33b-7b52-c4cb-9acf65145e64@yadavpratyush.com> <20190728224943.GC162590@genre.crustytoothpaste.net> <724fb243-c660-ae04-1b2f-caf34794b799@gmail.com>
 <005d7946-3fbf-9c06-21fb-51f10d06f33e@yadavpratyush.com> <nycvar.QRO.7.76.6.1907312132190.21907@tvgsbejvaqbjf.bet> <cc5dddc7-e33e-2a2c-3205-6dd14edd0abd@yadavpratyush.com> <xmqqftmjldjx.fsf@gitster-ct.c.googlers.com>
 <a143dcfd-8067-34f7-97f3-c4482dca5819@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ePBBXo7YaL9FKu4H9m1oFThGR47k19/zXKe0ke1xO1XBfkcRHIG
 2M2Add0pc+ki2d0fo8KmlQZKVvfh/mYLyYVlsQ6lKQYQpuy3sAVN6d9nbgkyfTnBG1Kq3iw
 S0v6wo6q6eJF2iyfST0pSxu6o4pPb+H47dqy6G0pWhlmG1F0WCt90HGoDhW7ksvi4wkR9U7
 sjMhMSGooqZXK6/gF8v3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a+ztcxMoOCM=:nzSU4yeg7jtucU3IjxDhwH
 gtT/tUrZ+b5GZ8CS6RdahKDXg8RdL8VBA1EPjtXsnm/GXbwRaR80HnpZR702ZplpOn5SNMDEa
 sJao8uJw5RRdJaAr+tnGIfyShdrJA09N2S8l/ToWZup+fOzpurLdwR0tUU8xS3aibLWLztnPj
 qheeJ+qCIyHb7Gp9DGLLX2aM/xRGW9sWh8i3h5IyKhHMbH3pEyv5r9JyqEempZCQxyFs75AnD
 nQOiYTJRmw9z9bnAeRLbHV3fUcFFi0dtBkq15G/XMxgy3ovv1xjG8bBzHR0x4AUwTxqR8XYXZ
 KEgycVwjaR5SJI1BbhlFehI4RRUCCUvSbXQDDsC4VCYBfkjmFIUdjIodlWJtSxKb3O62nn6yV
 aXIh2OOAa8Aa08PSw/REqesyQUilNyEXKeDn9ihBkg+PfbkoFwlFJ/DbHeAVJpOvTkg1eGdjG
 79ZDbCSDSXXysv/8OGXL4YHF75Ld7URLWo3f3Bt+5e5RLc78O/xH54FOVGuCcS8zeyaxL/wZ6
 XVOSf3V1LioR6HYWGLR6cTRmhexbNFgWV9mvoZnV9essC82dt8Qom+N4lX1YuWOdyfDe/tawA
 EJ7YIWkJQxM1bDPm9JnnGp4iShwC1xHdDS91SnQBp2CmcQ09LAfSzGgfUoeBKJbc59fWGZfPj
 2m6x/gn3kfq6FA4P3uW31mzhNpCmQ/UkT6ajOA0JFii3QvqinnDmEFRmCKKnKfxfTBMrXSFws
 fj7PygzAXSKLnl8KhpPaFpfLJYYwY1Tt/trXbEueXRA1w3buRkXrOy1GA/w+glmH+sIWTbSKG
 g5yDyUq565iuXFNendd53ZW4Xg4pVEaKsVB5WBIr2Ec4uqfvHMcfDdcy6LXXURAUp1+aUvh54
 sLEm0cXgVH0OOqmKJ3MKdU+EPRdFDUugDY/iL72XpftzgOp43Gt8iiD7qKKD8PnCg/ZNNM8e7
 36HHwUL4cw+K501LcH29G/AIHezh7C4d9mQXlhdJTI+nWn9ibbfggEf/hKYhBrm1kHIDOH3XC
 WXPpdt2etWMurTjdrgYwhPBGcUA6M9OjUaIg+bJOUnPdJpcFXMPj5LSDRCngW+Wist2XxJp+E
 xw+0hPEfMNhclVYtVsFB3OPQGCk76XwCyq82wfTIdwRWZF6fSeZoZtcaxxv2VSI3EZWrFUFmh
 V8t/E=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 3 Aug 2019, Pratyush Yadav wrote:

> On 8/2/19 10:17 PM, Junio C Hamano wrote:
> > Pratyush Yadav <me@yadavpratyush.com> writes:
> >
> > > All right, the patch in its current state can't fly. So what is
> > > the correct way to do this? I see the following options:
> > >
> > > 1. Add this as an option that is disabled by default, but people
> > > who don't mind it can enable it. This is the easiest to implement.
> > > But I leave it to you and Junio (and anyone else who wants to
> > > pitch in :)) to decide if it is a good idea.
> >
> > I think this is a good first step.  As I said already, I am not
> > convinced that "focus in" is a good heuristics for triggering auto
> > rescan, and I suspect that you or others may come up with and
> > replace it with a better heuristic over time.  During that
> > experiment, it would be better to allow interested others to opt
> > into the feature to help, while not disturbing ordinary users who
> > are OK with the current behaviour.
> >
>
> All right. I'll look a bit more to see if I can figure something
> better. I suggested using filesystem watches. I'll wait a bit to hear
> from Johannes on what he thinks about it. He doesn't like the idea of
> using Watchman apparently.

It's not that I don't like the idea of watchman. What I don't like is
the very limited number of scenarios where you can use watchman. It
essentially boils down to... macOS.

=46rom what I can tell, watchman really works best on macOS, it might work
well on Linux, and it is in an "eternal beta" on Windows because none of
the active developers have access to (or need for support on) Windows.

Also, using a filesystem monitor is quite a lot of overkill here, you
only want to refresh the index smartly and pro-actively. Now you pile
more and more complexity on top of the original patch, for little
obvious benefit (and for added difficulties setting this up, because you
can now no longer make this a default, as you have no idea whether
watchman is installed or not, whether it works as intended or not if it
is installed, and whether users will start to hate you for forcing this
down their throats).

I want you to take a step back, consider what problem you originally
tried to solve, and then come up with the simplest solution you can
possibly come up with. If your solution is not simple, reject it.

I _could_ imagine, for example, that a focus-out event, followed by a
configurable timeout (say, with the default being something like 10
seconds, which seems to me like a sensible minimum number of seconds to
change anything commit-worthy), could be used by a focus-in event to
trigger a refresh (with a message in the status bar what is happening
and why), and that that would strike a sensible balance between benefit
and complexity.

Ciao,
Johannes
