From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Custom git completion
Date: Fri, 29 Jan 2010 10:02:51 -0800
Message-ID: <7vockciyb8.fsf@alter.siamese.dyndns.org>
References: <9b69cfcf1001290457s6b7fad6cs5a915f16a11f5782@mail.gmail.com>
 <20100129151127.GA21821@spearce.org>
 <7v4om4kdt3.fsf@alter.siamese.dyndns.org>
 <20100129175950.GE21821@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Rhodes Clymer <david@zettazebra.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 29 19:03:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NavBU-0007RD-8P
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 19:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298Ab0A2SDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 13:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753157Ab0A2SDB
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 13:03:01 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37120 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936Ab0A2SDA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 13:03:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A0DE395813;
	Fri, 29 Jan 2010 13:02:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h2+hEYx/Y0viMe4bYjoeNcWy02U=; b=SnOdQ2
	nFNV11ODaFUbE1xJ3842yhXqTiBxvi2G8jf/sHO6EXDdygNhHtb15tIirDrT1iSb
	w2+Yo3tQPixRVNwkFyCq6Fvikl19x0h0ejThiTTXdWvBtLJUdI2Kp8mMQi/rYlnj
	S+CHf2BEN67hWlplp34N/2A7k1GsPF6sSsmsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wzr4bbVU0xzafUuMYLbeF9X7OoSjYvGz
	4/i06CQmZy3izJmudurRnEGxdFiOUfEH7BvMzT9vc7ngiSqzEsa4rSF8O1O2VEjy
	Z6I5+EscpwraPzPW61z5Ufw+lM56/Nf79gzaEtrpOZGJPujRFblRwY3DpBhfVZbo
	tHzJTlNilCM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6239695811;
	Fri, 29 Jan 2010 13:02:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE5E59580D; Fri, 29 Jan
 2010 13:02:52 -0500 (EST)
In-Reply-To: <20100129175950.GE21821@spearce.org> (Shawn O. Pearce's message
 of "Fri\, 29 Jan 2010 09\:59\:50 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8730DF34-0D00-11DF-907F-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138332>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>> An alias that uses another git subcommand (i.e. the ones that do not start
>> with a bang "!") seems to be handled correctly, but one of my aliases is
>> this:
>> 
>>     [alias]
>> 	lgm = "!sh -c 'GIT_NOTES_REF=refs/notes/amlog git log \"$@\" || :' -"
>
> Doing this is difficult, because its hard to parse that string and
> do completion on it.

That is why I said it is unfair to expect completion code to do that.

>   [completion]
>   	lgm = log
>
> and have `git lgm` complete using the same rules as `git log`.

I actually like that.  It matches _my_ expectation as a user to be able to
say "this subcommand has args that look like those given to 'log'".
