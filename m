From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Documentation/git-worktree: fix stale "git checkout --to" references
Date: Thu, 16 Jul 2015 15:57:58 -0700
Message-ID: <xmqq4ml34snd.fsf@gitster.dls.corp.google.com>
References: <1437084583-6382-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 00:58:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFs6P-0007DF-Pp
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 00:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756556AbbGPW6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 18:58:00 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36355 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbbGPW6A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 18:58:00 -0400
Received: by pacgq4 with SMTP id gq4so5431564pac.3
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 15:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=VtHkcWErnZLh4YstaZBn3r8fSwqK8dJllLW+Sgd9k08=;
        b=PYnkInYFsBGWgYoqBFkDWrUgkxHM76u4YLrOyER48n52T21ItoSMWexHBZQH8LbrwM
         tDAG7Y9ZfYQvu/73RaHzCO4U/6zDLv8B9bMVDaNfZWKmi0dAlwRZWF8MEt5m70GmX2pO
         drqxTu3RpOhLYoSZIaK93vRZE0yB+tDZ1VzXc4orGWbnGjSiA6lz4ojJkB4Gr4gw1e6H
         g6CqUnTrbK8T9rF02mwF6l6l3tnrszW9wzShtOajxwakghfryGS8VXeYDDs8kZqTnxUQ
         keuK40OXCMeqO9fDKB7yR19d8iFEaukPkc2yQOPrsrBnD1YChIYXrO3acO4LRzN31rbz
         ReTQ==
X-Received: by 10.66.159.1 with SMTP id wy1mr23565341pab.103.1437087479661;
        Thu, 16 Jul 2015 15:57:59 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:117b:74b0:a5d4:7d4c])
        by smtp.gmail.com with ESMTPSA id td3sm9074213pab.46.2015.07.16.15.57.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 Jul 2015 15:57:58 -0700 (PDT)
In-Reply-To: <1437084583-6382-1-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Thu, 16 Jul 2015 18:09:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274049>

Eric Sunshine <sunshine@sunshineco.com> writes:

> These should have been changed to "git worktree add" by fc56361
> (worktree: introduce "add" command, 2015-07-06.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>
> Changes since v1[1]: Reference the correct commit (fc56361, not b979d95)
> in the commit message. Sorry for the noise.
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/274046

Thanks.  Will apply.

By the way, given the rate of bugs and glitches I am finding in this
code with a very superficial use in real work only for a few days,
perhaps we would want to add a warning to the documentation of "git
worktree", in addition to the "this is still experimental" mention
in the release notes, to discourage people to keep their only copy
of the work in a secondary worktree for now?



 Documentation/git-worktree.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index da71f50..6de4c21 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -157,8 +157,9 @@ $ git worktree prune
 
 BUGS
 ----
-Multiple checkout support for submodules is incomplete. It is NOT
-recommended to make multiple checkouts of a superproject.
+Multiple checkout in general is still experimental, and the support
+for submodules is incomplete. It is NOT recommended to make multiple
+checkouts of a superproject.
 
 git-worktree could provide more automation for tasks currently
 performed manually, such as:
