From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 17/17] Documentation: add documentation for 'git interpret-trailers'
Date: Mon, 27 Jan 2014 13:20:18 -0800
Message-ID: <xmqqfvo9nmul.fsf@gitster.dls.corp.google.com>
References: <20140126165018.24291.47716.chriscool@tuxfamily.org>
	<20140126170011.24291.26146.chriscool@tuxfamily.org>
	<CAPig+cQgq_2h+n8OeDsrmk_NqAA4RDNzkBAtNCNjOAGMrFN4jg@mail.gmail.com>
	<20140127.213344.212708599170084659.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sunshine@sunshineco.com, git@vger.kernel.org, johan@herland.net,
	josh@joshtriplett.org, tr@thomasrast.ch, mhagger@alum.mit.edu,
	dan.carpenter@oracle.com, greg@kroah.com, peff@peff.net
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Jan 27 22:20:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7tba-0001ae-AL
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 22:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429AbaA0VU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 16:20:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44134 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754233AbaA0VUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 16:20:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3058367EC1;
	Mon, 27 Jan 2014 16:20:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nU28CGD2YFCqv9zR1da5LwrsNGw=; b=TdcKCR
	zqLPdbo18v/qiiOLNyGnz/yza3zdTggIYVCMdVJL+fJUHikvOuCNeSGD48sWsDWp
	FOpWa0ykGR0FKrKH9EEbq4AvmCgGIzirGXRdftFTzW2fgumewNzuB/gYyjxwYXbW
	Crwc9aD7jVuuEqorI7t8M7dnti48RKXImfhX0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QD249FEzCfz6QYakLVvQ/Zz8WWFaEUHU
	rUaDmA0M+sxcvuXMqNOL2LqAU9pQjiudLh2zAIHdjtEYHl2OdiLy9Khn1GAa22q4
	tpWNhD8WmJWgHRDb4Wbi/uqskNLT2C+N+sTkHXyb6F/Ohwu0vT7gaQUGgJKyZPlq
	xX+ToSx9jU4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11DA667EC0;
	Mon, 27 Jan 2014 16:20:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F96767EBA;
	Mon, 27 Jan 2014 16:20:22 -0500 (EST)
In-Reply-To: <20140127.213344.212708599170084659.chriscool@tuxfamily.org>
	(Christian Couder's message of "Mon, 27 Jan 2014 21:33:44 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D4EEC490-8798-11E3-9F10-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241158>

Christian Couder <chriscool@tuxfamily.org> writes:

>>> +'git interpret-trailers' [--trim-empty] [--infile=file] [<token[=value]>...]
>> 
>> Would it be more consistent with existing documentation to format this as so?
>> 
>>   [--infile=<file>] [<token>[=<value>]]...
>
> No, it would be very inconsistent:
>
> $ grep '\.\.\.\]' *.txt | wc -l
> 103
> $ grep '\]\.\.\.' *.txt | wc -l
> 0

I have a feeling that you are missing the point Eric is making.  The
value given to the --infile option can be anything, i.e. 'file'
there is a placeholder, hence "--infile=<file>" not "--infile=file"
as you wrote.

Also I think "[<token>[=<value>]]..." is the correct way to spell
that there can be 0 or more "<token>[=<value>]".  "<token[=value]>"
in the original does not make any sense, as <> is meant to say "this
thing is a placeholder", and we do not try to say, with the string
inside <>, what shape that placeholder takes.  In fact '=' part is
_not_ a placeholder but is required syntactically when you want to
supply a value to the token, so the original doubly is incorrect.

I find it a bad taste to allow unbound set of <token> on the LHS of
'=' on the command line, but that is a separate issue in the design,
not in the documentation of the design.

Thanks.
