From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/t2023-checkout-m.sh: fix use of test_must_fail
Date: Tue, 20 Dec 2011 13:23:56 -0800
Message-ID: <7v8vm7j5sj.fsf@alter.siamese.dyndns.org>
References: <4EDF1631.5090906@pcharlan.com>
 <1324413465-25614-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pete Harlan <pgit@pcharlan.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 20 22:24:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rd7AN-0006kr-Hn
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 22:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991Ab1LTVYD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Dec 2011 16:24:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46593 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752281Ab1LTVYA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Dec 2011 16:24:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F0D76C58;
	Tue, 20 Dec 2011 16:23:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=re1ih5gfva2V
	SrBptOxQxh1GHNs=; b=WMojQ7HPhFyPbSxF58wqbydrRUN9EzhvrE6UhTk6EtLI
	B4RCjFf03aevddrOi5wFifF2SmuW+r5Rz4lCPWIfIFphFYfaSvsp2YB/Nb8ZG1qH
	ZAKw9BtHPJAk2H3KHFI2EfzQU7AmO2kgcBZh/doulOyxk6x1xJkudQUCaCKMBZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=eJfQeh
	2RC7n4UNMy0XZ/g9lVnGGfvgwrhv2hLZ2tFraGdESQ+AchJrbYzSlxqjBLPyVUkd
	r6sb7bpOqWgXqYGGxfH2jWSWHy8kYWtO/u4NWHNFDR/os41GY2WzhSfqNWICWrFE
	n1lF0DyenH3+qPRI/0IAVpY6uavgkRpOvDg+0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26A2D6C57;
	Tue, 20 Dec 2011 16:23:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7545C6C55; Tue, 20 Dec 2011
 16:23:58 -0500 (EST)
In-Reply-To: <1324413465-25614-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 20 Dec
 2011 20:37:45 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EDCE1CAA-2B50-11E1-884A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187528>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change an invocation of test_must_fail() to be inside a
> test_expect_success() as is our usual pattern. Having it outside
> caused our tests to fail under prove(1) since we wouldn't print a
> newline before TAP output:
>
>     CONFLICT (content): Merge conflict in both.txt
>     # GETTEXT POISON #ok 2 - -m restores 2-way conflicted+resolved fi=
le
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>

Thanks.

> ---
>  t/t2023-checkout-m.sh |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/t/t2023-checkout-m.sh b/t/t2023-checkout-m.sh
> index 1a40ce0..7e18985 100755
> --- a/t/t2023-checkout-m.sh
> +++ b/t/t2023-checkout-m.sh
> @@ -17,7 +17,9 @@ test_expect_success setup '
>  	test_commit added_in_topic each.txt in_topic
>  '
> =20
> -test_must_fail git merge master
> +test_expect_success 'git merge master' '
> +    test_must_fail git merge master
> +'
> =20
>  clean_branchnames () {
>  	# Remove branch names after conflict lines
