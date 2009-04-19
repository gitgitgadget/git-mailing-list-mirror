From: David Aguilar <davvid@gmail.com>
Subject: Re: Git within Git what a git
Date: Sat, 18 Apr 2009 21:53:15 -0700
Message-ID: <20090419045314.GA5414@gmail.com>
References: <23070273.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: elkten <elkton.gen@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 19 06:59:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvP7h-0006h1-83
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 06:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbZDSExY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 00:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbZDSExX
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 00:53:23 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:43264 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbZDSExW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 00:53:22 -0400
Received: by wf-out-1314.google.com with SMTP id 29so1446036wff.4
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 21:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=JFo2myzpBWunt6HI1pe0goiJsIqrpAzAYLGf8ZJVfD8=;
        b=bSdtWQhtj8F1/EdQyqD3HE+54dQlff81W5XzBQFwMFkiDoWtsoAp+XIkeHGnE0b39z
         4q7l1anhyzrc/zKhn9OiW2F6QIa/JnPYkJaWYh2A2ixBjk3CaLtxLQ8cBzFXfVKQYjXg
         awA+dFs+GH+MOtpbFdce8v/jiwaeAm+07Jasw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=seHHSJyUSEfFOXcACXqb+l6Ko9buiOSu2u8QdZV6kjpggSxxtJRtuxhB9FtneVTuHc
         t/Lv6nMyrydhAIXorAWrVHkMv2cZzUV0YwB4w6YXkMcj8AomKyKU5Yb0whq80rLt8swm
         tCsNSzRtiiDCfFoqVKipMFGOcUqPxiBsswBSk=
Received: by 10.142.51.4 with SMTP id y4mr3956590wfy.39.1240116801906;
        Sat, 18 Apr 2009 21:53:21 -0700 (PDT)
Received: from gmail.com (cpe-76-87-90-126.socal.res.rr.com [76.87.90.126])
        by mx.google.com with ESMTPS id 32sm12184102wfc.36.2009.04.18.21.53.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Apr 2009 21:53:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <23070273.post@talk.nabble.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116883>

On  0, elkten <elkton.gen@gmail.com> wrote:
> 
> Hi All,
> 
> Before I go hacking the git source code, I would like git to be able to
> manage git trees in git trees, however I would like to check it can't

git-submodule has a google summer of code entry that's sounds
like it's right up your alley:
	http://git.or.cz/gitwiki/SoC2009Ideas

You help in making it happen would be awesome, especially when
handling large collections of git projects.

I'm sure you've seen Shawn's repo project?  (google android + repo)
If your timeline is shorter then he already has lots of
functionality in there.

	http://source.android.com/download/using-repo

Longer term (and I think Shawn agrees with this) we want it all
back in git, hence the gsoc project.

Are you looking at running some of fedora's infrastructure with
this, or was that just an example?  If so, that'd be really
interesting since those are the same kinda problems any large
organization runs into (lots of projects, lots of disconnect git
repos), and something I would be interested in helping out with
as well.


> already be done, let me give an example...
> 
> Imagine a directory structure thus...
> 
> fedora12-rc3/
> |-- .git
> |-- init
> |   `-- .git
> |-- kernel
> |   `-- .git
> `-- libpng
>     `-- .git
> 
> fedora12-rc3 is the attempt at a fedor12-rc3 build, inside are the packages
> for init, the kernel and libpng, each of these init, kernel and libpng have
> their own branches which correspond to their respective versions.
> 
> Inside the fedora12-rc3 directory is also many branches called fedora12-rc2,
> fedora12-rc1 etc...
> 
> I would like to be able to "git checkout fedora12-rc1", and it to
> automatically checkout the corresponding versions relating to fedora12-rc1,
> into init, kernel and libpng.
> 
> When I make a new branch in say "init" and check in the changes, when I go
> to the fedora12-rc1 branch I would like then to type git commit, and it
> record the version change within the init branch, thus when I go to check
> out the rc1 branch again I get all my changes.
> 
> If I switched branches and there were uncommitted changes in "kernel" it
> would warn me and ask me if I wanted to continue.
> 
> There are various different merge options that would be nice to, say fred
> was working on fedora12-rc2-fred and bob was working on fedroa12-rc2-bob,
> and I wanted to merge the two together (and we had made changes to the same
> packages) this would all be done for me.
> 
> I can understand this might be possible with some scripting, on git hooks,
> however this would seem a neat feature for git to support itself, does
> anybody have any scripts to do this?
> 
> Do other people think this would be a useful feature?
> 
> elk
> 
> 
> 
> -- 
> View this message in context: http://www.nabble.com/Git-within-Git-what-a-git-tp23070273p23070273.html
> Sent from the git mailing list archive at Nabble.com.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
		David
