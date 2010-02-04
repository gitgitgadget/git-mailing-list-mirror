From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Thu, 04 Feb 2010 13:03:39 -0800
Message-ID: <7vaavo90ic.fsf@alter.siamese.dyndns.org>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com>
 <7vpr4lhsfu.fsf@alter.siamese.dyndns.org>
 <7v4olxhrti.fsf@alter.siamese.dyndns.org>
 <201002041821.22864.jnareb@gmail.com>
 <cb7bb73a1002041208q54ff1f57y3202e88ae2f5f44e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 22:04:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd8ro-0008E1-UO
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 22:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753278Ab0BDVDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 16:03:55 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57849 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968Ab0BDVDy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 16:03:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DF1697CFE;
	Thu,  4 Feb 2010 16:03:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lYxhH25cRaU/mCzNDKCWsJaOexw=; b=NV5jH8
	9g4SoprhDft78yhKJDrzEwVioS6sVMQ4r0Ah065PobzHQK0ZrAEw3Zy7ktEoler2
	m3nSIvtZRl/JNvUZBUyiyqWyw+zXQBvWcbBrvXIRdbRUEuveSB5OmWa9MAppHyTa
	Jtr0gPgRkyzRjp2gBSzkvLyM0c0xutwveufhw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BfYV2XfWSwsw1V2D8XLIqkAdHVvJF3c2
	0Hn1fbYgoW+8VTm7kD1CWi0tFfLeZ81fjUvIaUKaovpOTZTwmWn1wqW26ezetshH
	qcCGWpK9gaPDyameDid8XtXZKHNk6LBwKqpsouB2LxAyjOUlZ79NOllaMmqqNj0F
	OJBP1AIzhio=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 04E6897CFC;
	Thu,  4 Feb 2010 16:03:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B664297CF9; Thu,  4 Feb
 2010 16:03:40 -0500 (EST)
In-Reply-To: <cb7bb73a1002041208q54ff1f57y3202e88ae2f5f44e@mail.gmail.com>
 (Giuseppe Bilotta's message of "Thu\, 4 Feb 2010 21\:08\:04 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C9B6C402-11D0-11DF-A8E3-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139003>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> As I mentioned on the cover letter, I was hoping to be able to make
> something that could be deployable without requiring core changes and
> thus a specific minimum git version. I do realize however that this is
> inherently not robust (unless the code is updated if and when the
> notes storage mechanism changes).

AFAIU, the note code on the core side already creates a fan-out structure
when notes tree gets large (see recent "What's cooking"; the series is
parked in 'pu' but that is primarily because we are in feature freeze); it
is not just "inherently not robust" but is much closer to "broken from day
one" ;-).  Otherwise I wouldn't have wasted time to point it out.

Your code is a very good proof-of-concept, though.

Regarding support of multiple notes hierarchies, listing, etc.

See for example:

  http://thread.gmane.org/gmane.comp.version-control.git/138079/focus=138128

I expect more ideas from needs by end-user would come, as we gain
experience with using notes in real projects.  You will certainly find
some other needs of your own, like the "not an environment but a command
line option" which Jakub mentioned, and "multiple hierarchies" like both
you and I found need for.  Share them and let us together make the notes
mechanism nicer to use.

Thanks.
