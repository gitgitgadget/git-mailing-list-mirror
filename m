From: Junio C Hamano <gitster@pobox.com>
Subject: Re: receive.denyNonNonFastForwards not denying force update
Date: Mon, 20 Aug 2012 10:05:40 -0700
Message-ID: <7vzk5pjxy3.fsf@alter.siamese.dyndns.org>
References: <CAHgXSop42qWcAEGn6=og8Pistv_Jrwhgcnv3B_ORVtSMi1fCHA@mail.gmail.com>
 <CAHgXSooFj2PJtcOWqsVNHUzMBQnH0cYzPjfs1CkzVuufwRVrog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: John Arthorne <arthorne.eclipse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 19:05:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3VQE-0006fb-5S
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 19:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757469Ab2HTRFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 13:05:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44856 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755702Ab2HTRFn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 13:05:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0163A81FB;
	Mon, 20 Aug 2012 13:05:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oOzQdNVYDk39oEL1AHMHWb9N+R8=; b=td0t6F
	oM3NW2R42ZurV7zeEzyefQmek8kftGYFcAh3JXepaToLMbre3Ay8gsSyu7WPD3aq
	nOnNAWKc13LCaXdSdWosLSc2RPFF7BHjRYMEgmTetw4deAHYvbG8hUwHIJheVYqi
	bNMG5UVwNiYur0k5Etsbr2b9zP8TiP3koo0Bg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kLbf6jvgY/s9Qh58mkpG+oIuDT7Q4Q8y
	rksJHvN+4C3hPrhPFiVXv6jm39kD7OjrVCZVClK9KaUWpfho3chM/vVJIHqFgoq0
	OeiPHkCUNHbHi4gro9f4Q1sqYFMz9omh3FUvqwUFNj+qxuICq/UEB8j4vM2tunvL
	L3nnqPpRBfU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E334B81FA;
	Mon, 20 Aug 2012 13:05:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5883D81F8; Mon, 20 Aug 2012
 13:05:42 -0400 (EDT)
In-Reply-To: <CAHgXSooFj2PJtcOWqsVNHUzMBQnH0cYzPjfs1CkzVuufwRVrog@mail.gmail.com> (John
 Arthorne's message of "Mon, 20 Aug 2012 09:33:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4630A91E-EAE9-11E1-9335-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203858>

John Arthorne <arthorne.eclipse@gmail.com> writes:

> For all the details see this bugzilla, particularly comment #59 where we
> finally narrowed this down:
>
> https://bugs.eclipse.org/bugs/show_bug.cgi?id=343150

What does "at the system level" in your "does *not* work at the
system level." exactly mean?

A configuration variable in the repository configuration take
precedence over user preference $HOME/.gitconfig which in turn take
precedence over system wide default /etc/gitconfig (or whereever you
or your distro decided to place it).  In other words, if you have
"[receive] denyNonFastForwards" in the system wide default, you can
say "[receive] denyNonFastForwards = false" in one particular
repository to allow it for that repository.
