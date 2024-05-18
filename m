Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004C33211
	for <git@vger.kernel.org>; Sat, 18 May 2024 19:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716060159; cv=none; b=lYBglIXWdGKF7xSVZrGsZLx1Sd+Mu2m4v+JpNHX7VvtczfxwPIpd35RoxKKgbRLIhVmQWQASWtZB9mloXxbLCqBYmLXVQLvWwvLbOzYJtcSqQ+qgeZr5SYeWp0hquUel4kMrUEfjsIFpS2bW8TXcXF/sRjk4bJNcHaE/k579tks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716060159; c=relaxed/simple;
	bh=HIa+FawEwtpi6pg9VUUy9JJTvi3+S3jfdIwH/lL3+po=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Hk1HXii2UVCjwiQUXKF6XwhR3thrl1Gsfq524cFdT6xiTaeoIelRBuUv34MK8qqmOavNfHhSZVunbLGziRNhlotW+eQQKWwdLHSTlF1ooZHDinLlR41ysiurZchDd4Xo10FhPR89usKMYouWrQSmWQ37iqvtXshGyvqAR9yONpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=g3pcGdAm; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="g3pcGdAm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716060139; x=1716664939;
	i=johannes.schindelin@gmx.de;
	bh=Dg6ApAKOTty1fPA3xXT1KfP+2iUKMOd1uMS2F2BsJcw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=g3pcGdAmQgo0DLCMk4XvRSrNl6c3+rzN6S4TzNytZ3io/EH8r9oNHUqg3rxl8CrT
	 huT8BTArcD0ISRjPvdLYlWSaL0BjFZBkqm7aPsq9ia4AtDHXe2Bv48HiO3h0lfldy
	 NV0N6pY8zE5xVBefEaBnGrEiDuMPsKLyNnACWNXVV8XQQXIB4jvfBZVKOI/v7hdOL
	 eN/xotEZiFaMrAeAI963CslQcQLM6fVtjyONddosKsyyowJsJDfh8LbHikmPKzXXH
	 S9fomrOM0TZNQr70OEaD+++bZVCejEbLr0nj61lMpjAuwgVnjqH9L7Sb0ubzNmMzn
	 FnjdiGZwKb02gUhRng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.77]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhlV-1sJ5w42FWx-00Bwhx; Sat, 18
 May 2024 21:22:19 +0200
Date: Sat, 18 May 2024 21:22:18 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 0/8] Various fixes for v2.45.1 and friends
In-Reply-To: <xmqqy187nj4u.fsf@gitster.g>
Message-ID: <c67780c5-ab50-37f0-a507-91e8b721b349@gmx.de>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com> <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com> <xmqqy187nj4u.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1UebVQIgmU2MKfr5/zyeTfkx8RnRAAkkDUxC8qlRFb+eatahctG
 0Vp2g75nL3fwVbZdHI4zQbDGqqLvUu6lyn+SOle3/ymZgcvD/FbWlbxDD1MMLvkAAjj9Ih8
 VUWfwcd6vpNhSPvJy6gpKI7hmpHoLT2CmKkb3RjN9F2FjZn8K+rtnKF1jvFXZtVRFs3yUPq
 ecse2MQIVPfr3A7t0RQiA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rVoqjd5gId4=;j8MF0GLgrMrmb7j/lJPwgxf2I/v
 bVBxRh5y3SiiT7valLUji4xY53V8HCatxjFbMjJ2ywR+eOnVs3PNhRhPqEyIHSyzrl6z9JRh2
 kUaskgT/dsLihNC2+uBp94p6saHrvc7PyaYERBsLH73Gzm1QywzniSf1ZrD+tJm0dX50eaTrm
 cc3iePronhONXd3QoMIHGjPH0VAr1x/uX6nHAnnXsBMyrCxJ9K46BWOX+ab0dyoUq3D9HLZDd
 FFLXgPZyppqWga7gC5ppInmN52ihOwSyFtcS4NqjcihE3B8cvJXrVOjXetNkCBDjDwvFd560V
 XVJL7AvcXkM6dI55IkFIAxVsfP7O2ZABsR8u6GsfAZhvrlL5dMe1uqdBy2wWmND/2Uqaz8M5S
 wK8UfM/qF8NKn91A0u3+PZFXyASEE38Au+0IiyObia2+emXldBQMIYAXdBG6O0izZRNVDdc9O
 VQAUEKJeWlSlWVrvL8wxbYmG79+EJNwuELRCZzUNqSrj900Q0MprnuMxbFGy0w6cWpxKP8Bvt
 8DpngUmvVSRTah6eg3tYBEv7B5BfvORhNvahADxnHtIHOecOAo91FiHIU4z0M7N59+Qbs/FK6
 AYQUcaYNt+dT5+Fvdu4t83XDN3tMhR753fgaXCWfNXDVuqKd8C3UJfbHn3wKL/hEjr3dtoij5
 CFh8Gl2qUiWU9hRXrLVjuxGmjNZFZ1kzQPiYRkFBRxQN2pQYiFkYSZWFZYXbXfUgxchBExSPL
 STlcnbwR1a0IjknX8B3hBmRJeV/9U0vr6u9mhk5TJ+8S96j9T+ml0xptGdXkyyXUyMAjv7WFv
 TP1CCS00errbw4nGdM8sgOwefo4JwhbVxNBcNjOM7Njj8=
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Sat, 18 May 2024, Junio C Hamano wrote:

> I have applied this to maint-2.39 and then merged them up to the
> maintenance tracks.  The results will be pushed out to the "split
> out" repository at
>
>     https://github.com/gitster/git/
>
> as these branches:
>
>     js/fix-clone-w-hooks-2.39
>     js/fix-clone-w-hooks-2.40
>     js/fix-clone-w-hooks-2.41
>     js/fix-clone-w-hooks-2.42
>     js/fix-clone-w-hooks-2.43
>     js/fix-clone-w-hooks-2.44
>     js/fix-clone-w-hooks-2.45

Thank you!

