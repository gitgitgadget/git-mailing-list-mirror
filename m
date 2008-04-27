From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git show documentation: no longer refer to git-diff-tree
 options
Date: Sun, 27 Apr 2008 10:33:26 -0700
Message-ID: <7v3ap7gq3d.fsf@gitster.siamese.dyndns.org>
References: <1209262661-14370-1-git-send-email-vmiklos@frugalware.org>
 <7vod7wkuue.fsf@gitster.siamese.dyndns.org>
 <200804270730.m3R7UTTp011092@mi1.bluebottle.com>
 <20080427114504.GT4012@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nanako3@bluebottle.com, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 19:34:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqAln-0005WA-RY
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 19:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762401AbYD0Rdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 13:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757284AbYD0Rdv
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 13:33:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41902 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762833AbYD0Rdt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 13:33:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 82A853DDE;
	Sun, 27 Apr 2008 13:33:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id ABBCA3DDD; Sun, 27 Apr 2008 13:33:42 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80465>

Miklos Vajna <vmiklos@frugalware.org> writes:

> I just checked each option one by one and right, I haven't found any
> other option that could be useful for git-show either. Given that the
> wording of -s for git-show is quite different, I think it would be
> easier to just document -s in git-show as well. Like this?

Hmm, yes but not exactly.

You lost --stat, --name-only and friends that were implied by mentioning
"diff-tree".

I agree your _motivation_ behind your original patch is good.  Saying "see
also that page if you want to do very exotic and rarely useful operation"
is one thing, but saying "described are most often used ones" and not
describing enough is bad.

Perhaps we would want to include diff-options.txt.  There may be some
options that are no-op or always-on in the context of "git show" in the
file, but we already have an infrastracture to turn parts of the inclusion
on and off depending on which manual page includes it.

> diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
> index dccf0e2..299b611 100644
> --- a/Documentation/git-show.txt
> +++ b/Documentation/git-show.txt
> @@ -25,12 +25,6 @@ with \--name-only).
>  
>  For plain blobs, it shows the plain contents.
>  
> -The command takes options applicable to the linkgit:git-diff-tree[1] command to
> -control how the changes the commit introduces are shown.
> -
> -This manual page describes only the most frequently used options.
> -
> -
>  OPTIONS
>  -------
>  <object>::
> @@ -38,6 +32,9 @@ OPTIONS
>  	For a more complete list of ways to spell object names, see
>  	"SPECIFYING REVISIONS" section in linkgit:git-rev-parse[1].
>  
> +-s::
> +	Don't show a textural diff for commits.
> +
>  include::pretty-options.txt[]
>  
>  
> -- 
> 1.5.5.1.91.g499fc.dirty
