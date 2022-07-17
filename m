Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1D9C433EF
	for <git@archiver.kernel.org>; Sun, 17 Jul 2022 11:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiGQL2L convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 17 Jul 2022 07:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiGQL2D (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jul 2022 07:28:03 -0400
X-Greylist: delayed 404 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 17 Jul 2022 04:27:59 PDT
Received: from mail-gateway-shared13.cyon.net (mail-gateway-shared13.cyon.net [194.126.200.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566CE14D3C
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 04:27:59 -0700 (PDT)
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared13.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <bb@drbeat.li>)
        id 1oD2Km-0007Di-Ha
        for git@vger.kernel.org; Sun, 17 Jul 2022 13:21:12 +0200
Received: from [10.20.10.232] (port=21452 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.95)
        (envelope-from <bb@drbeat.li>)
        id 1oD2Kl-00GLsK-Dn;
        Sun, 17 Jul 2022 13:21:11 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id 124E9180322; Sun, 17 Jul 2022 13:21:11 +0200 (CEST)
Date:   Sun, 17 Jul 2022 13:21:11 +0200
From:   Beat Bolli <dev@drbeat.li>
To:     David Chmelik <dchmelik@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: 'git clone,' build makes user non-writable files (should be
 option keep user-writable)
Message-ID: <YtPwp/OSD2X6Q/Ol@zbox.drbeat.li>
References: <822787da-bc26-0d72-a5c4-808a3d10126e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <822787da-bc26-0d72-a5c4-808a3d10126e@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 15, 2022 at 03:35:49AM -0700, David Chmelik wrote:

[resend with reply-to-all]

> What did you do before the bug happened?
> 'git clone,' built various software (with gcc, BSD & GNU make, autotools,
> cmake, etc.)
> 
> What did you expect to happen?
> Option: keep cloned/built/etc. files user-writable.
> 
> What happened instead?
> Needed chmod or 'sudo rm -rf.'
> 
> What's different between what you expected and what actually happened?
> Option: keep cloned/built/etc. files user-writable, otherwise (has been said
> 15+ years) encourages 'sudo rm -rf.'
> 
> Anything else you want to add:
>         I try/test/debug (and report bugs) many software commits but don't
> commit so need cloned/built/etc. files writable as user & even system-wide
> options: who hasn't made 'rm -rf' mistakes? (unrelated but someone might
> claim is: I don't use non-UNIX-like OS that shell alias 'rm -rf' to confirm
> every file (potentially thousands) and though made my own alias (confirm
> once) it's longer, sometimes unavailable so don't always use (many people
> don't)... software should always have user-writable files option.)  Below
> indicates GNU/Linux but also have often used git on *BSD/Unix.  I'm not on
> git mailing list but you can CC me all replies.

When building software as the current user, the build artefacts are
owned by this user.

Are you building the software using Docker containers that run as root?

Regards, Beat
