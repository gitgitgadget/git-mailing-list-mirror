Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF9CC4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 19:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D158207EA
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 19:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="I23DGoWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbgJGTnf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 15:43:35 -0400
Received: from mout.gmx.net ([212.227.15.19]:35195 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728291AbgJGTnf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 15:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602099810;
        bh=LFDHrbb//lEASWxuzY+kUOdn5DoIWSjh+I5QJJHqZqk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=I23DGoWl3nalMgXGXpMLSAKDhftZs8rggJ7SYV0gUXfN7UqFEh7Br8EHpcWJByq4/
         1AuzIh7sc6LstvUlGhHX/jtwdBe3hS5Mtts7DJOXKKJvo5KEZdEdXJYdn8mnHtH71h
         OkjleO3PtIY3S48DVFZukvoYnirlYUXqjFuLROCQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([213.196.213.184]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ml6mE-1knVs606ZQ-00lUmr; Wed, 07
 Oct 2020 21:43:30 +0200
Date:   Wed, 7 Oct 2020 21:43:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Tom Clarkson via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
        Ed Maste <emaste@freebsd.org>,
        Tom Clarkson <tom@tqclarkson.com>,
        Tom Clarkson <tom@tqclarkson.com>
Subject: Re: [PATCH v2 7/7] subtree: document new subtree commands
In-Reply-To: <fe2e4819b869725f870cd3ce99f1f8150fe17dc1.1602021913.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010072117340.50@tvgsbejvaqbjf.bet>
References: <pull.493.git.1589176201.gitgitgadget@gmail.com> <pull.493.v2.git.1602021913.gitgitgadget@gmail.com> <fe2e4819b869725f870cd3ce99f1f8150fe17dc1.1602021913.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/crl8VCe16MO6QHTYn/4OJrSqtAjzoZLfzgybLiyV8us63tqcYR
 TNyd4AOuKJsi7guok9Pjk6H6zTrabAWPNf2wCr8SKl0NA+N2xqcz7Uu9kNf6tVrWHN6ybnN
 sGKDeM5SPLPh38+MCi0d3tNBGh93oFF/HN7UfqVdXgXhIGfzswtn/STnRcfWppKvwK2n6A7
 u2UYcZSAbt5/mIL2rJvGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UYwn+REIU5E=:20sWuAibITpp+i2oF4q5T1
 jt+tch6UFUBtnXzFCSFIUTp4KLCcIb4hk9NPxwxNioKK2ITuvRuPHnTLSO2dvAEgoW0Hmcsx8
 WCAhDjTg9t46WueQoDRGGqxIG3XEhy7andZuvAWuF72LrsAFn8dp89WksMTscyIRDDbsnO7lq
 BCgtPVeDXWcsknN3I+S54QvBmI20MCWWNFGHlMgxfvULxYXbysPqcSi9Dwwag1lRkIz/IVKyg
 gCQ9kwK6F6cgVHHcQslTLszWhe6/b40AfhA4yo4zyHzeoZZYn1yyR0QL2/tNaXGlnIxauJuCR
 AOQmkNZn7HWR4X1IggI0AEhNm7ElvJDtwoYKLG88n8Z0KUo7W6r1ib5DvxeHgUUGkQlBpvZ0n
 SGEX4RkzjftMrYbnbS2i3semFIaqHmV6mfCKXoVHmL9hhq/0f7IpcAO/M9wyh0zoigONuel0U
 KQ5A4ds3qqmNTTTusZoMPp/lVCxjqEvIPSPimAI0/A20SfdYXu3jblYOZQYKGCPNCx2nsaPUO
 UE44RSyxk18aLpCZuQrFtR82ASfmXJ3jQkSLcARGh9sb2kZb3B0aQ8YAq9RbhJsZqiQZTFLrq
 2DeVRvwsPPS7k9qS++Qx9M9sW2Sz0phDDMXk3mq3M9yGN3kRu4/69tirx4Q3CqufP/hxyismZ
 d2IR1P0oT7uzlI4fsWddtZJwB9/WVIyluajh7sX/+iVCuMfgxp1rdrB7j7sCx+1fQHATRUa1w
 DpYNVP3Xe63BrBoR9kS3+afLqqfAnvpDwVQzCKQ/51m4TI95vbD2CuRY+PWslAUFOxoHVDsJJ
 H9FpsV5AH03Vjzsoy7JogFzk0kmyg7mZFvSrfCn+EQ2GweBn5h4nGrSuPjZTLNmjRlA4/vTG8
 pX09AUvxdkjT5p37fHRK5vZ8vmasdDXJD3da2vLij3WhVRruPE10QvnHdj0YE7fsaYEFRtQbI
 agFiP1FKYNFs2vG/DyvvUOcFQncNebcBLAlco6m2nLv6eBvymLcRffPiDLA3XH2bUMfl3s6cG
 UqWD33E34alGbEPNSQ4Wb1B11kgPTQYOv697PQFQ/3K6d/UuYf4ZSiVn3yevj5yoEUzNlby0o
 SB4xtJS+PZM4bBaAJJooTIhH4bNRllyw14wntkIHe0pXiNMmD3fecm7N0RIOzrcexIv5szDiI
 xGH/Khq8RY+Hhnqo/UtjCJguKFlrhTYzk453/HkxHzTfWnMj7bfJdk9D9Y4YJbL2ORpj/zt9l
 QrFOZFU5nUCJKnF7mRcGzqUYs2hw+kCiPSUDmjw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tom,

On Tue, 6 Oct 2020, Tom Clarkson via GitGitGadget wrote:

> From: Tom Clarkson <tom@tqclarkson.com>
>
> Signed-off-by: Tom Clarkson <tom@tqclarkson.com>
> ---
>  contrib/subtree/git-subtree.txt | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtr=
ee.txt
> index 352deda69d..a5a76e8ce6 100644
> --- a/contrib/subtree/git-subtree.txt
> +++ b/contrib/subtree/git-subtree.txt
> @@ -52,6 +52,12 @@ useful elsewhere, you can extract its entire history =
and publish
>  that as its own git repository, without accidentally
>  intermingling the history of your application project.
>
> +Although the relationship between subtree and mainline commits is store=
d

As far as I can see, this is the first time the term "mainline commit" is
used in that file, and it has not really be defined what you mean by that.
I *guess* you are referring to commits in the main project that did not
come from any subtree project.

Maybe this can be described without needing a new term?

Ciao,
Dscho

> +in regular git history, it is also cached between subtree runs. In most
> +cases this is merely a performance improvement, but for projects with
> +large and complex histories the cache can be manipulated directly
> +with the use, ignore and map commands.
> +
>  [TIP]
>  In order to keep your commit messages clean, we recommend that
>  people split their commits between the subtrees and the main
> @@ -120,6 +126,21 @@ and friends will work as expected.
>  Note that if you use '--squash' when you merge, you should usually not
>  just '--rejoin' when you split.
>
> +ignore::
> +	Mark a commit and all of its history as irrelevant to subtree split.
> +	In most cases this would be handled automatically based on metadata
> +	from subtree join commits. Intended for improving performance on
> +	extremely large repos and excluding complex history that turns out
> +	to be otherwise problematic.
> +
> +use::
> +	Mark a commit and all of its history as part of an existing subtree.
> +	In normal circumstances this would be handled based on the metadata
> +	from the subtree join commit. Similar to the --onto option of split.
> +
> +map::
> +	Manually override the normal output of split for a particular commit.
> +	Extreme flexibility for advanced troubleshooting purposes only.
>
>  OPTIONS
>  -------
> @@ -142,6 +163,9 @@ OPTIONS
>  	This option is only valid for add, merge and pull (unsure).
>  	Specify <message> as the commit message for the merge commit.
>
> +--clear-cache::
> +	Reset the subtree cache and recalculate all subtree mappings from the
> +	commit history
>
>  OPTIONS FOR add, merge, push, pull
>  ----------------------------------
> --
> gitgitgadget
>
