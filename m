Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB2923645D
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775321113; cv=none; b=pL19ppJ06lnHrF6sBbjDD5RQxMCEjQX2zro9Z5a0PefwQWuEcxcHyL9OBiiD5D8xbwBWcVZojKYCNIE/GRFi+7h7gMH1adBqpo/EbQoZQ2pnpb+mriPKBhxX0yZ4IqWoIBzY4wvjkMtl43qPFXG/OlBMYZIDk/+Z6pdrzk94UX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775321113; c=relaxed/simple;
	bh=06YInPmLcJbbME/VzHbAG3f5TZdqMsiZ28zsxkJ0PQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ERxa9tpc5CIFNhl4gj8YtNOH3fRyeYhYboejT6jLRCQGVDpj0KIeEZ6XuMB9Yip75O7TIgrwySHGQ7P0DQ1pNyK2aIRSgFuUFjJ8Msy9nrPCaCS46S2NjQGJWwM2lxdPs04nR4+IFqHB0g9hsSdrzsnP5nhcPhybEFiEdgX4qL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=OJjCPUca; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=azX+RKrb; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="OJjCPUca";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="azX+RKrb"
DKIM-Signature: a=rsa-sha256; b=OJjCPUcaOakM97MIyc8zquNzbO59xo+XQMonlRtNafhbAXVrStnh+wk3WHu5PjFkvV26FToouZKqT6Tr3I8EhvpPV3BhKV2VPAnExUOhatiNmyIgE7x44At248AltyiZtvcLnRmU/PfI4QQAF6PwcAqMggQuWujqPsvS3SUziKIZAfro8tVdBOtfg13QXCRfHyUNAyXIV1RyuIjqIjGrvJZVVHbclvYsIjnuIDnn7G9jSRuUMcdeSXX0na6jankIcKSLeEA38yvHOEJCbcG24chduOe8XtTcU6Jrpgk77ho6B6gJNbp462hk66TEBFmbePVRvqMw2snHGerTAKlRvw==; s=purelymail2; d=malon.dev; v=1; bh=06YInPmLcJbbME/VzHbAG3f5TZdqMsiZ28zsxkJ0PQ0=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=azX+RKrb1B9s1yOj6ZTuIrJ194JrGXCFzQWb65p8L972O8wskGMN5bTTa9VFn8zV3O5O6NNxALzWfi9ncET8skbrZzK0Dg6oiwvtFG40NVB7K9XtWpp4XUmDjC1mLcjPnzlXt9w6bD6akMNHfr9qMYew7s+0kiuXJReSGFRt+euY2fdeoypgk9vfLC0qSj1LegJdFybMk5x+GwfW44/lxmfuwSX+j1xKc3PNKlhgIXg3lBlwUgk2cPtLY8KvHJKzd7kWf7bDY1iehiMXJtvSkHHjyFAcDVubtRCj9BIcnsLNnywRuSRuQmsMWzkbJlWbMqprEf8HZmmr691m4PI1pw==; s=purelymail2; d=purelymail.com; v=1; bh=06YInPmLcJbbME/VzHbAG3f5TZdqMsiZ28zsxkJ0PQ0=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 748357501;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 04 Apr 2026 16:45:03 +0000 (UTC)
Message-ID: <d6c63949-1998-4cde-8cb0-902fd7db988c@malon.dev>
Date: Sun, 5 Apr 2026 00:45:00 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] git diff --no-index segfaults on large files (NULL object
 database)
