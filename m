From: Yann Dirson <ydirson@altern.org>
Subject: Re: StGIT: "stg new" vs "stg new --force"
Date: Thu, 19 Jan 2006 22:38:39 +0100
Message-ID: <20060119213838.GA27397@nowhere.earth>
References: <1137144291.20073.104.camel@dv> <b0943d9e0601160018x206faf9ck@mail.gmail.com> <1137517300.20556.26.camel@dv> <20060117215752.GH32585@nowhere.earth> <1137539762.12454.11.camel@dv> <20060118193717.GI32585@nowhere.earth> <1137631749.13853.22.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>, Charles Lever <cel@citi.umich.edu>
X-From: git-owner@vger.kernel.org Thu Jan 19 22:36:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzhR8-0001Kf-Pi
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 22:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422659AbWASVfN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 16:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422657AbWASVfN
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 16:35:13 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:24795 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1422661AbWASVfL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 16:35:11 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 4B61A1832F;
	Thu, 19 Jan 2006 22:35:10 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1EzhUN-0003ws-Ip; Thu, 19 Jan 2006 22:38:39 +0100
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1137631749.13853.22.camel@dv>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14935>

On Wed, Jan 18, 2006 at 07:49:09PM -0500, Pavel Roskin wrote:
> > But it would not be a replacement to selecting changes with a
> > granularity finer than file-level, which is what I wanted to suggest.
> 
> Why?  Maybe you got confused by two meanings of the word "patch"?  I
> think StGIT should use some other term, e.g. changeset.  I meant that
> the diff file (e.g. made by "stg diff") could be edited and folded into
> one of the StGIT patches (changesets).  Unless you want non-interactive
> separation of the hunks, using an editor should be a reasonable
> approach.

> My approach suggests that the user work with the diff from the
> beginning, and separates the changes by looking at them.

Oh, I think I now see what you meant.  I'm not sure it would be a good
idea to let the user edit the diff, although running an editor on it
is not much different from feeding it through filterdiff, or a
even through a graphical equivalent allowing to point at the hunks.


> I believe StGIT should be primarily designed to be used interactively.

I tend to disagree.  3rd-party apps like qgit should be able to let
the user do the selection, and tell the command-line tool what they
want to act upon.  It may be useful as well if stg gains
interactivity, but should not become the only way to work with it
(unix way of life).


> Your approach looks like a usability disaster to me.  The user is
> supposed to find numbers of the hunks, although s/he is working on the
> whole file (since it's "stg refresh").

That's what I'm currently doing to feed the hunk numbers to
filterdiff.  Any improvement in the process would be welcomed :)


Maybe we could have a "fold" or "refresh" variant that takes its
output from the output of "stg diff" (or any arbitrary diff on stdin,
to be friendly with GUI wrappers) filtered by an arbitrary command.
That command could be "cat" to get the current "refresh" behaviour, or
an editor wrapper acting on stdin/out, or a wrapper to filterdiff, or
whatever clever filter one would want to use.

Does it sound better ?
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
