From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 4/5] git-log.txt: rewrite note on why "--" may be required
Date: Mon, 22 Apr 2013 11:36:22 +0200
Message-ID: <871ua2sy95.fsf@linux-k42r.v.cablecom.net>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
	<1366458313-7186-5-git-send-email-artagnon@gmail.com>
	<7vtxn0wf4j.fsf@alter.siamese.dyndns.org>
	<7vmwsrqocu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 11:36:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUDAk-0006xb-SA
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 11:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819Ab3DVJg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 05:36:26 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:2535 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753157Ab3DVJgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 05:36:25 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 22 Apr
 2013 11:36:22 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 22 Apr 2013 11:36:22 +0200
In-Reply-To: <7vmwsrqocu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 21 Apr 2013 19:40:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222002>

Junio C Hamano <gitster@pobox.com> writes:

> This is a minimalistic patch to fix the formatting.  I removed the
> extra sentence after the enumeration and moved it to the end of the
> main text, but somebody may have a better idea to persuade AsciiDoc
> to format it in a more reasonable way while keeping the sentence
> there.
>
> -- >8 --
> Subject: line-log: fix documentation formatting
>
> The second paragraph of the added description for the -L option
> "<start> and <end> can take one of these forms:", and the list of
> forms that follow the headline, were indented one level too short,
> due to the missing "+" to signal that the next paragraph continues
> the previous one.
>
> Also "You can specify this option more than once" is about the -L
> option, not about its various forms of starting and ending points.
> Move it to the end of the main text.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-log.txt | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index 4850226..0959f9d 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -76,12 +76,11 @@ produced by --stat etc.
>  	not give any pathspec limiters.  This is currently limited to
>  	a walk starting from a single revision, i.e., you may only
>  	give zero or one positive revision arguments.
> -
> +	You can specify this option more than once.
> ++
>  <start> and <end> can take one of these forms:
>  
>  include::line-range-format.txt[]
> -You can specify this option more than once.
> -
>  

Sorry for being a bit late to this.  I think it's a good solution;
putting "You can specify this option more than once" after all the other
text was probably worse because it gets lost down there.

As for

>  --full-line-diff::
>  	Always print the interesting range even if the current commit

That's just stale and not currently implemented.  Sigh.  We should
remove it.

-- >8 --
Subject: [PATCH] git-log(1): remove --full-line-diff description

This option is a remnant of an earlier log -L version, and not
currently implemented.  Remove it until (if at all) it is implemented
again.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 Documentation/git-log.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 0959f9d..65707ce 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -82,10 +82,6 @@ produced by --stat etc.
 
 include::line-range-format.txt[]
 
---full-line-diff::
-	Always print the interesting range even if the current commit
-	does not change any line of the range.
-
 [\--] <path>...::
 	Show only commits that are enough to explain how the files
 	that match the specified paths came to be.  See "History
-- 
1.8.2.1.844.g59e84de.dirty
