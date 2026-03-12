Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01603FE357
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773336878; cv=none; b=BBrAofzH8kuZRRPtoxZsKxFoNgASdKp5Sc+xn6gAbPLznVTxh6fhzPIARx3y2vorhV0ZC7my234+G6Ii3R01FzJGnufyXJgLE3FoWocw1DtYbmxp4G+6xadLkkUUSAClBSByyZCLIIS4040OyYcgTuFnZwzW65qTkqClTsKF8Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773336878; c=relaxed/simple;
	bh=XR0QkHfxpFeiUHzW6QWGLlz7tJY1NjoEPn0lITvYYk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uf6E0lL5awy6rlHISE4LGsbAATe9ba+lY58u9IpO2j9T1UYSlp/vce0U8U+Sxwh6yviTCeM5JzVN3mCeHFtreFWNWtnYjOioG/Mb6k3TTA892kjfuW/u8l8x3hecinoinDi2RtyBy/dob2AyhEd9hxhMfs8fQibwSKgOIsctrk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=aNUaQh45; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="aNUaQh45"
Received: from piment-oiseau.localnet (unknown [IPv6:2a01:e0a:d1:f360:3d51:7a10:3981:3744])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id AE31CB00571;
	Thu, 12 Mar 2026 18:34:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1773336867;
	bh=XR0QkHfxpFeiUHzW6QWGLlz7tJY1NjoEPn0lITvYYk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aNUaQh459W9nzrXrx2l7G+1dvQOZfuq0kJxa1ZGYiJzVRKTaVFdLChlyJ79ocTeRt
	 etB/CuHCMt01+LrNe9ok1Y2V/dsmY/kYeZ/7sQgiT37E5hZrAVt5aRDsUGc+trOuqf
	 t2LbCogpXom5QUjZXglNN9T3zUWUmbSR9WvUEA0cObQVgD03l38Cx9gTn0AZdiRRb4
	 saNoXJoUn8l0oBRcgVXFo3USPZjeqnzw4tSLNI5nZHItypvK+p14dQ+S5USHEYOpdK
	 UN0bV4tlKHhUlLeeWx7GoKy1B1YJMhu0DxHQ2ZmCBp2OZzhfDuORqXKza7uceaX+KJ
	 5hZYK9mMLLiNw==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, kristofferhaugsbakk@fastmail.com
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 1/3] doc: interpret-trailers: convert to synopsis style
Date: Thu, 12 Mar 2026 18:34:24 +0100
Message-ID: <1953989.tdWV9SEqCh@piment-oiseau>
In-Reply-To: <doc_interpret-tr_synopsis.48b@msgid.xyz>
References:
 <CV_doc_interpret-tr_synopsis.48a@msgid.xyz>
 <doc_interpret-tr_synopsis.48b@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Wednesday, 11 March 2026 23:31:04 CET kristofferhaugsbakk@fastmail.com=20
wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>=20
> See e.g. 0ae23ab5 (doc: convert git worktree to synopsis style,
> 2025-10-05) for the markup rules for this style.
>=20
> There aren=E2=80=99t many subtleties to the transformation of this doc si=
nce it
> doesn=E2=80=99t use any advanced constructs. The only thing is that `": "=
` is
> used instead of `': '` to refer to effective inline-verbatim with
> a space (=E2=90=A0). I also use (_) for emphasis although (') gives the
> same result.
>=20
> Also prefer linking to Git commands instead of saying
> e.g. `git format-patch`.
>=20
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  Documentation/git-interpret-trailers.adoc | 126 +++++++++++-----------
>  1 file changed, 63 insertions(+), 63 deletions(-)
>=20
> diff --git a/Documentation/git-interpret-trailers.adoc
> b/Documentation/git-interpret-trailers.adoc index fd335fe772a..8a6c1bff47=
2=20
100644
> --- a/Documentation/git-interpret-trailers.adoc
> +++ b/Documentation/git-interpret-trailers.adoc
> @@ -7,14 +7,14 @@ git-interpret-trailers - Add or parse structured=20
information in
> commit messages
>=20
>  SYNOPSIS
>  --------
> -[verse]
> -'git interpret-trailers' [--in-place] [--trim-empty]
> +[synopsis]
> +git interpret-trailers [--in-place] [--trim-empty]
>  			[(--trailer (<key>|<key-alias>)
[(=3D|:)<value>])...]
>  			[--parse] [<file>...]
>=20
>  DESCRIPTION
>  -----------
> -Add or parse 'trailer' lines that look similar to RFC 822 e-mail
> +Add or parse _trailer_ lines that look similar to RFC 822 e-mail
>  headers, at the end of the otherwise free-form part of a commit
>  message. For example, in the following commit message
>=20
> @@ -27,10 +27,10 @@ Signed-off-by: Alice <alice@example.com>
>  Signed-off-by: Bob <bob@example.com>
>  ------------------------------------------------
>=20
> -the last two lines starting with "Signed-off-by" are trailers.
> +the last two lines starting with `Signed-off-by` are trailers.
>=20
>  This command reads commit messages from either the
> -<file> arguments or the standard input if no <file> is specified.
> +_<file>_ arguments or the standard input if no _<file>_ is specified.
>  If `--parse` is specified, the output consists of the parsed trailers
>  coming from the input, without influencing them with any command line
>  options or configuration variables.
> @@ -43,7 +43,7 @@ to each input file. The result is emitted on the standa=
rd=20
output.
>=20
>  This command can also operate on the output of linkgit:git-format-patch[=
1],
>  which is more elaborate than a plain commit message. Namely, such output
> -includes a commit message (as above), a "---" divider line, and a patch=
=20
part.
> +includes a commit message (as above), a `---` divider line, and a patch=
=20
part.
>  For these inputs, the divider and patch parts are not modified by
>  this command and are emitted as is on the output, unless
>  `--no-divider` is specified.
> @@ -53,24 +53,24 @@ are applied to each input and the way any existing=20
trailer in
>  the input is changed. They also make it possible to
>  automatically add some trailers.
>=20
> -By default, a '<key>=3D<value>' or '<key>:<value>' argument given
> +By default, a `<key>=3D<value>` or `<key>:<value>` argument given
>  using `--trailer` will be appended after the existing trailers only if
> -the last trailer has a different (<key>, <value>) pair (or if there
> -is no existing trailer). The <key> and <value> parts will be trimmed
> +the last trailer has a different (_<key>_, _<value>_) pair (or if there
> +is no existing trailer). The _<key>_ and _<value>_ parts will be trimmed
>  to remove starting and trailing whitespace, and the resulting trimmed
> -<key> and <value> will appear in the output like this:
> +_<key>_ and _<value>_ will appear in the output like this:
>=20
>  ------------------------------------------------
>  key: value
>  ------------------------------------------------
>=20
> -This means that the trimmed <key> and <value> will be separated by
> -`': '` (one colon followed by one space).
> +This means that the trimmed _<key>_ and _<value>_ will be separated by
> +": " (one colon followed by one space).
>=20
> -For convenience, a <key-alias> can be configured to make using `--traile=
r`
> +For convenience, a _<key-alias>_ can be configured to make using `--
trailer`
>  shorter to type on the command line. This can be configured using the
> -'trailer.<key-alias>.key' configuration variable. The <keyAlias> must be=
 a=20
prefix
> -of the full <key> string, although case sensitivity does not matter. For
> +`trailer.<key-alias>.key` configuration variable. The _<keyAlias>_ must =
be=20


Here, I guess that _<keyAlias>_ is in fact _<key-alias>_ . We do not use=20
camelCase for placeholders.

> a
> prefix +of the full _<key>_ string, although case sensitivity does not=20
matter. For
> example, if you have
>=20
>  ------------------------------------------------
> @@ -91,13 +91,13 @@ least one Git-generated or user-configured trailer an=
d=20
consists
> of at least 25% trailers.
>  The group must be preceded by one or more empty (or whitespace-only) lin=
es.
>  The group must either be at the end of the input or be the last
> -non-whitespace lines before a line that starts with '---' (followed by a
> +non-whitespace lines before a line that starts with `---` (followed by a
>  space or the end of the line).
>=20
>  When reading trailers, there can be no whitespace before or inside the
> -<key>, but any number of regular space and tab characters are allowed
> -between the <key> and the separator. There can be whitespaces before,
> -inside or after the <value>. The <value> may be split over multiple lines
> +_<key>_, but any number of regular space and tab characters are allowed
> +between the _<key>_ and the separator. There can be whitespaces before,
> +inside or after the _<value>_. The _<value>_ may be split over multiple=
=20
lines
>  with each subsequent line starting with at least one whitespace, like
>  the "folding" in RFC 822. Example:
>=20
> @@ -111,77 +111,77 @@ rules for RFC 822 headers. For example they do not=
=20
follow the
> encoding rule.
>=20
>  OPTIONS
>  -------
> ---in-place::
> +`--in-place`::
>  	Edit the files in place.
>=20
> ---trim-empty::
> -	If the <value> part of any trailer contains only whitespace,
> +`--trim-empty`::
> +	If the _<value>_ part of any trailer contains only whitespace,
>  	the whole trailer will be removed from the output.
>  	This applies to existing trailers as well as new trailers.
>=20
> ---trailer <key>[(=3D|:)<value>]::
> -	Specify a (<key>, <value>) pair that should be applied as a
> +`--trailer <key>[(=3D|:)<value>]`::
> +	Specify a (_<key>_, _<value>_) pair that should be applied as a
>  	trailer to the inputs. See the description of this
>  	command.
>=20
> ---where <placement>::
> ---no-where::
> +`--where <placement>`::
> +`--no-where`::
>  	Specify where all new trailers will be added.  A setting
> -	provided with '--where' overrides the `trailer.where` and any
> +	provided with `--where` overrides the `trailer.where` and any
>  	applicable `trailer.<keyAlias>.where` configuration variables

Here also, it's <key-alias> instead of <keyAlias> .

> -	and applies to all '--trailer' options until the next occurrence of
> -	'--where' or '--no-where'. Upon encountering '--no-where', clear the
> -	effect of any previous use of '--where', such that the relevant=20
configuration
> +	and applies to all `--trailer` options until the next occurrence of
> +	`--where` or `--no-where`. Upon encountering `--no-where`, clear the
> +	effect of any previous use of `--where`, such that the relevant=20
configuration
>  	variables are no longer overridden. Possible placements are `after`,
>  	`before`, `end` or `start`.
>=20
> ---if-exists <action>::
> ---no-if-exists::
> +`--if-exists <action>`::
> +`--no-if-exists`::
>  	Specify what action will be performed when there is already at
> -	least one trailer with the same <key> in the input.  A setting
> -	provided with '--if-exists' overrides the `trailer.ifExists` and any
> +	least one trailer with the same _<key>_ in the input.  A setting
> +	provided with `--if-exists` overrides the `trailer.ifExists` and any
>  	applicable `trailer.<keyAlias>.ifExists` configuration variables

Idem

> -	and applies to all '--trailer' options until the next occurrence of
> -	'--if-exists' or '--no-if-exists'. Upon encountering '--no-if-
exists', clear the
> -	effect of any previous use of '--if-exists', such that the relevant=20
configuration
> +	and applies to all `--trailer` options until the next occurrence of
> +	`--if-exists` or `--no-if-exists`. Upon encountering `--no-if-
exists`, clear the
> +	effect of any previous use of `--if-exists`, such that the relevant=20
configuration
> variables are no longer overridden. Possible actions are `addIfDifferent`,
> `addIfDifferentNeighbor`, `add`, `replace` and `doNothing`.
>=20
> ---if-missing <action>::
> ---no-if-missing::
> +`--if-missing <action>`::
> +`--no-if-missing`::
>  	Specify what action will be performed when there is no other
> -	trailer with the same <key> in the input.  A setting
> -	provided with '--if-missing' overrides the `trailer.ifMissing` and=20
any
> +	trailer with the same _<key>_ in the input.  A setting
> +	provided with `--if-missing` overrides the `trailer.ifMissing` and=20
any
>  	applicable `trailer.<keyAlias>.ifMissing` configuration variables

Idem

> -	and applies to all '--trailer' options until the next occurrence of
> -	'--if-missing' or '--no-if-missing'. Upon encountering '--no-if-
missing',
> -	clear the effect of any previous use of '--if-missing', such that=20
the relevant
> +	and applies to all `--trailer` options until the next occurrence of
> +	`--if-missing` or `--no-if-missing`. Upon encountering `--no-if-
missing`,
> +	clear the effect of any previous use of `--if-missing`, such that=20
the relevant
>  	configuration variables are no longer overridden. Possible actions=20
are
> `doNothing` or `add`.
>=20
> ---only-trailers::
> +`--only-trailers`::
>  	Output only the trailers, not any other parts of the input.
>=20
> ---only-input::
> +`--only-input`::
>  	Output only trailers that exist in the input; do not add any
>  	from the command-line or by applying `trailer.*` configuration

The star here stands for a placeholder. Let's name it and use synopsis styl=
e:

`trailer.<key-alias>`

>  	variables.
>=20
> ---unfold::
> +`--unfold`::
>  	If a trailer has a value that runs over multiple lines (aka=20
"folded"),
>  	reformat the value into a single line.
>=20
> ---parse::
> +`--parse`::
>  	A convenience alias for `--only-trailers --only-input
>  	--unfold`. This makes it easier to only see the trailers coming from=20
the
>  	input without influencing them with any command line options or
>  	configuration variables, while also making the output machine-
friendly with
> -	--unfold.
> +	`--unfold`.
>=20
> ---no-divider::
> +`--no-divider`::
>  	Do not treat `---` as the end of the commit message. Use this
>  	when you know your input contains just the commit message itself
> -	(and not an email or the output of `git format-patch`).
> +	(and not an email or the output of linkgit:git-format-patch[1]).
>=20
>  CONFIGURATION VARIABLES
>  -----------------------
> @@ -193,7 +193,7 @@ include::config/trailer.adoc[]
>  EXAMPLES
>  --------
>=20
> -* Configure a 'sign' trailer with a 'Signed-off-by' key, and then
> +* Configure a `sign` trailer with a `Signed-off-by` key, and then
>    add two of these trailers to a commit message file:
>  +
>  ------------
> @@ -230,8 +230,8 @@ Signed-off-by: Bob <bob@example.com>
>  Acked-by: Alice <alice@example.com>
>  ------------
>=20
> -* Extract the last commit as a patch, and add a 'Cc' and a
> -  'Reviewed-by' trailer to it:
> +* Extract the last commit as a patch, and add a `Cc` and a
> +  `Reviewed-by` trailer to it:
>  +
>  ------------
>  $ git format-patch -1
> @@ -239,9 +239,9 @@ $ git format-patch -1
>  $ git interpret-trailers --trailer 'Cc: Alice <alice@example.com>' --
trailer
> 'Reviewed-by: Bob <bob@example.com>' 0001-foo.patch >0001-bar.patch=20
=2D-----------
>=20
> -* Configure a 'sign' trailer with a command to automatically add a
> -  'Signed-off-by: ' with the author information only if there is no
> -  'Signed-off-by: ' already, and show how it works:
> +* Configure a `sign` trailer with a command to automatically add a
> +  "Signed-off-by: " with the author information only if there is no
> +  "Signed-off-by: " already, and show how it works:
>  +
>  ------------
>  $ cat msg1.txt
> @@ -272,7 +272,7 @@ body text
>  Signed-off-by: Alice <alice@example.com>
>  ------------
>=20
> -* Configure a 'fix' trailer with a key that contains a '#' and no
> +* Configure a `fix` trailer with a key that contains a `#` and no
>    space after this character, and show how it works:
>  +
>  ------------
> @@ -284,7 +284,7 @@ subject
>  Fix #42
>  ------------
>=20
> -* Configure a 'help' trailer with a cmd use a script `glog-find-author`
> +* Configure a `help` trailer with a cmd use a script `glog-find-author`
>    which search specified author identity from git log in git repository
>    and show how it works:
>  +
> @@ -308,7 +308,7 @@ Helped-by: Junio C Hamano <gitster@pobox.com>
>  Helped-by: Christian Couder <christian.couder@gmail.com>
>  ------------
>=20
> -* Configure a 'ref' trailer with a cmd use a script `glog-grep`
> +* Configure a `ref` trailer with a cmd use a script `glog-grep`
>    to grep last relevant commit from git log in the git repository
>    and show how it works:
>  +
> @@ -331,7 +331,7 @@ body text
>  Reference-to: 8bc9a0c769 (Add copyright notices., 2005-04-07)
>  ------------
>=20
> -* Configure a 'see' trailer with a command to show the subject of a
> +* Configure a `see` trailer with a command to show the subject of a
>    commit that is related, and show how it works:
>  +
>  ------------
> @@ -359,8 +359,8 @@ See-also: fe3187489d69c4 (subject of related commit)
>  * Configure a commit template with some trailers with empty values
>    (using sed to show and keep the trailing spaces at the end of the
>    trailers), then configure a commit-msg hook that uses
> -  'git interpret-trailers' to remove trailers with empty values and
> -  to add a 'git-version' trailer:
> +  linkgit:git-interpret-trailers[1] to remove trailers with empty values

We are already in the manual page of git-interpret-trailer. It is useless t=
o=20
provide a link to the current manpage.

> and
> +  to add a `git-version` trailer:
>  +
>  ------------
>  $ cat temp.txt
=09
Thanks.



