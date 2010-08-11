From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] t/t4016-diff-quote: change from skip_all=* to prereq
 skip
Date: Wed, 11 Aug 2010 11:32:15 -0700
Message-ID: <7vocd9xaog.fsf@alter.siamese.dyndns.org>
References: <1281469968-25670-1-git-send-email-avarab@gmail.com>
 <1281469968-25670-6-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 20:33:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjG6v-0002K0-TN
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 20:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755302Ab0HKScb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 14:32:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47516 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414Ab0HKSca convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 14:32:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CA0B6CC3F7;
	Wed, 11 Aug 2010 14:32:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=LWsHqrdgNOzpn2/hFhxGyguQr
	1U=; b=QaSf4N8uncHd7ogR0lQ/aTzuzPOe2fPRhu5wg8pm6/xBrfbUNzHBo0kdk
	bHJFcyRt7wiZReFZuzg+9sHK8vxDHrRbz6rbPJC9Mya6LRJy9Ev+3AT9Wb7P12kz
	CtXw2EkPRM1l+wzLO1JwAs5nt2g2ZNjWaPqPUHF3Hb5YUPmOQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=IaD7UzhjQVfgaee+FT7
	KhDg95SNEucBQG1Mss4l17W0naX8HJH+gU0p3by49U0sIE3MSI6eEbiJU4qZpOrj
	Fgonh7ADmJQwvhBb0AGNxRFyPKymO0b7T2UBCXM54vCtaldSAKMX12rHT83x7Xmr
	F/R06obseJz82O9QsKYR6mzU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 61D78CC3F1;
	Wed, 11 Aug 2010 14:32:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C9A1ECC3DA; Wed, 11 Aug
 2010 14:32:16 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CA0D2254-A576-11DF-87D9-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153275>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> diff --git a/t/t4016-diff-quote.sh b/t/t4016-diff-quote.sh
> index 34e5144..10e2db3 100755
> --- a/t/t4016-diff-quote.sh
> +++ b/t/t4016-diff-quote.sh
> @@ -11,14 +11,16 @@ test_description=3D'Quoting paths in diff output.
>  P0=3D'pathname'
>  P1=3D'pathname	with HT'
>  P2=3D'pathname with SP'
> +if P3=3D'pathname
>  with LF'
> +: 2>/dev/null >"$P1" && test -f "$P1" && rm -f "$P1"
> +then
> +	test_set_prereq TABS_IN_FILENAMES
> +else
> +	say 'Your filesystem does not allow tabs in filenames'
> +fi

Did you really mean to have that "if" before assignment to P3, and if s=
o
why (as opposed to "after assignment to P3" or "before assignment to P0=
")?
