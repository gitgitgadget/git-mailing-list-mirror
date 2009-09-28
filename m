From: Adam Brewster <adambrewster@gmail.com>
Subject: Re: thoughts on a possible "pre-upload" hook
Date: Sun, 27 Sep 2009 22:01:09 -0400
Message-ID: <c376da900909271901q1667ecacw730ba5180a558f3b@mail.gmail.com>
References: <2e24e5b90909220320rbd5fd1l40c7898656445232@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 04:01:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ms5YD-00049O-Vq
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 04:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485AbZI1CBH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Sep 2009 22:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752242AbZI1CBH
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 22:01:07 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:44071 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbZI1CBG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Sep 2009 22:01:06 -0400
Received: by ewy7 with SMTP id 7so4049680ewy.17
        for <git@vger.kernel.org>; Sun, 27 Sep 2009 19:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5izBxRztl8p6Skq60RT7tQY3Oj5B3phwXJvB9eUvP/Y=;
        b=FUN0BhwEkkRQcn7wLm7y4fGoCL7UWe0LeOiIOCvWRqDSv1bnJ0A9pZcP/eapU87RDW
         Dbz8u7BJcVy9QhPDPQ2exHt35IIbuCpK0Lg6UcVOA/ftGzUYauFWAg7fZdkk4a8HGakO
         zZaVBsHaodIgl2bHC/sAgr5wrkdVqeR55OO9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Y1v2VZZR1hMRln6MJNOOyrGgL1Oj3Cyk1OdJItd45XU11PuUzyh9qqxdzGF4Jj2xX1
         69RYQDQfTTbYHvoC8gwcG/QbWqK+iC71RHT4PUSiqCGxhyv5Yw0sgH940Xm8UOIaMFt5
         WFJ++frqPo7RxEO+668pbW6N+jOhvXEFfUcF0=
Received: by 10.216.91.73 with SMTP id g51mr639832wef.68.1254103269251; Sun, 
	27 Sep 2009 19:01:09 -0700 (PDT)
In-Reply-To: <2e24e5b90909220320rbd5fd1l40c7898656445232@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129222>

> As git is used more and more in corporate-type environments, at some
> point it becomes convenient to have *branches* (or more accurately,
> refs) that are not readable. =A0The simplest way to do this (from git=
's
> point of view) is to allow a "pre-upload" hook, rather like the
> "pre-receive" hook or "update" hook.
>

What's the benefit of this over using multiple repositories?

=46or a simple case where you have public branches and private branches=
,
you use public.git and private.git.  A post-update hook in private.git
can automatically push the appropriate branches to public.git (in
which case they don't worry about public.git at all) or they can do it
themselves.

=46or more complex access control, give each sub-unit that needs to
share work a repository that's only readable by the members of that
unit.  Each developer works in his own repo.  When something is ready
for a wider audience, he pushes it to a team repo.  When a team leader
has something that's ready to move up, he pushes to a group repo, etc.

--
Adam
