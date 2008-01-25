From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git pull manpage: don't include -n from fetch-options.txt
Date: Fri, 25 Jan 2008 10:28:39 +0100
Message-ID: <20080125092839.GF4475@genesis.frugalware.org>
References: <72481CA3A5A6474EA49CFD2CF28A5D5D02CA348A@hektor.iplbath.com> <alpine.LSU.1.00.0801241058330.5731@racer.site> <20080124232418.GC4475@genesis.frugalware.org> <7vfxwm8z4u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 10:29:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIKsN-0001Ow-7i
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 10:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000AbYAYJ27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 04:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754703AbYAYJ26
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 04:28:58 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:33796 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753780AbYAYJ24 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 04:28:56 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1JIKrd-00057A-Lz
	from <vmiklos@frugalware.org>; Fri, 25 Jan 2008 10:28:54 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id DD6A511901F7; Fri, 25 Jan 2008 10:28:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vfxwm8z4u.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71691>

The -n option stands for --no-summary in git pull

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Thu, Jan 24, 2008 at 05:36:33PM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> > The -n option stands for --no-summary in git pull
>
> Ok, but does that mean --no-tags does not exist there?

Oops, my bad. Here is an updated patch to just remove '-n' and keep
'--no-tags'.

 Documentation/fetch-options.txt |    5 +++++
 Documentation/git-pull.txt      |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 61e48cc..702f953 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -23,7 +23,12 @@
 	fetches is a descendant of `<lbranch>`.  This option
 	overrides that check.
 
+ifndef::git-pull[]
 -n, \--no-tags::
+endif::git-pull[]
+ifdef::git-pull[]
+\--no-tags::
+endif::git-pull[]
 	By default, `git-fetch` fetches tags that point at
 	objects that are downloaded from the remote repository
 	and stores them locally.  This option disables this
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 77fdaf1..f9f1e0d 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -25,6 +25,7 @@ OPTIONS
 -------
 include::merge-options.txt[]
 
+:git-pull: 1
 include::fetch-options.txt[]
 
 include::pull-fetch-param.txt[]
-- 
1.5.4.rc4-dirty
