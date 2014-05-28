From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: optionally reject case-clone branch names
Date: Wed, 28 May 2014 10:14:34 -0700
Message-ID: <xmqq7g55esg5.fsf@gitster.dls.corp.google.com>
References: <1401231368.18134.63.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed May 28 19:14:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WphR7-0004HY-Iw
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 19:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbaE1ROl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 13:14:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52678 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751518AbaE1ROk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 13:14:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1FD7419F90;
	Wed, 28 May 2014 13:14:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m6YfkpR4bz/GhY9VCmM1Hdr1UXQ=; b=HopLDv
	5gDOV+3rtEaBXKPw9SxwuLI/9CDXKMG2SVPrwx06R5/9t7ZN7k40KC7GVyovM43I
	rgLz9TNxshPYu2HEOYhmSLaDtEeLNAJUnnxf8i321uRosRQCXs6fllLNvOvCUkgv
	E0E7EULD4Wt2SzZ03yQ7qZOEBPwGneqh9pnzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gwQ+WvIZeDGlLTChS4poWtSzrW7Cpt0I
	iaHAwGzmEhtwXlsuxtWyqchx5iwVl21Nz4XDNPGMb8Yw0nQspzLlkis7pFygLqUx
	1gch3jvq3TUi4qGFsFQHsNddBmCFQo0gGNFQkT8aR9pw+I2pBw7fr7j57B4V+xvD
	S1mTHXlXwnc=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 155F919F8F;
	Wed, 28 May 2014 13:14:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A8EA619F8B;
	Wed, 28 May 2014 13:14:36 -0400 (EDT)
In-Reply-To: <1401231368.18134.63.camel@stross> (David Turner's message of
	"Tue, 27 May 2014 18:56:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8B87C6BA-E68B-11E3-894B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250297>

David Turner <dturner@twopensource.com> writes:

> RFC follows:
>
> 1. On a case-insensitive server, git receive-pack ought to always reject
> branches which are same-but-for-case of existing branches.
> 2. On a case-sensitive server, the same rule by default, with an option
> to allow the old behavior.
>
> Let me know if, should I write these patches, they would be likely to be
> accepted.

There is another a lot simpler possiblity, no?

3. On any server whose administrator chooses to enforce "one case
   variant only" rule, install a pre-receive hook that enforces the
   rule.
