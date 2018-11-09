Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09AE01F453
	for <e@80x24.org>; Fri,  9 Nov 2018 17:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeKJCyq (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 21:54:46 -0500
Received: from mout.gmx.net ([212.227.15.18]:52657 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbeKJCyq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 21:54:46 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LmKag-1fmNp13vRi-00ZxeU; Fri, 09
 Nov 2018 18:13:10 +0100
Date:   Fri, 9 Nov 2018 18:13:08 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] rebase: consolidate clean-up code before leaving
 reset_head()
In-Reply-To: <20181109100357.GA7410@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1811091750330.39@tvgsbejvaqbjf.bet>
References: <pull.72.git.gitgitgadget@gmail.com> <64597fe827021383ab68cfb247de61fcf104a961.1541756054.git.gitgitgadget@gmail.com> <20181109100357.GA7410@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:p5Bh/aE9/0j2qzbdpeNFS+yTrXJ/AlIopATb5LhV0BCBtcFJ/1u
 t+t0lqPveZdKPyIuRM6L4/Ev4G4x44D4dXMfa1UH/DJpEENn872vjnKhl8ZkVMyAx1WmW2t
 eGVMZ69ez9y0uMqYTA4dg6PqsFaRNjJIKeKMvzJMgBl9dniI/c3fl58BqGdY/sgZKFyp/+i
 2AN9zITvCamgOepP1BmrQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NO3xelL8Hyk=:uOCN/eVTBCZa3DXMGfrNg+
 vHj4zyeWLLSQWcXZE3jf5ImzqWTaDK3aSexOFcsMcIAMJxKz56MfFtn6rFxj6l6D43CgYgP/w
 VlP+qD9NMeTRdf7PVq63wnCmg4FvV3jpw6E3oU3VjF2dU/+/pVizKC5q58MDbXMT9dzm5ZWQP
 vVrG5xu+1TK70NSZoQbyXKOT0iZID5rZ4tkD9MuWMrbQeJq5cIF5MMX0xYGXgiFaPB+zSsEmS
 UmEYOVlYiNN91B2Yk2/QHNbvRHu3KgVUFf2k64mvd/VGpWZeQSvNiSCXd040rsPwajKAB9Gey
 hLiphZsR0Q2F75FEoPZB1bSCMqtMLDbZlHOMKksd3CS1nnzdsbXcJk4geaZwH56B4xe/9yoX3
 5nbKKtLBE6lQ53KizqIYUtjIk526UcFppf5aLN7BVpKgmFWxWN+Ih3GQqdQXrhjFjNDdMT0Gb
 mWSa/jo2I0K/t7JRRN5Btk9ShiGJ3I2l8yl0HX5sRbfR4uVXQl8YaOkCyRP4QyIgffwP46AO3
 dSk7SVnJ3/pdDdNJK5Mk3UiC8cWw8fPp0j7dDxihWyva5erQuVnvJXIxPuagQ6LCeldtffiia
 EV1Er2JjozeFJ5C2LeBgogPRGp02En2wTTiy63nvlcJrDa9hpzKdl/5Fjol91Cu2ZpvCBVOKP
 xMe79UCmQAV5JjMaNXOqhbezz9EUGvykKWOTEMmm5wcqq+oGl6Ika128Lt+4OGKcWJCqQEqwe
 StN9m/6ZcSM3So6NMnOEY7PrVWS1JPqasVjFu/DXNDM97ojQ6JTeuWSkQcPVDyjTsuTvx/OP0
 QZjMtrTxW8Kmf7J0C4cANV2o9X8/peaziNHkuEuH8yrl7XCKRIpGD40iQjqc6DFDblGt2A9W5
 IkAaiEEae5Fe6ok9F2VpKllLUTqV6rMwjOoVTpKYW2Upkf3psFMi1hV9Ov3Icj1eu9fW0NZsh
 QIdqS18NR9Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 9 Nov 2018, Jeff King wrote:

> On Fri, Nov 09, 2018 at 01:34:17AM -0800, Johannes Schindelin via GitGitGadget wrote:
> 
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index 0ee06aa363..6f6d7de156 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -569,16 +569,13 @@ static int reset_head(struct object_id *oid, const char *action,
> >  	}
> >  
> >  	if (!fill_tree_descriptor(&desc, oid)) {
> > -		error(_("failed to find tree of %s"), oid_to_hex(oid));
> > -		rollback_lock_file(&lock);
> > -		free((void *)desc.buffer);
> > -		return -1;
> > +		ret = error(_("failed to find tree of %s"), oid_to_hex(oid));
> > +		goto leave_reset_head;
> >  	}
> 
> If fill_tree_descriptor() fails, what is left in desc.buffer? Looking at
> the implementation, I think it's always NULL or a valid buffer. But I
> think all code paths actually die() unless we pass a NULL oid (and in
> that case desc.buffer would be NULL, too).
> 
> So I think the original here that calls free() doesn't ever do anything
> but it did not hurt. After your patch, the leave_reset_head code would
> continue to call free(), and that's OK.

Right, that was my thinking, too.

> There are a few earlier conditionals in reset_head() that do only
> rollback_lock_file() that could similarly be converted to use the goto.
> But they would need desc.buffer to be initialized to NULL. I could go
> either way on converting them or not.

Whoops. I should have checked more carefully?

> > @@ -586,10 +583,9 @@ static int reset_head(struct object_id *oid, const char *action,
> >  
> >  	if (write_locked_index(the_repository->index, &lock, COMMIT_LOCK) < 0)
> >  		ret = error(_("could not write index"));
> > -	free((void *)desc.buffer);
> >  
> >  	if (ret)
> > -		return ret;
> > +		goto leave_reset_head;
> >  
> >  	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
> >  	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : "rebase");
> > @@ -622,7 +618,10 @@ static int reset_head(struct object_id *oid, const char *action,
> >  					 UPDATE_REFS_MSG_ON_ERR);
> >  	}
> >  
> > +leave_reset_head:
> >  	strbuf_release(&msg);
> > +	rollback_lock_file(&lock);
> > +	free((void *)desc.buffer);
> >  	return ret;
> 
> We get here on success, too. So we may call rollback_lock_file() on an
> already-committed lock. This is explicitly documented as a no-op by the
> lock code, so that's OK.

Indeed. I did not check the documentation, but the code, and came to the
same conclusion.

> So overall looks good to me.

Thanks!
Dscho
