From: Junio C Hamano <gitster@pobox.com>
Subject: Re: libgit2 status
Date: Sun, 26 Aug 2012 11:28:12 -0700
Message-ID: <7vharpv77n.fsf@alter.siamese.dyndns.org>
References: <87a9xkqtfg.fsf@waller.obbligato.org> <5038A148.4020003@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: greened@obbligato.org, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sun Aug 26 20:28:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5hZR-0006QB-Di
	for gcvg-git-2@plane.gmane.org; Sun, 26 Aug 2012 20:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592Ab2HZS2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Aug 2012 14:28:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51481 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753088Ab2HZS2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2012 14:28:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CA2B8D79;
	Sun, 26 Aug 2012 14:28:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZNmddhB8aXPg/TqOYIHVKGgDK9k=; b=GLz8fF
	PIVj1/IFb16uI/QPhZ1Yq9GH/xF6NZNkLnGMGpkT0sGUtqQ7oc+ohAPv+2tdXyqV
	VHkzpGMmCFjm4DWr7z7avzphyuylqFcfBeRdmxB3IIeiqZmOEyfytQ8zxen0dbh/
	iU0bQmzpJNaxWuSmZAJWcGE66q5zR0YiLMw2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JD3/u8qQk4u0R/3kfBjY+iXfOKvYRKc1
	ZEYBwOzv/PIB/RFBEg4DjoejjTFMdse956/AlV1RfiEWI0GZ3xaXXtW6A3qNrsUA
	lcS4HU+b9FmAdPK1B7x2xAObcgItm0hwWvyj80BLGZwZT2DSN64LsiYc+c8olVWa
	cT00we+hAf8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 324068D77;
	Sun, 26 Aug 2012 14:28:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81D1D8D76; Sun, 26 Aug 2012
 14:28:14 -0400 (EDT)
In-Reply-To: <5038A148.4020003@op5.se> (Andreas Ericsson's message of "Sat,
 25 Aug 2012 11:56:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC645398-EFAB-11E1-BC2A-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204305>

Andreas Ericsson <ae@op5.se> writes:

> Politically, I'm not sure how keen the git community is on handing
> over control to the core stuff of git to a commercial entity, but it
> doesn't seem to be a dying project, so I'd say go ahead and do it.

I do not think commercial-ness of any entity comes into the picture.

The only three things that matter are license compatibility (I think
libgit2 licensed under GPLv2 + linkage exception is doing just fine
in that department), maturity and quality of it (it is in early
development phase), and the openness of the development process (it
could do better by finding ways to better interact with the
mainstream git development discussion that happens here in the
longer term).

And the last one should really be a "longer term" item.  It is more
important for its codebase to get mature and robust, and that can
only happen by various projects and products (e.g. GitHub for Mac)
using it to improve it.  I do not think "subtree" (or anything in
contrib/ for that matter) is part of "the core stuff of git", and do
not see a problem; such a move may help both subtree and libgit2.

Over a much longer timeperiod, I wouldn't be surprised if some "core
stuff" gets reimplemented on top of libgit2 and distributed as part
of the git-core.

There will be substantial integration and logistics hassles ahead of
us before that can happen, though.  E.g.  we could point at libgit2
as our submodule, but that is not the only way to make git depend on
libgit2; it could just be a Build-Depends like we depend on libz.
Looking at the build dependency of libgit2 itself, I do not think
tighter integration of the libgit2 itself into the git-core is not
likely to happen very soon, and also is not necessarily a good thing
to do.
