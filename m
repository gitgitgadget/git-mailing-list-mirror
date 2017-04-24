Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A5B0207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 17:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972053AbdDXRdk (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 13:33:40 -0400
Received: from mout.web.de ([212.227.15.14]:50793 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S971991AbdDXRdj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 13:33:39 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LkPW7-1cRB7r1dSl-00cQd4; Mon, 24
 Apr 2017 19:33:36 +0200
Subject: [PATCH v3 5/5] archive-zip: support files bigger than 4GB
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
Message-ID: <e53f1d3f-be3a-ac28-89eb-63011da64586@web.de>
Date:   Mon, 24 Apr 2017 19:33:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <85f2b6d1-107b-0624-af82-92446f28269e@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:GCcKtP7bHh7BXa7QZXIA3JWq5ZHvwzhl5BIMGyYFwe4uVNJavNS
 4v+/sSspOvq1uDbOOAXvpNgs2nLVBbFyjVBot5lMTSpJFv5ukYgWpXuwf0Uaqbz8mDt4uou
 IRhos0k6hHws2SMx8CU05L3HZdh2ERScBfXqyGUesj+GlPFgWWNz2v+mwjJi1ReVpuXKSTw
 Qi2naK9BoH8YFVRjBVgYw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nuDxVGgaC18=:NNQTXIBSuAIBqJ42pB0vbt
 a7DoQRYHSthQn7tCfiu0FHrYvLn51XwW1uNhY4j2FAiBJyPJkTJV/bQui5glbIJ6y5whN0NuS
 BACzqo8DHFKxBHZZRiKcziJqNdS+nO0zet91nmLXUg3esoBvZlsZ1px/nTA86nEdnwEEZMjWm
 8V4/+aWPEd8cLePFtpjcqRfpChb7a6OazKRWIyCPKIoe4iaguIQ1rJS5nJP/Hc321r7+vgI8S
 GYVzu7qB5tNNyNEr8CdYb4mdgfFRJDs/FZlfqzXXTCAOsY40cBPjthDwHWocMvoDL+6ubwgWd
 lWowpB7k4oGVhtPjNZMND2cQ3pPvLFjzRSIM8Dsdxwrtxr1qSakn6dd4CT7PBXayIwKwglrI2
 hrFsSrRMEK13+i4TroM8H7eVE9fGvvk9vYlfamYe/JFQUqBR1dUahtPkl10V4pTp9T9k/GBWu
 LaSrmk8ENSI7a0lKhDC84YxXxdtMwPHHYll/3NWCtekvqw5R3vFnJSJ45mct1kadC/fGkwCpt
 vDkF6gcHk0WYdPk+NLR1u8wNq0pQo4GFj+qEtECUrch07dp316mg1Ng674/u7gz+GgHya3hN4
 MCXacnm7EcTz5mubBxfFtiasZgV9x9VCNCHn5rx6lcMGu6dOLTJ5qEyQwMTFE3jDqJExE4BXa
 i+Jqg0eKIRKI+gQ/9mxzwF/DFbBmRdsF0queF850RTpOWvXEXuKXiRxZ9+wYKr7h4Ck0CLljI
 prI0+fvisTxKNYMvldL3Fqe9cTRnWidLxKWCKgRZDVm0qAk3Xklx6xWDXD89pLZHqArIYRBll
 8dWR/BC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Write a zip64 extended information extra field for big files as part of
their local headers and as part of their central directory headers.
Also write a zip64 version of the data descriptor in that case.

If we're streaming then we don't know the compressed size at the time we
write the header.  Deflate can end up making a file bigger instead of
smaller if we're unlucky.  Write a local zip64 header already for files
with a size of 2GB or more in this case to be on the safe side.

Both sizes need to be included in the local zip64 header, but the extra
field for the directory must only contain 64-bit equivalents for 32-bit
values of 0xffffffff.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 archive-zip.c                   | 90 ++++++++++++++++++++++++++++++++++-------
 t/t5004-archive-corner-cases.sh |  2 +-
 2 files changed, 76 insertions(+), 16 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 7d6f2a85d0..44ed78f163 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -45,6 +45,14 @@ struct zip_data_desc {
 	unsigned char _end[1];
 };
 
+struct zip64_data_desc {
+	unsigned char magic[4];
+	unsigned char crc32[4];
+	unsigned char compressed_size[8];
+	unsigned char size[8];
+	unsigned char _end[1];
+};
+
 struct zip_dir_trailer {
 	unsigned char magic[4];
 	unsigned char disk[2];
@@ -65,6 +73,14 @@ struct zip_extra_mtime {
 	unsigned char _end[1];
 };
 
+struct zip64_extra {
+	unsigned char magic[2];
+	unsigned char extra_size[2];
+	unsigned char size[8];
+	unsigned char compressed_size[8];
+	unsigned char _end[1];
+};
+
 struct zip64_dir_trailer {
 	unsigned char magic[4];
 	unsigned char record_size[8];
@@ -94,11 +110,15 @@ struct zip64_dir_trailer_locator {
  */
 #define ZIP_LOCAL_HEADER_SIZE	offsetof(struct zip_local_header, _end)
 #define ZIP_DATA_DESC_SIZE	offsetof(struct zip_data_desc, _end)
+#define ZIP64_DATA_DESC_SIZE	offsetof(struct zip64_data_desc, _end)
 #define ZIP_DIR_HEADER_SIZE	offsetof(struct zip_dir_header, _end)
 #define ZIP_DIR_TRAILER_SIZE	offsetof(struct zip_dir_trailer, _end)
 #define ZIP_EXTRA_MTIME_SIZE	offsetof(struct zip_extra_mtime, _end)
 #define ZIP_EXTRA_MTIME_PAYLOAD_SIZE \
 	(ZIP_EXTRA_MTIME_SIZE - offsetof(struct zip_extra_mtime, flags))
+#define ZIP64_EXTRA_SIZE	offsetof(struct zip64_extra, _end)
+#define ZIP64_EXTRA_PAYLOAD_SIZE \
+	(ZIP64_EXTRA_SIZE - offsetof(struct zip64_extra, size))
 #define ZIP64_DIR_TRAILER_SIZE	offsetof(struct zip64_dir_trailer, _end)
 #define ZIP64_DIR_TRAILER_RECORD_SIZE \
 	(ZIP64_DIR_TRAILER_SIZE - \
@@ -202,13 +222,23 @@ static void write_zip_data_desc(unsigned long size,
 				unsigned long compressed_size,
 				unsigned long crc)
 {
-	struct zip_data_desc trailer;
-
-	copy_le32(trailer.magic, 0x08074b50);
-	copy_le32(trailer.crc32, crc);
-	copy_le32(trailer.compressed_size, compressed_size);
-	copy_le32(trailer.size, size);
-	write_or_die(1, &trailer, ZIP_DATA_DESC_SIZE);
+	if (size >= 0xffffffff || compressed_size >= 0xffffffff) {
+		struct zip64_data_desc trailer;
+		copy_le32(trailer.magic, 0x08074b50);
+		copy_le32(trailer.crc32, crc);
+		copy_le64(trailer.compressed_size, compressed_size);
+		copy_le64(trailer.size, size);
+		write_or_die(1, &trailer, ZIP64_DATA_DESC_SIZE);
+		zip_offset += ZIP64_DATA_DESC_SIZE;
+	} else {
+		struct zip_data_desc trailer;
+		copy_le32(trailer.magic, 0x08074b50);
+		copy_le32(trailer.crc32, crc);
+		copy_le32(trailer.compressed_size, compressed_size);
+		copy_le32(trailer.size, size);
+		write_or_die(1, &trailer, ZIP_DATA_DESC_SIZE);
+		zip_offset += ZIP_DATA_DESC_SIZE;
+	}
 }
 
 static void set_zip_header_data_desc(struct zip_local_header *header,
@@ -252,6 +282,9 @@ static int write_zip_entry(struct archiver_args *args,
 	struct zip_local_header header;
 	uintmax_t offset = zip_offset;
 	struct zip_extra_mtime extra;
+	struct zip64_extra extra64;
+	size_t header_extra_size = ZIP_EXTRA_MTIME_SIZE;
+	int need_zip64_extra = 0;
 	unsigned long attr2;
 	unsigned long compressed_size;
 	unsigned long crc;
@@ -344,21 +377,40 @@ static int write_zip_entry(struct archiver_args *args,
 	extra.flags[0] = 1;	/* just mtime */
 	copy_le32(extra.mtime, args->time);
 
+	if (size > 0xffffffff || compressed_size > 0xffffffff)
+		need_zip64_extra = 1;
+	if (stream && size > 0x7fffffff)
+		need_zip64_extra = 1;
+
 	copy_le32(header.magic, 0x04034b50);
 	copy_le16(header.version, 10);
 	copy_le16(header.flags, flags);
 	copy_le16(header.compression_method, method);
 	copy_le16(header.mtime, zip_time);
 	copy_le16(header.mdate, zip_date);
-	set_zip_header_data_desc(&header, size, compressed_size, crc);
+	if (need_zip64_extra) {
+		set_zip_header_data_desc(&header, 0xffffffff, 0xffffffff, crc);
+		header_extra_size += ZIP64_EXTRA_SIZE;
+	} else {
+		set_zip_header_data_desc(&header, size, compressed_size, crc);
+	}
 	copy_le16(header.filename_length, pathlen);
-	copy_le16(header.extra_length, ZIP_EXTRA_MTIME_SIZE);
+	copy_le16(header.extra_length, header_extra_size);
 	write_or_die(1, &header, ZIP_LOCAL_HEADER_SIZE);
 	zip_offset += ZIP_LOCAL_HEADER_SIZE;
 	write_or_die(1, path, pathlen);
 	zip_offset += pathlen;
 	write_or_die(1, &extra, ZIP_EXTRA_MTIME_SIZE);
 	zip_offset += ZIP_EXTRA_MTIME_SIZE;
+	if (need_zip64_extra) {
+		copy_le16(extra64.magic, 0x0001);
+		copy_le16(extra64.extra_size, ZIP64_EXTRA_PAYLOAD_SIZE);
+		copy_le64(extra64.size, size);
+		copy_le64(extra64.compressed_size, compressed_size);
+		write_or_die(1, &extra64, ZIP64_EXTRA_SIZE);
+		zip_offset += ZIP64_EXTRA_SIZE;
+	}
+
 	if (stream && method == 0) {
 		unsigned char buf[STREAM_BUFFER_SIZE];
 		ssize_t readlen;
@@ -381,7 +433,6 @@ static int write_zip_entry(struct archiver_args *args,
 		zip_offset += compressed_size;
 
 		write_zip_data_desc(size, compressed_size, crc);
-		zip_offset += ZIP_DATA_DESC_SIZE;
 	} else if (stream && method == 8) {
 		unsigned char buf[STREAM_BUFFER_SIZE];
 		ssize_t readlen;
@@ -437,7 +488,6 @@ static int write_zip_entry(struct archiver_args *args,
 		zip_offset += compressed_size;
 
 		write_zip_data_desc(size, compressed_size, crc);
-		zip_offset += ZIP_DATA_DESC_SIZE;
 	} else if (compressed_size > 0) {
 		write_or_die(1, out, compressed_size);
 		zip_offset += compressed_size;
@@ -446,8 +496,14 @@ static int write_zip_entry(struct archiver_args *args,
 	free(deflated);
 	free(buffer);
 
-	if (offset > 0xffffffff) {
-		zip64_dir_extra_payload_size += 8;
+	if (compressed_size > 0xffffffff || size > 0xffffffff ||
+	    offset > 0xffffffff) {
+		if (compressed_size >= 0xffffffff)
+			zip64_dir_extra_payload_size += 8;
+		if (size >= 0xffffffff)
+			zip64_dir_extra_payload_size += 8;
+		if (offset >= 0xffffffff)
+			zip64_dir_extra_payload_size += 8;
 		zip_dir_extra_size += 2 + 2 + zip64_dir_extra_payload_size;
 	}
 
@@ -459,8 +515,8 @@ static int write_zip_entry(struct archiver_args *args,
 	strbuf_add_le(&zip_dir, 2, zip_time);
 	strbuf_add_le(&zip_dir, 2, zip_date);
 	strbuf_add_le(&zip_dir, 4, crc);
-	strbuf_add_le(&zip_dir, 4, compressed_size);
-	strbuf_add_le(&zip_dir, 4, size);
+	strbuf_add_le(&zip_dir, 4, clamp32(compressed_size));
+	strbuf_add_le(&zip_dir, 4, clamp32(size));
 	strbuf_add_le(&zip_dir, 2, pathlen);
 	strbuf_add_le(&zip_dir, 2, zip_dir_extra_size);
 	strbuf_add_le(&zip_dir, 2, 0);		/* comment length */
@@ -473,6 +529,10 @@ static int write_zip_entry(struct archiver_args *args,
 	if (zip64_dir_extra_payload_size) {
 		strbuf_add_le(&zip_dir, 2, 0x0001);	/* magic */
 		strbuf_add_le(&zip_dir, 2, zip64_dir_extra_payload_size);
+		if (size >= 0xffffffff)
+			strbuf_add_le(&zip_dir, 8, size);
+		if (compressed_size >= 0xffffffff)
+			strbuf_add_le(&zip_dir, 8, compressed_size);
 		if (offset >= 0xffffffff)
 			strbuf_add_le(&zip_dir, 8, offset);
 	}
diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index 0ac94b5cc9..a6875dfdb1 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -178,7 +178,7 @@ test_expect_success EXPENSIVE,UNZIP 'zip archive bigger than 4GB' '
 	"$GIT_UNZIP" -t many-big.zip
 '
 
-test_expect_failure EXPENSIVE,UNZIP 'zip archive with files bigger than 4GB' '
+test_expect_success EXPENSIVE,UNZIP,ZIPINFO 'zip archive with files bigger than 4GB' '
 	# Pack created with:
 	#   dd if=/dev/zero of=file bs=1M count=4100 && git hash-object -w file
 	mkdir -p .git/objects/pack &&
-- 
2.12.2

