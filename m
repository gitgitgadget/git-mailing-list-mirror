From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-format-patch(1)- add note about creating patch for
 single commit
Date: Sat, 18 Oct 2008 22:21:26 -0700
Message-ID: <7v1vyd9n3d.fsf@gitster.siamese.dyndns.org>
References: <1224392084-12956-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 19 07:24:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrQli-0001qY-3K
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 07:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbYJSFVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 01:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbYJSFVu
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 01:21:50 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38200 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbYJSFVu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 01:21:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BF2D58C788;
	Sun, 19 Oct 2008 01:21:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2EF678C786; Sun, 19 Oct 2008 01:21:28 -0400 (EDT)
In-Reply-To: <1224392084-12956-1-git-send-email-dpmcgee@gmail.com> (Dan
 McGee's message of "Sat, 18 Oct 2008 23:54:44 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D440125A-9D9D-11DD-A314-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98591>

Dan McGee <dpmcgee@gmail.com> writes:

> Signed-off-by: Dan McGee <dpmcgee@gmail.com>
> ---
>
> I thought this would be helpful because it took me the beter part of an hour
> to find a solution instead of specifying C~1..C or other crazy things. The
> current documentation just leaves you hanging when what you really want is
> just one formatted patch.
>
> If there any suggestions on better wording, feel free to resubmit or whatever-
> I just felt like this should be documented somewhere.
>
>  Documentation/git-format-patch.txt |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index adb4ea7..8518c33 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -46,7 +46,9 @@ applies to that command line and you do not get "everything
>  since the beginning of the time".  If you want to format
>  everything since project inception to one commit, say "git
>  format-patch \--root <commit>" to make it clear that it is the
> -latter case.
> +latter case.  If you want to format only a single commit, say "git
> +format-patch <commit>^!" (which excludes all parent revisions of the
> +specified commit).
>  
>  By default, each output file is numbered sequentially from 1, and uses the
>  first line of the commit message (massaged for pathname safety) as

Heh, a more natural way to say that is:

	git format-patch -1 $that_one

That uses the first option described in the documentation:

	-<n>::
        	Limits the number of patches to prepare.
