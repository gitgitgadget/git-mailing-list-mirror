From: Michael Witten <mfwitten@gmail.com>
Subject: Re: surprising behavior from merge
Date: Fri, 11 May 2012 23:57:22 -0000
Message-ID: <ae419d8bbc2b44bfa4c0a7eb421f5037-mfwitten@gmail.com>
References: <9A9AD20F-B316-4DC1-8C6A-E0FC6ED80A61@highlab.com>
Cc: git@vger.kernel.org
To: Sebastian Kuzminsky <seb@highlab.com>
X-From: git-owner@vger.kernel.org Sat May 12 01:59:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSzjl-000659-0G
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 01:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761371Ab2EKX6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 19:58:49 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:48551 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761336Ab2EKX6k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 19:58:40 -0400
Received: by wgbdr13 with SMTP id dr13so2939382wgb.1
        for <git@vger.kernel.org>; Fri, 11 May 2012 16:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=t9a6bOQ/RlVvkFItwUq4OXrkeUmqKxrH6jhwALfYU9U=;
        b=F/wEDxJ1KfXvbKYFHMLA7EVbT+6vThdJI5iNZpuqJYaXzoDBaQ5H0XMpb0RpmIXvf0
         Xtw3cYdxMyhjoPQ6JBq3+RFP8bnqSVdYLyJTIxf/4dwjIJMyH1zLx/cGYv2/LxjeEx7f
         +dmhj9P7QDXA4dVuYIH8U/mCTkTG1zQer4kPGPEBvLxHdK9If5NZhHoQnyl/rw0TEhYu
         n16a+uIPZNHXaTA1d4P+48AIKmHe/E4B806lPqse4UbEJcqdmW4bvt5uiUyEVG6EZ2/i
         xRMi3bbK+pB6ZuQF11td1RDVJo/KO8dUez8B/sTyU1iOtip6orEXAULWoErz3pWdgCLq
         noZw==
Received: by 10.180.83.196 with SMTP id s4mr65741wiy.15.1336780719266;
        Fri, 11 May 2012 16:58:39 -0700 (PDT)
Received: from gmail.com (tor20.anonymizer.ccc.de. [31.172.30.3])
        by mx.google.com with ESMTPS id ca3sm14276850wib.6.2012.05.11.16.58.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 May 2012 16:58:38 -0700 (PDT)
In-Reply-To: <9A9AD20F-B316-4DC1-8C6A-E0FC6ED80A61@highlab.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197708>

On Fri, 11 May 2012 16:25:29 -0600, Sebastian Kuzminsky wrote:

> Hi folks, I just ran in to a strange behavior with git merge.
>
> Things start out with two branches (let's call them 'master' and
> 'other') pointing at a particular commit. In master I commit a
> small one-line change, then make a second commit that adds some
> stuff just after the line changed in the previous commit. In the
> other branch, i cherry-pick the second commit from master (the
> one that adds the new stuff). The cherry-pick succeeds, despite
> the fuzzy context. So far, so good.
>
> Next I try to merge other into master. I expected it to notice
> there was nothing to do and leave the master tree unchanged,
> but it applied the "add new stuff" patch to master (even though
> that patch is already in master) and made a commit from that. So
> it silently did the wrong thing, and now the file contains two
> copies of stuff I added.
>
> That is a simplified version of what happened, in my real repo
> there were several (unrelated and unimportant) commits on both
> master and the other branch. When the surprising double-add
> happened, i simplified the repo to remove distractions.
> The simplified repo is here if anyone wants to inspect it:
> https://github.com/SebKuzminsky/merge-problem

It would obviously be helpful to supply:

  * Explicit commands that anyone on the list can try and discuss.
    For example:

      git init repo
      cd repo
      echo a  > a; git add a; git commit -m 'small one-line change'
      echo b >> a; git commit -am 'adds some stuff after'
      ...

  * Expected behavior from those commands.

  * Actual behavior from those commands.

In other words, rather than burdening people with the task of
constructing a mental picture of what you have done, you should
show them as directly and precisely as possible; in this way,
people can go about the business of discussing your issue much
more quickly and, most importantly, PRECISELY.

Sincerely,
Michael Witten
