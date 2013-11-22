From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Git issues with submodules
Date: Fri, 22 Nov 2013 22:05:29 +0530
Message-ID: <CALkWK0m9MK=RBBor-ZeGrGU9KA6tZa89UUi0J7j9fxr1g6uJtQ@mail.gmail.com>
References: <CAErtv26Q_YN+U+trjNac1aKLi9BvNHNNuaUkrr2RE0nB+yxWsw@mail.gmail.com>
 <CALkWK0n7jdLKOAFoFjuRz0aTCssorAgk2y=Vce76Y5aHWbj53Q@mail.gmail.com>
 <CAErtv27dMepNSbBVdOokn6OF858ENaKooL+FzD7JHtp9nRPufw@mail.gmail.com>
 <CALkWK0nDME-z7G4kcag=ad3qH5FL9FawrYFyVLQB6Z_g+TV+vQ@mail.gmail.com>
 <20131122151120.GA32361@sigill.intra.peff.net> <CAErtv25zrsde7wYg+VUZebow2pmhDnDQG53Dmz_gbjavC-D2cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Sergey Sharybin <sergey.vfx@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 22 17:36:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjtiK-0003lA-Ev
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 17:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756Ab3KVQgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 11:36:12 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:62782 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565Ab3KVQgL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 11:36:11 -0500
Received: by mail-ie0-f172.google.com with SMTP id qd12so2461011ieb.31
        for <git@vger.kernel.org>; Fri, 22 Nov 2013 08:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RsrTRdRX73ujurdWrYV0S5M6yxgeUebAVWfMr++SL3g=;
        b=c/b6NTiTzmYj7jrexRM2CqNtCOaEl0uaSt4Mohj3vhwb9ijt/vQ17vzlksDIMEREzh
         abDCYBuq+w6r1lDe18SvxHUNOhElZaTGiJ8LsLTpYBQVPt7UMuIJjoIYNpGUSiAFeqX/
         mSuDeEUnUd+Mm/ENWKTTE638yukOHlWKoQWvLi8zvzeUiQ+L5mOaXwGTED2V0XinVc1D
         stCU0EnOtBL2ZRUodtIsVc7tYDfUSfSnfYunt6dKrdVLIHHUnN+mnVg0Fu1WwcoZkt4H
         OYdf3brk48Cbvx+ZtRnum+7+c+/cYhHfsdkPr5FlJWGequs5iwEUs65KHEyDEPtcQaiP
         tDHg==
X-Received: by 10.42.60.18 with SMTP id o18mr722774ich.83.1385138169809; Fri,
 22 Nov 2013 08:36:09 -0800 (PST)
Received: by 10.64.73.36 with HTTP; Fri, 22 Nov 2013 08:35:29 -0800 (PST)
In-Reply-To: <CAErtv25zrsde7wYg+VUZebow2pmhDnDQG53Dmz_gbjavC-D2cA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238195>

Sergey Sharybin wrote:
> Ramkumar, not actually sure what you mean?
>
> For me `git diff --name-only HEAD --` ignores changes to submodules
> hash changes.

`git diff --name-only HEAD --` compares the worktree to HEAD (listing
both staged and unstaged changes); we want `git diff --name-only --`
to compare the worktree to the index (listing only unstaged changes),
as Peff notes.

> Also apparently it became a known TODO for phabricator
> developers [1].

That was me :)

> So, after all is it expected behavior of ls-files or not and if not
> shall i report it as a separate thread? :)

Actually, I doubt it's worth fixing ls-files. Your problem should be
fixed when this is merged (hopefully in a few hours):

  https://github.com/facebook/arcanist/pull/121

Cheers.
