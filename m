From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 11/11] Documentation: add documentation for 'git interpret-trailers'
Date: Mon, 07 Apr 2014 15:00:11 -0700
Message-ID: <xmqqr458ls0k.fsf@gitster.dls.corp.google.com>
References: <xmqqk3b4ogwu.fsf@gitster.dls.corp.google.com>
	<CAP8UFD38TE=5zxvkDvLRsDTpC6zDo6EN5q_HJMQPbUBcfJVsSg@mail.gmail.com>
	<xmqq4n25nkt0.fsf@gitster.dls.corp.google.com>
	<20140407.205800.839733420387302333.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: christian.couder@gmail.com, jrnieder@gmail.com,
	git@vger.kernel.org, josh@joshtriplett.org,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Apr 08 00:00:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXHaZ-0002Zb-QO
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 00:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687AbaDGWAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 18:00:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40040 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753119AbaDGWAO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 18:00:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D5167BFB4;
	Mon,  7 Apr 2014 18:00:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XltICT5Soh7t8Ybaknq9s8ZFxUQ=; b=CIp7dM
	HfU19oFlbZkCdYVd/XRkmykmBjN0uCAV4xn1Qs4Zk+A3jdvS0SWgx4aikeS6qwow
	FWAflUl3zgAzh/L9QcL4kVtzEs2MpVKY82A+C5DVREgPPb0/25QEmzbg9VZPR1M/
	q4bdtId6V5QmVCQdkikb4Y92fNoG4jPot5e5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oMms28Ze7uALMlOu8f69Oa1pK9XMpzne
	LSK7ZOXHqN+y/ZMHMTxAiQg/7xR0co4fz5ddAzI2RVam8V3MZ/sJv8IugmGX2WBl
	fMhz7XA6B7/2JA5m1bb2fifZrM9ndXPcEiSQq0mJehewMwlD5+YZvHbqvCCuo45E
	EIud6EUk02I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 168497BFB3;
	Mon,  7 Apr 2014 18:00:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7E737BF94;
	Mon,  7 Apr 2014 18:00:12 -0400 (EDT)
In-Reply-To: <20140407.205800.839733420387302333.chriscool@tuxfamily.org>
	(Christian Couder's message of "Mon, 07 Apr 2014 20:58:00 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FE6E32FE-BE9F-11E3-80CE-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245909>

Christian Couder <chriscool@tuxfamily.org> writes:

> From: Junio C Hamano <gitster@pobox.com>
>>
>> A different way to sell a colon, e.g.
>> 
>>     Consider the instruction sed takes on its command line.
>>     (e.g. "sed 's/frotz/nitfol/' <xyzzy").  In the most general
>>     form, you would always give it as the value of an '-e' option
>>     (e.g. "sed -e 's/frotz/nitfol' <xyzzy"), but you are allowed to
>>     be loose in limited occassions.  "Key:value" is like that, and
>>     in the most general form, it actually needs to be spelled as
>>     "-e 'Key:value'".
>> 
>> is possible, but I do not think it is a particularly good analogy,
>> because what you have as the alternative is "Key=value", and not
>> "-e 'Key:value'", or "--Key=value" (the last would probably be the 
>> most natural way to express this).
>
> The analogy that I would use is rather that Perl lets people use
> 's:foo:bar:' as well as 's=foo=bar=' instead of 's/foo/bar/' if they
> prefer.

I could *almost* buy that, but that does not hold as you are not
allowing (and I do not think you need to in this case) the user to
pick any termination character like "s|foo|bar|".  The only thing
you are doing is forbidding both ":" and "=" from the set of allowed
characters for labels.

However.

I think we could buy the syntax if the "Key:value" form were the
*only* form, *without* accepting "Key=value".

The latter is a poor attempt to pretend as if it is a normal command
line option, but because that form does not even take double-dashes
at the beginning, it even fails to mimic as a command line option.

It would be one way to reduce the unnecessary cognitive load from
the users when learning the Git command line argument convention to
reject the "key=value" form and only stick to "key: value" form.
After all, because of the shape of the footer we add to the log
message (i.e. a keyword label followed by a colon followed by a SP
followed by the value), it is clear that we can use ":" as the
separator without inconveniencing the users who want to use some
unusual characters in the label part, but there is no strong reason
to reject an equal sign in the label.
