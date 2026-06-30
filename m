Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCC2233933
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 21:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782855528; cv=none; b=hkrxSIeKsVVi4AneWqt1hbY/ZrzrEwhoqtmF5Ygw7DH7Fs1nfeZpz1avqFk1sE7n0jHfQY3zHW2xeZ0U0m2tCjswnKfSTSaGjt6VDr5PwK00VjA/50r+aY8OQpWqEz1llFN/PTZ8HmDnIwrFg4HeSqhALfvx9kuvBIJVoLqfNBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782855528; c=relaxed/simple;
	bh=mHva+SK4L3315y2ggEXzI34OD0QHtq9F2e6kEH1NdwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ORxp4npprNIyZ9kbSvPqHbHTFWXjWz219RwR7C1Ey9VDi2ueiiBL8b3IflQGLnQiuTZu7GwF5vzopEZiSpwD+7lXtiSs9q4GCIw4BfJ5+h5fUK5kQeCN4HKGurbG73yNcZ8M4CwTlzQ10t6xdG0vGiq7MpDaWduQXJcc8/9+Kpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=jumYri0t; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="jumYri0t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1782855523; x=1783460323; i=l.s.r@web.de;
	bh=hsSMLHdEPzdlgIpZ+BUP8Zu12xfGouzbS1XKtPGZl/I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jumYri0tsLQe35D1PIYuckmmIpn6rD3SBIzLULv/e5DzgVP2Kzmz0fdLP0OI9hAX
	 OacYssgU4wmUF6R5cJPLRGaDFDxORp0+ONaAmEtd4OvL0bsLk9EGle+eFZPWYJM/E
	 ULeZfXiETQcPjgoRQy+fOHcFPN93HsN/cMfnSvU2g3h+OdFKQxYP4UgpK+uPKVoAP
	 hpcpDBg153k6vQyD3YxoLTHWLmL7MVyVp+0vtgTP6Vtp4ZvpSfb8mSvjCGUpLNgT9
	 dBY9xEaAqLeYrn3B/iK5vfOHt5j1y+8iwuu7C/fp6aefvesbPeV7KTXgwoaFcg3Bq
	 2B8m5DFDwFK2xMw3VQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MREzA-1wQQXX36Hs-00VmYk; Tue, 30
 Jun 2026 23:38:43 +0200
Message-ID: <f9761389-8c31-4928-babf-8218e9393376@web.de>
Date: Tue, 30 Jun 2026 23:38:43 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git-blame vs. abbrev
To: Junio C Hamano <gitster@pobox.com>, Laszlo Ersek <laszlo.ersek@posteo.net>
Cc: git@vger.kernel.org
References: <b500479b-14c1-4fbb-a672-1d2cd4852601@posteo.net>
 <xmqqy0fvreps.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqy0fvreps.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TkoE5WWlN8iBuenvUaEDPIC3xfXthOS+7jDufLc8ROec1wxkxp8
 m5UPUUKKb392U1r1eYCvjCBHOLIjuvNvQDIbtdz1+ilAvTata2rLFKDMHdwmxQXUewTzFHq
 Rz/k7884YIY5gqEjXkMDrss1Hxp9sKWvSQz60rNPJCB5yRdK5vADZXpW9X26V4x6tFdcxym
 bCHTS3HpCtQyFDXN/L3eQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6VV+lcIrGaY=;KuWPBelnD3U4+XWnMyJSJPCRmuR
 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
 krlRYkd5v+xJ6ieMghtbxv9nIT6IsiD+mXVI=

On 6/30/26 9:49 PM, Junio C Hamano wrote:
> Laszlo Ersek <laszlo.ersek@posteo.net> writes:
>=20
>> Hi,
>>
>> when git-blame is passed the "-b" option ("Show blank SHA-1 for boundar=
y=20
>> commits"), shouldn't git-blame *stop* reserving a commit hash nibble fo=
r=20
>> the caret that otherwise marks boundary commits?
>>
>> More directly, I find it inconvenient that git-blame shows commit hashe=
s=20
>> that are one nibble longer (13) than my "core.abbrev" (12) setting;=20
>=20
> Just for the sake of aesthetics, I agree that when we are not
> showing the boundary mark, it would make sense not to reserve one
> column that we know we will never use.
Here's a patch to reserve a column only if marks are actually shown.

I strongly suspect that any line can only have a single mark, but I
didn't bother checking and proving whether that's actually true; the
new code should be able to handle multiple marks just fine.

Misses tests.

Ren=C3=A9


=2D--
 builtin/blame.c | 61 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 19 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index ffbd3ce5c5..0e747a43f2 100644
=2D-- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -453,6 +453,39 @@ static void determine_line_heat(struct commit_info *c=
i, const char **dest_color)
 	*dest_color =3D colorfield[i].col;
 }