As it happens, I had already worked on tentative/maint-* branches (that
you can see here: https://github.com/dscho/git/branches/active), but
had to take a break before finalizing them.

The major difference I see is that js/fix-clone-w-hooks-2.41 still
declares `do_files_match()` in `setup.h` (even if it is no longer defined
or called), and that `hook.c` includes `copy.h` (but that is no longer
needed), and that `setup.h` includes `hook.h` (but that's not needed
either).

While comparing, I noticed that I had missed an extra empty line in my
merge conflict resolutions, a `grep` -> `test_grep` conversation and an
`UNUSED` attribute for the `ctx` parameter of the `safe_hook_cb()`
function. So I am really grateful that you did those integrations
independently.

You will also note that I tentatively added commits to mark v2.39.5, ...,
v2.45.2 ready for tagging, along with release notes, just so we can hit
the ground running as soon as reviews settle down.

Ciao,
Johannes

>
> For those who are merging them up at home yourselves, here are the
> remerge diff that show the conflict resolution I made.
>
> * js/fix-clone-w-hooks-2.40
> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> remerge CONFLICT (content): Merge conflict in t/t1800-hook.sh
> index 2af93d130d..bc0ed30ab9 100755
> --- a/t/t1800-hook.sh
> +++ b/t/t1800-hook.sh
> @@ -177,7 +177,6 @@ test_expect_success 'git hook run a hook with a bad =
shebang' '
>  	test_cmp expect actual
>  '
>
> -<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< b9b439e0e3 (Git 2.40.2)
>  test_expect_success 'stdin to hooks' '
>  	write_script .git/hooks/test-hook <<-\EOF &&
>  	echo BEGIN stdin
> @@ -196,23 +195,10 @@ test_expect_success 'stdin to hooks' '
>  	test_cmp expect actual
>  '
>
> -test_expect_success 'clone protections' '
> -	test_config core.hooksPath "$(pwd)/my-hooks" &&
> -	mkdir -p my-hooks &&
> -	write_script my-hooks/test-hook <<-\EOF &&
> -	echo Hook ran $1
> -|||||||||||||||||||||||||||||||| 47b6d90e91
> -test_expect_success 'clone protections' '
> -	test_config core.hooksPath "$(pwd)/my-hooks" &&
> -	mkdir -p my-hooks &&
> -	write_script my-hooks/test-hook <<-\EOF &&
> -	echo Hook ran $1
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  test_expect_success '`safe.hook.sha256` and clone protections' '
>  	git init safe-hook &&
>  	write_script safe-hook/.git/hooks/pre-push <<-\EOF &&
>  	echo "called hook" >safe-hook.log
> ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 851218a8af (Revert "Add a helper funct=
ion to compare file contents")
>  	EOF
>
>  	test_must_fail env GIT_CLONE_PROTECTION_ACTIVE=3Dtrue \
> * js/fix-clone-w-hooks-2.41
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> remerge CONFLICT (content): Merge conflict in builtin/init-db.c
> index 0f0d2033c5..b351fe6e40 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -17,13 +17,9 @@
>  #include "path.h"
>  #include "setup.h"
>  #include "worktree.h"
> -<<<<<<< 0f15832059 (Git 2.41.1)
>  #include "wrapper.h"
> -||||||| b9b439e0e3
> -=3D=3D=3D=3D=3D=3D=3D
>  #include "run-command.h"
>  #include "hook.h"
> ->>>>>>> 752e921355 (Merge branch 'js/fix-clone-w-hooks-2.39' into HEAD)
>
>  #ifdef NO_TRUSTABLE_FILEMODE
>  #define TEST_FILEMODE 0
> diff --git a/cache.h b/cache.h
> remerge CONFLICT (content): Merge conflict in cache.h
> index d99735c623..bdedb87e83 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -555,1301 +555,7 @@ extern int verify_ce_order;
>  #define DATA_CHANGED    0x0020
>  #define TYPE_CHANGED    0x0040
>
> -<<<<<<< 0f15832059 (Git 2.41.1)
>  int cmp_cache_name_compare(const void *a_, const void *b_);
> -||||||| b9b439e0e3
> -/*
> - * Return an abbreviated sha1 unique within this repository's object da=
tabase.
> - * The result will be at least `len` characters long, and will be NUL
> - * terminated.
> - *
> - * The non-`_r` version returns a static buffer which remains valid unt=
il 4
> - * more calls to find_unique_abbrev are made.
> - *
> - * The `_r` variant writes to a buffer supplied by the caller, which mu=
st be at
> - * least `GIT_MAX_HEXSZ + 1` bytes. The return value is the number of b=
ytes
> - * written (excluding the NUL terminator).
> - *
> - * Note that while this version avoids the static buffer, it is not ful=
ly
> - * reentrant, as it calls into other non-reentrant git code.
> - */
> -const char *repo_find_unique_abbrev(struct repository *r, const struct =
object_id *oid, int len);
> -#define find_unique_abbrev(oid, len) repo_find_unique_abbrev(the_reposi=
tory, oid, len)
> -int repo_find_unique_abbrev_r(struct repository *r, char *hex, const st=
ruct object_id *oid, int len);
> -#define find_unique_abbrev_r(hex, oid, len) repo_find_unique_abbrev_r(t=
he_repository, hex, oid, len)
> -
> -/* set default permissions by passing mode arguments to open(2) */
> -int git_mkstemps_mode(char *pattern, int suffix_len, int mode);
> -int git_mkstemp_mode(char *pattern, int mode);
> -
> -/*
> - * NOTE NOTE NOTE!!
> - *
> - * PERM_UMASK, OLD_PERM_GROUP and OLD_PERM_EVERYBODY enumerations must
> - * not be changed. Old repositories have core.sharedrepository written =
in
> - * numeric format, and therefore these values are preserved for compati=
bility
> - * reasons.
> - */
> -enum sharedrepo {
> -	PERM_UMASK          =3D 0,
> -	OLD_PERM_GROUP      =3D 1,
> -	OLD_PERM_EVERYBODY  =3D 2,
> -	PERM_GROUP          =3D 0660,
> -	PERM_EVERYBODY      =3D 0664
> -};
> -int git_config_perm(const char *var, const char *value);
> -int adjust_shared_perm(const char *path);
> -
> -/*
> - * Create the directory containing the named path, using care to be
> - * somewhat safe against races. Return one of the scld_error values to
> - * indicate success/failure. On error, set errno to describe the
> - * problem.
> - *
> - * SCLD_VANISHED indicates that one of the ancestor directories of the
> - * path existed at one point during the function call and then
> - * suddenly vanished, probably because another process pruned the
> - * directory while we were working.  To be robust against this kind of
> - * race, callers might want to try invoking the function again when it
> - * returns SCLD_VANISHED.
> - *
> - * safe_create_leading_directories() temporarily changes path while it
> - * is working but restores it before returning.
> - * safe_create_leading_directories_const() doesn't modify path, even
> - * temporarily. Both these variants adjust the permissions of the
> - * created directories to honor core.sharedRepository, so they are best
> - * suited for files inside the git dir. For working tree files, use
> - * safe_create_leading_directories_no_share() instead, as it ignores
> - * the core.sharedRepository setting.
> - */
> -enum scld_error {
> -	SCLD_OK =3D 0,
> -	SCLD_FAILED =3D -1,
> -	SCLD_PERMS =3D -2,
> -	SCLD_EXISTS =3D -3,
> -	SCLD_VANISHED =3D -4
> -};
> -enum scld_error safe_create_leading_directories(char *path);
> -enum scld_error safe_create_leading_directories_const(const char *path)=
;
> -enum scld_error safe_create_leading_directories_no_share(char *path);
> -
> -int mkdir_in_gitdir(const char *path);
> -char *interpolate_path(const char *path, int real_home);
> -/* NEEDSWORK: remove this synonym once in-flight topics have migrated *=
/
> -#define expand_user_path interpolate_path
> -const char *enter_repo(const char *path, int strict);
> -static inline int is_absolute_path(const char *path)
> -{
> -	return is_dir_sep(path[0]) || has_dos_drive_prefix(path);
> -}
> -int is_directory(const char *);
> -char *strbuf_realpath(struct strbuf *resolved, const char *path,
> -		      int die_on_error);
> -char *strbuf_realpath_forgiving(struct strbuf *resolved, const char *pa=
th,
> -				int die_on_error);
> -char *real_pathdup(const char *path, int die_on_error);
> -const char *absolute_path(const char *path);
> -char *absolute_pathdup(const char *path);
> -const char *remove_leading_path(const char *in, const char *prefix);
> -const char *relative_path(const char *in, const char *prefix, struct st=
rbuf *sb);
> -int normalize_path_copy_len(char *dst, const char *src, int *prefix_len=
);
> -int normalize_path_copy(char *dst, const char *src);
> -int longest_ancestor_length(const char *path, struct string_list *prefi=
xes);
> -char *strip_path_suffix(const char *path, const char *suffix);
> -int daemon_avoid_alias(const char *path);
> -
> -/*
> - * These functions match their is_hfs_dotgit() counterparts; see utf8.h=
 for
> - * details.
> - */
> -int is_ntfs_dotgit(const char *name);
> -int is_ntfs_dotgitmodules(const char *name);
> -int is_ntfs_dotgitignore(const char *name);
> -int is_ntfs_dotgitattributes(const char *name);
> -int is_ntfs_dotmailmap(const char *name);
> -
> -/*
> - * Returns true iff "str" could be confused as a command-line option wh=
en
> - * passed to a sub-program like "ssh". Note that this has nothing to do=
 with
> - * shell-quoting, which should be handled separately; we're assuming he=
re that
> - * the string makes it verbatim to the sub-program.
> - */
> -int looks_like_command_line_option(const char *str);
> -
> -/**
> - * Return a newly allocated string with the evaluation of
> - * "$XDG_CONFIG_HOME/$subdir/$filename" if $XDG_CONFIG_HOME is non-empt=
y, otherwise
> - * "$HOME/.config/$subdir/$filename". Return NULL upon error.
> - */
> -char *xdg_config_home_for(const char *subdir, const char *filename);
> -
> -/**
> - * Return a newly allocated string with the evaluation of
> - * "$XDG_CONFIG_HOME/git/$filename" if $XDG_CONFIG_HOME is non-empty, o=
therwise
> - * "$HOME/.config/git/$filename". Return NULL upon error.
> - */
> -char *xdg_config_home(const char *filename);
> -
> -/**
> - * Return a newly allocated string with the evaluation of
> - * "$XDG_CACHE_HOME/git/$filename" if $XDG_CACHE_HOME is non-empty, oth=
erwise
> - * "$HOME/.cache/git/$filename". Return NULL upon error.
> - */
> -char *xdg_cache_home(const char *filename);
> -
> -int git_open_cloexec(const char *name, int flags);
> -#define git_open(name) git_open_cloexec(name, O_RDONLY)
> -
> -/**
> - * unpack_loose_header() initializes the data stream needed to unpack
> - * a loose object header.
> - *
> - * Returns:
> - *
> - * - ULHR_OK on success
> - * - ULHR_BAD on error
> - * - ULHR_TOO_LONG if the header was too long
> - *
> - * It will only parse up to MAX_HEADER_LEN bytes unless an optional
> - * "hdrbuf" argument is non-NULL. This is intended for use with
> - * OBJECT_INFO_ALLOW_UNKNOWN_TYPE to extract the bad type for (error)
> - * reporting. The full header will be extracted to "hdrbuf" for use
> - * with parse_loose_header(), ULHR_TOO_LONG will still be returned
> - * from this function to indicate that the header was too long.
> - */
> -enum unpack_loose_header_result {
> -	ULHR_OK,
> -	ULHR_BAD,
> -	ULHR_TOO_LONG,
> -};
> -enum unpack_loose_header_result unpack_loose_header(git_zstream *stream=
,
> -						    unsigned char *map,
> -						    unsigned long mapsize,
> -						    void *buffer,
> -						    unsigned long bufsiz,
> -						    struct strbuf *hdrbuf);
> -
> -/**
> - * parse_loose_header() parses the starting "<type> <len>\0" of an
> - * object. If it doesn't follow that format -1 is returned. To check
> - * the validity of the <type> populate the "typep" in the "struct
> - * object_info". It will be OBJ_BAD if the object type is unknown. The
> - * parsed <len> can be retrieved via "oi->sizep", and from there
> - * passed to unpack_loose_rest().
> - */
> -struct object_info;
> -int parse_loose_header(const char *hdr, struct object_info *oi);
> -
> -/**
> - * With in-core object data in "buf", rehash it to make sure the
> - * object name actually matches "oid" to detect object corruption.
> - *
> - * A negative value indicates an error, usually that the OID is not
> - * what we expected, but it might also indicate another error.
> - */
> -int check_object_signature(struct repository *r, const struct object_id=
 *oid,
> -			   void *map, unsigned long size,
> -			   enum object_type type);
> -
> -/**
> - * A streaming version of check_object_signature().
> - * Try reading the object named with "oid" using
> - * the streaming interface and rehash it to do the same.
> - */
> -int stream_object_signature(struct repository *r, const struct object_i=
d *oid);
> -
> -int finalize_object_file(const char *tmpfile, const char *filename);
> -
> -/* Helper to check and "touch" a file */
> -int check_and_freshen_file(const char *fn, int freshen);
> -
> -extern const signed char hexval_table[256];
> -static inline unsigned int hexval(unsigned char c)
> -{
> -	return hexval_table[c];
> -}
> -
> -/*
> - * Convert two consecutive hexadecimal digits into a char.  Return a
> - * negative value on error.  Don't run over the end of short strings.
> - */
> -static inline int hex2chr(const char *s)
> -{
> -	unsigned int val =3D hexval(s[0]);
> -	return (val & ~0xf) ? val : (val << 4) | hexval(s[1]);
> -}
> -
> -/* Convert to/from hex/sha1 representation */
> -#define MINIMUM_ABBREV minimum_abbrev
> -#define DEFAULT_ABBREV default_abbrev
> -
> -/* used when the code does not know or care what the default abbrev is =
*/
> -#define FALLBACK_DEFAULT_ABBREV 7
> -
> -struct object_context {
> -	unsigned short mode;
> -	/*
> -	 * symlink_path is only used by get_tree_entry_follow_symlinks,
> -	 * and only for symlinks that point outside the repository.
> -	 */
> -	struct strbuf symlink_path;
> -	/*
> -	 * If GET_OID_RECORD_PATH is set, this will record path (if any)
> -	 * found when resolving the name. The caller is responsible for
> -	 * releasing the memory.
> -	 */
> -	char *path;
> -};
> -
> -#define GET_OID_QUIETLY           01
> -#define GET_OID_COMMIT            02
> -#define GET_OID_COMMITTISH        04
> -#define GET_OID_TREE             010
> -#define GET_OID_TREEISH          020
> -#define GET_OID_BLOB             040
> -#define GET_OID_FOLLOW_SYMLINKS 0100
> -#define GET_OID_RECORD_PATH     0200
> -#define GET_OID_ONLY_TO_DIE    04000
> -#define GET_OID_REQUIRE_PATH  010000
> -
> -#define GET_OID_DISAMBIGUATORS \
> -	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
> -	GET_OID_TREE | GET_OID_TREEISH | \
> -	GET_OID_BLOB)
> -
> -enum get_oid_result {
> -	FOUND =3D 0,
> -	MISSING_OBJECT =3D -1, /* The requested object is missing */
> -	SHORT_NAME_AMBIGUOUS =3D -2,
> -	/* The following only apply when symlinks are followed */
> -	DANGLING_SYMLINK =3D -4, /*
> -				* The initial symlink is there, but
> -				* (transitively) points to a missing
> -				* in-tree file
> -				*/
> -	SYMLINK_LOOP =3D -5,
> -	NOT_DIR =3D -6, /*
> -		       * Somewhere along the symlink chain, a path is
> -		       * requested which contains a file as a
> -		       * non-final element.
> -		       */
> -};
> -
> -int repo_get_oid(struct repository *r, const char *str, struct object_i=
d *oid);
> -__attribute__((format (printf, 2, 3)))
> -int get_oidf(struct object_id *oid, const char *fmt, ...);
> -int repo_get_oid_commit(struct repository *r, const char *str, struct o=
bject_id *oid);
> -int repo_get_oid_committish(struct repository *r, const char *str, stru=
ct object_id *oid);
> -int repo_get_oid_tree(struct repository *r, const char *str, struct obj=
ect_id *oid);
> -int repo_get_oid_treeish(struct repository *r, const char *str, struct =
object_id *oid);
> -int repo_get_oid_blob(struct repository *r, const char *str, struct obj=
ect_id *oid);
> -int repo_get_oid_mb(struct repository *r, const char *str, struct objec=
t_id *oid);
> -void maybe_die_on_misspelt_object_name(struct repository *repo,
> -				       const char *name,
> -				       const char *prefix);
> -enum get_oid_result get_oid_with_context(struct repository *repo, const=
 char *str,
> -					 unsigned flags, struct object_id *oid,
> -					 struct object_context *oc);
> -
> -#define get_oid(str, oid)		repo_get_oid(the_repository, str, oid)
> -#define get_oid_commit(str, oid)	repo_get_oid_commit(the_repository, st=
r, oid)
> -#define get_oid_committish(str, oid)	repo_get_oid_committish(the_reposi=
tory, str, oid)
> -#define get_oid_tree(str, oid)		repo_get_oid_tree(the_repository, str, =
oid)
> -#define get_oid_treeish(str, oid)	repo_get_oid_treeish(the_repository, =
str, oid)
> -#define get_oid_blob(str, oid)		repo_get_oid_blob(the_repository, str, =
oid)
> -#define get_oid_mb(str, oid) 		repo_get_oid_mb(the_repository, str, oid=
)
> -
> -typedef int each_abbrev_fn(const struct object_id *oid, void *);
> -int repo_for_each_abbrev(struct repository *r, const char *prefix, each=
_abbrev_fn, void *);
> -#define for_each_abbrev(prefix, fn, data) repo_for_each_abbrev(the_repo=
sitory, prefix, fn, data)
> -
> -int set_disambiguate_hint_config(const char *var, const char *value);
> -
> -/*
> - * Try to read a SHA1 in hexadecimal format from the 40 characters
> - * starting at hex.  Write the 20-byte result to sha1 in binary form.
> - * Return 0 on success.  Reading stops if a NUL is encountered in the
> - * input, so it is safe to pass this function an arbitrary
> - * null-terminated string.
> - */
> -int get_sha1_hex(const char *hex, unsigned char *sha1);
> -int get_oid_hex(const char *hex, struct object_id *sha1);
> -
> -/* Like get_oid_hex, but for an arbitrary hash algorithm. */
> -int get_oid_hex_algop(const char *hex, struct object_id *oid, const str=
uct git_hash_algo *algop);
> -
> -/*
> - * Read `len` pairs of hexadecimal digits from `hex` and write the
> - * values to `binary` as `len` bytes. Return 0 on success, or -1 if
> - * the input does not consist of hex digits).
> - */
> -int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
> -
> -/*
> - * Convert a binary hash in "unsigned char []" or an object name in
> - * "struct object_id *" to its hex equivalent. The `_r` variant is reen=
trant,
> - * and writes the NUL-terminated output to the buffer `out`, which must=
 be at
> - * least `GIT_MAX_HEXSZ + 1` bytes, and returns a pointer to out for
> - * convenience.
> - *
> - * The non-`_r` variant returns a static buffer, but uses a ring of 4
> - * buffers, making it safe to make multiple calls for a single statemen=
t, like:
> - *
> - *   printf("%s -> %s", hash_to_hex(one), hash_to_hex(two));
> - *   printf("%s -> %s", oid_to_hex(one), oid_to_hex(two));
> - */
> -char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash, cons=
t struct git_hash_algo *);
> -char *oid_to_hex_r(char *out, const struct object_id *oid);
> -char *hash_to_hex_algop(const unsigned char *hash, const struct git_has=
h_algo *);	/* static buffer result! */
> -char *hash_to_hex(const unsigned char *hash);						/* same static buffe=
r */
> -char *oid_to_hex(const struct object_id *oid);						/* same static buff=
er */
> -
> -/*
> - * Parse a 40-character hexadecimal object ID starting from hex, updati=
ng the
> - * pointer specified by end when parsing stops.  The resulting object I=
D is
> - * stored in oid.  Returns 0 on success.  Parsing will stop on the firs=
t NUL or
> - * other invalid character.  end is only updated on success; otherwise,=
 it is
> - * unmodified.
> - */
> -int parse_oid_hex(const char *hex, struct object_id *oid, const char **=
end);
> -
> -/* Like parse_oid_hex, but for an arbitrary hash algorithm. */
> -int parse_oid_hex_algop(const char *hex, struct object_id *oid, const c=
har **end,
> -			const struct git_hash_algo *algo);
> -
> -
> -/*
> - * These functions work like get_oid_hex and parse_oid_hex, but they wi=
ll parse
> - * a hex value for any algorithm. The algorithm is detected based on th=
e length
> - * and the algorithm in use is returned. If this is not a hex object ID=
 in any
> - * algorithm, returns GIT_HASH_UNKNOWN.
> - */
> -int get_oid_hex_any(const char *hex, struct object_id *oid);
> -int parse_oid_hex_any(const char *hex, struct object_id *oid, const cha=
r **end);
> -
> -/*
> - * This reads short-hand syntax that not only evaluates to a commit
> - * object name, but also can act as if the end user spelled the name
> - * of the branch from the command line.
> - *
> - * - "@{-N}" finds the name of the Nth previous branch we were on, and
> - *   places the name of the branch in the given buf and returns the
> - *   number of characters parsed if successful.
> - *
> - * - "<branch>@{upstream}" finds the name of the other ref that
> - *   <branch> is configured to merge with (missing <branch> defaults
> - *   to the current branch), and places the name of the branch in the
> - *   given buf and returns the number of characters parsed if
> - *   successful.
> - *
> - * If the input is not of the accepted format, it returns a negative
> - * number to signal an error.
> - *
> - * If the input was ok but there are not N branch switches in the
> - * reflog, it returns 0.
> - */
> -#define INTERPRET_BRANCH_LOCAL (1<<0)
> -#define INTERPRET_BRANCH_REMOTE (1<<1)
> -#define INTERPRET_BRANCH_HEAD (1<<2)
> -struct interpret_branch_name_options {
> -	/*
> -	 * If "allowed" is non-zero, it is a treated as a bitfield of allowabl=
e
> -	 * expansions: local branches ("refs/heads/"), remote branches
> -	 * ("refs/remotes/"), or "HEAD". If no "allowed" bits are set, any exp=
ansion is
> -	 * allowed, even ones to refs outside of those namespaces.
> -	 */
> -	unsigned allowed;
> -
> -	/*
> -	 * If ^{upstream} or ^{push} (or equivalent) is requested, and the
> -	 * branch in question does not have such a reference, return -1 instea=
d
> -	 * of die()-ing.
> -	 */
> -	unsigned nonfatal_dangling_mark : 1;
> -};
> -int repo_interpret_branch_name(struct repository *r,
> -			       const char *str, int len,
> -			       struct strbuf *buf,
> -			       const struct interpret_branch_name_options *options);
> -#define interpret_branch_name(str, len, buf, options) \
> -	repo_interpret_branch_name(the_repository, str, len, buf, options)
> -
> -int validate_headref(const char *ref);
> -
> -int base_name_compare(const char *name1, size_t len1, int mode1,
> -		      const char *name2, size_t len2, int mode2);
> -int df_name_compare(const char *name1, size_t len1, int mode1,
> -		    const char *name2, size_t len2, int mode2);
> -int name_compare(const char *name1, size_t len1, const char *name2, siz=
e_t len2);
> -int cache_name_stage_compare(const char *name1, int len1, int stage1, c=
onst char *name2, int len2, int stage2);
> -
> -void *read_object_with_reference(struct repository *r,
> -				 const struct object_id *oid,
> -				 enum object_type required_type,
> -				 unsigned long *size,
> -				 struct object_id *oid_ret);
> -
> -struct object *repo_peel_to_type(struct repository *r,
> -				 const char *name, int namelen,
> -				 struct object *o, enum object_type);
> -#define peel_to_type(name, namelen, obj, type) \
> -	repo_peel_to_type(the_repository, name, namelen, obj, type)
> -
> -#define IDENT_STRICT	       1
> -#define IDENT_NO_DATE	       2
> -#define IDENT_NO_NAME	       4
> -
> -enum want_ident {
> -	WANT_BLANK_IDENT,
> -	WANT_AUTHOR_IDENT,
> -	WANT_COMMITTER_IDENT
> -};
> -
> -const char *git_author_info(int);
> -const char *git_committer_info(int);
> -const char *fmt_ident(const char *name, const char *email,
> -		      enum want_ident whose_ident,
> -		      const char *date_str, int);
> -const char *fmt_name(enum want_ident);
> -const char *ident_default_name(void);
> -const char *ident_default_email(void);
> -const char *git_editor(void);
> -const char *git_sequence_editor(void);
> -const char *git_pager(int stdout_is_tty);
> -int is_terminal_dumb(void);
> -int git_ident_config(const char *, const char *, void *);
> -/*
> - * Prepare an ident to fall back on if the user didn't configure it.
> - */
> -void prepare_fallback_ident(const char *name, const char *email);
> -void reset_ident_date(void);
> -
> -struct ident_split {
> -	const char *name_begin;
> -	const char *name_end;
> -	const char *mail_begin;
> -	const char *mail_end;
> -	const char *date_begin;
> -	const char *date_end;
> -	const char *tz_begin;
> -	const char *tz_end;
> -};
> -/*
> - * Signals an success with 0, but time part of the result may be NULL
> - * if the input lacks timestamp and zone
> - */
> -int split_ident_line(struct ident_split *, const char *, int);
> -
> -/*
> - * Given a commit or tag object buffer and the commit or tag headers, r=
eplaces
> - * the idents in the headers with their canonical versions using the ma=
ilmap mechanism.
> - */
> -void apply_mailmap_to_header(struct strbuf *, const char **, struct str=
ing_list *);
> -
> -/*
> - * Compare split idents for equality or strict ordering. Note that we
> - * compare only the ident part of the line, ignoring any timestamp.
> - *
> - * Because there are two fields, we must choose one as the primary key;=
 we
> - * currently arbitrarily pick the email.
> - */
> -int ident_cmp(const struct ident_split *, const struct ident_split *);
> -
> -struct cache_def {
> -	struct strbuf path;
> -	int flags;
> -	int track_flags;
> -	int prefix_len_stat_func;
> -};
> -#define CACHE_DEF_INIT { \
> -	.path =3D STRBUF_INIT, \
> -}
> -static inline void cache_def_clear(struct cache_def *cache)
> -{
> -	strbuf_release(&cache->path);
> -}
> -
> -int has_symlink_leading_path(const char *name, int len);
> -int threaded_has_symlink_leading_path(struct cache_def *, const char *,=
 int);
