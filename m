Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50806205C9
	for <e@80x24.org>; Sat,  7 Jan 2017 10:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941415AbdAGKvj (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 05:51:39 -0500
Received: from mout.gmx.net ([212.227.15.18]:63926 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932659AbdAGKvh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 05:51:37 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M8NBi-1cdNVO3ThC-00vxOI; Sat, 07
 Jan 2017 11:51:24 +0100
Date:   Sat, 7 Jan 2017 11:51:23 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Brandon Tolsch <btolsch@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>, git@vger.kernel.org
Subject: Re: [PATCH] rebase--interactive: count squash commits above 10
 correctly
In-Reply-To: <20170107082318.jj3izthx2ylscrns@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1701071150490.3469@virtualbox>
References: <CAMWRQeRaQQQcJ-R8eHc7f0KqZF2eEkYJOyTb9n7ds78pTqV-AA@mail.gmail.com> <20170107082318.jj3izthx2ylscrns@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wN90xs9Y0Fe1CaDNAlg3Foht1ZK5/8KEfKkEiGrvfuh3J4hEhRS
 c20s0uPD3ckyBC88Igv7+PfPAzifTUBgnzWfQbQHTVOzylYqAxYqUf1yDfeyD7BPB/d7XO2
 q8qExGsBTwWa1QFaZ5xuEQcn8prVszP7hAqy7446dL1QLZ82m2y5GyzWZHEZnvw0LCi9WE4
 g+OCSe0m4a3FtOaZZW2Vg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:m8Miko9L+cY=:G62l0iJqLXkauHsCZlOBcJ
 EkOqnf34qBLKP4gTXI/ICUdoWtP2UZH4T7JvcMsKJWpxjalYXY02KkuZZjPhXmx6HmV3ZEDz5
 l6de+yxlUu+l4nv51NXF7XnwHTdFz/OKx7uF+MW/K5WhvJFWV+0qHPw1Az3Rfk+AMyC05Umej
 Ciflu9WKCA2yv/cVvdwGxDwLuc/Fx916aTOZhzWUStVmwT64AE0sdZSEWRN6FtYEDMEZ4EZrL
 8lExoOjnPj24nrh9FSQjPn2LmXcJJqgrZVWyYnyIXbu89FSY9ZQjSb/3dFJNlRa23NpIqAx2u
 zH3JDsufuw6x2ebT/dn6ocIdroF9DLzxxIrgVoQF/7CGAj1u+rSqDXF5P6q1HJCW9uDhgn7X1
 hQdCaGdF27yHmJynCDi5qBLmCcHZn5F8mh0SV+BIRW7RZAKDlZ30U9IJ5AUbq8+uhtmN8KLc1
 RsROWII0rJrp9HVqo9DtgHmMYzryACi+1QerF7SA8Wr9SbSt3ihiqFRWtSPSHFaTQbJAjIsq/
 jtkB61ZAAXnjA+3H1iCm1hOGx8pV9FlFuJnzz7F0N/Awoohr0pLTskr/sDoVdWcENsfBNwdRu
 AIJI7aQGIvgD0zNcy+AMOjNGKSFHWh2f7zv+qfUzTuwi0R7v2cMS0xgb4Gu2l1lXmgEovNutO
 b1jhXxw5U7xjgvNMmp0VGdwSQG3OEIf1hzCdVwuN9/Exo46IyIoaJE0t0JZOd+7d4nLUwPgXo
 aneQRYOoVdmFVm1X1YCOk8TXuILNJmqVAo87453XURzib8z+y0Lv8W8Y/n1b3xB9D0uJMvzYB
 7EVScfX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sat, 7 Jan 2017, Jeff King wrote:

> On Fri, Jan 06, 2017 at 01:04:05AM -0800, Brandon Tolsch wrote:
> 
> We can fix this by making the ".*" less greedy. Instead of
> depending on ".*?" working portably, we can just limit the
> match to non-digit characters, which accomplishes the same
> thing.

Or we could simply require a space before the first digit, which would
maybe look a little simpler.

Ciao,
Dscho
