From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH 0/5] My set of stgit companion scripts.
Date: Tue, 9 Jan 2007 23:26:02 +0100
Message-ID: <20070109222602.GE17093@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070104233934.13580.17744.stgit@gandelf.nowhere.earth> <b0943d9e0701090221o6437fc0ana17bb190eb1eae0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 09 23:26:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4PQ6-00029s-BV
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 23:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbXAIW0L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 17:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbXAIW0L
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 17:26:11 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:59835 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932470AbXAIW0K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 17:26:10 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id D0C3C4320E;
	Tue,  9 Jan 2007 23:26:08 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id A2C991F0A3; Tue,  9 Jan 2007 23:26:02 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0701090221o6437fc0ana17bb190eb1eae0b@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36414>

On Tue, Jan 09, 2007 at 10:21:30AM +0000, Catalin Marinas wrote:
> >stg-what-changed is invaluable when shuffling patches in the stack.
> 
> It's interesting to see the diff of diffs but it takes some time to
> get used to it :-).

Sure :)

I think there is a lot of room for improvement here, which is possibly
a bit outside the scope of StGIT itself - eg. detecting that a change
was indeed done but in a different place, detecting changes impacting
only the context, etc.


> There is 'stg log (--patch|--graphical)' which
> shows the diff of every refresh you did on the patch. What it doesn't
> show is the diff of a push since this creates a new patch version
> every time.

I'm not sure what you mean here, I do get diffs for pushes, they just
reflect the changes done in patches below (which indeed confused me
very must when I first saw them - I even thought at first that patch
logging was confused by something in my repos).

OTOH, there are other places where the log shows nothing but should
record something, eg. on "refresh -e" when only editing the message.


> Maybe this could be extended so that for push with
> conflicts, it first stores a version with conflict markers and another
> version after fixing them and refreshing.

Well, that could possibly help when browsing with existing tools, but
I'm not sure it would be the right way to do things.

To be fair, I have mixed feelings towards the current patch logs
already.  Specifically, a patch log conceptually records how a patch
changes, but the current implementation (just like the one in "pg")
makes it so changes to below patches are reflected in the log.

I'd rather thing patchlog entries should link 2 commits (ie. maybe we
should add the ability for commit object to point to a commit in its
"tree" field, or maybe we should add a new "metacommit" type of
object), and that we should develop a set of tools to deal with
changes in changes, just like we already have tools to deal with
changes.  Not a trivial thing, but that should be fun :)

Best regards,
-- 
Yann.
