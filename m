From: David Aguilar <davvid@gmail.com>
Subject: Re: Unifying mergetool configuration between git and git-gui
Date: Sun, 22 Jul 2012 19:00:29 -0700
Message-ID: <CAJDDKr4aeDToxw177pBoZE5SW5hRoM3_xWi9oHLz0gmRkpVFTw@mail.gmail.com>
References: <500C0C9F.1000709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 04:00:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St7wv-0006M2-N6
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 04:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242Ab2GWCAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 22:00:34 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:55518 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab2GWCAa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 22:00:30 -0400
Received: by vbbff1 with SMTP id ff1so4256882vbb.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 19:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YuPn0WFyph7XD6EGizOA8PuUDC9jTrvRtiAsBcb9Nv4=;
        b=BYLMgBPTC6jsVKF3eAcF9NiUEpYGxH1qzgxjtqB0dfhNrVm4H5bbX1grvG7O/NtLmg
         HZDYcO4tolOHWXuFUhzYgI08Wh3DqGMtCSaPHfvLk7U2LB/Vh/M1E2KtvB2vzRKr28Sm
         4lDKHpApOBFkYwjLFzwQGo8apL7zqt4JaTZq4PmVSbrhGusUnYYAON3TFwRr5iP/tmAb
         uj3CppzjSwD1nkwe5qpALGh+US8a/lOo3S1D72EGh3tGR+vwoknCDxIOvG4BdaKGamI6
         c3wc/ZZuZJ13LEZxEAl5rq4t2aa01Yt6bgNTxFW8JnYJl6U6ByRwCJrqmomWi1C3t3zG
         Jdcg==
Received: by 10.52.72.99 with SMTP id c3mr9711007vdv.54.1343008829441; Sun, 22
 Jul 2012 19:00:29 -0700 (PDT)
Received: by 10.52.114.67 with HTTP; Sun, 22 Jul 2012 19:00:29 -0700 (PDT)
In-Reply-To: <500C0C9F.1000709@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201879>

On Sun, Jul 22, 2012 at 7:22 AM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> Hi,
>
> I was about to add a configuration for yet another mergetool when I realized
> that git gui's mergetool.tcl pretty much duplicates git's mergetools/*
> configuration files. Can some one tell me why this is necessary? I would
> have expected git gui to simply rely on "git mergetool" to launch the
> mergetool. Or, in case that git gui needs to use a different tool than the
> one configured as mergetool, that mergetool.tcl somehow uses the
> configuration from mergetools/*.
>
> Thanks for any insights.

I think the mergetool stuff in git-gui predates git-mergetool.

Ditto the "external diff" stuff in gitk -- it predates git-difftool.

It would be good to unify these so that the difftool/mergetool
experience is consistent.

As for how to have different diff/merge tools in GUI vs non-GUI modes
-- we have 'diff.guitool' to override 'diff.tool' when "git difftool
--gui" is used.  We do not have an equivalent 'merge.guitool', but
that would probably be the way to do it.
-- 
David
