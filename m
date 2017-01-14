Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFEBA20798
	for <e@80x24.org>; Sat, 14 Jan 2017 18:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751771AbdANSI4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jan 2017 13:08:56 -0500
Received: from mout.gmx.net ([212.227.17.20]:58979 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751473AbdANSIz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2017 13:08:55 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LqQTl-1cxgqL1nqz-00e0xA; Sat, 14
 Jan 2017 19:08:44 +0100
Date:   Sat, 14 Jan 2017 19:08:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 00/38] Teach the sequencer to act as rebase -i's
 backend
In-Reply-To: <xmqqinpnuaxl.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701141904390.3469@virtualbox>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de> <xmqqinpnuaxl.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:t6KuFFoCUYHcRvuC80bDk2uBVgvhJ77JZQFxRb5b1oTb2Vu5fVA
 ox0NVapDGR+YqnoMmEE1fo2hcNIICQ96OVly831ZIyvTP7eBvNEAGaWqAVhpb8ovJ2l/V3r
 D5COCTzgkDS5OsdrhFA3bs+x8xFMaACY3kEAkbVOHuPo2QZjH9bawwY9eCwC/WFKrIlLAkK
 lB7/LMu0qIkbSs2rSmf4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GLWmd03sWO8=:bGJLfm2uhsUO6dQR63Ki5e
 UmoxRHCLq+9i/zwQOhdmN6TK02DguHzcQKwn8fJVwTAwnJ75VdNwU2uCuytPtvpjEIzplkNBJ
 3jZxf8mw7bjCdPgJnFYr/xy/fFw18Xerlxi+OqKZ1th9uiFlAiA3TpyDgFpswqeXLMI/p5kcK
 9yu4at8M3F0z9th3Fk76TY1nMEDZwGohJ26qoNGoN8W0K3mIW3zIVfNadszb/MXEBs5F2Jehb
 YBpZWy0viEF1eMTS2k7GGnnU8kHoO70pds++j1AZBCEEhGqW7jLxjhcUPsNu/yTMEPMN7h+v3
 tsuK/+YS5EokxEg9YjcybZENjt0MPPc50FmNwUkUnaTNctONEH78wDSJwPWH0H9iohO4YEWdS
 sbUzpk/r2Z+xNt9jGaXvcKToOASC+ap5ksQjo28YcgjpvUjLAu9goNXMIOH6A229kobdKr42s
 1UC0QM790x12/xJUMA9CQkQWjnAPe2sTLTz9b+fAqQc8EaaAusJsBQ2HygApv/82NI91BX/35
 uCKW7fSDI9TyVq1yvBY8vsS/TjeSbDQc+azMm691rWfrSgszxR/H3I92LaYEjRRlr2X2wfb47
 Os0XbUtM8Ig5jMEe/fbJ3T5AC2XRQJENZRfdHjHCAlLQaOaPIYKZ3u19rKVmnQiB2ZCudTcS6
 mUHozyOR8i3arDcQcfvg+4urPy39g73SFAsPaIpmS3LRxGkzwQtaR+wZW2pPj6FNYc9ejQg/E
 JFlvco3U680Mp9a0dOfnNy/eHfPIA2EZg9tJP3z69HLan/IIRWE0R+XOksYTdwLJvyb+o9yVB
 F8ceFqS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 9 Jan 2017, Junio C Hamano wrote:

> I however think that the renaming of read_author_script() is totally
> backwards from maintainability's point of view.  

You stated elsewhere that converting a script into a builtin should focus
on a faithful conversion.

The original code is:

	. "$author_script"

Granted, this *cannot* be converted faithfully without reimplementing a
shell interpreter. So I did the next best thing: I converted it into code
that reads a block of environment variable settings.

What you asked for is totally unreasonable: you ask me to make this
conversion *even less faithful*.

What is worse: you argue from the "maintainability point of view", when it
is pretty obvious that *adding validation that was not there before* can
in no way make the code more maintainable, as it *adds new logic*.

And what is the worst: over all these discussions about a nothingburger
(you simply cannot convince me that I should introduce validating code
that has not been there before in the same patch series that simply tries
to recreate existing functionality), the most important part of a code
review was forgotten: to make sure that the changes are correct.

The worst direction a code review can take is to introduce regressions,
and that is exactly what happened.

Ciao,
Johannes
