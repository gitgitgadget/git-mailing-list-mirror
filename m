From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 3/4] refs: make refs/worktree/* per-worktree
Date: Sat, 15 Aug 2015 15:04:11 +0700
Message-ID: <CACsJy8DSD2orHh0EqfF249fR_dgdZyABhgHubFW=LZ4VEpz+7w@mail.gmail.com>
References: <1439416645-19173-1-git-send-email-dturner@twopensource.com> <1439416645-19173-3-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Christian Couder <chriscool@tuxfamily.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 10:04:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQWSQ-0000Wt-SG
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 10:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbbHOIEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2015 04:04:45 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:34099 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbbHOIEl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2015 04:04:41 -0400
Received: by oip136 with SMTP id 136so55859197oip.1
        for <git@vger.kernel.org>; Sat, 15 Aug 2015 01:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LwRQcCc4YVZqea5qE/fMlpO8+/xKa7vHF/vv9K+ogzE=;
        b=ldF+zn1+u52WOKyYNwNhpoW5QdkHl5r5Gud0rFue+UFA9IIoPxTBzNJ0ALMhO3/dAs
         Ge8HBNIXJrqdNek/9hhRj2ai/nEWWIw4KT6GMRMD6kntOvMgB1+KvwABxM4gfeoa+LVY
         UC6LY9aENM35kH8PMsWzgebPoaHSnwhQqMyt/EAHXDT4l4B6EdKxSvfqY/EZBrgganhE
         IeDBx/ZXg+lDgczHzHIb04lnBIARQ5plFIsI9WdkpyAX6TYuSDLIDCUuHjln8XDVHpm7
         kjdGKhXBoDH3WzIyH8CijuTF4p8aAsVglOJi7FqQdWmJxYF7AHkGzgPwGMYnUVrUshye
         ngYQ==
X-Received: by 10.202.195.71 with SMTP id t68mr32539686oif.117.1439625881358;
 Sat, 15 Aug 2015 01:04:41 -0700 (PDT)
Received: by 10.202.52.6 with HTTP; Sat, 15 Aug 2015 01:04:11 -0700 (PDT)
In-Reply-To: <1439416645-19173-3-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275981>

On Thu, Aug 13, 2015 at 4:57 AM, David Turner <dturner@twopensource.com> wrote:
> We need a place to stick refs for bisects in progress that is not
> shared between worktrees.  So we use the refs/worktree/ hierarchy.
>
> The is_per_worktree_ref function and associated docs learn that
> refs/worktree/ is per-worktree, as does the git_path code in path.c

I assume you want to iterate over all these per-worktree refs later
on. Otherwise just moving bisect refs outside refs/ would
automatically make them per-worktree. But then it would polute
$GIT_DIR some more, so probably not the best move. So yeah,
refs/worktree is probably for the best.
-- 
Duy
