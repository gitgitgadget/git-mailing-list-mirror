From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs: add filter-branch note about The BFG
Date: Tue, 17 Dec 2013 21:57:37 -0800
Message-ID: <xmqqr49ak8fi.fsf@gitster.dls.corp.google.com>
References: <1387277599-69719-1-git-send-email-roberto.tyley@gmail.com>
	<xmqqk3f3mjl5.fsf@gitster.dls.corp.google.com>
	<CAFY1edaEZzDUuG9kopbAp9h2Frc2aLRKkjKMUnpSonML2xZN=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jeff King <peff@peff.net>,
	tr@thomasrast.ch
To: Roberto Tyley <roberto.tyley@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 06:57:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtA8e-0005F2-HF
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 06:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975Ab3LRF5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 00:57:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47555 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817Ab3LRF5k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 00:57:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 949C351512;
	Wed, 18 Dec 2013 00:57:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0XU53nFTGaASnqtJ3EIxHXqi7ug=; b=R/PAkh
	L1g07ALF2YbFoPwFeOCMOXCfVykblHVvcASjOzwv9bWrY+df2QcDIg/7bqvioD08
	EK9Dgd0mXyxfwO7BMBpJsloN2OU5rycAemgO39DQKtTxVY8DplYUhk3+Ti24M8Dv
	IfbiyzFk9SQ5c0/n9uVNnvPGc0cwMTps/Zce8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CllBD/WNq0aloOerZrAluxZXUCz7m51I
	eyqKFBYYcFyH3yqxvZ0++p2B2D5ebKQOGKgsd5/l+06wQ2nqF3zn70QoaD7ra6y6
	tc0nIzoEHr2FgbbrSeexwBhBUEjbKqw6PL1IcpaJLRSQQdjeQ98lEak2yuaYr+Vq
	jUrCIVWzj7Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 805EB51511;
	Wed, 18 Dec 2013 00:57:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC37D51510;
	Wed, 18 Dec 2013 00:57:38 -0500 (EST)
In-Reply-To: <CAFY1edaEZzDUuG9kopbAp9h2Frc2aLRKkjKMUnpSonML2xZN=A@mail.gmail.com>
	(Roberto Tyley's message of "Wed, 18 Dec 2013 01:04:26 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4CE4F114-67A9-11E3-BFA5-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239424>

Roberto Tyley <roberto.tyley@gmail.com> writes:

> * The BFG takes advantage of multi-core machines, cleaning commit
> file-trees in parallel, which git-filter-branch currently does not do.
> * Any particular version of a file is cleaned exactly _once_. The BFG,
> unlike git-filter-branch, does not give you the opportunity to handle
> a file differently based on where or when it was committed within your
> history.
> * The link:http://rtyley.github.io/bfg-repo-cleaner/#examples[command-set]
> is much more restrictive than git-filter branch, and dedicated just to
> the tasks of removing unwanted data - e.g. `--strip-blobs-bigger-than
> 1M`.

I do not know offhand if the above formats well with AsciiDoc.  You
may have to do it like this:

* The first line of the bulletted paragraph is
  followed by the second and subsequent lines indented
  to align with the first one.

The first bullet point may be somewhat misleading, though.  Nothing
stops your script you use in filter-branch from processing blobs
belonging to a single tree in parallel---the user just needs to do a
bit more work to do so.

I think the second point is the most characteristic in BFG (and that
is what allows easy parallelization of the filtering).  Also, it
cannot be stressed enough that the "removing unwanted contents" use
case can take advantage of the "bad contents in a blob is bad, no
matter where in the tree and when in the history the blob appears".
That is what makes BFG particularly shine  for the use case. Its
design very much aligns the objective the use case wants to achieve.
