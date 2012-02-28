From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 01/10] Add git-column for columnar display
Date: Tue, 28 Feb 2012 10:10:13 -0800
Message-ID: <7v8vjm25iy.fsf@alter.siamese.dyndns.org>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 28 19:10:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2RVL-0002IK-9V
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 19:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965933Ab2B1SKU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 13:10:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54533 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810Ab2B1SKT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2012 13:10:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FC786E90;
	Tue, 28 Feb 2012 13:10:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8+0LFik460zz
	vKz0mlkK1aWJX6w=; b=AVn9DQ9vbMcXnMwe4YWtzWbbveejes65C0h+leNRcvUP
	ICxYykU8+JREZV5F6UHZlTU6EmUu/ZFi+nEmwJlbtNlIZGJeWVcvny1BFWgNWQqU
	Xopc6939566Unw35FFI9Apvx0DAW1P+F5MkUwD/u04J6/4mKv3fzv8FfSE+aDtw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=S0zv5b
	ZMRDuCJc8JuYBjnNnJ0Ez65Wuq6Xqn6wGtaxjZPs++XtxprDs0wbWZE8n543/qBs
	9IFG9M0uG2oyGMxC91jvlETvlHeF1m1Yx04ahD76S6zCmoyqF8jOWuX1cpive2AF
	daJBjHdYxO755x2Af8Ku5dIz/rHQeYHrry6/o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2A2B6E8F;
	Tue, 28 Feb 2012 13:10:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 28D806E82; Tue, 28 Feb 2012
 13:10:15 -0500 (EST)
In-Reply-To: <1330430331-19945-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 28 Feb
 2012 18:58:42 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 76AFF53A-6237-11E1-948D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191753>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> diff --git a/Documentation/git-column.txt b/Documentation/git-column.=
txt
> new file mode 100644
> index 0000000..508b85f
> --- /dev/null
> +++ b/Documentation/git-column.txt
> @@ -0,0 +1,49 @@
> +git-column(1)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +NAME
> +----
> +git-column - Display data in columns
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git column' [--mode=3D<mode> | --rawmode=3D<n>] [--width=3D<width>]

Please spell this "--raw-mode".

