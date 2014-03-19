From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2014, #03; Fri, 14)
Date: Wed, 19 Mar 2014 10:04:37 -0700
Message-ID: <xmqqlhw65dcq.fsf@gitster.dls.corp.google.com>
References: <xmqqlhwcfn4a.fsf@gitster.dls.corp.google.com>
	<53240C0F.2050204@web.de>
	<xmqqha6wg3o1.fsf@gitster.dls.corp.google.com>
	<906CACC0-FB16-4BB8-812D-59067DE0CC89@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Mar 19 18:04:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQJv6-0002Pg-R4
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 18:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934327AbaCSREm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Mar 2014 13:04:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64344 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933574AbaCSREl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Mar 2014 13:04:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B765473D7E;
	Wed, 19 Mar 2014 13:04:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/CW9XqRY0e5j
	4Enfpd2NKmIvJL4=; b=gclYD26nKyT8pOJuLbW8zLYvJ3u8MVghGcKEK9XsaTNJ
	fsA677TgTvlvAKD2SX8K+VCtmu3d9jyfR3XpdeZwpOizkNujCKERRhtrJtBreUMW
	qbizeZkjF4rqa5Z7Dh/i24RKhNTqI4Yce1OhqN4UGvChMD2E5WpIbvkfqdvUcY0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sP6vJ9
	4i5Jsgh5llfPJBVFB8cugh5i5P9X2z+1CdQM7XyHvPcqnfskDxa27XIz5Yx2MWc5
	QI4zRyVY7H/lrMqCszRWVat8ul/v0ul41qVzCvD1lwXJVytXuLLAMprC3sDc6NxA
	pSW1fbpDe/DXD24giXx76DkYyk1uNmOjieZjA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A360773D7D;
	Wed, 19 Mar 2014 13:04:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5FF573D79;
	Wed, 19 Mar 2014 13:04:39 -0400 (EDT)
In-Reply-To: <906CACC0-FB16-4BB8-812D-59067DE0CC89@quendi.de> (Max Horn's
	message of "Wed, 19 Mar 2014 11:53:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8EC45292-AF88-11E3-AB02-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244460>

Max Horn <max@quendi.de> writes:

> On 17.03.2014, at 18:01, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>>=20
>>> On 2014-03-14 23.09, Junio C Hamano wrote:
>>>> * ap/remote-hg-skip-null-bookmarks (2014-01-02) 1 commit
>>>> - remote-hg: do not fail on invalid bookmarks
>>>>=20
>>>> Reported to break tests ($gmane/240005)
>>>> Expecting a reroll.
>>> I wonder what should happen here.
>>> The change breaks all the tests in test-hg-hg-git.sh
>>> (And the breakage may prevent us from detecting other breakages)
>>>=20
>>> The ideal situation would be to have an extra test case for the pro=
blem
>>> which we try to fix with this patch.
>>>=20
>>> Antoine, is there any way to make your problem reproducable ?
>>> And based on that, to make a patch which passes all test cases ?
>>=20
>> After re-reading the thread briefly (there're just five messages)
>>=20
>>  http://thread.gmane.org/gmane.comp.version-control.git/239797/focus=
=3D240069
>
> For some reason, that link does not contain all messages from that
> conversation (unfortunately, I have seen GMane do that on multiple
> occasions. I hence try not to rely on it for reviewing email
> history -- I just don't trust it). In particular, it misses this
> crucial post:

[jc: please avoid overlong lines; I re-flowed above]

>   http://thread.gmane.org/gmane.comp.version-control.git/239830

Interesting.

> The (or at least "a") root cause has actually been
> discovered. Would a patch that adds an xfail test case for it be
> acceptable?

Do you mean a patch that only adds a new test that expects a failure
to the current code, without touching the current code that has the
bug it exposes?  That would be a good place to start.

> ... As a matter of fact, I a know a few more bugs in remote-hg for
> which I could produce xfail test cases. Of course I'd prefer to
> put them in together with a fix, but I don't know when I can get
> to that, if ever. So, would such changes be welcome?

Surely.  That is to keep tabs on bugs in an actionable form; it is a
better way of bug tracking than having a bug-tracker that is not
actively maintained, I would think.
