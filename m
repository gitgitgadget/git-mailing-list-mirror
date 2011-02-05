From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] Add const to parse_{commit,tag}_buffer()
Date: Sat,  5 Feb 2011 17:52:20 +0700
Message-ID: <1296903141-27075-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 05 11:53:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Plfm9-0008Hh-Dh
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 11:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130Ab1BEKxv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Feb 2011 05:53:51 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36287 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796Ab1BEKxu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 05:53:50 -0500
Received: by pva4 with SMTP id 4so566899pva.19
        for <git@vger.kernel.org>; Sat, 05 Feb 2011 02:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=buvt6RtwV14wW85eNiUDeTmkWsWzytodSsOAdKtGAhU=;
        b=LVk3jATtrk6bnY4TsH/wSlYQ67q4zVqrJpZ8WT2GAB6WEcwqcx68fDKCpYcX8VwCf7
         n7Ki19aOHvqfuai2sCksEgp1gSsbqGAe1CCmiKBcN4ZjZ46VX3lpRhKWV4dDRQclc22d
         JqZDN+W3QKTtw3MXBcHe/WGp8pk1HmR7tplpg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=K30zzznPjiiBk45XUP9s03du1cvGdzep/gpRowQ8l2pXiY8ZUHtiRNPbPS3RDAgOud
         BYfkLeYwEA2jMseqNJW3i6QlSGgMmgTpQq9vG77NJiUXjzMdW7D1ZgHkqmNFXxLFjIY6
         03EuN5GKUmAylgR1otgPGBAa4s2PP0Ylr8LVg=
Received: by 10.142.43.16 with SMTP id q16mr12832913wfq.78.1296903230007;
        Sat, 05 Feb 2011 02:53:50 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id f5sm2378806wfo.16.2011.02.05.02.53.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Feb 2011 02:53:49 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 05 Feb 2011 17:52:22 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166086>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 commit.c |    6 +++---
 commit.h |    2 +-
 tag.c    |    2 +-
 tag.h    |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index 74d6601..ac337c7 100644
--- a/commit.c
+++ b/commit.c
@@ -245,10 +245,10 @@ int unregister_shallow(const unsigned char *sha1)
 	return 0;
 }
=20
-int parse_commit_buffer(struct commit *item, void *buffer, unsigned lo=
ng size)
+int parse_commit_buffer(struct commit *item, const void *buffer, unsig=
ned long size)
 {
-	char *tail =3D buffer;
-	char *bufptr =3D buffer;
+	const char *tail =3D buffer;
+	const char *bufptr =3D buffer;
 	unsigned char parent[20];
 	struct commit_list **pptr;
 	struct commit_graft *graft;
diff --git a/commit.h b/commit.h
index eb6c5af..659c87c 100644
--- a/commit.h
+++ b/commit.h
@@ -38,7 +38,7 @@ struct commit *lookup_commit_reference_gently(const u=
nsigned char *sha1,
 					      int quiet);
 struct commit *lookup_commit_reference_by_name(const char *name);
=20
-int parse_commit_buffer(struct commit *item, void *buffer, unsigned lo=
ng size);
+int parse_commit_buffer(struct commit *item, const void *buffer, unsig=
ned long size);
 int parse_commit(struct commit *item);
=20
 /* Find beginning and length of commit subject. */
diff --git a/tag.c b/tag.c
index f789744..ecf7c1e 100644
--- a/tag.c
+++ b/tag.c
@@ -56,7 +56,7 @@ static unsigned long parse_tag_date(const char *buf, =
const char *tail)
 	return strtoul(dateptr, NULL, 10);
 }
=20
-int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
+int parse_tag_buffer(struct tag *item, const void *data, unsigned long=
 size)
 {
 	unsigned char sha1[20];
 	char type[20];
diff --git a/tag.h b/tag.h
index 8522370..5ee88e6 100644
--- a/tag.h
+++ b/tag.h
@@ -13,7 +13,7 @@ struct tag {
 };
=20
 extern struct tag *lookup_tag(const unsigned char *sha1);
-extern int parse_tag_buffer(struct tag *item, void *data, unsigned lon=
g size);
+extern int parse_tag_buffer(struct tag *item, const void *data, unsign=
ed long size);
 extern int parse_tag(struct tag *item);
 extern struct object *deref_tag(struct object *, const char *, int);
 extern size_t parse_signature(const char *buf, unsigned long size);
--=20
1.7.3.4.878.g439c7
