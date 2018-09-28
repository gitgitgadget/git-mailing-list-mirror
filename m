Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28ECB1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 17:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbeI1Xz0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 19:55:26 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:41933 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1XzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 19:55:25 -0400
Received: by mail-ua1-f74.google.com with SMTP id x18-v6so1464577uan.8
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 10:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WkktSFgWJ2HW7A94SMtrYk5kLohJHZFYV2RleMcw57k=;
        b=WfCq/d7cG2k9tgHEtrDzp1cQ9PWoqHifOHTZ60oWnRl2Js96Us6cSdcM63IeXck3xC
         hZr0CYYChOYUwE2KtFr+LeqRnjzKxu9CBjyFTMuCn0ectT8DPfpne/LGAHHJcth+jyyA
         53NbkRCOesYYjXWMPmjUmw/+Ty6qtkD7J9Q0FeaFiP1tMBAfRoORHgD7JudEbJ1sv8uU
         Gi6H70R24PZ9bzD6ZT7NNV5MtQ9IKde1GI7/zQk3VesIgKCefp3TM6duByIpktzkUqTC
         U1lXg2M9wozIJEABIfvTxtIFFGe1qeOM/OdcRNFp1MZuPYlyLl33zwBFgXyr6VyjgBs3
         rdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WkktSFgWJ2HW7A94SMtrYk5kLohJHZFYV2RleMcw57k=;
        b=lYpBX5HWbaddz36d3RpoiDu9fn5JW71M/gsrVLpgo2DWU46QvSx/z00t6+8kUwijnL
         h3cJmv6I1f5CH4cJRfYyGfJy6INYE8G5VfjQ5EBwIwBGzkIGF+IghHUfLrFII/GGZnYG
         6vVHrvh7UDbQ0bvmQXr2nsfx9zn8J4R3JuIectAWFRwikRsgx2md9WGFhjhvS5+bm+QB
         pNSwf3ubCtvwTbJd4G0cX5Q6Rk3AIOfuiEbDcqGrBw+7gQquQEzcQ39lT4WR+xUcs5gp
         c9el14zYHjcVhiAt21ARMh2Fv9EC7MLwE2KuqcdTWpyoFUO19Rhbthwy1D37zHIy8Due
         IYug==
X-Gm-Message-State: ABuFfoh1cGtDFmNuqdD4wkjVMxnr2AxT/frYWX/6i0Cxdag2DBi6492C
        74lUEYZ28uhwb9hG3WAoq/QXX2Si1zOl
X-Google-Smtp-Source: ACcGV62miNm85k0RpZU21ovlH8Ul1QFo8zZrvy2HL4lo0vNzcDPJ01NI512IuMIcZdD7mXpROqsiS7guqTlk
X-Received: by 2002:ab0:7651:: with SMTP id s17-v6mr3084288uaq.4.1538155836995;
 Fri, 28 Sep 2018 10:30:36 -0700 (PDT)
Date:   Fri, 28 Sep 2018 10:30:33 -0700
In-Reply-To: <xmqq5zypefcp.fsf@gitster-ct.c.googlers.com>
Message-Id: <20180928173033.159192-1-sbeller@google.com>
Mime-Version: 1.0
References: <xmqq5zypefcp.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH] strbuf.h: format according to coding guidelines
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, git@vger.kernel.org, jrnieder@gmail.com,
        peff@peff.net, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous patch suggested the strbuf header to be the leading example
of how we would want our APIs to be documented. This may lead to some
scrutiny of that code and the coding style (which is different from the
API documentation style) and hence might be taken as an example on how
to format code as well.

