From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/45] Add parse_pathspec() that converts cmdline args
 to struct pathspec
Date: Fri, 22 Mar 2013 14:55:58 -0700
Message-ID: <7vppyr5cb5.fsf@alter.siamese.dyndns.org>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363781779-14947-1-git-send-email-pclouds@gmail.com>
 <1363781779-14947-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 22:56:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ9wu-0000fB-2G
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 22:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423322Ab3CVV4D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Mar 2013 17:56:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49244 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932468Ab3CVV4B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Mar 2013 17:56:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08FD1AFB5;
	Fri, 22 Mar 2013 17:56:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0zfbvL9fQy+G
	Drtd1BbbqDShALg=; b=lvNmZYXC9sCazssYuAu69wJswhlK6+fY1JDZGveI2N0o
	LusMJ2S11S2w2PspgE6b9vMw5TWKcPtcrGyHVj1XvuOx3Pb16vFn5nfgNGN6DWI5
	Nqa23JjdISsWZ8GYMv3cBoSNNFCGLbvEmSWfhP37bBIDJ63i8RrcX/OKb1UvPiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ydn445
	Ye+GrRim5Y201HYMx51ssLp86NY7nGoidRSEwmRkxr+dy9LjVlaCqVF1X3Xfj7Xr
	sjHPIRu0d1g10FkLS9495p1HIgAPZoZS869EfdXKQQ4obnm7A8Gkgswva6UfL1xO
	KduDM7zHgkiOgs21JkUrAx5iQE0OOsUGPxnhY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECB73AFB4;
	Fri, 22 Mar 2013 17:56:00 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E434AAFB1; Fri, 22 Mar 2013
 17:55:59 -0400 (EDT)
In-Reply-To: <1363781779-14947-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 20 Mar
 2013 19:16:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4845CB1C-933B-11E2-9D5A-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218854>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/Documentation/technical/api-setup.txt b/Documentation/te=
chnical/api-setup.txt
> index 4f63a04..59a947e 100644
> --- a/Documentation/technical/api-setup.txt
> +++ b/Documentation/technical/api-setup.txt
> @@ -8,6 +8,23 @@ Talk about
>  * is_inside_git_dir()
>  * is_inside_work_tree()
>  * setup_work_tree()
> -* get_pathspec()
> =20
>  (Dscho)
> +
> +Pathspec
> +=3D=3D=3D=3D=3D=3D=3D=3D

asciidoc: ERROR: api-setup.txt: line 15: only book doctypes can
contain level 0 sections

Just demoting this to "--------" should be sufficient, I think.

