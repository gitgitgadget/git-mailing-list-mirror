Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AD423D2A0
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745573654; cv=none; b=HqZZKusWIpAcO3V2LzOgWpRtUaDrMK7uRTOq2SxLXNqMCGvBqS5IJ78EGd4ksuWYXz2JOLXRLlF5dU2mKIw1Vb6rg5hS8HhItRR90YMT9DWYxacgMk3jtuh/6zek015GoNt36AeIRW/v2xwMDAzNdta8geZaMufm41WXJrL/F/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745573654; c=relaxed/simple;
	bh=Yu1ao4JLkSubVf+u1aPxetdW0aYygF89CIgTD/N0KxI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FnqjF5CzJK2CyJhr/59Sr3EtvWCJM57Nu3G0ug6yDqMDSSg3WkzZgatkU6MvdmrAffzv+1tc/e4lAmrfF6URkN9rlb7FgsBmzy482jv15iKkAnJsOIQz++zNZR9wnv4c2SEXDMewo9oUTUpqaETLC8TnV9X8iL5LNTL5pq/cAos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=k3ku1nXH; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="k3ku1nXH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745573642; x=1746178442;
	i=johannes.schindelin@gmx.de;
	bh=H0gY02pMVFFCfhqEqqd3mI1mDsb4fZt7S+bt5GVtIBU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=k3ku1nXHMDvLgrsOQC+BPs4PYi//WyMQ1P15zYqDfIzgj0qYzn8n8DF3nm3lMdzQ
	 1xR8jYYvERlDxuZJWHEU+Hq7xwdxfTX4/Q+LR00yHUT7mSNcZatuydQjXUI3ZYWGl
	 HZkiygJ6Frfpdn3ELWSto5yWWTYmZGtYmyD/9UK9l2YQekmXcv2ufVYEtENOw5Vlj
	 +EuFZWbKECLP4IrRINLVkqgZxDunnwSiIbOtxF/BKcoIhHzd+Zo6HRT4mgWLYBHXn
	 QqowR+riEK26kDwyespZZ3Tyb8IiW2WIhTQt2x1NB+OZtSDBeCBdgI18S23rGwJXe
	 ++MoVuWrBCBOPiH/1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.208.52]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQe5u-1uUhkS1hqQ-00OTAE; Fri, 25
 Apr 2025 11:34:02 +0200
Date: Fri, 25 Apr 2025 11:34:01 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, gitster@pobox.com, peff@peff.net, 
    Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/3] test-tool: add pack-deltas helper
In-Reply-To: <aAsQwSfr-YvS2Mvh@pks.im>
Message-ID: <090ef16f-42a7-8de6-a79e-5a1958e2c103@gmx.de>
References: <pull.1906.git.1745430004.gitgitgadget@gmail.com> <5d4beb202d6ed842de72928462a10a4f5faa2718.1745430004.git.gitgitgadget@gmail.com> <aAsQwSfr-YvS2Mvh@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OKEQMvWS99fjEa6MtSV/ck/0/Fd6rSmUKSkg4LLvhSq/1+C+bh7
 OfuuS+3UtwXFfP/XofR7Yy+qT/CRTQgeR8hNx4yGWBcxm2zEB8G/dtDTYEiWTyoUj4e5QaU
 UmHJaH7+XZmXeWwSk2Zb5BeOxQOTYLRM1T/ntTvYnec9v43Tgl5CvbyGnkmipQry/EhOobM
 wrT7f9N62bfMLbees7OiQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KaPnSpBWQ4k=;3M9D7f5K9bpZ+y0R7H64DOZScDW
 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
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Fri, 25 Apr 2025, Patrick Steinhardt wrote:

> On Wed, Apr 23, 2025 at 05:40:02PM +0000, Derrick Stolee via GitGitGadge=
t wrote:
> > diff --git a/t/helper/test-pack-deltas.c b/t/helper/test-pack-deltas.c
> > new file mode 100644
> > index 00000000000..db7d1c3cd1f
> > --- /dev/null
> > +++ b/t/helper/test-pack-deltas.c
> > @@ -0,0 +1,140 @@
> [snip]
> > +int cmd__pack_deltas(int argc, const char **argv)
> > +{
> > +	int N;
> > +	struct hashfile *f;
> > +	struct strbuf line =3D STRBUF_INIT;
> > +
> > +	if (argc !=3D 2) {
> > +		usage(usage_str);
> > +		return -1;
> > +	}
> > +
> > +	N =3D atoi(argv[1]);
>=20
> Is there a reason why we don't use `parse_options()` here? It might make
> this tool easier to use and extend going forward, and we wouldn't have
> to care about invalid arguments. Right now, we silently accept a
> non-integer argument and do the wrong thing.

I think that `parse_options()` would be overkill here because:

- This is a _mandatory_ argument, not an optional one.

- The required data type is `uint32_t`, and `parse_options()` has no
  support for that.

But you do have a good point in that we may want to validate the data type
(even if technically, this is not a user-facing program, it's a test
helper that is used under tight control by Git's own test suite).

Consequently, I would suggest this fixup instead:

=2D- snipsnap --
Subject: [PATCH] fixup! test-tool: add pack-deltas helper

Let's make the command-line parsing a bit more stringent. We _could_
use `parse_options()`, but that would be overkill for a single,
non-optional argument. Besides, it would not bring any benefit, as the
parsed value needs to fit in the `uint32_t` type, and `parse_options()`
has no provision to ensure that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 t/helper/test-pack-deltas.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-pack-deltas.c b/t/helper/test-pack-deltas.c
index 4af69bdc05d3..f95d8ee16768 100644
=2D-- a/t/helper/test-pack-deltas.c
+++ b/t/helper/test-pack-deltas.c
@@ -8,11 +8,12 @@
 #include "hex.h"
 #include "pack.h"
 #include "pack-objects.h"
+#include "parse.h"
 #include "setup.h"
 #include "strbuf.h"
 #include "string-list.h"
=20
-static const char usage_str[] =3D "test-tool pack-deltas <n>";
+static const char usage_str[] =3D "test-tool pack-deltas <nr_entries>";
=20
 static unsigned long do_compress(void **pptr, unsigned long size)
 {
@@ -79,7 +80,7 @@ static void write_ref_delta(struct hashfile *f,
=20
 int cmd__pack_deltas(int argc, const char **argv)
 {
-	int N;
+	unsigned long n;
 	struct hashfile *f;
 	struct strbuf line =3D STRBUF_INIT;
=20
@@ -88,12 +89,13 @@ int cmd__pack_deltas(int argc, const char **argv)
 		return -1;
 	}
=20
-	N =3D atoi(argv[1]);
+	if (!git_parse_ulong(argv[1], &n) || n !=3D (uint32_t)n)
+		die("invalid number of objects: %s", argv[1]);
=20
 	setup_git_directory();
=20
 	f =3D hashfd(1, "<stdout>");
-	write_pack_header(f, N);
+	write_pack_header(f, n);
=20
 	/* Read each line from stdin into 'line' */
 	while (strbuf_getline_lf(&line, stdin) !=3D EOF) {
=2D-=20
2.49.0.windows.1

