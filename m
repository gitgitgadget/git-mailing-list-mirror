Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16656433B3
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775321628; cv=pass; b=Vr0CL1wuRmwkTctZvZVD8YfGZg/JEV5rnwuMn51tlwP+Sc3f5YeIuv1hjDtkFOJK3JfBrHwaGD9M5qi0xePEvIGDzm5ahvjjLIJrGXZC7BivcmC+LLOrdWyOlXZnQ+eYcVcf0HPvVdhn2ACQSQfKgH++Co37AN5VgXtEYekF818=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775321628; c=relaxed/simple;
	bh=2rYOyAHp3Wgva9ckCT5KIfmnJmP/WpIinoG/pC7JG3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LITX1B7egdm7FTgrG1l8vqZU7hXiXwah1d5wvSvQGuisLZwjYXQ2yIaIC/5Tz7/n27FtSfa0B+UKhvmmTOw+6iPXFi/wforn8Dwq/bDvJm/wpdjalkizqZOe3GpeddealQ4etWb3jWlsY5R4vy15oIhBMyygqmTIENR1LjBRZvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q9jAaRRn; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9jAaRRn"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b2469e5117so14595715ad.1
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 09:53:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775321626; cv=none;
        d=google.com; s=arc-20240605;
        b=dn4QolMjze/f9X9R4b2pJrg8MyUr1KryszsybEQSozAcc3QFYSIrbLAF+XqFCziYuA
         pU2Y3Ek3iH1Kn0MB8wLFyynhX2Erl0bjVy+XhkPQVoKZKkuS0qE8/YoKAup05qZ+m/Nw
         mCVJZyX/QcbFbrzBqaOLukE5NOFuV9MM14Xq9hB4ACduwHdfiNIH7Tg4VrKHTHLCR/Lv
         rTsAFPPmzmpSpG6ejawYh+pCMqE9QiAeY+Q7diA0cGYHCGWslhw6i6kgH8mD24YN6mu6
         A7S7TvM4mFGOPol1GrxEwGIvpdOvlX6MkVFA/r2JN8azR5Nry8K812lxHn/l2F19LQu/
         PjfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ws8b3IhMMIjRfmqHVfyQAGdB9/0KMSXJVKWtdxibuCw=;
        fh=Dz5fchjveqGdgzI3p5g1G0Y9h48zsKBjh6bG+DxRM34=;
        b=MLGg2HOfRsYgRGCMVrD5/rdR2jfUjwN/qWalbWjbaqbvcBE4Ew4kbxE91+mEQ8Z+ec
         C24jaKk6BijXzCoMuTLbq96SnQG/Odz5DAutgegvlyHXyOO3dXn+ows2H2y7HmmIRNgj
         8kGB1eBQkSCDjDOOYc7bJGJbnleywFmd4bpjByniRTyGElG74rFrQ7MYpWNH9lVfx/Tc
         O283wVd0Y5LcWnJ8I3rdM+5nS5bMPd2WjUIanGJ6VBE03AF3K3siLOqf8rjTwebecA45
         l9XWc4aljHbZOBe2p7H7fYyq3jp2kf1kU8lzrQz5Pr9FmAH3bEH1T9LAIaNfaG3FLd20
         YmVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775321626; x=1775926426; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ws8b3IhMMIjRfmqHVfyQAGdB9/0KMSXJVKWtdxibuCw=;
        b=q9jAaRRnB4bzCqL7gWGlDRmYAssyxILt3tSuUIKc3cGsuVqQuSIkRxv/DgnMbAWHJb
         vCkP1xHniGQfuqhjI7Oa9KToEw2IcxkFLLxCyED3lZLvkwH+E+TKVUQNa0a7ZbFMUoVj
         5UnGh8FPBRbRPjzsDI6r639tiCDj2U+wyWnUJWrd+U2sV3NabbVFBz0nuv4sXdDK2V25
         nrJKCpSlEF1dU10xN++jhRWzZ+dcSUAdLMdg5iM/Gq2k924cCVYsZhP/hhNSbA8poZUi
         EH823Elwikdn5g2UUlGzQdN4cmFL55PSM8wWDmeJFvKqJcTlVie2GWtKdcyLwBaspJdK
         H7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775321626; x=1775926426;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ws8b3IhMMIjRfmqHVfyQAGdB9/0KMSXJVKWtdxibuCw=;
        b=QVc6eKmxKBs6R6GTp3hRfsJ+bEbWdvTA7pm41iRH6gAC5xe8gPyd+bJdWQlKj41kli
         5MwQCFZm8b7afw89JjaB5czI/hq5PAGDEBRDKqjM8Qj/BJ/QycAj0uItb85iFQnBN4sA
         Nn9q6Bc1jwc1RKPb6nr2BYapbBnVZNRVS0SSfUVFqdeJ25Cnt21Wjs57sExzeGG9yyuM
         FeC1cNUlpQvHpX5NwHVutT4WXNzC1HzExnePT9Ma3j3KXXGrMAOPrHJ4vn2k/a3TzP4o
         8oJxLC3ug2GGMwa1ahjKQC7YLS+DDJr3Eh6KxbqxN+LCRxNlBx65HG4BV2Kdofucwj4b
         X3Cw==
