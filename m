From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC] Add posibility to preload stat information.
Date: Wed, 20 Mar 2013 22:45:22 +0530
Message-ID: <CALkWK0=b80U5dxGMpwKwL+jFURisEuSapWuuNRFcP+5R2f3+GA@mail.gmail.com>
References: <1363781732-11396-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: spearce@spearce.org, git@vger.kernel.org, pclouds@gmail.com,
	Jeff King <peff@peff.net>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 18:16:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIMcV-0003W9-Q0
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 18:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566Ab3CTRPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 13:15:43 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:61730 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207Ab3CTRPm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 13:15:42 -0400
Received: by mail-ie0-f173.google.com with SMTP id 9so2367461iec.32
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 10:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=6r4gmN/Ii6lshmZsFPPHx4GjJ6akqWuTvjqEUsNQ7Ao=;
        b=TpoomYgq2wEQ90eL6JPectNbvvDlMMEEQgqyfl7L7Q8SGzrs0GSGpeIfoVTb7LU0KJ
         HjOQG7aI8ZjWUVIYzIohagfg970rw3qVKPPQjGaZ8z2PjogBbw5S73IG4s5tqCDRn/CS
         fvrk21Hb5FBtbQ/Awz0V5qGpnaPKaEcC6Kw46Fh97u/58TjI3Qz1+gmWSBJC1duJmKsB
         hQ0g+YTd1lJm2i7Rqdth80+1z8ePn2JyalhzEmhdnOefmBrHLAlyE/ecWZS8QchdIvt9
         tELfET55YrR2SvgH0bhkG3glloIRJPwmOhCBJuc2Ab2o3WeIDQoO+iCK9PJf5J2oXTdd
         MXsg==
X-Received: by 10.50.108.235 with SMTP id hn11mr4619319igb.107.1363799742140;
 Wed, 20 Mar 2013 10:15:42 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Wed, 20 Mar 2013 10:15:22 -0700 (PDT)
In-Reply-To: <1363781732-11396-1-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218622>

Fredrik Gustafsson wrote:
> When entering a git working dir, optionally run a forked process that
> stat all files in the whole workdir and therefore loads stat information
> to RAM which will speedup things like git status and so on.

This is misleading.  You just execute the equivalent of `git status`
everytime I request a prompt inside a git working directory.  And this
is if I'm using __git_ps1() to augment my prompt, which I'm not- I use
ZSH's vcs_info, which is arguably better.  Also, you forgot to say how
to turn on the feature.

That said, this feature is extremely gross; it thrashes my filesystem
and hard drive.  Modern software is written to minimize IO, not
maximize it!  I'm completely against the inclusion of this patch.

However, I would not mind a feature that runs `git status` the very
first time I enter a git working directory: when I enter my clone of
linux.git, it takes my first `git status` invocation a good ten
seconds to complete, and we can fix this pretty easily.