> -int check_leading_path(const char *name, int len, int warn_on_lstat_err=
);
> -int has_dirs_only_path(const char *name, int len, int prefix_len);
> -void invalidate_lstat_cache(void);
> -void schedule_dir_for_removal(const char *name, int len);
> -void remove_scheduled_dirs(void);
> -
> -struct pack_window {
> -	struct pack_window *next;
> -	unsigned char *base;
> -	off_t offset;
> -	size_t len;
> -	unsigned int last_used;
> -	unsigned int inuse_cnt;
> -};
> -
> -struct pack_entry {
> -	off_t offset;
> -	struct packed_git *p;
> -};
> -
> -/*
> - * Create a temporary file rooted in the object database directory, or
> - * die on failure. The filename is taken from "pattern", which should h=
ave the
> - * usual "XXXXXX" trailer, and the resulting filename is written into t=
he
> - * "template" buffer. Returns the open descriptor.
> - */
> -int odb_mkstemp(struct strbuf *temp_filename, const char *pattern);
> -
> -/*
> - * Create a pack .keep file named "name" (which should generally be the=
 output
> - * of odb_pack_name). Returns a file descriptor opened for writing, or =
-1 on
> - * error.
> - */
> -int odb_pack_keep(const char *name);
> -
> -/*
> - * Set this to 0 to prevent oid_object_info_extended() from fetching mi=
ssing
> - * blobs. This has a difference only if extensions.partialClone is set.
> - *
> - * Its default value is 1.
> - */
> -extern int fetch_if_missing;
> -
> -/* Dumb servers support */
> -int update_server_info(int);
> -
> -const char *get_log_output_encoding(void);
> -const char *get_commit_output_encoding(void);
> -
> -int committer_ident_sufficiently_given(void);
> -int author_ident_sufficiently_given(void);
> -
> -extern const char *git_commit_encoding;
> -extern const char *git_log_output_encoding;
> -extern const char *git_mailmap_file;
> -extern const char *git_mailmap_blob;
> -
> -/* IO helper functions */
> -void maybe_flush_or_die(FILE *, const char *);
> -__attribute__((format (printf, 2, 3)))
> -void fprintf_or_die(FILE *, const char *fmt, ...);
> -void fwrite_or_die(FILE *f, const void *buf, size_t count);
> -void fflush_or_die(FILE *f);
> -
> -#define COPY_READ_ERROR (-2)
> -#define COPY_WRITE_ERROR (-3)
> -int copy_fd(int ifd, int ofd);
> -int copy_file(const char *dst, const char *src, int mode);
> -int copy_file_with_time(const char *dst, const char *src, int mode);
> -
> -/*
> - * Compare the file mode and contents of two given files.
> - *
> - * If both files are actually symbolic links, the function returns 1 if=
 the link
> - * targets are identical or 0 if they are not.
> - *
> - * If any of the two files cannot be accessed or in case of read failur=
es, this
> - * function returns 0.
> - *
> - * If the file modes and contents are identical, the function returns 1=
,
> - * otherwise it returns 0.
> - */
> -int do_files_match(const char *path1, const char *path2);
> -
> -void write_or_die(int fd, const void *buf, size_t count);
> -void fsync_or_die(int fd, const char *);
> -int fsync_component(enum fsync_component component, int fd);
> -void fsync_component_or_die(enum fsync_component component, int fd, con=
st char *msg);
> -
> -static inline int batch_fsync_enabled(enum fsync_component component)
> -{
> -	return (fsync_components & component) && (fsync_method =3D=3D FSYNC_ME=
THOD_BATCH);
> -}
> -
> -ssize_t read_in_full(int fd, void *buf, size_t count);
> -ssize_t write_in_full(int fd, const void *buf, size_t count);
> -ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset);
> -
> -static inline ssize_t write_str_in_full(int fd, const char *str)
> -{
> -	return write_in_full(fd, str, strlen(str));
> -}
> -
> -/**
> - * Open (and truncate) the file at path, write the contents of buf to i=
t,
> - * and close it. Dies if any errors are encountered.
> - */
> -void write_file_buf(const char *path, const char *buf, size_t len);
> -
> -/**
> - * Like write_file_buf(), but format the contents into a buffer first.
> - * Additionally, write_file() will append a newline if one is not alrea=
dy
> - * present, making it convenient to write text files:
> - *
> - *   write_file(path, "counter: %d", ctr);
> - */
> -__attribute__((format (printf, 2, 3)))
> -void write_file(const char *path, const char *fmt, ...);
> -
> -/* pager.c */
> -void setup_pager(void);
> -int pager_in_use(void);
> -extern int pager_use_color;
> -int term_columns(void);
> -void term_clear_line(void);
> -int decimal_width(uintmax_t);
> -int check_pager_config(const char *cmd);
> -void prepare_pager_args(struct child_process *, const char *pager);
> -
> -extern const char *editor_program;
> -extern const char *askpass_program;
> -extern const char *excludes_file;
> -
> -/* base85 */
> -int decode_85(char *dst, const char *line, int linelen);
> -void encode_85(char *buf, const unsigned char *data, int bytes);
> -
> -/* pkt-line.c */
> -void packet_trace_identity(const char *prog);
> -=3D=3D=3D=3D=3D=3D=3D
> -/*
> - * Return an abbreviated sha1 unique within this repository's object da=
tabase.
> - * The result will be at least `len` characters long, and will be NUL
> - * terminated.
> - *
> - * The non-`_r` version returns a static buffer which remains valid unt=
il 4
> - * more calls to find_unique_abbrev are made.
> - *
> - * The `_r` variant writes to a buffer supplied by the caller, which mu=
st be at
> - * least `GIT_MAX_HEXSZ + 1` bytes. The return value is the number of b=
ytes
> - * written (excluding the NUL terminator).
> - *
> - * Note that while this version avoids the static buffer, it is not ful=
ly
> - * reentrant, as it calls into other non-reentrant git code.
> - */
> -const char *repo_find_unique_abbrev(struct repository *r, const struct =
object_id *oid, int len);
> -#define find_unique_abbrev(oid, len) repo_find_unique_abbrev(the_reposi=
tory, oid, len)
> -int repo_find_unique_abbrev_r(struct repository *r, char *hex, const st=
ruct object_id *oid, int len);
> -#define find_unique_abbrev_r(hex, oid, len) repo_find_unique_abbrev_r(t=
he_repository, hex, oid, len)
> -
> -/* set default permissions by passing mode arguments to open(2) */
> -int git_mkstemps_mode(char *pattern, int suffix_len, int mode);
> -int git_mkstemp_mode(char *pattern, int mode);
> -
> -/*
> - * NOTE NOTE NOTE!!
> - *
> - * PERM_UMASK, OLD_PERM_GROUP and OLD_PERM_EVERYBODY enumerations must
> - * not be changed. Old repositories have core.sharedrepository written =
in
> - * numeric format, and therefore these values are preserved for compati=
bility
> - * reasons.
> - */
> -enum sharedrepo {
> -	PERM_UMASK          =3D 0,
> -	OLD_PERM_GROUP      =3D 1,
> -	OLD_PERM_EVERYBODY  =3D 2,
> -	PERM_GROUP          =3D 0660,
> -	PERM_EVERYBODY      =3D 0664
> -};
> -int git_config_perm(const char *var, const char *value);
> -int adjust_shared_perm(const char *path);
> -
> -/*
> - * Create the directory containing the named path, using care to be
> - * somewhat safe against races. Return one of the scld_error values to
> - * indicate success/failure. On error, set errno to describe the
> - * problem.
> - *
> - * SCLD_VANISHED indicates that one of the ancestor directories of the
> - * path existed at one point during the function call and then
> - * suddenly vanished, probably because another process pruned the
> - * directory while we were working.  To be robust against this kind of
> - * race, callers might want to try invoking the function again when it
> - * returns SCLD_VANISHED.
> - *
> - * safe_create_leading_directories() temporarily changes path while it
> - * is working but restores it before returning.
> - * safe_create_leading_directories_const() doesn't modify path, even
> - * temporarily. Both these variants adjust the permissions of the
> - * created directories to honor core.sharedRepository, so they are best
> - * suited for files inside the git dir. For working tree files, use
> - * safe_create_leading_directories_no_share() instead, as it ignores
> - * the core.sharedRepository setting.
> - */
> -enum scld_error {
> -	SCLD_OK =3D 0,
> -	SCLD_FAILED =3D -1,
> -	SCLD_PERMS =3D -2,
> -	SCLD_EXISTS =3D -3,
> -	SCLD_VANISHED =3D -4
> -};
> -enum scld_error safe_create_leading_directories(char *path);
> -enum scld_error safe_create_leading_directories_const(const char *path)=
;
> -enum scld_error safe_create_leading_directories_no_share(char *path);
> -
> -int mkdir_in_gitdir(const char *path);
> -char *interpolate_path(const char *path, int real_home);
> -/* NEEDSWORK: remove this synonym once in-flight topics have migrated *=
/
> -#define expand_user_path interpolate_path
> -const char *enter_repo(const char *path, int strict);
> -static inline int is_absolute_path(const char *path)
> -{
> -	return is_dir_sep(path[0]) || has_dos_drive_prefix(path);
> -}
> -int is_directory(const char *);
> -char *strbuf_realpath(struct strbuf *resolved, const char *path,
> -		      int die_on_error);
> -char *strbuf_realpath_forgiving(struct strbuf *resolved, const char *pa=
th,
> -				int die_on_error);
> -char *real_pathdup(const char *path, int die_on_error);
> -const char *absolute_path(const char *path);
> -char *absolute_pathdup(const char *path);
> -const char *remove_leading_path(const char *in, const char *prefix);
> -const char *relative_path(const char *in, const char *prefix, struct st=
rbuf *sb);
> -int normalize_path_copy_len(char *dst, const char *src, int *prefix_len=
);
> -int normalize_path_copy(char *dst, const char *src);
> -int longest_ancestor_length(const char *path, struct string_list *prefi=
xes);
> -char *strip_path_suffix(const char *path, const char *suffix);
> -int daemon_avoid_alias(const char *path);
> -
> -/*
> - * These functions match their is_hfs_dotgit() counterparts; see utf8.h=
 for
> - * details.
> - */
> -int is_ntfs_dotgit(const char *name);
> -int is_ntfs_dotgitmodules(const char *name);
> -int is_ntfs_dotgitignore(const char *name);
> -int is_ntfs_dotgitattributes(const char *name);
> -int is_ntfs_dotmailmap(const char *name);
> -
> -/*
> - * Returns true iff "str" could be confused as a command-line option wh=
en
> - * passed to a sub-program like "ssh". Note that this has nothing to do=
 with
> - * shell-quoting, which should be handled separately; we're assuming he=
re that
> - * the string makes it verbatim to the sub-program.
> - */
> -int looks_like_command_line_option(const char *str);
> -
> -/**
> - * Return a newly allocated string with the evaluation of
> - * "$XDG_CONFIG_HOME/$subdir/$filename" if $XDG_CONFIG_HOME is non-empt=
y, otherwise
> - * "$HOME/.config/$subdir/$filename". Return NULL upon error.
> - */
> -char *xdg_config_home_for(const char *subdir, const char *filename);
> -
> -/**
> - * Return a newly allocated string with the evaluation of
> - * "$XDG_CONFIG_HOME/git/$filename" if $XDG_CONFIG_HOME is non-empty, o=
therwise
> - * "$HOME/.config/git/$filename". Return NULL upon error.
> - */
> -char *xdg_config_home(const char *filename);
> -
> -/**
> - * Return a newly allocated string with the evaluation of
> - * "$XDG_CACHE_HOME/git/$filename" if $XDG_CACHE_HOME is non-empty, oth=
erwise
> - * "$HOME/.cache/git/$filename". Return NULL upon error.
> - */
> -char *xdg_cache_home(const char *filename);
> -
> -int git_open_cloexec(const char *name, int flags);
> -#define git_open(name) git_open_cloexec(name, O_RDONLY)
> -
> -/**
> - * unpack_loose_header() initializes the data stream needed to unpack
> - * a loose object header.
> - *
> - * Returns:
> - *
> - * - ULHR_OK on success
> - * - ULHR_BAD on error
> - * - ULHR_TOO_LONG if the header was too long
> - *
> - * It will only parse up to MAX_HEADER_LEN bytes unless an optional
> - * "hdrbuf" argument is non-NULL. This is intended for use with
> - * OBJECT_INFO_ALLOW_UNKNOWN_TYPE to extract the bad type for (error)
> - * reporting. The full header will be extracted to "hdrbuf" for use
> - * with parse_loose_header(), ULHR_TOO_LONG will still be returned
> - * from this function to indicate that the header was too long.
> - */
> -enum unpack_loose_header_result {
> -	ULHR_OK,
> -	ULHR_BAD,
> -	ULHR_TOO_LONG,
> -};
> -enum unpack_loose_header_result unpack_loose_header(git_zstream *stream=
,
> -						    unsigned char *map,
> -						    unsigned long mapsize,
> -						    void *buffer,
> -						    unsigned long bufsiz,
> -						    struct strbuf *hdrbuf);
> -
> -/**
> - * parse_loose_header() parses the starting "<type> <len>\0" of an
> - * object. If it doesn't follow that format -1 is returned. To check
> - * the validity of the <type> populate the "typep" in the "struct
> - * object_info". It will be OBJ_BAD if the object type is unknown. The
> - * parsed <len> can be retrieved via "oi->sizep", and from there
> - * passed to unpack_loose_rest().
> - */
> -struct object_info;
> -int parse_loose_header(const char *hdr, struct object_info *oi);
> -
> -/**
> - * With in-core object data in "buf", rehash it to make sure the
> - * object name actually matches "oid" to detect object corruption.
> - *
> - * A negative value indicates an error, usually that the OID is not
> - * what we expected, but it might also indicate another error.
> - */
> -int check_object_signature(struct repository *r, const struct object_id=
 *oid,
> -			   void *map, unsigned long size,
> -			   enum object_type type);
> -
> -/**
> - * A streaming version of check_object_signature().
> - * Try reading the object named with "oid" using
> - * the streaming interface and rehash it to do the same.
> - */
> -int stream_object_signature(struct repository *r, const struct object_i=
d *oid);
> -
> -int finalize_object_file(const char *tmpfile, const char *filename);
> -
> -/* Helper to check and "touch" a file */
> -int check_and_freshen_file(const char *fn, int freshen);
> -
> -extern const signed char hexval_table[256];
> -static inline unsigned int hexval(unsigned char c)
> -{
> -	return hexval_table[c];
> -}
> -
> -/*
> - * Convert two consecutive hexadecimal digits into a char.  Return a
> - * negative value on error.  Don't run over the end of short strings.
> - */
> -static inline int hex2chr(const char *s)
> -{
> -	unsigned int val =3D hexval(s[0]);
> -	return (val & ~0xf) ? val : (val << 4) | hexval(s[1]);
> -}
> -
> -/* Convert to/from hex/sha1 representation */
> -#define MINIMUM_ABBREV minimum_abbrev
> -#define DEFAULT_ABBREV default_abbrev
> -
> -/* used when the code does not know or care what the default abbrev is =
*/
> -#define FALLBACK_DEFAULT_ABBREV 7
> -
> -struct object_context {
> -	unsigned short mode;
> -	/*
> -	 * symlink_path is only used by get_tree_entry_follow_symlinks,
> -	 * and only for symlinks that point outside the repository.
> -	 */
> -	struct strbuf symlink_path;
> -	/*
> -	 * If GET_OID_RECORD_PATH is set, this will record path (if any)
> -	 * found when resolving the name. The caller is responsible for
> -	 * releasing the memory.
> -	 */
> -	char *path;
> -};
> -
> -#define GET_OID_QUIETLY           01
> -#define GET_OID_COMMIT            02
> -#define GET_OID_COMMITTISH        04
> -#define GET_OID_TREE             010
> -#define GET_OID_TREEISH          020
> -#define GET_OID_BLOB             040
> -#define GET_OID_FOLLOW_SYMLINKS 0100
> -#define GET_OID_RECORD_PATH     0200
> -#define GET_OID_ONLY_TO_DIE    04000
> -#define GET_OID_REQUIRE_PATH  010000
> -
> -#define GET_OID_DISAMBIGUATORS \
> -	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
> -	GET_OID_TREE | GET_OID_TREEISH | \
> -	GET_OID_BLOB)
> -
> -enum get_oid_result {
> -	FOUND =3D 0,
> -	MISSING_OBJECT =3D -1, /* The requested object is missing */
> -	SHORT_NAME_AMBIGUOUS =3D -2,
> -	/* The following only apply when symlinks are followed */
> -	DANGLING_SYMLINK =3D -4, /*
> -				* The initial symlink is there, but
> -				* (transitively) points to a missing
> -				* in-tree file
> -				*/
> -	SYMLINK_LOOP =3D -5,
> -	NOT_DIR =3D -6, /*
> -		       * Somewhere along the symlink chain, a path is
> -		       * requested which contains a file as a
> -		       * non-final element.
> -		       */
> -};
> -
> -int repo_get_oid(struct repository *r, const char *str, struct object_i=
d *oid);
> -__attribute__((format (printf, 2, 3)))
> -int get_oidf(struct object_id *oid, const char *fmt, ...);
> -int repo_get_oid_commit(struct repository *r, const char *str, struct o=
bject_id *oid);
> -int repo_get_oid_committish(struct repository *r, const char *str, stru=
ct object_id *oid);
> -int repo_get_oid_tree(struct repository *r, const char *str, struct obj=
ect_id *oid);
> -int repo_get_oid_treeish(struct repository *r, const char *str, struct =
object_id *oid);
> -int repo_get_oid_blob(struct repository *r, const char *str, struct obj=
ect_id *oid);
> -int repo_get_oid_mb(struct repository *r, const char *str, struct objec=
t_id *oid);
> -void maybe_die_on_misspelt_object_name(struct repository *repo,
> -				       const char *name,
> -				       const char *prefix);
> -enum get_oid_result get_oid_with_context(struct repository *repo, const=
 char *str,
> -					 unsigned flags, struct object_id *oid,
> -					 struct object_context *oc);
> -
> -#define get_oid(str, oid)		repo_get_oid(the_repository, str, oid)
> -#define get_oid_commit(str, oid)	repo_get_oid_commit(the_repository, st=
r, oid)
> -#define get_oid_committish(str, oid)	repo_get_oid_committish(the_reposi=
tory, str, oid)
> -#define get_oid_tree(str, oid)		repo_get_oid_tree(the_repository, str, =
oid)
> -#define get_oid_treeish(str, oid)	repo_get_oid_treeish(the_repository, =
str, oid)
> -#define get_oid_blob(str, oid)		repo_get_oid_blob(the_repository, str, =
oid)
> -#define get_oid_mb(str, oid) 		repo_get_oid_mb(the_repository, str, oid=
)
> -
> -typedef int each_abbrev_fn(const struct object_id *oid, void *);
> -int repo_for_each_abbrev(struct repository *r, const char *prefix, each=
_abbrev_fn, void *);
> -#define for_each_abbrev(prefix, fn, data) repo_for_each_abbrev(the_repo=
sitory, prefix, fn, data)
> -
> -int set_disambiguate_hint_config(const char *var, const char *value);
> -
> -/*
> - * Try to read a SHA1 in hexadecimal format from the 40 characters
> - * starting at hex.  Write the 20-byte result to sha1 in binary form.
> - * Return 0 on success.  Reading stops if a NUL is encountered in the
> - * input, so it is safe to pass this function an arbitrary
> - * null-terminated string.
> - */
> -int get_sha1_hex(const char *hex, unsigned char *sha1);
> -int get_oid_hex(const char *hex, struct object_id *sha1);
> -
> -/* Like get_oid_hex, but for an arbitrary hash algorithm. */
> -int get_oid_hex_algop(const char *hex, struct object_id *oid, const str=
uct git_hash_algo *algop);
> -
> -/*
> - * Read `len` pairs of hexadecimal digits from `hex` and write the
> - * values to `binary` as `len` bytes. Return 0 on success, or -1 if
> - * the input does not consist of hex digits).
> - */
> -int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
> -
> -/*
> - * Convert a binary hash in "unsigned char []" or an object name in
> - * "struct object_id *" to its hex equivalent. The `_r` variant is reen=
trant,
> - * and writes the NUL-terminated output to the buffer `out`, which must=
 be at
> - * least `GIT_MAX_HEXSZ + 1` bytes, and returns a pointer to out for
> - * convenience.
> - *
> - * The non-`_r` variant returns a static buffer, but uses a ring of 4
> - * buffers, making it safe to make multiple calls for a single statemen=
t, like:
> - *
> - *   printf("%s -> %s", hash_to_hex(one), hash_to_hex(two));
> - *   printf("%s -> %s", oid_to_hex(one), oid_to_hex(two));
> - */
> -char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash, cons=
t struct git_hash_algo *);
> -char *oid_to_hex_r(char *out, const struct object_id *oid);
> -char *hash_to_hex_algop(const unsigned char *hash, const struct git_has=
h_algo *);	/* static buffer result! */
> -char *hash_to_hex(const unsigned char *hash);						/* same static buffe=
r */
> -char *oid_to_hex(const struct object_id *oid);						/* same static buff=
er */
> -
> -/*
> - * Parse a 40-character hexadecimal object ID starting from hex, updati=
ng the
> - * pointer specified by end when parsing stops.  The resulting object I=
D is
> - * stored in oid.  Returns 0 on success.  Parsing will stop on the firs=
t NUL or
> - * other invalid character.  end is only updated on success; otherwise,=
 it is
> - * unmodified.
> - */
> -int parse_oid_hex(const char *hex, struct object_id *oid, const char **=
end);
> -
> -/* Like parse_oid_hex, but for an arbitrary hash algorithm. */
> -int parse_oid_hex_algop(const char *hex, struct object_id *oid, const c=
har **end,
> -			const struct git_hash_algo *algo);
> -
> -
> -/*
> - * These functions work like get_oid_hex and parse_oid_hex, but they wi=
ll parse
> - * a hex value for any algorithm. The algorithm is detected based on th=
e length
> - * and the algorithm in use is returned. If this is not a hex object ID=
 in any
> - * algorithm, returns GIT_HASH_UNKNOWN.
> - */
> -int get_oid_hex_any(const char *hex, struct object_id *oid);
> -int parse_oid_hex_any(const char *hex, struct object_id *oid, const cha=
r **end);
> -
> -/*
> - * This reads short-hand syntax that not only evaluates to a commit
> - * object name, but also can act as if the end user spelled the name
> - * of the branch from the command line.
> - *
> - * - "@{-N}" finds the name of the Nth previous branch we were on, and
> - *   places the name of the branch in the given buf and returns the
> - *   number of characters parsed if successful.
> - *
> - * - "<branch>@{upstream}" finds the name of the other ref that
> - *   <branch> is configured to merge with (missing <branch> defaults
> - *   to the current branch), and places the name of the branch in the
> - *   given buf and returns the number of characters parsed if
> - *   successful.
> - *
> - * If the input is not of the accepted format, it returns a negative
> - * number to signal an error.
> - *
> - * If the input was ok but there are not N branch switches in the
> - * reflog, it returns 0.
> - */
> -#define INTERPRET_BRANCH_LOCAL (1<<0)
> -#define INTERPRET_BRANCH_REMOTE (1<<1)
> -#define INTERPRET_BRANCH_HEAD (1<<2)
> -struct interpret_branch_name_options {
> -	/*
> -	 * If "allowed" is non-zero, it is a treated as a bitfield of allowabl=
e
> -	 * expansions: local branches ("refs/heads/"), remote branches
> -	 * ("refs/remotes/"), or "HEAD". If no "allowed" bits are set, any exp=
ansion is
> -	 * allowed, even ones to refs outside of those namespaces.
> -	 */
> -	unsigned allowed;
> -
> -	/*
> -	 * If ^{upstream} or ^{push} (or equivalent) is requested, and the
> -	 * branch in question does not have such a reference, return -1 instea=
d
> -	 * of die()-ing.
> -	 */
> -	unsigned nonfatal_dangling_mark : 1;
> -};
> -int repo_interpret_branch_name(struct repository *r,
> -			       const char *str, int len,
> -			       struct strbuf *buf,
> -			       const struct interpret_branch_name_options *options);
> -#define interpret_branch_name(str, len, buf, options) \
> -	repo_interpret_branch_name(the_repository, str, len, buf, options)
> -
> -int validate_headref(const char *ref);
> -
> -int base_name_compare(const char *name1, size_t len1, int mode1,
> -		      const char *name2, size_t len2, int mode2);
> -int df_name_compare(const char *name1, size_t len1, int mode1,
> -		    const char *name2, size_t len2, int mode2);
> -int name_compare(const char *name1, size_t len1, const char *name2, siz=
e_t len2);
> -int cache_name_stage_compare(const char *name1, int len1, int stage1, c=
onst char *name2, int len2, int stage2);
> -
> -void *read_object_with_reference(struct repository *r,
> -				 const struct object_id *oid,
> -				 enum object_type required_type,
> -				 unsigned long *size,
> -				 struct object_id *oid_ret);
> -
> -struct object *repo_peel_to_type(struct repository *r,
> -				 const char *name, int namelen,
> -				 struct object *o, enum object_type);
> -#define peel_to_type(name, namelen, obj, type) \
> -	repo_peel_to_type(the_repository, name, namelen, obj, type)
> -
> -#define IDENT_STRICT	       1
> -#define IDENT_NO_DATE	       2
> -#define IDENT_NO_NAME	       4
> -
> -enum want_ident {
> -	WANT_BLANK_IDENT,
> -	WANT_AUTHOR_IDENT,
> -	WANT_COMMITTER_IDENT
> -};
> -
> -const char *git_author_info(int);
> -const char *git_committer_info(int);
> -const char *fmt_ident(const char *name, const char *email,
> -		      enum want_ident whose_ident,
> -		      const char *date_str, int);
> -const char *fmt_name(enum want_ident);
> -const char *ident_default_name(void);
> -const char *ident_default_email(void);
> -const char *git_editor(void);
> -const char *git_sequence_editor(void);
> -const char *git_pager(int stdout_is_tty);
> -int is_terminal_dumb(void);
> -int git_ident_config(const char *, const char *, void *);
> -/*
> - * Prepare an ident to fall back on if the user didn't configure it.
> - */
> -void prepare_fallback_ident(const char *name, const char *email);
> -void reset_ident_date(void);
> -
> -struct ident_split {
> -	const char *name_begin;
> -	const char *name_end;
> -	const char *mail_begin;
> -	const char *mail_end;
> -	const char *date_begin;
> -	const char *date_end;
> -	const char *tz_begin;
> -	const char *tz_end;
> -};
> -/*
> - * Signals an success with 0, but time part of the result may be NULL
> - * if the input lacks timestamp and zone
> - */
> -int split_ident_line(struct ident_split *, const char *, int);
> -
> -/*
> - * Given a commit or tag object buffer and the commit or tag headers, r=
eplaces
> - * the idents in the headers with their canonical versions using the ma=
ilmap mechanism.
> - */
> -void apply_mailmap_to_header(struct strbuf *, const char **, struct str=
ing_list *);
> -
> -/*
> - * Compare split idents for equality or strict ordering. Note that we
> - * compare only the ident part of the line, ignoring any timestamp.
> - *
> - * Because there are two fields, we must choose one as the primary key;=
 we
> - * currently arbitrarily pick the email.
> - */
> -int ident_cmp(const struct ident_split *, const struct ident_split *);
> -
> -struct cache_def {
> -	struct strbuf path;
> -	int flags;
> -	int track_flags;
> -	int prefix_len_stat_func;
> -};
> -#define CACHE_DEF_INIT { \
> -	.path =3D STRBUF_INIT, \
> -}
> -static inline void cache_def_clear(struct cache_def *cache)
> -{
> -	strbuf_release(&cache->path);
> -}
> -
> -int has_symlink_leading_path(const char *name, int len);
> -int threaded_has_symlink_leading_path(struct cache_def *, const char *,=
 int);
