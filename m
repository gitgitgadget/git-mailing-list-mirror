From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] dir.c: Make git-status --ignored more consistent
Date: Sun, 30 Dec 2012 13:36:35 -0800
Message-ID: <7v623jfcik.fsf@alter.siamese.dyndns.org>
References: <20121229072249.GB15408@sigill.intra.peff.net>
 <1356878341-12942-1-git-send-email-apelisse@gmail.com>
 <CALWbr2w=CWkpbJhC5sjd9HnErmWj9JQnD6UUiDM91ovJ_-16vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Adam Spiers <git@adamspiers.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 30 22:40:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpQcj-00018G-Dg
	for gcvg-git-2@plane.gmane.org; Sun, 30 Dec 2012 22:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685Ab2L3Vgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2012 16:36:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36227 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751158Ab2L3Vgj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2012 16:36:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C14DCA4BF;
	Sun, 30 Dec 2012 16:36:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8bz583d+V9VcLQIOXoVUwoyLLu0=; b=GFo2nm
	6ri7Yeta84+S3i34IQJ5WgT3eSp/tlsDNhq3E3UcgXl/24MAIb9j6SFARzeTT1sV
	qrgHJAkdPkhFGEgfsZ45d06E6+9bYiImGFKCFqGF/BgB3MyykCxMZ9c2jZFQ0QA3
	P1srKa7pA9C+Mj2bHfKgTglkc+WnsEOo/DvEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pE9r8DZTeduJ2iYL/0X1FjxdV4DrPNDO
	mOfPfuPEQuKZ4WPZn34UXJ1Amw80GXZ2iOGI6Q+1dqTQ0qya+JP9MyoJYPWno8zK
	rhVtx9URq9onPy3lf4XwvGZbyl7x6t8iNs94Af5yUdY7ZX4aHy1FvLoUCqmG6YbS
	scgMO+aAg1U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE041A4BC;
	Sun, 30 Dec 2012 16:36:37 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 22CA6A489; Sun, 30 Dec 2012
 16:36:37 -0500 (EST)
In-Reply-To: <CALWbr2w=CWkpbJhC5sjd9HnErmWj9JQnD6UUiDM91ovJ_-16vA@mail.gmail.com> (Antoine
 Pelisse's message of "Sun, 30 Dec 2012 15:54:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD525F10-52C8-11E2-B1A0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212343>

Antoine Pelisse <apelisse@gmail.com> writes:

> By the way, that merges without conflicts with Adam's series, but it
> will not compile as he renamed functions that I'm now using
> (path_excluded() -> is_path_excluded() that is).
>
> By the way, Junio, how do you handle this situation as a maintainer ?
> Do you keep a note to manually make the change every time you remerge
> the series together ? That is the kind of use-case you can't handle
> with git-rerere, and I've been trying to find a solution to it.

I'll finish the write-up on jc/doc-maintainer topic not in a very
distant future, but not today.

In the meantime, the hint is in the use of refs/merge-fix/ hierarchy
in the Reintegrate script found on my 'todo' branch (which I have a
separate clone/checkout of in "Meta/" directory in my main working
tree).
