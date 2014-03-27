From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] test-lib: Document short options in t/README
Date: Thu, 27 Mar 2014 09:35:43 -0700
Message-ID: <xmqqd2h7fvkw.fsf@gitster.dls.corp.google.com>
References: <1395650987-5960-1-git-send-email-ilya.bobyr@gmail.com>
	<1395650987-5960-2-git-send-email-ilya.bobyr@gmail.com>
	<5330196A.3030101@ramsay1.demon.co.uk> <53306910.3090807@gmail.com>
	<xmqqior2mbtx.fsf@gitster.dls.corp.google.com>
	<5333F1E6.5060009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 17:36:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTDHl-0003bm-1x
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 17:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175AbaC0QgC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 12:36:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63773 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754761AbaC0QgA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 12:36:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27F6B76E38;
	Thu, 27 Mar 2014 12:36:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MVVNRyUHdyD8vNG9WevP5VRLxVw=; b=Kb4J04
	kjdnr6GLuW/iTMBUTllypvUzjkKiVMxQaRzWQ0GqqEZOYmXDI2G51S1DXzkMjf2I
	a688FaZD7yHbG5wfYF9mcQEOE6DB0wXHxOjUbPlzmD5d3AD3yrjQh28VHM2Ce5Mo
	o4vhYGOIYV8sDqY3AomYuem8X9yaYglzHQpQo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IlbC1K762W1vF7Xjk6ylaywV0xOC68RA
	IHKQri5WYnE8QWLwsBLOvOFvM4wVqfv4MLiI3/oKNeA9deevBxlf9pgISYKpiz54
	1GTJ3aw6/odK97YKb7UUtl/GRYLSDS2e2pDIG4C9G8fqEQOHq9Hs874aQFzqnJ3w
	rn1Xno0TOx8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15D8676E35;
	Thu, 27 Mar 2014 12:36:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 547F676DE5;
	Thu, 27 Mar 2014 12:35:45 -0400 (EDT)
In-Reply-To: <5333F1E6.5060009@gmail.com> (Ilya Bobyr's message of "Thu, 27
	Mar 2014 02:39:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D85442DC-B5CD-11E3-8D9E-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245290>

Ilya Bobyr <ilya.bobyr@gmail.com> writes:

> If there is decision on how shortening should work for all the
> options, maybe I could add a paragraph on that and make existing
> options more consistent.

We should strive to make the following from gitcli.txt apply
throughout the system:

 * many commands allow a long option `--option` to be abbreviated
   only to their unique prefix (e.g. if there is no other option
   whose name begins with `opt`, you may be able to spell `--opt` to
   invoke the `--option` flag), but you should fully spell them out
   when writing your scripts; later versions of Git may introduce a
   new option whose name shares the same prefix, e.g. `--optimize`,
   to make a short prefix that used to be unique no longer unique.

> If so, '--valgrind' becomes impossible to shorten because there
> is '--valgrind-only' that is a separate option.  Same for
> '--verbose'  and '--verbose-only'.

Correct.  If you really cared, --valgrind={yes,no,only} would be (or
have been) a better possibility, though.
