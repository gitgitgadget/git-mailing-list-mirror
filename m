From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] trailer: add examples to the documentation
Date: Mon, 28 Apr 2014 15:12:51 -0700
Message-ID: <xmqqbnvlnlwc.fsf@gitster.dls.corp.google.com>
References: <20140427200327.16880.53255.chriscool@tuxfamily.org>
	<20140427201238.16880.7144.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 00:13:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WetnQ-0004fo-Rz
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933387AbaD1WM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 18:12:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65413 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932661AbaD1WM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 18:12:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1267581673;
	Mon, 28 Apr 2014 18:12:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OAZiGMC1Gz30D5jNqtSOrnIz18M=; b=f0THWz
	Q/Az7bN1obsR318G6ey2+q3SwP3sHZjMXCDlOsZNBjN+AXxzzqcLzdhSPLBKe/DL
	vKkd9279Z8oMXWfzaCGwjEWe/1k2lau7JLfAdWINM7ka/PKJZ9D/USwZg1Z04+3T
	V8n0FAtsrVPXuCXs52KJ7snJyjr7kXCK2sNd0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LRGalwtpseah5nnNUZwQoHFPEL3UK5wO
	g4FG8ZiKkd72cUrHipEzzjDaMDjsNw05gUdVH2TX73I0U0vEBDqM4RKQwXlwbWwx
	ttDFfhHsp4+cdAUximVgwDFBZhvOTzf5oDUzHMciRVkgAH6+nndZ1uRqHCzb2wY8
	77KQHlgKihA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D88CF81672;
	Mon, 28 Apr 2014 18:12:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A2EE8166D;
	Mon, 28 Apr 2014 18:12:53 -0400 (EDT)
In-Reply-To: <20140427201238.16880.7144.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sun, 27 Apr 2014 22:12:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3E680ED8-CF22-11E3-B208-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247459>

Christian Couder <chriscool@tuxfamily.org> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-interpret-trailers.txt | 98 +++++++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 1 deletion(-)

Very good to have these examples.  They seem to be clearly written.

Having said that, this part made me go "Huh" for a few reasons.

> +* Configure a 'fix' trailer with a command to show the subject of a
> +  commit that is fixed, and show how it works:
> ++
> +------------
> +$ git config trailer.fix.key "Fixes #"
> +$ git config trailer.fix.ifExists "overwrite"
> +$ git config trailer.fix.command "git log -1 --oneline --format=\"%h (%s)\" --abbrev-commit --abbrev=14 \$ARG"
> +$ git interpret-trailers <<EOF
> +> subject
> +> 
> +> message
> +> 
> +> fix: HEAD~2
> +> EOF
> +subject
> +
> +message
> +
> +Fixes #fe3187489d69c4 (subject of fixed commit)
> +------------

 - It makes it appear that we have a convention to prefix "#" when
   talking about a commit object name, but that is not what we
   recommend to do.  Do some projects refer to commit object names
   that way?

 - It has been my impression that "#123456", when people talk about
   "Fixes #123456", refers to a bug ID in some tracking system, and
   the scenario the example sets up "show the subject that is fixed"
   would not help those who want to have such a linkage between bug
   ID and fix.

I however do not think of a good mechanised way to fill in the bug
ID with script [*1*].  I suspect (but I am thinking aloud and am
open to better alternatives) it would be better to change this
example *not* to show use of trailer.*.command but have it just take
the bug ID literally to make it a demonstration that the trailer
does not have to end with "key: ".  We can of course have your
example to turn a commit object name to human readable one-liner as
a separate one to illustrate how to use trailer.*.command, but I do
not think it is a good idea to call it "Fixes", as that may invite
confusions with a bug ID people would expect to see.


[Footnote]

*1* A workable project convention may be to document an existing bug
    in a test-suite and detect a commit that fixes the bug, e.g.

    - Document an expected-to-fail bug like so:

      test_expect_failure 'bug #123456' '
	... demonstrate breakage ...
      '

      when it is noticed to keep track of it.


    - A commit that fixes the bug will have a hunk:

      -test_expect_failure 'bug #123456' '
      +test_expect_success 'bug #123456' '

      and the trailer.fix.command can examine "git show" output of
      the proposed commit to detect that hunk and extract "bug #"
      from there.

    Of course that is not _the_ single best convention, and it would
    be too big for an example in this documentation.
