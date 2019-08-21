Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 325ED1F461
	for <e@80x24.org>; Wed, 21 Aug 2019 00:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfHUAum (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 20:50:42 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52657 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726128AbfHUAul (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Aug 2019 20:50:41 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8BA6221FE5
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 20:50:40 -0400 (EDT)
Received: from imap6 ([10.202.2.56])
  by compute1.internal (MEProxy); Tue, 20 Aug 2019 20:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sb.org; h=
        mime-version:message-id:date:from:to:subject:content-type
        :content-transfer-encoding; s=fm2; bh=AAzUz4q0PptBt5YvCRvRqtd4yS
        d5egEBxiSDWNg2+Kc=; b=SS5FccDKfHs+cNE5uXqGOCB2GrNUIAMP0fNTux3hDE
        CX5ArkYpO7sOGneiaf8PPiP+rXpTmbxHeeRS0/tEm743kt6VZuVYVPbA0AFhBpfm
        Pb1XHt7mPPzhyWvs9+gtcM1pEGSzad6nmsK8oRNk9hNRVPSvHNscfIohSJMr7+PK
        hGL9L15m0Y1j2Wxk7H3/Dfhw+seby/7tJwuoW/nywoLc1F5nwIknsTVrmIGK4inq
        qnrRoDzkP44kanY8samstsLsO4ujFqpymxylBmhMgdNO9O8QWJPYxA/3eMKJ1k4L
        wdpSgRS43hKQAwYqllsC7Z4ELHQbWbMhZkH35DMhjqiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=AAzUz4
        q0PptBt5YvCRvRqtd4ySd5egEBxiSDWNg2+Kc=; b=r2iSr5IZ+8hXpedU1/3hE6
        PaihENF44riaM/US48TCbhbpRX2KccoKlzWcqgVjQhkpRPp7UpuwE1SNiI9A7ICE
        qZoXRYlvpG9QihTuRD7ybH6/q2spDQQFUhZKBJFXqh5O0FIaP4IjeHEkc9HSSsJ6
        Dq+LID+VQ/X6hHb5de9xWMZAy8ELH4RVKJ5XmwK3PvdZrRICCaVM1fT3DAmxTC36
        QbRd5gVIDfT4ORkECpC/iydDmAFnts72zi/dvhSfOm9kY2Lv+Hy09M2KirwPApV9
        bAA7RLUJTzSZPalMMxd6YHopp5I0pNLVtTCjn7Z6KP3ApWiiXPbNv06mSafAfOHQ
        ==
X-ME-Sender: <xms:YJVcXXdzVTMkZ3rd2LJeH44OPSOEvZihWJJkZdX831Nqp9qOLmLkng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegvddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtgfesthhqre
    dtreerjeenucfhrhhomhepfdfnihhlhicuuegrlhhlrghrugdfuceolhhilhihsehssgdr
    ohhrgheqnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlihhlhiesshgsrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:YJVcXZhNU4yE5UwnX6MWLSZBKpLCdG49tQmKcAxBRmq5M5UWv3ay3A>
    <xmx:YJVcXVPfKbKscW9XbPuVp2161xr6nm8fMn7R170IoUmwhUNZc88KxA>
    <xmx:YJVcXdeeW_2Q2wtCbY927Ln7BRPJZsMdbuE9_8SRaGdzY9D03mEbaQ>
    <xmx:YJVcXT6JD4-cNEXN7hXHUAOYhtDunp4eTsCBTQ3L-db3QlNzLZ73Cw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4CBE21400EE; Tue, 20 Aug 2019 20:50:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-878-g972612b-fmstable-20190820v1
Mime-Version: 1.0
Message-Id: <3927bdd8-5641-4ade-aea5-e843c3bbf612@www.fastmail.com>
Date:   Tue, 20 Aug 2019 17:50:39 -0700
From:   "Lily Ballard" <lily@sb.org>
To:     git@vger.kernel.org
Subject: =?UTF-8?Q?Bug:_`git_fetch_--prune_origin_master:refs/foo`_incorrectly_pr?=
 =?UTF-8?Q?unes_refs/foo?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using the --prune flag (or fetch.prune=3Dtrue), a `git fetch` comma=
nd that uses a refspec to update a ref that doesn=E2=80=99t exist remote=
ly will behave incorrectly if the ref already exists locally. For exampl=
e:

> git fetch --prune master:refs/foo

If refs/foo doesn=E2=80=99t exist, this command will create it with the =
contents of origin=E2=80=99s master. If refs/foo does exist, it will be =
pruned immediately. If the `git fetch` doesn=E2=80=99t actually fetch an=
ything (because the commits exist locally) then it will exit with succes=
s, despite the ref not existing locally. If it does fetch commits, it wi=
ll fail with a =E2=80=9Ccannot lock ref=E2=80=9D error.

Here=E2=80=99s the flow for fetching twice:

> git fetch --prune origin master:refs/foo
From <url>
 * [new branch]            master     -> refs/foo
> git fetch --prune origin master:refs/foo
From <url>
 - [deleted]               (none)     -> refs/foo
> git rev-parse --verify refs/foo
fatal: Needed a single revision

And here=E2=80=99s what I get if the ref already exists and the fetch ac=
tually downloads commits (in this case I=E2=80=99m using --force but tha=
t=E2=80=99s not necessary for the bug):

> git fetch --prune --force origin pull/7267/head:refs/foo
From <url>
 - [deleted]               (none)     -> refs/foo
error: cannot lock ref 'refs/foo': unable to resolve reference 'refs/foo=
'
 ! e090924c71...ca5f06da05 refs/pull/7267/head -> refs/foo  (unable to u=
pdate local ref)

This was reproduced using git version 2.22.0.

-Lily Ballard
