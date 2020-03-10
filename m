Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DBAC10DCE
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 23:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E1C02071B
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 23:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="UpPKyun+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbgCJXVO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 19:21:14 -0400
Received: from forward501o.mail.yandex.net ([37.140.190.203]:38879 "EHLO
        forward501o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726899AbgCJXVO (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Mar 2020 19:21:14 -0400
Received: from mxback30g.mail.yandex.net (mxback30g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:330])
        by forward501o.mail.yandex.net (Yandex) with ESMTP id 0035C1E8027F;
        Wed, 11 Mar 2020 02:21:11 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback30g.mail.yandex.net (mxback/Yandex) with ESMTP id lUaySfsqRe-LBYSjsW9;
        Wed, 11 Mar 2020 02:21:11 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1583882471;
        bh=fJDg6ZLpdUwEV1RuZu9F8hbhF4N9sqsAK96iracr+hU=;
        h=References:Date:Message-Id:Subject:In-Reply-To:To:From;
        b=UpPKyun+W0vmCyQf3FpZGjpcZg8/FTKNcQNVd53vK8Ccnlv2vpR1QJBXNgXlRsZX7
         DXhdBQwoMI6IUHS7wgq1DGu5t3Bl/8LW4vlJzQeX3LksaCTxjsEc6I+fGq+/OvQZJk
         kRaAvE4kJ4M9j4sN+WG32VURlxA+Kcs3G8NmpiRU=
Authentication-Results: mxback30g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva3-67f911cb3a01.qloud-c.yandex.net with HTTP;
        Wed, 11 Mar 2020 02:21:11 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     Christos Pappas <chrispappas99@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <CAGa6KtSgGOLVjHdubwRW=Bvnjnp2PoP7jJ5_NxNWGFLrVYT9SA@mail.gmail.com>
References: <CAGa6KtSgGOLVjHdubwRW=Bvnjnp2PoP7jJ5_NxNWGFLrVYT9SA@mail.gmail.com>
Subject: Re: [Feature request] Give non-unique names to commits for grouping
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Wed, 11 Mar 2020 02:21:11 +0300
Message-Id: <6552181583882319@iva1-398527a32f9a.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



11.03.2020, 02:16, "Christos Pappas" <chrispappas99@gmail.com>:
> Dear Git users,
>
> I suggest that we should have the option to mark each commit with a
> category name, that is not necessarily unique (like 'tags') so we
> could have commit groups.
> For example we could:
> git mark {commit_id} {name}
>
> Then we could give special functionality to some commands based on
> those "marks".
> For example if we had marked a few commits with the name 'fix_typo'
> git log --mark fix_typo. Show all the commits marked with 'fix_typo'
> git blame --mark fix_typo Run git blame but ignore commits with 'fix_typo'

Why not use git log --grep? It can give better results if someone accidentally
forgets to use mark properly, but mentions keyword in the topic.

That said, it would be great if there was an easy way to use git log --grep
with commit topics only (i.e., search only in the first line)

-- 
Regards,
Konstantin

