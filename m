Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0799EC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 18:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD95E61040
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 18:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237068AbhHTSbn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 14:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbhHTSbl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 14:31:41 -0400
Received: from host1.jankratochvil.net (host1.jankratochvil.net [IPv6:2a02:2b88:6:3b57::1f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B350C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 11:31:02 -0700 (PDT)
Received: from host1.jankratochvil.net (localhost [127.0.0.1])
        by host1.jankratochvil.net (8.16.1/8.16.1) with ESMTPS id 17KIUsJZ023745
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 20:30:54 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 host1.jankratochvil.net 17KIUsJZ023745
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jankratochvil.net;
        s=default; t=1629484254;
        bh=tpwSOdG0uooJbWakxdaYnGsCaZUmFUzFdAETJEvxusI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Omv8YXXCsHDViMo+iW1V24D02QoRQq18row0U0oqP+ma7w9OxNbC3gFVxCbgF5V8g
         zCnjhepDdshjbI5OL64VeAju0QnfhJtR4FQ41DLCaqiJXmIDK9X1AtZj20eRfx99UM
         YZ/U8mecWmjSOAPpjS4GwI6Dwwq7mY0e+A+U4tQU=
Received: (from lace@localhost)
        by host1.jankratochvil.net (8.16.1/8.16.1/Submit) id 17KIUrEj023744;
        Fri, 20 Aug 2021 20:30:53 +0200
Date:   Fri, 20 Aug 2021 20:30:53 +0200
From:   Jan Kratochvil <jan@jankratochvil.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Subject: Re: bugreport: git apply -3 confusing "lacks the necessary blob"
Message-ID: <YR/03XFO3uA5uCF0@host1.jankratochvil.net>
References: <YR1OszUm08BMAE1N@host1.jankratochvil.net>
 <73a31988-d298-0168-43d5-849f91366d7d@gmail.com>
 <xmqqtujkui9v.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtujkui9v.fsf@gitster.g>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 20 Aug 2021 19:40:12 +0200, Junio C Hamano wrote:
> But I think Jan is talking about the case where users get a patch
> that lacks the "index" information out of other people's "diff"
> implementation and try to "apply -3" without realizing that it is
> not Git's "diff" output.

Yes.


> Perhaps something like the attached patch would be a good start.

It does fix the problem for me, thanks!


Jan
