Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED0A31F731
	for <e@80x24.org>; Thu,  8 Aug 2019 22:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732796AbfHHWuJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 18:50:09 -0400
Received: from mout.web.de ([212.227.15.4]:46677 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731914AbfHHWuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 18:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565304596;
        bh=W6PorgdoX2EUxD6N3savb6ildYZgftZIqQ7f1aSU/9g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AcSi9u3YoRCKqDb9JIO9uFFFgYV7+SuPLlgusGQSqAzZSxWOrMm9AEIycKusG++YR
         y8Mta2n6zXYPs4Yzxy8GU/8NyLKyP3zINTQtYA+3ommE8HEKi/MCduAQhuk5zeZ35v
         OFpe9Ut/8iSQG12YgQRcUvhPQ6VzB0AXfwN4V12w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LdJmT-1idxQL1a4X-00iURn; Fri, 09
 Aug 2019 00:49:56 +0200
Subject: Re: [PATCH v2 5/7] quote: add sq_quote_argv_pretty_ltrim
To:     Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.298.git.gitgitgadget@gmail.com>
 <pull.298.v2.git.gitgitgadget@gmail.com>
 <5059776248b6686faaff37c97aa63d0212579cd8.1565273938.git.gitgitgadget@gmail.com>
 <xmqqh86rfs70.fsf@gitster-ct.c.googlers.com>
 <7dbee619-2495-6426-b02b-49fd59e4f028@jeffhostetler.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <60c7b26c-e598-182b-421e-bdf5c0a8ac9f@web.de>
Date:   Fri, 9 Aug 2019 00:49:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7dbee619-2495-6426-b02b-49fd59e4f028@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u9T/jo7xj4NC/H5bcFaaVIISgVzEt+HJi4XRmlFnVW5sP2F1KXA
 1WGstXZX0bG5qqaucCR3ux38ovPPSrnJHT1HM5u9iUc+y/nq8p4LWwdCAR6OBZt0AN9yroE
 dzBZ5lZ1b38po4sgPsJmQ2nhHyD1/6KfI8S0E0CbkcTgb74zVsw69KgEf3HDAnhgCbNBMDF
 Bx6Hs8W8vp7MbXtDNYiCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QoFvoS/7Xc8=:Rq1Ggzxz47f/8Bt9nRwDa0
 neARKLt+XDlgWfIYgJNKTqahEl+1VRoDDT3QkrWJELoYmy+0pUT98RWZzsVuYub9c7si3ue/a
 /AaZ5FnlvJvq7glv0iNX6Y6tmnHfyhcFur8qJvfcuTeC9rX2hmhrtXcbJzDkeAmaFIdEJzUNA
 M6cwjidXq9qwi2oYMFnQeHVgaTo7cGB2pe72OwDFQLYNNIjMyVC5ELPNrgncEcMn1IKO3dwr5
 bH3zx1x6T+RaRHJ3NyFFo9QG4kWUzrHyDFuCi7BCGbQB5FGOoGzsbPBDKU7jQFLsYpWIVqRH9
 Of9FPHONXvcc1MfFdSGu2QKORe05L+0cUiSB/o7XPT+ZDwuLact1Ma5kmERGHpBadmBM0JReg
 Gj7ZPVS++GjFLuxVnZpkIhvpJUmNUAd5Qx0/WwLJEw6NhfGIfciIvnWSxNhxwBGbd1jO58BRS
 +LIhk7dgKwMxtKQQuchQc74BgrpzmzHR2VVBEyKRww2QY70fA0ghoT+OgdCY1JzV7b675uXf/
 MCfaDYlspm66Lh9Tv+V21EAABN3fMJyESwNORagoXAy92LeEZnXADjMGC3UYXscrtgzNjkAWa
 FVVA+A8bci8vHAdfZBca5bCUGekHAxMQEwNdDfFvlqCCS0pZ8sl0Dj8FZ9qdrzaU2+veWCUab
 uFhgG9xV+97pItlnV2fEjQNNWMWIKNRAhthCBI5ncTITirNoF2CAPUvwiRHU92ug64l4tzrvP
 33NgEOf2Hoilxo8IVsOGANMyedQ1Ncecf+QPYqR234K8h93hJyepi6hvlHZ8POu/7611U458/
 1W5kembd+aERvQjC6XvsVbMgjdxyY87hhwoj8oDXLqH5/qrcn6gPWbuaanR67wIeMmGdQyMrq
 E32pk4Hfdy/tj8TqkvEfyjvoPxBPBxRMJBmLHOion+DzV0LaPFCEjscTdU7mkXkLHBeAUjNP/
 VsDrz6jGPznjycYKnfZQm4PLD5GB8BLctP0CsEyMUWAv3T52W/hPNwBqTc5ix1IoKfKxK93wt
 ZVNMblTwq+ccRNN/B9IA+qqa6iJvj7UP4BRAz7R21o6IhMNlqAJ5HGuUH9DDrHVvQ54egqiun
 SPfsbsWhY5Zsg4QJKxSLS4UYCBEScHzBvkL92EIBcNRMfzfaOTSNc/fJr+KBadp9M9KK2+MMQ
 sQQeM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.08.19 um 21:04 schrieb Jeff Hostetler:
> On 8/8/2019 2:05 PM, Junio C Hamano wrote:
>> Having made the primary purpose of the helper clearer leads me to
>> wonder if "do not add SP before the first element, i.e. argv[0]", is
>> really what we want.=C2=A0 If we always clear the *dst strbuf before
>> starting to serialize argv[] into it, then the behaviour would make
>> sense, but we do not---we are "appending".
>>
>> As long as we are appending, would we be better off doing something
>> sillily magical like this instead, I have to wonder?
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0void sq_append_strings_quoted(struct strbuf *bu=
f, const char **av)
>> =C2=A0=C2=A0=C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; av[i]; i++) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
buf->len)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 strbuf_addch(buf, ' ');
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sq_q=
uote_buf_pretty(buf, argv[0]);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> That is, "if we are appending to an existing string, have SP to
>> separate the first element from that existing string; treat the
>> remaining elements the same way (if the buffer is empty, there is no
>> point adding SP at the beginning)".
>
> I don't think that would do what we want.=C2=A0 We don't know what the
> caller's expectations are.=C2=A0 In my uses in commits 6/7 and 7/7 I
> already added the leading chars I wanted in the strbuf before calling
> sq_quote_argv_pretty_ltrim() and assumed the output would be a true
> append.=C2=A0 For example:
>
> +=C2=A0=C2=A0=C2=A0 strbuf_addf(&buf_payload, "alias:%s argv:[", alias);
> +=C2=A0=C2=A0=C2=A0 sq_quote_argv_pretty_ltrim(&buf_payload, argv);
> +=C2=A0=C2=A0=C2=A0 strbuf_addch(&buf_payload, ']');
>
> I like your suggestion of putting my new function in the _append_
> category.=C2=A0 I think I'll add the 3rd arg to this and then it will
> be completely specified and I can get rid of the _ltrim suffix.

