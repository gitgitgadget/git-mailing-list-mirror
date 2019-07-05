Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92B421F461
	for <e@80x24.org>; Fri,  5 Jul 2019 19:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfGETEy (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 15:04:54 -0400
Received: from mout.gmx.net ([212.227.15.15]:41567 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfGETEy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 15:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562353484;
        bh=XA6xE4/jjFUml3RADqzCgPA5ZNxjKFNEBwbuYnVn8eU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FSH5TuUfpQ8syEhy6GmYQfMBrSZfh1JnvR01GHTxZiMUJG+HCFxU7ZIw/ul1pqZ/Z
         UzDrD3OZ0RfyvUnhtMsgPvFpCjYMwQ2j6df5kXreadSrJvjOKiMULL4kNVvipNUQTQ
         ESXml7zKL9tuIwn+BWjjCg/paILCXEY7/LOsYJYU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhlKs-1iE7R635dY-00dnoK; Fri, 05
 Jul 2019 21:04:44 +0200
Date:   Fri, 5 Jul 2019 21:05:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 09/14] range-diff: split lines manually
In-Reply-To: <20190705170630.27500-10-t.gummerer@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907052052060.44@tvgsbejvaqbjf.bet>
References: <20190414210933.20875-1-t.gummerer@gmail.com/> <20190705170630.27500-1-t.gummerer@gmail.com> <20190705170630.27500-10-t.gummerer@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:B8D0awcre7FNcLa6Th9ib/HsYqfQUE5i83YDRnCAY34Y/jyP4Of
 XPTfIs+0Y3GaC8MvmazHtej47GkNSQHp+Hy4HqlNrNAlxLAbWpDD/r83u+jyd1Ft6wrUSGp
 Lce9+oL8+SFbWG+RIaEHvTRldt9MEYcVTC8nm7fpOocKL6qTDAjiT072+R49kVZrWYMN2DX
 A13135spVnYQ5OZjXbfGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c7gnfmv9sXA=:+TmJd7ux36orKVuXIIYpKN
 ug2csT6aoONpY+HHuh29/nc/nVQN5zZYQLuLUTjNzFbcf18fhb1YiVz/2BIRKv4MNUL3w6HVA
 cjn6UexJQCTpvLuVudwaGbd+qFu/WnMp94nWLzNktdgJDf0KQag67UoLqXY09sBkJVpz4dSVw
 493oDKe1UA0NXR9LC8P+X28fQBJd0+Fdb5temFRaaqmFDmHx1utS4zWw0OF7BG3qJmVLGDTZ+
 g6MUW0jodkk8Pr/HltvzzbnmDYg2CgOZ9PV7x/6QH+aLzueZIgQIN/2hx2bNQ7TI7D2R7KgcP
 05Dq7/cttSiK1IG9fvofs9n43TmK7hTWnwxlyC4y0jbobu1wCqyh61vj2qjlxaXUZdxxrakHt
 bFfkeNp7faP2rGI8vGJpxc6/IFWfMX0DrzoZszLoiR1jhUkoGuP5+yR4ESMV6xw3aMbq/JORK
 n2DNXtqQvCMcgVsb1tFeJk7fk7gWj/J/O1zvNo73EQQSTj7z05sdwL9Fi2JuA4xGuYy9h1QTn
 itKlMIbTNGR2hl4oyVDTJ6BiA3hKAkPpxJ1Rr6oAQs4PUvOyFRzvJB8+lZ63QNkzgnl9mkwqB
 YbjRvD9ztIFkJ9NVtfT/4W7rvZvxp1dpshyJfZrPO3yTrDlDCGGUR92fzPU5XmwxT+abzazYw
 8WaHnGICJPDFEPQdvroskI90FkfJ8xb3dsP6Mz0ggbOKzM0BwTPiJxmCoCTzDY/vHZwWsOUts
 i30h7gKznfy6Xe0AdSG906IIADgtTqWqVFKC1fzHzwLfrPJSoWXYsD/6WGOAPFv9NhMKHiA43
 AfxpHKRd5Xwpl47vp7vzKscGfUvCrOjYuja2WpvrMEPIzJ9ArllQ3SwLfyYDhTt4GpkvWl85p
 0zPsnJaWtD7E74u31Cf70yJfAocsBWZk1W4TU1/jeGpsoS5fZ8fKSqklAwcX+VCj6IvfpPyLp
 0sgDFVndsNIzssMqbluS7YjSEsT/xlVEmihlLzHBGnJauKIdFQC1yMT8nFOEVX3gFZIWUqbK0
 UUGYVbTUkU/1e9qq9p0CM1RLBaiamVdwSX9IjvRwaQWymBL3NmRLdHu4dwJqbC3iGVC5CSoe4
 yJFlvBqqjzMITH9w4LePPCVccPsa49QCQJ2
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,


On Fri, 5 Jul 2019, Thomas Gummerer wrote:

> Currently range-diff uses the 'strbuf_getline()' function for doing
> its line by line processing.  In a future patch we want to do parts of
> that parsing using the 'parse_git_header()' function, which does

If you like my suggestion in patch 7/14, this commit message needs to talk
about the new name, too.

> requires reading parts of the input from that function, which doesn't

s/requires/require/

> use strbufs.
>
> Switch range-diff to do our own line by line parsing, so we can re-use
> the parse_git_header function later.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>
> Longer term it might be better to have both range-diff and apply code
> use strbufs.  However I didn't feel it's worth making that change for
> this patch series.

Makes sense.

>  range-diff.c | 69 +++++++++++++++++++++++++++++-----------------------
>  1 file changed, 39 insertions(+), 30 deletions(-)
>
> diff --git a/range-diff.c b/range-diff.c
> index 9242b8975f..916afa44c0 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -24,6 +24,17 @@ struct patch_util {
>  	struct object_id oid;
>  };
>
> +static unsigned long linelen(const char *buffer, unsigned long size)

Shouldn't this be `size_t`?

> +{
> +	unsigned long len =3D 0;

Likewise.

> +	while (size--) {
> +		len++;
> +		if (*buffer++ =3D=3D '\n')
> +			break;
> +	}
> +	return len;

How about

	const char *eol =3D memchr(buffer, '\n', size);

	return !eol ? size : eol + 1 - buffer;

instead?

For an extra brownie point, you could even rename this function to
`find_end_of_line()` and replace the LF by a NUL:

	if (!eol)
		return size;

	*eol =3D '\0';
	return eol + 1 - buffer;

> +}
> +
>  /*
>   * Reads the patches into a string list, with the `util` field being po=
pulated
>   * as struct object_id (will need to be free()d).
> @@ -31,10 +42,12 @@ struct patch_util {
>  static int read_patches(const char *range, struct string_list *list)
>  {
>  	struct child_process cp =3D CHILD_PROCESS_INIT;
> -	FILE *in;
> -	struct strbuf buf =3D STRBUF_INIT, line =3D STRBUF_INIT;
> +	struct strbuf buf =3D STRBUF_INIT, file =3D STRBUF_INIT;

This puzzled me. I'd like to suggest s/file/contents/

>  	struct patch_util *util =3D NULL;
>  	int in_header =3D 1;
> +	char *line;
> +	int offset, len;
> +	size_t size;
>
>  	argv_array_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
>  			"--reverse", "--date-order", "--decorate=3Dno",
> @@ -54,17 +67,15 @@ static int read_patches(const char *range, struct st=
ring_list *list)
>
>  	if (start_command(&cp))
>  		return error_errno(_("could not start `log`"));
> -	in =3D fdopen(cp.out, "r");
> -	if (!in) {
> -		error_errno(_("could not read `log` output"));
> -		finish_command(&cp);
> -		return -1;
> -	}
> +	strbuf_read(&file, cp.out, 0);

Shouldn't we handle a negative return value here, erroring out with "could
not read `log` output" as before?

>
> -	while (strbuf_getline(&line, in) !=3D EOF) {
> +	line =3D strbuf_detach(&file, &size);

I strongly suspect this to leak, given that `line` is subsequently
advanced, and there is no backup copy.

Maybe

	line =3D file.buf;
	size =3D file.len;

would make more sense here?

> +	for (offset =3D 0; size > 0; offset +=3D len, size -=3D len, line +=3D=
 len) {
>  		const char *p;
>
> -		if (skip_prefix(line.buf, "commit ", &p)) {
> +		len =3D linelen(line, size);
> +		line[len - 1] =3D '\0';
> +		if (skip_prefix(line, "commit ", &p)) {
>  			if (util) {
>  				string_list_append(list, buf.buf)->util =3D util;
>  				strbuf_reset(&buf);
> @@ -75,8 +86,6 @@ static int read_patches(const char *range, struct stri=
ng_list *list)
>  				free(util);
>  				string_list_clear(list, 1);
>  				strbuf_release(&buf);
> -				strbuf_release(&line);
> -				fclose(in);

We should release the file contents in `file` (or `contents`, if you like
my suggestions) here.

>  				finish_command(&cp);
>  				return -1;
>  			}
> @@ -85,26 +94,28 @@ static int read_patches(const char *range, struct st=
ring_list *list)
>  			continue;
>  		}
>
> -		if (starts_with(line.buf, "diff --git")) {
> +		if (starts_with(line, "diff --git")) {
>  			in_header =3D 0;
>  			strbuf_addch(&buf, '\n');
>  			if (!util->diff_offset)
>  				util->diff_offset =3D buf.len;
>  			strbuf_addch(&buf, ' ');
> -			strbuf_addbuf(&buf, &line);
> +			strbuf_addstr(&buf, line);
>  		} else if (in_header) {
> -			if (starts_with(line.buf, "Author: ")) {
> -				strbuf_addbuf(&buf, &line);
> +			if (starts_with(line, "Author: ")) {
> +				strbuf_addstr(&buf, line);
>  				strbuf_addstr(&buf, "\n\n");
> -			} else if (starts_with(line.buf, "    ")) {
> -				strbuf_rtrim(&line);
> -				strbuf_addbuf(&buf, &line);
> +			} else if (starts_with(line, "    ")) {
> +				p =3D line + len - 2;
> +				while (isspace(*p) && p >=3D line)
> +					p--;
> +				strbuf_add(&buf, line, p - line + 1);
>  				strbuf_addch(&buf, '\n');
>  			}
>  			continue;
> -		} else if (starts_with(line.buf, "@@ "))
> +		} else if (starts_with(line, "@@ "))
>  			strbuf_addstr(&buf, "@@");
> -		else if (!line.buf[0] || starts_with(line.buf, "index "))
> +		else if (!line[0] || starts_with(line, "index "))
>  			/*
>  			 * A completely blank (not ' \n', which is context)
>  			 * line is not valid in a diff.  We skip it
> @@ -117,25 +128,23 @@ static int read_patches(const char *range, struct =
string_list *list)
>  			 * we are not interested.
>  			 */
>  			continue;
> -		else if (line.buf[0] =3D=3D '>') {
> +		else if (line[0] =3D=3D '>') {
>  			strbuf_addch(&buf, '+');
> -			strbuf_add(&buf, line.buf + 1, line.len - 1);
> -		} else if (line.buf[0] =3D=3D '<') {
> +			strbuf_addstr(&buf, line + 1);
> +		} else if (line[0] =3D=3D '<') {
>  			strbuf_addch(&buf, '-');
> -			strbuf_add(&buf, line.buf + 1, line.len - 1);
> -		} else if (line.buf[0] =3D=3D '#') {
> +			strbuf_addstr(&buf, line + 1);
> +		} else if (line[0] =3D=3D '#') {
>  			strbuf_addch(&buf, ' ');
> -			strbuf_add(&buf, line.buf + 1, line.len - 1);
> +			strbuf_addstr(&buf, line + 1);
>  		} else {
>  			strbuf_addch(&buf, ' ');
> -			strbuf_addbuf(&buf, &line);
> +			strbuf_addstr(&buf, line);
>  		}
>
>  		strbuf_addch(&buf, '\n');
>  		util->diffsize++;
>  	}
> -	fclose(in);
> -	strbuf_release(&line);

We should release the file contents we previously read via `strbuf_read()`=
 here.

Ciao,
Dscho

>
>  	if (util)
>  		string_list_append(list, buf.buf)->util =3D util;
> --
> 2.22.0.510.g264f2c817a
>
>
