Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E847C207B3
	for <e@80x24.org>; Thu,  4 May 2017 09:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750773AbdEDJTi (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 05:19:38 -0400
Received: from mout.gmx.net ([212.227.17.22]:49536 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753144AbdEDJTb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 05:19:31 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCxfb-1dEhFB1pI3-009fDx; Thu, 04
 May 2017 11:19:22 +0200
Date:   Thu, 4 May 2017 11:19:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Lars Schneider <larsxschneider@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] travis-ci: retry if Git for Windows CI returns HTTP
 error 502 or 503
In-Reply-To: <20170503215015.17949-1-larsxschneider@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705041118190.4905@virtualbox>
References: <20170503215015.17949-1-larsxschneider@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jzfmYpBWOUGafHwYErceWH69AiY3Io15HSnsBdhky2+UcSUlLcr
 ZU5MgMXNyLV/gCQwJxkES1rceglST9K1XmfnbGvVh+rQnu6l5KxLJS5qMKRTOrfjkE44d4/
 ApZvX0eT545JmQZ6mJVwc7C/2OIqh0gxZ/vAY7fAlP/H3eQWtY2nT9qrt0zkR0h9P+G+Vqv
 jJ5fiINCJvA0cE+fL3dIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:43vhXMJcEFw=:X1gQlw5sm3Yoxw1D+K/aRd
 wxQKyHsu9UYXiSklY4fEYaV5RhCEEWvEao5fNRP6W/wbGm0qIXBUg2aHp6EZ3N41DHEf0dkjt
 2okx2hcyTnQWC8KjZY95b7lc+9A91EKsXM0HmUhBS/9z0un02qBbwIUb2hfUQFRY6kOdPh8uH
 ccdchbz8J+jARb8Kb/92Tp3cvFvC1oisaXCjkrnC6Fx9nVuD5mh+8YFqWCKmnMbUv+Gb2eQmO
 GQD7dGzxhzmZpQQP0uITOBRAhLckejx34Wc8xQjHWR7MxDV0sRuySoAIhXIVxsS3sgkw+qqct
 nU0aBZ6RnD7J7qb8w1XyIRpiwlwD4y3257jBLxzxrhG0byfOfwCXptBoTBBexj6PxxLsTLrtc
 JL7Q64hRBIzwVAtb8pSuokeRI/O6cHiVB1rZF5DZmd1bXO0GDZE5TcmtTQKaCV5t/i9gdy0dy
 WQumCNktqfc3ix7ddOZeODP8RAqwozYwM6phjH9mYZIXVsFZTn9UhsmHdM8wTg5CrJsj/tn0I
 m1GHHKCg+EOusddYGmz3YYr9T5hWCHBYuw7u1ihXPahncmxdQtQ5pe6onJLGwzznrKyCTdUuC
 1gZisExmCfmqFrUVvubJdo9qcEg3yANNie0iKwGHJZoX9pwVnQG3ZRCQc0mjb4vjz1joDEi2x
 Ha8dVfFyvsXZVhK41VOQBkGVfdtoO7Tp4fsJYJiKjaoQb05vtLST6Bz6x5X+q5IcZBdmjgBej
 9pmsqbqORmSh/0zW8T/r2SzCz7x3Op1sCKcb4ldXZuG3SXzmPr1oRi3UQcNEZ6n5lg9Gp0Fw1
 6DmThA9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lars,


On Wed, 3 May 2017, Lars Schneider wrote:

> The Git for Windows CI web app sometimes returns HTTP errors of
> "502 bad gateway" or "503 service unavailable" [1]. We also need to
> check the HTTP content because the GfW web app seems to pass through
> (error) results from other Azure calls with HTTP code 200.
> Wait a little and retry the request if this happens.

Thanks. In theory, it would be better to fix the web app to pass through
also the 502 error code, in practice I have a hard time finding the time
to make it so ;-)

Therefore, I would be very much in favor of the current version of the
patch.

Ciao,
Dscho
