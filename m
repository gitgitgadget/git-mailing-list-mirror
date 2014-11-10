From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] run-command: use void to declare that functions take no parameters
Date: Mon, 10 Nov 2014 14:43:10 -0800
Message-ID: <xmqq7fz28yo1.fsf@gitster.dls.corp.google.com>
References: <54612B4C.8010609@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Etienne Buira <etienne.buira@gmail.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 10 23:43:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xnxg5-000472-HW
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 23:43:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbaKJWnO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2014 17:43:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64607 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751138AbaKJWnN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2014 17:43:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5FF1F1D9DD;
	Mon, 10 Nov 2014 17:43:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=E74LU+NrDsIL
	rzdF91GnnJAnaWw=; b=GQZL4UK5TScXGXyFaPMIviV3lKAJWuL2N0OVRk4npwFZ
	MP2c/H0J2BSYUGe590cYs6VEsD0KN0iwk31KIY87UzWdamgZC6H1DgTOPox9FQQT
	zIvJPMDmLMZYE/S5F6kI5fe6xa0FNkJgI3276L2gX8NuJxPQ/5KimaYl9QmQ0UQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=G5XWBZ
	ymti5oN0Hfl5Q1O4ALBTaO99Sz8CCcsTsi61/Wy0ko2VFZ5JbzPrAFk3trBuu0T8
	4615MAy4Wwoeqw1SNoOq6M14d/pUHt1KLJ5gSj8uMot5NI1hKLPtAcywEGE9oxQk
	DzN6jqGMGr1U/n42SyQf6DSQMf3F7yHqEq99U=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 561911D9DC;
	Mon, 10 Nov 2014 17:43:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD2231D9DA;
	Mon, 10 Nov 2014 17:43:11 -0500 (EST)
In-Reply-To: <54612B4C.8010609@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Mon, 10
	Nov 2014 22:17:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F34921A0-692A-11E4-A1F4-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Explicitly declare that git_atexit_dispatch() and git_atexit_clear()
> take no parameters instead of leaving their parameter list empty and
> thus unspecified.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---

Thanks.

I was kind of surprised after running a git blame to find that this
is a recent thing, and the same patch looked quite substandard with
numerious style violations, and I somehow managed to let them slip
in X-<.  Perhaps I was having a bad day or something...

>  run-command.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index 79a0a76..a476999 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -636,7 +636,7 @@ static struct {
> =20
>  static int git_atexit_installed;
> =20
> -static void git_atexit_dispatch()
> +static void git_atexit_dispatch(void)
>  {
>  	size_t i;
> =20
> @@ -644,7 +644,7 @@ static void git_atexit_dispatch()
>  		git_atexit_hdlrs.handlers[i-1]();
>  }
> =20
> -static void git_atexit_clear()
> +static void git_atexit_clear(void)
>  {
>  	free(git_atexit_hdlrs.handlers);
>  	memset(&git_atexit_hdlrs, 0, sizeof(git_atexit_hdlrs));
