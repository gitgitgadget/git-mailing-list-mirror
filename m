From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/7] Documentation: put blame/log -L in sticked form
Date: Wed, 30 Oct 2013 10:09:28 -0700
Message-ID: <xmqqiowed6t3.fsf@gitster.dls.corp.google.com>
References: <21f40508f83a9407986d29f002adf5ad366c8b88.1382287779.git.trast@inf.ethz.ch>
	<c41aef218951f8b0ec6a20e1dbc39712ad13afce.1383031141.git.tr@thomasrast.ch>
	<xmqqvc0fd0la.fsf@gitster.dls.corp.google.com>
	<87bo27i85i.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Wed Oct 30 18:09:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbZGx-000418-Dm
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 18:09:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242Ab3J3RJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 13:09:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59854 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627Ab3J3RJb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 13:09:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AAD14D4C9;
	Wed, 30 Oct 2013 13:09:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ngiGRx0BpzEId9UQU8kdRo0byvQ=; b=iWix1N
	5tlaSo5ZL3uKDd0jUxBkHCFfApzS7AJVgM0RKsOsQhKARnzrO8X7K2n56pGN6hfp
	Whk1ZPN1WIH7bplr/hiCs69SNaUfQb5beoXJGKxvd80wpVSn9UVnC80ueMWq4K1X
	WexDYQFXvAt92xsL6TSNHRg2sRik3hZzyBIJA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xt78cvX1WnB1BzFSvWZuKIU4cW1tZnHU
	G9mviEe+UP1U9qhntdPXqElQQ1OaSAKr0SqcABWWR+Zh5sgoHdWaKzmgDiqrxih9
	KbS+7mLVge0tukwobruzTp681CtEDPBd9/DTK1sB7tlSySLiV766eIDKDhWEwaxB
	apLdtv/fUqY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A3A74D4C8;
	Wed, 30 Oct 2013 13:09:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E23C34D4C3;
	Wed, 30 Oct 2013 13:09:29 -0400 (EDT)
In-Reply-To: <87bo27i85i.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Wed, 30 Oct 2013 07:29:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 09EF64A0-4186-11E3-833E-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237037>

Thomas Rast <tr@thomasrast.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Thomas Rast <tr@thomasrast.ch> writes:
>>
>>> The next patch will document gitk -L, but gitk does not understand the
>>> separated form ('gitk -L :foo:bar' results in an error).  Spell
>>> git-blame and git-log -L, which are supposed to be "the same" option,
>>> without the spaces to prevent confusion.
>>
>> I agree that this patch may reduce confusion locally, but if we were
>> to go in this direction, we should be consistent and enforce "stuck"
>> form everywhere, not just the options you happened to have passed
>> thru to gitk, but other options such as "-S <revs-file>", and also
>> other commands that do not have anything to do with gitk (e.g. "git
>> commit -C<commit>", not "git commit -C <commit>".  Otherwise you
>> will give a wrong impression to readers as if they have to remember
>> which ones need to use the stuck form and which ones do not.
>
> Hmm.  Do you want to go there?

Absolutely not ;-)

But that unpleasant place would be the logical conclusion where this
patch leads us to, I would have to say. I was hoping that there is
an alternative solution to avoid that.

For example, gitk's parseviewargs is very well aware of the options
it supports, and it goes through the argument list one by one,
acting on what option it is looking at. Couldn't it be extended to
handle options with stuck and unstuck form?  After all, it has to
know that "-L" and "-S" are supported options; it wouldn't be too
much to ask for the parser to also know that "-L" eats the next
token (i.e. pass the pair <"-L", next token> intact as two separate
args to the underlying "log") while it can pass "-L?*" as is, no?
