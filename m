From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6] Add contrib/credentials/netrc with GPG support
Date: Thu, 07 Feb 2013 15:52:41 -0800
Message-ID: <7vtxpn4r7a.fsf@alter.siamese.dyndns.org>
References: <87ehgvua6h.fsf@lifelogs.com>
 <20130204211726.GB13186@sigill.intra.peff.net>
 <87mwvjsqjc.fsf_-_@lifelogs.com> <7vvca6u47f.fsf@alter.siamese.dyndns.org>
 <87k3qmr8yc.fsf@lifelogs.com> <87fw1ar3og.fsf_-_@lifelogs.com>
 <87ehgvua6h.fsf@lifelogs.com> <20130204211726.GB13186@sigill.intra.peff.net>
 <87mwvjsqjc.fsf_-_@lifelogs.com> <7vvca6u47f.fsf@alter.siamese.dyndns.org>
 <87k3qmr8yc.fsf@lifelogs.com> <7vhalqsfkf.fsf@alter.siamese.dyndns.org>
 <8738xaqy40.fsf_-_@lifelogs.com> <7vip66qu0u.fsf@alter.siamese.dyndns.org>
 <7vtxpqnwiv.fsf@alter.siamese.dyndns.org> <876226p97h.fsf_-_@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 00:53:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3bHB-0007wA-P3
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 00:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096Ab3BGXwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 18:52:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33242 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089Ab3BGXwo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 18:52:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D825FD80E;
	Thu,  7 Feb 2013 18:52:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mEmR7zTMmv90x5O6k6m1o+/EmrQ=; b=IhJnNi
	BPYo0oqMC1gEcYVZiOd4FlYbpTpCH7giHWQe5VSJdskzSu2bp9AHdaEWqvcn8RM3
	28Wptm/BjSJPk/ieUVh2PXm59QA3GNbyyxewqIHrc2aB0IWbQoXdoifLHY01nk3B
	mTxz33UGVH0674lJGBFEjaV1gDFRbcGk+MoOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LkrciQXRJ2XpewFbyOq6qFf8tLqEThEu
	6JgKVAAhAJs2zsyX4CEfdJRs/9pchZIaWXCWM5Cyt1uy/KsfYi5RqY0Z4GsJ0zb2
	+BL3Jq/28c72WzMY9rjaoBp1pCVHENmvvtq4KV3rY3fqsEXh5GdCdHCRKcwHn+yT
	WNmmj/5cj5Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD34DD80D;
	Thu,  7 Feb 2013 18:52:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37F11D80C; Thu,  7 Feb 2013
 18:52:43 -0500 (EST)
In-Reply-To: <876226p97h.fsf_-_@lifelogs.com> (Ted Zlatanov's message of
 "Tue, 05 Feb 2013 19:38:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 76CC67F6-7181-11E2-8B96-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215737>

Ted Zlatanov <tzz@lifelogs.com> writes:

> Add Git credential helper that can parse netrc/authinfo files.

I think this line is redundant; we already know it on the Subject: line.

> This credential helper supports multiple files, returning the first one
> that matches.  It checks file permissions and owner.  For *.gpg files,
> it will run GPG to decrypt the file.
>
> Signed-off-by: Ted Zlatanov <tzz@lifelogs.com>
> ---
> ...
> diff --git a/contrib/credential/netrc/Makefile b/contrib/credential/netrc/Makefile
> new file mode 100644
> index 0000000..18a924f
> --- /dev/null
> +++ b/contrib/credential/netrc/Makefile
> @@ -0,0 +1,12 @@
> +test_netrc:
> +	@(echo "bad data" | ./git-credential-netrc -f A -d -v) || echo "Bad invocation test, ignoring failure"
> +	@echo "=> Silent invocation... nothing should show up here with a missing file"
> +	@echo "bad data" | ./git-credential-netrc -f A get
> +	@echo "=> Back to noisy: -v and -d used below, missing file"
> +	echo "bad data" | ./git-credential-netrc -f A -d -v get
> +	@echo "=> Look for any entry in the default file set"
> +	echo "" | ./git-credential-netrc -d -v get
> +	@echo "=> Look for github.com in the default file set"
> +	echo "host=google.com" | ./git-credential-netrc -d -v get
> +	@echo "=> Look for a nonexistent machine in the default file set"
> +	echo "host=korovamilkbar" | ./git-credential-netrc -d -v get

Whose netrc is this reading?

Don't we want all of them to have "-f A" and ship "A" (rename it to
something more reasonable), so that anybody can notice when he tries
to improve it and breaks it?
