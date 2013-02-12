From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 11/12] format-patch: update append_signoff prototype
Date: Tue, 12 Feb 2013 11:29:44 -0800
Message-ID: <7v1uclgwk7.fsf@alter.siamese.dyndns.org>
References: <1360664260-11803-1-git-send-email-drafnel@gmail.com>
 <1360664260-11803-12-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com, jrnieder@gmail.com,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 20:30:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5LYR-0004ng-5f
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 20:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933204Ab3BLT3s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Feb 2013 14:29:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54340 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932293Ab3BLT3r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2013 14:29:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66219B571;
	Tue, 12 Feb 2013 14:29:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AT6awYuAOmlC
	ugP/PHbVO8EHiBs=; b=UoWCPvJrx8KeuPZJOF0d57Jx+k5GeW9bJccDyI2l3TBa
	c7LdRUgmvPsdRWsDlzJqkemuT629MNJgkkdjx6wWdgdSRFwkY7KFlW2eRAmDIjx+
	z7Ni23L3QLNHEee+zV2Z1M0uq0Q+Tyu7YkY6/c5hqFtZUnqCTcj4np6JkI71AlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jpYL7U
	jS6dxApE2qXaI3OayS6IJVVdHxfPHYTorS3M2l5kEr7leFNTmjQpwfOFJeAYUWBt
	FjsHaVfirCqi+Lll7COzuUdWlu/A1T/Caqn9oD5wxxRgtu8N2hRrkZ1KJOXEwUlM
	nJzDzvCNiGhXlKoEGFm02F0pX4uLVv3nWfguo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AC41B570;
	Tue, 12 Feb 2013 14:29:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90BECB569; Tue, 12 Feb 2013
 14:29:45 -0500 (EST)
In-Reply-To: <1360664260-11803-12-git-send-email-drafnel@gmail.com> (Brandon
 Casey's message of "Tue, 12 Feb 2013 02:17:38 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8EA94714-754A-11E2-AFC3-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216176>

Brandon Casey <drafnel@gmail.com> writes:

> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>
> This is a preparation step for merging with append_signoff from
> sequencer.c
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> Signed-off-by: Brandon Casey <bcasey@nvidia.com>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  builtin/log.c | 13 +------------
>  log-tree.c    | 17 +++++++++++++----
>  revision.h    |  2 +-
>  3 files changed, 15 insertions(+), 17 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 8f0b2e8..59de484 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1086,7 +1086,6 @@ int cmd_format_patch(int argc, const char **arg=
v, const char *prefix)
>  	struct commit *origin =3D NULL, *head =3D NULL;
>  	const char *in_reply_to =3D NULL;
>  	struct patch_ids ids;
> -	char *add_signoff =3D NULL;
>  	struct strbuf buf =3D STRBUF_INIT;
>  	int use_patch_format =3D 0;
>  	int quiet =3D 0;
> @@ -1193,16 +1192,6 @@ int cmd_format_patch(int argc, const char **ar=
gv, const char *prefix)
>  		rev.subject_prefix =3D strbuf_detach(&sprefix, NULL);
>  	}
> =20
> -	if (do_signoff) {
> -		const char *committer;
> -		const char *endpos;
> -		committer =3D git_committer_info(IDENT_STRICT);
> -		endpos =3D strchr(committer, '>');
> -		if (!endpos)
> -			die(_("bogus committer info %s"), committer);
> -		add_signoff =3D xmemdupz(committer, endpos - committer + 1);
> -	}
> -
>  	for (i =3D 0; i < extra_hdr.nr; i++) {
>  		strbuf_addstr(&buf, extra_hdr.items[i].string);
>  		strbuf_addch(&buf, '\n');
> @@ -1393,7 +1382,7 @@ int cmd_format_patch(int argc, const char **arg=
v, const char *prefix)
>  		total++;
>  		start_number--;
>  	}
> -	rev.add_signoff =3D add_signoff;
> +	rev.add_signoff =3D do_signoff;
>  	while (0 <=3D --nr) {
>  		int shown;
>  		commit =3D list[nr];
> diff --git a/log-tree.c b/log-tree.c
> index 5dc45c4..ac1cd68 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -10,6 +10,8 @@
>  #include "color.h"
>  #include "gpg-interface.h"
> =20
> +#define APPEND_SIGNOFF_DEDUP (1u <<0)
> +
>  struct decoration name_decoration =3D { "object names" };
> =20
>  enum decoration_type {
> @@ -253,9 +255,12 @@ static int detect_any_signoff(char *letter, int =
size)
>  	return seen_head && seen_name;
>  }
> =20
> -static void append_signoff(struct strbuf *sb, const char *signoff)
> +static void append_signoff(struct strbuf *sb, int ignore_footer, uns=
igned flag)
>  {
> +	unsigned no_dup_sob =3D flag & APPEND_SIGNOFF_DEDUP;

Unused variable at this step?

>  	static const char signed_off_by[] =3D "Signed-off-by: ";
> +	char *signoff =3D xstrdup(fmt_name(getenv("GIT_COMMITTER_NAME"),
> +					       getenv("GIT_COMMITTER_EMAIL")));
>  	size_t signoff_len =3D strlen(signoff);
>  	int has_signoff =3D 0;
>  	char *cp;
> @@ -275,6 +280,7 @@ static void append_signoff(struct strbuf *sb, con=
st char *signoff)
>  		if (!isspace(cp[signoff_len]))
>  			continue;
>  		/* we already have him */
> +		free(signoff);
>  		return;
>  	}
> =20
> @@ -287,6 +293,7 @@ static void append_signoff(struct strbuf *sb, con=
st char *signoff)
>  	strbuf_addstr(sb, signed_off_by);
>  	strbuf_add(sb, signoff, signoff_len);
>  	strbuf_addch(sb, '\n');
> +	free(signoff);
>  }
> =20
>  static unsigned int digits_in_number(unsigned int number)
> @@ -672,8 +679,10 @@ void show_log(struct rev_info *opt)
>  	/*
>  	 * And then the pretty-printed message itself
>  	 */
> -	if (ctx.need_8bit_cte >=3D 0)
> -		ctx.need_8bit_cte =3D has_non_ascii(opt->add_signoff);
> +	if (ctx.need_8bit_cte >=3D 0 && opt->add_signoff)
> +		ctx.need_8bit_cte =3D
> +			has_non_ascii(fmt_name(getenv("GIT_COMMITTER_NAME"),
> +					       getenv("GIT_COMMITTER_EMAIL")));
>  	ctx.date_mode =3D opt->date_mode;
>  	ctx.date_mode_explicit =3D opt->date_mode_explicit;
>  	ctx.abbrev =3D opt->diffopt.abbrev;
> @@ -686,7 +695,7 @@ void show_log(struct rev_info *opt)
>  	pretty_print_commit(&ctx, commit, &msgbuf);
> =20
>  	if (opt->add_signoff)
> -		append_signoff(&msgbuf, opt->add_signoff);
> +		append_signoff(&msgbuf, 0, APPEND_SIGNOFF_DEDUP);
> =20
>  	if ((ctx.fmt !=3D CMIT_FMT_USERFORMAT) &&
>  	    ctx.notes_message && *ctx.notes_message) {
> diff --git a/revision.h b/revision.h
> index 5da09ee..01bd2b7 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -138,7 +138,7 @@ struct rev_info {
>  	int		reroll_count;
>  	char		*message_id;
>  	struct string_list *ref_message_ids;
> -	const char	*add_signoff;
> +	int		add_signoff;
>  	const char	*extra_headers;
>  	const char	*log_reencode;
>  	const char	*subject_prefix;
