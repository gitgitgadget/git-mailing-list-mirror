Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11A3020986
	for <e@80x24.org>; Fri, 21 Oct 2016 11:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755066AbcJULnx (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 07:43:53 -0400
Received: from mout.gmx.net ([212.227.17.20]:58906 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754732AbcJULnw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 07:43:52 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M4B71-1coPhl3Mpf-00rscZ; Fri, 21 Oct 2016 13:43:42
 +0200
Date:   Fri, 21 Oct 2016 13:43:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 20/25] sequencer: refactor write_message()
In-Reply-To: <xmqqd1iug42f.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610211343310.3264@virtualbox>
References: <cover.1476120229.git.johannes.schindelin@gmx.de>        <cover.1476450940.git.johannes.schindelin@gmx.de>        <9a66d53ebd86d35136597e534be03605bb1346bc.1476450940.git.johannes.schindelin@gmx.de>        <xmqqh986g49i.fsf@gitster.mtv.corp.google.com>
 <xmqqd1iug42f.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WLizvt8upGA84wWjyRrAALMG/lq3rGaLy6Z6qmr2voLGAUJEmfC
 eT4YcUAmt7W+a1wfkNOs1o+HbBdKEwkCPdeLpcwlPCdYF9wkwq2I/bRO4GBmg/dBK/VwiHv
 j90jlrUxmJIhQrr1MdgPbP/jMMIiqk/iqWONXpsX+7sx40mgtrB3m6sY42PfdegSde53jD9
 NGL0cg+9yi/n9ghWg5nRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rpyt38npooU=:CcFac4O3AMBGkki30CokXc
 XbKzo1xY44zsInEVT0N1QrBdeyYhMudKttZC0NAVJKLoWKfMsgaLu/byM3VYE4q6PJCDIamv5
 ET3JNfH9LOod8TnORqZ+L2LljjuckoyNNQS4ZTqORvQ3EWdyhacMrIRwCtM1sATG0vIy/Gwo9
 HOP+eJ4x9UGW9j5kLWukSVi3YOCDoqhav3JzKVBXBeql3ivkGb/PLC7FqMxjP7rSyVfLKW93R
 +n1ZpvCVXwH0v216VTdgpaaXkb7HTmKxRqo//JhfF2cVh8ejs+X2LfgT6Ju9UbKVvWt29UK1c
 2e//WcWiTBbZTl/CD0f1k9qYM6wNYEr+Az/UmGR73fkK4p/861XQaLUhvd5M4c79LLYYwujwa
 cnXLeqFOg6/TsnfeXscnMFgVYUcivGVkQI8ptDSjw1UB4rs+t0vymzGUgUrhsP9toDeMEhhR9
 n3b1WyG3vCb9btMZy1zzQk32dzoNQX8I4IOhF+IGl28dEb201jbJF7p227qSVvA2GPyWPg3T6
 0thJdJ51mi+WSf+t1f7NyFeubomRZYsZtP/LKC3owvV925DzsIWTuvDB2YU/aSgD/lcIexc/R
 HMkPMJA6LIaEHwuXns6NelhEmO7x5gtJGm5CFpTmnYu7yhGuKjckz0RH6vdyg9xMi1O1ch5+/
 ynDzfibkSJLPYdBp2HHU7g3rR1pVt5p77hEv1ATsbWEVPM0FFXs6JaWSfIeAbo5EjqKnLd3Z0
 1caq78+D+p33k5sDNexgTWuo5UJYO3IaT8XkyF8F4jK57e4KMAqfUhJdKApHEJDfjn10Q7e/f
 q3BdzO/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 20 Oct 2016, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > If I were doing this, I would make this into three separate steps:
> >
> >     - move the strbuf_release(msgbuf) to the caller in
> >       do_pick_commit();
> >
> >     - add the missing rollback_lock_file(), which is a bugfix; and
> >       then finally
> >
> >     - allow the helper to take not a strbuf but <buf, len> pair as
> >       parameters.
> >
> > The end result of this patch achieves two thirds of the above, but
> > especially given that write_message() only has two call sites in a
> > single function, I think it is OK and preferrable even to do all
> > three.
> 
> Ah, make that four steps.  The final one is:
> 
>     - add append_eol parameter that nobody uses at this step in the
>       series.

Done,
Dscho
