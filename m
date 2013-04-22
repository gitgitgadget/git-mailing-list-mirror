From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/16] remote-helpers: avoid has_key
Date: Mon, 22 Apr 2013 15:28:54 -0700
Message-ID: <7va9oqnqs9.fsf@alter.siamese.dyndns.org>
References: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
	<1366667724-567-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Simon Ruderich <simon@ruderich.org>,
	Dusty Phillips <dusty@linux.ca>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 00:29:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUPEL-0005Tc-PS
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 00:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479Ab3DVW25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 18:28:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37444 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753317Ab3DVW24 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 18:28:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EB2218172;
	Mon, 22 Apr 2013 22:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lYt2/0UQ+L36SnTf0JNAzw6GRkk=; b=wR4jCn
	PYVaeDT8NtdcWogtJEhHaQ9lbTszs6BonL8d8sFAXBroC9lQW79MDaqT1LaBwozk
	4diJ5jmyqwkzDP2cyUz5VIjF2hAPq4wOFSu38gTkyIptfn+AfOWhsI1xlu3lXhAo
	lnYpVfB0rlBMD/3IpJ9Vz72Lmu9sWaPac4/q0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jpnYafPbh/BBsbnArXJ+QPnSPxnovGrc
	7nuc6z3s9W8xGWcC4SQj7B4wX5Q/quncUbhoxZQqQfTSLK+q8dL/hgAfhdCD+wFX
	jn/MTj06X2iHD+Z5QSkyYu2EcSb2Lk8kY5iCV+JUECOte1R9mTxo53FfMFxIxPk5
	PWhe9m4a1bY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4237918171;
	Mon, 22 Apr 2013 22:28:56 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A06241816E;
	Mon, 22 Apr 2013 22:28:55 +0000 (UTC)
In-Reply-To: <1366667724-567-2-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Mon, 22 Apr 2013 16:55:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 04B3C95C-AB9C-11E2-9753-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222119>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> From: Dusty Phillips <dusty@linux.ca>
>
> It is deprecated.
>
> [fc: do the same in remote-bzr]
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

No sign-off by the author?

It does not matter for something so trivial like this that there is
no other way to write, but it is a good habit you should encourage
your contributors to acquire, so that you do not have to waste time
with "please sign off" when their next contribution that is more
substantial comes.

>  contrib/remote-helpers/git-remote-bzr | 2 +-
>  contrib/remote-helpers/git-remote-hg  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
> index aa7bc97..cc6609b 100755
> --- a/contrib/remote-helpers/git-remote-bzr
> +++ b/contrib/remote-helpers/git-remote-bzr
> @@ -94,7 +94,7 @@ class Marks:
>          return self.last_mark
>  
>      def is_marked(self, rev):
> -        return self.marks.has_key(rev)
> +        return str(rev) in self.marks
>  
>      def new_mark(self, rev, mark):
>          self.marks[rev] = mark
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index 5481331..2cd1996 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -129,7 +129,7 @@ class Marks:
>          self.last_mark = mark
>  
>      def is_marked(self, rev):
> -        return self.marks.has_key(str(rev))
> +        return str(rev) in self.marks
>  
>      def get_tip(self, branch):
>          return self.tips.get(branch, 0)
