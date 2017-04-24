Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80310207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 17:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972018AbdDXRcm (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 13:32:42 -0400
Received: from mout.web.de ([212.227.15.3]:62333 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S971991AbdDXRck (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 13:32:40 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LuLxv-1c1twn00Wd-011hgZ; Mon, 24
 Apr 2017 19:32:38 +0200
Subject: [PATCH v3 4/5] archive-zip: support archives bigger than 4GB
To:     Peter Krefting <peter@softwolves.pp.se>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Keith Goldfarb <keith@blackthorn-media.com>
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org>
 <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se>
 <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org>
 <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
 <e0d1c923-a9f5-9ffc-a7e7-67f558e50796@kdbg.org>
 <alpine.DEB.2.00.1704240901520.31537@ds9.cixit.se>
 <b3f2f12c-2736-46ed-62c9-16334c5e3483@web.de>
 <85f2b6d1-107b-0624-af82-92446f28269e@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <02ddca3c-a11f-7c0c-947e-5ca87a62cdee@web.de>
Date:   Mon, 24 Apr 2017 19:32:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <85f2b6d1-107b-0624-af82-92446f28269e@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:MrqWC1b863RSa4+SILXAKql3lKNqf1J2UOzBLTuKNe80P19dpZO
 95faVxynlGaPIdEL7U/BaM8APjTRfNncH+bv2OOTBm+NoINvP+0mb9dwxseLcaiwaNdm581
 9or22FCXL3WGT4vSb1aY5PktvjwW1oFXBzIaxOlZxVs0GgXDNPwUrFF1PA7LmKjabfl5Q/I
 hDJfLkBcYuIWu9pyAsyNA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bi8DK8sLFmM=:uqr7LBtjWPQJd8vwNpK6Iq
 JDi+aIyR3+ecYbSHuUyV8V4zW0BGcNWw4pUJRAEgPY5+BmIw4zCAA1HRsZV5HvEbqVWNsT7y3
 zwZtBlleeMjpwmj70ClvGrwboxGWvIxpBuqQt2YgSVZtnJlEutZSmeeSaaGy8pgQOss9fbTmx
 R9luerKW07r8VPRlnTMEuyWGMwMIkcIFK5I8zQx7g4zZjg9wMMkD91p4G7JQefy/wkcJnt50R
 AzDmoy45HGMMI2E24RSTrGYsmN2FVT5MQqtDVrEP6l9NJLDNwuzex+Ay5phSyueBmMolS/FEs
 z2350jaH4MXsy2mieZ/N6j0CJ5u2AmmC2VZ/WWjvnKYVp5/9Us7F27NfmS8nsxLBV2Z5HyROG
 +nuwFtmM/DZULVsh2QsaBKDIhDOj03Kx8TWQ8rWHJ0qXB/V7QtfrDx6vjmApHo8dKTOY0bkZE
 1KgOYN0rKK8rmnPyNU8Dbt4pTNjChuZv22lscclBQvmvhSUB+j6+1+ie+UBoEmP1bNbe00mJ/
 e6DQFdOZ0ilf2kof0d6iEp90fLpTeA78+R4LIFYUKjDUfR+pGNWGp68dn0G2ic7UPiLm/E3VH
 +l8F7dvZjIaZfglRdY4vuvcTLrZH79+Qr9Agqc04faYfyNk6CrzRrgC0hrSpgpJIcu8xv5W7a
 Zn/XSMluBdfAQIHZLqq086abkJoCWYj/nd08SDUhIqcBb83nKOwvkIoWEsTEClGC0by0ufeMk
 i3CJ2fUE+bKyYnJN/AY8Rc2z/5rUsddBxsBRmVQeRsV3HQJiIP36RtNo7H12gCf4chR2B9K3E
 9gsNxgd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a zip64 extended information extra field to the central directory
and emit the zip64 end of central directory records as well as locator
if the offset of an entry within the archive exceeds 4GB.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 archive-zip.c                   | 32 ++++++++++++++++++++++++++++----
 t/t5004-archive-corner-cases.sh |  2 +-
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 2d52bb3ade..7d6f2a85d0 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -14,7 +14,7 @@ static int zip_time;
 /* We only care about the "buf" part here. */
 static struct strbuf zip_dir;
 
-static unsigned int zip_offset;
+static uintmax_t zip_offset;
 static uint64_t zip_dir_entries;
 
 static unsigned int max_creator_version;
@@ -145,6 +145,11 @@ static void copy_le16_clamp(unsigned char *dest, uint64_t n, int *clamped)
 	copy_le16(dest, clamp_max(n, 0xffff, clamped));
 }
 
+static void copy_le32_clamp(unsigned char *dest, uint64_t n, int *clamped)
+{
+	copy_le32(dest, clamp_max(n, 0xffffffff, clamped));
+}
+
 static int strbuf_add_le(struct strbuf *sb, size_t size, uintmax_t n)
 {
 	while (size-- > 0) {
@@ -154,6 +159,12 @@ static int strbuf_add_le(struct strbuf *sb, size_t size, uintmax_t n)
 	return -!!n;
 }
 
+static uint32_t clamp32(uintmax_t n)
+{
+	const uintmax_t max = 0xffffffff;
+	return (n < max) ? n : max;
+}
+
 static void *zlib_deflate_raw(void *data, unsigned long size,
 			      int compression_level,
 			      unsigned long *compressed_size)
@@ -254,6 +265,8 @@ static int write_zip_entry(struct archiver_args *args,
 	int is_binary = -1;
 	const char *path_without_prefix = path + args->baselen;
 	unsigned int creator_version = 0;
+	size_t zip_dir_extra_size = ZIP_EXTRA_MTIME_SIZE;
+	size_t zip64_dir_extra_payload_size = 0;
 
 	crc = crc32(0, NULL, 0);
 
@@ -433,6 +446,11 @@ static int write_zip_entry(struct archiver_args *args,
 	free(deflated);
 	free(buffer);
 
+	if (offset > 0xffffffff) {
+		zip64_dir_extra_payload_size += 8;
+		zip_dir_extra_size += 2 + 2 + zip64_dir_extra_payload_size;
+	}
+
 	strbuf_add_le(&zip_dir, 4, 0x02014b50);	/* magic */
 	strbuf_add_le(&zip_dir, 2, creator_version);
 	strbuf_add_le(&zip_dir, 2, 10);		/* version */
@@ -444,14 +462,20 @@ static int write_zip_entry(struct archiver_args *args,
 	strbuf_add_le(&zip_dir, 4, compressed_size);
 	strbuf_add_le(&zip_dir, 4, size);
 	strbuf_add_le(&zip_dir, 2, pathlen);
-	strbuf_add_le(&zip_dir, 2, ZIP_EXTRA_MTIME_SIZE);
+	strbuf_add_le(&zip_dir, 2, zip_dir_extra_size);
 	strbuf_add_le(&zip_dir, 2, 0);		/* comment length */
 	strbuf_add_le(&zip_dir, 2, 0);		/* disk */
 	strbuf_add_le(&zip_dir, 2, !is_binary);
 	strbuf_add_le(&zip_dir, 4, attr2);
-	strbuf_add_le(&zip_dir, 4, offset);
+	strbuf_add_le(&zip_dir, 4, clamp32(offset));
 	strbuf_add(&zip_dir, path, pathlen);
 	strbuf_add(&zip_dir, &extra, ZIP_EXTRA_MTIME_SIZE);
+	if (zip64_dir_extra_payload_size) {
+		strbuf_add_le(&zip_dir, 2, 0x0001);	/* magic */
+		strbuf_add_le(&zip_dir, 2, zip64_dir_extra_payload_size);
+		if (offset >= 0xffffffff)
+			strbuf_add_le(&zip_dir, 8, offset);
+	}
 	zip_dir_entries++;
 
 	return 0;
@@ -494,7 +518,7 @@ static void write_zip_trailer(const unsigned char *sha1)
 			&clamped);
 	copy_le16_clamp(trailer.entries, zip_dir_entries, &clamped);
 	copy_le32(trailer.size, zip_dir.len);
-	copy_le32(trailer.offset, zip_offset);
+	copy_le32_clamp(trailer.offset, zip_offset, &clamped);
 	copy_le16(trailer.comment_length, sha1 ? GIT_SHA1_HEXSZ : 0);
 
 	write_or_die(1, zip_dir.buf, zip_dir.len);
diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index bc052c803a..0ac94b5cc9 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -155,7 +155,7 @@ test_expect_success ZIPINFO 'zip archive with many entries' '
 	test_cmp expect actual
 '
 
-test_expect_failure EXPENSIVE,UNZIP 'zip archive bigger than 4GB' '
+test_expect_success EXPENSIVE,UNZIP 'zip archive bigger than 4GB' '
 	# build string containing 65536 characters
 	s=0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef &&
 	s=$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s &&
-- 
2.12.2

