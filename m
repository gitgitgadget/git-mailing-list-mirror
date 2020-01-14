Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797B4C33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 18:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396682084D
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 18:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=novalis.org header.i=@novalis.org header.b="rmnNULEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgANSUA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:20:00 -0500
Received: from bonobo.elm.relay.mailchannels.net ([23.83.212.22]:55753 "EHLO
        bonobo.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726491AbgANST7 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Jan 2020 13:19:59 -0500
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 720A5581620;
        Tue, 14 Jan 2020 18:19:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a58.g.dreamhost.com (100-96-87-46.trex.outbound.svc.cluster.local [100.96.87.46])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D36125808AD;
        Tue, 14 Jan 2020 18:19:57 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from pdx1-sub0-mail-a58.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.5);
        Tue, 14 Jan 2020 18:19:58 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|novalis@novalis.org
X-MailChannels-Auth-Id: dreamhost
X-Illustrious-Bitter: 0d97d41e2a4e523a_1579025998181_2084969737
X-MC-Loop-Signature: 1579025998181:3302640484
X-MC-Ingress-Time: 1579025998181
Received: from pdx1-sub0-mail-a58.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a58.g.dreamhost.com (Postfix) with ESMTP id 40E687F19D;
        Tue, 14 Jan 2020 10:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=LlptK
        UENTOpAF2SknDXZuHKaMeU=; b=rmnNULEdkuhVg2OmssawWX78zORUDeRjOFX0Z
        mbZM6tZZTrOvu2zks52VLYNidX7XB1wmY0A/8hxfVW0cRCFbfbXSP1r9wJEUHiol
        UashRobUtXHbI548vL6lWvgfvX60uyVADvBMaGtrnO3ExPIC4cDDOE45ICJuAyLe
        Cn9804=
Received: from corey (unknown [38.27.161.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by pdx1-sub0-mail-a58.g.dreamhost.com (Postfix) with ESMTPSA id 80F417F173;
        Tue, 14 Jan 2020 10:19:51 -0800 (PST)
Message-ID: <d4361b6d34513a3fdefa564d10269f60d4732208.camel@novalis.org>
Subject: Re: [RFC] Extending git-replace
X-DH-BACKEND: pdx1-sub0-mail-a58
From:   David Turner <novalis@novalis.org>
To:     Kaushik Srenevasan <kaushik@twitter.com>, git@vger.kernel.org
Date:   Tue, 14 Jan 2020 13:19:50 -0500
In-Reply-To: <CAN_uzpK1m42J19Xi8oc3Dwmhk9qF1n4hFrBVqD+0RHZuZ_15Jw@mail.gmail.com>
References: <CAN_uzpK1m42J19Xi8oc3Dwmhk9qF1n4hFrBVqD+0RHZuZ_15Jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrtddugddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucggtfgfnhhsuhgsshgtrhhisggvpdfftffgtefojffquffvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtkeertddtreejnecuhfhrohhmpeffrghvihguucfvuhhrnhgvrhcuoehnohhvrghlihhssehnohhvrghlihhsrdhorhhgqeenucfkphepfeekrddvjedrudeiuddrudejnecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopegtohhrvgihpdhinhgvthepfeekrddvjedrudeiuddrudejpdhrvghtuhhrnhdqphgrthhhpeffrghvihguucfvuhhrnhgvrhcuoehnohhvrghlihhssehnohhvrghlihhsrdhorhhgqedpmhgrihhlfhhrohhmpehnohhvrghlihhssehnohhvrghlihhsrdhorhhgpdhnrhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2020-01-13 at 21:33 -0800, Kaushik Srenevasan wrote:
> A feature that allowed such permanent replacement (say a
> `git-blacklist` or a `git-replace --blacklist`) might work as
> follows:
> 1. Blacklisted objects are stored as references under a new namespace
> -- `refs/blacklist`.
> 2. The object loader unconditionally translates a blacklisted OID
> into
> the OID it=E2=80=99s been replaced with.
> 3. The `+refs/blacklist/*:refs/blacklist/*` refspec is implicitly
> always a part of fetch and push transactions.

There are definitely some security implications here. I assume that
there's a config on the client to trust the server's refs/blacklist/*,
and that the documentation for this explains that it allows your repo
to be messed with in quite dangerous ways.  And on the server, I would
expect that only privileged users could push to refs/blacklist/*

To Elijah's point that this is related to partial clones and promisors,
I think Kaushik's idea is subtly different in that it involves
replacements, while promisors try to offer a seamless experience.  I
wonder whether Kaushik actually needs the replacement functionality? =20

That is, would it be sufficient if every replaced file were replaced
with the exact text "me caga en la leche" instead of a custom hand-
crafted replacement?  I guess it's a bit complicated because while
that's a reasonable blob, it's not a valid commit.  So maybe this
mechanism would be limited to blobs.  I thought about whether we could
a different flavor of replacement for commits, but those generally have
to be custom because they each have different parents.=20

And if that would be sufficient, could promisors be used for this?  I
don't know how those interact with fsck and the other commands that
you're worried about.  Basically, the idea would be to use most of the
existing promisor code, and then have a mode where instead of visiting
the promisor, we just always return "me caga en la leche" (and this
does not have its SHA checked, of course).

This could work together with some sort refs/blacklist mechanism to
enable the server to choose which objects the client replaces.