> diff --git a/builtin/column.c b/builtin/column.c
> new file mode 100644
> index 0000000..3b0f74e
> --- /dev/null
> +++ b/builtin/column.c
> @@ -0,0 +1,41 @@
> +#include "builtin.h"
> +#include "cache.h"
> +#include "strbuf.h"
> +#include "parse-options.h"
> +#include "string-list.h"
> +#include "column.h"
> +
> +static const char * const builtin_column_usage[] =3D {
> +	"git column [options]",
> +	NULL
> +};
> +static unsigned int colopts;
> +
> +int cmd_column(int argc, const char **argv, const char *prefix)
> +{
> +	struct string_list list =3D STRING_LIST_INIT_DUP;
> +	struct strbuf sb =3D STRBUF_INIT;
> +	struct column_options copts;
> +	struct option options[] =3D {
> +		OPT_COLUMN(0, "mode", &colopts, "layout to use"),
> +		OPT_INTEGER(0, "rawmode", &colopts, "layout to use"),
> +		OPT_INTEGER(0, "width", &copts.width, "Maximum width"),
> +		OPT_STRING(0, "indent", &copts.indent, "string", "Padding space on=
 left border"),
> +		OPT_INTEGER(0, "nl", &copts.nl, "Padding space on right border"),
> +		OPT_INTEGER(0, "padding", &copts.padding, "Padding space between c=
olumns"),
> +		OPT_END()
> +	};
> +
> +	memset(&copts, 0, sizeof(copts));
> +	copts.width =3D term_columns();
> +	copts.padding =3D 1;
> +	argc =3D parse_options(argc, argv, "", options, builtin_column_usag=
e, 0);

Curious. The usual pattern is to set up the built-in default, call
git_config() to override it with the configured values, and then call
parse_options() to override at the runtime.  I see configuration callba=
ck
defined in column.c but no call to git_config() here?

> +	if (argc)
> +		usage_with_options(builtin_column_usage, options);
> +
> +	while (!strbuf_getline(&sb, stdin, '\n'))
> +		string_list_append(&list, sb.buf);
> +
> +	print_columns(&list, colopts, &copts);
> +	return 0;
> +}
> diff --git a/column.c b/column.c
> new file mode 100644
> index 0000000..d61da81
> --- /dev/null
> +++ b/column.c
> @@ -0,0 +1,170 @@
> +#include "cache.h"
> +#include "column.h"
> +#include "string-list.h"
> +#include "parse-options.h"
> +
> +#define MODE(mode) ((mode) & COL_MODE)
> +
> +/* Display without layout when COL_ENABLED is not set */
> +static void display_plain(const struct string_list *list,
> +			  const char *indent, const char *nl)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < list->nr; i++)
> +		printf("%s%s%s", indent, list->items[i].string, nl);
> +}
> +
> +void print_columns(const struct string_list *list, unsigned int mode=
,
> +		   struct column_options *opts)
> +{
> +	const char *indent =3D "", *nl =3D "\n";
> +	int padding =3D 1, width =3D term_columns();
> +
> +	if (!list->nr)
> +		return;
> +	if (opts) {
> +		if (opts->indent)
> +			indent =3D opts->indent;
> +		if (opts->nl)
> +			nl =3D opts->nl;
> +		if (opts->width)
> +			width =3D opts->width;
> +		padding =3D opts->padding;
> +	}
> +	if (width <=3D 1 || !(mode & COL_ENABLED)) {

Curious why this is "1".  If your terminal is only 2 columns wide, you
wouldn't be able to show your list items in two columns as you would wa=
nt
to have an inter-column gap, no?

> +		display_plain(list, indent, nl);
> +		return;
> +	}
> +	die("BUG: invalid mode %d", MODE(mode));
> +}
> +
> +struct colopt {
> +	enum {
> +		ENABLE,
> +		MODE,
> +		OPTION
> +	} type;
> +	const char *name;
> +	int value;
> +};
> +
> +/*
> + * Set COL_ENABLED and COL_ENABLED_SET. If 'set' is -1, check if
> + * stdout is tty.
> + */
> +static int set_enable_bit(unsigned int *mode, int set, int stdout_is=
_tty)
> +{

Somehow it looks to me that this is setting the ENABLED bit, not enable
bit.

> +	if (set < 0) {	/* auto */
> +		if (stdout_is_tty < 0)
> +			stdout_is_tty =3D isatty(1);
> +		set =3D stdout_is_tty || (pager_in_use() && pager_use_color);

Why does this have anything to do with the use of color?

> +	}
> +	if (set)
> +		*mode =3D *mode | COL_ENABLED | COL_ENABLED_SET;
> +	else
> +		*mode =3D (*mode & ~COL_ENABLED) | COL_ENABLED_SET;
> +	return 0;
> +}

OK, so we record the desired value (either COL_ENABLED or not) and the
fact that a call to set_enable_bit() function set it.  Which implies th=
at
this function must be called from only one codepath (either setting fro=
m
the configuration mechanism, or by parsing the command line option) but
not both.  I guess this is only called from configuration codepath?

> +/*
> + * Set COL_MODE_*. mode is intially copied from column.ui. If
> + * COL_ENABLED_SET is not set, then neither 'always', 'never' nor
> + * 'auto' has been used. Default to 'always'.
> + */
> +static int set_mode(unsigned int *mode, unsigned int value)
> +{
> +	*mode =3D (*mode & ~COL_MODE) | value;
> +	if (!(*mode & COL_ENABLED_SET))
> +		*mode |=3D COL_ENABLED | COL_ENABLED_SET;
> +
> +	return 0;
> +}

I am *imagining* that "*mode" begins with some compiled-in default, the=
n
git_config() will read from column.* variables and set "*mode" but not =
in
this codepath, and by the time command line option triggers this codepa=
th,
we should have seen everything the config wants to tell us, so if the
config did not say anything (i.e. COL_ENABLED_SET is not set yet), we
force enable the feature (the user wanting it to operate in some mode i=
s
an indication enough that the user wants to enable the machinery as a
whole). So this function is designed to be called from command line opt=
ion
parsing, but never from the configuration parsing.

But the parse_option() function below calls this, which would mean it i=
s
also for command line option parsing and not configuration parsing.  Th=
e
same function however calls set_enable_bit() we saw earlier that can on=
ly
be called from configuration codepath.  What is going on?

I am afraid that we do not have enough to judge if this is sane in this
patch, as there is no support for column.ui at this stage.  Perhaps the
series is not structured well and has things that are not yet relevant =
in
early part of it.  Sigh.

The remainder of the patch unreviewed.
