Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F403E2095B
	for <e@80x24.org>; Sat, 18 Mar 2017 21:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751187AbdCRVWq (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 17:22:46 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:46158 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751181AbdCRVWf (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Mar 2017 17:22:35 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7D6EB280C1;
        Sat, 18 Mar 2017 21:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1489872006;
        bh=sAJDBsiN6lnvkThkoneoOfjXZMg5YkAFqmTtbo+8OEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kmpeE+SW5EEo5wDjgBBxCiw8eYXMlY/1RIb4ramw+TYRi1zGBdhquCX6q9uBN3ra1
         dFEzJEW/cDlGErvsTBBEkkO3raQMSY8K3CyW6xRvnH1AfjiqcpbcJKuoPnoiD7Fgj1
         jlDI+skD5FiXWvh+30OXxhhiFFFuRMreX8gP4SSA5RvKKrjb0bX0eamJ8Py4n5lDs8
         veHM7mkIxVjY/zT4oKQmbuZDjyZaHgHA6UtJ99ClE5V9Iclmwl+O9/71IipJfMPygA
         iWbZIMAZn7TbXENFF0+1tg7YHSGAo6T2XyHH/XvgOEBZvSCRCnNU7zxGYAWKyyf9q4
         hs7mkpeX1B+gCAgyVcGMERyrz8DitTw++n+YbQMc3IjakMpq/UwI88X/L1KugtL5Oq
         MEo7Wiy3FWr61KuZm5cBunvTyTbNfUavwf1hCCGchL3AJU5tm/Nk65YxQ0IGnNUWcS
         wubh3az582wlkUiQXpc5uyL3RdzPoHD270gPlkkKILWEPkTlZO2
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 20/20] Documentation: update and rename api-sha1-array.txt
Date:   Sat, 18 Mar 2017 21:19:54 +0000
Message-Id: <20170318211954.564030-21-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170318211954.564030-1-sandals@crustytoothpaste.net>
References: <20170318211954.564030-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the structure and functions have changed names, update the code
examples and the documentation.  Rename the file to match the new name
of the API.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 .../{api-sha1-array.txt => api-oid-array.txt}      | 44 +++++++++++-----------
 1 file changed, 22 insertions(+), 22 deletions(-)
 rename Documentation/technical/{api-sha1-array.txt => api-oid-array.txt} (61%)

diff --git a/Documentation/technical/api-sha1-array.txt b/Documentation/technical/api-oid-array.txt
similarity index 61%
rename from Documentation/technical/api-sha1-array.txt
rename to Documentation/technical/api-oid-array.txt
index dcc52943a5..b0c11f868d 100644
--- a/Documentation/technical/api-sha1-array.txt
+++ b/Documentation/technical/api-oid-array.txt
@@ -1,7 +1,7 @@
-sha1-array API
+oid-array API
 ==============
 
-The sha1-array API provides storage and manipulation of sets of SHA-1
+The oid-array API provides storage and manipulation of sets of object
 identifiers. The emphasis is on storage and processing efficiency,
 making them suitable for large lists. Note that the ordering of items is
 not preserved over some operations.
@@ -9,10 +9,10 @@ not preserved over some operations.
 Data Structures
 ---------------
 
-`struct sha1_array`::
+`struct oid_array`::
 
-	A single array of SHA-1 hashes. This should be initialized by
-	assignment from `SHA1_ARRAY_INIT`.  The `sha1` member contains
+	A single array of object IDs. This should be initialized by
+	assignment from `OID_ARRAY_INIT`.  The `oid` member contains
 	the actual data. The `nr` member contains the number of items in
 	the set.  The `alloc` and `sorted` members are used internally,
 	and should not be needed by API callers.
@@ -20,22 +20,22 @@ Data Structures
 Functions
 ---------
 
-`sha1_array_append`::
-	Add an item to the set. The sha1 will be placed at the end of
+`oid_array_append`::
+	Add an item to the set. The object ID will be placed at the end of
 	the array (but note that some operations below may lose this
 	ordering).
 
-`sha1_array_lookup`::
-	Perform a binary search of the array for a specific sha1.
+`oid_array_lookup`::
+	Perform a binary search of the array for a specific object ID.
 	If found, returns the offset (in number of elements) of the
-	sha1. If not found, returns a negative integer. If the array is
-	not sorted, this function has the side effect of sorting it.
+	object ID. If not found, returns a negative integer. If the array
+	is not sorted, this function has the side effect of sorting it.
 
-`sha1_array_clear`::
+`oid_array_clear`::
 	Free all memory associated with the array and return it to the
 	initial, empty state.
 
-`sha1_array_for_each_unique`::
+`oid_array_for_each_unique`::
 	Efficiently iterate over each unique element of the list,
 	executing the callback function for each one. If the array is
 	not sorted, this function has the side effect of sorting it. If
@@ -47,25 +47,25 @@ Examples
 --------
 
 -----------------------------------------
-int print_callback(const unsigned char sha1[20],
+int print_callback(const struct object_id *oid,
 		    void *data)
 {
-	printf("%s\n", sha1_to_hex(sha1));
+	printf("%s\n", oid_to_hex(oid));
 	return 0; /* always continue */
 }
 
 void some_func(void)
 {
-	struct sha1_array hashes = SHA1_ARRAY_INIT;
-	unsigned char sha1[20];
+	struct sha1_array hashes = OID_ARRAY_INIT;
+	struct object_id oid;
 
 	/* Read objects into our set */
-	while (read_object_from_stdin(sha1))
-		sha1_array_append(&hashes, sha1);
+	while (read_object_from_stdin(oid.hash))
+		oid_array_append(&hashes, &oid);
 
 	/* Check if some objects are in our set */
-	while (read_object_from_stdin(sha1)) {
-		if (sha1_array_lookup(&hashes, sha1) >= 0)
+	while (read_object_from_stdin(oid.hash)) {
+		if (oid_array_lookup(&hashes, &oid) >= 0)
 			printf("it's in there!\n");
 
 	/*
@@ -75,6 +75,6 @@ void some_func(void)
 	 * Instead, this will sort once and then skip duplicates
 	 * in linear time.
 	 */
-	sha1_array_for_each_unique(&hashes, print_callback, NULL);
+	oid_array_for_each_unique(&hashes, print_callback, NULL);
 }
 -----------------------------------------