To: Luca Stefani <luca.stefani.ge1@gmail.com>, git@vger.kernel.org
References: <CAO0HQ0X_pQmew5tJReOL=u+CMxCjAQynx8JfjykoYAUE59YNzw@mail.gmail.com>
Content-Language: en-US
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <CAO0HQ0X_pQmew5tJReOL=u+CMxCjAQynx8JfjykoYAUE59YNzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/26 18:39, Luca Stefani wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> `git diff --color -- file1 file2` SIGSEGV in case file1 and file2
> are "big enough", that is when the file size is bigger than
> repo_settings_get_big_file_threshold()
> 
> What did you expect to happen? (Expected behavior)
> 
> Not a crash, it to say "binary files are different"
> 
> What happened instead? (Actual behavior)
> 
> Program received signal SIGSEGV, Segmentation fault.
> index_fd (istate=istate@entry=0x5555559ccb40,
> oid=oid@entry=0x5555559d3c80, fd=4, st=st@entry=0x7fffffffc5c0,
> type=type@entry=OBJ_BLOB, path=path@entry=0x5555559d3ce0
> "4/root_part", flags=0) at /usr/src/debug/git/git/object-file.c:1634
> 1634                    transaction =
> odb_transaction_begin(the_repository->objects);
> (gdb) bt
> #0  index_fd (istate=istate@entry=0x5555559ccb40,
> oid=oid@entry=0x5555559d3c80, fd=4, st=st@entry=0x7fffffffc5c0,
> type=type@entry=OBJ_BLOB, path=path@entry=0x5555559d3ce0
> "4/root_part", flags=0)
>     at /usr/src/debug/git/git/object-file.c:1634
> #1  0x000055555579ab75 in index_path (istate=0x5555559ccb40,
> oid=0x5555559d3c80, path=0x5555559d3ce0 "4/root_part",
> st=0x7fffffffc5c0, flags=0) at
> /usr/src/debug/git/git/object-file.c:1658
> #2  0x0000555555720f83 in diff_fill_oid_info (one=0x5555559d3c80,
> istate=0x5555559ccb40) at /usr/src/debug/git/git/diff.c:4690
> #3  diff_fill_oid_info (one=one@entry=0x5555559d3c80,
> istate=0x5555559ccb40) at /usr/src/debug/git/git/diff.c:4679
> #4  0x0000555555724aba in run_diff (p=0x5555559ce900,
> o=0x7fffffffd188) at /usr/src/debug/git/git/diff.c:4738
> #5  diff_flush_patch (p=0x5555559ce900, o=0x7fffffffd188) at
> /usr/src/debug/git/git/diff.c:6247
> #6  0x0000555555729850 in diff_flush_patch_all_file_pairs
> (o=0x7fffffffd188) at /usr/src/debug/git/git/diff.c:6802
> #7  diff_flush (options=<optimized out>) at /usr/src/debug/git/git/diff.c:6942
> #8  0x00005555555b0d34 in diff_no_index (revs=0x7fffffffcbd0,
> algop=0x55555598dbd0 <hash_algos+112>, implicit_no_index=<optimized
> out>, argc=2, argv=0x5555559ce2a0) at
> /usr/src/debug/git/git/diff-no-index.c:427
> #9  cmd_diff (argc=<optimized out>, argv=0x5555559ce2a0,
> prefix=<optimized out>, repo=<optimized out>) at builtin/diff.c:516
> #10 0x000055555555fe05 in run_builtin (p=0x555555994ec8
> <commands.lto_priv+840>, argc=<optimized out>, argv=<optimized out>,
> repo=0x5555559a3c00 <the_repo.lto_priv>) at
> /usr/src/debug/git/git/git.c:506
> #11 handle_builtin (args=args@entry=0x7fffffffd980) at
> /usr/src/debug/git/git/git.c:779
> #12 0x00005555555612cc in run_argv (args=0x7fffffffd980) at
> /usr/src/debug/git/git/git.c:862
> #13 cmd_main (argc=<optimized out>, argv=<optimized out>) at
> /usr/src/debug/git/git/git.c:984
> #14 0x000055555555d794 in main (argc=6, argv=0x7fffffffdc58) at
> /usr/src/debug/git/git/common-main.c:9
> (gdb) p the_repository->objects
> $1 = (struct object_database *) 0x0
> (gdb) p istate->repo->objects
> $2 = (struct object_database *) 0x0
> (gdb) p istate->repo
> $3 = (struct repository *) 0x5555559a3c00 <the_repo.lto_priv>
> (gdb) p the_repository
> $4 = (struct repository *) 0x5555559a3c00 <the_repo.lto_priv>
> 
> The same issue happens in master, the same path is taken and when we
> finally get into
> `odb_transaction_begin` where odb is NULL, and reading ->transaction
> causes the illegal
> segment access once again.
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0x00005555557c6283 in odb_transaction_begin (odb=0x0) at odb.c:1075
> 1075            if (odb->transaction)
> (gdb) bt
> #0  0x00005555557c6283 in odb_transaction_begin (odb=0x0) at odb.c:1075
> #1  0x00005555557b94f9 in index_fd (istate=0x555555a88b60,
> oid=0x555555a8fcb0, fd=4, st=0x7fffffffc730, type=OBJ_BLOB,
> path=0x555555a8fd10 "4/root_part", flags=0) at object-file.c:1665
> #2  0x00005555557b9651 in index_path (istate=0x555555a88b60,
> oid=0x555555a8fcb0, path=0x555555a8fd10 "4/root_part",
> st=0x7fffffffc730, flags=0) at object-file.c:1691
> #3  0x0000555555730937 in diff_fill_oid_info (one=0x555555a8fcb0,
> istate=0x555555a88b60) at diff.c:4699
> #4  0x0000555555730b81 in run_diff (p=0x555555a8a9a0,
> o=0x7fffffffd1a8) at diff.c:4747
> #5  0x00005555557361d5 in diff_flush_patch (p=0x555555a8a9a0,
> o=0x7fffffffd1a8) at diff.c:6258
> #6  0x0000555555737cae in diff_flush_patch_all_file_pairs
> (o=0x7fffffffd1a8) at diff.c:6813
> #7  0x00005555557382b2 in diff_flush (options=0x7fffffffd1a8) at diff.c:6953
> #8  0x00005555557228cc in diff_no_index (revs=0x7fffffffcbf0,
> algop=0x555555a49b50 <hash_algos+112>, implicit_no_index=1, argc=2,
> argv=0x555555a8a2f0) at diff-no-index.c:427
> #9  0x00005555555c04b1 in cmd_diff (argc=5, argv=0x555555a8a2f0,
> prefix=0x0, repo=0x0) at builtin/diff.c:516
> #10 0x0000555555574f47 in run_builtin (p=0x555555a4aaa8
> <commands+840>, argc=5, argv=0x555555a8a2f0, repo=0x555555a7e620
> <the_repo>) at git.c:506
> #11 0x000055555557544e in handle_builtin (args=0x7fffffffdab0) at git.c:780
> #12 0x0000555555575778 in run_argv (args=0x7fffffffdab0) at git.c:863
> #13 0x0000555555575c0f in cmd_main (argc=5, argv=0x7fffffffdc50) at git.c:984
> #14 0x00005555556a7414 in main (argc=6, argv=0x7fffffffdc48) at common-main.c:9

