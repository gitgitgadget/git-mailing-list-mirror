From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git-clone -s: document problems with git gc --prune
Date: Tue, 22 Jan 2008 23:12:25 +0100
Message-ID: <20080122221225.GN4475@genesis.frugalware.org>
References: <20080122210305.GM4475@genesis.frugalware.org> <47965BB2.8080703@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 23:13:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHRNS-0000xM-RJ
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 23:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755940AbYAVWMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 17:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755899AbYAVWMp
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 17:12:45 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:39806 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753269AbYAVWMn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 17:12:43 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1JHRM8-0001A5-93
	from <vmiklos@frugalware.org>; Tue, 22 Jan 2008 23:12:38 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id BB0E8119019C; Tue, 22 Jan 2008 23:12:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <47965BB2.8080703@nrlssc.navy.mil>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0061]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71473>

There is a scenario when using git clone -s and git gc --prune togother is
dangerous. Document this.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Tue, Jan 22, 2008 at 03:10:10PM -0600, Brandon Casey <casey@nrlssc.navy.mil> wrote:
> I find that second sentence hard to understand. Maybe:
>
> If you clone your repository using this option, then delete branches in
> the source repository and then run linkgit:git-gc[1] using the '--prune'
> option in the source repository, it may remove objects which are referenced
> by the cloned repository.

Here is the re-worded version.

 Documentation/git-clone.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index fdccbd4..2341881 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -62,6 +62,14 @@ OPTIONS
 	.git/objects/info/alternates to share the objects
 	with the source repository.  The resulting repository
 	starts out without any object of its own.
+	*NOTE*: this is a possibly dangerous operation; do *not* use
+	it unless you understand what it does. If you clone your
+	repository using this option, then delete branches in the
+	source repository and then run linkgit:git-gc[1] using the
+	'--prune' option in the source repository, it may remove
+	objects which are referenced by the cloned repository.
+
+
 
 --reference <repository>::
 	If the reference repository is on the local machine
-- 
1.5.4.rc3.4.g16335-dirty