So let's format strbuf.h in a way that we'd like to see:
* omit the extern keyword from function declarations
* name all parameters (usually the parameters are obvious from its type,
  but consider exceptions like
  `int strbuf_getwholeline_fd(struct strbuf *, int, int);`
* break overly long lines

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Maybe this on top of Junios guideline patch?

Thanks,
Stefan

 strbuf.h | 148 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 81 insertions(+), 67 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index 60a35aef16..bf18fddb5b 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -87,7 +87,7 @@ struct object_id;
  * Initialize the structure. The second parameter can be zero or a bigger
  * number to allocate memory, in case you want to prevent further reallocs.
  */
-extern void strbuf_init(struct strbuf *, size_t);
+void strbuf_init(struct strbuf *sb, size_t alloc);
 
 /**
  * Release a string buffer and the memory it used. After this call, the
@@ -97,7 +97,7 @@ extern void strbuf_init(struct strbuf *, size_t);
  * To clear a strbuf in preparation for further use without the overhead
  * of free()ing and malloc()ing again, use strbuf_reset() instead.
  */
-extern void strbuf_release(struct strbuf *);
+void strbuf_release(struct strbuf *sb);
 
 /**
  * Detach the string from the strbuf and returns it; you now own the
@@ -107,7 +107,7 @@ extern void strbuf_release(struct strbuf *);
  * The strbuf that previously held the string is reset to `STRBUF_INIT` so
  * it can be reused after calling this function.
  */
-extern char *strbuf_detach(struct strbuf *, size_t *);
+char *strbuf_detach(struct strbuf *sb, size_t *sz);
 
 /**
  * Attach a string to a buffer. You should specify the string to attach,
@@ -117,7 +117,7 @@ extern char *strbuf_detach(struct strbuf *, size_t *);
  * malloc()ed, and after attaching, the pointer cannot be relied upon
  * anymore, and neither be free()d directly.
  */
-extern void strbuf_attach(struct strbuf *, void *, size_t, size_t);
+void strbuf_attach(struct strbuf *sb, void *str, size_t len, size_t mem);
 
 /**
  * Swap the contents of two string buffers.
@@ -148,7 +148,7 @@ static inline size_t strbuf_avail(const struct strbuf *sb)
  * This is never a needed operation, but can be critical for performance in
  * some cases.
  */
-extern void strbuf_grow(struct strbuf *, size_t);
+void strbuf_grow(struct strbuf *sb, size_t amount);
 
 /**
  * Set the length of the buffer to a given value. This function does *not*
@@ -183,30 +183,30 @@ static inline void strbuf_setlen(struct strbuf *sb, size_t len)
  * Strip whitespace from the beginning (`ltrim`), end (`rtrim`), or both side
  * (`trim`) of a string.
  */
-extern void strbuf_trim(struct strbuf *);
-extern void strbuf_rtrim(struct strbuf *);
-extern void strbuf_ltrim(struct strbuf *);
+void strbuf_trim(struct strbuf *sb);
+void strbuf_rtrim(struct strbuf *sb);
+void strbuf_ltrim(struct strbuf *sb);
 
 /* Strip trailing directory separators */
-extern void strbuf_trim_trailing_dir_sep(struct strbuf *);
+void strbuf_trim_trailing_dir_sep(struct strbuf *sb);
 
 /**
  * Replace the contents of the strbuf with a reencoded form.  Returns -1
  * on error, 0 on success.
  */
-extern int strbuf_reencode(struct strbuf *sb, const char *from, const char *to);
+int strbuf_reencode(struct strbuf *sb, const char *from, const char *to);
 
 /**
  * Lowercase each character in the buffer using `tolower`.
  */
-extern void strbuf_tolower(struct strbuf *sb);
+void strbuf_tolower(struct strbuf *sb);
 
 /**
  * Compare two buffers. Returns an integer less than, equal to, or greater
  * than zero if the first buffer is found, respectively, to be less than,
  * to match, or be greater than the second buffer.
  */
-extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
+int strbuf_cmp(const struct strbuf *first, const struct strbuf *second);
 
 
 /**
@@ -233,37 +233,38 @@ static inline void strbuf_addch(struct strbuf *sb, int c)
 /**
  * Add a character the specified number of times to the buffer.
  */
-extern void strbuf_addchars(struct strbuf *sb, int c, size_t n);
+void strbuf_addchars(struct strbuf *sb, int c, size_t n);
 
 /**
  * Insert data to the given position of the buffer. The remaining contents
  * will be shifted, not overwritten.
  */
-extern void strbuf_insert(struct strbuf *, size_t pos, const void *, size_t);
+void strbuf_insert(struct strbuf *sb, size_t pos, const void *, size_t);
 
 /**
  * Remove given amount of data from a given position of the buffer.
  */
-extern void strbuf_remove(struct strbuf *, size_t pos, size_t len);
+void strbuf_remove(struct strbuf *sb, size_t pos, size_t len);
 
 /**
  * Remove the bytes between `pos..pos+len` and replace it with the given
  * data.
  */
-extern void strbuf_splice(struct strbuf *, size_t pos, size_t len,
-			  const void *, size_t);
+void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
+		   const void *data, size_t data_len);
 
 /**
  * Add a NUL-terminated string to the buffer. Each line will be prepended
  * by a comment character and a blank.
  */
