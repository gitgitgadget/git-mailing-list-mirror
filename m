From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] l10n: builtin/pull.c: mark strings for translation
Date: Fri, 08 Apr 2016 13:33:42 -0700
Message-ID: <xmqqd1pzvo0p.fsf@gitster.mtv.corp.google.com>
References: <1460145765-7454-1-git-send-email-vascomalmeida@sapo.pt>
	<1460145765-7454-4-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Fri Apr 08 22:34:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aod6c-0004Ms-UT
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 22:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758942AbcDHUdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 16:33:53 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53287 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758934AbcDHUdu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 16:33:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 818BA5301D;
	Fri,  8 Apr 2016 16:33:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=inLmBkonD2yv/K4FDvR1m7+MRpk=; b=cCYnJC
	nsHkzu5+bdHwaFi2bL3Oal3jQkvfza+dy0hO1UfG75nEE9zBbcyV6a2OzmjUE672
	2hvA+u1L8vA3G1tXeGykdZJbpRK11tUlJZGjqKN9KzXrBppZfagVv9RG5OodrCSl
	ZZPg0GxnUkiyqDx3TI4vqUnQwsV8v1PPZ33Js=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ENDvUTLa18fOHx012q8WAYHz6GGdYvol
	5xC3hyTXmh+jUj+JPVTKbNXO4+BiDUsOSGcy/s9OVXiCFFurhABfrmA1og4ox62+
	IvOA8szsH9qNJQ8cMZzOGIdRlCQrwk4wrQaKxxnwXWA+Jyq2fWsvfPgjyC0cPy3h
	Cina01CoorY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7907E5301C;
	Fri,  8 Apr 2016 16:33:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EBAD95301B;
	Fri,  8 Apr 2016 16:33:43 -0400 (EDT)
In-Reply-To: <1460145765-7454-4-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Fri, 8 Apr 2016 20:02:42 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2FF94CE0-FDC9-11E5-A560-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291070>

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> Some translations might also translate "<remote>" and "<branch>".
> ...
>  		fprintf_ln(stderr, _("See git-pull(1) for details."));
>  		fprintf(stderr, "\n");
> -		fprintf_ln(stderr, "    git pull <remote> <branch>");
> +		fprintf_ln(stderr, _("    git pull <remote> <branch>"));

But "git pull" itself must never be translated, and there is no hint
given to those who are working on *.po files to prevent it.

Wouldn't it make more sense to do it like this?

	fprintf_ln(stderr, "    git pull <%s> <%s>", _("remote"), _("branch"));
