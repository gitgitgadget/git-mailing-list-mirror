From: Pavel Roskin <proski@gnu.org>
Subject: Re: StGIT: "stg new" vs "stg new --force"
Date: Wed, 18 Jan 2006 19:49:09 -0500
Message-ID: <1137631749.13853.22.camel@dv>
References: <1137144291.20073.104.camel@dv>
	 <b0943d9e0601160018x206faf9ck@mail.gmail.com>
	 <1137517300.20556.26.camel@dv> <20060117215752.GH32585@nowhere.earth>
	 <1137539762.12454.11.camel@dv>  <20060118193717.GI32585@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>, Charles Lever <cel@citi.umich.edu>
X-From: git-owner@vger.kernel.org Thu Jan 19 01:50:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzNzw-0007MG-1m
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 01:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161122AbWASAt0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 19:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161119AbWASAt0
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 19:49:26 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:59318 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1161122AbWASAtQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 19:49:16 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EzNwK-0003Xo-JO
	for git@vger.kernel.org; Wed, 18 Jan 2006 19:46:12 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1EzNzB-00048F-Ar; Wed, 18 Jan 2006 19:49:09 -0500
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20060118193717.GI32585@nowhere.earth>
X-Mailer: Evolution 2.5.4 (2.5.4-6) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14875>

On Wed, 2006-01-18 at 20:37 +0100, Yann Dirson wrote:
> > > It would even be useful sometimes to dispatch changes to a single file
> > > into several patches.  When they are distinct enough to be in
> > > different diff hunks, it is pretty easy to split an existing patch,
> > > but it could also be useful to only refresh a patch with specific diff
> > > hunks.  A possibility would be to add a filterdiff-like "-#<n>" flag,
> > > in addition to the above-suggested "refresh <file>" (and possibly only
> > > allow to specify a single file together with this flag).
> > 
> > I think if would be better to improve "stg fold" to work on arbitrary
> > patches.  This way, you prepare the patch in the editor (which would not
> > be harder than finding hunk numbers) and fold it into the patch of your
> > choice.  stg should check that the stack remains valid, possibly doing
> > trivial adjustments to the higher patches.  The current tree should not
> > be impacted.
> 
> This sounds like a good idea as well (and I would use it on a near
> daily basis as well ;).  Obviously such a request can also fail,
> eg. when requesting to fold a change into a patch, where a subsequent
> patch modifies the same lines.

Definitely.  Hard cases should be handled by hand.

> But it would not be a replacement to selecting changes with a
> granularity finer than file-level, which is what I wanted to suggest.

Why?  Maybe you got confused by two meanings of the word "patch"?  I
think StGIT should use some other term, e.g. changeset.  I meant that
the diff file (e.g. made by "stg diff") could be edited and folded into
one of the StGIT patches (changesets).  Unless you want non-interactive
separation of the hunks, using an editor should be a reasonable
approach.

I believe StGIT should be primarily designed to be used interactively.
Your approach looks like a usability disaster to me.  The user is
supposed to find numbers of the hunks, although s/he is working on the
whole file (since it's "stg refresh").

My approach suggests that the user work with the diff from the
beginning, and separates the changes by looking at them.

-- 
Regards,
Pavel Roskin