> -int check_leading_path(const char *name, int len, int warn_on_lstat_err=
);
> -int has_dirs_only_path(const char *name, int len, int prefix_len);
> -void invalidate_lstat_cache(void);
> -void schedule_dir_for_removal(const char *name, int len);
> -void remove_scheduled_dirs(void);
> -
> -struct pack_window {
> -	struct pack_window *next;
> -	unsigned char *base;
> -	off_t offset;
> -	size_t len;
> -	unsigned int last_used;
> -	unsigned int inuse_cnt;
> -};
> -
> -struct pack_entry {
> -	off_t offset;
> -	struct packed_git *p;
> -};
> -
> -/*
> - * Create a temporary file rooted in the object database directory, or
> - * die on failure. The filename is taken from "pattern", which should h=
ave the
> - * usual "XXXXXX" trailer, and the resulting filename is written into t=
he
> - * "template" buffer. Returns the open descriptor.
> - */
> -int odb_mkstemp(struct strbuf *temp_filename, const char *pattern);
> -
> -/*
> - * Create a pack .keep file named "name" (which should generally be the=
 output
> - * of odb_pack_name). Returns a file descriptor opened for writing, or =
-1 on
> - * error.
> - */
> -int odb_pack_keep(const char *name);
> -
> -/*
> - * Set this to 0 to prevent oid_object_info_extended() from fetching mi=
ssing
> - * blobs. This has a difference only if extensions.partialClone is set.
> - *
> - * Its default value is 1.
> - */
> -extern int fetch_if_missing;
> -
> -/* Dumb servers support */
> -int update_server_info(int);
> -
> -const char *get_log_output_encoding(void);
> -const char *get_commit_output_encoding(void);
> -
> -int committer_ident_sufficiently_given(void);
> -int author_ident_sufficiently_given(void);
> -
> -extern const char *git_commit_encoding;
> -extern const char *git_log_output_encoding;
> -extern const char *git_mailmap_file;
> -extern const char *git_mailmap_blob;
> -
> -/* IO helper functions */
> -void maybe_flush_or_die(FILE *, const char *);
> -__attribute__((format (printf, 2, 3)))
> -void fprintf_or_die(FILE *, const char *fmt, ...);
> -void fwrite_or_die(FILE *f, const void *buf, size_t count);
> -void fflush_or_die(FILE *f);
> -
> -#define COPY_READ_ERROR (-2)
> -#define COPY_WRITE_ERROR (-3)
> -int copy_fd(int ifd, int ofd);
> -int copy_file(const char *dst, const char *src, int mode);
> -int copy_file_with_time(const char *dst, const char *src, int mode);
> -
> -void write_or_die(int fd, const void *buf, size_t count);
> -void fsync_or_die(int fd, const char *);
> -int fsync_component(enum fsync_component component, int fd);
> -void fsync_component_or_die(enum fsync_component component, int fd, con=
st char *msg);
> -
> -static inline int batch_fsync_enabled(enum fsync_component component)
> -{
> -	return (fsync_components & component) && (fsync_method =3D=3D FSYNC_ME=
THOD_BATCH);
> -}
> -
> -ssize_t read_in_full(int fd, void *buf, size_t count);
> -ssize_t write_in_full(int fd, const void *buf, size_t count);
> -ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset);
> -
> -static inline ssize_t write_str_in_full(int fd, const char *str)
> -{
> -	return write_in_full(fd, str, strlen(str));
> -}
> -
> -/**
> - * Open (and truncate) the file at path, write the contents of buf to i=
t,
> - * and close it. Dies if any errors are encountered.
> - */
> -void write_file_buf(const char *path, const char *buf, size_t len);
> -
> -/**
> - * Like write_file_buf(), but format the contents into a buffer first.
> - * Additionally, write_file() will append a newline if one is not alrea=
dy
> - * present, making it convenient to write text files:
> - *
> - *   write_file(path, "counter: %d", ctr);
> - */
> -__attribute__((format (printf, 2, 3)))
> -void write_file(const char *path, const char *fmt, ...);
> -
> -/* pager.c */
> -void setup_pager(void);
> -int pager_in_use(void);
> -extern int pager_use_color;
> -int term_columns(void);
> -void term_clear_line(void);
> -int decimal_width(uintmax_t);
> -int check_pager_config(const char *cmd);
> -void prepare_pager_args(struct child_process *, const char *pager);
> -
> -extern const char *editor_program;
> -extern const char *askpass_program;
> -extern const char *excludes_file;
> -
> -/* base85 */
> -int decode_85(char *dst, const char *line, int linelen);
> -void encode_85(char *buf, const unsigned char *data, int bytes);
> -
> -/* pkt-line.c */
> -void packet_trace_identity(const char *prog);
> ->>>>>>> 752e921355 (Merge branch 'js/fix-clone-w-hooks-2.39' into HEAD)
>
>  /* add */
>  /*
> diff --git a/hook.c b/hook.c
> remerge CONFLICT (content): Merge conflict in hook.c
> index ce71f9d01a..b56f97949b 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -5,15 +5,12 @@
>  #include "path.h"
>  #include "run-command.h"
>  #include "config.h"
> -<<<<<<< 0f15832059 (Git 2.41.1)
>  #include "strbuf.h"
>  #include "environment.h"
>  #include "setup.h"
>  #include "copy.h"
> -||||||| b9b439e0e3
> -=3D=3D=3D=3D=3D=3D=3D
>  #include "strmap.h"
> ->>>>>>> 752e921355 (Merge branch 'js/fix-clone-w-hooks-2.39' into HEAD)
> +#include "hex.h"
>
>  static struct strset safe_hook_sha256s =3D STRSET_INIT;
>  static int safe_hook_sha256s_initialized;
> * js/fix-clone-w-hooks-2.42
> diff --git a/Makefile b/Makefile
> remerge CONFLICT (content): Merge conflict in Makefile
> index 5ae5f3c864..5776309365 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2743,16 +2743,8 @@ exec-cmd.sp exec-cmd.s exec-cmd.o: EXTRA_CPPFLAGS=
 =3D \
>  	'-DBINDIR=3D"$(bindir_relative_SQ)"' \
>  	'-DFALLBACK_RUNTIME_PREFIX=3D"$(prefix_SQ)"'
>
> -<<<<<<< babb4e5d71 (Git 2.42.2)
>  setup.sp setup.s setup.o: GIT-PREFIX
>  setup.sp setup.s setup.o: EXTRA_CPPFLAGS =3D \
> -||||||| 0f15832059
> -builtin/init-db.sp builtin/init-db.s builtin/init-db.o: GIT-PREFIX
> -builtin/init-db.sp builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS =
=3D \
> -=3D=3D=3D=3D=3D=3D=3D
> -builtin/init-db.sp builtin/init-db.s builtin/init-db.o: GIT-PREFIX
> -setup.sp setup.s setup.o: EXTRA_CPPFLAGS =3D \
> ->>>>>>> c7b6b0a28f (Merge branch 'js/fix-clone-w-hooks-2.40' into HEAD)
>  	-DDEFAULT_GIT_TEMPLATE_DIR=3D'"$(template_dir_SQ)"'
>
>  config.sp config.s config.o: GIT-PREFIX
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> remerge CONFLICT (content): Merge conflict in builtin/init-db.c
> index 6df47dd078..cb727c826f 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -12,920 +12,7 @@
>  #include "parse-options.h"
>  #include "path.h"
>  #include "setup.h"
> -<<<<<<< babb4e5d71 (Git 2.42.2)
>  #include "strbuf.h"
> -||||||| 0f15832059
> -#include "worktree.h"
> -#include "wrapper.h"
> -
> -#ifdef NO_TRUSTABLE_FILEMODE
> -#define TEST_FILEMODE 0
> -#else
> -#define TEST_FILEMODE 1
> -#endif
> -
> -#define GIT_DEFAULT_HASH_ENVIRONMENT "GIT_DEFAULT_HASH"
> -
> -static int init_is_bare_repository =3D 0;
> -static int init_shared_repository =3D -1;
> -
> -static void copy_templates_1(struct strbuf *path, struct strbuf *templa=
te_path,
> -			     DIR *dir)
> -{
> -	size_t path_baselen =3D path->len;
> -	size_t template_baselen =3D template_path->len;
> -	struct dirent *de;
> -
> -	/* Note: if ".git/hooks" file exists in the repository being
> -	 * re-initialized, /etc/core-git/templates/hooks/update would
> -	 * cause "git init" to fail here.  I think this is sane but
> -	 * it means that the set of templates we ship by default, along
> -	 * with the way the namespace under .git/ is organized, should
> -	 * be really carefully chosen.
> -	 */
> -	safe_create_dir(path->buf, 1);
> -	while ((de =3D readdir(dir)) !=3D NULL) {
> -		struct stat st_git, st_template;
> -		int exists =3D 0;
> -
> -		strbuf_setlen(path, path_baselen);
> -		strbuf_setlen(template_path, template_baselen);
> -
> -		if (de->d_name[0] =3D=3D '.')
> -			continue;
> -		strbuf_addstr(path, de->d_name);
> -		strbuf_addstr(template_path, de->d_name);
> -		if (lstat(path->buf, &st_git)) {
> -			if (errno !=3D ENOENT)
> -				die_errno(_("cannot stat '%s'"), path->buf);
> -		}
> -		else
> -			exists =3D 1;
> -
> -		if (lstat(template_path->buf, &st_template))
> -			die_errno(_("cannot stat template '%s'"), template_path->buf);
> -
> -		if (S_ISDIR(st_template.st_mode)) {
> -			DIR *subdir =3D opendir(template_path->buf);
> -			if (!subdir)
> -				die_errno(_("cannot opendir '%s'"), template_path->buf);
> -			strbuf_addch(path, '/');
> -			strbuf_addch(template_path, '/');
> -			copy_templates_1(path, template_path, subdir);
> -			closedir(subdir);
> -		}
> -		else if (exists)
> -			continue;
> -		else if (S_ISLNK(st_template.st_mode)) {
> -			struct strbuf lnk =3D STRBUF_INIT;
> -			if (strbuf_readlink(&lnk, template_path->buf,
> -					    st_template.st_size) < 0)
> -				die_errno(_("cannot readlink '%s'"), template_path->buf);
> -			if (symlink(lnk.buf, path->buf))
> -				die_errno(_("cannot symlink '%s' '%s'"),
> -					  lnk.buf, path->buf);
> -			strbuf_release(&lnk);
> -		}
> -		else if (S_ISREG(st_template.st_mode)) {
> -			if (copy_file(path->buf, template_path->buf, st_template.st_mode))
> -				die_errno(_("cannot copy '%s' to '%s'"),
> -					  template_path->buf, path->buf);
> -		}
> -		else
> -			error(_("ignoring template %s"), template_path->buf);
> -	}
> -}
> -
> -static void copy_templates(const char *option_template)
> -{
> -	const char *template_dir =3D get_template_dir(option_template);
> -	struct strbuf path =3D STRBUF_INIT;
> -	struct strbuf template_path =3D STRBUF_INIT;
> -	size_t template_len;
> -	struct repository_format template_format =3D REPOSITORY_FORMAT_INIT;
> -	struct strbuf err =3D STRBUF_INIT;
> -	DIR *dir;
> -	char *to_free =3D NULL;
> -
> -	if (!template_dir || !*template_dir)
> -		return;
> -
> -	strbuf_addstr(&template_path, template_dir);
> -	strbuf_complete(&template_path, '/');
> -	template_len =3D template_path.len;
> -
> -	dir =3D opendir(template_path.buf);
> -	if (!dir) {
> -		warning(_("templates not found in %s"), template_dir);
> -		goto free_return;
> -	}
> -
> -	/* Make sure that template is from the correct vintage */
> -	strbuf_addstr(&template_path, "config");
> -	read_repository_format(&template_format, template_path.buf);
> -	strbuf_setlen(&template_path, template_len);
> -
> -	/*
> -	 * No mention of version at all is OK, but anything else should be
> -	 * verified.
> -	 */
> -	if (template_format.version >=3D 0 &&
> -	    verify_repository_format(&template_format, &err) < 0) {
> -		warning(_("not copying templates from '%s': %s"),
> -			  template_dir, err.buf);
> -		strbuf_release(&err);
> -		goto close_free_return;
> -	}
> -
> -	strbuf_addstr(&path, get_git_common_dir());
> -	strbuf_complete(&path, '/');
> -	copy_templates_1(&path, &template_path, dir);
> -close_free_return:
> -	closedir(dir);
> -free_return:
> -	free(to_free);
> -	strbuf_release(&path);
> -	strbuf_release(&template_path);
> -	clear_repository_format(&template_format);
> -}
> -
> -/*
> - * If the git_dir is not directly inside the working tree, then git wil=
l not
> - * find it by default, and we need to set the worktree explicitly.
> - */
> -static int needs_work_tree_config(const char *git_dir, const char *work=
_tree)
> -{
> -	if (!strcmp(work_tree, "/") && !strcmp(git_dir, "/.git"))
> -		return 0;
> -	if (skip_prefix(git_dir, work_tree, &git_dir) &&
> -	    !strcmp(git_dir, "/.git"))
> -		return 0;
> -	return 1;
> -}
> -
> -void initialize_repository_version(int hash_algo, int reinit)
> -{
> -	char repo_version_string[10];
> -	int repo_version =3D GIT_REPO_VERSION;
> -
> -	if (hash_algo !=3D GIT_HASH_SHA1)
> -		repo_version =3D GIT_REPO_VERSION_READ;
> -
> -	/* This forces creation of new config file */
> -	xsnprintf(repo_version_string, sizeof(repo_version_string),
> -		  "%d", repo_version);
> -	git_config_set("core.repositoryformatversion", repo_version_string);
> -
> -	if (hash_algo !=3D GIT_HASH_SHA1)
> -		git_config_set("extensions.objectformat",
> -			       hash_algos[hash_algo].name);
> -	else if (reinit)
> -		git_config_set_gently("extensions.objectformat", NULL);
> -}
> -
> -static int create_default_files(const char *template_path,
> -				const char *original_git_dir,
> -				const char *initial_branch,
> -				const struct repository_format *fmt,
> -				int quiet)
> -{
> -	struct stat st1;
> -	struct strbuf buf =3D STRBUF_INIT;
> -	char *path;
> -	char junk[2];
> -	int reinit;
> -	int filemode;
> -	struct strbuf err =3D STRBUF_INIT;
> -	const char *work_tree =3D get_git_work_tree();
> -
> -	/*
> -	 * First copy the templates -- we might have the default
> -	 * config file there, in which case we would want to read
> -	 * from it after installing.
> -	 *
> -	 * Before reading that config, we also need to clear out any cached
> -	 * values (since we've just potentially changed what's available on
> -	 * disk).
> -	 */
> -	copy_templates(template_path);
> -	git_config_clear();
> -	reset_shared_repository();
> -	git_config(git_default_config, NULL);
> -
> -	/*
> -	 * We must make sure command-line options continue to override any
> -	 * values we might have just re-read from the config.
> -	 */
> -	is_bare_repository_cfg =3D init_is_bare_repository || !work_tree;
> -	if (init_shared_repository !=3D -1)
> -		set_shared_repository(init_shared_repository);
> -
> -	/*
> -	 * We would have created the above under user's umask -- under
> -	 * shared-repository settings, we would need to fix them up.
> -	 */
> -	if (get_shared_repository()) {
> -		adjust_shared_perm(get_git_dir());
> -	}
> -
> -	/*
> -	 * We need to create a "refs" dir in any case so that older
> -	 * versions of git can tell that this is a repository.
> -	 */
> -	safe_create_dir(git_path("refs"), 1);
> -	adjust_shared_perm(git_path("refs"));
> -
> -	if (refs_init_db(&err))
> -		die("failed to set up refs db: %s", err.buf);
> -
> -	/*
> -	 * Point the HEAD symref to the initial branch with if HEAD does
> -	 * not yet exist.
> -	 */
> -	path =3D git_path_buf(&buf, "HEAD");
> -	reinit =3D (!access(path, R_OK)
> -		  || readlink(path, junk, sizeof(junk)-1) !=3D -1);
> -	if (!reinit) {
> -		char *ref;
> -
> -		if (!initial_branch)
> -			initial_branch =3D git_default_branch_name(quiet);
> -
> -		ref =3D xstrfmt("refs/heads/%s", initial_branch);
> -		if (check_refname_format(ref, 0) < 0)
> -			die(_("invalid initial branch name: '%s'"),
> -			    initial_branch);
> -
> -		if (create_symref("HEAD", ref, NULL) < 0)
> -			exit(1);
> -		free(ref);
> -	}
> -
> -	initialize_repository_version(fmt->hash_algo, 0);
> -
> -	/* Check filemode trustability */
> -	path =3D git_path_buf(&buf, "config");
> -	filemode =3D TEST_FILEMODE;
> -	if (TEST_FILEMODE && !lstat(path, &st1)) {
> -		struct stat st2;
> -		filemode =3D (!chmod(path, st1.st_mode ^ S_IXUSR) &&
> -				!lstat(path, &st2) &&
> -				st1.st_mode !=3D st2.st_mode &&
> -				!chmod(path, st1.st_mode));
> -		if (filemode && !reinit && (st1.st_mode & S_IXUSR))
> -			filemode =3D 0;
> -	}
> -	git_config_set("core.filemode", filemode ? "true" : "false");
> -
> -	if (is_bare_repository())
> -		git_config_set("core.bare", "true");
> -	else {
> -		git_config_set("core.bare", "false");
> -		/* allow template config file to override the default */
> -		if (log_all_ref_updates =3D=3D LOG_REFS_UNSET)
> -			git_config_set("core.logallrefupdates", "true");
> -		if (needs_work_tree_config(original_git_dir, work_tree))
> -			git_config_set("core.worktree", work_tree);
> -	}
> -
> -	if (!reinit) {
> -		/* Check if symlink is supported in the work tree */
> -		path =3D git_path_buf(&buf, "tXXXXXX");
> -		if (!close(xmkstemp(path)) &&
> -		    !unlink(path) &&
> -		    !symlink("testing", path) &&
> -		    !lstat(path, &st1) &&
> -		    S_ISLNK(st1.st_mode))
> -			unlink(path); /* good */
> -		else
> -			git_config_set("core.symlinks", "false");
> -
> -		/* Check if the filesystem is case-insensitive */
> -		path =3D git_path_buf(&buf, "CoNfIg");
> -		if (!access(path, F_OK))
> -			git_config_set("core.ignorecase", "true");
> -		probe_utf8_pathname_composition();
> -	}
> -
> -	strbuf_release(&buf);
> -	return reinit;
> -}
> -
> -static void create_object_directory(void)
> -{
> -	struct strbuf path =3D STRBUF_INIT;
> -	size_t baselen;
> -
> -	strbuf_addstr(&path, get_object_directory());
> -	baselen =3D path.len;
> -
> -	safe_create_dir(path.buf, 1);
> -
> -	strbuf_setlen(&path, baselen);
> -	strbuf_addstr(&path, "/pack");
> -	safe_create_dir(path.buf, 1);
> -
> -	strbuf_setlen(&path, baselen);
> -	strbuf_addstr(&path, "/info");
> -	safe_create_dir(path.buf, 1);
> -
> -	strbuf_release(&path);
> -}
> -
> -static void separate_git_dir(const char *git_dir, const char *git_link)
> -{
> -	struct stat st;
> -
> -	if (!stat(git_link, &st)) {
> -		const char *src;
> -
> -		if (S_ISREG(st.st_mode))
> -			src =3D read_gitfile(git_link);
> -		else if (S_ISDIR(st.st_mode))
> -			src =3D git_link;
> -		else
> -			die(_("unable to handle file type %d"), (int)st.st_mode);
> -
> -		if (rename(src, git_dir))
> -			die_errno(_("unable to move %s to %s"), src, git_dir);
> -		repair_worktrees(NULL, NULL);
> -	}
> -
> -	write_file(git_link, "gitdir: %s", git_dir);
> -}
> -
> -static void validate_hash_algorithm(struct repository_format *repo_fmt,=
 int hash)
