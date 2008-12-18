From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Is it possible to roll back unstaged changes while leaving the staged ones for the next commit?
Date: Thu, 18 Dec 2008 12:34:56 +0900
Message-ID: <20081218123456.6117@nanako3.lavabit.com>
References: <c115fd3c0812171722g93dbeefw2fb5bf7641dfe394@mail.gmail.com>
 <c115fd3c0812171157m3d180534gb5630fbcf39b2bbd@mail.gmail.com>
 <7vy6yelf2m.fsf@gitster.siamese.dyndns.org>
 <c115fd3c0812171448o3db6f4c1oc24e39f9a68ed1d3@mail.gmail.com>
 <7vbpvajtmd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Tim Visher" <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 04:37:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD9hh-0006Ja-1r
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 04:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbYLRDgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 22:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbYLRDgR
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 22:36:17 -0500
Received: from karen.lavabit.com ([72.249.41.33]:47173 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610AbYLRDgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 22:36:16 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id D4E7EC8430;
	Wed, 17 Dec 2008 21:36:15 -0600 (CST)
Received: from 3940.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id AVHVB96LXLF1; Wed, 17 Dec 2008 21:36:15 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=LXbzPPXzR2v/4FpY2O/t30LQyxJGWVPmEcMwHaJGA1XYmH6oRhSAobF562+cDWyqpJTw6Rk/txc7d/EGdFQL7aXdL/qLsFkM8pLdRpYIwAnfk2tPSjKYddx6XWQ0hDPOd3BbkQYml6xUFdA4soQ2rRThLE4lATcEcopzUDDCIxo=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <c115fd3c0812171722g93dbeefw2fb5bf7641dfe394@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103430>

Quoting "Tim Visher" <tim.visher@gmail.com>:

> On Wed, Dec 17, 2008 at 5:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> How about omitting the "git commit" and do "git checkout PATH" after you
>> are done with the staging?  IOW, (1) above.
>
> Huh.  I guess I was under the impression that doing the `git checkout
> PATH` would destroy the staged content as well as the unstaged.  This
> isn't the case?

A short answer is "no it is not the case."

I was about to quote "git checkout" documentation to you because I was reasonably sure that Junio won't respond to people who ask a question whose answer is plainly described in the manual pages, but I think the description of the command is a little confusing especially for people who read it for the first time.

This is a patch to clarify the sentence.

-- 8< -- Cut Here -- 8< --
Subject: Clarify documentation of "git checkout <tree-ish> paths" syntax

The SYNOPSIS section of the manual writes:

    git checkout [options] [<tree-ish>] [--] <paths>...

but the DESCRIPTION says that this form checks the paths out "from the
index, or from a named commit."  A later sentence refers to the same
argument as "<tree-ish> argument", but it is not clear that these two
sentences are talking about the same command line argument for first-time
readers.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---

 Documentation/git-checkout.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 168333a..bbdfa40 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -27,7 +27,7 @@ the first namespace level.
 
 When <paths> are given, this command does *not* switch
 branches.  It updates the named paths in the working tree from
-the index file, or from a named commit.  In
+the index file, or from a named <tree-ish> (most often a commit).  In
 this case, the `-b` options is meaningless and giving
 either of them results in an error.  <tree-ish> argument can be
 used to specify a specific tree-ish (i.e. commit, tag or tree)








-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
