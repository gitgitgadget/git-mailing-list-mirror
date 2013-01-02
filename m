From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] t4014: do not uese echo -n
Date: Tue, 01 Jan 2013 17:16:59 -0800
Message-ID: <7vwqvw5qpg.fsf@alter.siamese.dyndns.org>
References: <201301012241.17050.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 02:17:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqCxq-0004kF-Jq
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 02:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257Ab3ABBRE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jan 2013 20:17:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40965 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751666Ab3ABBRC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jan 2013 20:17:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE399BC89;
	Tue,  1 Jan 2013 20:17:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cRRLjczIQOlh
	39WwBh18LM+yhYk=; b=dkCBlOdgq4LVd9SBNHd4ZPv4QnP/4XI7iOQ0IXZZo+BQ
	5Wt4RY3DrAZZ08GbVch/DDApc6K+v0zNuAqYsiIJSsK0CVKj7ALn7Mc9OXJ9AgAM
	haStEaREha479M/+qCH3duLJRjGT5kYv6U5VkmyBjWXzdneTOy5eXvoEGYaf5Yg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=N0B7V0
	P9S+bk1IkHNTMQaXRlwABoyVH9Hhall8nBf5DmSuskEspgYcrazSALrvpU4XwbA0
	sjBgjLBLACdJUDh/whPuhFbtEAZMI/CwWYNDaR+k579WVdkNKEYKdlhjg1bY0cFC
	CcDQmIVkFZERJzOU/J568YFWpvS0fFYBHdl6g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCE0BBC88;
	Tue,  1 Jan 2013 20:17:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 370BBBC87; Tue,  1 Jan 2013
 20:17:01 -0500 (EST)
In-Reply-To: <201301012241.17050.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?= message of "Tue, 1 Jan 2013 22:41:15
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C50B8C8-547A-11E2-966C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212481>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> echo -n is not portable on all systems.
> Use printf instead
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---

Brandon, this comes from 932581b (Unify appending signoff in
format-patch, commit and sequencer, 2012-11-25).  Please make sure
to squash it in when you reroll the series.

Thanks (and a happy new year ;-).

>  t/t4014-format-patch.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 6cfad13..f460930 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -993,7 +993,7 @@ EOF
>  '
> =20
>  test_expect_success 'signoff: commit with only subject that does not=
 end with NL' '
> -	echo -n subject | append_signoff >actual &&
> +	printf subject | append_signoff >actual &&
>  	cat >expected <<\EOF &&
>  4:Subject: [PATCH] subject
>  8:
