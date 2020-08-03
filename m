Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B794C433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 17:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ECD622BEF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 17:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mattmccutchen.net header.i=@mattmccutchen.net header.b="KpdYHKKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgHCRlt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 13:41:49 -0400
Received: from bonobo.birch.relay.mailchannels.net ([23.83.209.22]:11125 "EHLO
        bonobo.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725945AbgHCRlt (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Aug 2020 13:41:49 -0400
X-Sender-Id: dreamhost|x-authsender|matt@mattmccutchen.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6EF0E1E1C4A;
        Mon,  3 Aug 2020 17:41:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a73.g.dreamhost.com (100-96-23-22.trex.outbound.svc.cluster.local [100.96.23.22])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id CDA3E1E1FAE;
        Mon,  3 Aug 2020 17:41:44 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|matt@mattmccutchen.net
Received: from pdx1-sub0-mail-a73.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.8);
        Mon, 03 Aug 2020 17:41:47 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|matt@mattmccutchen.net
X-MailChannels-Auth-Id: dreamhost
X-Gusty-Drop: 3e8503c94957b9e2_1596476507244_2228496841
X-MC-Loop-Signature: 1596476507243:4162801309
X-MC-Ingress-Time: 1596476507243
Received: from pdx1-sub0-mail-a73.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a73.g.dreamhost.com (Postfix) with ESMTP id 92113B07F2;
        Mon,  3 Aug 2020 10:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=
        mattmccutchen.net; bh=4i1IgbgkYQZWZTw0EqVhhwyRzE8=; b=KpdYHKKNOt
        UViU3J8KzVpUUpkz9q1QHkFJnxpUSsAka6yNB5ODCXIo7uCVIwE4Ir2TGM9iQpyi
        Ynu0d+z+S7w/F2Xd71rmpmhG+L+gttu/szkZzlrf5Hnz7c1lALcsIKy8+NvHAA11
        gYlzMEjQ3s1Uq6HGDU9avqDvJhl25hL4k=
Received: from main (pool-100-15-89-198.washdc.fios.verizon.net [100.15.89.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by pdx1-sub0-mail-a73.g.dreamhost.com (Postfix) with ESMTPSA id A6DF3B080A;
        Mon,  3 Aug 2020 10:41:42 -0700 (PDT)
Message-ID: <ce0283e1cb38dc84eb850e3cfc7b1a6225a60b42.camel@mattmccutchen.net>
Subject: Re: Renaming the "master" branch without breaking existing clones
X-DH-BACKEND: pdx1-sub0-mail-a73
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Mon, 03 Aug 2020 13:41:40 -0400
In-Reply-To: <xmqqlfivwvtw.fsf@gitster.c.googlers.com>
References: <ec960483f5008e9948271c678d51876920ab62c9.camel@mattmccutchen.net>
         <xmqqlfivwvtw.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: 0
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrjeeggdduudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeforghtthcuofgtvehuthgthhgvnhcuoehmrghtthesmhgrthhtmhgttghuthgthhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepveejudehtdehueehveeuffethfeltddvhfetteeuvefhhedvgedvvefgudefhfdvnecukfhppedutddtrdduhedrkeelrdduleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhppdhhvghlohepmhgrihhnpdhinhgvthepuddttddrudehrdekledrudelkedprhgvthhurhhnqdhprghthhepofgrthhtucfotgevuhhttghhvghnuceomhgrthhtsehmrghtthhmtggtuhhttghhvghnrdhnvghtqedpmhgrihhlfhhrohhmpehmrghtthesmhgrthhtmhgttghuthgthhgvnhdrnhgvthdpnhhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2020-08-03 at 09:14 -0700, Junio C Hamano wrote:
> Matt McCutchen <matt@mattmccutchen.net> writes:
> 
> > 3. Ensuring that tools detect the default branch of a given repository
> > in an appropriate way rather than assuming "master".  Where applicable,
> > the remote HEAD symref is probably the best thing to use.
> 
> I wonder if that would work well.  Your refs/remotes/origin/HEAD is
> designed to be tweaked by you to indicate which remote branch is of
> interest to you to your local Git.  Those who are interested in
> following along 'maint' can update refs/remotes/origin/HEAD to point
> at refs/remotes/origin/maint in their clone of this project, and
> they can say "git fetch origin && git log origin" to see the history
> leading to the tip of 'maint' in my repository.
> 
> At least, that is how it is designed to work.  So "compare local
> refs/remotes/origin/HEAD and what 'git ls-remote origin' sees where
> they point at with their HEAD---if they are different, ours have old
> name and theirs have new name" is not a good heuristics.

Indeed.  I guess my proposal to use the HEAD symref of the remote
repository only applies to tools that interact with a central
repository and don't have a local repository that the user is allowed
to touch (there might be one for caching purposes only) and need to
know which branch to use if the user didn't specify one.  This would
include npm, yarn, etc., as mentioned in the article I linked.

If functionality is added to git to facilitate transitions for tools
that do have a local repository that the user is allowed to touch, as
you described, that would be great.

Matt

