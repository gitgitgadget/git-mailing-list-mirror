Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F246EC05027
	for <git@archiver.kernel.org>; Sat, 18 Feb 2023 02:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBRCCZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 21:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBRCCY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 21:02:24 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503336ABE5
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 18:02:23 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
        t=1676685741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mbLezMVYlIgQAb/lO2Ml0lTQnTohqUBnwGYvyXozuuU=;
        b=xDrX6GCm8HU6Bf74lhDTD67ehXh+o63JGmZNSwsHbIxciovo+N3EPNF94wzDYqB52rz0W9
        Oc/5/j9hOGpMNH2eH1ufQdo6lWZlfpMuuBpQ0pzRgtm1DpHS1KucDC3SLyt7iQzPbvyMrJ
        QX/gq6c8gVP/4fFrAOAUwBUAPsfm83Q=
Date:   Sat, 18 Feb 2023 02:02:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   ronan@rjp.ie
Message-ID: <fc7d9fdde0443532eb9c32f26f9f054e@rjp.ie>
Subject: Re: Git pull without fetch
To:     "Chris Torek" <chris.torek@gmail.com>, git@vger.kernel.org
In-Reply-To: <CAPx1Gvd8vizeyveKgE2o2GStQsiGxN4aaASqYc81Nk28ogFLJg@mail.gmail.com>
References: <CAPx1Gvd8vizeyveKgE2o2GStQsiGxN4aaASqYc81Nk28ogFLJg@mail.gmail.com>
 <49c07b5dc2afbd422d492d59380ad2c2@rjp.ie>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

February 17, 2023 6:46 PM, "Chris Torek" <chris.torek@gmail.com> wrote:=
=0A=0A> `git pull` =3D `git fetch` followed by a second command, either `=
git merge` or `git rebase`. If you=0A> don't want the `git fetch` step, r=
un the *second* command, instead of running *both* commands: it's=0A> rea=
lly just that simple.=0A=0ANo it isn't. Sorry, but I think you have misun=
derstood the problem. I'm well=0Aaware of the behavior of git pull.=0A=0A=
In the scenario described, `git rebase` will always report "Already up to=
 date"=0Abecause the head of the current branch and the head of the remot=
e tracking=0Abranch are the same. The prefetched reference lives under re=
fs/prefetch/* and is=0Aunnoticed by git rebase. This is why I used `git u=
pdate-ref ...` first: to=0Aupdate the remote tracking branch from the pre=
fetched copy.
