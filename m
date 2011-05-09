From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Separate default remotes for pulling and pushing
Date: Mon, 09 May 2011 09:45:49 -0700
Message-ID: <7viptjq0ua.fsf@alter.siamese.dyndns.org>
References: <1FDDE878-C81A-4318-836B-7F8BED51A981@gmail.com>
 <BANLkTinJDUa7sXjKHo81bG7KbnspxZ88oA@mail.gmail.com>
 <20110509081708.GA5871@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	David Lee <davidomundo@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 09 18:46:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJTaz-0005Rs-Kl
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 18:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105Ab1EIQqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 12:46:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48586 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab1EIQqB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 12:46:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 12D3E456D;
	Mon,  9 May 2011 12:48:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qIEPbWajIGdjfnqn4CZJHmZeNLo=; b=jnTCJ/
	8+PVfHazQBPhR3qkOygjmObIJBnDLsa3mzFK00xc9dsyi0ooBc6NVETTXK8Lwskv
	0A8koP85OLwm3yyujvoI/cxjw+epifvmvCf28OaiNE9rJ8tKX5uoTLaiCNf6K0wQ
	Bny1WUTn4xpSQ3mg9SrNHTiDn07/rObUZRASA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P/fMId6xAgQxBuV3+AJPr99lYJrehHtn
	BHWn1npVQzTmUGJn61mz4cH+PltesrZIViYPFEqlLAQaOyaXXcpWOJpYVebRR2zR
	xqvEWz9xSnQZNacJmPhbWHuKlqNgwm/2+VrjHeNlqYFLZQQBe+pSooIL9H6wJ2wZ
	NK2Li6xv/Ac=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B7462456C;
	Mon,  9 May 2011 12:48:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 54020456B; Mon,  9 May 2011
 12:47:55 -0400 (EDT)
In-Reply-To: <20110509081708.GA5871@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 9 May 2011 04:17:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 199E042C-7A5C-11E0-8A93-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173245>

Jeff King <peff@peff.net> writes:

>   4. Decentralized, you're a developer that publishes work via git. You
>      call the upstream maintainer "origin", so fetches are convenient
>      (and git does this for you at clone, after all). But pushing, even
>      though you probably always push to the same central, does not have
>      a convenient shorthand.
>
>      This is David's case (and mine, and I suspect some other git
>      developers who do enough work that they want to make it publicly
>      available via git, or even just have backups). It's also encouraged
>      by sites like github, where you might clone the upstream's
>      repository, but then pushes your changes up to a personal "fork"
>      to let others see and merge them.

In a sense, this is what I do as well.  As you mentioned, I push to "ko"
to publish, but when I "fetch" (or "pull") from "origin", I get the public
copy I have at kernel.org like everybody else, and I do fetch every time
after I push to "ko" to get the updated preformatted HTML and man page
branches.

I never felt it awkward that my fetch says "origin" and my push says "ko".
Even though I imagine that I could smash them together into a single
"origin", it would not give me anything, as I also push to push to
different places like repo.or.cz, sourceforge and github anyway.

While I see why some people might want to say "origin" for both in such a
set-up (when they do not push to multiple places like I do), I have a
feeling that it is a misguided wish that would make themselves unnecessary
confused than they already are, especially if the repositories used for
pushing and fetching are in reality different repositories (one good
example why it would be confusing is how remote tracking branches are
updated).
