From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 06/25] gettextize: git-fetch formatting messages
Date: Thu, 2 Sep 2010 14:59:37 -0500
Message-ID: <20100902195936.GA2531@burratino>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
 <1283456446-22577-7-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 22:01:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFyd-00020g-8m
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 22:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756812Ab0IBUBf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 16:01:35 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54748 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756752Ab0IBUBe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 16:01:34 -0400
Received: by vws3 with SMTP id 3so641893vws.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 13:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=+7KwKuRFT3O1Uw+EtvkXQGHzprM051XPl5F3tgXXoOM=;
        b=BwwRUxYic9riWvxXNppkUhECbpU/3SWVfuYkTDxi2IlNLQv8azT5AjoFwD65ndIJ0R
         yb4kI0uAGpFlDtmbdnoHP1esDwPM9KB/u9RaOjjm/jBUznQgJqINNDNJLepyKZqjq6MW
         epRuj2V/nJ11Zl4Yqb1jZ07fbFTuNTEM37esc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=GrJBsKtGHa7kd2YX2TfPAjitVurcLdIrFiyC/jLOdrqZb2CJ66JcyBJoTt8h+Pfpw8
         XeVmxP0SDZYyIJET8WXYSyi9+CrSaJaEN3UfW9ry6B4Wr7dEK9/aJNQVbBUdzG6Xybtn
         +06ZcNcnJc1OIBY1c9YLfTTDdts5Z4V4Xr8Nk=
Received: by 10.220.101.13 with SMTP id a13mr2363355vco.114.1283457691376;
        Thu, 02 Sep 2010 13:01:31 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id u1sm298779vcx.7.2010.09.02.13.01.29
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 13:01:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283456446-22577-7-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155190>

(+cc: some fetch ui authors, just as a heads up)

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -236,7 +236,7 @@ static int update_local_ref(struct ref *ref,
>  	if (!hashcmp(ref->old_sha1, ref->new_sha1)) {
>  		if (verbosity > 0)
>  			sprintf(display, "=3D %-*s %-*s -> %s", TRANSPORT_SUMMARY_WIDTH,
> -				"[up to date]", REFCOL_WIDTH, remote,
> +				_("[up to date]"), REFCOL_WIDTH, remote,
>  				pretty_ref);

Longer-term question: do people like to translate this kind of thing
(with the arrows and so on) differently for right-to-left languages or
is that considered overkill?

> @@ -249,8 +249,8 @@ static int update_local_ref(struct ref *ref,
>  		 * If this is the head, and it's not okay to update
>  		 * the head, and the old value of the head isn't empty...
>  		 */
> -		sprintf(display, "! %-*s %-*s -> %s  (can't fetch in current branc=
h)",
> -			TRANSPORT_SUMMARY_WIDTH, "[rejected]", REFCOL_WIDTH, remote,
> +		sprintf(display, _("! %-*s %-*s -> %s  (can't fetch in current bra=
nch)"),
> +			TRANSPORT_SUMMARY_WIDTH, _("[rejected]"), REFCOL_WIDTH, remote,

Regardless of the answer, we should probably be either consistently
translating or not translating it within this patch.  e.g. for not
translating (though I suspect translating is the better choice):

		sprintf(display, "! %-*s %-*s -> %s  %s",
			TRANSPORT_SUMMARY_WIDTH, "[rejected]", REFCOL_WIDTH, remote,
			pretty_ref, _("(can't fetch in current branch)"));

> @@ -260,8 +260,8 @@ static int update_local_ref(struct ref *ref,
>  		int r;
>  		r =3D s_update_ref("updating tag", ref, 0);
>  		sprintf(display, "%c %-*s %-*s -> %s%s", r ? '!' : '-',
> -			TRANSPORT_SUMMARY_WIDTH, "[tag update]", REFCOL_WIDTH, remote,
> -			pretty_ref, r ? "  (unable to update local ref)" : "");
> +			TRANSPORT_SUMMARY_WIDTH, _("[tag update]"), REFCOL_WIDTH, remote,
> +			pretty_ref, r ? _("  (unable to update local ref)") : "");

Maybe we could stick to "%c %-*s %-*s -> %s%s", to make consistent
translation easier.