The problem is most likely to occur in object-file.c:

...
int index_fd(struct index_state *istate, struct object_id *oid,
	     int fd, struct stat *st,
	     enum object_type type, const char *path, unsigned flags)
{
	int ret;

	/*
	 * Call xsize_t() only when needed to avoid potentially unnecessary
	 * die() for large files.
	 */
	if (type == OBJ_BLOB && path && would_convert_to_git_filter_fd(istate, 
path)) {
		ret = index_stream_convert_blob(istate, oid, fd, path, flags);
	} else if (!S_ISREG(st->st_mode)) {
		ret = index_pipe(istate, oid, fd, type, path, flags);
	} else if ((st->st_size >= 0 &&
		    (size_t)st->st_size <= 
repo_settings_get_big_file_threshold(istate->repo)) ||
		   type != OBJ_BLOB ||
		   (path && would_convert_to_git(istate, path))) {
		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
				 type, path, flags);
	} else {
		struct object_database *odb = the_repository->objects;
		struct odb_transaction_files *files_transaction;
		struct odb_transaction *transaction;

		transaction = odb_transaction_begin(odb);
		files_transaction = container_of(odb->transaction,
						 struct odb_transaction_files,
						 base);
		ret = index_blob_packfile_transaction(files_transaction, oid, fd,
						      xsize_t(st->st_size),
						      path, flags);
		odb_transaction_commit(transaction);
	}

	close(fd);
	return ret;
}
...

Note that in 'if (type == OBJ_BLOB && st->st_size > big_file_threshold)' 
block, there is no check to see if 'the_repository->objects' is NULL. It 
assumes that an object database is available, which is not true in 
no-repository scenarios.

One possible solution would be as follows: only when 'flags & 
HASH_WRITE_OBJECT' (or something like that) is true does this indicate 
that the file needs to be written in; if it is false only the hash value 
is required and the file should not be written in.

Will send a patch to fix it, soon.

Thanks, Yuchen
