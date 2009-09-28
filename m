From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Deciding between Git/Mercurial
Date: Mon, 28 Sep 2009 11:36:49 +0300
Message-ID: <94a0d4530909280136s1ff65004q1733bd4ef78bdc07@mail.gmail.com>
References: <h9nlhj$heq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: newsgroups@catchall.shelter13.net
X-From: git-owner@vger.kernel.org Mon Sep 28 10:37:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsBj9-0003ZF-B8
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 10:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbZI1Igt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2009 04:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbZI1Igt
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 04:36:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:27449 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbZI1Igt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 04:36:49 -0400
Received: by fg-out-1718.google.com with SMTP id 22so1396527fge.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2009 01:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=7cTPdJZ6ZUCsXC8gvODDkH195teQfZlHlArVkj9Op9E=;
        b=EG55EdNzI8pxp50nZU+eW9qyNVaDsOtkcS7B4XrzxhkeCFTIMrnHSBnqLp89rHpLI3
         PTEznofn9YacSfPdiXCGzVVpH3W/Tfb5HxMBrFhKOlMl9jzaTksFosj2hALs0H3bHYr4
         8RTURRI4ntyJ2wxx4FzlkD+wi9ED7XqP9ef9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=vYvoV/ee9wnrF69liUizIfsJdM04oo5S3E+WqyGKKq0+Pah4wxFt9td3uLCCZOGm/k
         XlqGP8CKF1LkjFLbcvBbgbhl2OyF9RqbOhrYmKLoduiFYSHVv38g+N7jy6jVjrz7cQYS
         ISh+Qa4a93/GfR8BxgMvU7DIxa8fj7Lq6neAA=
Received: by 10.86.17.29 with SMTP id 29mr3061263fgq.38.1254127011994; Mon, 28 
	Sep 2009 01:36:51 -0700 (PDT)
In-Reply-To: <h9nlhj$heq$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129237>

On Sun, Sep 27, 2009 at 3:24 PM, Anteru
<newsgroups@catchall.shelter13.net> wrote:
> Hi,
>
> I'm currently evaluating DVCS for a project, and we're at a point where
> it comes down to either Mercurial or Git. Right now, I'm advocating for
> Git, while my co-workers like Mercurial, so I'd like to provide some
> good arguments in favor of git. Unfortunately, I'm not a git expert, so
> I hope I can get some help here ...

IMO the key difference between hg and git is the storage model: hg
stores deltas, while git stores snapshots. That would mean that
certain operations are theoretically faster in git (e.g. checkout,
diff) while others faster in hg, although with git's packed format I
guess there's no operation faster in hg. This means that it doesn't
matter how much hg's python code improves, or if they even re-write
parts in C, they will never be able to match git's performance (unless
they change the storage model, which essentially means changing the
whole design -- won't happen).

All this is just guesses, I've thought about doing some measurements
but I haven't had time.

Cheers.

-- 
Felipe Contreras
