From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Mention that git-branch -M can cause problems for tracking branches
Date: Fri, 02 Nov 2007 13:14:57 -0700
Message-ID: <7vlk9g1k1q.fsf@gitster.siamese.dyndns.org>
References: <20071102091734.GC10141@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Nov 02 21:15:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io2vM-0006N9-AY
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 21:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757522AbXKBUPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 16:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754852AbXKBUPI
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 16:15:08 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:50228 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757452AbXKBUPG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 16:15:06 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id DE3CA2EF;
	Fri,  2 Nov 2007 16:15:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6A5F591788;
	Fri,  2 Nov 2007 16:15:25 -0400 (EDT)
In-Reply-To: <20071102091734.GC10141@diku.dk> (Jonas Fonseca's message of
	"Fri, 2 Nov 2007 10:17:34 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63168>

Jonas Fonseca <fonseca@diku.dk> writes:

> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> ---
>  Documentation/git-branch.txt |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
>  I made a patch to discard the overwritten branch's configuration
>  section, which Spearce felt was too lossy a behaviour. However, since
>  it confused me, I think it should at least be mentioned in the manpage.
>  Maybe the warning message from git should also be added to improve its
>  "googlability".
>
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 5e81aa4..def4e85 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -165,6 +165,11 @@ If you are creating a branch that you want to immediately checkout, it's
>  easier to use the git checkout command with its `-b` option to create
>  a branch and check it out with a single command.
>  
> +When a branch is renamed so that it overwrites an existing branch unintended
> +problems can arise. This is because git refuses to discard the configuration
> +section of the overwritten branch. As a result git can become confused if, for
> +example, the branches involved were used for tracking two different remote
> +branches. The only way to fix this is to edit the configuration file manually.

I do not understand this bit about "refuse".

 - To "refuse to discard", somebody has to ask to discard ---
   who asks so and when?

 - Is there a reason to "refuse" when such a removal request is
   made?  If so, what is it?  If not, why refusal?
