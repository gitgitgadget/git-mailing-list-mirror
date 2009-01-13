From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Documentation/git-blame.txt, git-gui.txt: link SEE
 ALSOs
Date: Mon, 12 Jan 2009 17:47:15 -0800
Message-ID: <7v8wpgf04c.fsf@gitster.siamese.dyndns.org>
References: <87bpucovnz.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jidanni@jidanni.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 13 02:48:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMYOe-0005KF-Kz
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 02:48:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752247AbZAMBrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 20:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753807AbZAMBrZ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 20:47:25 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35472 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbZAMBrY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 20:47:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1E56390651;
	Mon, 12 Jan 2009 20:47:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E743F9064E; Mon,
 12 Jan 2009 20:47:17 -0500 (EST)
In-Reply-To: <87bpucovnz.fsf@jidanni.org> (jidanni@jidanni.org's message of
 "Tue, 13 Jan 2009 09:13:20 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1EAB1E5C-E114-11DD-9370-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105437>

jidanni@jidanni.org writes:

> As git gui is heavily blame focused, we link its SEE ALSO to
> git-blame, and add a link back while we're at it.
>
> Signed-off-by: jidanni <jidanni@jidanni.org>
> ---
>  Documentation/git-blame.txt |    1 +
>  Documentation/git-gui.txt   |    3 +++
>  2 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
> index fba374d..d71a2c3 100644
> --- a/Documentation/git-blame.txt
> +++ b/Documentation/git-blame.txt
> @@ -186,6 +186,7 @@ commit commentary), a blame viewer won't ever care.
>  
>  SEE ALSO
>  --------
> +linkgit:git-gui[1],
>  linkgit:git-annotate[1]
>  
>  AUTHOR
> diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
> index d0bc98b..3a71074 100644
> --- a/Documentation/git-gui.txt
> +++ b/Documentation/git-gui.txt
> @@ -105,6 +105,9 @@ linkgit:gitk[1]::
>  	and file differences.  gitk is the utility started by
>  	'git-gui''s Repository Visualize actions.
>  
> +linkgit:git-blame[1]::
> +	Command-line blame viewer.
> +
>  Other
>  -----
>  'git-gui' is actually maintained as an independent project, but stable

As a general principle, I tend to refrain from referring to X from the
description of Y only because X happens to use Y heavily.

Referring people who heavily use Y to an alternative, which is X, hoping
that X may give a better user experience in certain environments is a
different matter, but in such a case, I'd rather see not just link but
in-text description as well (study the way "log -S" is suggested in the
description part for an example).  The attached patch shows you how.

On the other hand, what X does using Y sometimes may be easier to
understand if the reader is familiar with the way how Y works.  Even in
such a case, I think the documentation of X should be self contained
enough and ideally it shouldn't have to refer to Y.  And in the case of
git-gui documentation, I think it is.

So I am moderately negative about the first hunk of this patch as-is, and
I'll leave the decision on the second hunk to Shawn.



diff --git i/Documentation/git-blame.txt w/Documentation/git-blame.txt
index fba374d..ff7bbfb 100644
--- i/Documentation/git-blame.txt
+++ w/Documentation/git-blame.txt
@@ -36,6 +36,11 @@ $ git log --pretty=oneline -S'blame_usage'
 ea4c7f9bf69e781dd0cd88d2bccb2bf5cc15c9a7 git-blame: Make the output
 -----------------------------------------------------------------------------
 
+People working in GUI environment may find linkgit:git-gui[1] an useful
+alternative that provides an interactive interface to the history of
+each line.  It uses this command as an underlying engine.
+
+
 OPTIONS
 -------
 include::blame-options.txt[]
