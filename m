Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B4EECAAD3
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 10:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237787AbiIEK57 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 06:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237730AbiIEK5z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 06:57:55 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A159E56B8A
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 03:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1662375467;
        bh=2Dh66P0pBGskj5DPpI5AkmwAmWF4OLxHUVBsQysDdAg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=DAfj8hPZ6gDF7BucmqFd8YGEX3WzutV+pptKHN8F9m64YAVDnfnacg+jx/GCMK4BM
         A4K9pNZbyZCpzlQGXQYW17MzFgPgbvp9uCUjc1OHf4rz3HJoWCua/3TG+PpokQShnH
         FBnFVkCnbbctHX8bcAqPYCVfu/ZsB3MGko1Z9GgQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([91.47.144.123]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsrhK-1pNxNC3Rxg-00t6Pw; Mon, 05
 Sep 2022 12:57:46 +0200
Message-ID: <904b784d-a328-011f-c71a-c2092534e0f7@web.de>
Date:   Mon, 5 Sep 2022 12:57:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH] format-patch: warn if commit msg contains a patch
 delimiter
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, gitster@pobox.com
References: <d0b577825124ac684ab304d3a1395f3d2d0708e8.1662333027.git.matheus.bernardino@usp.br>
 <220905.864jxmme0a.gmgdl@evledraar.gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <220905.864jxmme0a.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wMBEzeQzLmuUnjO6K/sC5D061jQ9nrFbUIFyyMQH2mMuTdeZvj3
 LJB0F7rzebXbqXdMLi54BIzfyF8I90e/Uz5yXhhfp4LLKEOCKEHfj+bL66Q1cfYcLCg6nWp
 Z//bGcYnTEOPeZLittLldb9c5ta9C2psRBxL8b0cn07Wl5bgGPaYMRn19KHabUSG0LOyIfd
 +5Lxx8AwPBP1BGFkKKNFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EFKUknZ36XE=:x5IC9kcpimX+FSo7NC09YX
 sYQtih4GZK4mOU0+LIv2PSkRH5xzIWFFYQpgnGs/sbbnYXNeY6TDidZZc78A6geYoC9r2E+Pi
 rCWhz1Exb3Wug28fgHpDbbmkqJvTfs4nGhU/0JmBBRVaItje3eqK8NpKa7zXKP2P/Bc8mAcDt
 6dGPxnFRa6ImqrdDd5+wWLIv8l1t6izhPVFPE5W3s2gcV56ijqX9x7t9POuh5+Ke7OZUc8l+M
 iSzYp71Ner0ef9m2dZcKaaB/B6zYbAybdt2fpiZ1CRS+yujhm3b818sMr6rirJvAHwh+bb7qy
 7fnJWvw6nEjEoI1PTJOPNekEYoVIRklvku2BabHpXrqsy36DldSwlGJVghnw/G0G7fJDHoMYs
 IfersGqgmn/RGXrHOw1ytTcycyWRxlI6xutDlFhd902lpGyEMkQS+uWd9LA4BQrUHjmqir7bo
 Hd3ApSoDDHWJIfjoQkXCSCjK1pFQ8mU2a8LiM882Vo+XwHsIeYvpVsQ2dnL+XwasIyH0nwkok
 v5573dgtbwEdIDJB/F8aLA2F85PZNzCD6Ii4JnTcTzO+9A6oF+lattIoX/wCKIDx/jg2WS46L
 Yhb/0Bmkwsi3OZF/+mWc0adcGOZtFAKLR5GFLlKFc9pM5Dgt19WTH2IrLL8Zzb3FaGmApfiNZ
 VYl/JNYw00huh4ZOu+QtVMUsMI+UWi7GvimSef0Al9FVAaUA9hITJkdUiMlN+oMFtVDtIVOv9
 s2aUCmrsaFFQFmQhzvk5lDBdtdr1ofDHuKsLe97afUvX7lnX4+GeZWvs50igS2Siu/cSBYXMG
 UO1gmyaGvp6ieosWsoF5JxK8zJC45ytNhX4z6F8vP8gw06+N1lVE5lmygHHhm6oVthfFmE//2
 2TRePz5VIbfbR4l8YoYHOnPpbBsYTt2PV949rjVE4LlZolKiStT/50pws5f6lm96fwwt+P0Y/
 djbtHbvthP3hixpzdL3g8d4DbVWTwETdqSn//2ImgsX4TFFVABb1MNZEAp3SjyC/x67YSXtFO
 W601mZCqLte/Mq0u/Y0qalHu2gsspFpducvyNEr0Xu8kh1z3Sj1oVxsbxHuLLflW3jNnsq7IY
 PnLBomF/CqRLJsIl+M415/9pSzGnEfLWWKX18zKWawwLp8c3OWMttDJGZonz2fv19XCD9O/KB
 ryO3Q=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.09.22 um 10:01 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Sun, Sep 04 2022, Matheus Tavares wrote:
