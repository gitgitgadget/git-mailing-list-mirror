From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git Confusion
Date: Fri, 29 May 2009 06:44:26 -0700 (PDT)
Message-ID: <m3d49sauru.fsf@localhost.localdomain>
References: <815c8c330905290043i4c99a753jd5ad9bdd4cf18bbc@mail.gmail.com>
	<20090529125853.GB11785@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Tarjan <ptarjan@gmail.com>, git@vger.kernel.org,
	yury239@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 29 15:45:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA2OM-0006af-I1
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 15:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760855AbZE2No3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 09:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760736AbZE2No2
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 09:44:28 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:62273 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760904AbZE2No1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 09:44:27 -0400
Received: by bwz22 with SMTP id 22so6136994bwz.37
        for <git@vger.kernel.org>; Fri, 29 May 2009 06:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Df/UAxxq/7hOgPD+MkoUSOccESDOiJ0bzJO3zd8Epn4=;
        b=EY+QGQ52loVylSw2wV2b6gX++1zRwEB25yTHKpWl3xYduolFSDf3RUvjqev0KvPXQV
         gmV9GT+jYaRadcKhcKB3vp5wrjd8eUcStLdF0KwSWDgniKPW53qVxFGBhuCBNHqlujz7
         fL1mzv5I9mN+ldgWDH3KZ0IdsjhiGa4qqFXa0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=AH3pV1ynfqQApg6MvPJadt8OD8GsBJ5acM1Fqu5EDniaacoCmD0iZvjFtC5ZPZcDog
         0M4Lixa586VWr+8h9/N15dtamPVnx61cAMJRgexsAHPzx/sv3y3g7tZK53Z5PuslCDBX
         CE0LEB2v636yq/3T5KDLEG5aER3Bp8kmyYwTM=
Received: by 10.103.52.13 with SMTP id e13mr1633314muk.46.1243604667241;
        Fri, 29 May 2009 06:44:27 -0700 (PDT)
Received: from localhost.localdomain (abwe32.neoplus.adsl.tpnet.pl [83.8.228.32])
        by mx.google.com with ESMTPS id y2sm4393215mug.13.2009.05.29.06.44.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 May 2009 06:44:26 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4TDiO3E013361;
	Fri, 29 May 2009 15:44:25 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4TDiMwF013358;
	Fri, 29 May 2009 15:44:22 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090529125853.GB11785@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120278>

Jeff King <peff@peff.net> writes:
> On Fri, May 29, 2009 at 12:43:35AM -0700, Paul Tarjan wrote:
> 
> > I'm new to git and probably doing something very dumb, but I can't
> > seem to resolve this.
> > 
> > I have a remote repository and a local one. I ssh to the remote
> > machine, goto the repository directory (not a bare repository), edit a
> > file and commit it. All if fine.
> > 
> > I leave the remote host and go into the local git directory. Doing
> > "git pull origin master" says "Already up-to-date." but there is a
> > file I changed remotely, and I want to pull it locally!
> > 
> > The local repo was made with "git clone http://example.com/.git". I
> > have no branching (both are on master).
> 
> Your repository is accessed over http.  You need to run "git
> update-server-info" to build the files for clients to see the actual
> updates.
> 
> Usually such a repo is bare, and gets updates only by push. In that
> case, enabling the update hook to run update-server-info is sufficient.
> But in your case, you are actually working on the remote repo via commit
> and other means, so there is no convenient way to always
> update-server-info after a change.

Well, he can always add git-update-server-info to post-commit hook.

> 
> Is there a particular reason you cloned over http instead of over ssh?

Or git protocol?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
