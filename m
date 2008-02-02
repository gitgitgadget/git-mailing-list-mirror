From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-reset.txt: Use HEAD~N syntax everywhere (unify examples)
Date: Fri, 01 Feb 2008 18:59:29 -0800
Message-ID: <7v7iho6p2m.fsf@gitster.siamese.dyndns.org>
References: <3asc6spe.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sat Feb 02 04:00:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL8c7-00087o-K4
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 04:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758858AbYBBC7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 21:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757601AbYBBC7r
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 21:59:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48343 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757743AbYBBC7q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 21:59:46 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E3BA44FCF;
	Fri,  1 Feb 2008 21:59:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C9434FCE;
	Fri,  1 Feb 2008 21:59:41 -0500 (EST)
Importance: low
In-Reply-To: <3asc6spe.fsf@blue.sea.net> (Jari Aalto's message of "Sat, 02 Feb
	2008 03:41:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72214>

Jari Aalto <jari.aalto@cante.net> writes:

> The examples in the documentation refer to multiple ~N commits. To
> Keep the exampels unified with the same syntax, use ~N in all examples.
>
> Signed-off-by: Jari Aalto <jari.aalto AT cante.net>

> -$ git reset --soft HEAD^      <1>
> +$ git reset --soft HEAD~1     <1>
> -<1> The last three commits (HEAD, HEAD^, and HEAD~2) were bad
> +<1> The last three commits (HEAD, HEAD~1, and HEAD~2) were bad
> -$ git reset --soft HEAD^ ;# go back to WIP state  <2>
> +$ git reset --soft HEAD~1 ;# go back to WIP state <2>

I personally think this is a regression, not an improvement.

People need to refer to the HEAD^ (one commit ago) much more
often than HEAD~N for larger values of N.  And we should give
them exposure to HEAD^ and HEAD^^; both are faster and easier to
type and read than HEAD~1 and HEAD~2.

Especially about HEAD~1, nobody sane would type that.  It is
there only for consistency.

Otherwise, twisted people would complain "I can say HEAD~4
instead of HEAD^^^^ and it helps brevity; but it is inconsistent
that I cannot say HEAD~1 instead of HEAD^".
