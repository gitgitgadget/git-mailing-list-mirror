From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Fri, 11 Feb 2011 07:13:36 -0800 (PST)
Message-ID: <m3mxm28v3i.fsf@localhost.localdomain>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
	<201102070958.11551.johan@herland.net>
	<20110207201912.GB13461@sigill.intra.peff.net>
	<201102080159.02153.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Feb 11 16:13:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pnugt-0006S1-8N
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 16:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757117Ab1BKPNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 10:13:42 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41529 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757139Ab1BKPNl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 10:13:41 -0500
Received: by bwz15 with SMTP id 15so3296651bwz.19
        for <git@vger.kernel.org>; Fri, 11 Feb 2011 07:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=iGMX279TYJxky3Iz6zxeWIun5TdfCNiOmRtJAkvF5zU=;
        b=T6Wcsabj0kch1W9KCWxrhEFEeZw0pIbd0fUSR/5Jc5oYg2QRFzrtwMlr9mOKj849UR
         XNqOSPzr/6/F3Onurxd0esmwV43A3qkTT1x0FMfp41hZ9rN+J+N2SHHqUiD8D69Wt7lM
         9fzt5bTRemb77J2x51NCCNeBn9UrfCS8cjiJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=AZv9BB9zjomFQ3ihWJY/XzfQBenjpPNMkxQxFtX8JEWKbSBlegQjDR5gEOgdDrKQV6
         gc0ZbmRMSILTTJZXeJrJ1ddniTDf/g1u9DnZpLHvdzzepTROfozrDPl4U8QrwvHNu6Fp
         EZQAdhhOiAvGfmEq7x9xfKAUiwy8vsXtwdnkU=
Received: by 10.204.68.76 with SMTP id u12mr572152bki.57.1297437218489;
        Fri, 11 Feb 2011 07:13:38 -0800 (PST)
Received: from localhost.localdomain (abwo193.neoplus.adsl.tpnet.pl [83.8.238.193])
        by mx.google.com with ESMTPS id q18sm539130bka.3.2011.02.11.07.13.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Feb 2011 07:13:36 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p1BFCDxP008065;
	Fri, 11 Feb 2011 16:12:23 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p1BFBEAL008057;
	Fri, 11 Feb 2011 16:11:14 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <201102080159.02153.johan@herland.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166561>

Johan Herland <johan@herland.net> writes:
> On Monday 07 February 2011, Jeff King wrote:
> > On Mon, Feb 07, 2011 at 09:58:11AM +0100, Johan Herland wrote:

> > > This is the same technique we use when talking about branch names: On
> > > this mailing list, nobody is confused when I refer to 'maint',
> > > 'master', 'next' and 'pu'. Still, in our own work repos (at least in
> > > mine), these branches are actually called "refs/remotes/origin/<name>"
> > > (commonly referred to by their shorthands "origin/<name>"). Here we
> > > are, juggling the same kind of namespaces that I propose for tags, and
> > > it seems to work well without causing much confusion.
> > 
> > Just playing devil's advocate for a moment: isn't this namespace
> > distinction one of the more confusing things in git for new users? That
> > is, I have seen new-ish git users say "OK, so I cloned from upstream.
> > How come I can't say "git log maint" now?"

Or "where are all the branches?" ('git branch' doesn't show
remote-tracking branches).

> > Or it used to be "how come I can't "git checkout maint" now?" The
> > latter is now handled by some very specific magic in "git
> > checkout", but in general ref lookup does not automagically look
> > in remotes namespaces, and it has caused some confusion.

One has to be very careful with DWIM-mery, lest it would increase
confusion instead of reducing it.

[...]

> First, although the separate-remotes may at first be confusing to newbies 
> coming from a centralized VCS, I don't think this is the _main_ source of 
> confusion. And, as you imply, we cannot eliminate this kind of conceptual 
> confusion in any case, without violating core DVCS principles (like Bazaar 
> does in its "centralized workflow"). The best way to address this is, as you 
> say, by keeping it "simple, orthogonal, and distributed" (and try very hard 
> to keep the common use cases minimally affected).

Well, I think the confusion was greater and more dangerous in
pre-separate remotes era ('master' mapped to 'origin', branches mapped
to themselves, for single 'origin' remote).

> - Lack of consistency in the ref namespace (refs/remotes/$remote/* vs. 
> refs/tags/*). Also not clear from the current layout where to add new types 
> of refs (e.g. notes, replace). My proposal tries to address this issue.

The lack of consistency is there because tags should USUALLY be global
(there should be only one v1.7.4), while branch names should be local
(my 'master' branch is not your 'master' branch).
 
In some cases, like joining or subtree-merging unrelated projects we
would want local / per-remote tags: 'v1.7.4' in main project is not
'v1.7.4' in 'foo' subproject (in 'foo' remote).  Currently we lack a
way to specify that (the 'autofollow' refspec proposal, default
behaviour would be equivalent to '~refs/tags/*:refs/tags/*"), and lack
support from porcelain: MY PROPOSAL is to add '--use-separate-tags'
(like old '--use-separate-remote') to "git clone" and "git remote add",
and perhaps '--alternate' as equivalent to '--no-separate-tags' to 
"git remote add".

> - Lack of consistency in which fetch refspecs must be listed in the 
> configuration. (i.e. implicit vs. explicit fetch refspecs). My proposal 
> tries to address this as well.

Could you repeat your proposal?  Do I remember it correctly that with
'autofollow' refspec (valid only for tags... well, perhaps also for
notes and replacements) you want to specify defaults in config
explicitely

  [remote "origin"]
        url = git://git.example.com/repo.git
        fetch = +refs/heads/*:refs/remotes/origin/*
        fetch = ~refs/tags/*:refs/tags/*

Perhaps with

        fetch = +refs/heads/*:refs/remotes/origin/heads/*

> 
> - Lack of consistency in porcelain interfaces. Some of these have been fixed 
> in recent Git version, but some are yet to be fixed: E.g. some find the use 
> of FETCH_HEAD confusing (when does fetch update the remote refs, and when 
> does it update FETCH_HEAD instead?).

One of problems is how to keep the fact that

  $ git pull <URL> <branch>

does one-off pull without creating remote or remote-tracking branch.
But I agree that behavior of

  $ git pull <remote> <branch>

can be confusing.

>  Others (myself included) wonder why 'git push' by default updates
> remote branches with matching names, while 'git pull' relies on the
> explicitly configured upstreams to update the local refs. (FWIW,
> I've mitigated this last complaint insisting that all users at
> $dayjob run "git config --global push.default tracking" immediately
> after installing Git.) There are other UI inconsistencies too that
> escape me ATM.

IMHO that's not inconsisnency in Git, this is just reflection of the
fact that in most common case the situation is *assymetric* with
respect to fetch and push; you fetch from other people repositories,
but you push to (usually single, perhaps mirrored) your own publishing
repository.  For this situation 'push.default = matching' works
perfectly.

> 
> When it comes to your second question, I believe it's definitely worth 
> looking closer at whether we can exploit unambiguity across namespaces for 
> all types of refs (not just tags). I expect there are some non-trivial 
> issues down that road (some of these being discussed elsewhere in this 
> thread), but we may still end up with something better.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