-extern void strbuf_add_commented_lines(struct strbuf *out, const char *buf, size_t size);
+void strbuf_add_commented_lines(struct strbuf *out,
+				const char *buf, size_t size);
 
 
 /**
  * Add data of given length to the buffer.
  */
-extern void strbuf_add(struct strbuf *, const void *, size_t);
+void strbuf_add(struct strbuf *sb, const void *data, size_t len);
 
 /**
  * Add a NUL-terminated string to the buffer.
@@ -282,7 +283,7 @@ static inline void strbuf_addstr(struct strbuf *sb, const char *s)
 /**
  * Copy the contents of another buffer at the end of the current one.
  */
-extern void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2);
+void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2);
 
 /**
  * This function can be used to expand a format string containing
@@ -308,8 +309,13 @@ extern void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2);
  * parameters to the callback, `strbuf_expand()` passes a context pointer,
  * which can be used by the programmer of the callback as she sees fit.
  */
-typedef size_t (*expand_fn_t) (struct strbuf *sb, const char *placeholder, void *context);
-extern void strbuf_expand(struct strbuf *sb, const char *format, expand_fn_t fn, void *context);
+typedef size_t (*expand_fn_t) (struct strbuf *sb,
+			       const char *placeholder,
+			       void *context);
+void strbuf_expand(struct strbuf *sb,
+		   const char *format,
+		   expand_fn_t fn,
+		   void *context);
 
 /**
  * Used as callback for `strbuf_expand()`, expects an array of
@@ -321,7 +327,9 @@ struct strbuf_expand_dict_entry {
 	const char *placeholder;
 	const char *value;
 };
-extern size_t strbuf_expand_dict_cb(struct strbuf *sb, const char *placeholder, void *context);
+size_t strbuf_expand_dict_cb(struct strbuf *sb,
+			     const char *placeholder,
+			     void *context);
 
 /**
  * Append the contents of one strbuf to another, quoting any
@@ -329,29 +337,29 @@ extern size_t strbuf_expand_dict_cb(struct strbuf *sb, const char *placeholder,
  * destination. This is useful for literal data to be fed to either
  * strbuf_expand or to the *printf family of functions.
  */
-extern void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src);
+void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src);
 
 /**
  * Append the given byte size as a human-readable string (i.e. 12.23 KiB,
  * 3.50 MiB).
  */
-extern void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes);
+void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes);
 
 /**
  * Add a formatted string to the buffer.
  */
 __attribute__((format (printf,2,3)))
-extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
+void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
 
 /**
  * Add a formatted string prepended by a comment character and a
  * blank to the buffer.
  */
 __attribute__((format (printf, 2, 3)))
-extern void strbuf_commented_addf(struct strbuf *sb, const char *fmt, ...);
+void strbuf_commented_addf(struct strbuf *sb, const char *fmt, ...);
 
 __attribute__((format (printf,2,0)))
-extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
+void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
 
 /**
  * Add the time specified by `tm`, as formatted by `strftime`.
@@ -361,9 +369,9 @@ extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
  * `suppress_tz_name`, when set, expands %Z internally to the empty
  * string rather than passing it to `strftime`.
  */
-extern void strbuf_addftime(struct strbuf *sb, const char *fmt,
-			    const struct tm *tm, int tz_offset,
-			    int suppress_tz_name);
+void strbuf_addftime(struct strbuf *sb, const char *fmt,
+		    const struct tm *tm, int tz_offset,
+		    int suppress_tz_name);
 
 /**
  * Read a given size of data from a FILE* pointer to the buffer.
@@ -373,14 +381,14 @@ extern void strbuf_addftime(struct strbuf *sb, const char *fmt,
  * `strbuf_read()`, `strbuf_read_file()` and `strbuf_getline_*()`
  * family of functions have the same behaviour as well.
  */
-extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
+size_t strbuf_fread(struct strbuf *sb, size_t size, FILE *file);
 
 /**
  * Read the contents of a given file descriptor. The third argument can be
  * used to give a hint about the file size, to avoid reallocs.  If read fails,
  * any partial read is undone.
  */
-extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
+ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint);
 
 /**
  * Read the contents of a given file descriptor partially by using only one
@@ -388,7 +396,7 @@ extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
  * file size, to avoid reallocs. Returns the number of new bytes appended to
  * the sb.
  */
