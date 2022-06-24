Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD14C43334
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 08:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiFXIUb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 04:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiFXIUa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 04:20:30 -0400
X-Greylist: delayed 249 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Jun 2022 01:20:29 PDT
Received: from mariecurie.labrat.space (mariecurie.labrat.space [116.203.185.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21BA6F49F
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 01:20:29 -0700 (PDT)
Received: from labrat.space (adsl-178-38-36-59.adslplus.ch [178.38.36.59])
        by mariecurie.labrat.space (Postfix) with ESMTPSA id 788C93A47E11;
        Fri, 24 Jun 2022 10:16:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=labrat.space;
        s=201904; t=1656058577;
        bh=F8FrAcbg96H72oByJFUuGBvVhhinj32sDjuvqNPorco=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:From:To:CC:Date:
         Subject:Content-Type:Content-Disposition:Reply-To:In-Reply-To:
         MIME-Version:Message-ID:References;
        b=fGGKUyBKOctCe1uPvIwmL1T78qVUbV63Fnc523kfReA2vdVgJfoo0rOntBp41Eiy2
         im1Rvo4JobANTt4QzeaD2HWeXSMcF9iGgieFqeIJZiOEKlzQT5+c59tyBhfZ/13ZP3
         bW4SDqGg0rWToOPt206qtvg4nB/kKjrFLNajak+A5SGbnrpxE10nimCHEJgBRg88gY
         T8TNzlOXDjE4a77pEqL3Ueijf3GHyAdkK5TbMtAeSmjlLE9dGvnc8mthH8JMH43ihI
         f85dd3EurdvIEENZQQcarCX/9obT6BqzxNzoHr0jrMpQm/zeP8Z5TaWAyMygmzu3zy
         xzdVusxpvIUAw==
Date:   Fri, 24 Jun 2022 10:16:15 +0200
From:   Reto <reto@labrat.space>
To:     Tim Chase <git@tim.thechases.com>
Cc:     git@vger.kernel.org
Subject: Re: stashing only unstaged changes?
Message-ID: <20220624081615.zhurjajwuvtvzs2y@feather>
Mail-Followup-To: Tim Chase <git@tim.thechases.com>, git@vger.kernel.org
References: <20220621142618.239b02cd@bigbox.attlocal.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621142618.239b02cd@bigbox.attlocal.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You should be using proper branches, not stash.

Here's an email with some background from Junio:

https://lore.kernel.org/git/xmqq5ylior3l.fsf@gitster.g/

Some quotes:

> The intended use of "stash" is to clear the deck as quickly as
> possible to deal with "emergencies"

> Users are better off doing any large scale "I made a mess in the
> working tree with mixed changes, and I want to take time to separate
> them out" on separate (possibly temporary) branches, instead of
> using "stash save" + "stash pop"

In other words, you are using the wrong tool for the job probably.

Cheers,
Reto