> -{
> -	const char *env =3D getenv(GIT_DEFAULT_HASH_ENVIRONMENT);
> -	/*
> -	 * If we already have an initialized repo, don't allow the user to
> -	 * specify a different algorithm, as that could cause corruption.
> -	 * Otherwise, if the user has specified one on the command line, use i=
t.
> -	 */
> -	if (repo_fmt->version >=3D 0 && hash !=3D GIT_HASH_UNKNOWN && hash !=
=3D repo_fmt->hash_algo)
> -		die(_("attempt to reinitialize repository with different hash"));
> -	else if (hash !=3D GIT_HASH_UNKNOWN)
> -		repo_fmt->hash_algo =3D hash;
> -	else if (env) {
> -		int env_algo =3D hash_algo_by_name(env);
> -		if (env_algo =3D=3D GIT_HASH_UNKNOWN)
> -			die(_("unknown hash algorithm '%s'"), env);
> -		repo_fmt->hash_algo =3D env_algo;
> -	}
> -}
> -
> -int init_db(const char *git_dir, const char *real_git_dir,
> -	    const char *template_dir, int hash, const char *initial_branch,
> -	    unsigned int flags)
> -{
> -	int reinit;
> -	int exist_ok =3D flags & INIT_DB_EXIST_OK;
> -	char *original_git_dir =3D real_pathdup(git_dir, 1);
> -	struct repository_format repo_fmt =3D REPOSITORY_FORMAT_INIT;
> -
> -	if (real_git_dir) {
> -		struct stat st;
> -
> -		if (!exist_ok && !stat(git_dir, &st))
> -			die(_("%s already exists"), git_dir);
> -
> -		if (!exist_ok && !stat(real_git_dir, &st))
> -			die(_("%s already exists"), real_git_dir);
> -
> -		set_git_dir(real_git_dir, 1);
> -		git_dir =3D get_git_dir();
> -		separate_git_dir(git_dir, original_git_dir);
> -	}
> -	else {
> -		set_git_dir(git_dir, 1);
> -		git_dir =3D get_git_dir();
> -	}
> -	startup_info->have_repository =3D 1;
> -
> -	/* Ensure `core.hidedotfiles` is processed */
> -	git_config(platform_core_config, NULL);
> -
> -	safe_create_dir(git_dir, 0);
> -
> -	init_is_bare_repository =3D is_bare_repository();
> -
> -	/* Check to see if the repository version is right.
> -	 * Note that a newly created repository does not have
> -	 * config file, so this will not fail.  What we are catching
> -	 * is an attempt to reinitialize new repository with an old tool.
> -	 */
> -	check_repository_format(&repo_fmt);
> -
> -	validate_hash_algorithm(&repo_fmt, hash);
> -
> -	reinit =3D create_default_files(template_dir, original_git_dir,
> -				      initial_branch, &repo_fmt,
> -				      flags & INIT_DB_QUIET);
> -	if (reinit && initial_branch)
> -		warning(_("re-init: ignored --initial-branch=3D%s"),
> -			initial_branch);
> -
> -	create_object_directory();
> -
> -	if (get_shared_repository()) {
> -		char buf[10];
> -		/* We do not spell "group" and such, so that
> -		 * the configuration can be read by older version
> -		 * of git. Note, we use octal numbers for new share modes,
> -		 * and compatibility values for PERM_GROUP and
> -		 * PERM_EVERYBODY.
> -		 */
> -		if (get_shared_repository() < 0)
> -			/* force to the mode value */
> -			xsnprintf(buf, sizeof(buf), "0%o", -get_shared_repository());
> -		else if (get_shared_repository() =3D=3D PERM_GROUP)
> -			xsnprintf(buf, sizeof(buf), "%d", OLD_PERM_GROUP);
> -		else if (get_shared_repository() =3D=3D PERM_EVERYBODY)
> -			xsnprintf(buf, sizeof(buf), "%d", OLD_PERM_EVERYBODY);
> -		else
> -			BUG("invalid value for shared_repository");
> -		git_config_set("core.sharedrepository", buf);
> -		git_config_set("receive.denyNonFastforwards", "true");
> -	}
> -
> -	if (!(flags & INIT_DB_QUIET)) {
> -		int len =3D strlen(git_dir);
> -
> -		if (reinit)
> -			printf(get_shared_repository()
> -			       ? _("Reinitialized existing shared Git repository in %s%s\n")
> -			       : _("Reinitialized existing Git repository in %s%s\n"),
> -			       git_dir, len && git_dir[len-1] !=3D '/' ? "/" : "");
> -		else
> -			printf(get_shared_repository()
> -			       ? _("Initialized empty shared Git repository in %s%s\n")
> -			       : _("Initialized empty Git repository in %s%s\n"),
> -			       git_dir, len && git_dir[len-1] !=3D '/' ? "/" : "");
> -	}
> -
> -	free(original_git_dir);
> -	return 0;
> -}
> -=3D=3D=3D=3D=3D=3D=3D
> -#include "worktree.h"
> -#include "wrapper.h"
> -#include "run-command.h"
> -#include "hook.h"
> -
> -#ifdef NO_TRUSTABLE_FILEMODE
> -#define TEST_FILEMODE 0
> -#else
> -#define TEST_FILEMODE 1
> -#endif
> -
> -#define GIT_DEFAULT_HASH_ENVIRONMENT "GIT_DEFAULT_HASH"
> -
> -static int init_is_bare_repository =3D 0;
> -static int init_shared_repository =3D -1;
> -
> -static void copy_templates_1(struct strbuf *path, struct strbuf *templa=
te_path,
> -			     DIR *dir)
> -{
> -	size_t path_baselen =3D path->len;
> -	size_t template_baselen =3D template_path->len;
> -	struct dirent *de;
> -	int is_hooks_dir =3D ends_with(template_path->buf, "/hooks/");
> -
> -	/* Note: if ".git/hooks" file exists in the repository being
> -	 * re-initialized, /etc/core-git/templates/hooks/update would
> -	 * cause "git init" to fail here.  I think this is sane but
> -	 * it means that the set of templates we ship by default, along
> -	 * with the way the namespace under .git/ is organized, should
> -	 * be really carefully chosen.
> -	 */
> -	safe_create_dir(path->buf, 1);
> -	while ((de =3D readdir(dir)) !=3D NULL) {
> -		struct stat st_git, st_template;
> -		int exists =3D 0;
> -
> -		strbuf_setlen(path, path_baselen);
> -		strbuf_setlen(template_path, template_baselen);
> -
> -		if (de->d_name[0] =3D=3D '.')
> -			continue;
> -		strbuf_addstr(path, de->d_name);
> -		strbuf_addstr(template_path, de->d_name);
> -		if (lstat(path->buf, &st_git)) {
> -			if (errno !=3D ENOENT)
> -				die_errno(_("cannot stat '%s'"), path->buf);
> -		}
> -		else
> -			exists =3D 1;
> -
> -		if (lstat(template_path->buf, &st_template))
> -			die_errno(_("cannot stat template '%s'"), template_path->buf);
> -
> -		if (S_ISDIR(st_template.st_mode)) {
> -			DIR *subdir =3D opendir(template_path->buf);
> -			if (!subdir)
> -				die_errno(_("cannot opendir '%s'"), template_path->buf);
> -			strbuf_addch(path, '/');
> -			strbuf_addch(template_path, '/');
> -			copy_templates_1(path, template_path, subdir);
> -			closedir(subdir);
> -		}
> -		else if (exists)
> -			continue;
> -		else if (S_ISLNK(st_template.st_mode)) {
> -			struct strbuf lnk =3D STRBUF_INIT;
> -			if (strbuf_readlink(&lnk, template_path->buf,
> -					    st_template.st_size) < 0)
> -				die_errno(_("cannot readlink '%s'"), template_path->buf);
> -			if (symlink(lnk.buf, path->buf))
> -				die_errno(_("cannot symlink '%s' '%s'"),
> -					  lnk.buf, path->buf);
> -			strbuf_release(&lnk);
> -		}
> -		else if (S_ISREG(st_template.st_mode)) {
> -			if (is_hooks_dir &&
> -			    is_executable(template_path->buf))
> -				add_safe_hook(template_path->buf);
> -
> -			if (copy_file(path->buf, template_path->buf, st_template.st_mode))
> -				die_errno(_("cannot copy '%s' to '%s'"),
> -					  template_path->buf, path->buf);
> -		}
> -		else
> -			error(_("ignoring template %s"), template_path->buf);
> -	}
> -}
> -
> -static void copy_templates(const char *option_template)
> -{
> -	const char *template_dir =3D get_template_dir(option_template);
> -	struct strbuf path =3D STRBUF_INIT;
> -	struct strbuf template_path =3D STRBUF_INIT;
> -	size_t template_len;
> -	struct repository_format template_format =3D REPOSITORY_FORMAT_INIT;
> -	struct strbuf err =3D STRBUF_INIT;
> -	DIR *dir;
> -	char *to_free =3D NULL;
> -
> -	if (!template_dir || !*template_dir)
> -		return;
> -
> -	strbuf_addstr(&template_path, template_dir);
> -	strbuf_complete(&template_path, '/');
> -	template_len =3D template_path.len;
> -
> -	dir =3D opendir(template_path.buf);
> -	if (!dir) {
> -		warning(_("templates not found in %s"), template_dir);
> -		goto free_return;
> -	}
> -
> -	/* Make sure that template is from the correct vintage */
> -	strbuf_addstr(&template_path, "config");
> -	read_repository_format(&template_format, template_path.buf);
> -	strbuf_setlen(&template_path, template_len);
> -
> -	/*
> -	 * No mention of version at all is OK, but anything else should be
> -	 * verified.
> -	 */
> -	if (template_format.version >=3D 0 &&
> -	    verify_repository_format(&template_format, &err) < 0) {
> -		warning(_("not copying templates from '%s': %s"),
> -			  template_dir, err.buf);
> -		strbuf_release(&err);
> -		goto close_free_return;
> -	}
> -
> -	strbuf_addstr(&path, get_git_common_dir());
> -	strbuf_complete(&path, '/');
> -	copy_templates_1(&path, &template_path, dir);
> -close_free_return:
> -	closedir(dir);
> -free_return:
> -	free(to_free);
> -	strbuf_release(&path);
> -	strbuf_release(&template_path);
> -	clear_repository_format(&template_format);
> -}
> -
> -/*
> - * If the git_dir is not directly inside the working tree, then git wil=
l not
> - * find it by default, and we need to set the worktree explicitly.
> - */
> -static int needs_work_tree_config(const char *git_dir, const char *work=
_tree)
> -{
> -	if (!strcmp(work_tree, "/") && !strcmp(git_dir, "/.git"))
> -		return 0;
> -	if (skip_prefix(git_dir, work_tree, &git_dir) &&
> -	    !strcmp(git_dir, "/.git"))
> -		return 0;
> -	return 1;
> -}
> -
> -void initialize_repository_version(int hash_algo, int reinit)
> -{
> -	char repo_version_string[10];
> -	int repo_version =3D GIT_REPO_VERSION;
> -
> -	if (hash_algo !=3D GIT_HASH_SHA1)
> -		repo_version =3D GIT_REPO_VERSION_READ;
> -
> -	/* This forces creation of new config file */
> -	xsnprintf(repo_version_string, sizeof(repo_version_string),
> -		  "%d", repo_version);
> -	git_config_set("core.repositoryformatversion", repo_version_string);
> -
> -	if (hash_algo !=3D GIT_HASH_SHA1)
> -		git_config_set("extensions.objectformat",
> -			       hash_algos[hash_algo].name);
> -	else if (reinit)
> -		git_config_set_gently("extensions.objectformat", NULL);
> -}
> -
> -static int create_default_files(const char *template_path,
> -				const char *original_git_dir,
> -				const char *initial_branch,
> -				const struct repository_format *fmt,
> -				int quiet)
> -{
> -	struct stat st1;
> -	struct strbuf buf =3D STRBUF_INIT;
> -	char *path;
> -	char junk[2];
> -	int reinit;
> -	int filemode;
> -	struct strbuf err =3D STRBUF_INIT;
> -	const char *work_tree =3D get_git_work_tree();
> -
> -	/*
> -	 * First copy the templates -- we might have the default
> -	 * config file there, in which case we would want to read
> -	 * from it after installing.
> -	 *
> -	 * Before reading that config, we also need to clear out any cached
> -	 * values (since we've just potentially changed what's available on
> -	 * disk).
> -	 */
> -	copy_templates(template_path);
> -	git_config_clear();
> -	reset_shared_repository();
> -	git_config(git_default_config, NULL);
> -
> -	/*
> -	 * We must make sure command-line options continue to override any
> -	 * values we might have just re-read from the config.
> -	 */
> -	is_bare_repository_cfg =3D init_is_bare_repository || !work_tree;
> -	if (init_shared_repository !=3D -1)
> -		set_shared_repository(init_shared_repository);
> -
> -	/*
> -	 * We would have created the above under user's umask -- under
> -	 * shared-repository settings, we would need to fix them up.
> -	 */
> -	if (get_shared_repository()) {
> -		adjust_shared_perm(get_git_dir());
> -	}
> -
> -	/*
> -	 * We need to create a "refs" dir in any case so that older
> -	 * versions of git can tell that this is a repository.
> -	 */
> -	safe_create_dir(git_path("refs"), 1);
> -	adjust_shared_perm(git_path("refs"));
> -
> -	if (refs_init_db(&err))
> -		die("failed to set up refs db: %s", err.buf);
> -
> -	/*
> -	 * Point the HEAD symref to the initial branch with if HEAD does
> -	 * not yet exist.
> -	 */
> -	path =3D git_path_buf(&buf, "HEAD");
> -	reinit =3D (!access(path, R_OK)
> -		  || readlink(path, junk, sizeof(junk)-1) !=3D -1);
> -	if (!reinit) {
> -		char *ref;
> -
> -		if (!initial_branch)
> -			initial_branch =3D git_default_branch_name(quiet);
> -
> -		ref =3D xstrfmt("refs/heads/%s", initial_branch);
> -		if (check_refname_format(ref, 0) < 0)
> -			die(_("invalid initial branch name: '%s'"),
> -			    initial_branch);
> -
> -		if (create_symref("HEAD", ref, NULL) < 0)
> -			exit(1);
> -		free(ref);
> -	}
> -
> -	initialize_repository_version(fmt->hash_algo, 0);
> -
> -	/* Check filemode trustability */
> -	path =3D git_path_buf(&buf, "config");
> -	filemode =3D TEST_FILEMODE;
> -	if (TEST_FILEMODE && !lstat(path, &st1)) {
> -		struct stat st2;
> -		filemode =3D (!chmod(path, st1.st_mode ^ S_IXUSR) &&
> -				!lstat(path, &st2) &&
> -				st1.st_mode !=3D st2.st_mode &&
> -				!chmod(path, st1.st_mode));
> -		if (filemode && !reinit && (st1.st_mode & S_IXUSR))
> -			filemode =3D 0;
> -	}
> -	git_config_set("core.filemode", filemode ? "true" : "false");
> -
> -	if (is_bare_repository())
> -		git_config_set("core.bare", "true");
> -	else {
> -		git_config_set("core.bare", "false");
> -		/* allow template config file to override the default */
> -		if (log_all_ref_updates =3D=3D LOG_REFS_UNSET)
> -			git_config_set("core.logallrefupdates", "true");
> -		if (needs_work_tree_config(original_git_dir, work_tree))
> -			git_config_set("core.worktree", work_tree);
> -	}
> -
> -	if (!reinit) {
> -		/* Check if symlink is supported in the work tree */
> -		path =3D git_path_buf(&buf, "tXXXXXX");
> -		if (!close(xmkstemp(path)) &&
> -		    !unlink(path) &&
> -		    !symlink("testing", path) &&
> -		    !lstat(path, &st1) &&
> -		    S_ISLNK(st1.st_mode))
> -			unlink(path); /* good */
> -		else
> -			git_config_set("core.symlinks", "false");
> -
> -		/* Check if the filesystem is case-insensitive */
> -		path =3D git_path_buf(&buf, "CoNfIg");
> -		if (!access(path, F_OK))
> -			git_config_set("core.ignorecase", "true");
> -		probe_utf8_pathname_composition();
> -	}
> -
> -	strbuf_release(&buf);
> -	return reinit;
> -}
> -
> -static void create_object_directory(void)
> -{
> -	struct strbuf path =3D STRBUF_INIT;
> -	size_t baselen;
> -
> -	strbuf_addstr(&path, get_object_directory());
> -	baselen =3D path.len;
> -
> -	safe_create_dir(path.buf, 1);
> -
> -	strbuf_setlen(&path, baselen);
> -	strbuf_addstr(&path, "/pack");
> -	safe_create_dir(path.buf, 1);
> -
> -	strbuf_setlen(&path, baselen);
> -	strbuf_addstr(&path, "/info");
> -	safe_create_dir(path.buf, 1);
> -
> -	strbuf_release(&path);
> -}
> -
> -static void separate_git_dir(const char *git_dir, const char *git_link)
> -{
> -	struct stat st;
> -
> -	if (!stat(git_link, &st)) {
> -		const char *src;
> -
> -		if (S_ISREG(st.st_mode))
> -			src =3D read_gitfile(git_link);
> -		else if (S_ISDIR(st.st_mode))
> -			src =3D git_link;
> -		else
> -			die(_("unable to handle file type %d"), (int)st.st_mode);
> -
> -		if (rename(src, git_dir))
> -			die_errno(_("unable to move %s to %s"), src, git_dir);
> -		repair_worktrees(NULL, NULL);
> -	}
> -
> -	write_file(git_link, "gitdir: %s", git_dir);
> -}
> -
> -static void validate_hash_algorithm(struct repository_format *repo_fmt,=
 int hash)
