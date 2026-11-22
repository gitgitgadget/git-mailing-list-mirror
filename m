Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795348785;
	b=qGil93d41D7FSuOhNgf7NGQCTnDhHUkEajlutLKk35B1sgAEOE9az+Ay6qoc7lH0qtk+
	 7gBv83egKxiVtuN1liXb41uBPbok1zQd9Vv5pWW5qkuQwY5dHDL6y49ZdeQ1GKzL+fHWl
	 HBmCXUntdKfvq3uatunC1S42jA8+ofs8jnG/FDyJJNAYy0Udrv/70YyWX2QfS4boH40af
	 IPL6N1VkXMo6hDmjnzdZslrBtVc5fNQSRIqHGFpFL28Vh9bCwgcNpCcSh+e2SKqFL3B2i
	 /1oaRuYut6aF0hU6x6wSHGVlt/3agnLhlia4PEXqFd6J/sVSv/o0HU2wbybkVN83P5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795348785;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=vwKHkjRRCYwLKlT5BhWBRjRcdDkMnHrqzydTk897Rqo=;
	b=DU2OaC2eXcsQUEhdgBHfnZyc5g/oksbrF8W8PXkQeR+ErzunR2/DYHN11+6ufxvI2v43
	 AOnbg0BiNLfse3rq9Au9YiDRe9XM8kKsy6mWxfnk4+fvhtCzOo8tMkJyuhoMCfJQMPNYA
	 RC7Ity7glKm4Bb+zuRysx1rZBugMys3W4xTNzZFJC6BGncgU6rIYJnoLhns8KGUowEJb4
	 8hm49FhAQDtCgMg+Tn9QYaWcvIj00VMwIYpwDiXOLw1LtZc3kLMABNaredlhDF2p7WVlQ
	 +kLf3FsZoqvCrwUY4aDyKFcqaaQwhrYZ96SKoDaK42b7K4Z5DrcmQ3jwhjrwZVc0hGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=l.s.r@web.de header.a=rsa-sha256 header.s=s29768273 header.b=OF3mk9+f;
	arc=none smtp.remote-ip=212.227.17.11
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B28606A330
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 11:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6B28606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=l.s.r@web.de header.a=rsa-sha256 header.s=s29768273 header.b=OF3mk9+f
DKIM2-Signature:  i=1; m=1; t=1795348781;
 mf=PGwucy5yQHdlYi5kZT4=;
 rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:rk3HkhtiKbkzkqOiNMx0/KEYCF0W
   JpRFiTIKVKKLGMDtaDPjvRQo+PnrpfmemvVpLuNNMsjw5Hw7+/lelO37d3FT9BZrJeHGi3vloU/
   lS5sc68IQ9KBDuGtkvStWiJRaaMBYtxr3LWewZ8e/Nb2Kvst7yittB/X/je/uMDhzOiVkSTMqal
   ysk+GTcq9YSDsZx0//C/X6WYq3TxSM9aTe2RVd3sQYuE8/ISYe7+3+2Lf21dYQfBuI4h2QibAY8
   QkgnSkMR4XaA5BounFG9PhA46h31CC4N4+Ol+fHvkAzcHLnUjXLVWNDYIghmSl8X84TS4KnvDem
   whI5Hq8zMGnt5A==;
Message-Instance:  m=1;
 h=sha256:
   WRvWha0fRvp+5ZXakQ3tW8TjlFMG0FeljS8fdK1D3ZQ=:
   jTahxJUokkFQekOJF/dBVx0o5+JGgCx21db2Emm1VBk=,
  sha512:
   GNwQBQjq8ECU8pSFdcRTYIYY5tOkZNGKs6YILpAtT+POghJLG+ZauSulvJl1WIEninkrO8fJUJQqXI7BtimOZA==:
   ZxVcElAsRX52KQvZ+CvlQJ7w/QSCUuCfmcn3o/bQb1+/ihc8GHji4ZjfcqhoCYqaK4YNICCdSgxBeAbTA8Xv0A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1795348781; x=1795953581; i=l.s.r@web.de;
	bh=vwKHkjRRCYwLKlT5BhWBRjRcdDkMnHrqzydTk897Rqo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OF3mk9+fIsxm1Z5lwdem/wmnzSwpmz1XEsGiUPKwUeV0ObKo9646LRVs8FHacsm+
	 qGuIyo4rwQrDLtMAp+55QtQBkeDAui3lveqxFuOsOovocb6p+NqBk+pM6EeJoP7L6
	 Jzo3US9M0/F3+geGgSC5rU+45KoK3FREibux6/JJY4Gdrkj9Y11nIzvOU3JzR6wtB
	 /nHWNlU1BSX5SU5x9oJmGdQm6xnimeaHBpftVU7faBgbwan61PJjG2Zjtyuc9x04f
	 DDKAxFNoUSLufDkBowV+uQfnSDbxKedEMds8gGn3N4aNBjb/FJaTJx7d09A/zOpVh
	 4udc/3oUpkrJ3kbjsw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MmQYd-1yDGfc0qif-00iqbO for
 <git@vger.kernel.org>; Sun, 22 Nov 2026 12:59:41 +0100
