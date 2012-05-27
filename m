From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7403-*.sh: Avoid use of the nonportable '==' operator
Date: Sat, 26 May 2012 23:53:33 -0700
Message-ID: <7vfwamp11u.fsf@alter.siamese.dyndns.org>
References: <4FC10A0B.5080407@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jon.seymour@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun May 27 08:53:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYXME-0004df-0I
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 08:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575Ab2E0Gxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 02:53:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40810 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798Ab2E0Gxh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 02:53:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C2124590;
	Sun, 27 May 2012 02:53:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JmEEhtfsgyEVq66LbAS/o534Df0=; b=kztNK3
	5QIfJ3IwT6wnaS6sbR0rqRl1NgA/X/PDZxgS/aMeijKoFsn5gN7ZsAKcgoHVOHeP
	SWPF/By/M3pH0V3uJaYmLzvwETrTKPQVjoAKXfmOHAHAXoGZcNyOKL3kC44ryCnz
	q8fDgMxDKYlM+6MDzOXor/MbUGx1mmlaRvLa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iPTi7/PHrHXbitBTR7UhKoIYWBsVx/8a
	YLyEvGgvZGY07n6wUmoNhEXfw2zJo7BaziSI8dU0pEvMo47WrbrHUMhCWE0PGFxO
	QhLs2zxVkhDo7RpWFj7JEI++KM56t1CX2Yw2Z+KBBbIPRlBvUPRWRtTmx1+nY0CP
	kchjK5Pr48o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 132A1458F;
	Sun, 27 May 2012 02:53:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8CC9458C; Sun, 27 May 2012
 02:53:34 -0400 (EDT)
In-Reply-To: <4FC10A0B.5080407@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Sat, 26 May 2012 17:51:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ADD66798-A7C8-11E1-B234-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198581>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Some shells, including dash, do not support using the '==' string
> equality operator. This results in the failure of tests 7-12 with
> 'test' complaining of an "unexpected operator".

Thanks.  You do not have to single-out dash.
A shell script that uses "test $a == $b" is *buggy* and not conforming to
POSIX.
