From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Re: git config --get-urlmatch does not set exit code 1 when no match is found
Date: Sun, 28 Feb 2016 12:01:19 -0800
Message-ID: <xmqq8u24eh9s.fsf@gitster.mtv.corp.google.com>
References: <20160228104557.GT1766@serenity.lan>
	<cover.1456660027.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Guilherme <guibufolo@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Feb 28 21:01:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aa7X8-0008Hr-OT
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 21:01:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755065AbcB1UB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 15:01:28 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755024AbcB1UB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 15:01:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BEF0A47CBF;
	Sun, 28 Feb 2016 15:01:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G78L435ouGwgeOvJUAOsWOiyLUU=; b=YlJzkP
	1Bg086KMWwmLCKDjXMF9/u31Lofj30c4rdsbP1IuXmL6fZsz5O4DbA4PIil3gYZL
	ldiHU4dxGWoWQ+UJlcGW+nJ6QMAn6zGqNdqzzgRXTN6QqZA/lCMZkPOybpcpMkWA
	+87Ejj4wiEhddfl/1yaU4rr6reof/JtnIbu9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GTY8MvCRq/CXddizC8E1yJe5oashBCx0
	vBQ8b1PYjqhDq2G7hwIGbqjuRjeAJ+DQkiF09TjqUVJ/zy3dYwErnN9cfFfHiKSG
	1ZHJWWLyqDxHWKCSEgWXXz7xCghjL2TJBN8tnmwwrb3ePXgw+dhduPgcLcoaFJZG
	IGKCYCMtHXI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B66F547CBE;
	Sun, 28 Feb 2016 15:01:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2C71247CBD;
	Sun, 28 Feb 2016 15:01:21 -0500 (EST)
In-Reply-To: <cover.1456660027.git.john@keeping.me.uk> (John Keeping's message
	of "Sun, 28 Feb 2016 11:54:34 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0975F2EA-DE56-11E5-BAE6-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287788>

John Keeping <john@keeping.me.uk> writes:

> Here's a series that changes the behaviour of "git config --get-urlmatch"
> when no appropriate key is found as well as a couple of improvements to
> the documentation while we're here.

Sounds sensible.  It does change the behaviour, but it is inevitable
that a bugfix has to change existing behaviour, so...

>
> John Keeping (3):
>   config: fail if --get-urlmatch finds no value
>   Documentation/git-config: use bulleted list for exit codes
>   Documentation/git-config: fix --get-all description
>
>  Documentation/git-config.txt | 19 +++++++++----------
>  builtin/config.c             |  5 ++++-
>  t/t1300-repo-config.sh       |  3 +++
>  3 files changed, 16 insertions(+), 11 deletions(-)
