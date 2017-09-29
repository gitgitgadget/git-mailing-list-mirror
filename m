Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D072620281
	for <e@80x24.org>; Fri, 29 Sep 2017 18:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752581AbdI2Syz (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 14:54:55 -0400
Received: from mout.gmx.net ([212.227.17.20]:55270 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752351AbdI2Syy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 14:54:54 -0400
Received: from [192.168.178.43] ([92.76.242.84]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCPhl-1e77Em2KzR-00996q; Fri, 29
 Sep 2017 20:54:49 +0200
Subject: Re: [PATCH v16 1/6] bisect--helper: use OPT_CMDMODE instead of
 OPT_BOOL
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <CAFZEwPOjK25m84BgTF7AL72DL_K1dHf7OrYoX=_vky9r3GayNw@mail.gmail.com>
 <0102015ecc65d695-22151d3b-752b-4c10-a3a3-b8ef52491664-000000@eu-west-1.amazonses.com>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <1ffcb7a7-6ffe-c98e-66a1-c3d392f76077@gmx.net>
Date:   Fri, 29 Sep 2017 20:54:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <0102015ecc65d695-22151d3b-752b-4c10-a3a3-b8ef52491664-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:5W9dWUwhq6cQir1wwRv2sQmsR5J0kNyhoEk4re0bCmBqAzSxjIx
 4XxXNGUIBRHZoa5djplocLyBkf2IRD94yXcNSbu+ujDai9zISrgoXSVfIFPHE0CHO3oCndQ
 og+2jkOSmtkM7Vn1Zi4/ELglgRWrLLosD7dt+14pVsm9Rd7Ps1KNSaHwqCWXfdqgW3Mpldx
 YatMCMuWw3fZR5PtuaFcg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rD945CBdB8o=:40MIhsSpagY0zhCYq0izJo
 gX/3wyNGXyLhJkAWhHkX4EAxjdv0rHri6Aq9eX+5vdn97uADGpnEuRWIG1wFgI8tYc6IA6OEA
 cfcHcjOjzMMp0jFM2/H2qpZa2+RKYYDbgAvBCpIeW3mN6mwTqPYiH+OSITYZfEfRYIu6N06No
 0ko3G7qA4OMW8mxWc/NEXYY3vBCQx5fYS7+ejherv1mej5LVLQx/mHWPClJsFsPUbTDXzcaWH
 OWkJMzITH1ReAw+kUee0mdm5NKltblhKXRARmwDpYD3il1UU4hoXSL618u/ubmwdQR3CYntKn
 NNhyd0dqOQKPy7YJbC1kj5/I9wlxwxxeo4SykXVew1+Di9IFo9KMLrRKg+vGzYZK1DfOzVJYQ
 OhHUeK0ZBWFhhcn1SqXglEsPQrSKSNvpnTRWju5yGlJnEZo3B/Rlw1j1mIkZR22fS4s2D6IEd
 WpIZmzHiq2VhAQVE3ghdlOhKe69zQE7374SM3MCq4lU7s8kwTWUWXZhf9Rr882UoLScWxpWkl
 o4VynDBe93TO/8GNFXf+Tx1swogWOISLD9RQLC1i7AItGhRjPaNCrPEpkh5qXelZEdL5k35ra
 uu5XBFZnMkersExhotYmMOVn5eMbi9uHpfJpN21cvXNUoQ4p4w5vLOpKXtnaIN6ZYjCdRfnR0
 cg1e4q/3R1lpMi3EKNDH6hwCuETlmXYCpd5p7q0aCKqWzoi3v6filyhLrFsMQ7gLa8Oj6vIRF
 IAk0DwxfyBiUbFz+siL87fxNrWNJCFNAMIy/jDxSdXhOJ/naiYFW8H6bCIEO3/Aw5Eju31Zpi
 2LvzA2BJZ6LGTTRNfo+liiOYSRbaxGNSmd9+EUMvcwnh36r7os=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pranit,

On 09/29/2017 08:49 AM, Pranit Bauva wrote:
> It has been a long time since this series appeared on the mailing list.
> The previous version v15[1] is now split into many parts and I am
> sending the first part right now, will focus on getting this merged and
> then send out the next part.

That's a good idea!

I just reviewed your series by assuming I did the v15 review well (it
took quite some time at least)... so I just diff'ed the v15 and the v16
patches. I am totally fine with it!

Thanks,
Stephan