> +
> +See glossary-context.txt for the syntax of pathspec. In memory, a
> +pathspec set is represented by "struct pathspec" and is prepared by
> +parse_pathspec(). This function takes several arguments:
> +
> +- magic_mask specifies what features that are NOT supported by the
> +  following code. If a user attempts to use such a feature,
> +  parse_pathspec() can reject it early.
> +
> +- flags specifies other things that the caller wants parse_pathspec =
to
> +  perform.
> +
> +- prefix and args come from cmd_* functions
> +
> +get_pathspec() is obsolete and should never be used in new code.
> diff --git a/dir.c b/dir.c
> index 97ad45b..a442467 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -338,7 +338,7 @@ int match_pathspec_depth(const struct pathspec *p=
s,
>  /*
>   * Return the length of the "simple" part of a path match limiter.
>   */
> -static int simple_length(const char *match)
> +int simple_length(const char *match)
>  {
>  	int len =3D -1;
> =20
> @@ -350,7 +350,7 @@ static int simple_length(const char *match)
>  	}
>  }
> =20
> -static int no_wildcard(const char *string)
> +int no_wildcard(const char *string)
>  {
>  	return string[simple_length(string)] =3D=3D '\0';
>  }
> diff --git a/dir.h b/dir.h
> index c3eb4b5..89427fd 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -125,6 +125,8 @@ struct dir_struct {
>  #define MATCHED_RECURSIVELY 1
>  #define MATCHED_FNMATCH 2
>  #define MATCHED_EXACTLY 3
> +extern int simple_length(const char *match);
> +extern int no_wildcard(const char *string);
>  extern char *common_prefix(const char **pathspec);
>  extern int match_pathspec(const char **pathspec, const char *name, i=
nt namelen, int prefix, char *seen);
>  extern int match_pathspec_depth(const struct pathspec *pathspec,
> diff --git a/pathspec.c b/pathspec.c
> index ab53b8a..ebe9844 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -103,10 +103,6 @@ void die_if_path_beyond_symlink(const char *path=
, const char *prefix)
>  /*
>   * Magic pathspec
>   *
> - * NEEDSWORK: These need to be moved to dir.h or even to a new
> - * pathspec.h when we restructure get_pathspec() users to use the
> - * "struct pathspec" interface.
> - *
>   * Possible future magic semantics include stuff like:
>   *
>   *	{ PATHSPEC_NOGLOB, '!', "noglob" },
> @@ -115,7 +111,6 @@ void die_if_path_beyond_symlink(const char *path,=
 const char *prefix)
>   *	{ PATHSPEC_REGEXP, '\0', "regexp" },
>   *
>   */
> -#define PATHSPEC_FROMTOP    (1<<0)
> =20
>  static struct pathspec_magic {
>  	unsigned bit;
> @@ -127,7 +122,7 @@ static struct pathspec_magic {
> =20
>  /*
>   * Take an element of a pathspec and check for magic signatures.
> - * Append the result to the prefix.
> + * Append the result to the prefix. Return the magic bitmap.
>   *
>   * For now, we only parse the syntax and throw out anything other th=
an
>   * "top" magic.
> @@ -138,10 +133,15 @@ static struct pathspec_magic {
>   * the prefix part must always match literally, and a single stupid
>   * string cannot express such a case.
>   */
> -static const char *prefix_pathspec(const char *prefix, int prefixlen=
, const char *elt)
> +static unsigned prefix_pathspec(struct pathspec_item *item,
> +				unsigned *p_short_magic,
> +				const char **raw, unsigned flags,
> +				const char *prefix, int prefixlen,
> +				const char *elt)
>  {
> -	unsigned magic =3D 0;
> +	unsigned magic =3D 0, short_magic =3D 0;
>  	const char *copyfrom =3D elt;
> +	char *match;
>  	int i;
> =20
>  	if (elt[0] !=3D ':') {
> @@ -183,7 +183,7 @@ static const char *prefix_pathspec(const char *pr=
efix, int prefixlen, const char
>  				break;
>  			for (i =3D 0; i < ARRAY_SIZE(pathspec_magic); i++)
>  				if (pathspec_magic[i].mnemonic =3D=3D ch) {
> -					magic |=3D pathspec_magic[i].bit;
> +					short_magic |=3D pathspec_magic[i].bit;
>  					break;
>  				}
>  			if (ARRAY_SIZE(pathspec_magic) <=3D i)
> @@ -194,15 +194,128 @@ static const char *prefix_pathspec(const char =
*prefix, int prefixlen, const char
>  			copyfrom++;
>  	}
> =20
> +	magic |=3D short_magic;
> +	*p_short_magic =3D short_magic;
> +
>  	if (magic & PATHSPEC_FROMTOP)
> -		return xstrdup(copyfrom);
> +		match =3D xstrdup(copyfrom);
>  	else
> -		return prefix_path(prefix, prefixlen, copyfrom);
> +		match =3D prefix_path(prefix, prefixlen, copyfrom);
> +	*raw =3D item->match =3D match;
> +	item->len =3D strlen(item->match);
> +	if (limit_pathspec_to_literal())
> +		item->nowildcard_len =3D item->len;
> +	else
> +		item->nowildcard_len =3D simple_length(item->match);
> +	item->flags =3D 0;
> +	if (item->nowildcard_len < item->len &&
> +	    item->match[item->nowildcard_len] =3D=3D '*' &&
> +	    no_wildcard(item->match + item->nowildcard_len + 1))
> +		item->flags |=3D PATHSPEC_ONESTAR;
> +	return magic;
> +}
> +
> +static int pathspec_item_cmp(const void *a_, const void *b_)
> +{
> +	struct pathspec_item *a, *b;
> +
> +	a =3D (struct pathspec_item *)a_;
> +	b =3D (struct pathspec_item *)b_;
> +	return strcmp(a->match, b->match);
> +}
> +
> +static void NORETURN unsupported_magic(const char *pattern,
> +				       unsigned magic,
> +				       unsigned short_magic)
> +{
> +	struct strbuf sb =3D STRBUF_INIT;
> +	int i, n;
> +	for (n =3D i =3D 0; i < ARRAY_SIZE(pathspec_magic); i++) {
> +		const struct pathspec_magic *m =3D pathspec_magic + i;
> +		if (!(magic & m->bit))
> +			continue;
> +		if (sb.len)
> +			strbuf_addstr(&sb, " ");
> +		if (short_magic & m->bit)
> +			strbuf_addf(&sb, "'%c'", m->mnemonic);
> +		else
> +			strbuf_addf(&sb, "'%s'", m->name);
> +		n++;
> +	}
> +	/*
> +	 * We may want to substitue "this command" with a command
> +	 * name. E.g. when add--interactive dies when running
> +	 * "checkout -p"
> +	 */
> +	die(_("%s: pathspec magic not supported by this command: %s"),
> +	    pattern, sb.buf);
> +}
> +
> +/*
> + * Given command line arguments and a prefix, convert the input to
> + * pathspec. die() any magic in magic_mask is used.
> + */
> +void parse_pathspec(struct pathspec *pathspec,
> +		    unsigned magic_mask, unsigned flags,
> +		    const char *prefix, const char **argv)
> +{
> +	struct pathspec_item *item;
> +	const char *entry =3D argv ? *argv : NULL;
> +	int i, n, prefixlen;
> +
> +	memset(pathspec, 0, sizeof(*pathspec));
> +
> +	/* No arguments, no prefix -> no pathspec */
> +	if (!entry && !prefix)
> +		return;
> +
> +	/* No arguments with prefix -> prefix pathspec */
> +	if (!entry) {
> +		static const char *raw[2];
> +
> +		pathspec->items =3D item =3D xmalloc(sizeof(*item));
> +		memset(item, 0, sizeof(*item));
> +		item->match =3D prefix;
> +		item->nowildcard_len =3D item->len =3D strlen(prefix);
> +		raw[0] =3D prefix;
> +		raw[1] =3D NULL;
> +		pathspec->nr =3D 1;
> +		pathspec->raw =3D raw;
> +		return;
> +	}
> +
> +	n =3D 0;
> +	while (argv[n])
> +		n++;
> +
> +	pathspec->nr =3D n;
> +	pathspec->items =3D item =3D xmalloc(sizeof(*item) * n);
> +	pathspec->raw =3D argv;
> +	prefixlen =3D prefix ? strlen(prefix) : 0;
> +
> +	for (i =3D 0; i < n; i++) {
> +		unsigned short_magic;
> +		entry =3D argv[i];
> +
> +		item[i].magic =3D prefix_pathspec(item + i, &short_magic,
> +						argv + i, flags,
> +						prefix, prefixlen, entry);
> +		if (item[i].magic & magic_mask)
> +			unsupported_magic(entry,
> +					  item[i].magic & magic_mask,
> +					  short_magic);
> +		if (item[i].nowildcard_len < item[i].len)
> +			pathspec->has_wildcard =3D 1;
> +		pathspec->magic |=3D item[i].magic;
> +	}
> +
> +	qsort(pathspec->items, pathspec->nr,
> +	      sizeof(struct pathspec_item), pathspec_item_cmp);
>  }
> =20
>  /*
>   * N.B. get_pathspec() is deprecated in favor of the "struct pathspe=
c"
> - * based interface - see pathspec_magic above.
> + * based interface - see pathspec.c:parse_pathspec().
>   *
>   * Arguments:
>   *  - prefix - a path relative to the root of the working tree
> @@ -221,32 +334,11 @@ static const char *prefix_pathspec(const char *=
prefix, int prefixlen, const char
>   */
>  const char **get_pathspec(const char *prefix, const char **pathspec)
>  {
> -	const char *entry =3D *pathspec;
> -	const char **src, **dst;
> -	int prefixlen;
> -
> -	if (!prefix && !entry)
> -		return NULL;
> -
> -	if (!entry) {
> -		static const char *spec[2];
> -		spec[0] =3D prefix;
> -		spec[1] =3D NULL;
> -		return spec;
> -	}
> -
> -	/* Otherwise we have to re-write the entries.. */
> -	src =3D pathspec;
> -	dst =3D pathspec;
> -	prefixlen =3D prefix ? strlen(prefix) : 0;
> -	while (*src) {
> -		*(dst++) =3D prefix_pathspec(prefix, prefixlen, *src);
> -		src++;
> -	}
> -	*dst =3D NULL;
> -	if (!*pathspec)
> -		return NULL;
> -	return pathspec;
> +	struct pathspec ps;
> +	parse_pathspec(&ps,
> +		       PATHSPEC_ALL_MAGIC & ~PATHSPEC_FROMTOP,
> +		       0, prefix, pathspec);
> +	return ps.raw;
>  }
> =20
>  void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
> diff --git a/pathspec.h b/pathspec.h
> index a621676..937ec91 100644
> --- a/pathspec.h
> +++ b/pathspec.h
> @@ -1,6 +1,10 @@
>  #ifndef PATHSPEC_H
>  #define PATHSPEC_H
> =20
> +/* Pathspec magic */
> +#define PATHSPEC_FROMTOP	(1<<0)
> +#define PATHSPEC_ALL_MAGIC PATHSPEC_FROMTOP
> +
>  #define PATHSPEC_ONESTAR 1	/* the pathspec pattern sastisfies GFNM_O=
NESTAR */
> =20
>  struct pathspec {
> @@ -8,9 +12,11 @@ struct pathspec {
>  	int nr;
>  	unsigned int has_wildcard:1;
>  	unsigned int recursive:1;
> +	unsigned magic;
>  	int max_depth;
>  	struct pathspec_item {
>  		const char *match;
> +		unsigned magic;
>  		int len;
>  		int nowildcard_len;
>  		int flags;
> @@ -18,6 +24,11 @@ struct pathspec {
>  };
> =20
>  extern int init_pathspec(struct pathspec *, const char **);
> +extern void parse_pathspec(struct pathspec *pathspec,
> +			   unsigned magic_mask,
> +			   unsigned flags,
> +			   const char *prefix,
> +			   const char **args);
>  extern void copy_pathspec(struct pathspec *dst, const struct pathspe=
c *src);
>  extern void free_pathspec(struct pathspec *);
