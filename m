Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0F402018F
	for <e@80x24.org>; Wed, 13 Jul 2016 16:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbcGMQDu (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 12:03:50 -0400
Received: from [74.125.82.67] ([74.125.82.67]:32866 "EHLO
	mail-wm0-f67.google.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750923AbcGMQDs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 12:03:48 -0400
Received: by mail-wm0-f67.google.com with SMTP id o80so6385570wme.0
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 09:03:27 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+yuv6NrdND6MNZOFxKqHxMf6vEGuo4q2e2IUM4OWz7k=;
        b=FmfP695upIdiRzJQpWxrKUTSrYcebrBR0cNAz2TcinsBhzw0X3EVD/nH1RW6yNA/w1
         NDAoyFSNvLXKZm54wl6f+Hs2WcsluBj1/rJZ4rncE/SoWEq3eYl7oeeAeAoo1FqA1oIH
         rQi8RcbbC+IJk7g/wjhmMohZ1kgWOk4sO1lKNGD3pKvZtpnk7I0ynqIPuHfDW/1mKDCz
         sfhIjYALehrZ8PAP11ymJ2y7Uockf+5oVg3eZmwqVNZu+jeiXhUD6e3ZHaSjJc0WYFVs
         NkA+Juyx/d6gpDGJUAXsytB8xDqNkym7oFSd1IjRhD7PHN/7KwEFYu32AijiKDfaNruu
         3xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+yuv6NrdND6MNZOFxKqHxMf6vEGuo4q2e2IUM4OWz7k=;
        b=JEIKyDl7p5dyRTavpSv9j0ykNLR6SnK/a37nuXfKkEZbwOAsYOLCg1K4tSIlF1rQ5t
         P0x2aM6jh8Z7YB9isdjGdJU+KCZ1eg6AHmaruRN9wwDJL9SGH/FZiCfiu0XQNzL2C8Lc
         sh0gUXuhYnGjixp2Q03EzYohhFIMmVKM8/sBtvTQXwvKqvWfFqcPZ5jEps4oQVkro940
         IP4agyumBpEwJzWeNwr8GumaMvjSMkhUSCPU/W77wXYVsQhvOdWMW0nTn6rnqnhZAciM
         TWGCXvErzoP9jTlfNjCjdey/zyOZiQpI6gK+DevVn+vsiWPat4q49HX3kD+4ZcZNivPs
         ig8w==
X-Gm-Message-State: ALyK8tKj66spNGeblUBXhO9zxr9PCVckOinnoljeLDxBOdljjMfvuZFgDH79lsbgJ5SYgg==
X-Received: by 10.194.51.105 with SMTP id j9mr1664164wjo.35.1468425772735;
        Wed, 13 Jul 2016 09:02:52 -0700 (PDT)
Received: from slxbook4.fritz.box (p508BA422.dip0.t-ipconnect.de. [80.139.164.34])
        by smtp.gmail.com with ESMTPSA id yp1sm1559114wjc.6.2016.07.13.09.02.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jul 2016 09:02:52 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 2/8] add smudgeToFile and cleanFromFile filter configs
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <1468277112-9909-3-git-send-email-joeyh@joeyh.name>
Date:	Wed, 13 Jul 2016 18:02:50 +0200
Cc:	git@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <1994A13B-DD56-4E60-8CBA-A7299A6D6703@gmail.com>
References: <1468277112-9909-1-git-send-email-joeyh@joeyh.name> <1468277112-9909-3-git-send-email-joeyh@joeyh.name>
To:	Joey Hess <joeyh@joeyh.name>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 12 Jul 2016, at 00:45, Joey Hess <joeyh@joeyh.name> wrote:
> 
> This adds new smudgeToFile and cleanFromFile filter commands,
> which are similar to smudge and clean but allow direct access to files on
> disk.
> 
> This interface can be much more efficient when operating on large files,
> because the whole file content does not need to be streamed through the
> filter. It even allows for things like cleanFromFile commands that avoid
> reading the whole content of the file, and for smudgeToFile commands that
> populate a work tree file using an efficient Copy On Write operation.
> 
> The new filter commands will not be used for all filtering. They are
> efficient to use when git add is adding a file, or when the work tree is
> being updated, but not a good fit when git is internally filtering blob
> objects in memory for eg, a diff.
> 
> So, a user who wants to use smudgeToFile should also provide a smudge
> command to be used in cases where smudgeToFile is not used. And ditto
> with cleanFromFile and clean. To avoid foot-shooting configurations, the
> new commands are not used unless the old commands are also configured.
> 
> That also ensures that a filter driver configuration that includes these
> new commands will work, although less efficiently, when used with an older
> version of git that does not support them.
> 
> Signed-off-by: Joey Hess <joeyh@joeyh.name>
> ---
> Documentation/config.txt        |  18 ++++++-
> Documentation/gitattributes.txt |  37 ++++++++++++++
> convert.c                       | 111 +++++++++++++++++++++++++++++++++++-----
> convert.h                       |  10 ++++
> 4 files changed, 160 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 19493aa..a55bed8 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1325,15 +1325,29 @@ format.useAutoBase::
> 	format-patch by default.
> 
> filter.<driver>.clean::
> -	The command which is used to convert the content of a worktree
> +	The command which is used as a filter to convert the content of a worktree
> 	file to a blob upon checkin.  See linkgit:gitattributes[5] for
> 	details.
> 
> filter.<driver>.smudge::
> -	The command which is used to convert the content of a blob
> +	The command which is used as a filter to convert the content of a blob
> 	object to a worktree file upon checkout.  See
> 	linkgit:gitattributes[5] for details.
> 
> +filter.<driver>.cleanFromFile::
> +	Similar to filter.<driver>.clean but the specified command
> +	directly accesses a worktree file on disk, rather than
> +	receiving the file content from standard input.
> +	Only used when filter.<driver>.clean is also configured.
> +	See linkgit:gitattributes[5] for details.
> +
> +filter.<driver>.smudgeToFile::
> +	Similar to filter.<driver>.smudge but the specified command
> +	writes the content of a blob directly to a worktree file,
> +	rather than to standard output.
> +	Only used when filter.<driver>.smudge is also configured.
> +	See linkgit:gitattributes[5] for details.
> +
> fsck.<msg-id>::
> 	Allows overriding the message type (error, warn or ignore) of a
> 	specific message ID such as `missingEmail`.
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index 197ece8..a58aafc 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -385,6 +385,43 @@ not exist, or may have different contents. So, smudge and clean commands
> should not try to access the file on disk, but only act as filters on the
> content provided to them on standard input.
> 
> +There are two extra commands "cleanFromFile" and "smudgeToFile", which
> +can optionally be set in a filter driver. These are similar to the "clean"
> +and "smudge" commands, but avoid needing to pipe the contents of files
> +through the filters, and instead read/write files in the filesystem.
> +This can be more efficient when using filters with large files that are not
> +directly stored in the repository.
> +
> +Both "cleanFromFile" and "smudgeToFile" are provided a path as an
> +added parameter after the configured command line.
> +
> +The "cleanFromFile" command is provided the path to the file that
> +it should clean. Like the "clean" command, it should output the cleaned
> +version to standard output.
> +
> +The "smudgeToFile" command is provided a path to the file that it
> +should write to. (This file will already exist, as an empty file that can
> +be written to or replaced.) Like the "smudge" command, "smudgeToFile"
> +is fed the blob object from its standard input.
> +
> +Some git operations that need to apply filters cannot use "cleanFromFile"
> +and "smudgeToFile", since the files are not present to disk. So, to avoid
> +inconsistent behavior, "cleanFromFile" will only be used if "clean" is
> +also configured, and "smudgeToFile" will only be used if "smudge" is also
> +configured.
> +
> +An example large file storage filter driver using cleanFromFile and
> +smudgeToFile follows:
> +
> +------------------------
> +[filter "bigfiles"]
> +	clean = store-bigfile --from-stdin
> +	cleanFromFile = store-bigfile --from-file
> +	smudge = retrieve-bigfile --to-stdout
> +	smudgeToFile = retrieve-bigfile --to-file
> +	required
Minor nit: Do we need "required" in the minimal example? Plus, all test
cases use "required = true" (I just learned about that short-hand version).


> +------------------------
> +
> Interaction between checkin/checkout attributes
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> diff --git a/convert.c b/convert.c
> index 214c99f..eb7774f 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -358,7 +358,8 @@ struct filter_params {
> 	unsigned long size;
> 	int fd;
> 	const char *cmd;
> -	const char *path;
> +	const char *path; /* Path within the git repository */
> +	const char *fspath; /* Path to file on disk */
Good comment here. However, I wonder if these two "path" variables
could be confused in other parts of this file.

I think with an additional apply_filter function you could avoid this
confusion and it would be easier for me to apply my "long running filter
patch" on top :-)
https://github.com/larsxschneider/git/blob/74e22bd4e0b505785fa8ffc2ef15721909635d1c/convert.c#L1143-L1146
https://github.com/larsxschneider/git/blob/74e22bd4e0b505785fa8ffc2ef15721909635d1c/convert.c#L402-L488

Thanks for this patch series,
Lars


> };
> 
> static int filter_buffer_or_fd(int in, int out, void *data)
> @@ -387,6 +388,15 @@ static int filter_buffer_or_fd(int in, int out, void *data)
> 	strbuf_expand(&cmd, params->cmd, strbuf_expand_dict_cb, &dict);
> 	strbuf_release(&path);
> 
> +	/* append fspath to the command if it's set, separated with a space */
> +	if (params->fspath) {
> +		struct strbuf fspath = STRBUF_INIT;
> +		sq_quote_buf(&fspath, params->fspath);
> +		strbuf_addstr(&cmd, " ");
> +		strbuf_addbuf(&cmd, &fspath);
> +		strbuf_release(&fspath);
> +	}
> +
> 	argv[0] = cmd.buf;
> 
> 	child_process.argv = argv;
> @@ -425,7 +435,8 @@ static int filter_buffer_or_fd(int in, int out, void *data)
> 	return (write_err || status);
> }
> 
> -static int apply_filter(const char *path, const char *src, size_t len, int fd,
> +static int apply_filter(const char *path, const char *fspath,
> +			const char *src, size_t len, int fd,
>                         struct strbuf *dst, const char *cmd)
> {
> 	/*
> @@ -454,6 +465,7 @@ static int apply_filter(const char *path, const char *src, size_t len, int fd,
> 	params.fd = fd;
> 	params.cmd = cmd;
> 	params.path = path;
> +	params.fspath = fspath;
> 
> 	fflush(NULL);
> 	if (start_async(&async))
> @@ -484,6 +496,8 @@ static struct convert_driver {
> 	struct convert_driver *next;
> 	const char *smudge;
> 	const char *clean;
> +	const char *smudge_to_file;
> +	const char *clean_from_file;
> 	int required;
> } *user_convert, **user_convert_tail;
> 
> @@ -510,8 +524,9 @@ static int read_convert_config(const char *var, const char *value, void *cb)
> 	}
> 
> 	/*
> -	 * filter.<name>.smudge and filter.<name>.clean specifies
> -	 * the command line:
> +	 * filter.<name>.smudge, filter.<name>.clean,
> +	 * filter.<name>.smudgeToFile, filter.<name>.cleanFromFile
> +	 * specifies the command line:
> 	 *
> 	 *	command-line
> 	 *
> @@ -524,6 +539,12 @@ static int read_convert_config(const char *var, const char *value, void *cb)
> 	if (!strcmp("clean", key))
> 		return git_config_string(&drv->clean, var, value);
> 
> +	if (!strcmp("smudgetofile", key))
> +		return git_config_string(&drv->smudge_to_file, var, value);
> +
> +	if (!strcmp("cleanfromfile", key))
> +		return git_config_string(&drv->clean_from_file, var, value);
> +
> 	if (!strcmp("required", key)) {
> 		drv->required = git_config_bool(var, value);
> 		return 0;
> @@ -821,7 +842,37 @@ int would_convert_to_git_filter_fd(const char *path)
> 	if (!ca.drv->required)
> 		return 0;
> 
> -	return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);
> +	return apply_filter(path, NULL, NULL, 0, -1, NULL, ca.drv->clean);
> +}
> +
> +int can_clean_from_file(const char *path)
> +{
> +	struct conv_attrs ca;
> +
> +	convert_attrs(&ca, path);
> +	if (!ca.drv)
> +		return 0;
> +
> +	/*
> +	 * Only use the cleanFromFile filter when the clean filter is also
> +	 * configured.
> +	 */
> +	return (ca.drv->clean_from_file && ca.drv->clean);
> +}
> +
> +int can_smudge_to_file(const char *path)
> +{
> +	struct conv_attrs ca;
> +
> +	convert_attrs(&ca, path);
> +	if (!ca.drv)
> +		return 0;
> +
> +	/*
> +	 * Only use the smudgeToFile filter when the smudge filter is also
> +	 * configured.
> +	 */
> +	return (ca.drv->smudge_to_file && ca.drv->smudge);
> }
> 
> const char *get_convert_attr_ascii(const char *path)
> @@ -864,7 +915,7 @@ int convert_to_git(const char *path, const char *src, size_t len,
> 		required = ca.drv->required;
> 	}
> 
> -	ret |= apply_filter(path, src, len, -1, dst, filter);
> +	ret |= apply_filter(path, NULL, src, len, -1, dst, filter);
> 	if (!ret && required)
> 		die("%s: clean filter '%s' failed", path, ca.drv->name);
> 
> @@ -889,14 +940,34 @@ void convert_to_git_filter_fd(const char *path, int fd, struct strbuf *dst,
> 	assert(ca.drv);
> 	assert(ca.drv->clean);
> 
> -	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv->clean))
> +	if (!apply_filter(path, NULL, NULL, 0, fd, dst, ca.drv->clean))
> 		die("%s: clean filter '%s' failed", path, ca.drv->name);
> 
> 	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action, checksafe);
> 	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
> }
> 
> -static int convert_to_working_tree_internal(const char *path, const char *src,
> +void convert_to_git_filter_from_file(const char *path, struct strbuf *dst,
> +				   enum safe_crlf checksafe)
> +{
> +	struct conv_attrs ca;
> +	convert_attrs(&ca, path);
> +
> +	assert(ca.drv);
> +	assert(ca.drv->clean);
> +	assert(ca.drv->clean_from_file);
> +
> +	if (!apply_filter(path, path, "", 0, -1, dst, ca.drv->clean_from_file))
> +		die("%s: cleanFromFile filter '%s' failed", path, ca.drv->name);
> +
> +	crlf_to_git(path, dst->buf, dst->len, dst, ca.crlf_action,
> +		checksafe);
> +	ident_to_git(path, dst->buf, dst->len, dst, ca.ident);
> +}
> +
> +static int convert_to_working_tree_internal(const char *path,
> +					    const char *destpath,
> +					    const char *src,
> 					    size_t len, struct strbuf *dst,
> 					    int normalizing)
> {
> @@ -907,7 +978,10 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
> 
> 	convert_attrs(&ca, path);
> 	if (ca.drv) {
> -		filter = ca.drv->smudge;
> +		if (destpath)
> +			filter = ca.drv->smudge_to_file;
> +		else
> +			filter = ca.drv->smudge;
> 		required = ca.drv->required;
> 	}
> 
> @@ -918,7 +992,7 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
> 	}
> 	/*
> 	 * CRLF conversion can be skipped if normalizing, unless there
> -	 * is a smudge filter.  The filter might expect CRLFs.
> +	 * is a filter.  The filter might expect CRLFs.
> 	 */
> 	if (filter || !normalizing) {
> 		ret |= crlf_to_worktree(path, src, len, dst, ca.crlf_action);
> @@ -928,21 +1002,30 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
> 		}
> 	}
> 
> -	ret_filter = apply_filter(path, src, len, -1, dst, filter);
> +	ret_filter = apply_filter(path, destpath, src, len, -1, dst, filter);
> 	if (!ret_filter && required)
> -		die("%s: smudge filter %s failed", path, ca.drv->name);
> +		die("%s: %s filter %s failed", path, destpath ? "smudgeToFile" : "smudge", ca.drv->name);
> 
> 	return ret | ret_filter;
> }
> 
> int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst)
> {
> -	return convert_to_working_tree_internal(path, src, len, dst, 0);
> +	return convert_to_working_tree_internal(path, NULL, src, len, dst, 0);
> +}
> +
> +int convert_to_working_tree_filter_to_file(const char *path, const char *destpath, const char *src, size_t len)
> +{
> +	struct strbuf output = STRBUF_INIT;
> +	int ret = convert_to_working_tree_internal(path, destpath, src, len, &output, 0);
> +	/* The smudgeToFile filter stdout is not used. */
> +	strbuf_release(&output);
> +	return ret;
> }
> 
> int renormalize_buffer(const char *path, const char *src, size_t len, struct strbuf *dst)
> {
> -	int ret = convert_to_working_tree_internal(path, src, len, dst, 1);
> +	int ret = convert_to_working_tree_internal(path, NULL, src, len, dst, 1);
> 	if (ret) {
> 		src = dst->buf;
> 		len = dst->len;
> diff --git a/convert.h b/convert.h
> index 82871a1..6f46d10 100644
> --- a/convert.h
> +++ b/convert.h
> @@ -42,6 +42,10 @@ extern int convert_to_git(const char *path, const char *src, size_t len,
> 			  struct strbuf *dst, enum safe_crlf checksafe);
> extern int convert_to_working_tree(const char *path, const char *src,
> 				   size_t len, struct strbuf *dst);
> +extern int convert_to_working_tree_filter_to_file(const char *path,
> +						  const char *destpath,
> +						  const char *src,
> +						  size_t len);
> extern int renormalize_buffer(const char *path, const char *src, size_t len,
> 			      struct strbuf *dst);
> static inline int would_convert_to_git(const char *path)
> @@ -53,6 +57,12 @@ extern void convert_to_git_filter_fd(const char *path, int fd,
> 				     struct strbuf *dst,
> 				     enum safe_crlf checksafe);
> extern int would_convert_to_git_filter_fd(const char *path);
> +/* Precondition: can_clean_from_file(path) == true */
> +extern void convert_to_git_filter_from_file(const char *path,
> +					    struct strbuf *dst,
> +					    enum safe_crlf checksafe);
> +extern int can_clean_from_file(const char *path);
> +extern int can_smudge_to_file(const char *path);
> 
> /*****************************************************************
>  *
> -- 
> 2.8.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

