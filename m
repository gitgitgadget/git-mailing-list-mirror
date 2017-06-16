Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A379F1FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 13:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753858AbdFPN4o (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 09:56:44 -0400
Received: from mout.gmx.net ([212.227.15.18]:63396 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753101AbdFPN4n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 09:56:43 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M4Gup-1dcQiY1DEp-00rqN3; Fri, 16
 Jun 2017 15:56:33 +0200
Date:   Fri, 16 Jun 2017 15:56:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Liam Beguin <liambeguin@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v5 08/10] rebase -i: skip unnecessary picks using the
 rebase--helper
In-Reply-To: <a12767b9-a947-e0a2-fc82-fc25992fd0d1@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1706161551030.4200@virtualbox>
References: <cover.1497444257.git.johannes.schindelin@gmx.de> <72bbfcae2abcb14f6b1288051a244faadbee29e0.1497444257.git.johannes.schindelin@gmx.de> <a12767b9-a947-e0a2-fc82-fc25992fd0d1@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jQnXuJUXwLhTEN3LMjftp9Kl/O8a7GBgcrex3vPhS+ClUwjfFhZ
 PxLelgCDn4b0zwe6F9/ZvSjo7Toq7EyqAWzTci+BrImnd8Fg7P6w5jscJseTD5yzleirXSM
 fX8OyFVJOlu5v9LQFqrbSTEpPikPG/lNcn5WSnw0CRpNThTwAst8iPmQldoLDyUZIJl2ZTi
 oqtHPLjW8gPMdePgFIPbg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TIirVDt+ubs=:RIgm2RhUFpDj26dwc500KL
 Q0ojHZWxxPUChlAVJzpFIVsCmOg/eyt9Usxg6ClCS6//g/LmsPMYJEvMA6AdjRPydc8C8C5zd
 s4jMVA//GI6Tk2hNPbmaYtlzSINYiecuPYOr8JBTFzJbd2OUA5H3xxKwF6z8ACW3v9/QiG/1n
 k2cVogXli5HahWPrE6S9zRe86ez1aQkCzBHjlY3XQ4UYv3FKALS7JZk4Cbk5FVvJLNgQ5TGv3
 cf/4Xho2TTSqqj8rfT8SMHEuu/fJcjOjVqQD0n5FsMrV8POV4ErA2WuVx4+WnyGl0osRHx1mo
 8PJz0mLs55HfWf+Zu2htl5/fXchbZVPMh+imM4B4CkrnS29V3uoWnft+/L3hBUSw8FZtZ6t86
 dniDt3gfihH5+IF/m452Hi86A95TQUnYjdsahUfaCkcBgyZefgS72ymZhtteP6fZ4/1PRTN11
 +gKT8rxVe0rYmzwcpq+wFQKxKhGyS0GFl0OWzG78Mq90yTnr1DR4xLX09C81+bQoXN7CABh3+
 aIcWeD+onTDwU/T1+SXQmjk8JB2o9u1+ylgfzEkjn63GetbLKe5DF4d3WY1MnEWugVzTWdCpi
 A6myBb2eIRAbu5ujNNpnGNac9Uu7u4/rXNqWO7dkS+wfu4Rcs4jhRRZEBGFD9e01uj8Ub4wD9
 hF5LVWV7c7dNmZhDwK3Fc0W/RSEOpCi2nq9xDW0O5w5k670dxDm0TnRvbLEoIxOfHeQjetkhk
 1TZJpBwJlaThOXFSS3rx8efaj7o9OxJSoHeNetWmon0mKTrTCMe5wFb5jwMWRG8XDGI12BptR
 kAP0abE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Liam,

On Thu, 15 Jun 2017, Liam Beguin wrote:

> On 14/06/17 09:08 AM, Johannes Schindelin wrote:
> > diff --git a/sequencer.c b/sequencer.c
> > index a697906d463..a0e020dab09 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -2640,3 +2640,110 @@ int check_todo_list(void)
> >  
> >  	return res;
> >  }
> > +
> > +/* skip picking commits whose parents are unchanged */
> > +int skip_unnecessary_picks(void)
> > +{
> > +	const char *todo_file = rebase_path_todo();
> > +	struct strbuf buf = STRBUF_INIT;
> > +	struct todo_list todo_list = TODO_LIST_INIT;
> > +	struct object_id onto_oid, *oid = &onto_oid, *parent_oid;
> > +	int fd, i;
> > +
> > +	if (!read_oneliner(&buf, rebase_path_onto(), 0))
> > +		return error(_("could not read 'onto'"));
> > +	if (get_sha1(buf.buf, onto_oid.hash)) {
> 
> I missed this last time but we could also replace `get_sha1` with `get_oid`

Good point!

I replaced this locally and force-pushed, but there is actually little
chance of this patch series being integrated in a form with which I would
be comfortable.

Ciao,
Dscho
