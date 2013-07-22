From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] rev-parse(1): logically group options
Date: Mon, 22 Jul 2013 15:30:39 -0700
Message-ID: <7vehaqb52o.fsf@alter.siamese.dyndns.org>
References: <7v4nbquw3l.fsf@alter.siamese.dyndns.org>
	<cover.1374410829.git.john@keeping.me.uk>
	<cover.1374410829.git.john@keeping.me.uk>
	<d708e9253761472a1e675ce6fe46dc02686ad9a9.1374410829.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Jul 23 00:30:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1Ocw-0004rT-No
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 00:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782Ab3GVWam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 18:30:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38245 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737Ab3GVWam (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 18:30:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D6452707C;
	Mon, 22 Jul 2013 22:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=5+az5L4fd+CeSUhoTEAfbddXtjo=; b=TRydpV7TgOygfc5D/xpF
	iV0QgSH/2xTbNBJxIbTS9Pm9aBVqD1dxE6y9LI1bwQu+wF2CEiQFOLBSQqU4ZQES
	Q8JyfAZ8BA7wMjUGtcZpZU7FdRGc9b9ZA6iF+cTbGHt1rrYPNBGCj8YLYqRL40Gn
	5FYhh+EUb7hHargJ3AnvSGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=XPWamK1sE01IbFQIFTxmTy/edWrEYjAGK4SL3TY/URAhvB
	t5n4vpdh9okk1RdHqx8D0ruZ3WkCvCMTg/tPmBnGO1yMDxiCq8LTMI6TjZrRadHY
	hbB91/zUlMSST44MmJIK346jttVKO9e/AmXn9kmatb/m9jYJEzbLfFu4Ua99g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94FDD2707B;
	Mon, 22 Jul 2013 22:30:41 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0C5E27077;
	Mon, 22 Jul 2013 22:30:40 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 57089EE8-F31E-11E2-887D-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231003>

John Keeping <john@keeping.me.uk> writes:

> The options section of the git-rev-parse manual page has grown
> organically so that there now does not seem to be much logic behind the
> ordering of the options.  It also does not make it clear that certain
> options must appear first on the command line.
>
> Address this by reorganising the options into groups with subheadings.
> The text of option descriptions does not change.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  Documentation/git-rev-parse.txt | 104 ++++++++++++++++++++++++----------------
>  1 file changed, 64 insertions(+), 40 deletions(-)
>
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index 993903c..34c55a7 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -24,9 +24,23 @@ distinguish between them.
>  
>  OPTIONS
>  -------
> +
> +Operation Modes
> +~~~~~~~~~~~~~~~
> +
> +Each of these options must appear first on the command line.
> +
>  --parseopt::
>  	Use 'git rev-parse' in option parsing mode (see PARSEOPT section below).
>  
> +--sq-quote::
> +	Use 'git rev-parse' in shell quoting mode (see SQ-QUOTE
> +	section below). In contrast to the `--sq` option below, this
> +	mode does only quoting. Nothing else is done to command input.

Much nicer ;-)

The rest also looked good to me.  Thanks.
