Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8A9C433EF
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 15:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379902AbiAaPv2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 10:51:28 -0500
Received: from mout.web.de ([212.227.17.12]:34425 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235351AbiAaPv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 10:51:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1643644284;
        bh=kg+bQmCP3kIvCN4o2QzALPodQWmMX1lQBwa3FLFW95I=;
        h=X-UI-Sender-Class:Date:From:To:Subject:References:In-Reply-To;
        b=S8YqriZpbRHaheNbiUiwsC6dmXtNNA61miXBO+hvaAI3BHaaBXGkyshANo49spGD/
         i046l7mGumhgRgzY+5rfRVWVZCFtMVdIe6/wvWU1a20EgZzSTqZAJhHTrPge6YvWIN
         F+/i2ISnYbaJanyr1gXmlCVyyXzFNFECqS0sHB8c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHEXi-1n1PnY2WRs-00DVnM; Mon, 31
 Jan 2022 16:51:24 +0100
Date:   Mon, 31 Jan 2022 16:51:24 +0100
From:   Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>
To:     Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Subject: Re: Why won't "git rebase -Xrenormalize -i $REBASE_SHA" do anything?
Message-ID: <20220131155124.u25j4bit3ahusgsc@tb-raspi4>
References: <20220131110149.GE16463@raven.inka.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131110149.GE16463@raven.inka.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:LSmMOFRdzTjQ2hQxNgSBgfAF4QSUB6AILjaLYqD0Y3BmjP+prgi
 KtRieJYXJPrp4bHg1bonUy23NdDuqFOhpZ8os0d9EGvdq2wAzAWDlj/7VcVFICvBcF/D8Zg
 TfZyBBlQxtHsuV1oDOPwByPTCKOnUu8uo5HAPVgCTXVO3AmidB3oUwUNXHFsxHG+RmxkLSn
 J5lUkf4LDXMSIQCExvKMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6ea/cRyu3gY=:xBwL4ps55mxOggyuxfP0SF
 QCoehncs58O5oROqBGk89DW4W/bdJErNJj7pRrwne4dhPUCj16P68SurYbvixqiL+LrOMbc8m
 i+wsYnkYvXKBCR6r/2TNz4v8JONKeGmpxN3/wNgktmxzymMlZEFqidU5vBfqKrcifWSIVgoGB
 EE69YE5NDu9EfSWC9Etu/9asCbRBB0qTCCRGXiNU7mRL74nJwusDK6RGMLvwAkEYJbppMYBTk
 Declw2xTyF2MYE9P622KS9DP5RsBpt36cTXcr5Rc9W25uLao8LANw9zLEIYL/fjSyhfJXqaSv
 obmIW/8cWz2Mq8AQPBGGefjtJuc0sFjCM3Avq4njSGX3hf8W78QYHGXR+G+2rfQbvid6m57PL
 u4yYcRqGvUuLH4R6Sm2GIZlWP86XWB2IZT3oS5x7EAfBgiXamtLZqBs4mM4UgTRsjn/05/ez2
 0rfTlTBKYYniz+KePRmpq+TfefuQdXQe8B3/rL2Kg0ZbPs0r07JCLoib01K1M35mCCxeaVhLO
 IkC09x5Um+9gZuVziRznfU+s+9IWy+lIkqFOR75WwXQ3BdHSUezX81MBb9pFY73d/04ieOubN
 Ke6pjQIRFBVEZ1Qk7ASiZi6H2FDlqzokBYn837zwk3PbOTpXqXx9TLQcnl2EzfDUszr2ozkdq
 vjcpBEzFDv39qb/h//L6Sq3U7NesWoEFQcOlFaPEIcLlwnYq1fJW12vwLvUXJAk+t5OBCD7/k
 xZjvqAShMmAPkL0HqyBEhwp9BalMXnExmQ3qiP+wW9tsqCF8GlyZ76Na+Rn3eoHXHyA65tFFn
 TbcJ1bQW45Laaji14B8MJzhEDQXXdQSz9EjQJxFga5rdTEme90XsI0pD+C+oqZIthOlcxU227
 oDIOstU2NMdusEuq22VBzd38+Dv4chqpH73qQABJo3Uiy8amT3pUufTZIjpQys8PkK5+QE0uN
 qBHnIHnqDGcrHbVbZA8Wy80ySDBTp6Lk2rwKROUirx0AM15PnWteBpIJpC9mESVGuPBoTuu8o
 xVbJxCgywcd5jicUaCwwpSAhv7RWPI6qPfNei5iJ8tya5FtqyzTqdLx7ol9EDq7Eqr1Ge3BuI
 JIzFji4x6qmxGo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 31, 2022 at 12:01:50PM +0100, Josef Wolf wrote:
> Hello,
>
> I've added "* text=3Dauto" to an existing repo with a completely linear =
history.

What exactly does this mean ?
Is there one branch, several branches ?
No merges at all ?

>
> Now, as expected, every rebase operation gives me lots of conflicts, whi=
ch are
> hard to resolve.
>
> So I'd like to clean up the history:
>
>   $ git rebase -Xrenormalize -i $REBASE_SHA
>
> But this turns out to be a no-op? It says immediately
>
>   Successfully rebased and updated refs/heads/wip-normalize
>
> without even the counter which is usually output to show progress during=
 an
> interactive rebase as it is working through the rebase-todo. I can confi=
rm
> that nothing has happened by checking the sha of the branch.
>
> So, what am I missing? How would I renormalize all the commits of a bran=
ch?
That is a tricky question.
If you renormalize all commits of one branch,
you create a complete new history, right ?
Just out of interest:
Why do you want to do this ?
And I have the slight feeling, that Git does not support this
"renormalize all the commits of a branch" workflow, but I may be wrong.

Is you repo public ?
Or could you come up with an example ?

> The branch has linear history, no merges there.
>
> Thanks,
>
> --
> Josef Wolf
> jw@raven.inka.de
