From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] Add test_harness make target for testing with
 prove(1)
Date: Fri, 07 May 2010 20:58:06 -0700
Message-ID: <7vwrvfcaep.fsf@alter.siamese.dyndns.org>
References: <1273261025-31523-1-git-send-email-avarab@gmail.com>
 <1273261025-31523-6-git-send-email-avarab@gmail.com>
 <m339y3forb.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 08 05:59:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAbCC-00061i-As
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 05:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127Ab0EHD6S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 23:58:18 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41013 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab0EHD6R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 23:58:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6928EB1517;
	Fri,  7 May 2010 23:58:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=RxOo6ZNc4wea
	IjIY178bFOPW4Ck=; b=ZiVa0tWRSAwD38rX+s0peuwvcDb73XjV8E5EaugiX0j0
	qeONYP0Gx3Z824lcpYgEAXeOrH0Xe6A/PDvO22MifTP1fy0SjTmI8t9cnPC+3Puv
	3MbQdttAaEq0AFP1Kakd490vvDJeH0as0RcExQWUyRbZZzMdogfPwGQ2798re7E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=I9DcfA
	E04jdjvU07dwnswv0l5GqKk6wVCY2HMfH3+ao8KSGZbhiwDnAh8ZkTzjP3UcAk0X
	qVcNcOBiY2gCy80Nig+XruiM9tIE76aYEONW9W0FZm0Ck+VtUsEwghg1FkuLZVaP
	t+U8k6Ympa8LdrjVqwYeuvO29urFpvTn6P/zM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F557B150F;
	Fri,  7 May 2010 23:58:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F302B150C; Fri,  7 May
 2010 23:58:07 -0400 (EDT)
In-Reply-To: <m339y3forb.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Fri\, 07 May 2010 13\:20\:28 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EBF110CC-5A55-11DF-8E8B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146632>

Jakub Narebski <jnareb@gmail.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> The --jobs option I'm supplying to prove(1) is not supported in all
>> prove versions, some older ones (before Perl 5.10.1) don't have
>> it. Anyone that's hacking Git probably has 5.10.1, and you can alway=
s
>> use the old `make test` for non-parallel tests.
>
> I am hacking Git, and I don't have perl >=3D 5.10.1.  On the other ha=
nd
> I can alway run "make test" or individual tests instead of=20
> "make test_harness".
>
> A better solution would be to check Perl version, or even better of
> "prove" supports '--jobs' option, and selectively enable parallel
> running of test harness in Makefile.

Besides, "make -j15 test" from the toplevel already runs the tests in
parallel.  I don't see much point in this change.
