From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] remote-helpers: move tests out of contrib
Date: Mon, 21 Apr 2014 11:36:56 -0700
Message-ID: <xmqq7g6ia5rr.fsf@gitster.dls.corp.google.com>
References: <1398029971-1396-1-git-send-email-felipe.contreras@gmail.com>
	<1398029971-1396-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 20:37:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcJ5q-0002nQ-Tf
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 20:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489AbaDUShV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 14:37:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38772 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753121AbaDUShT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 14:37:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B13327E530;
	Mon, 21 Apr 2014 14:37:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=be7Ls3BkaWXIZeh5QucjeZVhB2A=; b=DpJ8kZ
	ZOTMueTFYa6q+oDQywcYVMzdns1csZ2SniNkwEoCjl02VZr/b/I8siFpBH327hbb
	57xkAmvvOFmJyiI5ykI2XvwxwuTh3vn39d8B2vH7TeLj5AEGqYyuq+3213b7lUXA
	eoCyJAHodHenlKcLIIWk82aAF8NzB1xicjYvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vBQqiVaZgDwCCwR0W5P0akWLLapn5R9Y
	QgNdZ6RcsU7ntN/Bi2OGv/OAZmOGF3kS4CvyPIFSEXdu/0w/9FmWh+ImSwraKtto
	qvBBlgJirzaDz+Xg6kjh7Dfq5K8vi7qohTPZbTYDEpjIjucqe/tIaGIRsUjmOvO4
	U6R+2aXN0Yk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 938DA7E52E;
	Mon, 21 Apr 2014 14:37:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8B557E4FF;
	Mon, 21 Apr 2014 14:36:58 -0400 (EDT)
In-Reply-To: <1398029971-1396-3-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sun, 20 Apr 2014 16:39:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EBEC6A08-C983-11E3-8C4B-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246616>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> They should be tested by default.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/Makefile                            | 14 --------------
>  t/Makefile                                                 |  8 +++++++-
>  .../remote-helpers/test-bzr.sh => t/remote-helpers/bzr.t   |  2 +-
>  .../test-hg-bidi.sh => t/remote-helpers/hg-bidi.t          |  2 +-
>  .../test-hg-hg-git.sh => t/remote-helpers/hg-hg-git.t      |  2 +-
>  contrib/remote-helpers/test-hg.sh => t/remote-helpers/hg.t |  2 +-
>  6 files changed, 11 insertions(+), 19 deletions(-)
>  delete mode 100644 contrib/remote-helpers/Makefile
>  rename contrib/remote-helpers/test-bzr.sh => t/remote-helpers/bzr.t (99%)
>  rename contrib/remote-helpers/test-hg-bidi.sh => t/remote-helpers/hg-bidi.t (98%)
>  rename contrib/remote-helpers/test-hg-hg-git.sh => t/remote-helpers/hg-hg-git.t (99%)
>  rename contrib/remote-helpers/test-hg.sh => t/remote-helpers/hg.t (99%)
>
> diff --git a/contrib/remote-helpers/Makefile b/contrib/remote-helpers/Makefile
> deleted file mode 100644
> index 239161d..0000000
> --- a/contrib/remote-helpers/Makefile
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -TESTS := $(wildcard test*.sh)
> -
> -export T := $(addprefix $(CURDIR)/,$(TESTS))
> -export MAKE := $(MAKE) -e
> -export PATH := $(CURDIR):$(PATH)
> -export TEST_LINT := test-lint-executable test-lint-shell-syntax
> -
> -test:
> -	$(MAKE) -C ../../t $@
> -
> -$(TESTS):
> -	$(MAKE) -C ../../t $(CURDIR)/$@
> -
> -.PHONY: $(TESTS)
> diff --git a/t/Makefile b/t/Makefile
> index 8fd1a72..818f4ed 100644
> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -14,6 +14,7 @@ RM ?= rm -f
>  PROVE ?= prove
>  DEFAULT_TEST_TARGET ?= test
>  TEST_LINT ?= test-lint-duplicates test-lint-executable
> +export TEST_DIRECTORY = $(CURDIR)
>  
>  ifdef TEST_OUTPUT_DIRECTORY
>  TEST_RESULTS_DIRECTORY = $(TEST_OUTPUT_DIRECTORY)/test-results
> @@ -29,6 +30,9 @@ TEST_RESULTS_DIRECTORY_SQ = $(subst ','\'',$(TEST_RESULTS_DIRECTORY))
>  T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
>  TSVN = $(sort $(wildcard t91[0-9][0-9]-*.sh))
>  TGITWEB = $(sort $(wildcard t95[0-9][0-9]-*.sh))
> +TREMOTE = $(wildcard remote-helpers/*.t)

This step needs a bit more work, I am afraid, to at least have these
three test scripts follow the same numbering scheme.  Especially given
that there were recent discussions on allowing a range of tests to
be run (or omitted) via notations like "5000,5020,9800-9812", not
doing so now will make it harder to implement such an enhancement.

Also, I noticed that, unlike say t9801 that shows this:

    $ cd t && make T=t9801-*sh prove
    rm -f -r 'test-results'
    *** prove ***
    t9801-git-p4-branch.sh .. skipped: skipping git p4 tests; no p4 or p4d
    Files=1, Tests=0,  0 wallclock secs ( 0.03 usr  0.00 sys +  0.00 ...
    Result: NOTESTS

these are unnecessarily noisy when refusing to run:

    $ cd t && make T=remote-helpers/bzr.t prove
    *** prove ***
    remote-helpers/bzr.t .. Traceback (most recent call last):
      File "<string>", line 1, in <module>
      File "/usr/local/buildtools/current/sitecustomize/sitecu...
        return real_import(name, globals, locals, fromlist, level)
    ImportError: No module named bzrlib
    remote-helpers/bzr.t .. skipped: skipping remote-bzr tests; bzr not available
    Files=1, Tests=0,  0 wallclock secs ( 0.03 usr  0.00 sys +  0.02 ...

Can we squelch these expected import error messages?

Thanks.