-extern ssize_t strbuf_read_once(struct strbuf *, int fd, size_t hint);
+ssize_t strbuf_read_once(struct strbuf *sb, int fd, size_t hint);
 
 /**
  * Read the contents of a file, specified by its path. The third argument
@@ -396,19 +404,19 @@ extern ssize_t strbuf_read_once(struct strbuf *, int fd, size_t hint);
  * Return the number of bytes read or a negative value if some error
  * occurred while opening or reading the file.
  */
-extern ssize_t strbuf_read_file(struct strbuf *sb, const char *path, size_t hint);
+ssize_t strbuf_read_file(struct strbuf *sb, const char *path, size_t hint);
 
 /**
  * Read the target of a symbolic link, specified by its path.  The third
  * argument can be used to give a hint about the size, to avoid reallocs.
  */
-extern int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
+int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
 
 /**
  * Write the whole content of the strbuf to the stream not stopping at
  * NUL bytes.
  */
-extern ssize_t strbuf_write(struct strbuf *sb, FILE *stream);
+ssize_t strbuf_write(struct strbuf *sb, FILE *stream);
 
 /**
  * Read a line from a FILE *, overwriting the existing contents of
@@ -422,10 +430,10 @@ extern ssize_t strbuf_write(struct strbuf *sb, FILE *stream);
 typedef int (*strbuf_getline_fn)(struct strbuf *, FILE *);
 
 /* Uses LF as the line terminator */
-extern int strbuf_getline_lf(struct strbuf *sb, FILE *fp);
+int strbuf_getline_lf(struct strbuf *sb, FILE *fp);
 
 /* Uses NUL as the line terminator */
-extern int strbuf_getline_nul(struct strbuf *sb, FILE *fp);
+int strbuf_getline_nul(struct strbuf *sb, FILE *fp);
 
 /*
  * Similar to strbuf_getline_lf(), but additionally treats a CR that
@@ -434,14 +442,14 @@ extern int strbuf_getline_nul(struct strbuf *sb, FILE *fp);
  * that can come from platforms whose native text format is CRLF
  * terminated.
  */
-extern int strbuf_getline(struct strbuf *, FILE *);
+int strbuf_getline(struct strbuf *sb, FILE *file);
 
 
 /**
  * Like `strbuf_getline`, but keeps the trailing terminator (if
  * any) in the buffer.
  */
-extern int strbuf_getwholeline(struct strbuf *, FILE *, int);
+int strbuf_getwholeline(struct strbuf *sb, FILE *file, int term);
 
 /**
  * Like `strbuf_getwholeline`, but operates on a file descriptor.
@@ -449,19 +457,19 @@ extern int strbuf_getwholeline(struct strbuf *, FILE *, int);
  * use it unless you need the correct position in the file
  * descriptor.
  */
-extern int strbuf_getwholeline_fd(struct strbuf *, int, int);
+int strbuf_getwholeline_fd(struct strbuf *sb, int fd, int term);
 
 /**
  * Set the buffer to the path of the current working directory.
  */
-extern int strbuf_getcwd(struct strbuf *sb);
+int strbuf_getcwd(struct strbuf *sb);
 
 /**
  * Add a path to a buffer, converting a relative path to an
  * absolute one in the process.  Symbolic links are not
  * resolved.
  */
-extern void strbuf_add_absolute_path(struct strbuf *sb, const char *path);
+void strbuf_add_absolute_path(struct strbuf *sb, const char *path);
 
 /**
  * Canonize `path` (make it absolute, resolve symlinks, remove extra
@@ -475,7 +483,7 @@ extern void strbuf_add_absolute_path(struct strbuf *sb, const char *path);
  * Callers that don't mind links should use the more lightweight
  * strbuf_add_absolute_path() instead.
  */
-extern void strbuf_add_real_path(struct strbuf *sb, const char *path);
+void strbuf_add_real_path(struct strbuf *sb, const char *path);
 
 
 /**
@@ -483,13 +491,13 @@ extern void strbuf_add_real_path(struct strbuf *sb, const char *path);
  * normalize_path_copy() for details. If an error occurs, the contents of "sb"
  * are left untouched, and -1 is returned.
  */
-extern int strbuf_normalize_path(struct strbuf *sb);
+int strbuf_normalize_path(struct strbuf *sb);
 
 /**
  * Strip whitespace from a buffer. The second parameter controls if
  * comments are considered contents to be removed or not.
  */
