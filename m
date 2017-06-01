Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E731920D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 12:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751090AbdFAM4T (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 08:56:19 -0400
Received: from mout.gmx.net ([212.227.15.18]:62049 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbdFAM4S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 08:56:18 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNZ9u-1dElkt3rUQ-007EQ9; Thu, 01
 Jun 2017 14:56:14 +0200
Date:   Thu, 1 Jun 2017 14:56:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH 2/3] rebase: Add tests for console output
In-Reply-To: <20170531104213.16944-3-phillip.wood@talktalk.net>
Message-ID: <alpine.DEB.2.21.1.1706011329350.3610@virtualbox>
References: <20170531104213.16944-1-phillip.wood@talktalk.net> <20170531104213.16944-3-phillip.wood@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4WQr8v/bpHR5Yn4uvRwv3+kdchmvvCAmch5bu9dD1Gzq9mCz+C4
 TYIFS6s0x10rae2M44odRaw+1+cebkSvAgE2hqSOr85GfI2txi7Mi+bf7hP3dMHTb0wBdyl
 HNCEHUuuSi2ezEXlPhlLuBi9YLdjo30jdJ7p49apzXZ9QJIUX69WpXhR5v+bawX9Gddp0m6
 QVgZBto0G7UEYQO7a589Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BgNCiMiSUCA=:1OwGG/kAaF1Aqf+MRfmGqG
 Z4VOydvxmHTpqzVkqOZSkedpjjDxjwsjvf5ph5fCK5ac87XLR0/V2atEUmYfQzuq36088w4vj
 YJLXvl+riRFLrnDvNejTn4pLJhZRhfXPBPfN3uiaOuJvzGtK6qWZvOkzxUM0V2U288p5zLiUs
 n/4F5SXKPwUw8E2BENfdCjR0TpEU6FJhuqqKRQnFNkA6+0l7BmQilx0o3cVLOXTtJi20pgY+F
 CwlK9YepC0hJ2ysgAE/Upk8BeMh48eJ45Z1WNA57LgPqkylYFUUuMDJsCMzLaRzZ74cGQeWZ6
 GrQDfUY/94tgLCo8J/ZObjtDFv4RLrmUUdpeX1/O6Gs0w5gtQqPQaUzGch1+wTz09GPpz9F8Y
 jcLhBhghYeGANNKYrTa6nW1HpbRzci1k3fkW3wSQuWjyFK2POXH1oWQRipUtBo1CkrfSms4xL
 qSh68MT3jxUnDIRGzAbI2GcIg+EemczrvLM/p8ePSb2bXCzIFrrOLpH9VH+5ikEJPxpsPV9t1
 3r/Iwxg0Pw3PS0b1zwIFoxVFcCfOCihL53W9gXOXhP1kwoPnZfZR6+yHo8C2N+3W82bBFCPRt
 6he+MQK0mSQv4lZWuYI9Hej1XKfrzq0ZEjXRN72+5e5YzUUlaTfoda1vfQ2VQfQs2D8nnKqrp
 GySAIUFrEi5xjd/ETQUrFgpti30lNJkFhL9iEMHXIqErcgwvoHG9F8uf0Bd3CsgDVc6FjqZq9
 89zdAkv/ceSfYtjxU8qm0mE3c8IuvecC+L0KsatW+YulgQ7du/JdQ5PSRk1znb3GXk+8+ut3B
 HZhJskc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 31 May 2017, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> Check the console output when using --autostash and the stash applies
> cleanly is what we expect. To avoid this test depending on commit and
> stash hashes it uses sed to replace them with XXX. The sed script also
> replaces carriage returns in the output with '\r' to avoid embedded
> '^M's in the expected output files. Unfortunately this means we still
> end up with an embedded '^M' in the sed script which may not be
> preserved when sending this. The last line of the sed script should be
> +s/^M/\\r/g

Like Junio pointed out, this sed script would not be portable. To
elaborate: there are two major variants of sed out there, GNU sed and BSD
sed. Typically GNU sed allows a little more powerful instructions, e.g. \t
and \r.

But we should simply take a step back and ask why test_cmp is not enough
to ignore the CRs in the output?

Also, about the commit IDs. As long as the tests are consistent (i.e. they
use test_commit rather than plain `git commit`, or at least call
`test_tick` beforehand), the commit IDs should actually be identical
between runs and not depend on the time of day or the date.

The only exception to that rule is when some previous test cases call
`test_commit` but are guarded behind some prereq and may not be executed
at all. In that case, the precise commit IDs depend on the particular set
of active prereqs.

But as far as I can tell, t3420 does not have any test cases guarded by
prereqs.

Taking an additional step back, I wonder whether we have to hard-code the
commit IDs (or XXX) to begin with. Why not generate the `expect` files
with the information at hand? We can simply ask `git rev-parse --short`.

For the stash's commit ID, there is no record in the ref space, of course
(because it was created with `git stash create`). But I think in this
case, it is legitimate to simply grep the output.

That way, the test would be precise and resilient.

So for example instead of adding the t/t3420/expected-success-am verbatim,
you could generate the output via

	cat >expect <<-EOF
	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\\$" output)
	HEAD is now at $(git rev-parse --short HEAD~2) third commit
	First, rewinding head to replay your work on top of it...
	Applying: second commit
	Applying: third commit
	Applied autostash.
	EOF

Ciao,
Johannes
