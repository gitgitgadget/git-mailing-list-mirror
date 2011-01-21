From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Documentation: suggest "reset --keep" to undo a commit
Date: Fri, 21 Jan 2011 01:37:30 -0600
Message-ID: <20110121073730.GA26276@burratino>
References: <vpq62ziv788.fsf@bauges.imag.fr>
 <20110120195726.GA11702@burratino>
 <20110120200827.GB14184@vidovic>
 <201101202134.41911.trast@student.ethz.ch>
 <7vfwsnqn8c.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1101210801210.15247@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 21 08:38:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgBZS-00054L-2H
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 08:38:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132Ab1AUHiC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 02:38:02 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38059 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331Ab1AUHiB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 02:38:01 -0500
Received: by gwj20 with SMTP id 20so436341gwj.19
        for <git@vger.kernel.org>; Thu, 20 Jan 2011 23:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Rtqcgj6Zcv1Gm7rmlTOfJi+E9ri5E2zzomjwdf3cdHI=;
        b=iPFTO+7eYX61RoyrJVWo2OrjeoveSlsXTxs21AJRYPn4EyafE7rRHcvojCBdS+2nNi
         7tcJWvgm4+yR6c28i3lhJokD9peFZT2xbpw46GNfgZzJqejXyABTWfgTIkXQr/F/QeeY
         tC8+jCejPw3/2D6R73peygnfRtuFRJB5Bzb90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jTA9ezfTcheCUuypBIacwTf3Qwktd2WGO8UddW8FZmzliw7xPM0fdsmNY+p9IGhCdr
         GcJpbb5aYaFGzIEk6z1nzcuDpKyO/rRiovtUZpzv1Cg2PkGHW8egG35DKaisMXEIY/WR
         MJ9cbNMw7+yIkSIJP1k29Efm+0ZjzwH3/ccmk=
Received: by 10.147.170.14 with SMTP id x14mr399197yao.36.1295595480170;
        Thu, 20 Jan 2011 23:38:00 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id f10sm11107876anh.5.2011.01.20.23.37.58
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 20 Jan 2011 23:37:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1101210801210.15247@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165358>

When one's only goal is to move from one commit to another, reset
--keep is simply better than reset --hard, since it preserves local
changes in the index and worktree when easy and errors out without
doing anything when not.  Update the two "how to remove commits"
examples in this vein.  "reset --hard" is still explained in a later
example about cleaning up during a merge.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Johannes Schindelin wrote:

> rebase -i checks that all is well and we could come back to the current 
> status later if we realized that things went horribly wrong.
>
> reset --hard does not do that. No safety net. No reflog. Nada.

Right.  I think we should encourage people to use "reset --keep" more
often.  (In general.  The particular "rebase to pull" example just
mentioned is less obvious.)

 Documentation/git-reset.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index fd72976..1f13a1e 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -148,7 +148,7 @@ Undo a commit, making it a topic branch::
 +
 ------------
 $ git branch topic/wip     <1>
-$ git reset --hard HEAD~3  <2>
+$ git reset --keep HEAD~3  <2>
 $ git checkout topic/wip   <3>
 ------------
 +
@@ -163,7 +163,7 @@ Undo commits permanently::
 +
 ------------
 $ git commit ...
-$ git reset --hard HEAD~3   <1>
+$ git reset --keep HEAD~3   <1>
 ------------
 +
 <1> The last three commits (HEAD, HEAD^, and HEAD~2) were bad
-- 
1.7.4.rc2
