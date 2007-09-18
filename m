From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Mention that 'push .. master' is in explicit form master:refs/heads/master
Date: Tue, 18 Sep 2007 13:54:26 -0700
Message-ID: <7vfy1bvgn1.fsf@gitster.siamese.dyndns.org>
References: <wsuomgyu.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 22:54:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXk5i-0008W7-Lz
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 22:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867AbXIRUyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 16:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755028AbXIRUyd
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 16:54:33 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:35622 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbXIRUyc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 16:54:32 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 63CA01378B5;
	Tue, 18 Sep 2007 16:54:50 -0400 (EDT)
In-Reply-To: <wsuomgyu.fsf@blue.sea.net> (Jari Aalto's message of "Tue, 18 Sep
	2007 12:59:53 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58633>

Jari Aalto <jari.aalto@cante.net> writes:

> Signed-off-by: Jari Aalto <jari.aalto AT cante.net>
> ---
>  Documentation/git-push.txt |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 7b8e075..71ac450 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -105,7 +105,9 @@ git push origin master::
>  	Find a ref that matches `master` in the source repository
>  	(most likely, it would find `refs/heads/master`), and update
>  	the same ref (e.g. `refs/heads/master`) in `origin` repository
> -	with it.
> +	with it. The following would be exactly same command:
> +
> +	git push origin master:refs/heads/master

They _might_ be exactly the same.

The reason people often explicitly write

	$ git push $URL refs/heads/master:refs/heads/master

in their insns for newbies is because this form would not be
affected by the random factors at $URL repository (or your
repository) and will consistently get the same result.

	$ git push $URL foo

may push branch head 'foo' or tag 'foo' depending on which one
you have locally.  Having both is not encouraged, but spelling
the insn out explicitly as refs/heads/foo makes it clear the
command is talking about the branch even when there is a tag
with the same name.