> -{
> -	const char *env =3D getenv(GIT_DEFAULT_HASH_ENVIRONMENT);
> -	/*
> -	 * If we already have an initialized repo, don't allow the user to
> -	 * specify a different algorithm, as that could cause corruption.
> -	 * Otherwise, if the user has specified one on the command line, use i=
t.
> -	 */
> -	if (repo_fmt->version >=3D 0 && hash !=3D GIT_HASH_UNKNOWN && hash !=
=3D repo_fmt->hash_algo)
> -		die(_("attempt to reinitialize repository with different hash"));
> -	else if (hash !=3D GIT_HASH_UNKNOWN)
> -		repo_fmt->hash_algo =3D hash;
> -	else if (env) {
> -		int env_algo =3D hash_algo_by_name(env);
> -		if (env_algo =3D=3D GIT_HASH_UNKNOWN)
> -			die(_("unknown hash algorithm '%s'"), env);
> -		repo_fmt->hash_algo =3D env_algo;
> -	}
> -}
> -
> -int init_db(const char *git_dir, const char *real_git_dir,
> -	    const char *template_dir, int hash, const char *initial_branch,
> -	    unsigned int flags)
> -{
> -	int reinit;
> -	int exist_ok =3D flags & INIT_DB_EXIST_OK;
> -	char *original_git_dir =3D real_pathdup(git_dir, 1);
> -	struct repository_format repo_fmt =3D REPOSITORY_FORMAT_INIT;
> -
> -	if (real_git_dir) {
> -		struct stat st;
> -
> -		if (!exist_ok && !stat(git_dir, &st))
> -			die(_("%s already exists"), git_dir);
> -
> -		if (!exist_ok && !stat(real_git_dir, &st))
> -			die(_("%s already exists"), real_git_dir);
> -
> -		set_git_dir(real_git_dir, 1);
> -		git_dir =3D get_git_dir();
> -		separate_git_dir(git_dir, original_git_dir);
> -	}
> -	else {
> -		set_git_dir(git_dir, 1);
> -		git_dir =3D get_git_dir();
> -	}
> -	startup_info->have_repository =3D 1;
> -
> -	/* Ensure `core.hidedotfiles` is processed */
> -	git_config(platform_core_config, NULL);
> -
> -	safe_create_dir(git_dir, 0);
> -
> -	init_is_bare_repository =3D is_bare_repository();
> -
> -	/* Check to see if the repository version is right.
> -	 * Note that a newly created repository does not have
> -	 * config file, so this will not fail.  What we are catching
> -	 * is an attempt to reinitialize new repository with an old tool.
> -	 */
> -	check_repository_format(&repo_fmt);
> -
> -	validate_hash_algorithm(&repo_fmt, hash);
> -
> -	reinit =3D create_default_files(template_dir, original_git_dir,
> -				      initial_branch, &repo_fmt,
> -				      flags & INIT_DB_QUIET);
> -	if (reinit && initial_branch)
> -		warning(_("re-init: ignored --initial-branch=3D%s"),
> -			initial_branch);
> -
> -	create_object_directory();
> -
> -	if (get_shared_repository()) {
> -		char buf[10];
> -		/* We do not spell "group" and such, so that
> -		 * the configuration can be read by older version
> -		 * of git. Note, we use octal numbers for new share modes,
> -		 * and compatibility values for PERM_GROUP and
> -		 * PERM_EVERYBODY.
> -		 */
> -		if (get_shared_repository() < 0)
> -			/* force to the mode value */
> -			xsnprintf(buf, sizeof(buf), "0%o", -get_shared_repository());
> -		else if (get_shared_repository() =3D=3D PERM_GROUP)
> -			xsnprintf(buf, sizeof(buf), "%d", OLD_PERM_GROUP);
> -		else if (get_shared_repository() =3D=3D PERM_EVERYBODY)
> -			xsnprintf(buf, sizeof(buf), "%d", OLD_PERM_EVERYBODY);
> -		else
> -			BUG("invalid value for shared_repository");
> -		git_config_set("core.sharedrepository", buf);
> -		git_config_set("receive.denyNonFastforwards", "true");
> -	}
> -
> -	if (!(flags & INIT_DB_QUIET)) {
> -		int len =3D strlen(git_dir);
> -
> -		if (reinit)
> -			printf(get_shared_repository()
> -			       ? _("Reinitialized existing shared Git repository in %s%s\n")
> -			       : _("Reinitialized existing Git repository in %s%s\n"),
> -			       git_dir, len && git_dir[len-1] !=3D '/' ? "/" : "");
> -		else
> -			printf(get_shared_repository()
> -			       ? _("Initialized empty shared Git repository in %s%s\n")
> -			       : _("Initialized empty Git repository in %s%s\n"),
> -			       git_dir, len && git_dir[len-1] !=3D '/' ? "/" : "");
> -	}
> -
> -	free(original_git_dir);
> -	return 0;
> -}
> ->>>>>>> c7b6b0a28f (Merge branch 'js/fix-clone-w-hooks-2.40' into HEAD)
>
>  static int guess_repository_type(const char *git_dir)
>  {
> diff --git a/config.c b/config.c
> remerge CONFLICT (content): Merge conflict in config.c
> index f0f09004c8..3846a37be9 100644
> --- a/config.c
> +++ b/config.c
> @@ -1558,33 +1558,7 @@ static int git_default_core_config(const char *va=
r, const char *value,
>  	if (!strcmp(var, "core.attributesfile"))
>  		return git_config_pathname(&git_attributes_file, var, value);
>
> -<<<<<<< babb4e5d71 (Git 2.42.2)
> -	if (!strcmp(var, "core.hookspath")) {
> -		if (ctx->kvi && ctx->kvi->scope =3D=3D CONFIG_SCOPE_LOCAL &&
> -		    git_env_bool("GIT_CLONE_PROTECTION_ACTIVE", 0))
> -			die(_("active `core.hooksPath` found in the local "
> -			      "repository config:\n\t%s\nFor security "
> -			      "reasons, this is disallowed by default.\nIf "
> -			      "this is intentional and the hook should "
> -			      "actually be run, please\nrun the command "
> -			      "again with "
> -			      "`GIT_CLONE_PROTECTION_ACTIVE=3Dfalse`"),
> -			    value);
> -||||||| 0f15832059
> -	if (!strcmp(var, "core.hookspath")) {
> -		if (current_config_scope() =3D=3D CONFIG_SCOPE_LOCAL &&
> -		    git_env_bool("GIT_CLONE_PROTECTION_ACTIVE", 0))
> -			die(_("active `core.hooksPath` found in the local "
> -			      "repository config:\n\t%s\nFor security "
> -			      "reasons, this is disallowed by default.\nIf "
> -			      "this is intentional and the hook should "
> -			      "actually be run, please\nrun the command "
> -			      "again with "
> -			      "`GIT_CLONE_PROTECTION_ACTIVE=3Dfalse`"),
> -			    value);
> -=3D=3D=3D=3D=3D=3D=3D
>  	if (!strcmp(var, "core.hookspath"))
> ->>>>>>> c7b6b0a28f (Merge branch 'js/fix-clone-w-hooks-2.40' into HEAD)
>  		return git_config_pathname(&git_hooks_path, var, value);
>
>  	if (!strcmp(var, "core.bare")) {
> diff --git a/hook.c b/hook.c
> index 7ddb677216..7be471e335 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -59,7 +59,8 @@ void add_safe_hook(const char *path)
>  	}
>  }
>
> -static int safe_hook_cb(const char *key, const char *value, void *d)
> +static int safe_hook_cb(const char *key, const char *value,
> +			const struct config_context *ctx UNUSED, void *d)
>  {
>  	struct strset *set =3D d;
>
> diff --git a/setup.c b/setup.c
> index ea2aec5aaa..dc4897543e 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -18,6 +18,7 @@
>  #include "trace2.h"
>  #include "worktree.h"
>  #include "exec-cmd.h"
> +#include "run-command.h"
>  #include "hook.h"
>
>  static int inside_git_dir =3D -1;
> @@ -1794,6 +1795,7 @@ static void copy_templates_1(struct strbuf *path, =
struct strbuf *template_path,
>  	size_t path_baselen =3D path->len;
>  	size_t template_baselen =3D template_path->len;
>  	struct dirent *de;
> +	int is_hooks_dir =3D ends_with(template_path->buf, "/hooks/");
>
>  	/* Note: if ".git/hooks" file exists in the repository being
>  	 * re-initialized, /etc/core-git/templates/hooks/update would
> @@ -1846,6 +1848,10 @@ static void copy_templates_1(struct strbuf *path,=
 struct strbuf *template_path,
>  			strbuf_release(&lnk);
>  		}
>  		else if (S_ISREG(st_template.st_mode)) {
> +			if (is_hooks_dir &&
> +			    is_executable(template_path->buf))
> +				add_safe_hook(template_path->buf);
> +
>  			if (copy_file(path->buf, template_path->buf, st_template.st_mode))
>  				die_errno(_("cannot copy '%s' to '%s'"),
>  					  template_path->buf, path->buf);
> * js/fix-clone-w-hooks-2.43
> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> remerge CONFLICT (content): Merge conflict in t/t1800-hook.sh
> index 1283a9bd47..c51be5f7a0 100755
> --- a/t/t1800-hook.sh
> +++ b/t/t1800-hook.sh
> @@ -191,24 +191,7 @@ test_expect_success '`safe.hook.sha256` and clone p=
rotections' '
>  	echo "called hook" >safe-hook.log
>  	EOF
>
> -<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< 1f2e64e22d (Git 2.43.4)
> -	git hook run test-hook 2>err &&
> -	test_grep "Hook ran" err &&
> -|||||||||||||||||||||||||||||||| babb4e5d71
> -	git hook run test-hook 2>err &&
> -	grep "Hook ran" err &&
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 0268cf79cb (Merge branch 'js/fix-clone=
-w-hooks-2.41' into HEAD)
>  	test_must_fail env GIT_CLONE_PROTECTION_ACTIVE=3Dtrue \
> -<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< 1f2e64e22d (Git 2.43.4)
> -		git hook run test-hook 2>err &&
> -	test_grep "active .core.hooksPath" err &&
> -	test_grep ! "Hook ran" err
> -|||||||||||||||||||||||||||||||| babb4e5d71
> -		git hook run test-hook 2>err &&
> -	grep "active .core.hooksPath" err &&
> -	! grep "Hook ran" err
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  		git -C safe-hook hook run pre-push 2>err &&
>  	cmd=3D"$(grep "git config --global --add safe.hook.sha256 [0-9a-f]" er=
r)" &&
>  	eval "$cmd" &&
> @@ -235,7 +218,6 @@ test_expect_success 'Git LFS special-handling in clo=
ne protections' '
>  		git -C lfs-hooks hook run pre-push &&
>  	test_write_lines "called pre-push" >expect &&
>  	test_cmp lfs-hooks/fake-git-lfs.log expect
> ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 0268cf79cb (Merge branch 'js/fix-clone=
-w-hooks-2.41' into HEAD)
>  '
>
>  test_done
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 6ee833bac2..0fcfe6f2ce 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -835,7 +835,7 @@ test_expect_success 'clone with init.templatedir run=
s hooks' '
>  		git -c init.templateDir=3D"$(pwd)/tmpl" \
>  			clone --recurse-submodules \
>  			tmpl/hooks hook-run-submodule 2>err &&
> -		! grep "active .* hook found" err &&
> +		test_grep ! "active .* hook found" err &&
>  		test_path_is_file hook-run-submodule/hook.run &&
>  		test_path_is_file hook-run-submodule/sub/hook.run
>  	)
> * js/fix-clone-w-hooks-2.44* js/fix-clone-w-hooks-2.45
>