=20
+static size_t handle_marks(const struct blame_entry *ent, int opt, bool p=
rint)
+{
+	size_t len =3D 0;
+
+	if ((ent->suspect->commit->object.flags & UNINTERESTING) &&
+	    !blank_boundary && !(opt & OUTPUT_ANNOTATE_COMPAT)) {
+		if (print)
+			putchar('^');
+		len++;
+	}
+	if (mark_unblamable_lines && ent->unblamable) {
+		if (print)
+			putchar('*');
+		len++;
+	}
+	if (mark_ignored_lines && ent->ignored) {
+		if (print)
+			putchar('?');
+		len++;
+	}
+	return len;
+}
+
+static size_t print_marks(const struct blame_entry *ent, int opt)
+{
+	return handle_marks(ent, opt, true);
+}
+
+static size_t count_marks(const struct blame_entry *ent, int opt)
+{
+	return handle_marks(ent, opt, false);
+}
+
 static void emit_other(struct blame_scoreboard *sb, struct blame_entry *e=
nt,
 		       int opt, struct blame_entry *prev_ent)
 {
@@ -499,23 +532,10 @@ static void emit_other(struct blame_scoreboard *sb, =
struct blame_entry *ent,
 		if (color)
 			fputs(color, stdout);
=20
-		if (suspect->commit->object.flags & UNINTERESTING) {
-			if (blank_boundary) {
-				memset(hex, ' ', strlen(hex));
-			} else if (!(opt & OUTPUT_ANNOTATE_COMPAT)) {
-				length--;
-				putchar('^');
-			}
-		}
-
-		if (mark_unblamable_lines && ent->unblamable) {
-			length--;
-			putchar('*');
-		}
-		if (mark_ignored_lines && ent->ignored) {
-			length--;
-			putchar('?');
-		}
+		if ((suspect->commit->object.flags & UNINTERESTING) &&
+		    blank_boundary)
+			memset(hex, ' ', strlen(hex));
+		length -=3D print_marks(ent, opt);
=20
 		printf("%.*s", (int)(length < GIT_MAX_HEXSZ ? length : GIT_MAX_HEXSZ), =
hex);
 		if (opt & OUTPUT_ANNOTATE_COMPAT) {
@@ -647,11 +667,15 @@ static void find_alignment(struct blame_scoreboard *=
sb, int *option)
 	struct blame_entry *e;
 	int compute_auto_abbrev =3D (abbrev < 0);
 	int auto_abbrev =3D DEFAULT_ABBREV;
+	size_t max_marks_count =3D 0;
=20
 	for (e =3D sb->ent; e; e =3D e->next) {
 		struct blame_origin *suspect =3D e->suspect;
 		int num;
+		size_t marks_count =3D count_marks(e, *option);
=20
+		if (max_marks_count < marks_count)
+			max_marks_count =3D marks_count;
 		if (compute_auto_abbrev)
 			auto_abbrev =3D update_auto_abbrev(auto_abbrev, suspect);
 		if (strcmp(suspect->path, sb->path))
@@ -685,8 +709,7 @@ static void find_alignment(struct blame_scoreboard *sb=
, int *option)
 	max_score_digits =3D decimal_width(largest_score);
=20
 	if (compute_auto_abbrev)
-		/* one more abbrev length is needed for the boundary commit */
-		abbrev =3D auto_abbrev + 1;
+		abbrev =3D auto_abbrev + max_marks_count;
 }
=20
 static void sanity_check_on_fail(struct blame_scoreboard *sb, int baa)
=2D-=20
2.54.0