-extern void strbuf_stripspace(struct strbuf *buf, int skip_comments);
+void strbuf_stripspace(struct strbuf *buf, int skip_comments);
 
 static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
 {
@@ -518,8 +526,8 @@ static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
  * For lighter-weight alternatives, see string_list_split() and
  * string_list_split_in_place().
  */
-extern struct strbuf **strbuf_split_buf(const char *, size_t,
-					int terminator, int max);
+struct strbuf **strbuf_split_buf(const char *str, size_t len,
+				 int terminator, int max);
 
 static inline struct strbuf **strbuf_split_str(const char *str,
 					       int terminator, int max)
@@ -528,7 +536,7 @@ static inline struct strbuf **strbuf_split_str(const char *str,
 }
 
 static inline struct strbuf **strbuf_split_max(const struct strbuf *sb,
-						int terminator, int max)
+					       int terminator, int max)
 {
 	return strbuf_split_buf(sb->buf, sb->len, terminator, max);
 }
@@ -549,23 +557,23 @@ static inline struct strbuf **strbuf_split(const struct strbuf *sb,
  *   'element1, element2, ..., elementN'
  * to str.  If only one element, just write "element1" to str.
  */
-extern void strbuf_add_separated_string_list(struct strbuf *str,
-					     const char *sep,
-					     struct string_list *slist);
+void strbuf_add_separated_string_list(struct strbuf *str,
+				      const char *sep,
+				      struct string_list *slist);
 
 /**
  * Free a NULL-terminated list of strbufs (for example, the return
  * values of the strbuf_split*() functions).
  */
-extern void strbuf_list_free(struct strbuf **);
+void strbuf_list_free(struct strbuf **list);
 
 /**
  * Add the abbreviation, as generated by find_unique_abbrev, of `sha1` to
  * the strbuf `sb`.
  */
-extern void strbuf_add_unique_abbrev(struct strbuf *sb,
-				     const struct object_id *oid,
-				     int abbrev_len);
+void strbuf_add_unique_abbrev(struct strbuf *sb,
+			      const struct object_id *oid,
+			      int abbrev_len);
 
 /**
  * Launch the user preferred editor to edit a file and fill the buffer
@@ -574,15 +582,21 @@ extern void strbuf_add_unique_abbrev(struct strbuf *sb,
  * run in. If the buffer is NULL the editor is launched as usual but the
  * file's contents are not read into the buffer upon completion.
  */
-extern int launch_editor(const char *path, struct strbuf *buffer, const char *const *env);
+int launch_editor(const char *path,
+		  struct strbuf *buffer,
+		  const char *const *env);
 
-extern void strbuf_add_lines(struct strbuf *sb, const char *prefix, const char *buf, size_t size);
+void strbuf_add_lines(struct strbuf *sb,
+		      const char *prefix,
+		      const char *buf,
+		      size_t size);
 
 /**
  * Append s to sb, with the characters '<', '>', '&' and '"' converted
  * into XML entities.
  */
-extern void strbuf_addstr_xml_quoted(struct strbuf *sb, const char *s);
+void strbuf_addstr_xml_quoted(struct strbuf *sb,
+			      const char *s);
 
 /**
  * "Complete" the contents of `sb` by ensuring that either it ends with the
@@ -612,8 +626,8 @@ static inline void strbuf_complete_line(struct strbuf *sb)
  * If "allowed" is non-zero, restrict the set of allowed expansions. See
  * interpret_branch_name() for details.
  */
-extern void strbuf_branchname(struct strbuf *sb, const char *name,
-			      unsigned allowed);
+void strbuf_branchname(struct strbuf *sb, const char *name,
+		       unsigned allowed);
 
 /*
  * Like strbuf_branchname() above, but confirm that the result is
@@ -621,15 +635,15 @@ extern void strbuf_branchname(struct strbuf *sb, const char *name,
  *
  * The return value is "0" if the result is valid, and "-1" otherwise.
  */
-extern int strbuf_check_branch_ref(struct strbuf *sb, const char *name);
+int strbuf_check_branch_ref(struct strbuf *sb, const char *name);
 
-extern void strbuf_addstr_urlencode(struct strbuf *, const char *,
-				    int reserved);
+void strbuf_addstr_urlencode(struct strbuf *sb, const char *name,
+			     int reserved);
 
 __attribute__((format (printf,1,2)))
-extern int printf_ln(const char *fmt, ...);
+int printf_ln(const char *fmt, ...);
 __attribute__((format (printf,2,3)))
-extern int fprintf_ln(FILE *fp, const char *fmt, ...);
+int fprintf_ln(FILE *fp, const char *fmt, ...);
 
 char *xstrdup_tolower(const char *);
 char *xstrdup_toupper(const char *);
-- 
2.19.0

