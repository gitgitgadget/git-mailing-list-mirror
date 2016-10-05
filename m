Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6266E1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 13:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754184AbcJENIt (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 09:08:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:52175 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754178AbcJENIs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 09:08:48 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MbgWb-1bZHa93QOb-00J4gi; Wed, 05 Oct 2016 15:08:40
 +0200
Date:   Wed, 5 Oct 2016 15:08:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 21/25] sequencer: refactor write_message()
In-Reply-To: <xmqqfup1nf3u.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610051504360.35196@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>        <cover.1473590966.git.johannes.schindelin@gmx.de>        <da2293aee439da2274e30304e2d1f097b9644e64.1473590966.git.johannes.schindelin@gmx.de>        <e21e3391-bfc3-68b8-8eaf-0e15e5a436c5@kdbg.org>
 <xmqqfup1nf3u.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0Y+RrcEpOZnCN6retWp/Y/Wck9qSPsflJ/d3RthB8Yq+ZqoGXbI
 jSncwpPv1g7l+yU4sLRYaTOPuRNhk2gjKWjf6hVXqApCka5zy5n4x2TO0WVex98ni92Dfke
 ZN08RBxe8HyhOxGYCEQq+1dZpfnF2lzlX/ovPDo4r/T4BBLK+PtMswydZpZCV+cisrbLsDw
 oVZJsfewZ+1aCrR+mTkcw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ys0elaTSnEY=:Z8xrcFsc/ejO2h2l/8uGxx
 634DAj723/UaI5lPoMHYBaQsqP3Qw7Y+6iQuWqlMkh20nz4k6e97pbMNcQsozXE+3dNlwJUi3
 KerDKTVTJzS/8x+y6HbCKWSzcEfYJPpmPNrT51kv9aveOKllJoeQv7sgHgdgdF7JIaB1e/8sN
 LGfbYYYe/OEvYEeA8oIbUVotL+xc0FFztZKxUV2ld1LuTdFkANOn2fCBv1X/+1VVGhi5+6GoK
 2HEfZ3E2yyvhyfIMGYFmP0+ozOboEBRxXUorQ+noXk3273ZsAcrKdv0xK/DAFBChMhsPkZ0AX
 aGgwha97GmN7LNDb50oCWb2x9kaC2+ZMlhoVMOHbQepuky3KDxGaGjBSCIDcobAXI6jGeAyYx
 B7g7WscZ+EzLom3v4CTGDl+AH5vDYW3gWgqdXa0bo+BED/bkABlUjPyVGB1/oreEgmwBEvvmA
 dxJgTGJmH1ik3RjKokS2lLgBJEN2tHEj4wkoYNxri/gu76VC3oNfWos2lS0CvjqqFFGq54j4A
 MpZKtv6a0tAOiv8qWU2dJkQO+SaC6eC3HC4iTjx1vTMzeV+LGFhODSDp8TwaWyN8K4FnX1OAn
 lISDX8w+F2yhSMefaQmMwQFmf3woBtThCDd35g5kJ4IN6IVW7O3rAI8aUYYwiMdu+vpIVFWtC
 6rwT2yZ/mA4PekgHosKx2NWheqrsls/X3XMyknoEsDMUueFlIb0lVD+c3Q3rINSKeEWo6VDoB
 IVDJYzf6ZO/ykmPkHUkLPLDWzqLcizuTw/bGTb29OU1c3/P6bT2gneh5o3IOogxUCAEzHIO7M
 ODKdXAG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Hannes,

On Thu, 15 Sep 2016, Junio C Hamano wrote:

> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > Am 11.09.2016 um 12:55 schrieb Johannes Schindelin:
> >> -static int write_message(struct strbuf *msgbuf, const char *filename)
> >> +static int write_with_lock_file(const char *filename,
> >> +				const void *buf, size_t len, int append_eol)
> >>  {
> >>  	static struct lock_file msg_file;
> >>
> >>  	int msg_fd = hold_lock_file_for_update(&msg_file, filename, 0);
> >>  	if (msg_fd < 0)
> >>  		return error_errno(_("Could not lock '%s'"), filename);
> >> -	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
> >> -		return error_errno(_("Could not write to %s"), filename);
> >> -	strbuf_release(msgbuf);
> >> +	if (write_in_full(msg_fd, buf, len) < 0)
> >> +		return error_errno(_("Could not write to '%s'"), filename);
> >> +	if (append_eol && write(msg_fd, "\n", 1) < 0)
> >> +		return error_errno(_("Could not write eol to '%s"), filename);
> >>  	if (commit_lock_file(&msg_file) < 0)
> >>  		return error(_("Error wrapping up %s."), filename);
> >>
> >>  	return 0;
> >>  }
> >
> > The two error paths in the added lines should both
> >
> > 		rollback_lock_file(&msg_file);
> >
> > , I think. But I do notice that this is not exactly new, so...
> 
> It may not be new for this step, but overall the series is aiming to
> libify the stuff, so we should fix fd and lockfile leaks like this
> as we notice them.

Makes sense, even for the final commit_lock_file().

Ciao,
Dscho
