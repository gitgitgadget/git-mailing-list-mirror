Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61995C19F35
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 17:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A25961101
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 17:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbhHIR47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 13:56:59 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:35496 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbhHIR4w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 13:56:52 -0400
Date:   Mon, 09 Aug 2021 17:56:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eagain.st;
        s=protonmail; t=1628531786;
        bh=j1i+c+B1/eXQNdxvfLA7m4pkiK/2sBLrHvVfCO0JUIE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=hAJRPs+75n7XeICx84Qc16K3G2yF++koFnot0gxVvkaHbnm4atfvv6zaUHvpQomsj
         VS20PiK6dZwi9zEb4lhQLlkZMG0DTUvYTVrHVjOzdMHMeRrjG6SOTmngweSeDfS7Ya
         GJpf+5QzknCoPMeBoVqvwOOF2XF+oV/oezm+B9n/0NhoIcZ9dymvpdVbomEJCq6Y0L
         l1D9HHDuU0Z/+YKBGXDN7D/dEFZKqvBTTwLFimFhcB9ikciE7YH3PDu5Mus0PxZn84
         qONIpkDIbD1b4EomIcgTdOMV2tEbalD4OyMCANb6ojrZLMXj92Aq7QzaBx1GDKxzSd
         CVdVpWWUqyuyQ==
To:     git@vger.kernel.org
From:   Kim Altintop <kim@eagain.st>
Cc:     kim@eagain.st, gitster@pobox.com, jonathantanmy@google.com,
        bwilliams.eng@gmail.com
Reply-To: Kim Altintop <kim@eagain.st>
Subject: [PATCH 0/3] upload-pack: treat want-ref relative to namespace
Message-ID: <20210809175530.75326-1-kim@eagain.st>
In-Reply-To: <20210804205951.668140-1-kim@eagain.st>
References: <20210730135845.633234-1-kim@eagain.st> <20210731203415.618641-1-kim@eagain.st> <20210804203829.661565-1-kim@eagain.st> <20210804205951.668140-1-kim@eagain.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fifth reroll of [0].

The patch has been split into three commits, where the first is a small
refactoring of the test file, the second is the original patch + tests, and=
 the
last one attempts to express the `transfer.hideRefs` behaviour more accurat=
ely
in the docs.

Thanks for your help and patience!

This version of the patch is also available at [1].

[0]: https://lore.kernel.org/git/20210804205951.668140-1-kim@eagain.st/
[1]: https://github.com/kim/git/tree/ka/namespaced-want-ref-v5

Kim Altintop (3):
  t5730: introduce fetch command helper
  upload-pack.c: treat want-ref relative to namespace
  docs: clarify the interaction of transfer.hideRefs and namespaces

 Documentation/config/transfer.txt  |  17 ++-
 t/t5703-upload-pack-ref-in-want.sh | 236 +++++++++++++++++++++++++----
 upload-pack.c                      |  18 ++-
 3 files changed, 224 insertions(+), 47 deletions(-)

--
2.32.0


