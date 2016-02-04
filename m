From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/25] upload-pack: remove unused variable "backup"
Date: Thu, 04 Feb 2016 15:32:14 -0800
Message-ID: <xmqq8u30f3wh.fsf@gitster.mtv.corp.google.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
	<1454576641-29615-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 00:32:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRTNu-0003WO-3n
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 00:32:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756432AbcBDXcS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 18:32:18 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65180 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750744AbcBDXcR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2016 18:32:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A55024202A;
	Thu,  4 Feb 2016 18:32:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+y4PElzNqMna
	K3lrrcfyO+w0J4Y=; b=rC5DE+DCSSeeUop3tGcEcBqZurj9JmoAaqav34FvlwnU
	V85i09+t9HBJgZRi2RloZtqZ/UMof79DyCKL9N9BwG8+tuvvyHMyYAR71VEu6N9T
	irFqjqADEbNCcet/gLdl5Ef/0hXm0sNOzpyT2N07argzxx3y4C0CTEdZROGMOIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=B7/bYk
	EW0RUcPNrSjcG5zUowVq1D2ktneQeRx98EKpqPSb4Z1ZJVgOU6l49X0b2jHp0J75
	hjrb2bF8ZwsT3jpd5pGBJpezh6t3GIYFF491wPxId2cX3atLGTpIv29XpBDDxyaS
	x6bW2MsEG4yYqX8xboqUYl95lH2ZlCgd0RNKU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9C1E842029;
	Thu,  4 Feb 2016 18:32:16 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1E15742028;
	Thu,  4 Feb 2016 18:32:16 -0500 (EST)
In-Reply-To: <1454576641-29615-7-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 4 Feb
 2016 16:03:42 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 867AC706-CB97-11E5-B99F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285519>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> After the last patch, "result" and "backup" are the same. "result" us=
ed
> to move, but the movement is now contained in send_shallow(). Delete
> this redundant variable.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

OK.  05 and 06 squashed together would also have been readable, but
either way is fine; it is not worth merging them into one.

>  upload-pack.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index 0eb9a0b..ee5d20b 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -554,7 +554,7 @@ static void send_shallow(struct commit_list *resu=
lt)
> =20
>  static void deepen(int depth, const struct object_array *shallows)
>  {
> -	struct commit_list *result =3D NULL, *backup =3D NULL;
> +	struct commit_list *result =3D NULL;
>  	int i;
>  	if (depth =3D=3D INFINITE_DEPTH && !is_repository_shallow())
>  		for (i =3D 0; i < shallows->nr; i++) {
> @@ -562,11 +562,10 @@ static void deepen(int depth, const struct obje=
ct_array *shallows)
>  			object->flags |=3D NOT_SHALLOW;
>  		}
>  	else
> -		backup =3D result =3D
> -			get_shallow_commits(&want_obj, depth,
> -					    SHALLOW, NOT_SHALLOW);
> +		result =3D get_shallow_commits(&want_obj, depth,
> +					     SHALLOW, NOT_SHALLOW);
>  	send_shallow(result);
> -	free_commit_list(backup);
> +	free_commit_list(result);
>  	for (i =3D 0; i < shallows->nr; i++) {
>  		struct object *object =3D shallows->objects[i].item;
>  		if (object->flags & NOT_SHALLOW) {
