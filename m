Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29162C433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E60132067C
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rtzoeller.com header.i=@rtzoeller.com header.b="TRIhFYlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgHSRvF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:51:05 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:45318 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgHSRvE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 13:51:04 -0400
Date:   Wed, 19 Aug 2020 17:50:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rtzoeller.com;
        s=protonmail; t=1597859462;
        bh=9uhxx+Xzd4ozOmeFje1DvS7sXCBAVbZ6y9NPRf9OlH8=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=TRIhFYlN+CekJgtW54P7hQEYduPdoTu5RhEp9/42LQF6qIGp5qGOrScXm89nIO0Xw
         nO/x6GEVFnc0CyyVsM5MDzif1gqlFpvbk2kbkZ6a+N0hnvzpm91It6vZ91H4YnB8uX
         gCI5pDADQ7gndxDsHpfk1PjuWXWUdjYsaAckI2cE=
To:     git@vger.kernel.org
From:   Ryan Zoeller <rtzoeller@rtzoeller.com>
Cc:     Ryan Zoeller <rtzoeller@rtzoeller.com>
Reply-To: Ryan Zoeller <rtzoeller@rtzoeller.com>
Subject: [RFC PATCH 0/2] Support enabling bash completion of all options
Message-ID: <20200819175047.692962-1-rtzoeller@rtzoeller.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds --git-completion-helper-all, which behaves similarly to
--git-completion-helper but includes options which are typically hidden.
An environment variable GIT_COMPLETION_SHOW_ALL is used to opt-in to
this behavior.

I often prototype automated tooling around git by running commands locally
until I'm satisfied with the behavior, then migrating them into a script.
Having bash completion for some of the more obscure options is useful.

I wasn't sure how to add automated tests around this without making the
tests overly brittle (e.g. depending on a verbatim list of options), so
I welcome ideas and feedback.

-Ryan

Ryan Zoeller (2):
  parse-options: add --git-completion-helper-all
  completion: add GIT_COMPLETION_SHOW_ALL env var

 contrib/completion/git-completion.bash | 14 +++++++++++++-
 parse-options.c                        | 18 ++++++++++++------
 2 files changed, 25 insertions(+), 7 deletions(-)

--=20
2.28.0.260.g5fadab5a9c


