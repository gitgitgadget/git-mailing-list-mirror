From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] mv: no "Huh?" to the user
Date: Fri, 08 Aug 2014 10:48:58 -0700
Message-ID: <xmqqfvh6kh2t.fsf@gitster.dls.corp.google.com>
References: <1407503462-32632-1-git-send-email-pclouds@gmail.com>
	<1407503462-32632-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 19:49:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFoHz-00007G-Mb
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 19:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756956AbaHHRtK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2014 13:49:10 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59314 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756955AbaHHRtI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Aug 2014 13:49:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 618F32E0C9;
	Fri,  8 Aug 2014 13:49:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xBAWAeYnixuC
	Lye0v2JVJkfTQ3c=; b=rrpfxkqIHi+bgZZzYQT+NNvNuRzsZJy6hOwTluOf/Iez
	G77I4gK57hMBmSFVtoEyv+5DvknO82fb/pJ7gbZ5PrU3FRRYmCJGYOQktKtLydx3
	1MtZy42+OPjXpy7Cn/wCxWelbR2QmppxTQiiCArFiOPkOhGXSeChandPkh6gS24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=f109lP
	gSKdy4gtv7wicYVNXB+cdfnx/GzbhE409a4XLeuSXo+3aMGUbbt/yV7wx3J2Id+3
	nlTJlz+00ReikbWXt9nMIl6T6PDReqDOkPGmP8GKDJQG+r8NnieKhrnIbSmhUYKX
	kwtWGw8pqrL9cf3eqyO/QI+n0uUQXfiJgkGVo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 57C392E0C7;
	Fri,  8 Aug 2014 13:49:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4EAE52E0B9;
	Fri,  8 Aug 2014 13:49:00 -0400 (EDT)
In-Reply-To: <1407503462-32632-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 8 Aug
 2014 20:10:56 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 474AFE3C-1F24-11E4-8728-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255059>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Although if we are frisky, this could do
>
>    static NORETURN void die_builtin(const char *err, va_list params)
>    {
>   -	vreportf("fatal: ", err, params);
>   +	vreportf("Huh? ", err, params);
>    	exit(128);
>    }

;-)

While at it we may want to remove the extra SP between dies and
their opening parentheses.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/mv.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index b892f63..a7e02c0 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -135,7 +135,7 @@ int cmd_mv(int argc, const char **argv, const cha=
r *prefix)
>  			if (first >=3D 0) {
>  				struct strbuf submodule_dotgit =3D STRBUF_INIT;
>  				if (!S_ISGITLINK(active_cache[first]->ce_mode))
> -					die (_("Huh? Directory %s is in index and no submodule?"), src)=
;
> +					die (_("Directory %s is in index and no submodule?"), src);
>  				if (!is_staging_gitmodules_ok())
>  					die (_("Please, stage your changes to .gitmodules or stash them=
 to proceed"));
>  				strbuf_addf(&submodule_dotgit, "%s/.git", src);
> @@ -153,8 +153,7 @@ int cmd_mv(int argc, const char **argv, const cha=
r *prefix)
> =20
>  				first =3D cache_name_pos(src_w_slash, len_w_slash);
>  				if (first >=3D 0)
> -					die (_("Huh? %.*s is in index?"),
> -							len_w_slash, src_w_slash);
> +					die (_("%.*s is in index"), len_w_slash, src_w_slash);
> =20
>  				first =3D -1 - first;
>  				for (last =3D first; last < active_nr; last++) {
