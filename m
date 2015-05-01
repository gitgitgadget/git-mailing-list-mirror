From: Alangi Derick <alangiderick@gmail.com>
Subject: Improving code base readability
Date: Fri, 1 May 2015 16:26:17 +0100
Message-ID: <CAKB+oNvB322hyX3UbGBPETDc0zEdC39PdeM=GG=rVf_WYGq_OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 01 17:26:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoCpb-0002Py-St
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 17:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947AbbEAP0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 11:26:19 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:35709 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625AbbEAP0S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 11:26:18 -0400
Received: by qcbgu10 with SMTP id gu10so4687131qcb.2
        for <git@vger.kernel.org>; Fri, 01 May 2015 08:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=xFovCoBmvAFVOihvr6DUHwvqDicHXJjmfmavgd/kWjY=;
        b=rJtQCtiaCapAyilpqq0owlzSxn/qBgouhrv0sltPtv54lpCL/JGxx0/BqCdR2FKL9S
         Ay5Oa7nDZfw6VsUw0IjrBm35fTkiMR7SBdb8OaFpMyQRvfs6C4Iaek96KqlF+/FxeJTH
         kn08qQook5Q6tHHj1B7xR42LMwXTNv0JJu1QPcGo9DB/I80RnAM3g/wKB5f4QVizK/Zj
         Yp0cfsF3bKNL8GtyXqa2geOmHaR/mjJmTj95jD+Ae7roS5BhUR1Wq85qr9Pre1iTYqXf
         SoYyRhkmATZZqIk//rSoYA0tbbA1vlVFcV/xvzqsSsHVW1l4ciSw85zbngG/ULvf+XMr
         CQbA==
X-Received: by 10.229.96.199 with SMTP id i7mr5650546qcn.6.1430493977191; Fri,
 01 May 2015 08:26:17 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Fri, 1 May 2015 08:26:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268145>

This is an example of what i am talking about or what i am trying to
demonstrate. This is the patch:

>From d3515334b435d2626345114ac044416252a5397f Mon Sep 17 00:00:00 2001
From: Alangi Derick <alangiderick@gmail.com>
Date: Fri, 1 May 2015 16:21:33 +0100
Subject: [PATCH v1] Improving code base readability

---
 archive-tar.c   | 10 +++++-----
 archive-zip.c   | 12 ++++++------
 base85.c        | 14 +++++++-------
 builtin/mv.c    |  4 ++--
 builtin/notes.c | 36 ++++++++++++++++++------------------
 builtin/prune.c |  6 +++---
 builtin/push.c  |  6 +++---
 git.c           |  2 +-
 8 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 0d1e6bd..c5d64aa 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -102,7 +102,7 @@ static int stream_blocked(const unsigned char *sha1)

  st = open_istream(sha1, &type, &sz, NULL);
  if (!st)
