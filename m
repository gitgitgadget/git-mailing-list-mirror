From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] t/t5705-clone-2gb: change from skip_all=* to prereq
 skip
Date: Wed, 11 Aug 2010 11:32:22 -0700
Message-ID: <7viq3hxao9.fsf@alter.siamese.dyndns.org>
References: <1281469968-25670-1-git-send-email-avarab@gmail.com>
 <1281469968-25670-3-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 20:33:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjG6w-0002K0-Cf
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 20:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327Ab0HKSce convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 14:32:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47621 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755313Ab0HKScd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 14:32:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 07C13CC3FA;
	Wed, 11 Aug 2010 14:32:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=gbZFQMgi+sVXzhswIcfYDS+8y
	i8=; b=RHmm+HxyGIUiWdNTcHpKFS0jeRRkBXLLqz8h9EvVLj4U1S21BQeEx0n95
	+e44MB4/TwYHAOWf++enSMtUEDJ4nv/6KfRjPbiCjpfvFVP/TwDBp7u2mfxVv8Pb
	Vqx+CS52iv9YlHrhEIL0DVEaXVMPxMSpFtivT1yM/qu2FFGqb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=MmWMJz7Kq+3puyTeII2
	6MGr0CKfsP/XSRZG+E0NhtiLz/UuLp55WlaQdqOun7Gdqeh/9HHYL7zgRzuQxqdq
	HZTAAA2ODFmFYPxcIfZB/HLZLtY4WFIbNsSBVMRsVz3kLf7NprDVaHf00a8oBTdd
	8NXr9G4b/cy6SyTXes4o9RUk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AADEBCC3F8;
	Wed, 11 Aug 2010 14:32:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D22FBCC3E7; Wed, 11 Aug
 2010 14:32:23 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CCAAC944-A576-11DF-839C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153276>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Change this test to skip test with test prerequisites, and to do setu=
p
> work in tests. This improves the skipped statistics on platforms wher=
e
> the test isn't run.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> ---
>  t/t5705-clone-2gb.sh |   11 ++++-------
>  1 files changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/t/t5705-clone-2gb.sh b/t/t5705-clone-2gb.sh
> index e4d1b6a..694e28d 100755
> --- a/t/t5705-clone-2gb.sh
> +++ b/t/t5705-clone-2gb.sh
> @@ -3,12 +3,9 @@
>  test_description=3D'Test cloning a repository larger than 2 gigabyte=
'
>  . ./test-lib.sh
> =20
> -test -z "$GIT_TEST_CLONE_2GB" &&
> -skip_all=3D"Skipping expensive 2GB clone test; enable it with GIT_TE=
ST_CLONE_2GB=3Dt" &&
> -test_done &&
> -exit
> +test -n "$GIT_TEST_CLONE_2GB" && test_set_prereq CLONE_2GB

In your 6/7 you preserve the "skipping" message with "say"; don't you w=
ant
to do the same here?
