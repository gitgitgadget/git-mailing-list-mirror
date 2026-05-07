Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47DD3F23C0
	for <git@vger.kernel.org>; Thu,  7 May 2026 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778160270; cv=none; b=IAbdC+2AQv4tF7IyMY571Omsho/oKbV+cS3p7P4Kj8WfEx/jl8MX25ZfzyuZY+faSyKBqybiAni7cf9bAAkIZOt3TsRRytBhJeReclrfDNTKW25WWU8QjsT1+tWVvFSp1KJd6yvlwJQ+gubwLff6fVN9URpB5y91oD4ti6K8lFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778160270; c=relaxed/simple;
	bh=QfXyKolXtDLcSPk/8QRwjFOdhgZZp/XLjiwsIAJzHyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WMMKyS3IgWlbxBCQY3uemjJo0iFJ3w73XRRo5mKqoTa/rvJ0NFpe6VFYkmPV6dUYI63d9lXVzkDpXHbT4Fb9z8sRs3nAPunQgCRRNGMMjtrVawEj4Mrr3aHQYTHX/ZZiT8Bl597dKIxQaEhoavq2/7cqeEWGLseQT32eR7+mVOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtFyJf4n; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtFyJf4n"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48d102471a4so8813025e9.2
        for <git@vger.kernel.org>; Thu, 07 May 2026 06:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778160262; x=1778765062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d8GxO42HbanXSTppFTpz5hyj8hhdKMw6KDpF7OurTeo=;
        b=WtFyJf4nfoFr/rIw2c+Dj6B68OBJPJZwz6Q6h/44gFACiB09UF59iWUY3JLlzx6Ub0
         KhjUwwkJWQubwQiffA48qx6ZUK1D1BB5PnSzjH8tmKen4H2dFHtF8smZHIUHcsiqphbH
         0YCVJKFNWNcHGfczv26ZmC8hEoCvmOwgGM+DgbSN8jeplVIeEQB3NnzkUNWVK6aBF2UT
         mj39yjX+yhWpsIlK7QvYNmDNCNA3lgepkoPjiSEKUBKFdsSRSDps/hAKSNMHmE6NTFIC
         Y8aD7qTbmHRdSwDhikxwWNoCYp1iXHPyKplVNUh+wT+wklEVg66H7XUuT5AQnkd4OPMz
         WuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778160262; x=1778765062;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d8GxO42HbanXSTppFTpz5hyj8hhdKMw6KDpF7OurTeo=;
        b=q6xp6umVnjAee/mfGbqOaJD/DQOl+uXr5jgTYnpAbj2ULyCH3I3qthz/rH1U3J3/vB
         wMZJgwz/GZ2/XgnrWeuJruzHq6FrZdZeYQGkTB1qLeeAoKaZI3FR/AUbWcWIrgdfA2y6
         Err7d9LudBvUjMAEizUZ1RnBu55+evu9eRbT9mHi7NyvHKW53/wHAm+sg41spbTtXghM
         lIQnqhscZ+SMoz4zVf6X5pHC9JH7QPVtOKfWikSOtaeZJYVjhiXPG/Y5f3R9qf9aIL5r
         akgl7TCnMuBaru98Qiqkrmt8NUb/3sb2CSdlOd6OIVsqvQuVkAfczQYmvkKO/I3Q1Ydb
         oG6g==
X-Forwarded-Encrypted: i=1; AFNElJ9oscihB7K2UUEVDhoLn9fiqEuU/bO10XzYhZd+obEpCP/25aQwIz80Jcn4iAqIO/3AaD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxRxF9epFanKfcjtqV5alDni4pjCWN3P6fiov7QaeKt/rPG4lk
	r5hYnyVGddLD98qMbhJGghvPrJ+Dw202+3XirtprhlmA+GZExgQXQNo1
