From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/5] test-lib: Adjust output to be valid TAP format
Date: Fri, 25 Jun 2010 10:21:57 -0700
Message-ID: <7v6317koy2.fsf@alter.siamese.dyndns.org>
References: <AANLkTinVp6kivNzbdUj-7EXjKrolBqvtsNROo-dCSydn@mail.gmail.com>
 <1277416332-12072-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 19:22:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSCbW-0002dh-O3
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 19:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756568Ab0FYRWJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jun 2010 13:22:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51383 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756566Ab0FYRWI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jun 2010 13:22:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 67B13BDDB3;
	Fri, 25 Jun 2010 13:22:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zoAk5ckt1tB/
	HApx53t+V8vR7AU=; b=pHoVEAtN2dNvV6LG50tX+9jOOq571hm8NFdMqFgPWNJe
	dlKugn/0PnOV9U/ecNPXiilw4DPBzKbYyin/NoekGhNTC4L44jbkb/FMzvG4H5ht
	yCxGo4Oj12w0P7H4gYMaAeNq+OpibC2shSJk5oU/27pcycteR0GuEdVw1SJ/OgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kiCofR
	+K6gOY4tPDUuiRb7hHPW/sQb3mJrRpvaIXy5fqhaxC1dTHsJoDs71Xx8/NE1dBej
	O/dqjdYIXxmazTnWmIGPP90vAPBUH7VFBr9O2Ydm3ut2BoqZ4V2jF6J4pLBNu4aW
	g8q71ThtgUAAHQtdaqHVffnbBUE3PDNgkE/L4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 454B6BDDB2;
	Fri, 25 Jun 2010 13:22:02 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 963C8BDDB1; Fri, 25 Jun
 2010 13:21:59 -0400 (EDT)
In-Reply-To: <1277416332-12072-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu\, 24 Jun
 2010 21\:52\:12 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2B25E012-807E-11DF-AD71-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149698>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> diff --git a/t/README b/t/README
> index 0e4e8d8..aa4ed28 100644
> --- a/t/README
> +++ b/t/README
> @@ -18,25 +18,48 @@ The easiest way to run tests is to say "make".  T=
his runs all
> ...

This describes the general framework of tests from the point of view of=
 a
person who runs them and reads their output well.  I'll replace ab/tap
topic with these five patches.

I'd however like to ask you to update the sections in t/README to help
test writers.  You have gained enough experience with patches 4 and 5 (=
and
with patch 2 for Perl tests) to know what kind of script constructs, us=
ed
by people who are used to the old way of writing our tests, would cause
the TAP stuff to break, and are in the ideal position to rewrite that
section.  Two examples of what is drastically different from the old wo=
rld
order are "do not print to the standard output strings that begin with =
XX
(or partial lines)" and "here is how to skip the remainder of the tests=
",
but you may have a handful of more rules.  I expect that "Writing Tests=
"
through "Test harness library" sections would be affected.

Earlier I kept wondering if this series is worth the trouble.  Having t=
o
learn and follow the set of these new rules is exactly what I meant by
"trouble".  Let's make sure that the new rules are clear, small, and ea=
sy
to follow for other contributors.

Thanks.
