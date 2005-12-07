From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: dotfile support
Date: Wed, 7 Dec 2005 06:56:46 -0800
Message-ID: <20051207145646.GA9207@tumblerings.org>
References: <20050416230058.GA10983@ucw.cz> <118833cc05041618017fb32a2@mail.gmail.com> <20050416183023.0b27b3a4.pj@sgi.com> <Pine.LNX.4.58.0504162138020.7211@ppc970.osdl.org> <42620092.9040402@dwheeler.com> <Pine.LNX.4.58.0504170857580.7211@ppc970.osdl.org> <42628D1B.3000207@dwheeler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Jackson <pj@sgi.com>,
	Morten Welinder <mwelinder@gmail.com>, mj@ucw.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 16:02:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek0jb-0008DO-1j
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 15:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbVLGO51 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 09:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVLGO51
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 09:57:27 -0500
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:10962 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S1751113AbVLGO51
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 7 Dec 2005 09:57:27 -0500
Received: from zbrown by tumblerings.org with local (Exim 4.54)
	id 1Ek0is-0002q6-SI; Wed, 07 Dec 2005 06:56:46 -0800
To: "David A. Wheeler" <dwheeler@dwheeler.com>
Content-Disposition: inline
In-Reply-To: <42628D1B.3000207@dwheeler.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13326>

Hi,

What's the status of dotfile support? I can only find one thread that really
discusses the issue:

On Sun, Apr 17, 2005 at 12:21:47PM -0400, David A. Wheeler wrote:
> Linus Torvalds wrote:
> >
> >On Sun, 17 Apr 2005, David A. Wheeler wrote:
> >
> ...
> >Also, I made a design decision that git only cares about non-dotfiles. Git 
> >literally never sees or looks at _anything_ that starts with a ".". I 
> >think that's absolutely the right thing to do for an SCM (if you hide your 
> >files, I really don't think you should expect the SCM to see it), but it's 
> >obviously not the right thing for a backup thing.
> 
> Again, a command line flag or config file entry could change that
> in the future, if desired.  So this is a decision that could be
> changed later... the best kind of decision :-).

Personally I like dotfile support, and I compare it to the language encoding
issue for filenames. Linus says we should treat filenames as binary data,
and thus it won't matter what characters someone uses. I agree completely,
but by not supporting dotfiles, we're creating a big exception, in that if
a filename begins with a dot, we treat it in a much different way, in fact
we ignore it completely.

In the above quote, Linus says "if you hide your files, I really don't think
you should expect the SCM to see it". But what about the case where the
user is not the one choosing to create dotfiles? If I want to put a bunch of
config files for various apps into a git repository, I don't get to pick their
names in many cases, at least not without changing the way I invoke my apps
(or the scripts that do it for me). But it's still worthwhile to have those
config files in version control. It makes it much easier to experiment with
new tools, recover from my mistakes, and share my successes with others.

So that's my pitch: Leaving out dotfile support seems like it creates an
unnecessary limitation that eliminates some valid uses of git.

Be well,
Zack

> 
> --- David A. Wheeler
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Zack Brown
