Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A46C433EF
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 08:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B35D660EB8
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 08:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbhKMIL4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Nov 2021 03:11:56 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:55041 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhKMILz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Nov 2021 03:11:55 -0500
X-Greylist: delayed 817 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Nov 2021 03:11:55 EST
Received: (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 9F21AC0002;
        Sat, 13 Nov 2021 08:09:01 +0000 (UTC)
Date:   Sat, 13 Nov 2021 13:38:58 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, angavrilov@gmail.com
Subject: Re: [RFC PATCH 0/4] git-gui: support SHA-256 repositories
Message-ID: <20211113080858.2cjsd672eh4psdyu@yadavpratyush.com>
References: <20211011121757.627-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211011121757.627-1-carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo,

On 11/10/21 05:17AM, Carlo Marcelo Arenas Belón wrote:
> While poking a SHA-256 hash repository, was surprised to find gitk
> would fail with a fatal error when called, hence this series.
> 
> Sending as an RFC, since I am not a git-gui or gitk user, and so
> while this fixes the original issue and allows me to call gitk to
> see the branch merge history (which is usually as much as I do with
> it), it is likey missing some changes, as most of them where found
> by lightly poking at all of the gui menus (except for remote or tool)

Thanks for the patches, and sorry for taking so long to review these.

The changes you sent look good to me for the most part, apart from a few 
comments I made on the patches. I haven't looked too deeply into other 
places that might need updating but the basic functionality seems to 
work fine for me.

> 
> It could also be reordered to reduce unnecessary churn and of course
> also needs the gitk change[1] that was sent independently, and better
> commit messages.
> 
> [1] https://lore.kernel.org/git/20211011114723.204-1-carenas@gmail.com/
> 
> Carlo Marcelo Arenas Belón (4):
>   blame: prefer null_sha1 over nullid and retire later
>   rename all *_sha1 variables and make null_oid hash aware
>   expand regexp matching an oid to be hash agnostic
>   track oid_size to allow for checks that are hash agnostic
> 
>  git-gui.sh                   | 30 ++++++++++++++++--------------
>  lib/blame.tcl                | 18 +++++++++---------
>  lib/checkout_op.tcl          |  4 ++--
>  lib/choose_repository.tcl    |  2 +-
>  lib/commit.tcl               |  3 ++-
>  lib/remote_branch_delete.tcl |  2 +-
>  6 files changed, 31 insertions(+), 28 deletions(-)
> 
> -- 
> 2.33.0.1081.g099423f5b7
> 

-- 
Regards,
Pratyush Yadav
