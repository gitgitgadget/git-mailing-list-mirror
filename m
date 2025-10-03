Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB13156F20
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759521503; cv=none; b=FiVywcaho7qCIOrPcYKBdw8ZSnltxtLXBXQ94YlHaDAw5QXbASqbS4+niKFL5FJnYySmzI4KWUpRcmXgLV0O3WNLSUJ+loI8huqk/l+yD9fVg52FXsWWeTHXsTgsacATJqyyOrYieu13GZTV12qUR1IPilKqak5Dq20RXf3S9ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759521503; c=relaxed/simple;
	bh=cC+6zKDTDzEpU7hWEhns27BD52HVZ51bQf/OG3DjPxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swxFsjGZbZYymumF+HB5ayjFnb0ENk0qm3GDJ3J1x984qjovAIs8HChkxpaQHTzqTHT5wOCf1+0AT+lgmzcIa5qwUSc0d6Dg7/7a6L4EuteAfqjJ7h2BSufXo+Vj8b8FKOZ7C7Klj+CRdHm/lp7H2Vti3E09P3wvPMUCZs2uf3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=LPmaybRI; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="LPmaybRI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759521498; x=1760126298; i=l.s.r@web.de;
	bh=LU8CX/cdlUVkyKtAgcDZPBo59ICjmW1a70293tKDgr0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LPmaybRIgJz9KM452etezGmfCZlKxiIy1bcBi04mw8EfbHID3BHtAYDeskTMm5L+
	 ekd9K0WDerOjgLfdp+qSU46h3kds3jyiH8cyvrff+R9vLiiqDCamTcHdvwsSbkgXY
	 Rma4rAfFJFX+6xIuOW/nsMCkKsILAKrAtP+NCtzYRfUHgr2C2e5iTaaYb3igxWM5I
	 CskqZqWcosRukDKmMEW4dqa82vhRxfiflZtUZZKQaZUXhgq/icwIgSDGm5HfglGld
	 NC5XZwTR+dGgsgf1OZF4HAsD3YK6p37DMAosWBCtT7FOUdwmetOoK5DvLYjmyrSEs
	 QgxgrnEwqX9aSuV5GA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.16.132]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N947J-1uBh2w13f5-00sGL9; Fri, 03
 Oct 2025 21:53:01 +0200
Message-ID: <737e78f5-6337-4964-8385-9c35897f5dff@web.de>
Date: Fri, 3 Oct 2025 21:53:00 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] add-patch: roll over to next undecided hunk
To: Junio C Hamano <gitster@pobox.com>
Cc: "Windl, Ulrich" <u.windl@ukr.de>,
 "git@vger.kernel.org" <git@vger.kernel.org>
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
 <76665b6f-cb92-4694-bc89-5eb21197df34@web.de> <xmqqo6qoufqp.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqo6qoufqp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2rF2oP9eO7/8yuMKiF0VqHc4mZL692Byv2tTQ8Fdnnv85/vLsOi
 rtEL+Rtg2/JmA4TG9GQ1ZkpdQdTn3bJSlOIx/qSR06PuvyvdRSCoSnE0VLvy4BzQ4ebobfS
 rtga2rMMZnA8Zeb+bVzWuuW/Q0ZrEdLG8mikUPjq4lQMCc2q9A1EUMDFkj3cM3MVNiU3SoM
 EvLHqeeFQnRNcVD+cXFAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:g+qZqAq+B3U=;y9lOBToELZqZr2BkKBJPSRovtHt
 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

On 10/3/25 6:11 PM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> git add --patch presents diff hunks one after the other, asking whether
>> to add them.  If we mark some as undecided, e.g. with J, then it will
>=20
> Perhaps "mark" -> "leave".
>=20
> I somehow find it awkward to say "mark as undecided", as I have
> always viewed J/K as a way to skip a hunk, leaving it undecided.
>=20
> Besides, "J" lets you revisit a hunk that you earlier have decided
> to use of hold off, and it leaves your last decision on that hunk.
> A statement that implies "J marks as undecided" is misleading.

Right, j/J/k/K leave the use/skip/undecided status of the current hunk
unchanged.  "leave this hunk undecided" in the documentation is
misleading as well, because these options will not leave a hunk
undecided if we made a decision on it before:

               j - leave this hunk undecided, see next undecided hunk
               J - leave this hunk undecided, see next hunk
               k - leave this hunk undecided, see previous undecided hunk
               K - leave this hunk undecided, see previous hunk

