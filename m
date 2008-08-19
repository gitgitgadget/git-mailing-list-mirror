From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH] Add hints to revert documentation about other ways to undo changes
Date: Tue, 19 Aug 2008 12:50:31 -0700
Message-ID: <1219175431-20730-1-git-send-email-tarmigan+git@gmail.com>
References: <7vk5ec7s05.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Tarmigan Casebolt <tarmigan+git@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Lea Wiemann <lewiemann@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Aug 19 21:39:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVX32-0007Pn-QQ
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 21:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673AbYHSTiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 15:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753609AbYHSTiN
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 15:38:13 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:50394 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032AbYHSTiM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 15:38:12 -0400
Received: by gxk9 with SMTP id 9so5605406gxk.13
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 12:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender;
        bh=q+uhhl12xRTzMIy3JkQkXtY//erYeyJo+Bv1klHHE64=;
        b=cBrV0DyUn94I8oIO6Al1kQW60sjWpQJVJZMltgRiegOgmRPUbxYuAaQEketBYI8jZc
         6k0ZzyvgJgF6FWLK44tjPQDRdNLKrLAG4JZU3s+DhLeA0zCITHZA9SdR65sg0nWefDr+
         AJF1YpLFtQv/Qa83nOxRiaYurQWKWNotWtWnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :sender;
        b=RaChY/gV8Tox6924oQugQuMSH0S43FPuJLAyc4eT2fFfAbdbLLSg7azI+/3iKlBziV
         HdW3kan76jUUv70KMLEwmYnQ+IqBzL2NEeESNsXIWd6A8EHSwjMUoiN4YkpgUETyBzAM
         ABAZH/VLtweDhv+kF5tXz8HUxtI9KZXDa7GJw=
Received: by 10.142.134.20 with SMTP id h20mr2660435wfd.21.1219174691009;
        Tue, 19 Aug 2008 12:38:11 -0700 (PDT)
Received: from localhost ( [24.130.14.197])
        by mx.google.com with ESMTPS id 27sm860699wfa.2.2008.08.19.12.38.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Aug 2008 12:38:09 -0700 (PDT)
X-Mailer: git-send-email 1.6.0
In-Reply-To: <7vk5ec7s05.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92912>

Based on its name, people may read the 'git revert' documentation when
they want to undo local changes, especially people who have used other
SCM's.  'git revert' may not be what they had in mind, but git
provides several other ways to undo changes to files.  We can help
them by pointing them towards the git commands that do what they might
want to do.

Cc: Daniel Barkalow <barkalow@iabervon.org>
Cc: Lea Wiemann <lewiemann@gmail.com>
Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
---

On Tue, Aug 19, 2008 at 11:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
> The last sentence makes the paragraph incoherent, doesn't it?

Yeah.  My thinking was that the people who would appreciate this note
would be newbies, and it might be nice to warn them not to just try
'git reset --hard' without thinking.

> By starting this paragraph with "Despite its name", you are stating your
> expectation that the people who find "git revert" nonintuitive are the
> majority.  
>
> And you explain how to perform the operation that majority
> would expect, which is to throw away uncommitted changes to go back to the
> clean slate.  If that is what the target audience of this paragraph
> expects to happen anyway, why do you need to caution against it in the
> last sentence?

I envision this note as useful for a majority of newbies who don't yet
have a sense of everything 'git reset' and 'git checkout' can do.

> If the answer is "because it is not cut-and-dried which expectation is the
> majority, and we try to be careful not to lose local modifications of
> users", then the tone of the paragraph needs to become more neutral.
>
> I'd suggest either dropping the first sentence altogether and starting the
> paragraph with "If you want to throw away...", or replacing the first
> sentence with "'git revert' is used to record a new commit to reverse the
> effect of an earlier commit (often a faulty one)."

Good idea.  I like the later option.

Thanks,
Tarmigan

 Documentation/git-revert.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 98cfa3c..e578edf 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -15,7 +15,15 @@ Given one existing commit, revert the change the patch introduces, and record a
 new commit that records it.  This requires your working tree to be clean (no
 modifications from the HEAD commit).
 
+Note: 'git revert' is used to record a new commit to reverse the
+effect of an earlier commit (often a faulty one).  If you want to
+throw away all uncommitted changes in your working directory, you
+should see linkgit:git-reset[1], particularly the '--hard' option.  If
+you want to extract specific files as they were in another commit, you
+should see linkgit:git-checkout[1], specifically the 'git checkout
+<commit> -- <filename>' syntax.  Take care with these alternatives as
+both will discard uncommitted changes in your working directory.
+
 OPTIONS
 -------
 <commit>::
-- 
1.6.0
