From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/Makefile: don't define TEST_RESULTS_DIRECTORY recursively
Date: Mon, 06 May 2013 08:20:48 -0700
Message-ID: <7vy5bsrv73.fsf@alter.siamese.dyndns.org>
References: <6bb37f45280373b96c2ae581db9bd87007dc0fb7.1367843730.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Thomas Rast <trast@inf.ethz.ch>, Jeff King <peff@peff.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon May 06 17:21:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZNDk-0005GR-2g
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 17:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754240Ab3EFPUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 11:20:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49275 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753960Ab3EFPUv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 11:20:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 673FF1A3DC;
	Mon,  6 May 2013 15:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1s6uh1h31oDaLBqDnESo39ZROmU=; b=g/5x2N
	C7WW6O5ywadx+MuEoZSJX/wxXqX+Ka806UP/Xd2iHLwtoHwHFSQj90bmLpUUHEYc
	KCWzYdW6GRM//4wlO+rDG/26rIrl1B1ud5SRHEZeZc0XhPPpNuI0TwBKY10e/Ckz
	c2Eq6Ha1ii2dKQfB2wjlI6cBLtkmgqTy6kNlk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ORudcuHZZNf5h7WOPgDGe6JeXFfLltUf
	CWL4jWUmqEcteQMnlvP+B7vmamr2JGENwgRGzKfGQpBwVSJ770V88upuyR7gXSAM
	xtsfLgjrSY6Ska/YMUCai0zMRsna/7teKyN5hb7W96yJCkvISfI2tERpTm300wln
	LQfwCzg5fg8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EA221A3DB;
	Mon,  6 May 2013 15:20:50 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA5C21A3D9;
	Mon,  6 May 2013 15:20:49 +0000 (UTC)
In-Reply-To: <6bb37f45280373b96c2ae581db9bd87007dc0fb7.1367843730.git.john@keeping.me.uk>
	(John Keeping's message of "Mon, 6 May 2013 13:35:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8893A6BA-B660-11E2-9F56-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223459>

John Keeping <john@keeping.me.uk> writes:

> Commit 54bb901 (t/Makefile: fix result handling with
> TEST_OUTPUT_DIRECTORY - 2013-04-26) incorrectly defined
> TEST_RESULTS_DIRECTORY relative to itself, when it should be relative to
> TEST_OUTPUT_DIRECTORY.  Fix this.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  t/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, I missed this one.

> diff --git a/t/Makefile b/t/Makefile
> index 11de5da..ebb7371 100644
> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -16,7 +16,7 @@ DEFAULT_TEST_TARGET ?= test
>  TEST_LINT ?= test-lint-duplicates test-lint-executable
>  
>  ifdef TEST_OUTPUT_DIRECTORY
> -TEST_RESULTS_DIRECTORY = $(TEST_RESULTS_DIRECTORY)/test-results
> +TEST_RESULTS_DIRECTORY = $(TEST_OUTPUT_DIRECTORY)/test-results
>  else
>  TEST_RESULTS_DIRECTORY = test-results
>  endif
