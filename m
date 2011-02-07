From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [1.8.0] git checkout refs/heads/foo checks out branch foo
Date: Mon, 7 Feb 2011 16:00:30 -0600
Message-ID: <20110207220030.GA19357@elie>
References: <alpine.DEB.1.10.1102062234010.3788@debian>
 <20110207205934.GD13461@sigill.intra.peff.net>
 <AANLkTinmqTi4cYbR6PtSxt6itCvFQDuT_sE1tjx45a3h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 23:00:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmZ8e-0000S5-NL
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 23:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755087Ab1BGWAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 17:00:46 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51066 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755037Ab1BGWAp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 17:00:45 -0500
Received: by fxm20 with SMTP id 20so5397824fxm.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 14:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=gMxuXafZm8Ru4HgT8jugOfnj/KKowJA4yf5Jor64l4I=;
        b=CgKixPJmox7yGUMWbwcdgLCR9xb8ogz+1sP3yQ12HdpqdWwdRa1UVC1y8tp+hwMG1Z
         oyvC5mSOPmlPELC+0adMKDO2XeGkxtx9EnJgiV57NU26P5+OHts66Kevj4hiWdUQ4eVl
         EtSyCOj3CUlWNwrxQnIc+3neAJPtuHsO8XjaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dUMnd15ExDQmUQFs0IHUchSkIEDKybGrXd0zSnFPKTv27laPeC1tU/Xo55pbcfaQzH
         sXZD11WyDUHiz8rqjEwPP+euBiHdfdrCDS/oHn2nODWbXWm/zl/DUfKCvpM7KtW5+lEy
         K85HdvOUrHv5QZ6zHqQONOEHDxKt3e/HC8FV8=
Received: by 10.223.85.203 with SMTP id p11mr15497630fal.108.1297116043838;
        Mon, 07 Feb 2011 14:00:43 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id 11sm1451515faw.20.2011.02.07.14.00.40
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 07 Feb 2011 14:00:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinmqTi4cYbR6PtSxt6itCvFQDuT_sE1tjx45a3h@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166305>

Sverre Rabbelier wrote:

> Now _that_ is an excellent usability improvement, assuming we want to
> encourage detaching HEAD... do we?

Yes.

-- 8<
Subject: commit: document --detach synonym for "git checkout foo^{commit}"

For example, one might use this when making a temporary merge to test
that two topics work well together.

This patch just documents the option.  It is not meant for application
without an implementation and tests for the option.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-checkout.txt |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 880763d..698ae6c 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git checkout' [-q] [-f] [-m] [<branch>]
+'git checkout' [-q] [-f] [-n] [--detach] [<commit>]
 'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
 'git checkout' --patch [<tree-ish>] [--] [<paths>...]
@@ -22,9 +23,10 @@ branch.
 
 'git checkout' [<branch>]::
 'git checkout' -b|-B <new_branch> [<start point>]::
+'git checkout' [--detach] [<commit>]::
 
 	This form switches branches by updating the index, working
-	tree, and HEAD to reflect the specified branch.
+	tree, and HEAD to reflect the specified branch or commit.
 +
 If `-b` is given, a new branch is created as if linkgit:git-branch[1]
 were called and then checked out; in this case you can
@@ -115,6 +117,13 @@ explicitly give a name with '-b' in such a case.
 	Create the new branch's reflog; see linkgit:git-branch[1] for
 	details.
 
+--detach::
+	Rather than checking out a branch to work on it, check out a
+	commit for inspection and discardable experiments.
+	This is the default behavior of "git checkout <commit>" when
+	<commit> is not a branch name.  See the "DETACHED HEAD" section
+	below for details.
+
 --orphan::
 	Create a new 'orphan' branch, named <new_branch>, started from
 	<start_point> and switch to it.  The first commit made on this
@@ -204,7 +213,7 @@ leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 
 
 
-Detached HEAD
+DETACHED HEAD
 -------------
 
 It is sometimes useful to be able to 'checkout' a commit that is
-- 
1.7.4