X-Gm-Message-State: AOJu0Ywbrw91akKsfS7Kd7rj/VgAKVykaqO3mAXCarRPWc8e+mfwlvz2
	L/9EGohkhFB26NkUHCwhl10ToadXQ2UQ58CTrdryJyu0pR1O1XtbALJAaBNe7xSdV5WuemQIuRb
	7RNzx2yDqNb5umhM0fX7m8vuBwVgK4y/O/ovN4mY=
X-Gm-Gg: AeBDieuGYzjZK/wxu7XhuSrnuln6+RDo3F2MmxEpycj3M+rhPcF8xWgJ9gkzDltVHz4
	ps4hquj6RDJux0ZojE5m//EXAi346C4v2rr/KZ9+1UPM7BhMTRAU8KLaN+ja7ovCdPh9f6Hcf0c
	Tz4Ex2KfoGt2BHbabmcQFS86qTdiM3zAz7mP6WBPXmtTMDrr2XyVQfl3d/OM9geQAFfsAnScX99
	M8Nj9+2P3PNqLg9GS0ls9KOyk+sNqpse7hMkK0sjXUuD7CeypmEYg4EfgcA63QYK7oEenOBgA7F
	6HmY
X-Received: by 2002:a17:902:ce0b:b0:2b0:c060:aab8 with SMTP id
 d9443c01a7336-2b277d9b788mr89373155ad.9.1775321626450; Sat, 04 Apr 2026
 09:53:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO0HQ0X_pQmew5tJReOL=u+CMxCjAQynx8JfjykoYAUE59YNzw@mail.gmail.com>
 <d6c63949-1998-4cde-8cb0-902fd7db988c@malon.dev>
In-Reply-To: <d6c63949-1998-4cde-8cb0-902fd7db988c@malon.dev>
From: Luca Stefani <luca.stefani.ge1@gmail.com>
Date: Sat, 4 Apr 2026 18:53:35 +0200
X-Gm-Features: AQROBzDS4NnV7-K8iB4La8CgYGT738eFAsDoqIkNDZlBUek8SMUDbhqA3IsTvuM
Message-ID: <CAO0HQ0VEJsG6MYrp_bSTuU09PDsypGPrM0XazvM8er0kB32Gqg@mail.gmail.com>
Subject: Re: [BUG] git diff --no-index segfaults on large files (NULL object database)
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for looking into it.
Locally, I simply check against null storage and it works just fine,
flags is always 0 in my experiments so a check against
INDEX_WRITE_OBJECT also worked.

