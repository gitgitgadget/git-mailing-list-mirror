Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B581F2021E
	for <e@80x24.org>; Sun, 20 Nov 2016 20:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbcKTUUA (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Nov 2016 15:20:00 -0500
Received: from mout.gmx.net ([212.227.17.22]:56324 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751512AbcKTUT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2016 15:19:59 -0500
Received: from [192.168.178.43] ([88.71.227.20]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M34eJ-1d0NjP1kL1-00swcR; Sun, 20
 Nov 2016 21:19:56 +0100
Subject: Re: [PATCH v15 13/27] bisect--helper: `bisect_start` shell function
 partially in C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1ad3-ea75ed97-2514-427e-8e57-9f10efd4e6e9-000000@eu-west-1.amazonses.com>
 <52f6241f-e584-d830-ca66-084dc509c7fe@gmx.net>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <de42ba9d-af15-6d77-5c97-4136b7aad149@gmx.net>
Date:   Sun, 20 Nov 2016 21:19:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <52f6241f-e584-d830-ca66-084dc509c7fe@gmx.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:/SE+Mybx7E3Wsbvsc7KI+o0bNQ93LRXereeog6mbG6D5tm87Lqj
 zOqRF1fTElwG8PubUzud6s349cl+UIorKW0MyY8az2+bJ5ILACMuVmtgdxupGo2M7fkwhMX
 DEOmOYEhDCRdNonDVtAVWlG+nf369iBqzOGIEruOJoi2oSNuXLbI8aVZDheNWHhj6PJln5n
 3ON+BaAEqMcleQLAaAEhQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BcPWRTrJz/g=:ExcWxIr3Bg1l7jwaQr6hIN
 XWfUjqQuh+UHzzdsNf3vUdA1om4lAJQXfbjqA62G3sMdpAfUy1Ged0REvRNzC2c8MoS37F2S7
 vaUb3H+cRX+V+CyXWa+DtQVhMU+mEwMkTTAh6tow1TyhEhRPkOnr5gkFMlYzz+BVrqdraeFyj
 mUmLCT/Gqy6RQUmsshWtjbzxy43m3ehxuTfa7A8lVxhnsNqT/f2uDg6NMSFCb5jMTbS2z/U7s
 45u5G4IAoeuwnPujdjVKSk0W2tlSHNuFlyPRL+y23IGeIRXgKhuJGCuWieZwFqv+ccrTIuPxD
 /LR0KeAX7NLNAOOUf/wkxjlZjdmA27+dGUO8CDj7i4tCxsTnxyY+W68ebZoM/iaXwdXAz8WMx
 edCR4ctegYM2BMJm2GVqUGHGx9N/64PIrgbqHjthul/0vXjdi6v+NXYKF6I/7ymbVj/B/5Kib
 o0RglpF+iHVgJOiwweKsEcII5d1WckwfjKkjKSnG+V3zZg4U3ZleVZ13ZuFkinTyjjM6N3x3J
 +nz2SG/NG6qM67OTltk2z3WjyzA7sdMvZNVI3yb4FlSs7sjg5p4KCvGksSVLmkUrqoE7dtgC1
 Xr1dtcjsrxcvNNsz8d4UPfZsLElhxpfTes0VyLN/RfaA0/6u/515HQBZ+Yb3bh6ayR0B1BINT
 aQ4Y16tpMJN9163WrIVJG1PpkNacHfJGOr8+HXbSeGdtR7zkQhmDeXx6bixfVybyRv8wmZhGt
 oj43o+GnKIFGVgCKuQAHyof4W+R8BY6V+3koZawVmF+5VMqR0prgJ063XPbdrbn5PBWwq4UoM
 97Az71Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/20/2016 09:01 PM, Stephan Beyer wrote:
> First, replace the current set_terms() by
> 
> static void set_terms(struct bisect_terms *terms, const char *bad,
>                                                  const char *good)
> {
> 	terms->term_good = xstrdup(good);
> 	terms->term_bad = xstrdup(bad);
> }
> 
> ie, without calling write_terms(...).

I did not want to confuse you here but I forgot to mention that there
should also be freeing code, i.e. initialize your terms to NULL in the
beginning of cmd_builtin__helper, and always free them if it is not
null. This freeing code could also be in an extra function free_terms()
and you call it in set_terms() and for cleanup in the end.
