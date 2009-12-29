From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Possible bug in 1.6.6 with reset --hard and $GIT_WORK_TREE
Date: Tue, 29 Dec 2009 15:38:28 +0700
Message-ID: <fcaeb9bf0912290038u77a5e83cqe2f3cbfab05af263@mail.gmail.com>
References: <1a04eebf0912282247p6975a96el8076cb39378bd104@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Fyn Fynn <fynfynn@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 09:38:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPXb9-0003Bs-5C
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 09:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbZL2Ii3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 03:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbZL2Ii3
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 03:38:29 -0500
Received: from mail-px0-f189.google.com ([209.85.216.189]:40290 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbZL2Ii2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 03:38:28 -0500
Received: by pxi27 with SMTP id 27so6082276pxi.4
        for <git@vger.kernel.org>; Tue, 29 Dec 2009 00:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=HYxqdhPUk7gW7ssZaKSJAv23W9JzWuYVBHCfi027quw=;
        b=YpuscuKEnEd2//wS4FQKcDNfPmF0ayxPhjXKV9nyfzbPdLZZwjx8n5LG8jiHPAq4jZ
         SUuULU3ymIzgJHaFfrWIBgatjWlomBGZAS5oafe8CpL5y0bS1iRnm5qN/wEfbK8KYXjA
         Bem8LfQRkeJ1dXZaSGcK3mzfTSyq6xeTPTndU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=r14hlmzgCEW3LkXfaPgOtdLM243clbiblE/aHrt5xL3wl+wo4lAtfq3co32Ey2dj96
         pDYZrdS1Pxk8c4gngFeW0O/3P1B7TREDngGM5r8JKVWoh7usVSNb5uaen9tsvkes8PzU
         PAR/lXxILe2tU2HTkzwDt4iwwC/tXzmr+8TiE=
Received: by 10.114.242.8 with SMTP id p8mr11344672wah.169.1262075908221; Tue, 
	29 Dec 2009 00:38:28 -0800 (PST)
In-Reply-To: <1a04eebf0912282247p6975a96el8076cb39378bd104@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135784>

On 12/29/09, Fyn Fynn <fynfynn@gmail.com> wrote:
> The exact same git reset command that works in 1.6.4, fails to work
>  under 1.6.6:
>
>  $ GIT_WORK_TREE=$HOME/rawdata/ GIT_DIR=$HOME/rawdata/.git
>  /usr/local/git-1.6.6/bin/git reset --hard
>  fatal: hard reset requires a work tree
>  $ GIT_WORK_TREE=$HOME/rawdata/ GIT_DIR=$HOME/rawdata/.git
>  /usr/local/git-1.6.4/bin/git reset --hard
>  HEAD is now at 77ec73f...
>
>  What gives?

A recent patch by Jeff (952dfc6 (reset: improve worktree safety valves
- 2009-12-04)) makes sure that "git reset --hard" will not work
outside worktree (which is right). Where was your current directory,
inside $GIT_WORK_TREE or outside?
-- 
Duy
