From: David Kastrup <dak@gnu.org>
Subject: Re: Git GSoC 2014
Date: Fri, 14 Feb 2014 10:44:35 +0100
Message-ID: <87d2iq58qk.fsf@fencepost.gnu.org>
References: <20140213091037.GA28927@sigill.intra.peff.net>
	<87bnya8z6q.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Fri Feb 14 10:44:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEFK9-0007kI-Pq
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 10:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbaBNJol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 04:44:41 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:38581 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbaBNJoh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 04:44:37 -0500
Received: from localhost ([127.0.0.1]:37621 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WEFJz-0003wP-K4; Fri, 14 Feb 2014 04:44:35 -0500
Received: by lola (Postfix, from userid 1000)
	id 26D5FE04F7; Fri, 14 Feb 2014 10:44:35 +0100 (CET)
In-Reply-To: <87bnya8z6q.fsf@thomasrast.ch> (Thomas Rast's message of "Thu, 13
	Feb 2014 22:45:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242093>

Thomas Rast <tr@thomasrast.ch> writes:

> Here's my moonshot:
>
> --- 8< ---
> Replace object loading/writing layer by libgit2
>
> Git reads objects from storage (loose and packed) through functions in
> sha1_file.c.  Most commands only require very simple, opaque read and
> write access to the object storage.  As a weatherballoon, show that it
> is feasible to use libgit2 git_odb_* routines for these simple callers.
>
> Aim for passing the git test suite using git_odb_* object storage
> access, except for tests that verify behavior in the face of storage
> corruption, replacement objects, alternate storage locations, and
> similar quirks.  Of course it is even better if you pass the test suite
> without exception.

[...]

> That absolutely requires a co-mentor from the libgit2 side to do,
> however.  Perhaps you could talk someone into it? ;-)
>
> Motivation: I believe that migrating to libgit2 is the better approach,
> medium term, than rewriting everything ourselves to be nice, clean and
> thread-safe.  I took a shot a while ago at making the pack reading code
> thread-safe, but it's adding mess when we could simply replace it all by
> the already thread-safe libgit2 calls.  It also helps shake out
> incompatibilities in libgit2.

That would either require forking libgit2 for Git use or stop dead any
contributions to that rather central part of the git codebase from
contributors not wanting their contributions to get reused in binary
proprietary software.

It would also mean that no serious forward-going work (like developing
new packing formats or network protocols) can be done on a pure GPLv2
codebase any more.  So anybody insisting on contributing work under the
current Git license only would be locked out from working on significant
parts of Git and could no longer propose changes in central parts.

Now this can all be repealed by the "developing the atomic bomb does not
mean that one has to use it" argument but even if one does not use it,
the world with and without it are different worlds and occupy mindshare
and suggest "solutions" and "diplomacy" involving it.

So this is definitely a large step towards a situation where erosion of
the existing license and related parts of the community becomes more
attractive.

There is the rationale "we can always say "no" at the end".  How do you
explain this "no" to the student who invested significant amounts of
work into this, in a project proposed by the Git developers?

This definitely should not be "we'll think about it if and when that
project is finished" material.

-- 
David Kastrup
