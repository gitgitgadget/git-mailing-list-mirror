From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/7] Fix tests under GETTEXT_POISON on git-remote
Date: Mon, 27 Aug 2012 09:28:14 -0700
Message-ID: <7v4nnoti3l.fsf@alter.siamese.dyndns.org>
References: <cover.1346045253.git.worldhello.net@gmail.com>
 <1b42b555cd785e19e95c730ac00271a2fee64edb.1346045253.git.worldhello.net@gmail.com> <08d87cf811ed6ea328303b8ca26f1ab32cacfba9.1346045253.git.worldhello.net@gmail.com> <7398781c6d647557954f4a0c7df29fc98aad842b.1346045253.git.worldhello.net@gmail.com> <d20c47e9618f998b84934c0310f3de51d791e83f.1346045253.git.worldhello.net@gmail.com> <a2e20a1e1ae4be42b763904177cf634a6e291f15.1346045253.git.worldhello.net@gmail.com> <1345523464-14586-1-git-send-email-pclouds@gmail.com> <cover.1346045253.git.worldhello.net@gmail.com> <f56c058cfd76d02ed42b0c5b7161bde6bd51ddd0.1346045253.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 18:28:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T62Ar-0007DF-Ad
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 18:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971Ab2H0Q2T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Aug 2012 12:28:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63567 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806Ab2H0Q2S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Aug 2012 12:28:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE5B97F7F;
	Mon, 27 Aug 2012 12:28:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=hyAD8P0rTBvWXehEcSP18nW3I
	bQ=; b=XytHGJ869AruopkZNhm1zS+FwUa7XSk+5bELi/ajE+nwoH1f8ri/6PzGx
	t7fkBkrqp2uI6dFVzqwx6fxLZuBzpBEcWvgQvdNNuGSmWah0RSdX2O8u4ptDp5QT
	Hln18Ov8T2crVK5hf1VVsIz2vpYWmhJfw0K2MPJq/uBusj0BrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=HRI9I47ywzCGjriK7/+
	W8R45UipcGXa4Kmr/EfjeSdQ5fQ1LDGSM449G1KKJ1sUtIz+HYs7U62vPv1+zY/b
	w+Qjrl1gSkk6GMKYxnp4UaMAihoO5Es4PkaD6Cna368Wz6W3eq7FXMkVXSS+OuHT
	X3P3vyAFHrBWRUGEL0aL9VC8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA6E77F7E;
	Mon, 27 Aug 2012 12:28:17 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E47E7F7A; Mon, 27 Aug 2012
 12:28:16 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3442287E-F064-11E1-A4F4-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204354>

Jiang Xin <worldhello.net@gmail.com> writes:

> Use i18n-specific test functions in test scripts for git-remote.
> This issue was was introduced in v1.7.10-233-gbb16d5:
>
>     bb16d5 i18n: remote: mark strings for translation
>
> and been broken under GETTEXT_POISON=3DYesPlease since.
>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> ...
> @@ -77,6 +75,14 @@ test_expect_success 'add another remote' '
>  )
>  '
> =20
> +test_expect_success C_LOCALE_OUTPUT 'add another remote' '
> +(
> +	cd test &&
> +	check_remote_track origin master side &&
> +	check_remote_track second master side another &&
> +)
> +'

This couldn't have possibly passed with the trailing &&, or am I
missing something?  There is already "add another remote" before
this test that adds "second" remote.  Is this test about "add
yet another remote", or is it checking the result of adding "second"
that was done in the previous step?

Will queue with an obvious fix-up with retitle, 'check tracking', or
something.

Thanks.
