From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/4] textconv: make diff_options accessible from
 blame
Date: Thu, 03 Jun 2010 22:48:20 -0700
Message-ID: <7vvd9z5owr.fsf@alter.siamese.dyndns.org>
References: <1275562038-7468-1-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275562038-7468-2-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275562038-7468-3-git-send-email-axel.bonnet@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>
To: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 04 07:48:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKPlp-0007F8-4r
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 07:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719Ab0FDFsf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 01:48:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39497 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab0FDFsf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Jun 2010 01:48:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A6BD8B90DD;
	Fri,  4 Jun 2010 01:48:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=QOF8CpeqoM8yBeWa4G+TWuQ1P
	w0=; b=gABqrEFfAuGxDY+rP1Yn8nftiwgxZJTCJdz2AlqvUkwzd6OOJc7TyMrLn
	FflMwkE7AC5ZZ3SuBoE81gMn7ldKR6Q+f1yMWGROBDFwDgpqDX+Smw/eh3SYX7Pr
	CWoU0J2l7cR9LxDjwMg6SCSGmqVWzy025eVU+LEidYwCDbw4sc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=QuG2XvaQkiJdr+fu6sv
	AkmrkYy8RGOnjix768/8LgLo7Z8Md3ZCArqIoAyaWZnTwU3h7NvqO+qZsazDfvgL
	O7gdiwS9CM8RS9Ax+3mmuJMdOOYhIPIdUUSqLUjHP7OdFRRdfon8ZTGlKT9/Rmp4
	gAhXAETk/dQhDHPBFu5AUuw4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C561B90DC;
	Fri,  4 Jun 2010 01:48:29 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6AAAFB90D8; Fri,  4 Jun
 2010 01:48:24 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CD350268-6F9C-11DF-B64B-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148378>

Axel Bonnet <axel.bonnet@ensimag.imag.fr> writes:

> Diff_options specify whether conversion is activated or not. Blame ne=
eds
> to access these options in order to concert files with external drive=
rs
>
> Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
> Signed-off-by: Cl=C3=83=C2=A9ment Poulain <clement.poulain@ensimag.im=
ag.fr>
> Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>

The name of Cl=C3=A9ment is spelled correctly on the mail header while =
S-o-b
line is corrupt.  Perhaps you have recorded your commits in UTF-8 but
allowed your MUA to send in 8859-1?  This comment applies to all the
patches in the series.

> diff --git a/builtin/blame.c b/builtin/blame.c
> index fc15863..63b497c 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -89,7 +89,8 @@ struct origin {
>   * Given an origin, prepare mmfile_t structure to be used by the
>   * diff machinery
>   */
> -static void fill_origin_blob(struct origin *o, mmfile_t *file)
> +static void fill_origin_blob(struct diff_options opt,
> +			     struct origin *o, mmfile_t *file)
>  {
>  	if (!o->file.ptr) {
>  		enum object_type type;

Two points.

 * Generally we do not want to pass structures by value.  It is especia=
lly
   true when the structure is bigger than one word, and accesses to the
   variable in the callee is read-only.

 * The callee does not seem to use the new parameter yet.  You might wa=
nt
   to defer this change until fill-origin-blob actually starts using it=
=2E
