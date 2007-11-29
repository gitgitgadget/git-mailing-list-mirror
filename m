From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: give rerere a chance
Date: Wed, 28 Nov 2007 16:17:27 -0800
Message-ID: <7v7ik129d4.fsf@gitster.siamese.dyndns.org>
References: <7vlk8q7hzg.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711221117590.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 29 01:18:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxX6y-00048r-GE
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 01:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758594AbXK2ARe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 19:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762018AbXK2ARe
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 19:17:34 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:59024 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762243AbXK2ARc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 19:17:32 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 4A3F32F2;
	Wed, 28 Nov 2007 19:17:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id D67D99ADAC;
	Wed, 28 Nov 2007 19:17:50 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711221117590.27959@racer.site> (Johannes
	Schindelin's message of "Thu, 22 Nov 2007 11:18:10 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66476>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> @@ -166,13 +167,13 @@ pick_one_preserving_merges () {
>  			msg="$(git cat-file commit $sha1 | sed -e '1,/^$/d')"
>  			# No point in merging the first parent, that's HEAD
>  			new_parents=${new_parents# $first_parent}
> -			# NEEDSWORK: give rerere a chance
>  			if ! GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
>  				GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
>  				GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
>  				output git merge $STRATEGY -m "$msg" \
>  					$new_parents
>  			then
> +				git rerere

This comment is not about this rerere change, but output is a shell
function and I vaguely recall we had a discussion on "VAR=VAL cmd" form
of single-shot export not working for them as expected...
