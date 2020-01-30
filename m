Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A927C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0DB206F0
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="LIBXTOur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgA3PEN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:04:13 -0500
Received: from mout.gmx.net ([212.227.15.18]:34477 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbgA3PEN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 10:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580396651;
        bh=bduv39OtF/20okrkNb5R0hxU8ofOAb/qfnxzuFV+xNs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LIBXTOur9ytJQJBnVmlbKQghBuMj3J65+HuOrnBQ7Sob060dijVSNaaPnhC4RsMhh
         Solz56cMt7tMqqqAfjw7nJFEWcfZUYyrWWqz+OLPpJeS49SdVFQFGCdDm5OJ+F7sTb
         5IvAebnR0HM6eDE5rFc1m5i/0AB7bRXrKVV4ZsdU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ma24s-1j2Z830sdg-00VzI8; Thu, 30
 Jan 2020 16:04:11 +0100
Date:   Thu, 30 Jan 2020 16:04:11 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [Outreachy][PATCH v2 00/11] Finish converting git bisect to C
 part 1
In-Reply-To: <20200128144026.53128-1-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001301601580.46@tvgsbejvaqbjf.bet>
References: <20200128144026.53128-1-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nHOIlzycGTZ/zvr7Cectigmq6mmTYQhtLwjH74Msq/44EWRxtbe
 eNI6PzAmOvS2WWcYDPPrYSWSuvVqPIyUsZPEhJ7kwMNT+yypsuAlr57I5/pKo9zAqwLZqPD
 vTZ1BgAT+94XGI9DbxpVevBp8FvnkTV69troMLJ9fd/pRJh13+uI2HXY5s4xYCQud9n2h0o
 erVebEVaUAxKCwEZz+ZYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MQJR7lKakZc=:wUubcSFkNOkR+3wutmjqTU
 EQdmgPvQn+RCg5EpjBf9iCFO1HFyh4UE3iIDlSZ1V/5kk9ZUp8V0/utNAaHLSoSg/XKDRs/Y/
 kcjqacuuAEimLz0/ra3eRwyaEu+XIMa+U2kB/6+VnZ16zIlhpl5Vw0g3ISPiAqTl6m/CT3B2g
 QeXY4MCNj7MdGUMJHVfc4Y0ZkZCbV8OtznSpmHvSysWt3F64rn/3E197rUXu5dX/nGz3ou1sj
 UAXL8uXw5R9jHZyBMWH1pf0BUjMem/hOrQ155orYeA8vdvmU+skJ5D8tZO+atGxiI4Sjnch+Z
 l/UUll7O07dsjLVNFAqxwzvNWNlKS/D83UauudZuXyJ242MeZ0lcKMt0qtd1trdHAPym1iOf7
 sFaVXv0Wjc1XYlntanfLEli09pm91misZcL1K0IFIzwqW7uXpsizYEkRtJOV1fCygJzB6itCe
 iKJpq+oRU/AD1e8uQIdDZDF5w9mbbgt0QudNOX1NWtK5AuZEfAPyl2zD8NYkKzoY6NJRUIOlt
 GhBEsGuzQaC9GeVCYYJ4aSE6QLPEdiS4rKWvTx28tw2uX5Wyxg3gRFbgOfVkQeawririQmiLl
 r0bUr3b6UWjlXwo6VO6U4uEzAJmCh82oqiXqWlhSUVcVnuVJnCgtX0b92xRcG+ie3iPAnupEf
 lO/AGSinIEFt0fiU7jQoJhvQd8KLk+f5iZIt9ManyxXaZFDgEQHI0TtE+vfYyBpjO1gamcKOV
 adB/jB+vNpS7A8sZLJODMZls6SwI+nir07i76ayfIHJSbWSQubm0kj6ZNV2+fP2pkqw+krvyY
 myPMMWlru9t2oFJVrKnEdFWafZx6sp8hkH3J7Xc+ys8YwY2/ftJhGKURh1GWOJFeirO2IWSqe
 VF16hlZd9iqAUukd3b+yFgTf/ndqM7WnUCWV2r07AXg8YgDUezLtSqtbiipUyV/BtEFPGwtJx
 rzCBJ0HjhB15KDXQ4CxDhrqdk+Yg2//xq81mhOTfjLBMyY1S28W2JZBBEQJaR7dtPxE/NqFcx
 yBYUjIx1ct64LUm4tSY8JACouEvzlQSO5FMdfijfPATk1mXYrqoFtc5+J1bHe4YFShIyHLW6B
 I4mtUi1z9LcCAm46HLXXOxEdoQRScKsbkYXDYkEZn9HoQcducl1VWPl+vuULVKldj26fYhU46
 +AR3iLwqu/HFCC3bXZ52xBsZbvNkpCXeYpDb5mkTjnGlifcDZzn8y3jR3k1JwBbo3LSHojXOD
 YScVQ9EHS33LwX4J/
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Tue, 28 Jan 2020, Miriam Rubio wrote:

> These patches correspond to a first part of patch series
> of Outreachy project "Finish converting `git bisect` from shell to C"
> started by the interns Pranit Bauva and Tanushree Tumane
> (https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
> continued by Miriam Rubio.
>
> This first part are formed of preparatory/clean-up patches and all
> `bisect.c` libification work.
>
> These patch series emails were generated from:
> https://gitlab.com/mirucam/git/commits/git-bisect-work-part1
>
> It has to be noted that in this version 2 nothing has been done about a
> reviewer suggestion of using enums for error codes, because there was no
> consensus about using them by the reviewers.

It is a pity, as "magic" constants tend to remain "magic" (and eventually
"tragic" when they have not been addressed properly).

However, this does not need to hold up your patch series.

I noted a couple of rather minor things; It looks pretty good to me
already, though, and I thank you very much for splitting this patch series
off, so that only the libification remains. It made for a pleasant read.

Thanks,
Dscho

>
> --- Changes since v1 Finish converting git bisect to C part 1 patch seri=
es ---
>
> General changes
> ---------------
>
> * Previous patch series version has been split in smaller groups
> in order to facilitate revision and integration.
> * Rebase on master branch: c7a6207591 (Sync with maint, 2020-01-27).
> * Improve commit messages.
>
> Specific changes
> ----------------
>
> [6/11] bisect: libify `exit_if_skipped_commits` to `error_if_skipped*`
> and its dependents
>
> * Remove redundant sentences in commit message.
> * Use `if (res < 0)` instead of `if (res)`.
>
> [8/11] bisect: libify `check_merge_bases` and its dependents
>
> * Remove redundant sentence in commit message.
>
> --
>
> [9/11] bisect: libify `check_good_are_ancestors_of_bad` and its
> dependents
>
> * Remove redundant sentences in commit message.
> * Return in `if (!current_bad_oid)` condition.
>
> --
>
> [10/11] bisect: libify `handle_bad_merge_base` and its dependents
>
> * Remove redundant sentence in commit message.
>
> --
>
> [11/11] bisect: libify `bisect_next_all`
>
> * Remove redundant sentence in commit message.
> * Add return codes explanations in `bisect.h`.
>
> --
>
> Miriam Rubio (2):
>   bisect--helper: convert `vocab_*` char pointers to char arrays
>   bisect: use the standard 'if (!var)' way to check for 0
>
> Pranit Bauva (7):
>   run-command: make `exists_in_PATH()` non-static
>   bisect: libify `exit_if_skipped_commits` to `error_if_skipped*` and
>     its dependents
>   bisect: libify `bisect_checkout`
>   bisect: libify `check_merge_bases` and its dependents
>   bisect: libify `check_good_are_ancestors_of_bad` and its dependents
>   bisect: libify `handle_bad_merge_base` and its dependents
>   bisect: libify `bisect_next_all`
>
> Tanushree Tumane (2):
>   bisect--helper: change `retval` to `res`
>   bisect--helper: introduce new `decide_next()` function
>
>  bisect.c                 | 136 +++++++++++++++++++++++++++------------
>  bisect.h                 |  23 +++++++
>  builtin/bisect--helper.c | 118 +++++++++++++++++----------------
>  run-command.c            |   2 +-
>  run-command.h            |  11 ++++
>  5 files changed, 193 insertions(+), 97 deletions(-)
>
> --
> 2.21.1 (Apple Git-122.3)
>
>
