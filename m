Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EDD1F5437
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764687426; cv=none; b=Rg2Xz2tfoYMlHd/Pqr9toHb0821ablzzLy7HRJSP/QHqMaQCDLw+yZBW2uQcZzMU+8QMQ2GY7g6vY5ZkdKewVULeG5d6PpYBIZTR1sLqMEL/twH1+8vG/lvQPT9iI3OCf49u1h7SfBZlUEVX85YYqxNTw3UE3oKw79/BB4EYmU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764687426; c=relaxed/simple;
	bh=Wm3YFbkePypC0p+IKUDVm6OlxgaqDcFsD+305KTX4AQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ab1qRuZfD3yao2KwNSLumKAYM2Hw1fNaj/Pbm6aLAEwVgwwe+H+qkLKfQY3MBXtz2seVTfEUOG25+0vKwi9ermnA+w1ZolyNcE2025XByPZOTt9mTQD0Nc+E3XYz1F5FsH/Vbn8qqFCJuz8j4NZU04VFgtVmelNsUj+oprKIMkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=SipyUXvB; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="SipyUXvB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764687420; x=1765292220;
	i=johannes.schindelin@gmx.de;
	bh=Y/lnV2KuPKbVrM0Le6iG2tZ3rfBuecnsj+rT/BB/JGU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SipyUXvB73rZhaqHenmHj37Tsgk3t0QURbrdLomp1Hyog7YtnEaRVbo0qVdBQQag
	 CAedPH80WJn7o0nSL74Do9HFuTnjwu8CI5OxA440raL/F+d2tZM+N9V6MuyPxQMyd
	 TpwiDosjeo2WYHZuPfrsy1sHZyDHGVvx8Lsx8KVe1ZDw5IrqyAvaUE7zKT38XaC/j
	 HbgCQi0cW+/Iydwuv6pNx0bsN1sLAoczvDZes8YSO5sux5aEl2PXgs+f2hi84eD7x
	 k2CD4Ueplbt8qwUNpHpdYeqrzENjg7mwXjbpS4O+cxMFi72eoFZiqOhdySrgWdNEE
	 rZ7p5ouYg5/Pe7tr5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MowGa-1vrBy93MMg-00ec38; Tue, 02
 Dec 2025 15:56:59 +0100
Date: Tue, 2 Dec 2025 15:56:58 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: phillip.wood@dunelm.org.uk
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 0/3] Sanitize sideband channel messages
In-Reply-To: <8570a129-d66a-465a-905e-0a077c69c409@gmail.com>
Message-ID: <038dc330-3353-25a7-aa58-f4989cdd391c@gmx.de>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com> <8570a129-d66a-465a-905e-0a077c69c409@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1833208380-1764687419=:11010"
X-Provags-ID: V03:K1:uTilY+8caePD8HPmp87xAKW6Mu2CRj6rA9lVc6RRr+lfRoJzV2m
 0FFqie1/fEwIFe8ybzbtFv38LIOZJCmnxMRoT/9RSI3uWc4XVj3zfDrYPM5QXjQe5zTvoyM
 gccrI7d76iKD4HKiDJkAEdmNVdNLtaAQVY2AuNrLu64c38j6xcqrh0Bg1HmTQIBwQ1NlOrP
 koWM1WlZKaigBMaXwhrRQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gNWFvj8Rjzc=;sirIL6vBJaEdjgWnTi+IpkrZrzB
 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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1833208380-1764687419=:11010
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Wed, 15 Jan 2025, Phillip Wood wrote:

> On 14/01/2025 18:19, Johannes Schindelin via GitGitGadget wrote:
> > When a clone fails, users naturally turn to the output of the=C2=A0git
> > clone=C2=A0command. To assist in such scenarios, the output includes t=
he messages
> > from the remote=C2=A0git pack-objects=C2=A0process, delivered via what=
 Git calls the