X-Gm-Gg: AeBDietxZpiz4tUqCu9FFa/gxALi/dkTBKrYsCbWx/Y3yKjVGAB7bhjRsQEkTH3PQY8
	AsZ9Epc4/0sZp22G3tZfa6MKgQ8kLHMUFdmwmqZZVEwXBKFqP1icRWN4216u1UTlrZ2QksB8dfM
	Sff0zMiIdjoKJBhiRbcUij+nlF3VdWOw8doLta6gqdkeD3GG7nNmEadLDLcoJEJU1p9cEujs0rA
	Q9VuSwhYl2otB3v14iMQBpFIPmhYZciQlWQgjCk+MnAg5YIVqNDC22yIVJVPGkbtKJgfKkCLlK3
	bQ8zf8j8PBtJjqUd1Dfnmw8ImOMgE/C/BH4cqlRIRwo2PuIZTPdgxKZXov/xMVEBMIUVacBDgLy
	eF0jTvZR5C1kY8pmw8HaWHEC/blpPrTQSgMJD+iu+gMnaKKwZTA7sNKnFC4qq/yHt1IpbaSt1BS
	GqJgwbT7LLtjRU5otCiLy2eqt+u55J/91RCZhFpKfT3QCLxMMzr5RXerkB3S8f6g+G+f7WE/l7N
	HG3Cw2J4kKDzMmq5LuuMA==
