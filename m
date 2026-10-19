Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792429891;
	b=H4KvezFw2mF506B6R0i0de2ZZv/xmIV4wHsWTZSy7YdFuzmszYSq5zfKSmPXduueB+by
	 hODhUHA96kesXmdI6edl7nxIimDh7wZ0Ni/UAV/4HuTkipGtVhdFdhcRw+y5OEbD+FNI/
	 /4vqlnUTkDoHR0QZ6V3YxGuB0vndJziZ2g2sldNBRxkfCsH3a6HowXUyyUGTgdt1Ht5CX
	 GeJpPRb4PtXWx3+XsTTbqAPcBrF140ul1B3mTYp2jYwlXXbaSas3xcxEUfRSUBvvt6qcH
	 ayhLcbDRnhSswuBXFx0LdDbhSM4PBNG7uh07nVBNa6fnU8Zf0OkSojaFyIIKr2CAJTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429891;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:References:Content-Language:
	 Cc:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=d3cT/KDlXkDYX7LMJxt+3ktOgZ2hx8k5lJyLzSOGgw4=;
	b=Pc0lW0EG/iU1qZVrrsD0fwHvDVX65hK0cHX55wYoS3QiVNpS8ivydAZjs+LNGoMfeIWW
	 Ei5gFPs2txScOO/5KrGrENpT9Ot9buQhI3tFuy3Gz+ZVuOP0Fdh5jWnVOqNOusK2+CRrW
	 GwTuLT2YPYBTXsBfD05syMDB0B7UOcv3jS3mcvKwvgdpUmW2vHF0f75Zuky3X/Hi4K0vY
	 drj+S+IOSmFKqBnb18swe5icvMh6k3Dtowga1IGKsN626sPHxxJS2NqevhEPRmvFzh2Ka
	 mg2L18AXgqlVTtC9cYvv6BGrGEjWTNclV/yrbMRE5ZA7BabZHz2H65SPvoYgaGpdRag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=l.s.r@web.de header.a=rsa-sha256 header.s=s29768273 header.b=s7GUwAZh;
	arc=none smtp.remote-ip=212.227.17.12
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A716B606A31B
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 17:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A716B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=l.s.r@web.de header.a=rsa-sha256 header.s=s29768273 header.b=s7GUwAZh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1792429881; x=1793034681; i=l.s.r@web.de;
	bh=d3cT/KDlXkDYX7LMJxt+3ktOgZ2hx8k5lJyLzSOGgw4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=s7GUwAZhBSYzneCo92NcYVqDsiP3PDhQ4JNvtFHb1uy23E2aGtanh39QB/3FOO0n
	 u1QQ2u3yHw8BSwLB5cAIGSXkuj+d6zJDFG83qJi7nr356Z0/f0DMKiqaogTZxUWPD
	 /WW/jfD/smpjrFpWW4q0u93XHKHfiBxvZixziMfdexsng45r34iwBXd+l1iBXw5Xx
	 5iHIQyB/RRhAliwOTMCy4hct8bhuchuk0Zen47Yggyyya3XGmp+jEz3+frJG/CL+u
	 KgvG6l+ej1QpJv/klyaudYv2wM8IJ+7VKWSuLDkaotXzD1x4lTVrfXUk9llgn7aIa
	 beLrFa7khupPIvNMlw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnFyI-1wrWPt33Vk-00jI5M; Mon, 19
 Oct 2026 19:11:21 +0200
Message-ID: <e25693e2-1e32-46ae-945f-0a83b382e8a2@web.de>
Date: Mon, 19 Oct 2026 19:11:21 +0200
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] archive-zip: omit UT extra field if mtime is out of range
To: "Matthew E. Luallen" <m@sph3r3.com>, git@vger.kernel.org
References: <CA+h9NxRT-9QzLGihdL_Bp-yyt1AdXJ79YYgpK-OaegUz8e+HcA@mail.gmail.com>
Content-Language: en-US
Cc: Junio C Hamano <gitster@pobox.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CA+h9NxRT-9QzLGihdL_Bp-yyt1AdXJ79YYgpK-OaegUz8e+HcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+PBMDKZmROAgDjoeOPH0ot+pRnmZvVdVU2xBPt5mUa7Bq8WQ2e0
 dIyd8WjMMjTo65zT76/99mzBjR0UmQU7hDfzV51Evpv/yHEdAlBeVPYyhaNpcYx8/3a8KYH
 WKLINVN6IXtA3e5J6o50t3StVqLOVeCF90Ju4S6E0TNDXrsjXHI1rC0scyCKm/HksHIGZbo
 3BvStKLNIq5QxdkIClWVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vfrGyyxlI/Y=;nT3YGZOn5EsWEGJ9EYUAuzY5o6m
 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
 =

