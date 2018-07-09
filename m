Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 842E61F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 07:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754433AbeGIHxe (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 03:53:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:34581 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751321AbeGIHxd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 03:53:33 -0400
Received: from [10.49.91.56] ([95.208.59.25]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MAkkB-1fmeeS3CXL-00Bq7c; Mon, 09
 Jul 2018 09:53:27 +0200
Date:   Mon, 9 Jul 2018 09:53:14 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Daniel Harding <dharding@living180.net>
cc:     git@vger.kernel.org, Aaron Schrab <aaron@schrab.com>
Subject: Re: [PATCH 0/2] Fix --rebase-merges with custom commentChar
In-Reply-To: <20180708184110.14792-1-dharding@living180.net>
Message-ID: <nycvar.QRO.7.76.6.1807090936230.75@tvgsbejvaqbjf.bet>
References: <20180708184110.14792-1-dharding@living180.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FF2y+1oEejOJ9DS2MRKWjIkiITqecpQqFe7bND1ReWR2cRACoY3
 ftToDYjVqH00z8BzGyuo0qdNdBGKuDRTIqJHJkuwn69QXNcliHTYtVXobwlvZaXXZWLVPr+
 NZsV+SHvCr9DUZoMc3Eyh30eR+w/x8nmYo26kSeu4ZpsOocnv84jd5m1zy65hk7M0of8/Vn
 rEmqSuW/4MUbN2UaYw6sQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3bVrQgpVXiQ=:5wYQMa4yP8dRdQBotOu7NI
 r51Yt6Sc2H7Nu3ZTXvV+EukoeV5AP7txkX1dH+pD85A1Cg5GUL4IWBH73HVNf2vDLNJQNyTlT
 MAadCP/m6mqRCcJM5k7IQZ/fziK9PrdhMwf5z1Y9Y5ZNQ9P7dCnqaSn8GggtJ34jQoCQBaujN
 ked4Fj10xnzRu9pgQ+pYHDupS8h2HYsOiYfrA05ZpIZzfjdBrv2ctfFfs1Goor5kx8l5GKoxN
 zVqCnOSa47uz+ST6ZiaFzH+r0/oQ2031URMJQCs5e0PBzrkKwRn0hjcJsl1msi6v2vTPql3ZW
 j0szlN+ttZbGRa6uZG5ejPVE/s3EZSQ4VNo387uceUN+hpkVUzOWQURdcykA260sonZX6kmcg
 r2Dml7rvnanlZvmu/3vIi7Z65y1Y0Iyta4GQQ/NzLsoMOLzQbSs3NA9ENZfQjOPVLuto12O8I
 FxSzJ8eWNk782ZXuDbwV4m6DCTlY6Uhsqyd8uKvRj4WmdLlo/np9ySI2rmzHpPKooxE7Ze6MX
 jukvE/eEPaHrA376RQ9jE6HvNvLl7CljJMt9m0VwGgDsxMx5nT6beOeA6OvjTHxjxZREoVFIO
 0fClEAkM2nXLFAS7aHQpTEgT7A2W4Zw4h776EywRzsyog5Mmq6I7z8ynkXKD1q6eW9U73InDh
 AJ0SYM41JX+zWGEXVia7egqTfuwa0u4dGguE/yo4hGUTaHqVdYVhz2hSpgSwFCfz+crJ4O5ro
 f3HPYqSUE/kOZwuO0TNJbxFEGh+uqldrUwttqypXPWc86egDXFGnVEu56Ua+gpWjW5tauibEo
 wCQIsg4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Daniel,

On Sun, 8 Jul 2018, Daniel Harding wrote:

> I have core.commentChar set in my .gitconfig, and when I tried to run
> git rebase -i -r, I received an error message like the following:
> 
> error: invalid line 3: # Branch <name>
> 
> To fix this, I updated sequencer.c to use the configured commentChar
> for the Branch <name> comments.  I also tweaked the tests in t3430 to
> verify todo list generation with a custom commentChar.  I'm not sure
> if I took the right approach with that, or if it would be better to
> add additional tests for that case, so feel free to
> tweak/replace/ignore the second commit as appropriate.

Nothing is as powerful as an idea whose time has come. Or as a patch whose
time has come, I guess:

https://public-inbox.org/git/20180628020414.25036-1-aaron@schrab.com/

AFAICT the remaining task was to send a new revision of the patch, with
the commit message touched up, to reflect the analysis that it handles the
`auto` setting well.

Your patch adds a regression test in addition, which is very nice.

So maybe you can coordinate with Aaron about that first patch? I really
think that the commit message needs to explain why the `auto` setting is
not a problem here.

Ciao,
Dscho
