Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDD87207EC
	for <e@80x24.org>; Wed,  5 Oct 2016 11:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754824AbcJELl4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 07:41:56 -0400
Received: from mout.gmx.net ([212.227.15.19]:54061 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752289AbcJELlz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 07:41:55 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M6ilI-1avGAa1Wku-00wUmH; Wed, 05 Oct 2016 13:41:48
 +0200
Date:   Wed, 5 Oct 2016 13:41:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 05/25] sequencer: allow the sequencer to take custody
 of malloc()ed data
In-Reply-To: <xmqqzinc295y.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610051338530.35196@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>        <cover.1473590966.git.johannes.schindelin@gmx.de>        <942aa559a0af9b52e079c5c78fa313f49b87d50d.1473590966.git.johannes.schindelin@gmx.de>
 <xmqqzinc295y.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:iWXQVeZdOZzrLX6l+s9yJhOI7pss4nM0diWPGQJXcn9E1EsmhOf
 +9NWAA9g2YE/vm88/m8nFwNzQTlsEYx4vORySaDjTDi3fhCuDL32TePLT6CRBxxSqLR7wF+
 fofXhyUYyezUz8wbDuRz4031VF1uWLq1j1HsCUyOwwTCRjpRnG2sjXi3YN0yr0tJGEa5N15
 cd/5Nd3sUcolu0HlbdYXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gx4SCNXna48=:QosL5wmY97JxZrT2BseszM
 VQEvtFvX605s7a8YivE8OhHbarU89DU92IRPeNQTco7lQAjFENtxBjxnTNLShZV9VhGGGJtyy
 +d8rBzbvvy7Nuc6OeEBgsqcuL0aMouFa1pFi4cmbpy6+kuinpTLE6wgLCXpTMzzfRcEX1Wy34
 Bzoe0uEsMAY0Cfcfw0oKRJKXdh/AZ74gvecYfgHA3En+2umRfEUIL9wwdiYBZsXc6yh+y9xlG
 jh53XZ+9Osh+mUiFfit4uUTdoEBCwFaoSMYnAPi+vllNYwMEdYiEX/cwgYvKOeiAigzzEE3Tg
 dH90vot6Q/VZ4oTBDb9dITnk6jt7D9V4ppVaGwzWOaQx4sqfZhWDJmNNwTX0c0DR4pCsbFIFh
 uHvgDREd/V996BCKYkORGnrLfK9Ttgag0iDBXCrwZE6SBVbWNAhLa/ktvpGkk4ge1xcnCKW2q
 tcreqgk18LpXnPGAHepiZMLDNg2UbluPhMwNVWnQTxVWASgof4zjMgzFS2SP9W/2HkBuhnBew
 a8V+wBvylQViwQURl7q5JKY2Y0H4Lq9sRWlgT0ZPQ8Wp3NqSNpksz2+geuBkhz9TK4f/9tusl
 GrqSSSBwf7jgbiNtWp21jDwAHnUbdiUqv343LHsiwkK+80bFhZxgjrbXsklSMNx2PVKjeUU3V
 VYdzc93LpmjzRFVdU0ovhwIRimQMbAWHoRkAG0zJr4klfGJ8GfxWdUQVbRgFgOZlrPDiytLkt
 BC3QVRSxN2I43XyVr80aNdgOthYOCXEHXQEsQiQExDFVaAnd0+tojhhGwW7j/Ixwa0StK5f8k
 jzoIdk5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 12 Sep 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > The sequencer is our attempt to lib-ify cherry-pick. Yet it behaves
> > like a one-shot command when it reads its configuration: memory is
> > allocated and released only when the command exits.
> >
> > This is kind of okay for git-cherry-pick, which *is* a one-shot
> > command. All the work to make the sequencer its work horse was
> > done to allow using the functionality as a library function, though,
> > including proper clean-up after use.
> >
> > This patch introduces an API to pass the responsibility of releasing
> > certain memory to the sequencer. Example:
> >
> > 	const char *label =
> > 		sequencer_entrust(opts, xstrfmt("From: %s", email));
> 
> I thought we (not just me) were already pretty clear during the last
> round of review that we will not want this entrust() thing.

That does not match my understanding.

The problem is that we are building functionality for libgit.a, not merely
for a builtin that we know will simply exit() and take all allocated
memory with it.

The additional problem is that the sequencer was *already* meant for
libgit.a, yet simply strdup()s data left and right and assigns it to const
fields, purposefully wasting memory.

Sure, I can leave those memory leaks in, but then I also have to introduce
new ones via the rebase -i support.

If you prefer to accept such sloppy work, I will change it of course,
feeling dirty that it has my name on it.

Ciao,
Dscho
