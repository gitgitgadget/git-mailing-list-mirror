From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Revert changes and extend diff option documentation
Date: Sun, 16 Dec 2007 11:43:23 -0800
Message-ID: <7vejdml92c.fsf@gitster.siamese.dyndns.org>
References: <1197631424-52586-1-git-send-email-win@wincent.com>
	<1197631424-52586-2-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 20:43:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3zP2-0006zx-Tx
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 20:43:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594AbXLPTnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 14:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751841AbXLPTnd
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 14:43:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55430 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259AbXLPTnc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 14:43:32 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F27913602;
	Sun, 16 Dec 2007 14:43:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C5943601;
	Sun, 16 Dec 2007 14:43:25 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68479>

Wincent Colaiuta <win@wincent.com> writes:

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 9ecc1d7..54207f0 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -92,10 +92,10 @@ endif::git-format-patch[]
>  	file gives the default to do so.
>  
>  --check::
> -	Warn if changes introduce trailing whitespace
> -	or an indent that uses a space before a tab. Exits with
> -	non-zero status if problems are found. Not compatible with
> -	--exit-code.
> +	Warn if changes introduce whitespace problems (such as
> +	trailing whitespace). Configuration and per-path attributes
> +	control what git classifies as a whitespace problem (see
> +	gitlink:git-config[1] and gitlink:gitattributes[5]).

This is not quite right, is it?  The command still exits with exit code.
It is just that the calling process does not see it if you let it spawn
the pager.

> @@ -197,8 +197,9 @@ endif::git-format-patch[]
>  
>  --exit-code::
>  	Make the program exit with codes similar to diff(1).
> -	That is, it exits with 1 if there were differences and
> -	0 means no differences.
> +	That is, it exits with 0 if there were no differences
> +	and 1 if there were. If --check is used and the
> +	differences introduce whitespace problems exits with 3.

This side is correct.
