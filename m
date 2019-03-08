Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55E6420374
	for <e@80x24.org>; Fri,  8 Mar 2019 15:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfCHPbG (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 10:31:06 -0500
Received: from mout.gmx.net ([212.227.17.22]:59439 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbfCHPbF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 10:31:05 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LsTjw-1gvdav1lDE-011wcd; Fri, 08
 Mar 2019 16:30:53 +0100
Date:   Fri, 8 Mar 2019 16:30:36 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Matthew Kraai <mkraai@its.jnj.com>
Subject: Re: [PATCH v13 18/27] stash: convert create to builtin
In-Reply-To: <20190307191836.GB29221@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1903081630040.41@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet> <20190225231631.30507-1-t.gummerer@gmail.com> <20190225231631.30507-19-t.gummerer@gmail.com> <20190307191836.GB29221@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2bjW8DH2iwN1XbfZOXUrFlICsqZS/ZD0TAI2Kvt0Sh054bjuVhP
 iWrx8J7msTpgaAGgirZ3bQetDXeuvcNLFyR52NSdvsWMdKyWQ76UZxV1p1jM+JySgKMRXqK
 m9gFnYpQOG5TOWSvNCozagV7m1is+xCAo+Clt5zhzJsVDkkRCrzWR2vnHlFEOz8hNUgph8a
 awvgsRtxLv/YuPpxTFTgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qi8Nm3mhf08=:ERPNscihGtZ3C8zjTl0GWF
 38FIvm5gd1iBrCaTuuig7uoVc9lTEs7IZDxqG1oT0sRTcvydryFNE4pIiE5+j234ful3w+rss
 JatZFwQdhkLWS8UTl1ZOJVCpummhGJx7hADFR9hCTw/WrpKNEaQ3kl7CFAnFq2DizfjOdfylM
 npVpn87qY0FfbEeJyM1HgTeg43N2CvtbxpI6+jbyqKMLtnfZ2vGpTKd7qaQYdzYD1+gAfrEcN
 0VpmqVSbcfDD1Go1OYZs3LlWx5+uE2AeDhvwcWRs15wNcisSQPw/GbWr3AZtsLTt4fL8yQeM6
 fYpR6ix/SsQAhk0K7GN77LWbj6YUfNpWwbh6/+Uf2BjFZQ1MAzzp7vQzmSEqnr902w5bvJOg/
 hp+1Las3Eno4C4QDcCxH3a3VfO/O4j4u3Qtefka+BmpUsJ/aqx40C8tOoWcQh0gHBZPDICTPG
 PaGCTfmi+sDtVFXXoSb5I0ErTaVW99ep3g60DY/cgZpnu9hoI3Oqo2AxlyYzKD7OJe1YxY1zI
 mAUwk6lmCR4Fh9J1qTcUeaMy69NmEjSDFjTOq+l1lKJxolXjvOeOg7ksDUvWjcRnSMTqxsxu/
 BjkfZrxEYXFTR4AbyPWuomICcddiLatiNpmP310xCAdJmnTN+2tlhYZ7AbCGkVZSM3rHi1abE
 0X/SWCtIdWCDW5ibo9tmZD7uxqIPLp1LTH5qrT1wTPQr1nm47WDqZaSg/xh6cOZV7yLMiB6z3
 I6rBNHCFReLmUXDS0zIwBQIHKhnq03u9TBTCAO8hqarMAAeFIe/Cinz8MlrPZ22a7APoNWplR
 Tq4y0zIEChjKQlsqgTarhSnmCOtVZyDORCntG83dT6dIaQcyIXeM8ZbAN7uLRn506Sw1vpmFz
 s9LgoFuLiAHVRK6nsLleReJtNEv5jwGNbXIMtnkBsXkPwOKlOXbMeZjBPz+0JGsBxhvAxsgef
 jvP0TeZ4Oog==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 7 Mar 2019, Jeff King wrote:

> On Mon, Feb 25, 2019 at 11:16:22PM +0000, Thomas Gummerer wrote:
> 
> > +static void add_pathspecs(struct argv_array *args,
> > +			  struct pathspec ps) {
> 
> Here and elsewhere in the series, I notice that we pass the pathspec
> struct by value, which is quite unusual for our codebase (and
> potentially confusing, if any of the callers were to mutate the pointers
> in the struct).
> 
> Is there any reason this shouldn't be "const struct pathspec *ps" pretty
> much throughout the file?

I am quite certain that this is merely an oversight. It totes slipped
by my review, for example.

Thanks for catching!
Dscho
