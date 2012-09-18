From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to create the " [PATCH 0/5]" first email?
Date: Mon, 17 Sep 2012 17:36:35 -0700
Message-ID: <7v7grsqi98.fsf@alter.siamese.dyndns.org>
References: <1347710524-15404-1-git-send-email-pclouds@gmail.com>
 <F93DBBE1DDAA44A28C9020F9A58FD825@PhilipOakley>
 <7vzk4rz00y.fsf@alter.siamese.dyndns.org>
 <98180D4AA94C468887029389CC535D4F@PhilipOakley>
 <7vfw6gqkfg.fsf@alter.siamese.dyndns.org>
 <20120918001522.GA10283@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 02:37:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDloA-0003uE-KJ
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 02:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756250Ab2IRAgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 20:36:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58872 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756234Ab2IRAgi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 20:36:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C37769D99;
	Mon, 17 Sep 2012 20:36:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jdiX0Gb9fgC0hEByQs9Q6hw1xAg=; b=tFmWGS
	M9IsUyJdtQcg/18TNAykRWFoBxZNsIMKF7mAnYDDR9BZqyL/8/diKyDbb/BPSCOe
	7Jv2V3VzuVFYc8Sb7jkR6L1aa0XmzC5SknksFfUzGFSnvi+D6y5QLZ3horFZ3IQc
	FHrxI8mL+6mGDz+L8pwFudQBRdA5jvSQWgec8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R2KcJYi+LUbQKBOPD+/wpNcjL7vB22LP
	Y4Xqo8CBDT1doeRxp0m6jm8fjqF2nY7jkcI1U+qyfn/QGksRntgxZnCzclF0e+24
	6SAgXpNiknabjoeH32qP2jGDelze/J3QJDHuHfqGrpLhJJDo2EJOJrqsjGW3R4xg
	Mb3rvSxM85E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF1A79D98;
	Mon, 17 Sep 2012 20:36:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE6919D96; Mon, 17 Sep 2012
 20:36:36 -0400 (EDT)
In-Reply-To: <20120918001522.GA10283@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 17 Sep 2012 20:15:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E78638CE-0128-11E2-95FC-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205774>

Jeff King <peff@peff.net> writes:

> On Mon, Sep 17, 2012 at 04:49:39PM -0700, Junio C Hamano wrote:
>
>> > However, when it came to creating the series, with comments, I
>> > couldn't see a way of having my comments within my local commits, but
>> > preparing a patch series that would properly include the '---'
>> > separator.
>> 
>> An unofficial trick that works is to write the
>> 
>>     ---
>> 
>>      * This is an additional comment
>> 
>> 
>> yourself when running "git commit".  That will be propagated to the
>> output from format-patch.  You will have another "---" in front of
>> the diffstat, but nobody is hurt by that.
>
> But note that using "format-patch -s" will break; it puts the sign-off
> below the "---".

I think "format-patch -s" is a workflow mistake in the first place.
You should be doing the sign-off the commit when you commit in the
first place.  It is not like "I cannot sign off because I think it
is still iffy" or anything.

But your point still stands; "commit -s" will not see through that
official trick either ;-).

>> But when doing a big series that deserves a cover letter [PATCH 0/n],
>> you will use editor on the output from format-patch anyway, and I
>> find it simpler to do the follow-on comments at that point myself.
>
> Me too (actually, I load it all into mutt and then comment on each as I
> send them out, but it amounts to the same thing, seeing as how my MUA
> just invokes $EDITOR when I edit a mail).
