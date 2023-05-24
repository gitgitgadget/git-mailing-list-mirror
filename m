Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2EDC77B7A
	for <git@archiver.kernel.org>; Wed, 24 May 2023 23:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjEXXki (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 May 2023 19:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjEXXkf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2023 19:40:35 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DA012B
        for <git@vger.kernel.org>; Wed, 24 May 2023 16:40:33 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6EFC918E1A7;
        Wed, 24 May 2023 19:40:30 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=XgG5Dz50RMfW+DLhny7kdZlEWtWkOGX+du4pqyb
        9CYM=; b=oHadVOixQL9+P+QvduL2ukbJhQcC/exWN3lDiDxh3G8q4RPX/VjCNtB
        RG5x4SC7uv1m27/LsHk1wNKtjGbPhjPyJaKePdz3jyDoIoWQZW9k3ZH+rUV6pGUV
        U5umWJRYD4bzecvAP2mgiT8rpMzZcWmsfQDOd9+empZQDUPmyioU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6789418E1A6;
        Wed, 24 May 2023 19:40:30 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C46D018E1A5;
        Wed, 24 May 2023 19:40:29 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Wed, 24 May 2023 19:40:28 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     rsbecker@nexbridge.com
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.41.0-rc2
Message-ID: <ZG6gbN04DfldoadD@pobox.com>
References: <xmqqedn5fluv.fsf@gitster.g>
 <022501d98e94$68c671c0$3a535540$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <022501d98e94$68c671c0$3a535540$@nexbridge.com>
X-Pobox-Relay-ID: 5E0951BC-FA8C-11ED-9F9C-307A8E0A682E-09356542!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rsbecker@nexbridge.com wrote:
> I'm not sure this is a new thing but it is the first time
> I noticed it in the log. It was not in the build log for
> 2.41.0-rc0.
>
> /usr/coreutils/bin/bash: line 3: tclsh: command not found
>     * tclsh failed; using unoptimized loading

Have you set NO_TCLTK in your builds?  I don't see that in
the NonStop section of config.mak.uname.

> Tclsh is not available on NonStop or S/390 AFAIK. While
> its use does go back to 2007, I just want to ensure that
> it does not sneak in as a dependency beyond git-gui and
> gitk-git.

The only references to tclsh outside of the Makefile and
git-gui/gitk are commented code in contrib/buildsystems/,
engine.pl and parse.pl.

-- 
Todd
