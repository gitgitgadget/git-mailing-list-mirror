Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B317520195
	for <e@80x24.org>; Thu, 14 Jul 2016 08:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbcGNIJk (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 04:09:40 -0400
Received: from mout.gmx.net ([212.227.15.15]:58141 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750739AbcGNIJe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 04:09:34 -0400
Received: from virtualbox ([89.204.154.227]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Ltr89-1bDXbT03ef-011ER3; Thu, 14 Jul 2016 10:09:30
 +0200
Date:	Thu, 14 Jul 2016 10:09:28 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Benjamin Fritsch <beanie@benle.de>
cc:	git@vger.kernel.org, Brendan Fosberry <brendan@codeship.com>
Subject: Re: Multiple Keys in ssh-agent, fail to clone
In-Reply-To: <CFA91608-1F29-4631-BABC-258404A62A3B@benle.de>
Message-ID: <alpine.DEB.2.20.1607141007230.6426@virtualbox>
References: <CFA91608-1F29-4631-BABC-258404A62A3B@benle.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dLLVTGM6HHYBz6HVl+uvvW/F4cQBM/MG2V2LXHXzXuSgRGuYpUb
 xRM4ptJLSJCS6ckMSobwACcYrFwExkcUbStc+Kp39Ylc6iGSOVDYooDh82jVgXiKDt4IzH0
 zGcfBOUfoMUTnyyo+bHt6x5oR2NmOle/sFHPlvYBURbqaLOyfKSCXqL10fBfhWrU+amqGGA
 w1qsztG4kY6JeVtbDPItQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:hajbkDiL18g=:Wi1Xenl4VwMNVNInlHGy4T
 lL43SOKEQs2MdJizLj+NWhBPce7u9KqJuC/Buwz1qUkV6V+VnjemPDq5Ybp+sKrC91NGNHHol
 f+Hu1py8jffrGiLCkTPdGBWKJj7FDH7AUisETTut3QNWRBoncERvNi5ijARLAvw8CavLfV3MY
 yeCP+6LADDnx1mO8wvl6jsByFXyhrVedqjL43u2252tW/JhakCzhiuXaUV9+osgXrW4BxBZ55
 8nO7Eh2/sbAGryOQArmnpvaBzm1chxlQwFw4XxJ2Am6NNcuK47EueheAhwgL30y1rn7gFprcn
 oLl1KtzzfqIRAmoFgIx9TZrUCLVlKxPd9FCrpLkDyYg6sFdu7WzQ5oue/FLTWfZfEG3dAGJQk
 +pCuvB6y9UR1UohIDtod6MljuH/EuOSInXL26Ca/auhZh1qneOa8IsihS24wHFcdIHb4PW1bu
 kazX9nHlTdZZcKT3QXsreaVxmvGGV+wVTE3OepKYHTEVLBHSmIMDmwzLJpgWYw++7aDN2umgR
 /QFauAuPtOao646zus6/yk6A597Kw0G2F8Wp8AnIuL9FNsjp/j/dBkCnglnHES7SOzYq5cgL6
 psVHeYhcaqSi7haJ/vKCrvKcrN1/CjC074DSf1QQKVZjqxCZt6IUafPe70azR8CLqbh05WaSC
 WLdPJakvIqSgsIL9lxlvGUgxeFFizpsq+32rL4JT9scLZ7MqTv1UNq8Omz0lcu57OX6TH0Yfc
 XYkkNhZbGldWw5uibbmpohmABxn0lC+6uP71gGqubv2QAUS0+ZYpkT06sn6y8WCMJIPIKrkfB
 kz5zWsq
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Benjamin,

On Wed, 13 Jul 2016, Benjamin Fritsch wrote:

> I have two keys.
> - KeyA (my company that has access to the repository I want to clone)
> - KeyB (just my personal key with access to my personal stuff)
> 
> Having both keys in loaded and listed in `ssh-add -L` fails to clone the
> repository. I tried to change the order of the key in the agent but
> neither KeyA, KeyB nor KeyB, KeyA will work. The only case that works if
> I have KeyA loaded an no other key is added to the ssh-agent.

I once had the same problem, due to a server newly closing the connection
directly after the first key failed. Note: the problem was the *server*
(that was updated at the same time as my local Debian packages).

The only remedy was to specify the exact key in ~/.ssh/config via
IdentityFile.

Hth,
Johannes
