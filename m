From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Index format v5
Date: Thu, 03 May 2012 13:32:39 -0700
Message-ID: <7vr4v1dmzc.fsf@alter.siamese.dyndns.org>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
 <7vd36lf634.fsf@alter.siamese.dyndns.org> <87pqalgiyv.fsf@thomas.inf.ethz.ch>
 <87k40tgix2.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gummerer <t.gummerer@gmail.com>, <git@vger.kernel.org>,
	<mhagger@alum.mit.edu>, <peff@peff.net>, <spearce@spearce.org>,
	<davidbarr@google.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 03 22:32:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ2hn-000112-Lw
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 22:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758702Ab2ECUcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 16:32:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55212 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758669Ab2ECUcm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 16:32:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51B6B6EE0;
	Thu,  3 May 2012 16:32:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M77rAYTGeDezuhd4IeY3Lwu/o70=; b=HeSWTE
	yKwTZTq3ZUeuM9Fru/qvv1pYltV015iY0cPc7S9QGtDavJT4ZKAWKibWTmmsXA17
	VgkEKqscCRrx84XiAS4pMlCWepYF1lH0PRQKhVkycs2LGA6abTpfyCuyqrq0Thtk
	tzxlN9XktY1jWCjkmLm7jM8pJnVQprZmvXfi4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SODgKu0sdR1PgfT1VgG/1GtDDLNX5GZN
	4w0yNSQdnVxKutuLDbOQ0FZlMaK1rDh5aY8rDNeuyh2M15Ich+cjq307tkvAQpgf
	xmAGdeamh+l57R6FLnBVQ07kDQYDyZ60x6Cu/fcKHyLTH10j7XSP+mGmHNHJsRZg
	8UsbbocjvPM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47E316EDF;
	Thu,  3 May 2012 16:32:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7AE86ED4; Thu,  3 May 2012
 16:32:40 -0400 (EDT)
In-Reply-To: <87k40tgix2.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Thu, 3 May 2012 21:32:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 211A92F0-955F-11E1-ADA7-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196955>

Thomas Rast <trast@student.ethz.ch> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> Comparisons for equality never have false negatives with any hash
>> function.  Collisions are false positives.
>
> Bah, shouldn't hit "send" so fast.  There goes my karma :-D

Heh, don't take "karma" thing too seriously. I was merely trying to be
funny and I seem to have failed the attempt.

It depends on what question you are asking, and against "Did this change?"
question, saying "No, it didn't" when the right answer is "Yes, it did" is
a false negative.  You are asking for a false negative if you substitute
byte-for-byte comparison with comparison of hashed results of the values
that needs to be compared.

But as I said, mtime is the primary thing that protects us, so it may not
be such a big deal.