X-Received: by 2002:a05:600c:1504:b0:48a:525b:e148 with SMTP id 5b1f17b1804b1-48e51f1856dmr70877695e9.4.1778160262123;
        Thu, 07 May 2026 06:24:22 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:76d:4c01:bd41:1f83:652f:1d59? ([2a0a:ef40:76d:4c01:bd41:1f83:652f:1d59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538a517bsm134242055e9.4.2026.05.07.06.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 06:24:21 -0700 (PDT)
Message-ID: <e640ac2d-9e46-4f1e-9aef-deac80c65361@gmail.com>
Date: Thu, 7 May 2026 14:24:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] add -p: introduce 'w' command to view hunk with
 --word-diff
To: Javier Bassi <javierbassi@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>,
 Rene Scharfe <l.s.r@web.de>, Elijah Newren <newren@gmail.com>,
 Ruben Justo <rjusto@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <20260506235459.529862-1-javierbassi@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260506235459.529862-1-javierbassi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Javier

On 07/05/2026 00:54, Javier Bassi wrote:
> When using `git add --patch`, reviewing changes in long lines can be
> difficult with the default line-based diff. This is particularly
> noticeable in formats such as JSONP, CSV, LaTeX, Markdown, or other
> plain text where small inline edits can be hard to spot.
> 
> Added `w - print the current hunk with word-diff` during hunk selection
> to re-display the current hunk using `--word-diff`. This provides a
> clearer inline view of changes without modifying the hunk or affecting
> how patches are applied or staged.

I think this is useful. While one can set interactive.diffFilter to 
highlight intraline differences with "diff-highlight" or "delta" they do 
not cope well if the text has been reflowed.

I think the approach of using the current hunk text, rather than running 
"git diff --diff-words" is sensible because it works correctly if the 
user has edited the hunk and it makes it easy to handle hunks that have 
been split. It would be good to propagate the filename when creating the 
filespec so that we use the correct word diff regex for the file. We 
should also propagate the context and inter-hunk context settings from 
struct interactive_options. It would also be a good idea to reuse the 
hunk header from the unified diff so that the line numbers and hunk 
fragment are correct.

Thanks

Phillip

> Signed-off-by: Javier Bassi <javierbassi@gmail.com>
> ---
>   Documentation/git-add.adoc |   1 +
>   add-patch.c                | 105 ++++++++++++++++++++++++++++++++++++-
>   t/t3701-add-interactive.sh |  59 +++++++++++++--------
>   3 files changed, 142 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
> index 941135dc63..d2ee1cf9a9 100644
> --- a/Documentation/git-add.adoc
> +++ b/Documentation/git-add.adoc
> @@ -351,6 +351,7 @@ patch::
>          K - go to the previous hunk, roll over at the top
>          s - split the current hunk into smaller hunks
>          e - manually edit the current hunk
> +       w - print the current hunk with word-diff
>          p - print the current hunk
>          P - print the current hunk using the pager
>          ? - print help
> diff --git a/add-patch.c b/add-patch.c
> index f27edcbe8d..0364f4bc97 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -7,6 +7,7 @@
>   #include "commit.h"
>   #include "config.h"
>   #include "diff.h"
> +#include "diffcore.h"
>   #include "editor.h"
>   #include "environment.h"
>   #include "gettext.h"
> @@ -1508,6 +1509,105 @@ static void summarize_hunk(struct add_p_state *s, struct hunk *hunk,
>   	strbuf_complete_line(out);
>   }
>   
> +static void trim_trailing_lf(struct strbuf *buf)
> +{
> +	if (buf->len && buf->buf[buf->len - 1] == '\n')
> +		strbuf_setlen(buf, buf->len - 1);
> +}
> +
> +static void add_word_diff_line(struct strbuf *old, struct strbuf *new,
> +			       const char *line, size_t len, char marker)
> +{
> +	if (marker == '-' || marker == '+' || *line == ' ') {
> +		line++;
> +		len--;
> +	}
> +
> +	if (marker != '+')
> +		strbuf_add(old, line, len);
> +	if (marker != '-')
> +		strbuf_add(new, line, len);
> +}
> +
> +static void build_word_diff_files(struct add_p_state *s, struct hunk *hunk,
> +				  struct strbuf *old, struct strbuf *new)
> +{
> +	size_t i;
> +	char last_marker = '\0';
> +
> +	for (i = hunk->start; i < hunk->end; i = find_next_line(&s->plain, i)) {
> +		size_t next = find_next_line(&s->plain, i);
> +		char marker = normalize_marker(s->plain.buf + i);
> +
> +		if (marker == '\\') {
> +			if (last_marker != '+')
> +				trim_trailing_lf(old);
> +			if (last_marker != '-')
> +				trim_trailing_lf(new);
> +			continue;
> +		}
> +
> +		if (marker != ' ' && marker != '-' && marker != '+')
> +			BUG("unhandled diff marker: '%c'", marker);
> +
> +		add_word_diff_line(old, new, s->plain.buf + i, next - i,
> +				   marker);
> +		last_marker = marker;
> +	}
> +}
> +
> +static struct diff_filespec *word_diff_filespec(struct repository *r,
> +						const char *name,
> +						struct strbuf *buf)
> +{
> +	struct diff_filespec *spec = alloc_filespec(name);
> +	size_t size;
> +
> +	fill_filespec(spec, null_oid(r->hash_algo), 0, 0100644);
> +	spec->data = strbuf_detach(buf, &size);
> +	spec->size = size;
> +	spec->should_free = 1;
> +	spec->is_stdin = 1;
> +
> +	return spec;
> +}
> +
> +static void show_hunk_word_diff(struct add_p_state *s, struct hunk *hunk,
> +				int colored)
> +{
> +	struct hunk_header *header = &hunk->header;
> +	struct strbuf old = STRBUF_INIT, new = STRBUF_INIT;
> +	struct diff_options opts;
> +	struct diff_queue_struct queue;
> +
> +	if (!header->old_offset && !header->new_offset) {
> +		strbuf_reset(&s->buf);
> +		render_hunk(s, hunk, 0, colored, &s->buf);
> +		fputs(s->buf.buf, stdout);
> +		return;
> +	}
> +
> +	build_word_diff_files(s, hunk, &old, &new);
> +
> +	repo_diff_setup(s->r, &opts);
> +	opts.output_format = DIFF_FORMAT_PATCH;
> +	opts.use_color = colored ? s->cfg.use_color_diff : GIT_COLOR_NEVER;
> +	opts.word_diff = DIFF_WORDS_PLAIN;
> +	opts.context = header->old_count > header->new_count ?
> +		header->old_count : header->new_count;
> +	opts.flags.suppress_diff_headers = 1;
> +	diff_setup_done(&opts);
> +
> +	memcpy(&queue, &diff_queued_diff, sizeof(diff_queued_diff));
> +	diff_queue_init(&diff_queued_diff);
> +	diff_queue(&diff_queued_diff,
> +		   word_diff_filespec(s->r, "a", &old),
> +		   word_diff_filespec(s->r, "b", &new));
> +	diffcore_std(&opts);
> +	diff_flush(&opts);
> +	memcpy(&diff_queued_diff, &queue, sizeof(diff_queued_diff));
> +}
> +
>   #define DISPLAY_HUNKS_LINES 20
>   static size_t display_hunks(struct add_p_state *s,
>   			    struct file_diff *file_diff, size_t start_index)
> @@ -1540,6 +1640,7 @@ N_("j - go to the next undecided hunk, roll over at the bottom\n"
>      "/ - search for a hunk matching the given regex\n"
>      "s - split the current hunk into smaller hunks\n"
>      "e - manually edit the current hunk\n"
> +   "w - print the current hunk with word-diff\n"
>      "p - print the current hunk\n"
>      "P - print the current hunk using the pager\n"
>      "> - go to the next file, roll over at the bottom\n"
> @@ -1731,7 +1832,7 @@ static size_t patch_update_file(struct add_p_state *s,
>   				permitted |= ALLOW_GOTO_PREVIOUS_FILE;
>   				strbuf_addstr(&s->buf, ",<");
>   			}
> -			strbuf_addstr(&s->buf, ",p,P");
> +			strbuf_addstr(&s->buf, ",w,p,P");
>   		}
>   		if (file_diff->deleted)
>   			prompt_mode_type = PROMPT_DELETION;
> @@ -1953,6 +2054,8 @@ static size_t patch_update_file(struct add_p_state *s,
>   				hunk->use = USE_HUNK;
>   				goto soft_increment;
>   			}
> +		} else if (s->answer.buf[0] == 'w') {
> +			show_hunk_word_diff(s, hunk, colored);
>   		} else if (ch == 'p') {
>   			rendered_hunk_index = -1;
>   			use_pager = (s->answer.buf[0] == 'P') ? 1 : 0;
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 6e120a4001..e1ce98d62b 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -48,8 +48,8 @@ test_expect_success 'unknown command' '
>   	git add -N command &&
>   	git diff command >expect &&
>   	cat >>expect <<-EOF &&
> -	(1/1) Stage addition [y,n,q,a,d,e,p,P,?]? Unknown command ${SQ}W${SQ} (use ${SQ}?${SQ} for help)
> -	(1/1) Stage addition [y,n,q,a,d,e,p,P,?]?$SP
> +	(1/1) Stage addition [y,n,q,a,d,e,w,p,P,?]? Unknown command ${SQ}W${SQ} (use ${SQ}?${SQ} for help)
> +	(1/1) Stage addition [y,n,q,a,d,e,w,p,P,?]?$SP
>   	EOF
>   	git add -p -- command <command >actual 2>&1 &&
>   	test_cmp expect actual
> @@ -332,9 +332,9 @@ test_expect_success 'different prompts for mode change/deleted' '
>   	git -c core.filemode=true add -p >actual &&
>   	sed -n "s/^\(([0-9/]*) Stage .*?\).*/\1/p" actual >actual.filtered &&
>   	cat >expect <<-\EOF &&
> -	(1/1) Stage deletion [y,n,q,a,d,p,P,?]?
> -	(1/2) Stage mode change [y,n,q,a,d,k,K,j,J,g,/,p,P,?]?
> -	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,P,?]?
> +	(1/1) Stage deletion [y,n,q,a,d,w,p,P,?]?
> +	(1/2) Stage mode change [y,n,q,a,d,k,K,j,J,g,/,w,p,P,?]?
> +	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,w,p,P,?]?
>   	EOF
>   	test_cmp expect actual.filtered
>   '
> @@ -521,13 +521,13 @@ test_expect_success 'split hunk setup' '
>   test_expect_success 'goto hunk 1 with "g 1"' '
>   	test_when_finished "git reset" &&
>   	tr _ " " >expect <<-EOF &&
> -	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,P,?]? + 1:  -1,2 +1,3          +15
> +	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,w,p,P,?]? + 1:  -1,2 +1,3          +15
>   	_ 2:  -2,4 +3,8          +21
>   	go to which hunk? @@ -1,2 +1,3 @@
>   	_10
>   	+15
>   	_20
> -	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
> +	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]?_
>   	EOF
>   	test_write_lines s y g 1 | git add -p >actual &&
>   	tail -n 7 <actual >actual.trimmed &&
> @@ -540,7 +540,7 @@ test_expect_success 'goto hunk 1 with "g1"' '
>   	_10
>   	+15
>   	_20
> -	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
> +	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]?_
>   	EOF
>   	test_write_lines s y g1 | git add -p >actual &&
>   	tail -n 4 <actual >actual.trimmed &&
> @@ -550,11 +550,11 @@ test_expect_success 'goto hunk 1 with "g1"' '
>   test_expect_success 'navigate to hunk via regex /pattern' '
>   	test_when_finished "git reset" &&
>   	tr _ " " >expect <<-EOF &&
> -	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,P,?]? @@ -1,2 +1,3 @@
> +	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,w,p,P,?]? @@ -1,2 +1,3 @@
>   	_10
>   	+15
>   	_20
> -	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
> +	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]?_
>   	EOF
>   	test_write_lines s y /1,2 | git add -p >actual &&
>   	tail -n 5 <actual >actual.trimmed &&
> @@ -567,7 +567,7 @@ test_expect_success 'navigate to hunk via regex / pattern' '
>   	_10
>   	+15
>   	_20
> -	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
> +	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]?_
>   	EOF
>   	test_write_lines s y / 1,2 | git add -p >actual &&
>   	tail -n 4 <actual >actual.trimmed &&
> @@ -579,27 +579,42 @@ test_expect_success 'print again the hunk' '
>   	tr _ " " >expect <<-EOF &&
>   	+15
>   	 20
> -	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? @@ -1,2 +1,3 @@
> +	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]? @@ -1,2 +1,3 @@
>   	 10
>   	+15
>   	 20
> -	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
> +	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]?_
>   	EOF
>   	test_write_lines s y g 1 p | git add -p >actual &&
>   	tail -n 7 <actual >actual.trimmed &&
>   	test_cmp expect actual.trimmed
>   '
>   
> +test_expect_success 'print hunk with word-diff' '
> +	test_when_finished "rm -rf word-diff-repo" &&
> +	git init word-diff-repo &&
> +	(
> +		cd word-diff-repo &&
> +		test_write_lines "alpha old beta" context >word-diff &&
> +		git add word-diff &&
> +		git commit -m word-diff &&
> +		test_write_lines "alpha new beta" context >word-diff &&
> +		test_write_lines w n | git add -p word-diff >actual &&
> +		test_grep "alpha \\[-old-\\]{+new+} beta" actual &&
> +		git diff --cached --exit-code
> +	)
> +'
> +
>   test_expect_success TTY 'print again the hunk (PAGER)' '
>   	test_when_finished "git reset" &&
>   	cat >expect <<-EOF &&
>   	<GREEN>+<RESET><GREEN>15<RESET>
>   	 20<RESET>
> -	<BOLD;BLUE>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
> +	<BOLD;BLUE>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
>   	PAGER  10<RESET>
>   	PAGER <GREEN>+<RESET><GREEN>15<RESET>
>   	PAGER  20<RESET>
> -	<BOLD;BLUE>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>
> +	<BOLD;BLUE>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]? <RESET>
>   	EOF
>   	test_write_lines s y g 1 P |
>   	(
> @@ -796,21 +811,21 @@ test_expect_success 'colors can be overridden' '
>   	<BLUE>+<RESET><BLUE>new<RESET>
>   	<CYAN> more-context<RESET>
>   	<BLUE>+<RESET><BLUE>another-one<RESET>
> -	<YELLOW>(1/1) Stage this hunk [y,n,q,a,d,s,e,p,P,?]? <RESET><BOLD>Split into 2 hunks.<RESET>
> +	<YELLOW>(1/1) Stage this hunk [y,n,q,a,d,s,e,w,p,P,?]? <RESET><BOLD>Split into 2 hunks.<RESET>
>   	<MAGENTA>@@ -1,3 +1,3 @@<RESET>
>   	<CYAN> context<RESET>
>   	<BOLD>-old<RESET>
>   	<BLUE>+<RESET><BLUE>new<RESET>
>   	<CYAN> more-context<RESET>
> -	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET><MAGENTA>@@ -3 +3,2 @@<RESET>
> +	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]? <RESET><MAGENTA>@@ -3 +3,2 @@<RESET>
>   	<CYAN> more-context<RESET>
>   	<BLUE>+<RESET><BLUE>another-one<RESET>
> -	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,P,?]? <RESET><MAGENTA>@@ -1,3 +1,3 @@<RESET>
> +	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,w,p,P,?]? <RESET><MAGENTA>@@ -1,3 +1,3 @@<RESET>
>   	<CYAN> context<RESET>
>   	<BOLD>-old<RESET>
>   	<BLUE>+new<RESET>
>   	<CYAN> more-context<RESET>
> -	<YELLOW>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>
> +	<YELLOW>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]? <RESET>
>   	EOF
>   	test_cmp expect actual
>   '
> @@ -1424,9 +1439,9 @@ test_expect_success 'invalid option s is rejected' '
>   	test_write_lines j s q | git add -p >out &&
>   	sed -ne "s/ @@.*//" -e "s/ \$//" -e "/^(/p" <out >actual &&
>   	cat >expect <<-EOF &&
> -	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,s,e,p,P,?]?
> -	(2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? Sorry, cannot split this hunk
> -	(2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?
> +	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,s,e,w,p,P,?]?
> +	(2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]? Sorry, cannot split this hunk
> +	(2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,w,p,P,?]?
>   	EOF
>   	test_cmp expect actual
>   '

