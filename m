Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7117F1E8342
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785156683; cv=none; b=iz23SQekvTD1xzob3gQt5W9st8VAjfNBRjc2x6fCc1b/hP+hLNFNGG8c9+W5In47Q+kmBYicWsLI9ttBILCD8y6y7lIT8a3jZ5KQtGxiMWRW4xPGv8S5T2YM63YenJzYDFis1kt8bWg4bWJlNiFPG+WVuAyJT9tOHIZjSjaUnVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785156683; c=relaxed/simple;
	bh=nsdO8w8gNyM5VmESN0rqNnV9FP5zWD7ml+7Hg74aX2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=DjCsBQSAq2PjfbUKFFsGyBUTNo7kFmrN0vPRlVe1CooGsRqU8hGs30+NSOXmCqVufOf1wQyFHFNe8L1x3EAFujY2zF1nLnm88Xs5EeyNzMaKhmGWHVHjI2zI9YOOeHCm8lfV3kmbV1owKPcQXUtrNIBttECY0o0yu0K4HW2Hsbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixixwkiq; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixixwkiq"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso5208761a12.0
        for <git@vger.kernel.org>; Mon, 27 Jul 2026 05:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785156680; x=1785761480; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:cc:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jgZAE39BbjAAFGdpK/MuLJ+UlzXgkzMoCe4a5g/+1A8=;
        b=ixixwkiqXv/y5NLjAZVIR/cH5uAf31uUgJWwEHsz/9sWveg1fmypWi2WO3HEykSYkh
         iqfRaP8pgAjoJHzYaUG+rg1LgGyRn+jBe0DFkQT6d0bQy2JADx9Em5ZvkEXcFrA+C/CV
         XOMZpFxS886t/ULkbFMSesRChz3x0CTf28ZUx+60NxVWNhYUJyumXd0wGQB3Le8Kwyk9
         0n57xyrCLbkxqs4WTO54IxWPfwsKET9mFCmYAauoUnXpxc4E6qqvoIxUvsb7P5HkhNJy
         ZR0PzcXWIaVSE46ujaItZP6b55LRXNNsyl4Zi41ih8LGFeN6j13YAmNmGz7FCv/TLi+f
         a+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785156680; x=1785761480;
        h=content-transfer-encoding:content-type:in-reply-to:cc:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jgZAE39BbjAAFGdpK/MuLJ+UlzXgkzMoCe4a5g/+1A8=;
        b=EBrFS+mKLn8PP/jXJh9tg3YB8Iu0x7wJ1nPpBGdzod85DOGB24N83MDPT5B2TM9sxy
         16y2XnHn3iS/VB3vL7SKrMGZbICSsMpZvetTH6zeBppQVpMrAt7vdeJ8a30r5Q62O7z1
         6qvGBhjRUk4Jr0bxE92IixFZjXLnaHxlWbScB0bNWOmxLiPhGvcp85sGJSgN+sbrnLal
         g5Cwm93VVRmRq0Gzw6p4/ml6fUv8YrhRMIWgwSzLpzpc/VQtQE9cMRq8IDx81byDG5dO
         Ui8LzHsiV8f7akelGbXNE3vr5VuiQR55TfZTmWgP8KU6ZdnzOPVDVES4CpvHhNiFOHJD
         +FiQ==
X-Forwarded-Encrypted: i=1; AHgh+RrK7FN7AHJPogxyrZmlf96u+4+h1eBI3XLTAUYAGDzBesRS9Nw0V1W04C/wHL8+O6itFw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/AjEsNkrRfIkmJog1iwi0TinLvboN4hTgywRWLEcRwt5iqcXE
	+kquR1hf5pjlyVltsFFMF5zLUmGRJTu+mH1aGPeAQPQ7p7/4CsmYmut6
X-Gm-Gg: AR+sD11CEQVIgmABpMSOZzCr2DyVOicrs7xRZ+1DOLularKaix6wYaCMf0CB2K+GzAC
	s7IbYSr17HYPSReCnymYPZ+TfOZ7yEE7QJ2rMMSRrpFaDaDnhk+31Ir01rNSkmAgOByu9xOsUHi
	cLyzso0DZdeNSTCDSB9SuflR2BBTJaQnseRtIsimukIrkiCZRi/DbAmb85iMGFqbgZsAWH6q8gF
	tUA060rTpW6glxvNbTQyxtREoVoeUmZO9fWLqan5rmnPWVUM0u4MVQWCabwCL2eh1urWiHEccR6
	0Hi9AbGagEqLsedmTWMcBdVS9yh38sE9YI00eywCXIG3TKcbPvJ99rBJfujyUsi/eTGhHGteVTQ
	nhV6ResKH+hJzIJLFvAFOSx+f8BSJK439rLWa28LD73CDj1icnjRt/o3T5rj0eg32K/aCKqsyId
	oI5S8AcCTc/t9mPNMFmpQG3LBqb+HHtEah+v8CmpKSh2VGAE4+d/Knq8n8zkFlRSj/zxml4qKTc
	sE=