> > "sideband channel."
> >=20
> > Given that the remote server is, by nature, remote, there is no guaran=
tee
> > that it runs an unmodified Git version. This exposes Git to ANSI escap=
e
> > sequence injection (see
> > CWE-150,=C2=A0https://cwe.mitre.org/data/definitions/150.html), which =
can corrupt
> > terminal state, hide information,
>=20
> I agree we should think about preventing an untrusted remote process fro=
m
> making it look like its messages come from the trusted local process. At=
 best
> it is confusing and at worst it might trick a user into running a malici=
ous
> command if they think the message came from the local git process.

It's actually much worse. With the right approach, you could trick a user
to think that they interact with Git, when in reality they are executing a
command instead.

> We need to be careful not to break existing legitimate output though.

Well, given that that "legitimate output" sends control sequences, whether
the output goes to a terminal window or to a pipe to be parsed by an
application, I don't think that it is _all_ that legitimate.

But then, I don't know why some people keep harping about this when the
patch series as-is already passes those color sequences through by
default?

> Brian has already highlighted the need to support '\e[K' (clear to the
> end of the current line), we may also want to treat '\e[G' (move to
> column 1 on the current line) as '\r' in addition to SGR escapes in the
> last patch.

Consider this: One of the most effective ways to fool a victim is to hide
suspicious information from them. In that respect, it is undesirable to
pass through those sequences that would allow just that.

Besides, color me surprised that this is even necessary? What use case
could there be to erase to the end of the line from a remote process, when
that process' output is supposed to be text that arrives word by word,
line by line, no backsies? What use case would be there to send a Carriage
Return other than to hide the `remote:` prefix?

I did play with the idea of optionally passing through those two
sequences, though, and came up with this patch (don't worry if it does not
apply on top of v1 of this here patch series, my local branch is currently
a bit in flux):

=2D- snip --
diff --git a/sideband.c b/sideband.c
index 0025b51b4e1..f613d4d6cc3 100644
=2D-- a/sideband.c
+++ b/sideband.c
@@ -28,9 +28,42 @@ static struct keyword_entry keywords[] =3D {
 static enum {
 	ALLOW_NO_CONTROL_CHARACTERS =3D 0,
 	ALLOW_ANSI_COLOR_SEQUENCES =3D 1<<0,
-	ALLOW_DEFAULT_ANSI_SEQUENCES =3D ALLOW_ANSI_COLOR_SEQUENCES,
-	ALLOW_ALL_CONTROL_CHARACTERS =3D 1<<1,
-} allow_control_characters =3D ALLOW_ANSI_COLOR_SEQUENCES;
+	ALLOW_ANSI_ERASE_IN_LINE =3D 1<<1,
+	ALLOW_ANSI_CURSOR_HORIZONTAL_ABSOLUTE =3D 1<<2,
+	ALLOW_DEFAULT_ANSI_SEQUENCES =3D
+		ALLOW_ANSI_COLOR_SEQUENCES |
+		ALLOW_ANSI_ERASE_IN_LINE |
+		ALLOW_ANSI_CURSOR_HORIZONTAL_ABSOLUTE,
+	ALLOW_ALL_CONTROL_CHARACTERS =3D 1<<3,
+} allow_control_characters =3D ALLOW_DEFAULT_ANSI_SEQUENCES;
+
+static inline int skip_prefix_in_csv(const char *value, const char *prefi=
x,
+				     const char **out)
+{
+	if (!skip_prefix(value, prefix, &value) ||
+	    (*value && *value !=3D ','))
+		return 0;
+	*out =3D value + !!*value;
+	return 1;
+}
+
+static void parse_allow_control_characters(const char *value)
+{
+	allow_control_characters =3D ALLOW_NO_CONTROL_CHARACTERS;
+	while (*value) {
+		if (skip_prefix_in_csv(value, "default", &value))
+			allow_control_characters |=3D ALLOW_DEFAULT_ANSI_SEQUENCES;
+		else if (skip_prefix_in_csv(value, "color", &value))
+			allow_control_characters |=3D ALLOW_ANSI_COLOR_SEQUENCES;
+		else if (skip_prefix_in_csv(value, "erase-in-line", &value))
+			allow_control_characters |=3D ALLOW_ANSI_ERASE_IN_LINE;
+		else if (skip_prefix_in_csv(value, "cursor-horizontal-absolute", &value=
))
+			allow_control_characters |=3D ALLOW_ANSI_CURSOR_HORIZONTAL_ABSOLUTE;
+		else
+			warning(_("unrecognized value for `sideband."
+				  "allowControlCharacters`: '%s'"), value);
+	}
+}
=20
 /* Returns a color setting (GIT_COLOR_NEVER, etc). */
 static int use_sideband_colors(void)
@@ -54,13 +87,8 @@ static int use_sideband_colors(void)
 		if (git_config_get_string_tmp("sideband.allowcontrolcharacters",
 					      &value))
 			; /* huh? `get_maybe_bool()` returned -1 */
-		else if (!strcmp(value, "default"))
-			allow_control_characters =3D ALLOW_DEFAULT_ANSI_SEQUENCES;
-		else if (!strcmp(value, "color"))
-			allow_control_characters =3D ALLOW_ANSI_COLOR_SEQUENCES;
 		else
-			warning(_("unrecognized value for `sideband."
-				  "allowControlCharacters`: '%s'"), value);
+			parse_allow_control_characters(value);
 		break;
 	default:
 		break; /* not configured */
@@ -93,7 +121,7 @@ void list_config_color_sideband_slots(struct string_lis=
t *list, const char *pref
 		list_config_item(list, prefix, keywords[i].keyword);
 }
=20
-static int handle_ansi_color_sequence(struct strbuf *dest, const char *sr=
c, int n)
+static int handle_ansi_sequence(struct strbuf *dest, const char *src, int=
 n)
 {
 	int i;
=20
@@ -107,12 +135,17 @@ static int handle_ansi_color_sequence(struct strbuf =
*dest, const char *src, int
 	 * https://en.wikipedia.org/wiki/ANSI_escape_code#SGR.
 	 */
=20
-	if (allow_control_characters !=3D ALLOW_ANSI_COLOR_SEQUENCES ||
-	    n < 3 || src[0] !=3D '\x1b' || src[1] !=3D '[')
+	if (n < 3 || src[0] !=3D '\x1b' || src[1] !=3D '[')
 		return 0;
=20
+error("allow: 0x%x", allow_control_characters);
 	for (i =3D 2; i < n; i++) {
-		if (src[i] =3D=3D 'm') {
+		if ((src[i] =3D=3D 'G' &&
+		     (allow_control_characters & ALLOW_ANSI_CURSOR_HORIZONTAL_ABSOLUTE)=
) ||
+		    (src[i] =3D=3D 'K' &&
+		     (allow_control_characters & ALLOW_ANSI_ERASE_IN_LINE)) ||
+		    (src[i] =3D=3D 'm' &&
+		     (allow_control_characters & ALLOW_ANSI_COLOR_SEQUENCES))) {
 			strbuf_add(dest, src, i + 1);
 			return i;
 		}
@@ -127,7 +160,7 @@ static void strbuf_add_sanitized(struct strbuf *dest, =
const char *src, int n)
 {
 	int i;
=20
-	if (allow_control_characters =3D=3D ALLOW_ALL_CONTROL_CHARACTERS) {
+	if ((allow_control_characters & ALLOW_ALL_CONTROL_CHARACTERS)) {
 		strbuf_add(dest, src, n);
 		return;
 	}
@@ -136,7 +169,8 @@ static void strbuf_add_sanitized(struct strbuf *dest, =
const char *src, int n)
 	for (; n && *src; src++, n--) {
 		if (!iscntrl(*src) || *src =3D=3D '\t' || *src =3D=3D '\n')
 			strbuf_addch(dest, *src);
-		else if ((i =3D handle_ansi_color_sequence(dest, src, n))) {
+		else if (allow_control_characters !=3D ALLOW_NO_CONTROL_CHARACTERS &&
+			 (i =3D handle_ansi_sequence(dest, src, n))) {
 			src +=3D i;
 			n -=3D i;
 		} else {
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote=
-messages.sh
index 98c575e2e7f..a59accd0ec2 100755
=2D-- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -104,7 +104,7 @@ test_expect_success 'disallow (color) control sequence=
s in sideband' '
 	printf "error: Have you \\033[31mread\\033[m this?\\a\\n" >&2
 	exec "$@"
 	EOF
-	test_config_global uploadPack.packObjectshook ./color-me-surprised &&
+	test_config_global uploadPack.packObjectsHook ./color-me-surprised &&
 	test_commit need-at-least-one-commit &&
=20
 	git clone --no-local . throw-away 2>stderr &&
@@ -129,4 +129,42 @@ test_expect_success 'disallow (color) control sequenc=
es in sideband' '
 	test_file_not_empty actual
 '
=20
+test_decode_csi() {
+	awk '{
+		while (match($0, /\033/) !=3D 0) {
+			printf "%sCSI ", substr($0, 1, RSTART-1);
+			$0 =3D substr($0, RSTART + RLENGTH, length($0) - RSTART - RLENGTH + 1)=
;
+		}
+		print
+	}'
+}
+
+test_expect_success 'control sequences in sideband allowed by default' '
+	write_script .git/color-me-surprised <<-\EOF &&
+	printf "error: \\033[31mcolor\\033[m\\033[Goverwrite\\033[Gerase\\033[K\=
\033?25l\\n" >&2
+	exec "$@"
+	EOF
+	test_config_global uploadPack.packObjectsHook ./color-me-surprised &&
+	test_commit need-at-least-one-commit-at-least &&
+
+	rm -rf throw-away &&
+	git clone --no-local . throw-away 2>stderr &&
+	test_decode_color <stderr >color-decoded &&
+	test_decode_csi <color-decoded >decoded &&
+	test_grep "CSI \\[K" decoded &&
+	test_grep "CSI \\[G" decoded &&
+	test_grep "\\^\\[?25l" decoded &&
+
+	rm -rf throw-away &&
+	git -c sideband.allowControlCharacters=3Derase-in-line,color \
+		clone --no-local . throw-away 2>stderr &&
+	test_decode_color <stderr >color-decoded &&
+	test_decode_csi <color-decoded >decoded &&
+	test_grep "RED" decoded &&
+	test_grep "CSI \\[K" decoded &&
+	test_grep ! "CSI \\[G" decoded &&
+	test_grep ! "\\^\\[\\[K" decoded &&
+	test_grep "\\^\\[\\[G" decoded
+'
+
 test_done
=2D- snap --

I am not particularly happy about the current shape of the patch because
the functionality it adds is not flexible enough. Currently I am thinking
about some sort of pattern matcher where users could configure
`sideband.allowControlCharacters=3D"CSI [ K, CSI [ G"` or something. Or
`^[[K,^[[G`, i.e. reflecting the sanitized version of the control
sequences that should be passed through instead. But that might be totally
overengineered and not worth it.

After all, I have not received a single complaint about the new default in
Git for Windows, where only color sequences are passed through by default,
and all others are sanitized. which leads me to the very important
conclusion that the concerns that were raised, and that were considered
serious enough to prevent these patches to be included in the embargoed
release, were potentially far, far less concerning than originally
assumed.

Also: The suggestion on the git-security mailing list was to reach out for
input from the wider Git community to be able to come up with a better
solution than the small circle of developers on the git-security mailing
list could. Notwithstanding the fact that already the first reply to my
patch series sent a very strong message that at least one contributor
considered this already a closed case upon arrival, I have to point out
that apart from the ERASE-IN-LINE and CURSOR_HORIZONTAL_ABSOLUTE
suggestions, no other control sequences have been suggested as needing to
be passed through by default. And those suggestions came from someone who
had already been very vocal in the discussion on the git-security mailing
list, so maybe the suggestion to reach out to the wider commmunity was not
actually completely genuine interest in an improved patch series.

Besides, _iff_ there are users who need to enable control sequence
pass-through for anything else than color, they are likely to need that
only for a very small number of repositories, and for repositories whose
remote servers they trust, therefore they can easily just opt out of
sanitizing control sequences in those few repositories.

> > and even insert characters into the input buffer (as if the user had
> > typed those characters).
>=20
> Maybe I've missed something but my understanding from the link above is =
that
> this is a non-issue for terminal emulators released in the last 20 years=
.

Oh, that's incorrect, at least if you talk about control sequences that
insert characters into the input buffer. Those control sequences which let
you query the terminal are used e.g. to determine the current window
dimensions. They very much insert characters into the input buffer. They
have to, there is no other way to return information back to the caller.

Maybe the _particular_ Escape sequence I talked about, to query the
foreground text color, has been quietly disabled in some terminal
emulators (but certainly not in all of them, I know, because I use that
feature in one of my terminal emulators all the time).

But I did caution already in the discussion on the git-security mailing
list against getting hung up with _one particular_ control sequence. Not
only does that forget about all the other wonderful control sequences used
for querying information from the terminal, they also completely neglect
that it is totally within terminal emulators' purview to introduce new
capabilities via new control sequences. Some people in this dicussion
would probably deem that stupid or terrible or something, or even that it
would render the terminal emulator _buggy_, but I'd argue that it's in the
same ballpark as introducing a new `git repo` command and breaking
everybody's setup who already had an `alias.repo`: It is _totally_ within
the remit of Git to introduce such a command _and_ break existing user's
setups that way. Just like it was within the Git project's rights to
rename all `.txt` files in `Documentation/`, breaking tons of existing
deeplinks on the web. Some people outside of the Git project rolled their
eyes about that decision, but they simply had no say in the matter. Same
goes for terminal emulators. The contract is clear: terminal emulators
interpret control sequences, software using them has to be careful what
control sequences it sends and has no vote which control sequences the
terminal emulator chooses to support or not.

Ciao,
Johannes

> In any case I think that that is a security bug in the emulator and
> should be fixed there as it has been in the past. I found [1] to be much
> more informative than the mitre link above about the actual
> vulnerabilities.
>=20
> Best Wishes
>=20
> Phillip
>=20
> [1] https://marc.info/?l=3Dbugtraq&m=3D104612710031920
>=20
> > This patch series addresses this vulnerability by sanitizing the sideb=
and
> > channel.
> >=20
> > It is important to note that the lack of sanitization in the sideband
> > channel is already "exploited" by the Git user community, albeit in
> > well-intentioned ways. For instance, certain server-side hooks use ANS=
I
> > color sequences in error messages to make them more noticeable during
> > intentional failed fetches, e.g. as seen at
> > https://github.com/kikeonline/githook-explode and
> > https://github.com/arosien/bart/blob/HEAD/hooks/post-receive.php
> >=20
> > To accommodate such use cases, Git will allow ANSI color sequences to =
pass
> > through by default, while presenting all other ASCII control character=
s in a
> > common form (e.g., presenting the ESC character as=C2=A0^[).
> >=20
> > This vulnerability was reported to the Git security mailing list in ea=
rly
> > November, along with these fixes, as part of an iteration of the patch=
es
> > that led to the coordinated security release on Tuesday, January 14th,=
 2025.
> >=20
> > While Git for Windows included these fixes in v2.47.1(2), the consensu=
s,
> > apart from one reviewer, was not to include them in Git's embargoed
> > versions. The risk was considered too high to disrupt existing scenari=
os
> > that depend on control characters received via the sideband channel be=
ing
> > sent verbatim to the user's terminal emulator.
> >=20
> > Several reviewers suggested advising terminal emulator writers about t=
hese
> > "quality of implementation issues" instead. I was quite surprised by t=
his
> > approach, as it seems overly optimistic to assume that terminal emulat=
ors
> > could distinguish between control characters intentionally sent by Git=
 and
> > those unintentionally relayed from the remote server.
> >=20
> > Please note that this patch series applies cleanly on top of v2.47.2. =
To
> > apply it cleanly on top of v2.40.4 (the oldest of the most recently se=
rviced
> > security releases), the calls to=C2=A0test_grep=C2=A0need to be replac=
ed with calls
> > to=C2=A0test_i18ngrep, and the calls to=C2=A0git_config_get_string_tmp=
()=C2=A0need to be
> > replaced with calls to=C2=A0git_config_get_string().
> >=20
> > Johannes Schindelin (3):
> > sideband: mask control characters
> > sideband: introduce an "escape hatch" to allow control characters
> > sideband: do allow ANSI color sequences by default
> >=20
> >   Documentation/config.txt            |  2 +
> >   Documentation/config/sideband.txt   | 16 ++++++
> >   sideband.c                          | 78 +++++++++++++++++++++++++++=
+-
> >   t/t5409-colorize-remote-messages.sh | 30 +++++++++++
> >   4 files changed, 124 insertions(+), 2 deletions(-)
> >   create mode 100644 Documentation/config/sideband.txt
> >=20
> >=20
> > base-commit: e1fbebe347426ef7974dc2198f8a277b7c31c8fe
> > Published-As:
> > https://github.com/gitgitgadget/git/releases/tag/pr-1853%2Fdscho%2Fsan=
itize-sideband-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git
> > pr-1853/dscho/sanitize-sideband-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/1853
>=20
>=20

--8323328-1833208380-1764687419=:11010--
