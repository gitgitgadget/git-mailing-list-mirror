From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: push.default documented in "man git-push"?
Date: Tue, 2 Oct 2012 21:08:00 +0530
Message-ID: <CALkWK0nQu_vvLGu=j2CDkGcKtp-T401kDyhD5_iMqQrkGk9K8Q@mail.gmail.com>
References: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
 <CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com> <CAN7QDoJ=PKt_1zW58648tcaT7MP1MTVJo9E4PW5g93K_tO91Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: David Glasser <glasser@davidglasser.net>
X-From: git-owner@vger.kernel.org Tue Oct 02 17:39:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ4YK-0001vU-O8
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 17:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620Ab2JBPiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 11:38:22 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:39981 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754615Ab2JBPiV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 11:38:21 -0400
Received: by qaas11 with SMTP id s11so614830qaa.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 08:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Yy74rxwfiQuGmQJZAvhTWPJPrE5F8s4jhesb3/FwPq0=;
        b=YyinyaptNOXwHOBzGvpmcaHa0O+7DpkJewjuoKaexND8H7jAypAowXBi+aFTduh/9E
         bbSmcWmiVw8RRpZt7d2UlHwEHR+iLPx8Nwd/Q2ZVglTQwY9+YxqDNWdmi1nhpL99cTSX
         PDBkX1lOEqLPQtY7CEscQ3xcqvXfK8TZzUJYDkCwkKD1k45/PvNt23Qv+Rd/z0CUxwo9
         d60Aj/jHUCA4X/0PPNVKx3xIJXh2eat7pk1mqihkDReVASbdxVW0QXn2J5CrIwZT2WoK
         tMC37JK5cSNx6uh2zwHs6Dz6j5A8PiIHh7q7A963wtclaAQNe/+K/ReJEoCtQU/kXJgo
         HYxA==
Received: by 10.229.206.86 with SMTP id ft22mr3758867qcb.120.1349192300864;
 Tue, 02 Oct 2012 08:38:20 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Tue, 2 Oct 2012 08:38:00 -0700 (PDT)
In-Reply-To: <CAN7QDoJ=PKt_1zW58648tcaT7MP1MTVJo9E4PW5g93K_tO91Jw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206807>

David Glasser wrote:
> Thanks Rankumar! There's also the reference in the "git push origin"
> example and the "This is the default operation mode if no explicit
> refspec is found".

Sorry;  here's a revised patch.

--8<--
From: Ramkumar Ramachandra <artagnon@gmail.com>
Date: Tue, 2 Oct 2012 21:06:05 +0530
Subject: [PATCH] Documentation: mention `push.default` in git-push.txt

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-push.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index cb97cc1..e1e9aca 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -37,7 +37,8 @@ OPTIONS[[OPTIONS]]
        `+`, followed by the source ref <src>, followed
        by a colon `:`, followed by the destination ref <dst>.
        It is used to specify with what <src> object the <dst> ref
-       in the remote repository is to be updated.
+       in the remote repository is to be updated.  If not specified,
+       the configuration variable `push.default` is used.
 +
 The <src> is often the name of the branch you would want to push, but
 it can be any arbitrary "SHA-1 expression", such as `master~4` or
@@ -65,7 +66,8 @@ directs git to push "matching" branches: for every
branch that
 the local side, the remote side is updated if a branch of the same name
 already exists on the remote side.  This is the default operation mode
 if no explicit refspec is found (that is neither on the command line
-nor in any Push line of the corresponding remotes file---see below).
+nor in any Push line of the corresponding remotes file, or `push.default`
+---see below).

 --all::
        Instead of naming each ref to push, specifies that all
@@ -357,7 +359,7 @@ Examples
        `git push origin :`.
 +
 The default behavior of this command when no <refspec> is given can be
-configured by setting the `push` option of the remote.
+configured by setting the `push` option of the remote, or `push.default`.
 +
 For example, to default to pushing only the current branch to `origin`
 use `git config remote.origin.push HEAD`.  Any valid <refspec> (like
-- 
1.7.12.1.428.g652398a.dirty