Message-ID: <25761d5e-b8ac-404b-9c50-763595c17522@web.de>
Date: Sun, 22 Nov 2026 12:59:40 +0100
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
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] archive: separate --no-add-file and --no-add-virtual-file
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XUDCRd7KBEIUdpCm3uQd1LPdugy/+TRe6MrWr/kDmDxKF8eBdfU
 1Q7HDTMx5UkrmJKvNlfIHtqopYvu5d0CbuVXgOLkTjxFsx5QFtrJuELmRBhqQ6+8+syVpvW
 msgZOxxjtbbs5jL+LqpIQS55ys3kL19eu8OqtwYELOFNDNkpeW4SgRdWFjsR4BLJNpdfOJB
 3sor7vhRX5gfcVa6raSrQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9m/gEcD9418=;3Y7ToSf/45oqBLa0OjNjDIZo0rK
 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

The options --add-file and --add-virtual-file of git archive add
different types of files.  They register them in the same string-list
variable though.  Their negative forms clear the whole shared list,
which is surprising.  Make them remove only the entries added by their
respective positive form instead.

We could do that by using separate lists, but that would change the
order of files in generated archives.  So do it by filtering the
string-list using the new function filter_string_list_func(), which
supports our custom item destructor extra_file_info_clear().

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 archive.c           | 14 ++++++++++++--
 string-list.c       | 18 ++++++++++++++++++
 string-list.h       | 10 ++++++++++
 t/t5000-tar-tree.sh | 18 ++++++++++++++++++
 4 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/archive.c b/archive.c
index 59790be986..33bd2c3d5c 100644
=2D-- a/archive.c
+++ b/archive.c
@@ -559,6 +559,14 @@ static void extra_file_info_clear(void *util, const c=
har *str UNUSED)
 	free(info);
 }
=20
+static int keep_file(struct string_list_item *item, void *cb_data)
+{
+	struct extra_file_info *info =3D item->util;
+	bool is_regular_file =3D !info->content;
+	bool keep_regular_file =3D !!cb_data;
+	return is_regular_file =3D=3D keep_regular_file;
+}
+
 static int add_file_cb(const struct option *opt, const char *arg, int uns=
et)
 {
 	struct archiver_args *args =3D opt->value;
@@ -569,8 +577,10 @@ static int add_file_cb(const struct option *opt, cons=
t char *arg, int unset)
 	struct extra_file_info *info;
=20
 	if (unset) {
-		string_list_clear_func(&args->extra_files,
-				       extra_file_info_clear);
+		bool keep_regular_file =3D !!strcmp(opt->long_name, "add-file");
+		filter_string_list_func(&args->extra_files,
+					extra_file_info_clear, keep_file,
+					keep_regular_file ? (void *)1 : NULL);
 		return 0;
 	}
=20
diff --git a/string-list.c b/string-list.c
index d260b873c8..b469ba9576 100644
=2D-- a/string-list.c
+++ b/string-list.c
@@ -151,6 +151,24 @@ void filter_string_list(struct string_list *list, int=
 free_util,
 	list->nr =3D dst;
 }
=20
+void filter_string_list_func(struct string_list *list,
+			     string_list_clear_func_t clearfunc,
+			     string_list_each_func_t want, void *cb_data)
+{
+	size_t dst =3D 0;
+	for (size_t src =3D 0; src < list->nr; src++) {
+		if (want(&list->items[src], cb_data)) {
+			list->items[dst++] =3D list->items[src];
+		} else {
+			clearfunc(list->items[src].util,
+				  list->items[src].string);
+			if (list->strdup_strings)
+				free(list->items[src].string);
+		}
+	}
+	list->nr =3D dst;
+}
+
 static int item_is_not_empty(struct string_list_item *item, void *data UN=
USED)
 {
 	return *item->string !=3D '\0';
diff --git a/string-list.h b/string-list.h
index b86ee7c099..b08282b78f 100644
=2D-- a/string-list.h
+++ b/string-list.h
@@ -134,6 +134,16 @@ typedef void (*string_list_clear_func_t)(void *p, con=
st char *str);
 /** Call a custom clear function on each util pointer */
 void string_list_clear_func(struct string_list *list, string_list_clear_f=
unc_t clearfunc);
=20
+/**
+ * Apply `want` to each item in `list`, retaining only the ones for which
+ * the function returns true.  Call `clearfunc` on the util members of
+ * any items that have to be deleted.  Preserve the order of the items
+ * that are retained.
+ */
+void filter_string_list_func(struct string_list *list,
+			     string_list_clear_func_t clearfunc,
+			     string_list_each_func_t want, void *cb_data);
+
 /*
  * Set the length of a string_list to `nr`, provided that (a) `list`
  * does not own its own storage, and (b) that `nr` is no larger than
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 3ad600c793..3e181e4687 100755
=2D-- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -552,4 +552,22 @@ test_expect_success TAR_HUGE,TIME_IS_64BIT,TIME_T_IS_=
64BIT 'system tar can read
 	test_cmp expect actual
 '
=20
+test_expect_success '--no-add-file keeps --add-virtual-file entries' '
+	echo foo >file &&
+	git archive --add-file=3Dfile --add-virtual-file=3Dvirtual:file \
+		--no-add-file $EMPTY_TREE >virtual.tar &&
+	"$TAR" tf virtual.tar >actual &&
+	echo virtual >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--no-add-virtual-file keeps --add-file entries' '
+	echo foo >file &&
+	git archive --add-file=3Dfile --add-virtual-file=3Dvirtual:file \
+		--no-add-virtual-file $EMPTY_TREE >untracked.tar &&
+	"$TAR" tf untracked.tar >actual &&
+	echo file >expect &&
+	test_cmp expect actual
+'
+
 test_done
=2D-=20
2.56.1
