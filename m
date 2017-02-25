Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C68FA2022D
	for <e@80x24.org>; Sat, 25 Feb 2017 11:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbdBYLw6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 06:52:58 -0500
Received: from mout.gmx.net ([212.227.17.22]:52774 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751402AbdBYLwv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 06:52:51 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MD9uq-1cXfF711si-00GZJj; Sat, 25
 Feb 2017 12:51:21 +0100
Date:   Sat, 25 Feb 2017 12:51:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        David Turner <David.Turner@twosigma.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] http(s): automatically try NTLM authentication first
In-Reply-To: <20170223204804.syj6tgjdrgmqdzna@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1702251250320.3767@virtualbox>
References: <20170222173936.25016-1-dturner@twosigma.com> <xmqqpoiaasgj.fsf@gitster.mtv.corp.google.com> <97ab9a812f7b46d7b10d4d06f73259d8@exmbdft7.ad.twosigma.com> <xmqq8toyapu6.fsf@gitster.mtv.corp.google.com> <20170222213410.iak43asq775tzr42@sigill.intra.peff.net>
 <alpine.DEB.2.20.1702231806340.3767@virtualbox> <20170223194237.eckkpiqv7inuz7un@sigill.intra.peff.net> <xmqqlgsw7iey.fsf@gitster.mtv.corp.google.com> <20170223204804.syj6tgjdrgmqdzna@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:2W6Kiq0teiLUECvQa9atfCcYbdL9eKLdr33cwEnn9byf1Rvr40f
 vg/4pcZSmpXLWQH6UEpEjZVDQnGzEYUWJw+E8i7TsYAh6YI4ZqIJAUdX8KMtFqU4Zh3bqob
 tP6S0+iBWuUKWVOGTvZT57Mt6bzXy1GLi4czdOcD1IlPue6T64U17/7PznRGFCLCXrlS8tH
 YcSSESokXiCBLJlW4j24Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:O/zSxvwhlB0=:Y7TvfEoZS/+siwYyQB+gto
 hnPOAsSsIxU2/fJGmTfJx1+zRV29s8zxHGrJZxjiipGoFGrzoy2UUdvRCjYbgcPxkJigf558Z
 gNjMjG2pZBqLFHkCVh5w53I4QJMjFh0A9Q7XNpdX8h3rmTQU6NYZ6meeS0fstmXF+QPzK/qcE
 FRTsg8S9ZgWW6weQGe+hJz5aXFKoeg1gQV0dQz6n9X4nyjfoDy5Cm9zGGFiC4TeBd6ZMAi950
 SCjzfKBqXveVb5gVaZICoW6pBSLVMw0qWFZjymQjGDwaqXpoJC0nOjbcFe7yu3XnAibS11luW
 q9nX9YRoOR/sPpHFBEkFkGZoEOvV+0tc41dooYpNOJyc+GB2xhjSCc0vwdsbSd9j9x700Ku3m
 JKKVpdobyPV0lEHF6U9MNiMWQPH6N2FNwCG/Iak6wQou8xKr+7o5oFDLXxUT8udXq1/9DU7oT
 bhDWlmXcbc+yXRNEhyyPF8baZevQhU3KxeMfC+3yf97yzdUZyVWvQ2eSUVuTO2lBXxFbmkKIq
 P2ErZDpzr5mAodaiwmoeedxJqZndjzT+mVFPNaV9SasajTBNA0Gh69yOZAfndornUNrCvT8zD
 EYrZJ40LBmUcUNUc1CvTr5vjrLaAgIOe+x+BVIHX5x/c5lZQF9uG62cDXQKA8yPYfJxYWPktX
 P0kV0QAV1rteSzzborut2tTqQbnnC6GKGv0Aw+DkMp1Fj/WOxjayXrZDsmPgRzSSnSBOtC9jH
 KQKbOz9rDdhy62AV3mWtFQnTPhfV/WLV5XO45hjyPjwLn5RQ7+5g6jbRs4WdX88s1eqE8CyhS
 BobRYUKyk1Z3686MNTRRPW3P/Y7sRFRf0C8OISsrUlQk+UKxjSd/SwjAOYG7PYV0XYYJYRyg/
 tf/zSRnxycYcgazhVh3+qyDXqTAgQLfzhtZbmNWFu/0bmfsFYr2kkJg+07FvceMg/l8YD4mMJ
 jrZ8GFBNuV9+asJ2+J2UsNiH08Pr64H4wgwDtS8vWdw/df4mGip8qsC45ElvsKlP37ecv/5j+
 ZDz3OmV/dg7KXGMVqzrEl3w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 23 Feb 2017, Jeff King wrote:

> For Git for Windows, [PATCH 2/2] seems like the auto behavior would be a
> strict improvement over the "true" default they've been shipping.

Absolutely. Thank you for your tremendous help!

Ciao,
Dscho
