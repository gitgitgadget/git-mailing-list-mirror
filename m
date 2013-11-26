From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] transport: Catch non positive --depth option value
Date: Tue, 26 Nov 2013 14:19:03 -0800
Message-ID: <xmqqfvqivmaw.fsf@gitster.dls.corp.google.com>
References: <5283A380.9030308@gmail.com>
	<xmqqzjp1bqm3.fsf@gitster.dls.corp.google.com>
	<528A9877.4060802@gmail.com>
	<xmqq61ro9utf.fsf@gitster.dls.corp.google.com>
	<528E2660.6020107@gmail.com>
	<xmqq1u294ih3.fsf@gitster.dls.corp.google.com>
	<CACsJy8B0qBmBkx0n2B=ivUqZTgVz-ZLhTQ_nVJ4AV0njnZksfw@mail.gmail.com>
	<5293DE93.3020008@gmail.com>
	<CACsJy8BV74W63Sak-j_9RMjp_5Bo8HMd3Xc93GTtSn4yWStfEA@mail.gmail.com>
	<52947B42.4080105@gmail.com>
	<CACsJy8Dfibu96VchD=p_05deLm-46mfXZzcYQg+0BqaN2=To=A@mail.gmail.com>
	<529488D5.80605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: =?utf-8?Q?Andr=C3=A9s_G=2E_Aragoneses?= <knocte@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 26 23:19:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlQyZ-0001So-AH
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 23:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758558Ab3KZWTQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Nov 2013 17:19:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54567 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758547Ab3KZWTL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Nov 2013 17:19:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1527D56EBC;
	Tue, 26 Nov 2013 17:19:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=mRKoi018pvfhwEk9EXVtJI/kZ
	mY=; b=yEB/YTrzvhxfEa3lhrINWdnnRMcD3mebwgoesO9u3cH/RTsZM6iXZ0pEz
	ptrEh61yJzBpAKVzvWEkpkeD0WOlTUkCJXPZvuTHLQyeW9FoHTlsE/NVCaFyCyGL
	G8EUEoUkm985L/5o6Y9xzITEW643RZvlg6wg0bmd4HRxBwrzWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=n947FtD9he3MGoiQzl/
	GGmKVFO0z6uMP8fY0a3cbk9NW1XkYY2K8Yf+kgi0GgbTUJYYgCWjRCNPMHovFPlw
	5Ur0qBgLjBabh3nyPKdyXG/BRR6V3+1Dq2Yx0EYmZs127pt2V72Uo5OyWIvBGuq7
	DCkvE9WuUHTecSbhg3tc4E0Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0537356EBB;
	Tue, 26 Nov 2013 17:19:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 312FF56EB9;
	Tue, 26 Nov 2013 17:19:10 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C5CB8088-56E8-11E3-91FB-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238397>

"Andr=C3=A9s G. Aragoneses" <knocte@gmail.com> writes:

> From 4f3b24379090b7b69046903fba494f3191577b20 Mon Sep 17 00:00:00 200=
1
> From: =3D?UTF-8?q?Andr=3DC3=3DA9s=3D20G=3D2E=3D20Aragoneses?=3D <knoc=
te@gmail.com>
> Date: Tue, 26 Nov 2013 12:38:19 +0100
> Subject: [PATCH] transport: Catch non positive --depth option value

Please do not leave these four lines in your e-mail message, unless
there is a good reason to do so (e.g. when you are forwarding a
patch authored by somebody else, you may want a "From:" that names
the real author at the beginning, but that does not apply in this
case where you are sending your own).

The first line is merely a marker to say the file is a format-patch
output, and the header lines are there for those who use "git
send-email" to mail the messages out, and/or for those who want to
cut & paste some of them (not copy & paste) to their MUA header
input widgets.

> Instead of simply ignoring the value passed to --depth option when
> it is zero or negative, now it is caught and reported.
>
> This will let people know that they were using the option
> incorrectly (as depth<0 should be simply invalid, and under the
> hood depth=3D=3D0 didn't have any effect).
>
> (The change in fetch.c is needed to avoid the tests failing
> because of this new restriction.)

Good, but it is not just tests but without that change real
operations break.  In other words, it is an integral part of the
patch, not a workaround for a broken test.

Thanks.  Will queue with a bit of tweak.

> Signed-off-by: Andres G. Aragoneses <knocte@gmail.com>
> Reviewed-by: Duy Nguyen <pclouds@gmail.com>
> ---
>  builtin/fetch.c | 2 +-
>  transport.c     | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index bd7a101..88c04d7 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -770,7 +770,7 @@ static void backfill_tags(struct transport *trans=
port, struct ref *ref_map)
>  	}
> =20
>  	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
> -	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
> +	transport_set_option(transport, TRANS_OPT_DEPTH, NULL);
>  	fetch_refs(transport, ref_map);
> =20
>  	if (gsecondary) {
> diff --git a/transport.c b/transport.c
> index 7202b77..5b42ccb 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -483,6 +483,8 @@ static int set_git_option(struct git_transport_op=
tions *opts,
>  			opts->depth =3D strtol(value, &end, 0);
>  			if (*end)
>  				die("transport: invalid depth option '%s'", value);
> +			if (opts->depth < 1)
> +				die("transport: invalid depth option '%s' (must be positive)", v=
alue);
>  		}
>  		return 0;
>  	}
