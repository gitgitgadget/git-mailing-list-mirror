Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E62C43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 16:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbiGLQ3u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 12:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiGLQ3t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 12:29:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA88C1FD0
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 09:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657643374;
        bh=X+N3mtDO9jlK+3bz3KsNc05zrrpN8ZnclULR2fx8blg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eZ9W55luXGDqo9ppnjO5/T7NN29x6S8Bbx94D2GmoTvL0AbBHkAZdUFHNsP2dXrfq
         7+UvwG8XxjqMksCVzKcYLniBvN+mSVITb6BCyHxSIDbVZz37zSvae34jAT+MlsLnGD
         FUQPT0ff0NfQPSNZbW+y6kjpfzWsJBTWvbzlutY8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.180.6] ([213.196.212.225]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mt75H-1nHy9X20WP-00tPll; Tue, 12
 Jul 2022 18:29:34 +0200
Date:   Tue, 12 Jul 2022 18:29:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        congdanhqx@gmail.com, christian.couder@gmail.com, avarab@gmail.com,
        gitster@pobox.com, johncai86@gmail.com
Subject: Re: [PATCH v3 1/4] revision: improve commit_rewrite_person()
In-Reply-To: <20220709154149.165524-2-siddharthasthana31@gmail.com>
Message-ID: <98nq3r16-0p93-21p5-0pn6-r36841320903@tzk.qr>
References: <20220707161554.6900-1-siddharthasthana31@gmail.com> <20220709154149.165524-1-siddharthasthana31@gmail.com> <20220709154149.165524-2-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3iAFDyFooJkLOmmhEfLBEofeWV2w3hA2oq7Ffe444p56MQMgoX8
 lbqeAqbll8NrbSHGHyVOKnPq8mTmOWFEyanK0xF+rDgcLTHiJT1JOdMWWEcy2g5AVmA7o1j
 6zClKGTZj7GwdaW6drkhprEUisBTV8cH61lUAibFCcGKpWyZV5PzMdS9YlibRWDoqIbhQeg
 PwYXyIHE72Tf/cWmfIP3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tSw159250No=:FG6MxdUK5QHi+cPG8SCCIL
 bt10kra/lSjFAtSvX5LLhZvP1XomlabeR6S8BTBNyVIZM7ADwV1rarvaIAiProFICHX9RiSWS
 d5o7x7U5IUsh5yB4mmERvlWAKvJH3ezchRS1hc42NO9w6OlPvIbf+USDNY/F663CDJyCgfD9u
 UmQMeRi8xmJH3yYzpi00w9kmo6RGIlXwQq9/CHSdtiWgH9QxkE7AZPLNlL8AX8wyS2YIrvQ7O
 9wGu25vEBhi7Fi6MIMMMZG+ABTHnZpudphYRiXMFypESNz8R2F+kxS6jtpgkela54M+u5Bufb
 VUzNM7Jc+f1MDrN+5u3KN99MKQwk85sdnyS7ypa50coCyWGvspheRESDErvfbiOtAxAa4mHEk
 r/YLtn+0gtt0pKoHOW/9nCL45fgNWbB/26sgCwAFkq/jtTcqiQ6GMIVrki1XulMVE78eHmqGI
 L/7jmeEABjzzUHi8sSrYb0N8GwB4bXVhzdvzemIqhfU9S2J+F6qJ1Ez11yBPXCiNNhRv4I4GW
 2bCCjuhuJac61UiOiZerojGxW2WnWwQ1hkl+5E8lqUUIvdsIfU2u3K+Zw1UIeh+kr6GQ6tuzR
 rQ/9bRFnpIjwPm9NbU4lD85hHPitj7CSKYapMRHIcVYIlanL0XJLAWGGKEPpxr2OdvSsR0677
 R/odiWNjWeypjkBEu4uZv0IRWgTXuycDVOOz6s1XYuZJ/7Q0mRbpl6ERhZL0fmJHKWx6hYP52
 3jypMCgKSIaoz0K294FXqOD7ImTNaggrmgU9M/i1grucqMafulWup+GLERETAHzJz9jqnBDBe
 8krNaXgduOdA1G3zwdmhunR62KmTEhimODR4Id+8aLkwf9cRU0OO6GqxCDkCySVuZgbvev3pV
 uwfvC1eeCYSro8OsikI9hguDbQS7EwnqlPorwnc6BBRCVI0KUjbodDPVCDvMIOMQKwseJhLAx
 ovea8pRp4UBP3Z4rLPHh/7V3R/MELdDCqyXF6pvozHa5OaQKX9tTY+8Wv1iu6XKz0Ic/NtOI5
 2dlEuqd+5phj3wgRU/tBA/iRhkom/QivNokH7E2siacH93h3pG4G75FOmIM/ADmS6sfdLl28A
 we0bjAOV/VetFRN0yw3dOSR+g7z4Ign3fW5WVVh6QkyznVxHSQAVkya4TUcCnA9ZdUFCV7T/b
 oCcnY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Siddarth,

On Sat, 9 Jul 2022, Siddharth Asthana wrote:

> diff --git a/revision.c b/revision.c
> index 211352795c..1939c56c67 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -3792,14 +3791,42 @@ static int commit_rewrite_person(struct strbuf *=
buf, const char *what, struct st
>  			      ident.mail_end - ident.name_begin + 1,
>  			      namemail.buf, namemail.len);
>
> +		newlen =3D namemail.len;
> +
>  		strbuf_release(&namemail);
>
> -		return 1;
> +		return newlen - (ident.mail_end - ident.name_begin + 1);
>  	}
>
>  	return 0;
>  }
>
> +static void commit_rewrite_person(struct strbuf *buf, const char **head=
ers, struct string_list *mailmap)
> +{
> +	size_t buf_offset =3D 0;
> +
> +	if (!mailmap)
> +		return;
> +
> +	for (;;) {
> +		const char *person, *line;
> +		size_t i, linelen;
> +
> +		line =3D buf->buf + buf_offset;
> +		linelen =3D strchrnul(line, '\n') - line + 1;
> +
> +		if (linelen <=3D 1)
> +			/* End of header */
> +			return;

This conditional would probably read much better if it was moved up a few
lines and rewritten like this:

	if (!*line || *line =3D=3D '\n')
		return; /* End of headers */

or even turning the `for (;;)` into

	while (buf->buf[buf_offset] && buf->buf[buf_offset] !=3D '\n')

> +
> +		buf_offset +=3D linelen;

I would prefer to avoid having `linelen` altogether, and instead move the
`buf_offset` assignment _after_ the loop that handles the current header
line (and _not_ modify `buf_offset` inside):

	buf_offset =3D strchrnul(buf->buf + buf_offset, '\n');
	if (buf->buf[buf_offset] =3D=3D '\n')
		buf_offset++;

> +
> +		for (i =3D 0; headers[i]; i++)
> +			if (skip_prefix(line, headers[i], &person))
> +				buf_offset +=3D rewrite_ident_line(person, buf, mailmap);

At this point, we have handled the header and should _not_ continue the
(inner) `for` loop. This is important because `line` is potentially
invalidated by that `rewrite_ident_line()` call. See below for a patch
(which is on top of `shears/seen`, but you get the idea.

This issue could also be avoided by consistently using `buf->buf +
buf_offset` instead of `line`.

> +	}
> +}
> +
>  static int commit_match(struct commit *commit, struct rev_info *opt)
>  {
>  	int retval;

=2D- snipsnap --
=46rom 61dd169def195eee9827a9a670f8dab606279cea Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Tue, 12 Jul 2022 15:10:35 +0200
Subject: [PATCH] fixup??? revision: improve commit_rewrite_person()

When the `linux-musl` job failed in t4203.44 with a segmentation fault,
I became suspicious. From
https://github.com/git-for-windows/git/runs/7301741954?check_suite_focus=
=3Dtrue#step:5:1775:

  + test_config mailmap.file complex.map
  + config_dir=3D
  + test mailmap.file '=3D' -C
  + test_when_finished 'test_unconfig  '"'"'mailmap.file'"'"
  + test 0 '=3D' 0
  + test_cleanup=3D'{ test_unconfig  '"'"'mailmap.file'"'"'
  		} && (exit "$eval_ret"); eval_ret=3D$?; :'
  + git config mailmap.file complex.map
  + git log --use-mailmap --author '<cto@coompany.xx>'
  Segmentation fault (core dumped)
  error: last command exited with $?=3D139

I suspected a memory corruption, and my go-to tool to investigate those
is `valgrind`, so I ran `t4203-*.sh -ivx --valgrind-only=3D44`. It
reported the following:

=2D- snip --
[...]
expecting success of 4203.44 'Only grep replaced author with --use-mailmap=
':
	test_config mailmap.file complex.map &&
	git log --use-mailmap --author "<cto@coompany.xx>" >actual &&
	test_must_be_empty actual

+ test_config mailmap.file complex.map
+ config_dir=3D
+ test mailmap.file =3D -C
+ test_when_finished test_unconfig  'mailmap.file'
+ test 0 =3D 0
+ test_cleanup=3D{ test_unconfig  'mailmap.file'
		} && (exit "$eval_ret"); eval_ret=3D$?; :
+ git config mailmap.file complex.map
+ git log --use-mailmap --author <cto@coompany.xx>
=3D=3D14374=3D=3D Invalid read of size 1
=3D=3D14374=3D=3D    at 0x2EE384: skip_prefix (git-compat-util.h:676)
=3D=3D14374=3D=3D    by 0x2EF31D: apply_mailmap_to_header (ident.c:417)
=3D=3D14374=3D=3D    by 0x3BB045: commit_match (revision.c:3831)
=3D=3D14374=3D=3D    by 0x3BB389: get_commit_action (revision.c:3917)
=3D=3D14374=3D=3D    by 0x3BB934: simplify_commit (revision.c:4005)
=3D=3D14374=3D=3D    by 0x3BBCAD: get_revision_1 (revision.c:4083)
=3D=3D14374=3D=3D    by 0x3BBEF0: get_revision_internal (revision.c:4184)
=3D=3D14374=3D=3D    by 0x3BC192: get_revision (revision.c:4262)
=3D=3D14374=3D=3D    by 0x1A0B05: cmd_log_walk_no_free (log.c:454)
=3D=3D14374=3D=3D    by 0x1A0BCD: cmd_log_walk (log.c:496)
=3D=3D14374=3D=3D    by 0x1A1E90: cmd_log (log.c:818)
=3D=3D14374=3D=3D    by 0x129A04: run_builtin (git.c:466)
=3D=3D14374=3D=3D  Address 0x4b76f4e is 94 bytes inside a block of size 21=
0 free'd
=3D=3D14374=3D=3D    at 0x483DFAF: realloc (in /usr/lib/x86_64-linux-gnu/v=
algrind/vgpreload_memcheck-amd64-linux.so)
=3D=3D14374=3D=3D    by 0x42F908: xrealloc (wrapper.c:136)
=3D=3D14374=3D=3D    by 0x3E6742: strbuf_grow (strbuf.c:99)
=3D=3D14374=3D=3D    by 0x3E6F1F: strbuf_splice (strbuf.c:242)
=3D=3D14374=3D=3D    by 0x2EF220: rewrite_ident_line (ident.c:382)
=3D=3D14374=3D=3D    by 0x2EF338: apply_mailmap_to_header (ident.c:418)
=3D=3D14374=3D=3D    by 0x3BB045: commit_match (revision.c:3831)
=3D=3D14374=3D=3D    by 0x3BB389: get_commit_action (revision.c:3917)
=3D=3D14374=3D=3D    by 0x3BB934: simplify_commit (revision.c:4005)
=3D=3D14374=3D=3D    by 0x3BBCAD: get_revision_1 (revision.c:4083)
=3D=3D14374=3D=3D    by 0x3BBEF0: get_revision_internal (revision.c:4184)
=3D=3D14374=3D=3D    by 0x3BC192: get_revision (revision.c:4262)
=3D=3D14374=3D=3D  Block was alloc'd at
=3D=3D14374=3D=3D    at 0x483B723: malloc (in /usr/lib/x86_64-linux-gnu/va=
lgrind/vgpreload_memcheck-amd64-linux.so)
=3D=3D14374=3D=3D    by 0x483E017: realloc (in /usr/lib/x86_64-linux-gnu/v=
algrind/vgpreload_memcheck-amd64-linux.so)
=3D=3D14374=3D=3D    by 0x42F908: xrealloc (wrapper.c:136)
=3D=3D14374=3D=3D    by 0x3E6742: strbuf_grow (strbuf.c:99)
=3D=3D14374=3D=3D    by 0x3E733D: strbuf_add (strbuf.c:298)
=3D=3D14374=3D=3D    by 0x3AF420: strbuf_addstr (strbuf.h:305)
=3D=3D14374=3D=3D    by 0x3BB027: commit_match (revision.c:3829)
=3D=3D14374=3D=3D    by 0x3BB389: get_commit_action (revision.c:3917)
=3D=3D14374=3D=3D    by 0x3BB934: simplify_commit (revision.c:4005)
=3D=3D14374=3D=3D    by 0x3BBCAD: get_revision_1 (revision.c:4083)
=3D=3D14374=3D=3D    by 0x3BBEF0: get_revision_internal (revision.c:4184)
=3D=3D14374=3D=3D    by 0x3BC192: get_revision (revision.c:4262)
=3D=3D14374=3D=3D
{
   <insert_a_suppression_name_here>
   Memcheck:Addr1
   fun:skip_prefix
   fun:apply_mailmap_to_header
   fun:commit_match
   fun:get_commit_action
   fun:simplify_commit
   fun:get_revision_1
   fun:get_revision_internal
   fun:get_revision
   fun:cmd_log_walk_no_free
   fun:cmd_log_walk
   fun:cmd_log
   fun:run_builtin
}
error: last command exited with $?=3D126
not ok 44 - Only grep replaced author with --use-mailmap
1..44
=2D- snap --

And indeed, we see that the `rewrite_ident_line()` function grows the
strbuf, which can (and does, in this instance) move the buffer to a new
address, which invalidates the `line` pointer, which still points at the
old address.

It might actually make sense to rewrite the entire part of the original
patch where it looks for the end of the header line, so that it avoids
working on pointers altogether, and uses offsets instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 ident.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ident.c b/ident.c
index 5f17bd607dd..fbcf7250aab 100644
=2D-- a/ident.c
+++ b/ident.c
@@ -414,8 +414,10 @@ void apply_mailmap_to_header(struct strbuf *buf, cons=
t char **headers, struct st
 		buf_offset +=3D linelen;

 		for (i =3D 0; headers[i]; i++)
-			if (skip_prefix(line, headers[i], &person))
+			if (skip_prefix(line, headers[i], &person)) {
 				buf_offset +=3D rewrite_ident_line(person, buf, mailmap);
+				break;
+			}
 	}
 }

=2D-
2.37.0.rc2.windows.1.7.g45a475aeb84