We write an Extended Timestamp Extra Field (ID 0x5455 =3D "UT") for each
zip entry, like Info-ZIP zip(1) does.  Its time values are signed 32-bit
integers (see e.g. https://libzip.org/specifications/extrafld.txt).
Stop emitting them when the commit time doesn't fit in.

Use a strbuf to prepare the extra field up front.  Keep it empty if the
time value is out of range.  Like for the central zip directory we only
care about the length-limited buffer aspect of the strbuf, not about
NUL-termination.  This simplifies the conditional output by avoiding to
repeat the condition.

Reported-by: Matthew E. Luallen <m@sph3r3.com>
Helped-by: Matthew E. Luallen <m@sph3r3.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Changes since v1:
- skip tests of 33-bit timestamp on 32-bit architectures

 archive-zip.c                   | 37 +++++++++++++--------------------
 t/t5004-archive-corner-cases.sh | 28 +++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 6f73ca6d58..785689584c 100644
=2D-- a/archive-zip.c
+++ b/archive-zip.c
@@ -24,6 +24,7 @@ static int zip_time;
=20
 /* We only care about the "buf" part here. */
 static struct strbuf zip_dir;
+static struct strbuf zip_extra_mtime;
=20
 static uintmax_t zip_offset;
 static uint64_t zip_dir_entries;
@@ -81,14 +82,6 @@ struct zip_dir_trailer {
 	unsigned char _end[1];
 };
=20
-struct zip_extra_mtime {
-	unsigned char magic[2];
-	unsigned char extra_size[2];
-	unsigned char flags[1];
-	unsigned char mtime[4];
-	unsigned char _end[1];
-};
-
 struct zip64_extra {
 	unsigned char magic[2];
 	unsigned char extra_size[2];
@@ -129,9 +122,6 @@ struct zip64_dir_trailer_locator {
 #define ZIP64_DATA_DESC_SIZE	offsetof(struct zip64_data_desc, _end)
 #define ZIP_DIR_HEADER_SIZE	offsetof(struct zip_dir_header, _end)
 #define ZIP_DIR_TRAILER_SIZE	offsetof(struct zip_dir_trailer, _end)
-#define ZIP_EXTRA_MTIME_SIZE	offsetof(struct zip_extra_mtime, _end)
-#define ZIP_EXTRA_MTIME_PAYLOAD_SIZE \
-	(ZIP_EXTRA_MTIME_SIZE - offsetof(struct zip_extra_mtime, flags))
 #define ZIP64_EXTRA_SIZE	offsetof(struct zip64_extra, _end)
 #define ZIP64_EXTRA_PAYLOAD_SIZE \
 	(ZIP64_EXTRA_SIZE - offsetof(struct zip64_extra, size))
@@ -299,9 +289,8 @@ static int write_zip_entry(struct archiver_args *args,
 {
 	struct zip_local_header header;
 	uintmax_t offset =3D zip_offset;
-	struct zip_extra_mtime extra;
 	struct zip64_extra extra64;
-	size_t header_extra_size =3D ZIP_EXTRA_MTIME_SIZE;
+	size_t header_extra_size =3D zip_extra_mtime.len;
 	int need_zip64_extra =3D 0;
 	unsigned long attr2;
 	unsigned long compressed_size;
@@ -315,7 +304,7 @@ static int write_zip_entry(struct archiver_args *args,
 	const char *path_without_prefix =3D path + args->baselen;
 	unsigned int creator_version =3D 0;
 	unsigned int version_needed =3D 10;
-	size_t zip_dir_extra_size =3D ZIP_EXTRA_MTIME_SIZE;
+	size_t zip_dir_extra_size =3D zip_extra_mtime.len;
 	size_t zip64_dir_extra_payload_size =3D 0;
=20
 	crc =3D crc32(0, NULL, 0);
@@ -381,11 +370,6 @@ static int write_zip_entry(struct archiver_args *args=
,
 		}
 	}
=20
-	copy_le16(extra.magic, 0x5455);
-	copy_le16(extra.extra_size, ZIP_EXTRA_MTIME_PAYLOAD_SIZE);
-	extra.flags[0] =3D 1;	/* just mtime */
-	copy_le32(extra.mtime, args->time);
-
 	if (size > 0xffffffff || compressed_size > 0xffffffff)
 		need_zip64_extra =3D 1;
 	if (stream && size > 0x7fffffff)
@@ -412,8 +396,8 @@ static int write_zip_entry(struct archiver_args *args,
 	zip_offset +=3D ZIP_LOCAL_HEADER_SIZE;
 	write_or_die(1, path, pathlen);
 	zip_offset +=3D pathlen;
-	write_or_die(1, &extra, ZIP_EXTRA_MTIME_SIZE);
-	zip_offset +=3D ZIP_EXTRA_MTIME_SIZE;
+	write_or_die(1, zip_extra_mtime.buf, zip_extra_mtime.len);
+	zip_offset +=3D zip_extra_mtime.len;
 	if (need_zip64_extra) {
 		copy_le16(extra64.magic, 0x0001);
 		copy_le16(extra64.extra_size, ZIP64_EXTRA_PAYLOAD_SIZE);
@@ -546,7 +530,7 @@ static int write_zip_entry(struct archiver_args *args,
 	strbuf_add_le(&zip_dir, 4, attr2);
 	strbuf_add_le(&zip_dir, 4, clamp32(offset));
 	strbuf_add(&zip_dir, path, pathlen);
-	strbuf_add(&zip_dir, &extra, ZIP_EXTRA_MTIME_SIZE);
+	strbuf_addbuf(&zip_dir, &zip_extra_mtime);
 	if (zip64_dir_extra_payload_size) {
 		strbuf_add_le(&zip_dir, 2, 0x0001);	/* magic */
 		strbuf_add_le(&zip_dir, 2, zip64_dir_extra_payload_size);
@@ -644,12 +628,21 @@ static int write_zip_archive(const struct archiver *=
ar UNUSED,
 	dos_time(&args->time, &zip_date, &zip_time);
=20
 	strbuf_init(&zip_dir, 0);
+	strbuf_init(&zip_extra_mtime, 0);
+
+	if (args->time <=3D 0x7fffffff) {
+		strbuf_add_le(&zip_extra_mtime, 2, 0x5455); /* magic */
+		strbuf_add_le(&zip_extra_mtime, 2, 1 + 4); /* payload size */
+		strbuf_add_le(&zip_extra_mtime, 1, 1); /* flags; just mtime */
+		strbuf_add_le(&zip_extra_mtime, 4, args->time);
+	}
=20
 	err =3D write_archive_entries(args, write_zip_entry);
 	if (!err)
 		write_zip_trailer(args->commit_oid);
=20
 	strbuf_release(&zip_dir);
+	strbuf_release(&zip_extra_mtime);
=20
 	return err;
 }
diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-case=
s.sh
index 768b0ff85d..c776387ad6 100755
=2D-- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -227,4 +227,32 @@ test_expect_success 'tar archive with long paths' '
 	git archive -o long_paths.tar $tree
 '
=20
+test_lazy_prereq ZIPINFO_UT_EXTRA '
+	"$ZIPINFO" -v "$TEST_DIRECTORY"/t5004/big-pack.zip |
+	grep "UT extra field modtime"
+'
+
+test_expect_success TIME_IS_64BIT 'zip archive with 32-bit mtime' '
+	blob=3D$(echo foo | git hash-object -w --stdin) &&
+	tree=3D$(printf "100644 blob $blob\tfile" | git mktree) &&
+	git archive --mtime=3D"@2147483647 +0000" -o with_ut_extra.zip $tree
+'
+
+test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT 'zip archive with mtime=
 exceeding 32-bit' '
+	blob=3D$(echo foo | git hash-object -w --stdin) &&
+	tree=3D$(printf "100644 blob $blob\tfile" | git mktree) &&
+	git archive --mtime=3D"@2147483648 +0000" -o without_ut_extra.zip $tree
+'
+
+test_expect_success TIME_IS_64BIT,ZIPINFO_UT_EXTRA 'UT extra field' '
+	"$ZIPINFO" -v with_ut_extra.zip >actual &&
+	test_grep "UT extra field modtime" actual
+'
+
+test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT,ZIPINFO_UT_EXTRA \
+	'UT extra field omitted when mtime exceeds 32-bit' '
+	"$ZIPINFO" -v without_ut_extra.zip >actual &&
+	test_grep ! "UT extra field modtime" actual
+'
+
 test_done

Interdiff against v1:
  diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-ca=
ses.sh
  index 20bab21048..c776387ad6 100755
  --- a/t/t5004-archive-corner-cases.sh
  +++ b/t/t5004-archive-corner-cases.sh
  @@ -238,7 +238,7 @@ test_expect_success TIME_IS_64BIT 'zip archive with =
32-bit mtime' '
   	git archive --mtime=3D"@2147483647 +0000" -o with_ut_extra.zip $tree
   '
  =20
  -test_expect_success TIME_IS_64BIT 'zip archive with mtime exceeding 32-=
bit' '
  +test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT 'zip archive with mti=
me exceeding 32-bit' '
   	blob=3D$(echo foo | git hash-object -w --stdin) &&
   	tree=3D$(printf "100644 blob $blob\tfile" | git mktree) &&
   	git archive --mtime=3D"@2147483648 +0000" -o without_ut_extra.zip $tre=
e
  @@ -249,7 +249,7 @@ test_expect_success TIME_IS_64BIT,ZIPINFO_UT_EXTRA '=
UT extra field' '
   	test_grep "UT extra field modtime" actual
   '
  =20
  -test_expect_success TIME_IS_64BIT,ZIPINFO_UT_EXTRA \
  +test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT,ZIPINFO_UT_EXTRA \
   	'UT extra field omitted when mtime exceeds 32-bit' '
   	"$ZIPINFO" -v without_ut_extra.zip >actual &&
   	test_grep ! "UT extra field modtime" actual
=2D-=20
2.56.0
