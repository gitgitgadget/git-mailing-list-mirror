Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F1F11F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 12:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753076AbdARMlB (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 07:41:01 -0500
Received: from mout.gmx.net ([212.227.17.22]:62908 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752551AbdARMlA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 07:41:00 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mchyv-1cBszM1BXV-00HxcD; Wed, 18
 Jan 2017 13:38:53 +0100
Date:   Wed, 18 Jan 2017 13:38:50 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Andrew Arnott <Andrew.Arnott@microsoft.com>
Subject: Re: [PATCH 2/2] Be more careful when determining whether a remote
 was configured
In-Reply-To: <xmqqd1flcosv.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701181338041.3469@virtualbox>
References: <cover.1484687919.git.johannes.schindelin@gmx.de> <41c347f22c80e96c54db34baa739b6e37e268b61.1484687919.git.johannes.schindelin@gmx.de> <20170117214723.p5rni6wwggei366j@sigill.intra.peff.net> <xmqqd1flcosv.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:SGdgZ5FVY2hm4pJHGha6C635n7pJ4xBLo7ijUDRfRXnGkjLyChr
 gXESlbCK9Rk1ID312kpz6NuIkHXuPY18XdPmG1qBIMuMkui01pPNYKPgeKrMnrdbzOSDfsE
 YcyPEso7G2GrckgOBI2gZxdFNg5fMi6PnJpr9omgvB4v7gP06Wi4P1hPINRvHtBiYDcs5Te
 YmbxHWLEay/nuebQz5MMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Zke/Z3qtlBc=:+bMGkx1Y5QoglpFTNVr++9
 5qMHaANXg9GNky6gW4qJTUB9pI5OD7uabLWR76ILvCu7Zxum8/8WViyzWzNWAoUNMAuYAgvlb
 xX90MF3FdBa0aFJA8Kvkboq71PTvD5k8Y41QJYLOGuep+qvGCduBeE55RxfnAkWotMGKONYfa
 kwNE6oldT0NyduhYK03TYAIlgDNP+bTMikfXi02s9XswyNW+z/e/jsib1nHUEDTYW7p0rC3Qi
 3f2l4fw/47yc4U0nkQp2EShVs0HRIpDT9GhROzx3g3gx8oMMp2HvqdhYAeeB0IbKOMum7qHWo
 i2ZMptYzBQs6CMK7isof81ojHxJxcjC/h3HS5Zco5kHXBcn7u12OUKL9TOBrhBoBySWs77Q1g
 sR5I1lEaRS4wdF/dpIuOaD50cijQAapO/Y0k5szGRhb7eOOmbokh7NCBOvK6xHc3e2I8DK1u8
 TQ1JuBPHtiC7QxcE05f62rtcJn+Bsw+y0Mz88cRkYFbTg0j4s8kRQhUP3cwMb0yiM9x9gCJWS
 oaSoRbPBvnBdwxaDPA7wLsHIjn4253BEPpkoQdXih1EJJYVbXLs0i8YIwZjmXtaW2/IF44HhJ
 Bxvxcr97pcyp4YX547zADhNlnKBJZia2sIHwa+BXFjP2e5k7QdSch7hOkE+GWvSKEirFXihtG
 JfCpWE/pPOZhkYDbeDNFY0njlkG+66CAbFAgJqvGPGG+j1hNie59RW2cxoeHqgOAOG65rjWW1
 VKL6ZcIN6hg0QlxMwouCHx45o+B112gtRZdjXD73K94KqujonKGKFLhy2dCoSm3IA9Up///EU
 MeNaCU/F2fZi3UGzg1bCFt6qK4FijZVIkHfV2KCx4CFZou3QDxYiQeTK9zL11YAObHDg0Yp7r
 dDKvAFxdx+58U3p9jOjd33OBRb1K/lCw+NwlBA2z7OmkFBVmv0edFg/+4Nw0DLlG2cj8RpddO
 74x2UdyMOu11CUkkWc66osATxiw5d/fN31qGt71sPzGAafZodnGg54JG94ak+tR9aeBNNs44Y
 apF73nHdcAK5QzKN9zkOyh+kifOCA5dwUVQJTdf4DjpPAVcAjRSNxW9VX3rf2IsjvQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 17 Jan 2017, Junio C Hamano wrote:

> Perhaps instead of adding "is it configured?" flag that is too
> broadly named and has too narrow meaning, would it make more sense
> to introduce "int can_prune(struct remote *remote)" that looks at
> the remote refspecs?

That ("can we prune?") is not the question we need to ask when determining
whether we can rename a remote to a new name.

Ciao,
Johannes
