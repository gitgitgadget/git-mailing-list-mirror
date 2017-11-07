Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA6D320A10
	for <e@80x24.org>; Tue,  7 Nov 2017 00:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755541AbdKGAnT (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 19:43:19 -0500
Received: from mout.gmx.net ([212.227.17.20]:56470 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754703AbdKGAnR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 19:43:17 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M0yaB-1f6Sdk1WQB-00v4LW; Tue, 07
 Nov 2017 01:43:11 +0100
Date:   Tue, 7 Nov 2017 01:43:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Phillip Wood <phillip.wood@talktalk.net>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v1 1/8] commit: move empty message checks to libgit
In-Reply-To: <20171106112709.2121-2-phillip.wood@talktalk.net>
Message-ID: <alpine.DEB.2.21.1.1711070141110.6482@virtualbox>
References: <20170925101041.18344-1-phillip.wood@talktalk.net> <20171106112709.2121-1-phillip.wood@talktalk.net> <20171106112709.2121-2-phillip.wood@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Rz79AooHqj+4hmmUV8/2+ZSAENP2Jd9DjGx73AMOqdcuUv0Weig
 TBCOJYmizUys672t4xD2X3weA17M4K5e+oHdRk05Pv+x/H+HOLR30NRO/gIeKiHxB2skASm
 2mVSRPXm++D1YpfJwa5Gv2E/mzvSrToRzwi+p1NShmS1du8OVhZUpiM33elRWhVsKCDdqha
 ghWLgMo3MBV461g0A8LxA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vG+jarsm3hs=:VjqGyKwj/C1r/SgTauRk6q
 flCwHbIvGHNcRuQ+yYNcmnVJ+3hP636RXaFJTRoJ66or4qQyvNrYKqAYoSDDZEuMqbIysJndD
 b47GCBC9BB6xjaJeSj4Hx84Qn5XwvFmArVYT3tgt9Z1o4KvltYb7CCSJONxw7WpNsouTWuCkN
 eJyQGqOtIDKKcpOJNdRHZKg2aXXkjR4p4R84D6+cmVj8JtTnGSaaDYs1h14fyUNNiRwFI3f50
 3HgoKzcwRqe0+5+xUjosdXnbLbP+UQ7tzBC66J8D8gmIjbJryNYcq59dtAzX0qnz+ZTU3bauM
 7vkgHwsUGxnj7hupczHZjeXhjfQiUUn8cIflsSG5lVUPAJsOO9t0zZawjOXDtCOQCCI22sxbi
 JvGy4SKGpmypfnEiF0VgpEsIdBRA73bnG7CzgF0Ibc6OLbwgrdSUzTPCehREhpn+cvPoBBW95
 Aff7vlwYC2JHdEfYG9X5pxKM7PbQllI5LBoIwyGH0awOEsA0ipJS5pokbpcu/3RHxW3l2ou87
 Re4GOakmNBSzE6Oxa1wY845bRRIInF6y2RG99TlpQTnA1BAZMGf7oDfGatOn1vzztqRCRCRCG
 oyRAUTndsQ90BDYIRhDq2xXctVqw38dbfAQXCliAxGloVX4zSkh89TyDwtg/2ftgF+3rMsCWr
 0BAP5jI5J+3PfQv00CftnfVbCQkv4kDSFnJvP5dJIwHYFoX5vkDGEddov3MD3N4uX9IiNVBy3
 mqnrzNqAYkWsaqO16GrhbjntPPMIrAsYh0TU08jCMCwL/LrIW3FH1dNhef/N2+cfggo/Xfwgw
 XGQvfqaZki6OzxmsPN+KcGg+mfLOjuJ9fjUYvxtTGt9Oc3tPtA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 6 Nov 2017, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> Move the functions that check for empty messages from bulitin/commit.c
> to sequencer.c so they can be shared with other commands. The
> functions are refactored to take an explicit cleanup mode and template
> filename passed by the caller.
> 
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>

Good rationale. Just one thing:

> diff --git a/sequencer.h b/sequencer.h
> index 6f3d3df82c0ade64b7b125acd49bf3f5e15c53af..65a4b0c25185d7ad5115035abb766d1b95df9a62 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -58,4 +58,14 @@ extern const char sign_off_header[];
>  void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
>  void append_conflicts_hint(struct strbuf *msgbuf);
>  
> +enum cleanup_mode {
> +	CLEANUP_SPACE,
> +	CLEANUP_NONE,
> +	CLEANUP_SCISSORS,
> +	CLEANUP_ALL
> +};

When it was file-local, `cleanup_mode` was okay (although far from great).
Now that we want to make it more widely available, I fear we have to make
the name much longer, e.g. `commit_msg_cleanup_mode`.

Ciao,
Dscho