Two observations:

If callers want to add something before a joined delimited list, they
already can with a strbuf_add* call.  No need to add that feature to
a function that joins lists.

And repetitions of repetitions (loops) are boring.

Apologies in advance for any coffee stains on your monitor, but
here's how I would start, probably followed by attempts to inline the
functions that become trivial wrappers:

=2D--
 quote.c  | 18 ++++--------------
 strbuf.c | 20 +++++++++++++-------
 strbuf.h |  8 ++++++++
 3 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/quote.c b/quote.c
index 7f2aa6faa4..f422188852 100644
=2D-- a/quote.c
+++ b/quote.c
@@ -74,24 +74,14 @@ void sq_quotef(struct strbuf *dst, const char *fmt, ..=
.)

 void sq_quote_argv(struct strbuf *dst, const char **argv)
 {
-	int i;
-
-	/* Copy into destination buffer. */
-	strbuf_grow(dst, 255);
-	for (i =3D 0; argv[i]; ++i) {
-		strbuf_addch(dst, ' ');
-		sq_quote_buf(dst, argv[i]);
-	}
+	strbuf_addch(dst, ' ');
+	strbuf_map_join_argv(dst, argv, sq_quote_buf, " ");
 }

 void sq_quote_argv_pretty(struct strbuf *dst, const char **argv)
 {
-	int i;
-
-	for (i =3D 0; argv[i]; i++) {
-		strbuf_addch(dst, ' ');
-		sq_quote_buf_pretty(dst, argv[i]);
-	}
+	strbuf_addch(dst, ' ');
+	strbuf_map_join_argv(dst, argv, sq_quote_buf_pretty, " ");
 }

 static char *sq_dequote_step(char *arg, char **next)
diff --git a/strbuf.c b/strbuf.c
index d30f916858..d337853b53 100644
=2D-- a/strbuf.c
+++ b/strbuf.c
@@ -304,17 +304,23 @@ void strbuf_addbuf(struct strbuf *sb, const struct s=
trbuf *sb2)
 	strbuf_setlen(sb, sb->len + sb2->len);
 }

+void strbuf_map_join_argv(struct strbuf *sb, const char **argv,
+			  void (*fn)(struct strbuf *, const char *),
+			  const char *separator)
+{
+	while (*argv) {
+		fn(sb, *argv++);
+		if (*argv)
+			strbuf_addstr(sb, separator);
+	}
+}
+
 const char *strbuf_join_argv(struct strbuf *buf,
 			     int argc, const char **argv, char delim)
 {
-	if (!argc)
-		return buf->buf;
+	char separator[] =3D { delim, '\0' };

-	strbuf_addstr(buf, *argv);
-	while (--argc) {
-		strbuf_addch(buf, delim);
-		strbuf_addstr(buf, *(++argv));
-	}
+	strbuf_map_join_argv(buf, argv, strbuf_addstr, separator);

 	return buf->buf;
 }
diff --git a/strbuf.h b/strbuf.h
index f62278a0be..7adeff94a7 100644
=2D-- a/strbuf.h
+++ b/strbuf.h
@@ -297,6 +297,14 @@ static inline void strbuf_addstr(struct strbuf *sb, c=
onst char *s)
  */
 void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2);

+/**
+ * Apply `fn` to `sb` and each element of the NULL-terminated array
+ * `argv`. Add `separator` between these invocations.
+ */
+void strbuf_map_join_argv(struct strbuf *sb, const char **argv,
+			  void (*fn)(struct strbuf *, const char *),
+			  const char *separator);
+
 /**
  * Join the arguments into a buffer. `delim` is put between every
  * two arguments.
=2D-
2.22.0