Perhaps omit it?

               j - go to next undecided hunk
               J - go to next hunk
               k - go to previous undecided hunk
               K - go to previous hunk

Weird that one can switch between use and skip, but there's no
way to revert back to undecided.

>> start over after reaching the last hunk.  It always starts over at the
>> very first hunk, though, even if we already decided on it.  Skip
>> decided hunks when rolling over instead.
>=20
> Nicely analyzed.
>=20
>> Reported-by: Windl, Ulrich <u.windl@ukr.de>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  add-patch.c                |  9 ++++++++-
>>  t/t3701-add-interactive.sh | 20 ++++++++++++++++++++
>>  2 files changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/add-patch.c b/add-patch.c
>> index b0389c5d5b..42a8394c92 100644
>> --- a/add-patch.c
>> +++ b/add-patch.c
>> @@ -1436,8 +1436,15 @@ static int patch_update_file(struct add_p_state =
*s,
>>  	render_diff_header(s, file_diff, colored, &s->buf);
>>  	fputs(s->buf.buf, stdout);
>>  	for (;;) {
>> -		if (hunk_index >=3D file_diff->hunk_nr)
>> +		if (hunk_index >=3D file_diff->hunk_nr) {
>>  			hunk_index =3D 0;
>> +			for (i =3D 0; i < file_diff->hunk_nr; i++) {
>> +				if (file_diff->hunk[i].use =3D=3D UNDECIDED_HUNK) {
>> +					hunk_index =3D i;
>> +					break;
>> +				}
>> +			}
>> +		}
>=20
> OK.
>=20
> This is probably a closely related tangent, but last night I was
> looking this function and found that its per-hunk loop does
> completely bogus thing.  For example, find a case where you have
> more than one hunks, among which there are splittable and
> non-splittable hunks (a hunk is splittable if there are context
> lines between an added or a removed line).  Start cycling the hunks
> without making any decisions with "J" or "K".  Once you visited a
> splittable hunk (where you'd see 's' among the possible choices),
> coming back to an unsplittable hunk will now let you split it!  's'
> may not be visible among the choices, but telling it to 's'plit will
> give you "Split into 1", which is a technically correct nonsense.
>=20
> This is because the handling of "permitted" in that function only
> adds, without resetting at the end of processing the current hunk.
> Yet it does something like this:
>=20
> 	for (;;) {
> 		...
> 		strbuf_reset(&s->buf);
> 		if (file_diff->hunk_nr) {
> 			... add choices to the prompt ...
> 			if (hunk->splittable_into > 1) {
> 				permitted |=3D ALLOW_SPLIT;
> 				strbuf_addstr(&s->buf, ",s");
> 			}
> 			...
> 		}
> 		...
> 		printf(_(s->mode->prompt_mode[prompt_mode_type]),
> 		       s->buf.buf);
> 		if (*s->s.reset_color_interactive)
> 			fputs(s->s.reset_color_interactive, stdout);
> 		fflush(stdout);
> 		if (read_single_character(s) =3D=3D EOF)
> 			break;
> 		ch =3D tolower(s->answer.buf[0]);
> 		... dispatch on the command character ...
> 		if (ch =3D=3D 'y') {
> 			...
> 		} else if (s->answer.buf[0] =3D=3D 's') {
> 			size_t splittable_into =3D hunk->splittable_into;
> 			if (!(permitted & ALLOW_SPLIT)) {
> 				err(s, _("Sorry, cannot split this hunk"));
> 			} else if (!split_hunk(s, file_diff,
> 					     hunk - file_diff->hunk)) {
> 				color_fprintf_ln(stdout, s->s.header_color,
> 						 _("Split into %d hunks."),
> 						 (int)splittable_into);
> 				rendered_hunk_index =3D -1;
> 			}
> 		...
>=20
> Notice that the prompt is built correctly but that information is
> *not* used when deciding if the operation is possible?
>=20
> This is another ancient regression that was introduced while
> rewriting this program in C near the end of 2019, I think.  And this
> causes many other bugs in this area, like 'k' at the very first hunk
> gets complaint "No previous hunk" only once (you move to the next
> one with 'j' and come back to the first hunk with 'k', and then 'k'
> no longer complains, even though it is not among the choice).

This should be easy to fix by resetting permitted at the start of the
loop, no?  Patch below.

> With this bug, however, we have gained a bit of useful feature, I
> think.  Even though j/J should not be offered when we are at the
> last hunk for a file, we do wrap-around to the first hunk.  I just
> checked the original code before the C rewrite, and even though it
> were written defensively so that incrementing the current hunk
> number to 5 when you have only 4 hunks would take you back to the
> initial hunk (instead of barfing), because we did not have this
> "permitted is never reset" bug, it actually did not allow you to go
> beyond the end with j/J.  Today's code seems to have inherited this
> defensive adjustment to stay within the available hunks, and with
> the "permitted is never reset" bug, we are taken back to the first
> hunk.
y/n/e on the last hunk roll over, which makes sense to me.  Their
movement part is not mentioned in the documentation, by the way.

With the patch below j/J are stopped by the floor, as seemingly
intended.  Not sure if the (now accidental) roll-over behavior is
better for them.


 add-patch.c                | 19 ++++++++++---------
 t/t3701-add-interactive.sh | 19 +++++++++++++++++++
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 42a8394c92..1012840019 100644
=2D-- a/add-patch.c
+++ b/add-patch.c
@@ -1418,15 +1418,6 @@ static int patch_update_file(struct add_p_state *s,
 	struct child_process cp =3D CHILD_PROCESS_INIT;
 	int colored =3D !!s->colored.len, quit =3D 0, use_pager =3D 0;
 	enum prompt_mode_type prompt_mode_type;
-	enum {
-		ALLOW_GOTO_PREVIOUS_HUNK =3D 1 << 0,
-		ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK =3D 1 << 1,
-		ALLOW_GOTO_NEXT_HUNK =3D 1 << 2,
-		ALLOW_GOTO_NEXT_UNDECIDED_HUNK =3D 1 << 3,
-		ALLOW_SEARCH_AND_GOTO =3D 1 << 4,
-		ALLOW_SPLIT =3D 1 << 5,
-		ALLOW_EDIT =3D 1 << 6
-	} permitted =3D 0;
=20
 	/* Empty added files have no hunks */
 	if (!file_diff->hunk_nr && !file_diff->added)
@@ -1436,6 +1427,16 @@ static int patch_update_file(struct add_p_state *s,
 	render_diff_header(s, file_diff, colored, &s->buf);
 	fputs(s->buf.buf, stdout);
 	for (;;) {
+		enum {
+			ALLOW_GOTO_PREVIOUS_HUNK =3D 1 << 0,
+			ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK =3D 1 << 1,
+			ALLOW_GOTO_NEXT_HUNK =3D 1 << 2,
+			ALLOW_GOTO_NEXT_UNDECIDED_HUNK =3D 1 << 3,
+			ALLOW_SEARCH_AND_GOTO =3D 1 << 4,
+			ALLOW_SPLIT =3D 1 << 5,
+			ALLOW_EDIT =3D 1 << 6
+		} permitted =3D 0;
+
 		if (hunk_index >=3D file_diff->hunk_nr) {
 			hunk_index =3D 0;
 			for (i =3D 0; i < file_diff->hunk_nr; i++) {
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index fa6ec5f835..33b307b8ff 100755
=2D-- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1341,6 +1341,25 @@ test_expect_success 'roll over to next undecided (2=
)' '
 	test_cmp expect hunks
 '
=20
+test_expect_success 'invalid options are rejected' '
+	test_write_lines a b c d e f g h i j k >file &&
+	git add file &&
+	test_write_lines X b c d e f g h X j X >file &&
+	test_write_lines j j J k k K s q | git add -p >out &&
+	sed -ne "s/ @@.*//" -e "s/ \$//" -e "/^(/p" <out >actual &&
+	cat >expect <<-EOF &&
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?
+	(2/2) Stage this hunk [y,n,q,a,d,k,K,g,/,s,e,p,?]? No next hunk
+	(2/2) Stage this hunk [y,n,q,a,d,k,K,g,/,s,e,p,?]? No next hunk
+	(2/2) Stage this hunk [y,n,q,a,d,k,K,g,/,s,e,p,?]?
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? No previous hunk
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? No previous hunk
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? Sorry, cannot split thi=
s hunk
+	(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'set up base for -p color tests' '
 	echo commit >file &&
 	git commit -am "commit state" &&