- return error("cannot stream blob %s", sha1_to_hex(sha1));
+ return error("Cannot stream blob %s", sha1_to_hex(sha1));
  for (;;) {
  readlen = read_istream(st, buf, sizeof(buf));
  if (readlen <= 0)
@@ -224,7 +224,7 @@ static int write_tar_entry(struct archiver_args *args,
  *header.typeflag = TYPEFLAG_REG;
  mode = (mode | ((mode & 0100) ? 0777 : 0666)) & ~tar_umask;
  } else {
- return error("unsupported file mode: 0%o (SHA1: %s)",
+ return error("Unsupported file mode: 0%o (SHA1: %s)",
      mode, sha1_to_hex(sha1));
  }
  if (pathlen > sizeof(header.name)) {
@@ -251,7 +251,7 @@ static int write_tar_entry(struct archiver_args *args,
  enum object_type type;
  buffer = sha1_file_to_archive(args, path, sha1, old_mode, &type, &size);
  if (!buffer)
- return error("cannot read %s", sha1_to_hex(sha1));
+ return error("Cannot read %s", sha1_to_hex(sha1));
  } else {
  buffer = NULL;
  size = 0;
@@ -413,10 +413,10 @@ static int write_tar_filter_archive(const struct
archiver *ar,
  filter.in = -1;

  if (start_command(&filter) < 0)
- die_errno("unable to start '%s' filter", argv[0]);
+ die_errno("Unable to start '%s' filter", argv[0]);
  close(1);
  if (dup2(filter.in, 1) < 0)
- die_errno("unable to redirect descriptor");
+ die_errno("Unable to redirect descriptor");
  close(filter.in);

  r = write_tar_archive(ar, args);
diff --git a/archive-zip.c b/archive-zip.c
index ffb3535..18eef04 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -234,7 +234,7 @@ static int write_zip_entry(struct archiver_args *args,
  }

  if (pathlen > 0xffff) {
- return error("path too long (%d chars, SHA1: %s): %s",
+ return error("Path too long (%d chars, SHA1: %s): %s",
  (int)pathlen, sha1_to_hex(sha1), path);
  }

@@ -258,7 +258,7 @@ static int write_zip_entry(struct archiver_args *args,
     size > big_file_threshold) {
  stream = open_istream(sha1, &type, &size, NULL);
  if (!stream)
- return error("cannot stream blob %s",
+ return error("Cannot stream blob %s",
      sha1_to_hex(sha1));
  flags |= ZIP_STREAM;
  out = buffer = NULL;
@@ -266,7 +266,7 @@ static int write_zip_entry(struct archiver_args *args,
  buffer = sha1_file_to_archive(args, path, sha1, mode,
       &type, &size);
  if (!buffer)
- return error("cannot read %s",
+ return error("Cannot read %s",
      sha1_to_hex(sha1));
  crc = crc32(crc, buffer, size);
  is_binary = entry_is_binary(path_without_prefix,
@@ -275,7 +275,7 @@ static int write_zip_entry(struct archiver_args *args,
  }
  compressed_size = (method == 0) ? size : 0;
  } else {
- return error("unsupported file mode: 0%o (SHA1: %s)", mode,
+ return error("Unsupported file mode: 0%o (SHA1: %s)", mode,
  sha1_to_hex(sha1));
  }

@@ -385,7 +385,7 @@ static int write_zip_entry(struct archiver_args *args,
  zstream.avail_in = readlen;
  result = git_deflate(&zstream, 0);
  if (result != Z_OK)
- die("deflate error (%d)", result);
+ die("Deflate error (%d)", result);
  out_len = zstream.next_out - compressed;

  if (out_len > 0) {
@@ -404,7 +404,7 @@ static int write_zip_entry(struct archiver_args *args,
  zstream.avail_in = 0;
  result = git_deflate(&zstream, Z_FINISH);
  if (result != Z_STREAM_END)
- die("deflate error (%d)", result);
+ die("Deflate error (%d)", result);

  git_deflate_end(&zstream);
  out_len = zstream.next_out - compressed;
diff --git a/base85.c b/base85.c
index 5ca601e..9142940 100644
--- a/base85.c
+++ b/base85.c
@@ -50,17 +50,17 @@ int decode_85(char *dst, const char *buffer, int len)
  ch = *buffer++;
  de = de85[ch];
  if (--de < 0)
- return error("invalid base85 alphabet %c", ch);
+ return error("Invalid base85 alphabet %c", ch);
  acc = acc * 85 + de;
  } while (--cnt);
  ch = *buffer++;
  de = de85[ch];
  if (--de < 0)
- return error("invalid base85 alphabet %c", ch);
+ return error("Invalid base85 alphabet %c", ch);
  /* Detect overflow. */
  if (0xffffffff / 85 < acc ||
     0xffffffff - de < (acc *= 85))
- return error("invalid base85 sequence %.5s", buffer-5);
+ return error("Invalid base85 sequence %.5s", buffer-5);
  acc += de;
  say1(" %08x", acc);

@@ -78,7 +78,7 @@ int decode_85(char *dst, const char *buffer, int len)

 void encode_85(char *buf, const unsigned char *data, int bytes)
 {
- say("encode 85");
+ say("Encode 85");
  while (bytes) {
  unsigned acc = 0;
  int cnt;
@@ -111,7 +111,7 @@ int main(int ac, char **av)
  encode_85(buf, av[2], len);
  if (len <= 26) len = len + 'A' - 1;
  else len = len + 'a' - 26 - 1;
- printf("encoded: %c%s\n", len, buf);
+ printf("Encoded: %c%s\n", len, buf);
  return 0;
  }
  if (!strcmp(av[1], "-d")) {
@@ -119,13 +119,13 @@ int main(int ac, char **av)
  if ('A' <= len && len <= 'Z') len = len - 'A' + 1;
  else len = len - 'a' + 26 + 1;
  decode_85(buf, av[2]+1, len);
- printf("decoded: %.*s\n", len, buf);
+ printf("Decoded: %.*s\n", len, buf);
  return 0;
  }
  if (!strcmp(av[1], "-t")) {
  char t[4] = { -1,-1,-1,-1 };
  encode_85(buf, t, 4);
- printf("encoded: D%s\n", buf);
+ printf("Encoded: D%s\n", buf);
  return 0;
  }
 }
diff --git a/builtin/mv.c b/builtin/mv.c
index d1d4316..c4b8a43 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -148,7 +148,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
  destination = internal_copy_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
  } else {
  if (argc != 1)
- die(_("destination '%s' is not a directory"), dest_path[0]);
+ die(_("Destination '%s' is not a directory"), dest_path[0]);
  destination = dest_path;
  }

@@ -253,7 +253,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
  printf(_("Renaming %s to %s\n"), src, dst);
  if (!show_only && mode != INDEX) {
  if (rename(src, dst) < 0 && !ignore_errors)
- die_errno(_("renaming '%s' failed"), src);
+ die_errno(_("Renaming '%s' failed"), src);
  if (submodule_gitfile[i]) {
  if (submodule_gitfile[i] != SUBMODULE_WITH_GITDIR)
  connect_work_tree_and_git_dir(dst, submodule_gitfile[i]);
diff --git a/builtin/notes.c b/builtin/notes.c
index 63f95fc..aa69b7f 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -143,11 +143,11 @@ static void write_commented_object(int fd, const
unsigned char *object)
  show.err = 0;
  show.git_cmd = 1;
  if (start_command(&show))
- die(_("unable to start 'show' for object '%s'"),
+ die(_("Unable to start 'show' for object '%s'"),
     sha1_to_hex(object));

  if (strbuf_read(&buf, show.out, 0) < 0)
- die_errno(_("could not read 'show' output"));
+ die_errno(_("Could not read 'show' output"));
  strbuf_add_commented_lines(&cbuf, buf.buf, buf.len);
  write_or_die(fd, cbuf.buf, cbuf.len);

@@ -155,7 +155,7 @@ static void write_commented_object(int fd, const
unsigned char *object)
  strbuf_release(&buf);

  if (finish_command(&show))
- die(_("failed to finish 'show' for object '%s'"),
+ die(_("Failed to finish 'show' for object '%s'"),
     sha1_to_hex(object));
 }

@@ -170,7 +170,7 @@ static void prepare_note_data(const unsigned char
*object, struct note_data *d,
  d->edit_path = git_pathdup("NOTES_EDITMSG");
  fd = open(d->edit_path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
  if (fd < 0)
- die_errno(_("could not create file '%s'"), d->edit_path);
+ die_errno(_("Could not create file '%s'"), d->edit_path);

  if (d->given)
  write_or_die(fd, d->buf.buf, d->buf.len);
@@ -198,7 +198,7 @@ static void prepare_note_data(const unsigned char
*object, struct note_data *d,
 static void write_note_data(struct note_data *d, unsigned char *sha1)
 {
  if (write_sha1_file(d->buf.buf, d->buf.len, blob_type, sha1)) {
- error(_("unable to write note object"));
+ error(_("Unable to write note object"));
  if (d->edit_path)
  error(_("The note contents have been left in %s"),
  d->edit_path);
@@ -228,9 +228,9 @@ static int parse_file_arg(const struct option
*opt, const char *arg, int unset)
  strbuf_addch(&d->buf, '\n');
  if (!strcmp(arg, "-")) {
  if (strbuf_read(&d->buf, 0, 1024) < 0)
- die_errno(_("cannot read '%s'"), arg);
+ die_errno(_("Cannot read '%s'"), arg);
  } else if (strbuf_read_file(&d->buf, arg, 1024) < 0)
- die_errno(_("could not open or read '%s'"), arg);
+ die_errno(_("Could not open or read '%s'"), arg);
  stripspace(&d->buf, 0);

  d->given = 1;
@@ -355,7 +355,7 @@ static int list(int argc, const char **argv, const
char *prefix)
      git_notes_list_usage, 0);

  if (1 < argc) {
- error(_("too many parameters"));
+ error(_("Too many parameters"));
  usage_with_options(git_notes_list_usage, options);
  }

@@ -410,7 +410,7 @@ static int add(int argc, const char **argv, const
char *prefix)
      PARSE_OPT_KEEP_ARGV0);

  if (2 < argc) {
- error(_("too many parameters"));
+ error(_("Too many parameters"));
  usage_with_options(git_notes_add_usage, options);
  }

@@ -486,7 +486,7 @@ static int copy(int argc, const char **argv, const
char *prefix)

  if (from_stdin || rewrite_cmd) {
  if (argc) {
- error(_("too many parameters"));
+ error(_("Too many parameters"));
  usage_with_options(git_notes_copy_usage, options);
  } else {
  return notes_copy_from_stdin(force, rewrite_cmd);
@@ -494,11 +494,11 @@ static int copy(int argc, const char **argv,
const char *prefix)
  }

  if (argc < 2) {
- error(_("too few parameters"));
+ error(_("Too few parameters"));
  usage_with_options(git_notes_copy_usage, options);
  }
  if (2 < argc) {
- error(_("too many parameters"));
+ error(_("Too many parameters"));
  usage_with_options(git_notes_copy_usage, options);
  }

@@ -574,7 +574,7 @@ static int append_edit(int argc, const char
**argv, const char *prefix)
      PARSE_OPT_KEEP_ARGV0);

  if (2 < argc) {
- error(_("too many parameters"));
+ error(_("Too many parameters"));
  usage_with_options(usage, options);
  }

@@ -642,7 +642,7 @@ static int show(int argc, const char **argv, const
char *prefix)
      0);

  if (1 < argc) {
- error(_("too many parameters"));
+ error(_("Too many parameters"));
  usage_with_options(git_notes_show_usage, options);
  }

@@ -770,7 +770,7 @@ static int merge(int argc, const char **argv,
const char *prefix)
  if (strategy || do_commit + do_abort == 0)
  do_merge = 1;
  if (do_merge + do_commit + do_abort != 1) {
- error("cannot mix --commit, --abort or -s/--strategy");
+ error("Cannot mix --commit, --abort or -s/--strategy");
  usage_with_options(git_notes_merge_usage, options);
  }

@@ -778,7 +778,7 @@ static int merge(int argc, const char **argv,
const char *prefix)
  error("Must specify a notes ref to merge");
  usage_with_options(git_notes_merge_usage, options);
  } else if (!do_merge && argc) {
- error("too many parameters");
+ error("Too many parameters");
  usage_with_options(git_notes_merge_usage, options);
  }

@@ -916,7 +916,7 @@ static int prune(int argc, const char **argv,
const char *prefix)
      0);

  if (argc) {
- error(_("too many parameters"));
+ error(_("Too many parameters"));
  usage_with_options(git_notes_prune_usage, options);
  }

@@ -937,7 +937,7 @@ static int get_ref(int argc, const char **argv,
const char *prefix)
      git_notes_get_ref_usage, 0);

  if (argc) {
- error("too many parameters");
+ error("Too many parameters");
  usage_with_options(git_notes_get_ref_usage, options);
  }

diff --git a/builtin/prune.c b/builtin/prune.c
index 17094ad..aa7ffb2 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -53,7 +53,7 @@ static int prune_object(const unsigned char *sha1,
const char *fullpath,
  if (show_only || verbose) {
  enum object_type type = sha1_object_info(sha1, NULL);
  printf("%s %s\n", sha1_to_hex(sha1),
-       (type > 0) ? typename(type) : "unknown");
+       (type > 0) ? typename(type) : "Unknown");
  }
  if (!show_only)
  unlink_or_warn(fullpath);
@@ -65,7 +65,7 @@ static int prune_cruft(const char *basename, const
char *path, void *data)
  if (starts_with(basename, "tmp_obj_"))
  prune_tmp_file(path);
  else
- fprintf(stderr, "bad sha1 file: %s\n", path);
+ fprintf(stderr, "Bad sha1 file: %s\n", path);
  return 0;
 }

@@ -128,7 +128,7 @@ int cmd_prune(int argc, const char **argv, const
char *prefix)
  add_pending_object(&revs, object, "");
  }
  else
- die("unrecognized argument: %s", name);
+ die("Unrecognized argument: %s", name);
  }

  if (show_progress == -1)
diff --git a/builtin/push.c b/builtin/push.c
index 57c138b..6af9d34 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -391,7 +391,7 @@ static int do_push(const char *repo, int flags)

  if (!remote) {
  if (repo)
- die(_("bad repository '%s'"), repo);
+ die(_("Bad repository '%s'"), repo);
  die(_("No configured push destination.\n"
     "Either specify the URL from the command-line or configure a
remote repository using\n"
     "\n"
@@ -463,9 +463,9 @@ static int option_parse_recurse_submodules(const
struct option *opt,
  else if (!strcmp(arg, "on-demand"))
  *flags |= TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND;
  else
- die("bad %s argument: %s", opt->long_name, arg);
+ die("Bad %s argument: %s", opt->long_name, arg);
  } else
- die("option %s needs an argument (check|on-demand)",
+ die("Option %s needs an argument (check|on-demand)",
  opt->long_name);

  return 0;
diff --git a/git.c b/git.c
index 481aa74..f9343d0 100644
--- a/git.c
+++ b/git.c
@@ -654,7 +654,7 @@ int main(int argc, char **av)
  if (skip_prefix(cmd, "git-", &cmd)) {
  argv[0] = cmd;
  handle_builtin(argc, argv);
- die("cannot handle %s as a builtin", cmd);
+ die("Cannot handle %s as a builtin", cmd);
  }

  /* Look for flags.. */
-- 
2.4.0.2.g54b2a32.dirty


Regards
Alangi Derick Ndimnain
