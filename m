Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA6391F403
	for <e@80x24.org>; Tue, 19 Jun 2018 06:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937276AbeFSGwX (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 02:52:23 -0400
Received: from mout.gmx.net ([212.227.17.20]:58997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935759AbeFSGvz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 02:51:55 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MVedf-1fi91d3lBn-00Ywn0; Tue, 19
 Jun 2018 08:51:19 +0200
Date:   Tue, 19 Jun 2018 08:51:27 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     Alban Gruin <alban.gruin@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC][PATCH 2/3] rebase -i: rewrite setup_reflog_action() in
 C
In-Reply-To: <CAGZ79kaLSCXSDHN8=L-FCBvQ9jRJqit6VFNK3VmHm9H07ThEsg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806190848320.77@tvgsbejvaqbjf.bet>
References: <20180618131844.13408-1-alban.gruin@gmail.com> <20180618131844.13408-3-alban.gruin@gmail.com> <CAGZ79kaLSCXSDHN8=L-FCBvQ9jRJqit6VFNK3VmHm9H07ThEsg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NKPZyDQBGNmTg9kzEYugvlcjvRuJEgx33rKxo4dj8HRRLs9PbsM
 TAWlqhqnofvfCz0nV9lqh8ofe8Rfw6CIkM+O2xgqPxJcrwuU3Bc4D3yvr5vxcq1/tChNE39
 hGvvO6lcCkBJ4zatOaIGicgUOoOYOmLUhfFw0hjlpOw2r2yLCPU1ywMJxqciac4Jq7itJTg
 O5YBao17DHKj0qpqH1ODA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Vsl7TE+XuGg=:8oYVHKQWqZpRo1iYzBx5qx
 yrH4eBZ59NvfAyC/jS/MVeEavrcdJkF8vUQrbR2kHcgHEiW0DrVwPnim5PPaLpmGK48y7n9Tg
 XhXqkIBuDQXRn7cpxwsvhbNoqdZj7i7IWDbJvJ4eABnZ0htPIT6XfPxMzuCGHkJQVrMXyVi9h
 Rqx/pFjauT5Aq390LZiFhdHkJ/mgsF2rDYn7G8TdEcc/TaxDtUddmYTmwW8TcK0uaUU0uDUtk
 XGkRuQvoON6WPW1xAxyhs8sdtIOTa4cEabVBmA6SJSyxVUB27qRq7riiC3H7IL+UZfPFqEQwS
 lkKH9rRpIwxk8IuDhAInlOLSRj7fA1EX3oQLEQExNuNEkxVbQfJ4sRsdWUdN86JPkD+Rx70xJ
 E7FsiPJmKQUN6bu+Lxa33jmGSyIfjJS+VmfU5t0b7DKc6x3cWXU75Di5O8aZBKiyGOb/Izr/F
 I5pbCc5z1/1kY+vRNRmfFKauYrdm+mOmIwxD8lFXm2P8KZ3luLt0gFJD7h3lqB8QnzyRXe+Xc
 XuE+BGcUYS8Bji1ZTZsney3ahnMm11Ri0yZkgIrhJdkyYdu9uY2ou2Rs9pWjkdKiUg7FjXpMX
 EvoT0MEEmWsCXaUFrBtuw3RMo2dWEWEXXU+2RmqxqUOj0TFs/jLdb6XhUm043M/0GfXwWJNyi
 EeLNb+3H+3eJ5KtF7sIHDzEcp9ohq9klSM5Pzoo3GVZsChsq3XA/1PYyQA4+KfD4BubQatN1W
 j9hWF1SJJe14JVdo0nPv1u4VVWszCuEG2y4dilaEuVHykY7FodVUgzXfNlBvIsCYmI+vCsgYT
 WHwQOLf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Mon, 18 Jun 2018, Stefan Beller wrote:

> On Mon, Jun 18, 2018 at 6:19 AM Alban Gruin <alban.gruin@gmail.com> wrote:
> >
> > +int setup_reflog_action(struct replay_opts *opts, const char *commit,
> > +                       int verbose)
> > +{
> > +       const char *action;
> > +
> > +       if (commit && *commit) {
> 
> While this is defensive programming (checking the pointer before dereferencing
> it, the first condition (commit == NULL) should never be false here,
> as the caller
> checks for argc == 2 ?

But it is not marked as `static` (or is it?). So we should not rely on the
caller to Do The Right Thing.

Ciao,
Dscho
