From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Mon, 05 May 2014 15:34:38 -0500
Message-ID: <5367f5de8e411_1193d2f30cba@nysa.notmuch>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
 <20140505184546.GB23935@serenity.lan>
 <5367e1ac39571_5977e7531081@nysa.notmuch>
 <20140505195525.GC23935@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 19:06:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whi9F-0006KZ-1q
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756079AbaEEUp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 16:45:26 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:44653 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755066AbaEEUpX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 16:45:23 -0400
Received: by mail-oa0-f41.google.com with SMTP id m1so6654066oag.0
        for <git@vger.kernel.org>; Mon, 05 May 2014 13:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=uePr1qqga7NZZUKn521fGPYCqt8sXAZ6z/ecwYMM8VE=;
        b=CkYkParxnBvJ0jpINqvoS9atqU0qbeF4ydueklvbrBRSBb4YWjdeS+KZ48kBJCsShH
         w9vVajCckSSxQuRMgqlsCZGFDRpzx9iL13n0BQRZvW21w0Q4PWkjwLdyO8Qoe7zHoD37
         +5jLOjcQ+UbRTI8Yzb4GEUpzuUNVWry2J7s6kGCRn9GhdkJDJxoUZhNVmeo/lHipD8hR
         Y/ug5AXROAblicX05rXUSddCy5/J9VlOHPZ8kzYNIjs7ceNHTIitrAP4sku3U+IKDLve
         kPT7eLKj5Er66VDckD8ZA0uL86P2ZHj/rvRD5/cixlXoQUpuWLaSCXctvcOPvOPnorDO
         1kwg==
X-Received: by 10.182.87.42 with SMTP id u10mr33917869obz.22.1399322722852;
        Mon, 05 May 2014 13:45:22 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id a7sm21775276obf.19.2014.05.05.13.45.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 May 2014 13:45:21 -0700 (PDT)
In-Reply-To: <20140505195525.GC23935@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248171>

John Keeping wrote:
> On Mon, May 05, 2014 at 02:08:28PM -0500, Felipe Contreras wrote:
> > John Keeping wrote:
> > > I am not convinced that tools for interoperating with other VCSs need to
> > > be part of core Git; as Junio has pointed out previously, while contrib/
> > > was necessary for promoting associated tools when Git was young and had
> > > not established mindshare, Git is now by far the most popular DVCS and
> > > is rapidly catching up with centralized systems.  Associated tools can
> > > therefore live on their own and do not need to be promoted as part of
> > > Git itself (as git-imerge is doing successfully).
> > 
> > Then let's remove git-p4.
> 
> If git-p4 were not already in the core, I would be making precisely the
> same argument regarding it (and the others you identify below).

So basically you are arguing against any change.

> > > the version currently on 'pu' fails the test suite for me because I
> > > have Mercurial 3.0:
> > > 
> > > 	AttributeError: 'mqrepo' object has no attribute 'getbundle'
> > 
> > And because this patch has not been picked up[1].
> 
> And it is now probably too late for that to make Git 2.0,

That's not for you to decide.

> which means it may be another 12 weeks before it makes it into a Git
> release.  Since this is quite a minor change it may make it into a
> stable release, but what would happen if the required changes were
> much more involved?

All the Mercurial API compatibility issues I have seen are trivial.

> > > I do not want to end up in a situation where an update to Git is blocked
> > > by a distribution because git-remote-hg is not updated to support newer
> > > versions of Mercurial sufficiently quickly; this previously happened in
> > > Gentoo due to git-svn and meant that was stuck on 1.7.8 until 1.7.13 was
> > > released [2].
> > 
> > Travis-CI ensures that won't happen[2].
> 
> I don't see that building against Mercurial's default branch, so it will
> not help with future releases.

I can easily add that.

> > > Since the remote helper interface is stable and the remote helpers do
> > > not use any of the Git internals, I consider the risks of including them
> > > in core Git to outweigh the benefits of wider distribution.  In fact,
> > > the remote helpers may benefit from having their own release cadences
> > > so that they can respond to changes in related projects more quickly
> > > than the normal Git release cycle.
> > 
> > Maybe, but git-remote-hg has already benefitted a lot from the wider
> > exposure of being in 'contrib/', I'm sure it would benefit even more if
> > it's distributed by default.
> 
> Is that because it was included in contrib/ or just as a result of being
> publicised on this list and elsewhere?

The former I'd bet.

> I don't think git-imerge is suffering from being its own project and
> git-subtree appears to have received very little attention despite
> being in contrib/.

Apples and oranges. There aren't scores of tools out there trying to do
what git-subtree does.

> > Moreover, there's a ton of subpar tools out there[3], and I believe
> > giving the burden of choosing one to the user is detrimental to the Git
> > project. If we as a project say: this is the one we recommend, and has
> > the Git stamp, that helps the users tremendously.
> 
> But by choosing one now, we are stuck promoting that one even if a
> better alternative comes along in the future.

Are there better alternatives coming in the future?

> > Your point is valid though, but it's valid not just for
> > git-remote-hg/bzr.
> > 
> > So I think these are the two options:
> > 
> >   1) Include git-remote-hg/bzr to the core and distribute them by
> >      default (as is the current intention)
> > 
> >   2) Remove git-remote-hg/bzr entirely from the Git tree. And do the
> >      same for other tools: git-p4, git-svn, git-cvs*. Given the huge
> >      amount of people using Subversion, we might want to defer that one
> >      for later, but eventually do it.
> 
> Don't forget git-archimport...
> 
> My personal vote would be for 2), splitting the bridges to other VCSs
> into their own repositories but there would need to be some guarantee
> that they would continue to be maintained.  I'm not sure it needs to
> wait for a major Git release since most of the impact is on package
> maintainers and not end users.

Sure, we might not need to wait for v3.0, but that's not the point. The
point is that we should be consistent, and that means going for 1) in
v2.0.

> > I'd say for v2.0 we should go for 1), and 2) should be considered for
> > v3.0, perhaps.
> 
> I don't think there is any advantage to adding new tools now if we only
> intend to remove them in the future.

Do we intend to remove them in the future? That hasn't been decided.

-- 
Felipe Contreras
