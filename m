Return-Path: <SRS0=1Io1=D7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18ADC2D0A3
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 17:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45CAD22254
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 17:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="IFuXJsXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762748AbgJXRw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 13:52:57 -0400
Received: from mout.web.de ([212.227.15.3]:54331 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762745AbgJXRw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 13:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1603561969;
        bh=Mlg5/zB1HBAc1fHSv3R7PS8m8aKBShSwvckrYVd9TBA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=IFuXJsXAHsTD+P3spaTp+F5IWM73YXZHWwnWmoBtiIrXzKUwjz5k5gZC+CQZl0B+h
         nxhgMDsxUxshaAi9wHWzVX4KBkYjC/bZU4h7iDHK3eCXfSCsb4eHROG1NettGjSwsf
         o3O0uLNg7AUO7eKk9/lIknM7F9NiCX+cb1slDkT4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lcxjk-1k65NR2Kgq-00iGXN; Sat, 24
 Oct 2020 19:52:49 +0200
Subject: Re: [ANNOUNCE] Git v2.29.0-rc1
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqq7drzv1bn.fsf@gitster.c.googlers.com>
 <ce8f482f-9a78-6867-38ae-601bcc2c9f66@web.de>
 <xmqqmu0rqu8h.fsf@gitster.c.googlers.com>
 <61bafa3b-bd23-f01f-9a4a-c348b7588f37@web.de>
Message-ID: <e135ac82-49f1-e06c-45d7-6b3b9f9837c6@web.de>
Date:   Sat, 24 Oct 2020 19:52:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <61bafa3b-bd23-f01f-9a4a-c348b7588f37@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lu3nM4b0c+fEDdF36zqc4LO9ze/PNIC+/Jtu5YKEmpjsQkq//dR
 mTCgcKfPI1QgPeiUNaALc2ehnhs2aMqTADRwTAMIyng7ro6tRztUHE1V3IkX0AJMaOnDqOB
 aAorXKePoevKJiRxsGlMS6JYQbFaKxG16aUsGa4hC9AGmYBbYP0PlJ0YMoRK1E30PfIAhLf
 8euSJD+16qAWdBJgCZ0lw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vSIma0KAKzs=:+HKSCN2/sFfDMCu1Q9tOT+
 NehcTKGf7l+iZ8u9n4YD6pESSf/mwhzm7b1k9F1gK5TfJwwqcrgwDZaRV+6gtW5P5RVYgd1LP
 GN00gDL2PPM0GEJXRHXiLY1Z5aU1zVpnOsSTCeYVYl/MVgvOCicfqBIXbNYubAeJductd6/GV
 VPA4rgdAFj8RuJHUXnlnYiCWs1ZJPLCY7AR/rdrY1f/hjWdtvY0oIaPZEOa1uqD9oNFsY5Hmn
 B1KlYUiKtpnWeUkWTIS2y1nJaK2KMwnN1mfk638yD+FHLnzAPUDTSMWgHrP0LX1wEpfcylRsh
 tzatnuZEKT5mUdDNhkwRSGH1Qx5m74Gw/8KpZ2bUihebvoRXm5S9sxwzRcdbayOxFAc5N7+VJ
 Zc52ZPT7UnTF49/2wJ/Wzi+L87a6J75yRaCN9UDMubz1QngE9muTJ9AjYbh4l9FFV6J8BS3j/
 /bzYoyGgjDoG4t08xo6+drb7p/IeBE+7u6isB4LV32hf2YLUg7ZwhZIu62k0mQnR57ZoLi8nT
 m2CO2qTH+2RiXht3faXCzTB1jJLZhQ80QOVhQHOx6ykJIUx8mM+ZRwIQ0wuVrf9e5ahvhN0AM
 MCBDTnP3JdvCn8YBhbSlcwhF/e+4jZgt/+BczFKz61AhrmDZOT5sx4OBqHpBHHGyM9i3y1X+l
 ds4ROGbS03qGSBChaIwzNL2z3v3Gm+T1eLiuWkYFN+fTMchVxdCyDcX+xyFrZXN/I5CkeeL0d
 gOYVFRNXKAQ8s6V+JOkziTt7dWs2qrBJENgB16tbeufxMB+FZ452Cr2Hh7zdbA5G/ubSxabvM
 bVQpRgSyDjvNbT3SUbuf/o1Seg/2k1/wmV+sQsFUy7FW1MNUcORRPstqZpaFQsUObgOu5Zr6e
 77kgwFpYeY1glO1K4HGQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.10.20 um 21:19 schrieb Ren=C3=A9 Scharfe:
> Am 12.10.20 um 18:33 schrieb Junio C Hamano:
>> If this "feature" were experimental and if the experiment turns out
>> to be a failure, would we have a viable alternative definition?
>>
>> Perhaps "--add-file names an untracked file in the working tree and
>> the single '--prefix' that is used for entries that come from the
>> tree object is applied"?  Or perhaps remove --add-file entirely as a
>> failed experiment?
>
> Removing --add-file entirely is certainly possible, but it's used in the
> Makefile now and I can't imagine what would make its disposal necessary.
>
> Turning it into a standard OPT_STRING_LIST option for full untracked
> paths and using the last --prefix value for all archive entries would be
> a more straightforward UI and might be versatile enough.

Here's how that would have looked, but it seems I'm too late.

The Makefile rules get a bit more fragile because the version files are
special and the simpler --add-file forces us to create them at their
actual place if not present, which can lead to problems (stuck version)
if we don't delete them afterwards.  Avoiding that was the reason for
the more complicated version that ended up in v2.29.  That fragility
could be defused by teaching GIT-VERSION-GEN about version_is_generated.

Anyway, at this point I'm OK with keeping the released version to avoid
additional confusion.


 Documentation/git-archive.txt |  4 +--
 Makefile                      | 52 +++++++++++++++------------
 archive.c                     | 83 ++++++++++++++++----------------------=
-----
 t/t5000-tar-tree.sh           | 11 ------
 t/t5003-archive-zip.sh        | 10 ------
 5 files changed, 61 insertions(+), 99 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 9f8172828d..b221dd5e3d 100644
=2D-- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -57,9 +57,7 @@ OPTIONS

 --add-file=3D<file>::
 	Add a non-tracked file to the archive.  Can be repeated to add
-	multiple files.  The path of the file in the archive is built
-	by concatenating the value for `--prefix` (if any) and the
-	basename of <file>.
+	multiple files.

 --worktree-attributes::
 	Look for attributes in .gitattributes files in the working tree
diff --git a/Makefile b/Makefile
index 1fb0ec1705..33fd806bc6 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -3050,34 +3050,41 @@ quick-install-html:

 ### Maintainer's dist rules

+version:
+	touch version_is_generated
+	echo $(GIT_VERSION) > version
+
+git-gui/version:
+	touch git-gui/version_is_generated
+	$(MAKE) -C git-gui TARDIR=3D. dist-version
+
+define version_clean_script =3D
+if test -f version_is_generated; then \
+	$(RM) version version_is_generated; \
+fi
+if test -f git-gui/version_is_generated; then \
+	$(RM) git-gui/version git-gui/version_is_generated; \
+fi
+endef
+
 # Allow tweaking to hide local environment effects, like perm bits.
 # With GNU tar, "--mode=3Du+rwX,og+rX,og-w" would be a good idea, for exa=
mple.
 TAR_DIST_EXTRA_OPTS =3D
 GIT_TARNAME =3D git-$(GIT_VERSION)
-GIT_ARCHIVE_EXTRA_FILES =3D \
-	--prefix=3D$(GIT_TARNAME)/ \
-	--add-file=3Dconfigure \
-	--add-file=3D$(GIT_TARNAME)/version \
-	--prefix=3D$(GIT_TARNAME)/git-gui/ \
-	--add-file=3D$(GIT_TARNAME)/git-gui/version
+GIT_ARCHIVE_EXTRA_FILES =3D configure version git-gui/version
 ifdef DC_SHA1_SUBMODULE
-GIT_ARCHIVE_EXTRA_FILES +=3D \
-	--prefix=3D$(GIT_TARNAME)/sha1collisiondetection/ \
-	--add-file=3Dsha1collisiondetection/LICENSE.txt \
-	--prefix=3D$(GIT_TARNAME)/sha1collisiondetection/lib/ \
-	--add-file=3Dsha1collisiondetection/lib/sha1.c \
-	--add-file=3Dsha1collisiondetection/lib/sha1.h \
-	--add-file=3Dsha1collisiondetection/lib/ubc_check.c \
-	--add-file=3Dsha1collisiondetection/lib/ubc_check.h
-endif
-dist: git-archive$(X) configure
-	@mkdir -p $(GIT_TARNAME)
-	@echo $(GIT_VERSION) > $(GIT_TARNAME)/version
-	@$(MAKE) -C git-gui TARDIR=3D../$(GIT_TARNAME)/git-gui dist-version
+GIT_ARCHIVE_EXTRA_FILES +=3D sha1collisiondetection/LICENSE.txt \
+			   sha1collisiondetection/lib/sha1.c \
+			   sha1collisiondetection/lib/sha1.h \
+			   sha1collisiondetection/lib/ubc_check.c \
+			   sha1collisiondetection/lib/ubc_check.h
+endif
+dist: git-archive$(X) configure version git-gui/version
 	./git-archive --format=3Dtar \
-		$(GIT_ARCHIVE_EXTRA_FILES) \
-		--prefix=3D$(GIT_TARNAME)/ HEAD^{tree} > $(GIT_TARNAME).tar
-	@$(RM) -r $(GIT_TARNAME)
+		$(subst $(space),$(space)--add-file=3D,$(space)$(GIT_ARCHIVE_EXTRA_FILE=
S)) \
+		--prefix=3D$(GIT_TARNAME)/ HEAD^{tree} > $(GIT_TARNAME).tar || \
+	$(RM) $(GIT_TARNAME).tar
+	$(version_clean_script)
 	gzip -f -9 $(GIT_TARNAME).tar

 rpm::
@@ -3164,6 +3171,7 @@ endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-LDFLAGS GIT-BUILD-OPTIONS
 	$(RM) GIT-USER-AGENT GIT-PREFIX
 	$(RM) GIT-SCRIPT-DEFINES GIT-PERL-DEFINES GIT-PERL-HEADER GIT-PYTHON-VAR=
S
+	$(version_clean_script)
 ifdef MSVC
 	$(RM) $(patsubst %.o,%.o.pdb,$(OBJECTS))
 	$(RM) $(patsubst %.exe,%.pdb,$(OTHER_PROGRAMS))
diff --git a/archive.c b/archive.c
index 3c1541af9e..bb56b27581 100644
=2D-- a/archive.c
+++ b/archive.c
@@ -267,8 +267,8 @@ static int queue_or_write_archive_entry(const struct o=
bject_id *oid,
 }

 struct extra_file_info {
-	char *base;
-	struct stat stat;
+	unsigned int mode;
+	size_t size;
 };

 int write_archive_entries(struct archiver_args *args,
@@ -278,7 +278,6 @@ int write_archive_entries(struct archiver_args *args,
 	struct unpack_trees_options opts;
 	struct tree_desc t;
 	int err;
-	struct strbuf path_in_archive =3D STRBUF_INIT;
 	struct strbuf content =3D STRBUF_INIT;
 	struct object_id fake_oid =3D null_oid;
 	int i;
@@ -331,27 +330,24 @@ int write_archive_entries(struct archiver_args *args=
,
 	for (i =3D 0; i < args->extra_files.nr; i++) {
 		struct string_list_item *item =3D args->extra_files.items + i;
 		char *path =3D item->string;
+		char *path_on_disk =3D prefix_filename(args->prefix, path);
+		char *path_in_archive =3D prefix_filename(args->base, path);
 		struct extra_file_info *info =3D item->util;

 		put_be64(fake_oid.hash, i + 1);

-		strbuf_reset(&path_in_archive);
-		if (info->base)
-			strbuf_addstr(&path_in_archive, info->base);
-		strbuf_addstr(&path_in_archive, basename(path));
-
 		strbuf_reset(&content);
-		if (strbuf_read_file(&content, path, info->stat.st_size) < 0)
+		if (strbuf_read_file(&content, path_on_disk, info->size) < 0)
 			err =3D error_errno(_("could not read '%s'"), path);
 		else
-			err =3D write_entry(args, &fake_oid, path_in_archive.buf,
-					  path_in_archive.len,
-					  info->stat.st_mode,
+			err =3D write_entry(args, &fake_oid, path_in_archive,
+					  strlen(path_in_archive), info->mode,
 					  content.buf, content.len);
+		free(path_on_disk);
+		free(path_in_archive);
 		if (err)
 			break;
 	}
-	strbuf_release(&path_in_archive);
 	strbuf_release(&content);

 	return err;
@@ -493,42 +489,6 @@ static void parse_treeish_arg(const char **argv,
 	ar_args->time =3D archive_time;
 }

-static void extra_file_info_clear(void *util, const char *str)
-{
-	struct extra_file_info *info =3D util;
-	free(info->base);
-	free(info);
-}
-
-static int add_file_cb(const struct option *opt, const char *arg, int uns=
et)
-{
-	struct archiver_args *args =3D opt->value;
-	const char **basep =3D (const char **)opt->defval;
-	const char *base =3D *basep;
-	char *path;
-	struct string_list_item *item;
-	struct extra_file_info *info;
-
-	if (unset) {
-		string_list_clear_func(&args->extra_files,
-				       extra_file_info_clear);
-		return 0;
-	}
-
-	if (!arg)
-		return -1;
-
-	path =3D prefix_filename(args->prefix, arg);
-	item =3D string_list_append_nodup(&args->extra_files, path);
-	item->util =3D info =3D xmalloc(sizeof(*info));
-	info->base =3D xstrdup_or_null(base);
-	if (stat(path, &info->stat))
-		die(_("File not found: %s"), path);
-	if (!S_ISREG(info->stat.st_mode))
-		die(_("Not a regular file: %s"), path);
-	return 0;
-}
-
 #define OPT__COMPR(s, v, h, p) \
 	OPT_SET_INT_F(s, NULL, v, h, p, PARSE_OPT_NONEG)
 #define OPT__COMPR_HIDDEN(s, v, p) \
@@ -548,14 +508,14 @@ static int parse_archive_args(int argc, const char *=
*argv,
 	int i;
 	int list =3D 0;
 	int worktree_attributes =3D 0;
+	struct string_list_item *item;
 	struct option opts[] =3D {
 		OPT_GROUP(""),
 		OPT_STRING(0, "format", &format, N_("fmt"), N_("archive format")),
 		OPT_STRING(0, "prefix", &base, N_("prefix"),
 			N_("prepend prefix to each pathname in the archive")),
-		{ OPTION_CALLBACK, 0, "add-file", args, N_("file"),
-		  N_("add untracked file to archive"), 0, add_file_cb,
-		  (intptr_t)&base },
+		OPT_STRING_LIST(0, "add-file", &args->extra_files, N_("file"),
+				N_("add untracked file to archive")),
 		OPT_STRING('o', "output", &output, N_("file"),
 			N_("write the archive to this file")),
 		OPT_BOOL(0, "worktree-attributes", &worktree_attributes,
@@ -593,6 +553,23 @@ static int parse_archive_args(int argc, const char **=
argv,
 	if (is_remote && args->extra_files.nr)
 		die(_("Options --add-file and --remote cannot be used together"));

+	for_each_string_list_item(item, &args->extra_files) {
+		char *path;
+		struct stat st;
+		struct extra_file_info *info;
+
+		path =3D prefix_filename(args->prefix, item->string);
+		if (lstat(path, &st))
+			die(_("File not found: %s"), item->string);
+		if (!S_ISREG(st.st_mode))
+			die(_("Not a regular file: %s"), item->string);
+		free(path);
+
+		item->util =3D info =3D xmalloc(sizeof(*info));
+		info->mode =3D canon_mode(st.st_mode);
+		info->size =3D st.st_size;
+	}
+
 	if (!base)
 		base =3D "";

@@ -661,7 +638,7 @@ int write_archive(int argc, const char **argv, const c=
har *prefix,

 	rc =3D ar->write_archive(ar, &args);

-	string_list_clear_func(&args.extra_files, extra_file_info_clear);
+	string_list_clear(&args.extra_files, 1);

 	return rc;
 }
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 3ebb0d3b65..a090712ddb 100755
=2D-- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -182,17 +182,6 @@ test_expect_success 'git archive --add-file' '
 check_tar with_untracked
 check_added with_untracked untracked untracked

-test_expect_success 'git archive --add-file twice' '
-	echo untracked >untracked &&
-	git archive --prefix=3Done/ --add-file=3Duntracked \
-		--prefix=3Dtwo/ --add-file=3Duntracked \
-		--prefix=3D HEAD >with_untracked2.tar
-'
-
-check_tar with_untracked2
-check_added with_untracked2 untracked one/untracked
-check_added with_untracked2 untracked two/untracked
-
 test_expect_success 'git archive on large files' '
     test_config core.bigfilethreshold 1 &&
     git archive HEAD >b3.tar &&
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 1e6d18b140..a9a44f2760 100755
=2D-- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -206,14 +206,4 @@ test_expect_success 'git archive --format=3Dzip --add=
-file' '
 check_zip with_untracked
 check_added with_untracked untracked untracked

-test_expect_success 'git archive --format=3Dzip --add-file twice' '
-	echo untracked >untracked &&
-	git archive --format=3Dzip --prefix=3Done/ --add-file=3Duntracked \
-		--prefix=3Dtwo/ --add-file=3Duntracked \
-		--prefix=3D HEAD >with_untracked2.zip
-'
-check_zip with_untracked2
-check_added with_untracked2 untracked one/untracked
-check_added with_untracked2 untracked two/untracked
-
 test_done
