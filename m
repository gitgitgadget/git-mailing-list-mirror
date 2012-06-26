From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Egit/Jgit support for relocated .git directories
Date: Tue, 26 Jun 2012 08:40:16 -0700
Message-ID: <CAJo=hJubPwt8y4NhhctMag5Yr6cbYXZ4sORTB1=FkTjQZhEsTQ@mail.gmail.com>
References: <4FE97057.3040609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, jgit-dev@eclipse.org,
	egit-dev@eclipse.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 17:40:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjXsk-0000AV-MI
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 17:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758551Ab2FZPkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 11:40:39 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60828 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758541Ab2FZPkj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 11:40:39 -0400
Received: by dady13 with SMTP id y13so56470dad.19
        for <git@vger.kernel.org>; Tue, 26 Jun 2012 08:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+zgRdqWtok4uQe+E5MaHnp8qxTngHhsbyjuJ9NeK8yk=;
        b=GHcvEf6t/D7Bvb/BRfF4wxDsYlVdYvtwCr6u/KecTnyzSzvlWilWYO+hYF3y6hQ0vt
         LNc821w4pL7JRqLiKrGgGVSCqy9K1ybw/a10EkZYMICMNsaPzFx9cLx+7fW9cpbev6u+
         20h8xpjRd2b8Vz6caoDqDz0+yVUHNkERnWATc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=+zgRdqWtok4uQe+E5MaHnp8qxTngHhsbyjuJ9NeK8yk=;
        b=JgtYHcmOZC/lHEl6hSJIZca8A2MOzt0yboGT9NaOI3SR2IfTTIb7aHNyvvMG2ONLSH
         ZFvAB+Otdn1n/OdNvnRo4rBeZS+IPo9VmMKvQ7YBgA60zTyXnoeTRTwq9Lfm2XHPx2cj
         SGbwSBXysiNseui1ZUsezAaXgBcXKBVHXGaJk3QZBm/CkN0k+fRVUXlDVrQycbFhkM3K
         IG0tvywDBdINWdYGlrUd1YVMMeH1hx9IlwFsEXByBwIXB8tLsj4fk/CZ6VoE80jsWgNX
         Wsap+JC7x7PieIff6evA/X14UuaXYsumrrQaMbZsCUWXSOfAk0kjssrkrEYbdptvR9/N
         vetg==
Received: by 10.68.197.198 with SMTP id iw6mr53491623pbc.36.1340725238416;
 Tue, 26 Jun 2012 08:40:38 -0700 (PDT)
Received: by 10.68.52.169 with HTTP; Tue, 26 Jun 2012 08:40:16 -0700 (PDT)
In-Reply-To: <4FE97057.3040609@gmail.com>
X-Gm-Message-State: ALoCoQkIa+DmwJA9p+okURLeOdnGH+5Eb1BcCyKnFhCKYXPuzba15rIm3mo/mdoUpclLbS/4D/Ff
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200652>

On Tue, Jun 26, 2012 at 1:18 AM, Chris Packham <judge.packham@gmail.com> wrote:
> This is a bit of a secondhand bug report/query so sorry if the details
> are a bit sketchy.
>
> Since git 1.7.8:
>
> ``When populating a new submodule directory with "git submodule init",
> the $GIT_DIR metainformation directory for submodules is created inside
> $GIT_DIR/modules/<name>/ directory of the superproject and referenced
> via the gitfile mechanism. This is to make it possible to switch
> between commits in the superproject that has and does not have the
> submodule in the tree without re-cloning.''
>
> I've had several colleagues at work tell me that with the relocated
> $GIT_DIR the Egit integration with eclipse doesn't work. I can't really
> qualify "doesn't work" but from what I've been told importing the
> project works but blaming/annotating doesn't.
>
> I believe the gitfile mechanism isn't new but it possibly hasn't been
> used by many Egit/Jgit users. Can anyone confirm if it is supported by
> Egit/Jgit (and I'm barking up the wrong tree).

I am pretty certain we forgot to support gitfile in JGit. Hence this
doesn't work in EGit.

Whoops.
