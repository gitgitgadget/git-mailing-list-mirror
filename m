From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 6/6] status: add missing blank line after list of "other" files
Date: Fri, 06 Sep 2013 11:56:36 -0700
Message-ID: <xmqqzjrpwzh7.fsf@gitster.dls.corp.google.com>
References: <vpq38phsvuc.fsf@anie.imag.frvpq38phsvuc.fsf@anie.imag.fr>
	<1378489389-25802-1-git-send-email-Matthieu.Moy@imag.fr>
	<1378489389-25802-7-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqbo45yfm5.fsf@gitster.dls.corp.google.com>
	<vpqmwnprdpy.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Sep 06 20:57:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI1DL-000532-1A
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 20:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868Ab3IFS4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 14:56:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34190 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800Ab3IFS4s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 14:56:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A37F33F160;
	Fri,  6 Sep 2013 18:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KdYOypeCy7MBpRuRGGvOuprdbA0=; b=i+uGbs
	UsP9BI1bNUp44sFB8MYslQIdOMrvTJbHoVgGcVx4Rhxn3pW2yLubXpgBf+g3fZMh
	GuU8KKueM+IXGQtZ4B5TPuZxpZJ4au4QW9COy9Ts01oX0Z/cLasv53Zw8WeL7RdW
	zEiFXLgDe3B2qAvQGiDjc2JEdbnxLp2V3ACA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pAAhYmHAMqlJT7JdoPE7IS7DU7vS019j
	5xphyVIGB396KBYRX4Onfgc+/i6Kp6wI4ZAjOdSqSjE8hszK3r1tdiOjCLNr+qn3
	q2fljnRJOpMTMBaZhkzfrB7BxHRLGOwWvpSDtk7p253OjwSjWko/4QciQcs1BC+K
	1sK+OEkrT/I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F35F3F15F;
	Fri,  6 Sep 2013 18:56:47 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B3A73F157;
	Fri,  6 Sep 2013 18:56:45 +0000 (UTC)
In-Reply-To: <vpqmwnprdpy.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	06 Sep 2013 20:45:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 13C1280E-1726-11E3-9CA3-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234086>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>>
>>> List of files in other sections ("Changes to be committed", ...) end with
>>> a blank line.
>>
>> It is not like we want to add a blank line at the end of each
>> element; it is rather that we want to have a blank line between each
>> element, so that they can have a bit of breathing room between them.
>
> Well, "between each element, and at the end of the output" sounds a lot
> like "after each element" ;-).

There is a difference between terminator and separator semantics.

LF is a line terminator; it is attached to the end of each line, it
does not come between each pair of adjacent lines. Hence a text file
ends with a LF.

A blank line that separates each C function in our sources is a
separator.  That is why a patch that does

	@@ -99,3 +99,8 @@ int false(void)
	 {
	 	return 0;
	 }
	+
	+int true(void)
        +{
        +	return 1;
	+}

does not add a trailing blank line at the end.

And I am saying that the blank lines in "status" output should be
separators, not terminators of sections.

But see the other message.