>
>> When applying a patch, `git am` looks for special delimiter strings
>> (such as "---") to know where the message ends and the actual diff
>> starts. If one of these strings appears in the commit message itself,
>> `am` might get confused and fail to apply the patch properly. This has
>> already caused inconveniences in the past [1][2]. To help avoid such
>> problem, let's make `git format-patch` warn on commit messages
>> containing one of the said strings.
>>
>> [1]: https://lore.kernel.org/git/20210113085846-mutt-send-email-mst@ker=
nel.org/
>> [2]: https://lore.kernel.org/git/16297305.cDA1TJNmNo@earendil/
>
> I followed this topic with one eye, and have run into this myself in the
> past. I'm not against this warning, but I wonder if we can't fix
> "am/apply" to just be smarter. The cases I've seen are all ones where:
>
>  * We have a copy/pasted git diff, but we could disambiguate based on
>    (at least) the "---" line being a telltale for the "real" patch, and
>    the "X file changed..." diffstat.
>  * We have a not-quite-git-looking patch diff in the commit message
>    (which we'd normally detect and apply), as in your [2].
>
> Couldn't we just be a bit smarter about applying these, and do a
> look-ahead and find what the user meant.

Whatever we use to separate message from diff can be included in that
message by an unsuspecting user and "---" can be part of a diff.  An
earlier discussion yielded an idea, but no implementation:
https://lore.kernel.org/git/20200204010524-mutt-send-email-mst@kernel.org/

> Is any case, having such a warning won't "settle" this issue, as we're
> able to deal with this non-ambiguity in commit objects/the push/fetch
> protocol. It's just "format-patch/am" as a "wire protocol" that has this
> issue.
>
> But anyway, that's the state of the world now, so warning() about it is
> fair, even if we had a fix for the "apply" part we might want to warn
> for a while to note that it's an issue on older gits.
>
>> +		if (pp->check_in_body_patch_breaks) {
>> +			strbuf_reset(&linebuf);
>> +			strbuf_add(&linebuf, line, linelen);
>> +			if (patchbreak(&linebuf) || is_scissors_line(linebuf.buf)) {
>> +				strbuf_strip_suffix(&linebuf, "\n");
>
> Hrm, it's a (small) shame that the patchbreak() function takes a "struct
> strbuf" rather than a char */size_t in this case (seemingly for no good
> reason, as it's "const"?).

A strbuf is NUL-terminated, a length-limited string (char */size_t)
doesn't have to be.  That means the current implementation can use
functions like starts_with(), but a faithful version that promises to
stay within a given length cannot.  So the reason is probably
convenience.  With skip_prefix_mem() it wouldn't be that bad, though:

=2D--
 mailinfo.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 9621ba62a3..ae2e70e363 100644
=2D-- a/mailinfo.c
+++ b/mailinfo.c
@@ -646,32 +646,30 @@ static void decode_transfer_encoding(struct mailinfo=
 *mi, struct strbuf *line)
 	free(ret);
 }

-static inline int patchbreak(const struct strbuf *line)
+static int patchbreak(const char *buf, size_t len)
 {
-	size_t i;
-
 	/* Beginning of a "diff -" header? */
-	if (starts_with(line->buf, "diff -"))
+	if (skip_prefix_mem(buf, len, "diff -", &buf, &len))
 		return 1;

 	/* CVS "Index: " line? */
-	if (starts_with(line->buf, "Index: "))
+	if (skip_prefix_mem(buf, len, "Index: ", &buf, &len))
 		return 1;

 	/*
 	 * "--- <filename>" starts patches without headers
 	 * "---<sp>*" is a manual separator
 	 */
-	if (line->len < 4)
+	if (len < 4)
 		return 0;

-	if (starts_with(line->buf, "---")) {
+	if (skip_prefix_mem(buf, len, "---", &buf, &len)) {
 		/* space followed by a filename? */
-		if (line->buf[3] =3D=3D ' ' && !isspace(line->buf[4]))
+		if (len > 1 && buf[0] =3D=3D ' ' && !isspace(buf[1]))
 			return 1;
 		/* Just whitespace? */
-		for (i =3D 3; i < line->len; i++) {
-			unsigned char c =3D line->buf[i];
+		for (; len; buf++, len--) {
+			unsigned char c =3D buf[0];
 			if (c =3D=3D '\n')
 				return 1;
 			if (!isspace(c))
@@ -682,14 +680,14 @@ static inline int patchbreak(const struct strbuf *li=
ne)
 	return 0;
 }

-static int is_scissors_line(const char *line)
+static int is_scissors_line(const char *line, size_t len)
 {
 	const char *c;
 	int scissors =3D 0, gap =3D 0;
 	const char *first_nonblank =3D NULL, *last_nonblank =3D NULL;
 	int visible, perforation =3D 0, in_perforation =3D 0;

-	for (c =3D line; *c; c++) {
+	for (c =3D line; len; c++, len--) {
 		if (isspace(*c)) {
 			if (in_perforation) {
 				perforation++;
@@ -705,12 +703,14 @@ static int is_scissors_line(const char *line)
 			perforation++;
 			continue;
 		}
-		if (starts_with(c, ">8") || starts_with(c, "8<") ||
-		    starts_with(c, ">%") || starts_with(c, "%<")) {
+		if (skip_prefix_mem(c, len, ">8", &c, &len) ||
+		    skip_prefix_mem(c, len, "8<", &c, &len) ||
+		    skip_prefix_mem(c, len, ">%", &c, &len) ||
+		    skip_prefix_mem(c, len, "%<", &c, &len)) {
 			in_perforation =3D 1;
 			perforation +=3D 2;
 			scissors +=3D 2;
-			c++;
+			c--, len++;
 			continue;
 		}
 		in_perforation =3D 0;
@@ -747,7 +747,8 @@ static int check_inbody_header(struct mailinfo *mi, co=
nst struct strbuf *line)
 {
 	if (mi->inbody_header_accum.len &&
 	    (line->buf[0] =3D=3D ' ' || line->buf[0] =3D=3D '\t')) {
-		if (mi->use_scissors && is_scissors_line(line->buf)) {
+		if (mi->use_scissors &&
+		    is_scissors_line(line->buf, line->len)) {
 			/*
 			 * This is a scissors line; do not consider this line
 			 * as a header continuation line.
@@ -808,7 +809,7 @@ static int handle_commit_msg(struct mailinfo *mi, stru=
ct strbuf *line)
 	if (convert_to_utf8(mi, line, mi->charset.buf))
 		return 0; /* mi->input_error already set */

-	if (mi->use_scissors && is_scissors_line(line->buf)) {
+	if (mi->use_scissors && is_scissors_line(line->buf, line->len)) {
 		int i;

 		strbuf_setlen(&mi->log_message, 0);
@@ -826,7 +827,7 @@ static int handle_commit_msg(struct mailinfo *mi, stru=
ct strbuf *line)
 		return 0;
 	}

-	if (patchbreak(line)) {
+	if (patchbreak(line->buf, line->len)) {
 		if (mi->message_id)
 			strbuf_addf(&mi->log_message,
 				    "Message-Id: %s\n", mi->message_id);
=2D-
2.37.2