X-Received: by 2002:a17:906:7955:b0:c12:8ede:77 with SMTP id a640c23a62f3a-c1f1fdd44ebmr356030866b.22.1785156679300;
        Mon, 27 Jul 2026 05:51:19 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:3d4c:17a4:abdd:f101? ([2a0a:ef40:17bb:9901:3d4c:17a4:abdd:f101])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f5e717da4sm49040566b.4.2026.07.27.05.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 05:51:18 -0700 (PDT)
Message-ID: <e971400e-6d23-463f-ae9c-a21d3c5a3563@gmail.com>
Date: Mon, 27 Jul 2026 13:51:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] utf8: make utf8_strwidth() and utf8_strnwidth() return
 size_t
To: Hardik Kumar <hardikxk@gmail.com>, git@vger.kernel.org
References: <20260726123427.173877-1-hardikxk@gmail.com>
 <20260727065917.469738-1-hardikxk@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Pablo Sabater <pabloosabaterr@gmail.com>
In-Reply-To: <20260727065917.469738-1-hardikxk@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Hardik

On 27/07/2026 07:59, Hardik Kumar wrote:
> 
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 48d5251..83e4dd6 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -564,7 +564,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent,
>   					name = ci.author_mail.buf;
>   				else
>   					name = ci.author.buf;
> -				pad = longest_author - utf8_strwidth(name);
> +				pad = longest_author - cast_size_t_to_int(utf8_strwidth(name));
>   				printf(" (%s%*s %10s",
>   				       name, pad, "",
>   				       format_time(ci.author_time,

To me this example perfectly illustrates why changing the return value 
of utf8_strwidth() is a bad idea. The return value is pretty much always 
used to calculate a padding to pass to printf() which expects an int. By 
changing the return value you're forcing all the callers to do the 
conversion themselves which is a bug waiting to happen. I'm also far 
from convinced that the conversions in this patch are complete: grepping 
for 'utf8_strn\{0,1\}width' turns up several calls which do not appear 
to be correctly converted here. For example:

builtin/worktree.c: display[i].width = utf8_strwidth(buf.buf);

where "width" is an int.

I think it would be much better to remove the TODO comment as Junio 
previously suggested and instead add some documentation to the function 
explaining (a) why it is appropriate for it to return an int; (b) why we 
must use the cast_size_t_to_int() helper to prevent overflows (see the 
commit that added that comment).

Thanks

Phillip

> @@ -685,9 +685,9 @@ static void find_alignment(struct blame_scoreboard *sb, int *option)
>   			suspect->commit->object.flags |= METAINFO_SHOWN;
>   			get_commit_info(suspect->commit, &ci);
>   			if (*option & OUTPUT_SHOW_EMAIL)
> -				num = utf8_strwidth(ci.author_mail.buf);
> +				num = cast_size_t_to_int(utf8_strwidth(ci.author_mail.buf));
>   			else
> -				num = utf8_strwidth(ci.author.buf);
> +				num = cast_size_t_to_int(utf8_strwidth(ci.author.buf));
>   			if (longest_author < num)
>   				longest_author = num;
>   			commit_info_destroy(&ci);
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 775a797..c4ae95f 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -850,7 +850,7 @@ static void display_ref_update(struct display_state *display_state, char code,
>   			display_state->shown_url = 1;
>   		}
>   
> -		width = (summary_width + strlen(summary) - gettext_width(summary));
> +		width = (summary_width + strlen(summary) - cast_size_t_to_int(gettext_width(summary)));
>   		remote = prettify_refname(remote);
>   		local = prettify_refname(local);
>   
> diff --git a/builtin/repo.c b/builtin/repo.c
> index 84e012f..9c7ad8c 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -371,7 +371,7 @@ static void stats_table_vaddf(struct stats_table *table,
>   
>   	strbuf_vaddf(&buf, format, ap);
>   	formatted_name = strbuf_detach(&buf, NULL);
> -	name_width = utf8_strwidth(formatted_name);
> +	name_width = cast_size_t_to_int(utf8_strwidth(formatted_name));
>   
>   	item = string_list_append_nodup(&table->rows, formatted_name);
>   	item->util = entry;
> @@ -387,12 +387,12 @@ static void stats_table_vaddf(struct stats_table *table,
>   		string_list_append_nodup(&table->annotations, strbuf_detach(&buf, NULL));
>   	}
>   	if (entry->value) {
> -		int value_width = utf8_strwidth(entry->value);
> +		int value_width = cast_size_t_to_int(utf8_strwidth(entry->value));
>   		if (value_width > table->value_col_width)
>   			table->value_col_width = value_width;
>   	}
>   	if (entry->unit) {
> -		int unit_width = utf8_strwidth(entry->unit);
> +		int unit_width = cast_size_t_to_int(utf8_strwidth(entry->unit));
>   		if (unit_width > table->unit_col_width)
>   			table->unit_col_width = unit_width;
>   	}
> @@ -582,8 +582,8 @@ static void stats_table_print_structure(const struct stats_table *table)
>   {
>   	const char *name_col_title = _("Repository structure");
>   	const char *value_col_title = _("Value");
> -	int title_name_width = utf8_strwidth(name_col_title);
> -	int title_value_width = utf8_strwidth(value_col_title);
> +	int title_name_width = cast_size_t_to_int(utf8_strwidth(name_col_title));
> +	int title_value_width = cast_size_t_to_int(utf8_strwidth(value_col_title));
>   	int name_col_width = table->name_col_width;
>   	int value_col_width = table->value_col_width;
>   	int unit_col_width = table->unit_col_width;
> diff --git a/column.c b/column.c
> index 93fae31..a63d040 100644
> --- a/column.c
> +++ b/column.c
> @@ -26,7 +26,7 @@ struct column_data {
>   /* return length of 's' in letters, ANSI escapes stripped */
>   static int item_length(const char *s)
>   {
> -	return utf8_strnwidth(s, strlen(s), 1);
> +	return cast_size_t_to_int(utf8_strnwidth(s, strlen(s), 1));
>   }
>   
>   /*
> diff --git a/diff.c b/diff.c
> index 589c196..205fedf 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2982,7 +2982,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>   			continue;
>   		}
>   		fill_print_name(file);
> -		len = utf8_strwidth(file->print_name);
> +		len = cast_size_t_to_int(utf8_strwidth(file->print_name));
>   		if (max_len < len)
>   			max_len = len;
>   
> @@ -3037,7 +3037,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>   	 * making the line longer than the maximum width.
>   	 */
>   	if (options->stat_width == -1)
> -		width = term_columns() - utf8_strnwidth(line_prefix, strlen(line_prefix), 1);
> +		width = term_columns() - cast_size_t_to_int(utf8_strnwidth(line_prefix, strlen(line_prefix), 1));
>   	else
>   		width = options->stat_width ? options->stat_width : 80;
>   	number_width = decimal_width(max_change) > number_width ?
> @@ -3108,7 +3108,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>   		 * "scale" the filename
>   		 */
>   		len = name_width;
> -		name_len = utf8_strwidth(name);
> +		name_len = cast_size_t_to_int(utf8_strwidth(name));
>   		if (name_width < name_len) {
>   			char *slash;
>   			prefix = "...";
> @@ -3123,7 +3123,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>   			if (slash)
>   				name = slash;
>   		}
> -		padding = len - utf8_strwidth(name);
> +		padding = len - cast_size_t_to_int(utf8_strwidth(name));
>   		if (padding < 0)
>   			padding = 0;
>   
> diff --git a/gettext.c b/gettext.c
> index 8d08a61..4d5d05e 100644
> --- a/gettext.c
> +++ b/gettext.c
> @@ -129,7 +129,7 @@ void git_setup_gettext(void)
>   }
>   
>   /* return the number of columns of string 's' in current locale */
> -int gettext_width(const char *s)
> +size_t gettext_width(const char *s)
>   {
>   	static int is_utf8 = -1;
>   	if (is_utf8 == -1)
> diff --git a/gettext.h b/gettext.h
> index 484cafa..f161a21 100644
> --- a/gettext.h
> +++ b/gettext.h
> @@ -31,7 +31,7 @@
>   #ifndef NO_GETTEXT
>   extern int git_gettext_enabled;
>   void git_setup_gettext(void);
> -int gettext_width(const char *s);
> +size_t gettext_width(const char *s);
>   #else
>   #define git_gettext_enabled (0)
>   static inline void git_setup_gettext(void)
> diff --git a/pretty.c b/pretty.c
> index d8a9f37..83d4e86 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1809,7 +1809,7 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
>   
>   	if (padding < 0) {
>   		const char *start = strrchr(sb->buf, '\n');
> -		int occupied;
> +		size_t occupied;
>   		if (!start)
>   			start = sb->buf;
>   		occupied = utf8_strnwidth(start, strlen(start), 1);
> @@ -1830,7 +1830,7 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
>   		placeholder++;
>   		total_consumed++;
>   	}
> -	len = utf8_strnwidth(local_sb.buf, local_sb.len, 1);
> +	len = cast_size_t_to_int(utf8_strnwidth(local_sb.buf, local_sb.len, 1));
>   
>   	if (c->flush_type == flush_left_and_steal) {
>   		const char *ch = sb->buf + sb->len - 1;
> diff --git a/utf8.c b/utf8.c
> index 96460cc..cefaefe 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -208,7 +208,7 @@ int utf8_width(const char **start, size_t *remainder_p)
>    * string, assuming that the string is utf8.  Returns strlen() instead
>    * if the string does not look like a valid utf8 string.
>    */
> -int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
> +size_t utf8_strnwidth(const char *string, size_t len, int skip_ansi)
>   {
>   	const char *orig = string;
>   	size_t width = 0;
> @@ -225,15 +225,10 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
>   		if (glyph_width > 0)
>   			width += glyph_width;
>   	}
> -
> -	/*
> -	 * TODO: fix the interface of this function and `utf8_strwidth()` to
> -	 * return `size_t` instead of `int`.
> -	 */
> -	return cast_size_t_to_int(string ? width : len);
> +	return string ? width : len;
>   }
>   
> -int utf8_strwidth(const char *string)
> +size_t utf8_strwidth(const char *string)
>   {
>   	return utf8_strnwidth(string, strlen(string), 0);
>   }
> @@ -821,7 +816,7 @@ void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int wid
>   		       const char *s)
>   {
>   	size_t slen = strlen(s);
> -	int display_len = utf8_strnwidth(s, slen, 0);
> +	size_t display_len = utf8_strnwidth(s, slen, 0);
>   	int utf8_compensation = slen - display_len;
>   
>   	if (display_len >= width) {
> diff --git a/utf8.h b/utf8.h
> index cf8ecb0..531e968 100644
> --- a/utf8.h
> +++ b/utf8.h
> @@ -7,8 +7,8 @@ typedef unsigned int ucs_char_t;  /* assuming 32bit int */
>   
>   size_t display_mode_esc_sequence_len(const char *s);
>   int utf8_width(const char **start, size_t *remainder_p);
> -int utf8_strnwidth(const char *string, size_t len, int skip_ansi);
> -int utf8_strwidth(const char *string);
> +size_t utf8_strnwidth(const char *string, size_t len, int skip_ansi);
> +size_t utf8_strwidth(const char *string);
>   int is_utf8(const char *text);
>   int is_encoding_utf8(const char *name);
>   int same_encoding(const char *, const char *);
> diff --git a/wt-status.c b/wt-status.c
> index 58461e0..672f83b 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -325,13 +325,13 @@ static const char *wt_status_diff_status_string(int status)
>   	}
>   }
>   
> -static int maxwidth(const char *(*label)(int), int minval, int maxval)
> +static size_t maxwidth(const char *(*label)(int), int minval, int maxval)
>   {
>   	int result = 0, i;
>   
>   	for (i = minval; i <= maxval; i++) {
>   		const char *s = label(i);
> -		int len = s ? utf8_strwidth(s) : 0;
> +		size_t len = s ? utf8_strwidth(s) : 0;
>   		if (len > result)
>   			result = len;
>   	}
> @@ -345,7 +345,7 @@ static void wt_longstatus_print_unmerged_data(struct wt_status *s,
>   	struct wt_status_change_data *d = it->util;
>   	struct strbuf onebuf = STRBUF_INIT;
>   	static char *padding;
> -	static int label_width;
> +	static size_t label_width;
>   	const char *one, *how;
>   	int len;
>   
> @@ -360,7 +360,7 @@ static void wt_longstatus_print_unmerged_data(struct wt_status *s,
>   	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
>   
>   	how = wt_status_unmerged_status_string(d->stagemask);
> -	len = label_width - utf8_strwidth(how);
> +	len = label_width - cast_size_t_to_int(utf8_strwidth(how));
>   	status_printf_more(s, c, "%s%.*s%s\n", how, len, padding, one);
>   	strbuf_release(&onebuf);
>   }
> @@ -429,7 +429,7 @@ static void wt_longstatus_print_change_data(struct wt_status *s,
>   	what = wt_status_diff_status_string(status);
>   	if (!what)
>   		BUG("unhandled diff status %c", status);
> -	len = label_width - utf8_strwidth(what);
> +	len = label_width - cast_size_t_to_int(utf8_strwidth(what));
>   	assert(len >= 0);
>   	if (one_name != two_name)
>   		status_printf_more(s, c, "%s%.*s%s -> %s",
> 
> base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca

