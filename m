From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] t/README: Document the dangers of printing "ok" /
 "not ok"
Date: Thu, 01 Jul 2010 10:16:36 -0700
Message-ID: <7vhbkj2kcr.fsf@alter.siamese.dyndns.org>
References: <1277997004-29504-1-git-send-email-avarab@gmail.com>
 <1277997004-29504-9-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 19:17:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUNO1-0001tS-Nr
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 19:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183Ab0GARQr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 13:16:47 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34269 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159Ab0GARQp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jul 2010 13:16:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 33102C0F26;
	Thu,  1 Jul 2010 13:16:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9OiqdwnUCCwE
	78RgOm9T3JLgPIg=; b=q1h4Hh3WP020QUMiVEUcUfjHj2bHe10NiFpDWO2i5lnN
	bZD+UxL25vI08kFJNPVCFkg3DYZh16q2cKQplT5Up8YFG+tjvSEdBGiUCSPtoY+7
	+K8wuWy+2Ly9DESM5ZGg8BqDzLP+oaw05A8MmRrE/317TSiEGLKjuFIFKxcQchk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yAccTK
	VcA/oVJiAXD4GvrW+BVgqqd9bH8upFUHJ3elybs2WFngly5tsAwMw1pcpKyt0TgK
	CBafIcJJxVa6ejrGMH58NJd/RBX2oSDN7NhJ9CYsDE9sMzzKjxmRMW1BxCylsnA4
	nU0nRIExWlzw4cfllqzF1rfXwowkxUT1mhzCg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EB6D0C0F24;
	Thu,  1 Jul 2010 13:16:40 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14927C0F23; Thu,  1 Jul
 2010 13:16:37 -0400 (EDT)
In-Reply-To: <1277997004-29504-9-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu\,  1 Jul
 2010 15\:10\:04 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6A1B40C2-8534-11DF-8090-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150059>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> index 42a4c25..29f795e 100644
> --- a/t/README
> +++ b/t/README
> @@ -50,6 +50,12 @@ prove and other harnesses come with a lot of usefu=
l options. The
>      # Repeat until no more failures
>      $ prove -j 15 --state=3Dfailed,save ./t[0-9]*.sh
> =20
> +The TAP support is completely incidental. A TAP harness is just a
> +program that interprets the "ok"/"not ok" (and some other strings) i=
n
> +a special way. The only limitation this imposes is that you shouldn'=
t
> +echo "ok" or "not ok" by yourself at the beginning of a line, that'l=
l
> +confuse the TAP harness.
> +

I think the above is not suitable for the target audience of the sectio=
n
("Running Tests"); they are not _writing_ tests.

This information (or an enhanced version of it) should come between
"Source 'test-lib.sh'" that talks about what the harness gives, and
"Skipping tests".  Perhaps name that to "Test your stuff".  An example.=
=2E.

    Test your stuff
    ---------------

    After sourcing test-lib.sh, you test the parts of the system using =
the
    test harness.  Your tests will be done in the <script> part of
    test_expect_success helper function, and the exit status of the las=
t
    command in that <script> signals the success/failure of a test.

    You are not supposed to "exit" from the <script> part; the harness
    will catch this as a programming error of the test.  Use test_done
    instead, if you need to stop the tests early (see "Skipping tests"
    below).

    Inside <script> part, the standard output and standard error stream=
s
    are discarded, and the test harness only reports "ok" or "not ok" t=
o
    the end user running the tests.  Under --verbose, they are shown to
    help debugging the tests.

    The output from the test suite is designed to be TAP compliant (see
    http://..... to learn more about TAP), to allow programs by other
    people to parse our output.  This further places restriction on wha=
t
    your tests can say to the standard output and standard error.  The =
TAP
    readers expect a line that begins with either "ok" and "not ok" to
    signal a test passed or failed (and our harness already produces su=
ch
    lines), so your script shouldn't emit such lines to their output.

I suspect the last paragraph needs a bit more work.  For example, don't
you have some restriction not to say things like "1..43"???
