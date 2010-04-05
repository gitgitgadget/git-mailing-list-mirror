From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation/remote-helpers: Add invocation and see
 also  sections
Date: Mon, 05 Apr 2010 15:07:03 -0700
Message-ID: <7vljd1mu48.fsf@alter.siamese.dyndns.org>
References: <f3271551003282104v384d2dc7qe0d3c092c01bc505@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 00:07:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyuSH-0003Vk-2l
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 00:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756732Ab0DEWHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 18:07:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45067 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756686Ab0DEWH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 18:07:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 89FD5A8894;
	Mon,  5 Apr 2010 18:07:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rpfaozeQd1yZbGttPI3sVgNOGv8=; b=sdzfD/
	7IMPgm1E3ZPYHD+nW0OHYLN/yLLjIBxpz5jz+g6a5x8TAZzzMvgJ+exy6PECQg0n
	xQSt0zqfjAFK+qcjnl6STZNO4Pdi0inxBiB+Ciq3UUU5qEZiqaIO39ujS8LqdkDJ
	+vAz26ONDUs1qjKLMm58eWzqZf02IdJSGHNy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X568rlQMm3klWpue6Am2Pw5aPRUYQW9y
	pk4+hnbTo1mHyNaF2JWrn+I+WpvxRF+FEHhKZQIpkqde8/DFZKwHoGL8H+dyoc2Z
	b4MtYpJUbaKBJNrD6Fo2sXDb9kzSlixX49LMZ3rOpVjJgQ46V0jZJYuNOMDd3eZ9
	KdiGpjfrBck=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F183EA888A;
	Mon,  5 Apr 2010 18:07:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C755A8885; Mon,  5 Apr
 2010 18:07:04 -0400 (EDT)
In-Reply-To: <f3271551003282104v384d2dc7qe0d3c092c01bc505@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Mon\, 29 Mar 2010 09\:34\:35 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 98C4AF04-40FF-11DF-95B9-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144069>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> diff --git a/Documentation/git-remote-helpers.txt
> b/Documentation/git-remote-helpers.txt
> index 2382fb4..58533e5 100644
> --- a/Documentation/git-remote-helpers.txt
> +++ b/Documentation/git-remote-helpers.txt
> @@ -38,6 +38,54 @@ Git comes with a "curl" family of remote helpers,
> specifically
>  'git-remote-ftps'. They implement the capabilities 'fetch', 'option',
>  and 'push'.
>
> +INVOCATION
> +----------
> +
> +These programs can always be invoked as 'git remote-<transport>' by
> +the end user.

That directly contradicts with what you wrote in the other [1/2] patch to
the same file, where you said "are normally not used directly by end
users".

Yes they _can_ be invoked, but unless you are in the business of debugging
them, you usually don't, so I don't see much point saying this.
