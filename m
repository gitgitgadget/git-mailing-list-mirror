From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] builtin-commit: refactor short-status code into
 wt-status.c
Date: Sun, 06 Dec 2009 16:30:04 -0800
Message-ID: <7v638jd3sj.fsf@alter.siamese.dyndns.org>
References: <cover.1260025135.git.git@drmicha.warpmail.net>
 <c42e3f38816a08aba4610cb808f09067a07ad097.1260025135.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Dec 07 01:31:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHRVx-0004Cy-06
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 01:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934465AbZLGAaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 19:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934412AbZLGAaJ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 19:30:09 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64514 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934465AbZLGAaE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 19:30:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 63C92856B6;
	Sun,  6 Dec 2009 19:30:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=MxNxTClAzc4ABQrrZqJ2d5fD/mY=; b=gSRNRup8pNaxLYQXEyaS2M/
	mBfcogZJfax9DS344BNwJF/nRMP5Zf+dyKxQnliUkMOTD7cJ5miRaECxZOi7iaRt
	fSUo/0DnKXPDm7a3T8bFolmDCI08Ab3OfiR9kg8uKivXUvszgGHSjUvoK9sBTp6J
	KQTbqSTUxc0TWGqTtCYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=hXSrLUlcNbOLazXiJCCJLCMlNakjPoqzbuNLT7qh+gyssT2Hi
	/eLYBJ0AHh+7c4fDsKz7yNZzEastbMZ+YGdTZSx1sevfZGAe6sK/9QtN+T0RWCjV
	oCxxU88fGUsxMYJL+ZLmezKY0rzhFSLEVFdCA7p2tor8N5Ja0QflgJBkLE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EE73856B3;
	Sun,  6 Dec 2009 19:30:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CAAF856AF; Sun,  6 Dec
 2009 19:30:05 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ACBF329A-E2C7-11DE-A70A-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134699>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Currently, builtin-commit.c contains most code producing the
> short-status output, whereas wt-status.c contains most of the code for
> the long format.
>
> Refactor so that most of the long and short format producing code
> resides in wt-status.c and is named analogously.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  builtin-commit.c |  101 ++---------------------------------------------------
>  wt-status.c      |   89 +++++++++++++++++++++++++++++++++++++++++++++++
>  wt-status.h      |    2 +
>  3 files changed, 95 insertions(+), 97 deletions(-)

Nice.

Thanks.
