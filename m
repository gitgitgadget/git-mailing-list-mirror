From: Christian MICHON <christian.michon@gmail.com>
Subject: Re: on pulling/cloning git notes
Date: Thu, 24 Jun 2010 14:25:13 +0200
Message-ID: <AANLkTilGS6t29J4NQMgseZY9WD1kAPCr9oFeQt1RaWjP@mail.gmail.com>
References: <AANLkTilDMVU6b7SwHx0Bztu1rTCubiIPTuDDX6pJBcHx@mail.gmail.com>
	<4C2329E5.8050904@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jun 24 14:25:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORlUh-0003FC-05
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 14:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755304Ab0FXMZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 08:25:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:3097 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755298Ab0FXMZP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 08:25:15 -0400
Received: by fg-out-1718.google.com with SMTP id d23so2012931fga.1
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 05:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=3D++JhlQE6MEKoYbBc5HCloNoWjSl4UDt/dgnzfJyE0=;
        b=DTdzO4Z9XB1g7cSR5K9hD2BqweZrNYbMoGD+sAtTOLmyG450U7l2p+WFLhyyJ98loC
         QcqvyNMxlWINEZLHTK7TOYs3Gd1aQFQEIg4w+zHWgHZQ92tVhPn6JTw68mks1LHhA3QB
         8zg98jaGaJY1ahKihzQlaspdT8fsH53F8twss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=W5DkyTB96wDNhKQPICmPDd3EwXi0rmEB1dio0VQpQHlZ1fq/IZQtFQULHAVQLpCWI2
         Pp1hM4co+lpy/T2E5+pOvL4HknMGWJ88ZutL30D3+fq7/g9ob3zkeo7ZOM64chtXaZqv
         uY23vD3Zf2REZSfmr9uYIu+QiS1zEs7eRvlEc=
Received: by 10.103.184.13 with SMTP id l13mr3086890mup.87.1277382313351; Thu, 
	24 Jun 2010 05:25:13 -0700 (PDT)
Received: by 10.103.138.8 with HTTP; Thu, 24 Jun 2010 05:25:13 -0700 (PDT)
In-Reply-To: <4C2329E5.8050904@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149587>

On Thu, Jun 24, 2010 at 11:48 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> As you can see from the default "fetch" line above, "refs/heads" are
> fetched by default (when cloning, fetching etc.), but nothing else
> (well, besides some tags). You can set up an additional fetch refspec to
> get the notes also.

I'm actually doing a fresh clone elsewhere, using 'git clone --mirror
gitolite:daat'.

I was expecting to grab everything from the remote refs, as in this
case my .git/config will look like this:
[remote "origin"]
        fetch = +refs/*:refs/*
        mirror = true
        url = gitolite:daat

> It's not done by default because it's up to you decide what to do with
> the notes. Sometimes, you want them to end up in "refs/notes" so that
> they are displayed by default. But maybe you want them in
> "refs/notes/remotes/gitolites" e.g. and display them only on request
> (--show-notes=remotes/gitolite), or merge them into your own notes.
>

So the * in .git/config was misleading me. Instead I changed the fetch
to this after the original clone, then performed an incremental fetch
and it worked.

[remote "origin"]
        fetch = +refs/heads/*:refs/notes/*
        mirror = true
        url = gitolite:daat

Thanks for the hint, Michael!

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