diff --git a/object-file.c b/object-file.c
index f0b029ff0b..68303aa99c 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1654,7 +1654,8 @@ int index_fd(struct index_state *istate, struct
object_id *oid,
  } else if ((st->st_size >= 0 &&
      (size_t)st->st_size <=
repo_settings_get_big_file_threshold(istate->repo)) ||
     type != OBJ_BLOB ||
-    (path && would_convert_to_git(istate, path))) {
+    (path && would_convert_to_git(istate, path)) ||
+    !(flags & INDEX_WRITE_OBJECT)) {
  ret = index_core(istate, oid, fd, xsize_t(st->st_size),
  type, path, flags);
  } else {

Luca.


On Sat, 4 Apr 2026 at 18:45, Tian Yuchen <cat@malon.dev> wrote:
>
> On 4/4/26 18:39, Luca Stefani wrote:
> > Thank you for filling out a Git bug report!
> > Please answer the following questions to help us understand your issue.
> >
> > What did you do before the bug happened? (Steps to reproduce your issue)
> >
> > `git diff --color -- file1 file2` SIGSEGV in case file1 and file2
> > are "big enough", that is when the file size is bigger than
> > repo_settings_get_big_file_threshold()
> >
> > What did you expect to happen? (Expected behavior)
> >
> > Not a crash, it to say "binary files are different"
> >
> > What happened instead? (Actual behavior)
> >
> > Program received signal SIGSEGV, Segmentation fault.
> > index_fd (istate=istate@entry=0x5555559ccb40,
> > oid=oid@entry=0x5555559d3c80, fd=4, st=st@entry=0x7fffffffc5c0,
> > type=type@entry=OBJ_BLOB, path=path@entry=0x5555559d3ce0
> > "4/root_part", flags=0) at /usr/src/debug/git/git/object-file.c:1634
> > 1634                    transaction =
> > odb_transaction_begin(the_repository->objects);
> > (gdb) bt
> > #0  index_fd (istate=istate@entry=0x5555559ccb40,
> > oid=oid@entry=0x5555559d3c80, fd=4, st=st@entry=0x7fffffffc5c0,
> > type=type@entry=OBJ_BLOB, path=path@entry=0x5555559d3ce0
> > "4/root_part", flags=0)
> >     at /usr/src/debug/git/git/object-file.c:1634
> > #1  0x000055555579ab75 in index_path (istate=0x5555559ccb40,
> > oid=0x5555559d3c80, path=0x5555559d3ce0 "4/root_part",
> > st=0x7fffffffc5c0, flags=0) at
> > /usr/src/debug/git/git/object-file.c:1658
> > #2  0x0000555555720f83 in diff_fill_oid_info (one=0x5555559d3c80,
> > istate=0x5555559ccb40) at /usr/src/debug/git/git/diff.c:4690
> > #3  diff_fill_oid_info (one=one@entry=0x5555559d3c80,
> > istate=0x5555559ccb40) at /usr/src/debug/git/git/diff.c:4679
> > #4  0x0000555555724aba in run_diff (p=0x5555559ce900,
> > o=0x7fffffffd188) at /usr/src/debug/git/git/diff.c:4738
> > #5  diff_flush_patch (p=0x5555559ce900, o=0x7fffffffd188) at
> > /usr/src/debug/git/git/diff.c:6247
> > #6  0x0000555555729850 in diff_flush_patch_all_file_pairs
> > (o=0x7fffffffd188) at /usr/src/debug/git/git/diff.c:6802
> > #7  diff_flush (options=<optimized out>) at /usr/src/debug/git/git/diff.c:6942
> > #8  0x00005555555b0d34 in diff_no_index (revs=0x7fffffffcbd0,
> > algop=0x55555598dbd0 <hash_algos+112>, implicit_no_index=<optimized
> > out>, argc=2, argv=0x5555559ce2a0) at
> > /usr/src/debug/git/git/diff-no-index.c:427
> > #9  cmd_diff (argc=<optimized out>, argv=0x5555559ce2a0,
> > prefix=<optimized out>, repo=<optimized out>) at builtin/diff.c:516
> > #10 0x000055555555fe05 in run_builtin (p=0x555555994ec8
> > <commands.lto_priv+840>, argc=<optimized out>, argv=<optimized out>,
> > repo=0x5555559a3c00 <the_repo.lto_priv>) at
> > /usr/src/debug/git/git/git.c:506
> > #11 handle_builtin (args=args@entry=0x7fffffffd980) at
> > /usr/src/debug/git/git/git.c:779
> > #12 0x00005555555612cc in run_argv (args=0x7fffffffd980) at
> > /usr/src/debug/git/git/git.c:862
> > #13 cmd_main (argc=<optimized out>, argv=<optimized out>) at
> > /usr/src/debug/git/git/git.c:984
> > #14 0x000055555555d794 in main (argc=6, argv=0x7fffffffdc58) at
> > /usr/src/debug/git/git/common-main.c:9
> > (gdb) p the_repository->objects
> > $1 = (struct object_database *) 0x0
> > (gdb) p istate->repo->objects
> > $2 = (struct object_database *) 0x0
> > (gdb) p istate->repo
> > $3 = (struct repository *) 0x5555559a3c00 <the_repo.lto_priv>
> > (gdb) p the_repository
> > $4 = (struct repository *) 0x5555559a3c00 <the_repo.lto_priv>
> >
> > The same issue happens in master, the same path is taken and when we
> > finally get into
> > `odb_transaction_begin` where odb is NULL, and reading ->transaction
> > causes the illegal
> > segment access once again.
> >
> > Program received signal SIGSEGV, Segmentation fault.
> > 0x00005555557c6283 in odb_transaction_begin (odb=0x0) at odb.c:1075
> > 1075            if (odb->transaction)
> > (gdb) bt
> > #0  0x00005555557c6283 in odb_transaction_begin (odb=0x0) at odb.c:1075
> > #1  0x00005555557b94f9 in index_fd (istate=0x555555a88b60,
> > oid=0x555555a8fcb0, fd=4, st=0x7fffffffc730, type=OBJ_BLOB,
> > path=0x555555a8fd10 "4/root_part", flags=0) at object-file.c:1665
> > #2  0x00005555557b9651 in index_path (istate=0x555555a88b60,
> > oid=0x555555a8fcb0, path=0x555555a8fd10 "4/root_part",
> > st=0x7fffffffc730, flags=0) at object-file.c:1691
> > #3  0x0000555555730937 in diff_fill_oid_info (one=0x555555a8fcb0,
> > istate=0x555555a88b60) at diff.c:4699
> > #4  0x0000555555730b81 in run_diff (p=0x555555a8a9a0,
> > o=0x7fffffffd1a8) at diff.c:4747
> > #5  0x00005555557361d5 in diff_flush_patch (p=0x555555a8a9a0,
> > o=0x7fffffffd1a8) at diff.c:6258
> > #6  0x0000555555737cae in diff_flush_patch_all_file_pairs
> > (o=0x7fffffffd1a8) at diff.c:6813
> > #7  0x00005555557382b2 in diff_flush (options=0x7fffffffd1a8) at diff.c:6953
> > #8  0x00005555557228cc in diff_no_index (revs=0x7fffffffcbf0,
> > algop=0x555555a49b50 <hash_algos+112>, implicit_no_index=1, argc=2,
> > argv=0x555555a8a2f0) at diff-no-index.c:427
> > #9  0x00005555555c04b1 in cmd_diff (argc=5, argv=0x555555a8a2f0,
> > prefix=0x0, repo=0x0) at builtin/diff.c:516
> > #10 0x0000555555574f47 in run_builtin (p=0x555555a4aaa8
> > <commands+840>, argc=5, argv=0x555555a8a2f0, repo=0x555555a7e620
> > <the_repo>) at git.c:506
> > #11 0x000055555557544e in handle_builtin (args=0x7fffffffdab0) at git.c:780
> > #12 0x0000555555575778 in run_argv (args=0x7fffffffdab0) at git.c:863
> > #13 0x0000555555575c0f in cmd_main (argc=5, argv=0x7fffffffdc50) at git.c:984
> > #14 0x00005555556a7414 in main (argc=6, argv=0x7fffffffdc48) at common-main.c:9
>
> The problem is most likely to occur in object-file.c:
>
> ...
> int index_fd(struct index_state *istate, struct object_id *oid,
>              int fd, struct stat *st,
>              enum object_type type, const char *path, unsigned flags)
> {
>         int ret;
>
>         /*
>          * Call xsize_t() only when needed to avoid potentially unnecessary
>          * die() for large files.
>          */
>         if (type == OBJ_BLOB && path && would_convert_to_git_filter_fd(istate,
> path)) {
>                 ret = index_stream_convert_blob(istate, oid, fd, path, flags);
>         } else if (!S_ISREG(st->st_mode)) {
>                 ret = index_pipe(istate, oid, fd, type, path, flags);
>         } else if ((st->st_size >= 0 &&
>                     (size_t)st->st_size <=
> repo_settings_get_big_file_threshold(istate->repo)) ||
>                    type != OBJ_BLOB ||
>                    (path && would_convert_to_git(istate, path))) {
>                 ret = index_core(istate, oid, fd, xsize_t(st->st_size),
>                                  type, path, flags);
>         } else {
>                 struct object_database *odb = the_repository->objects;
>                 struct odb_transaction_files *files_transaction;
>                 struct odb_transaction *transaction;
>
>                 transaction = odb_transaction_begin(odb);
>                 files_transaction = container_of(odb->transaction,
>                                                  struct odb_transaction_files,
>                                                  base);
>                 ret = index_blob_packfile_transaction(files_transaction, oid, fd,
>                                                       xsize_t(st->st_size),
>                                                       path, flags);
>                 odb_transaction_commit(transaction);
>         }
>
>         close(fd);
>         return ret;
> }
> ...
>
> Note that in 'if (type == OBJ_BLOB && st->st_size > big_file_threshold)'
> block, there is no check to see if 'the_repository->objects' is NULL. It
> assumes that an object database is available, which is not true in
> no-repository scenarios.
>
> One possible solution would be as follows: only when 'flags &
> HASH_WRITE_OBJECT' (or something like that) is true does this indicate
> that the file needs to be written in; if it is false only the hash value
> is required and the file should not be written in.
>
> Will send a patch to fix it, soon.
>
> Thanks, Yuchen
