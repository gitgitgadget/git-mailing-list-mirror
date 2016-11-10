Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C48D20229
	for <e@80x24.org>; Thu, 10 Nov 2016 21:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934181AbcKJVxZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 16:53:25 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:43865 "EHLO
        homiemail-a8.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933973AbcKJVxY (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 Nov 2016 16:53:24 -0500
Received: from homiemail-a8.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a8.g.dreamhost.com (Postfix) with ESMTP id 536665F206A
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 13:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=
        mattmccutchen.net; bh=U67ktCDlD0N1IIfopmsXxQfXKkk=; b=R46bWVZbP5
        XAa1tt25ZrVndWvxDVOYBuU+VotnqmTwHRW8AsKq0Dvn2kUNyxW58ywQYlqef7Bh
        HgQRsXukH6ibfQ+B2u8J/Et5CycN3I8m1QQk9VOnd3hTiNkE4mRkEHQ082dgOb6k
        PJxFyXIqtdIRulV7HD5d9fNv2HvY7oJiE=
Received: from main (30-10-119.wireless.csail.mit.edu [128.30.10.119])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a8.g.dreamhost.com (Postfix) with ESMTPSA id 096EE5F2068
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 13:53:22 -0800 (PST)
Message-ID: <1478814800.2878.10.camel@mattmccutchen.net>
Subject: Re: "git subtree --squash" interacts poorly with revert, merge, and
 rebase
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     git@vger.kernel.org
Date:   Thu, 10 Nov 2016 16:53:20 -0500
In-Reply-To: <1477523244.2764.114.camel@mattmccutchen.net>
References: <1477523244.2764.114.camel@mattmccutchen.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2016-10-26 at 19:07 -0400, Matt McCutchen wrote:
> Maybe we would never hit any of these problems in practice, but they
> give me a bad enough feeling that I'm planning to write my own tool
> that tracks the upstream commit ID in a file (like a submodule) and
> doesn't generate any extra commits. =C2=A0Without generating extra comm=
its,
> the only place to store the upstream content in the superproject would
> be in another subtree, which would take up disk space in every working
> tree unless developers manually set skip-worktree. =C2=A0I think I pref=
er to
> not store the upstream content and just have the tool fetch it from a
> local subproject repository each time it's needed.
>=20
> I'll of course post the tool on the web and would be happy to see it
> integrated into "git subtree" if that makes sense, but I don't know how
> much time I'd be willing to put into making that happen.

I have named my tool "git subtree-lite" and posted it here:

https://mattmccutchen.net/utils/git-subtree-lite.git/

For now,=C2=A0please email any bug reports, enhancement requests, or
proposed patches to me. =C2=A0I have philosophical concerns about hosting=
 my
own projects on services I don't control and practical concerns about a
=C2=A0few "forge" apps that I looked into installing on my own web site, =
but
if people are seriously interested in collaborating on this, I'll work
something out.

Matt
