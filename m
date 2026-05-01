Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151FA382F2A
	for <git@vger.kernel.org>; Fri,  1 May 2026 10:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777630576; cv=none; b=e8LzIRZMcXYnj1xidVN1FflF33kcOjJl+Y6jyhrmMmeh7sV4/ioYQXP0IH/68pbT71x7HDzJZbim02Fn3QZ8VPkR8NDAc0Gk/OVargzKeADrAMTpZHYkSMknK6d4oFjqgVEVRozPq+K/ykE02E2uCx77V9OIDeVutFgVRD1aIAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777630576; c=relaxed/simple;
	bh=UsXaaMb+fs2bfrZwPt/xKq1NVaIITqhVX5XgIW9YUV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9G7yZPZ3KjPe/llMvHtar7O5Fx85BIYTXuSpTvOzSxrJKPHhNkLkPc25OwkqbyUygeVqub+4OozaU0vY8DzJG82KukSiOcVseW6OFOUdLztvPFm4Ka2jz6D5Hu5DgERF1yji90YLJNDsyt7bCP5vla9sUIGvHrmy1Cz1xj57k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/n3nJIj; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/n3nJIj"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43eb012ac4fso1023862f8f.0
        for <git@vger.kernel.org>; Fri, 01 May 2026 03:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777630572; x=1778235372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B69P94OUYNLmH7rOyxhIZyuZNhWRwSfH0ilh5MDfJnU=;
        b=S/n3nJIjrlCBzui5GIE26wE9aQCo+wfpRNDxNguAQ+QLLJuCZgNJX/R6UQK9iRSEpA
         aFIiqzamtl99p1gwRLrOfr7mhwO2ATaxIa4sTSy16qAcHxcX9q610k7BYQ3rm/Z5I28/
         ip7N2Us2WcoMxf2202HVEze9AtuwNBacIZRLWRAoE7f/VRAabAvm++MsC+tCybNC7Amd
         ZTgPsQnOTgn1W1JgmDwPAOirZZFz7Hnd/5Pa2FrsS7BJIr8rGsLgd+Wr2BtgPi7rn3H2
         eMTkg0IM48Pw1B8Qp95HQC3X3b1EGYwt9w9I9URKp7LQRsTT3VcJcxXhT+0PjSKLApAr
         tTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777630572; x=1778235372;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B69P94OUYNLmH7rOyxhIZyuZNhWRwSfH0ilh5MDfJnU=;
        b=BQ+v5Xw3gBTOQA5ibjrvkrgzul4oArYENL0Z5l0kBLodpv1X3fdRqeDRkA4zyzCxPJ
         Ui9oOwcSoQVr+kwHehVz9kP53Tf/wCkgzEriEjwFK/8/LzjksNw5GO5Cp/a3shKWwkO1
         mbhFROHA0/sQTMOs7eTrnGX4FlxWQa3cRzzVXmLY93CMDTazcfCDE80J9525elLDa474
         I4LEFYd24VtxyIhKVBKUOgkbL/f26m3ahtMW0MV86Av2w9CU9hz7qJ8kz6GYiaTK4GGS
         x7Bae3E9yDs0yKOTrGrhWvLF4wumSHJJNr8/PSovaj2MP3NFgqwlxrkUe/bGRJaOHbeE
         NGig==
X-Forwarded-Encrypted: i=1; AFNElJ9RYFrduGOEkL2yFnWL2N6bdU281baF6DkxZedUmEM77fDjhD14ahl4azPUK4JMcKaWr+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww/rTDhznjBcYFDBKtLOH3Y6ktiykgaGaht1oC/26KKLpnM61S
	aVWZBApyCoH/suTYYuyHIcIYsHS+blHkSpyfashspKF8flc7ppe8iNuF
X-Gm-Gg: AeBDietiuESQks02RHqOrC0VFrIgPRNbkXOZZvR7B9O4qQURwYE6ckcMBj+Uq9AyRzv
	0Dji18Gstw+V+ddSgu9Qrur8KUzAoSnL+vdFPql6Q2JuNIaRm//DN61vS5tEtIluZW8zZQAavvD
	2r6UafNWxpv8UF5Pv3OIeRy3pu/5YvirI8t5TE5UVRFAQS9GX8MAtR84YkJMfHpYWOUYke6180h
	UVFr0ftWtc2fNDRFOGsk83vy+nAHGIpuA0yMRGPXYKBVh2Bk+NWbEiWD7Ubic4XdQeST7LPSsSD
	9NhIpIyLZC6UdeS3ahE1b+Nrz+TvkhOhl+tC3HkfIL9aw4j5UGy69BT5YB/erYm5e7qOuOBHRMy
	G9+tp6ufP3foVJ/x0906z2EDzHwrmdqJ1LtuMLPlikDSnAC96Vila1DWoGj6NZSozT6VxjlCCsY
	raCW29M623vo/mp/fUE0H8ga6L91FQAw/edqIBjBZWk72CQlKfcwLWhuaDcCHSBcAbPqc6lYiBb
	MpECijcdCx17LFzbdGse0ewAr3PMXk6GsM=
X-Received: by 2002:a05:6000:310f:b0:43b:4f86:e985 with SMTP id ffacd0b85a97d-4493f130840mr11361794f8f.33.1777630572082;
        Fri, 01 May 2026 03:16:12 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1706:1a01:942c:6274:d1a3:61d3? ([2a0a:ef40:1706:1a01:942c:6274:d1a3:61d3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8ea7d0c9sm4115166f8f.7.2026.05.01.03.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 03:16:11 -0700 (PDT)
Message-ID: <e8bb57a2-8eff-4f72-96ca-72d8880901e0@gmail.com>
Date: Fri, 1 May 2026 11:16:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] format-rev: introduce builtin for on-demand pretty
 formatting
To: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, ben.knoble@gmail.com
References: <V2_CV_name-rev_--format.51b@msgid.xyz>
 <V3_CV_format-rev.66a@msgid.xyz> <V3_format-rev_new_builtin.66f@msgid.xyz>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <V3_format-rev_new_builtin.66f@msgid.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kristoffer

On 28/04/2026 23:25, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> Introduce a new builtin for pretty formatting one revision expression
> per line or commit object names found in running text.
> 
> Sometimes you want to format commits. Most of the time you’re
> walking the graph, e.g. getting a range of commits like
> `master..topic`. That’s a job for git-log(1).
> 
> But there are times when you want to format commits that you encounter
> on demand:
> 
> • Full hashes in running text that you might want to pretty-print
> • git-last-modified(1) outputs full hashes that you can do the same
>    with
> • git-cherry(1) has `-v` for commit subject, but maybe you want
>    something else?
> 
> But now you can’t use git-log(1), git-show(1), or git-rev-list(1):
> 
> • You can’t feed commits piecemeal to these commands, one input
>    for one output; they block until standard in is closed

So you can feed them piecemeal but you don't get any output until you 
close stdin. That can be helpful as it means the calling process can 
write to "git log --stdin" and then read the output without worrying 
about getting deadlocked. The Implementation below works fine if there 
are separate processes or threads writing to and reading from "git 
format-rev", but if we want a single process to be able to read from and 
write to "git format-rev --stdin-mode=text" there will need to be a way 
to delimit message boundaries so that git knows where the input message 
ends and the caller knows where the response ends. We'll also need to be 
careful about flushing the output at the end of a processed message.

For "--stdin-mode=revs" the caller cannot know how many lines the output 
will span because formats like %(trailers) will produce a variable 
number of lines depending on which trailers are present. It is also 
possible for a rev name to span more than one line. The following 
example finds the most recent commit that mentions 'cherry-pick' in the 
subject line

:/^[^
]cherry-pick

so we need a way to delimit the input and output records there as well. 
I think the functionality implemented here is useful (transforming the 
output of 'git blame' or 'git-last-modified' are convicing examples) and 
it is probably better to do it as a command rather than adding a 
"--format" option to name-rev.

> • You can’t feed a list of possibly duplicate commits, like the output
>    of git-last-modified(1); they effectively deduplicate the output

That is definitely a problem

> Beyond these two points there’s also the input massage problem: you

s/massagge/message/?

Thanks

Phillip

> cannot feed mixed input (revisions mixed with arbitrary text).
> 
> One might hope that git-cat-file(1) can save us. But it doesn’t
> support pretty formats.
> 
> But there is one command that already both handles revisions as
> arguments, revisions on standard input, and even revisions mixed in
> with arbitrary text. Namely git-name-rev(1): the command for outputting
> symbolic names for commits.
> 
> We made some room in `builtin/name-rev.c` two commits ago. Let’s
> now add this new git-format-rev(1) command. Taking inspiration from
> git-name-rev(1), there are two modes:
> 
> • revs: like git-name-rev(1) in argv mode, but one revision per line
>    on standard in
> • text: like git-name-rev(1) with `--annotate-stdin`
> 
> ***
> 
> We need to add this command to the exception list in
> `t/t1517-outside-repo.sh` because it uses “EXPERIMENTAL!”
> in the usage line.
> 
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
> 
> Notes (series):
>      v3:
>      • And don’t forget to document --notes this time
>      
>            https://lore.kernel.org/git/CALnO6CB5WOTp_e7Kv3CrEbQ+3XE-gDxNVHf7qATBEbyKWfxpLg@mail.gmail.com/
> 
>   Documentation/git-format-rev.adoc | 148 ++++++++++++++++++++++++
>   Makefile                          |   1 +
>   builtin.h                         |   1 +
>   builtin/name-rev.c                | 186 ++++++++++++++++++++++++++++++
>   command-list.txt                  |   1 +
>   git.c                             |   1 +
>   t/t1517-outside-repo.sh           |   3 +-
>   t/t6120-describe.sh               | 104 +++++++++++++++++
>   8 files changed, 444 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/git-format-rev.adoc
> 
> diff --git a/Documentation/git-format-rev.adoc b/Documentation/git-format-rev.adoc
> new file mode 100644
> index 00000000000..d960001d750
> --- /dev/null
> +++ b/Documentation/git-format-rev.adoc
> @@ -0,0 +1,148 @@
> +git-format-rev(1)
> +=================
> +
> +NAME
> +----
> +git-format-rev - EXPERIMENTAL: Pretty format revisions on demand
> +
> +
> +SYNOPSIS
> +--------
> +[synopsis]
> +(EXPERIMENTAL!) git format-rev --stdin-mode=<mode> --format=<pretty> [--notes=<ref>]
> +
> +DESCRIPTION
> +-----------
> +
> +Pretty format revisions from standard input.
> +
> +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> +
> +OPTIONS
> +-------
> +
> +`--stdin-mode=<mode>`::
> +	How to interpret standard input data:
> ++
> +--
> +`revs`:: Each line is interpreted as a commit. Any kind of revision
> +	expression can be used (see linkgit:gitrevisions[7]). Annotated
> +	tags are peeled (see linkgit:gitglossary[7]).
> ++
> +The argument `rev` is also accepted.
> +`text`:: Formats all commit object names found in freeform text. These
> +	must the full object names, i.e. abbreviated hexidecimal object
> +	names will not be interpreted.
> +--
> +
> +`--format=<pretty>`::
> +	Pretty format string.
> +
> +`--notes=<ref>`::
> +`--no-notes`::
> +	Custom notes ref. Notes are displayed when using the `%N`
> +	atom. See linkgit:git-notes[1].
> +
> +EXAMPLES
> +--------
> +
> +The command linkgit:git-last-modified[1] shows the commit that each file
> +was last modified in.
> +
> +----
> +$ git last-modified -- README.md Makefile
> +7798034171030be0909c56377a4e0e10e6d2df93	Makefile
> +c50fbb2dd225e7e82abba4380423ae105089f4d7	README.md
> +----
> +
> +We can pipe the result to this command in order to replace the object
> +name with the commit author.
> +
> +----
> +$ git last-modified -- README.md Makefile |
> +    git format-rev --stdin-mode=text --format=%an
> +Junio C Hamano	Makefile
> +Todd Zullinger	README.md
> +----
> +
> +Another example is _formatting commits in commit messages_. Given this commit message:
> +
> +----
> +Fix off-by-one error
> +
> +Fix off-by-one error introduced in
> +e83c5163316f89bfbde7d9ab23ca2e25604af290.
> +
> +We thought we fixed this in 5569bf9bbedd63a00780fc5c110e0cfab3aa97b9 but
> +that only covered 1/3 of the faulty cases.
> +----
> +
> +We can format the commits and use par(1) to reflow the text, say in a
> +`commit-msg` hook:
> +
> +----
> +$ git config set hook.reference-commits.event commit-msg
> +$ git config set hook.reference-commits.command reference-commits
> +$ cat $(which reference-commits)
> +#/bin/sh
> +
> +msg="$1"
> +rewritten=$(mktemp)
> +git format-rev --stdin-mode=text --format=reference <"$msg" |
> +    par >"$rewritten"
> +mv "$rewritten" "$msg"
> +----
> +
> +Which will produce something like this:
> +
> +----
> +Fix off-by-one error
> +
> +Fix off-by-one error introduced in e83c5163316 (Implement better memory
> +allocator, 2005-04-07).
> +
> +We thought we fixed this in 5569bf9bbed (Fix memory allocator,
> +2005-06-22) but that only covered 1/3 of the faulty cases.
> +----
> +
> +DISCUSSION
> +----------
> +
> +This command lets you format any number of revisions in any order
> +through one command invocation. Consider the
> +linkgit:git-last-modified[1] case from the "EXAMPLES" section above:
> +
> +1. There might be hundreds of files
> +2. Commits can be repeated, i.e. two or more files were last modified in
> +   the same commit
> +
> +Two widely-used commands which pretty formats commits are
> +linkgit:git-log[1] and linkgit:git-show[1]. It turns out that they are
> +not a good fit for the above use case.
> +
> +- The output of linkgit:git-last-modified[1] would have to be processed
> +  in stages since you need to transform the first column separately and
> +  then link the author to the filename. But this is surmountable.
> +- You can feed each commit to `git show` or `git show --no-walk -1`. But
> +  that means that you need to create a process for each line.
> +- Let’s say that you want to use one process, not one per line. So you
> +  want to feed all the commits to the command. Now you face the problem
> +  that you have to feed all the commits to the commands before you get
> +  any output (this is also the case for the `--stdin` modes). In other
> +  words, you cannot loop through each line, get the author for the
> +  commit, and output the author and the filename. You need to feed all
> +  the commits, get back all the output, and match the output with the
> +  filename.
> +- But the next problem is that commands will deduplicate the input and
> +  only output one commit one single time only. Thus you cannot make the
> +  output order match the input order, since a commit could have been
> +  repeated in the original input.
> +
> +In short, it is straightforward to use these two commands if you use one
> +process per line. It is much more work if you just want to use one
> +process, but still doable. In contrast, this problem is just another
> +shell pipeline with this command.
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> diff --git a/Makefile b/Makefile
> index 15b1ded1a0b..cbaf91fd846 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -895,6 +895,7 @@ BUILT_INS += $(patsubst builtin/%.o,git-%$X,$(BUILTIN_OBJS))
>   BUILT_INS += git-cherry$X
>   BUILT_INS += git-cherry-pick$X
>   BUILT_INS += git-format-patch$X
> +BUILT_INS += git-format-rev$X
>   BUILT_INS += git-fsck-objects$X
>   BUILT_INS += git-init$X
>   BUILT_INS += git-maintenance$X
> diff --git a/builtin.h b/builtin.h
> index 235c51f30e5..63813c90125 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -189,6 +189,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix, struct re
>   int cmd_for_each_ref(int argc, const char **argv, const char *prefix, struct repository *repo);
>   int cmd_for_each_repo(int argc, const char **argv, const char *prefix, struct repository *repo);
>   int cmd_format_patch(int argc, const char **argv, const char *prefix, struct repository *repo);
> +int cmd_format_rev(int argc, const char **argv, const char *prefix, struct repository *repo);
>   int cmd_fsck(int argc, const char **argv, const char *prefix, struct repository *repo);
>   int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix, struct repository *repo);
>   int cmd_gc(int argc, const char **argv, const char *prefix, struct repository *repo);
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index dc4136f4de3..b60cc766279 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -18,6 +18,9 @@
>   #include "commit-graph.h"
>   #include "wildmatch.h"
>   #include "mem-pool.h"
> +#include "pretty.h"
> +#include "revision.h"
> +#include "notes.h"
>   
>   /*
>    * One day.  See the 'name a rev shortly after epoch' test in t6120 when
> @@ -272,14 +275,26 @@ struct name_ref_data {
>   	struct string_list exclude_filters;
>   };
>   
> +struct pretty_format {
> +	struct pretty_print_context ctx;
> +	struct userformat_want want;
> +};
> +
>   enum command_type {
>   	NAME_REV = 1,
> +	FORMAT_REV = 2,
> +};
> +
> +enum stdin_mode {
> +    TEXT = 1,
> +    REVS = 2,
>   };
>   
>   struct command {
>   	enum command_type type;
>   	union {
>   		int name_only;
> +		struct pretty_format *pretty_format;
>   	} u;
>   };
>   
> @@ -290,6 +305,13 @@ static void init_name_rev_command(struct command *cmd,
>   	cmd->u.name_only = name_only;
>   }
>   
> +static void init_format_rev_command(struct command *cmd,
> +				    struct pretty_format *pretty_format)
> +{
> +	cmd->type = FORMAT_REV;
> +	cmd->u.pretty_format = pretty_format;
> +}
> +
>   static struct tip_table {
>   	struct tip_table_entry {
>   		struct object_id oid;
> @@ -495,6 +517,27 @@ static const char *get_rev_name(const struct object *o, struct strbuf *buf)
>   	}
>   }
>   
> +static const char *get_format_rev(const struct commit *c,
> +				  struct pretty_format *format_ctx,
> +				  struct strbuf *buf)
> +{
> +	strbuf_reset(buf);
> +
> +	if (format_ctx->want.notes) {
> +		struct strbuf notebuf = STRBUF_INIT;
> +
> +		format_display_notes(&c->object.oid, &notebuf,
> +				     get_log_output_encoding(),
> +				     format_ctx->ctx.fmt == CMIT_FMT_USERFORMAT);
> +		format_ctx->ctx.notes_message = strbuf_detach(&notebuf, NULL);
> +	}
> +
> +	pretty_print_commit(&format_ctx->ctx, c, buf);
> +	FREE_AND_NULL(format_ctx->ctx.notes_message);
> +
> +	return buf->buf;
> +}
> +
>   static void show_name(const struct object *obj,
>   		      const char *caller_name,
>   		      int always, int allow_undefined, int name_only)
> @@ -565,6 +608,19 @@ static void name_rev_line(char *p, struct command *cmd)
>   				else
>   					printf("%.*s (%s)", p_len, p_start, name);
>   				break;
> +			case FORMAT_REV:
> +				if (!oid_ret)
> +					o = parse_object(the_repository, &oid);
> +				if (o && o->type == OBJ_COMMIT)
> +					name = get_format_rev((const struct commit *)o,
> +							      cmd->u.pretty_format,
> +							      &buf);
> +				*(p + 1) = c;
> +				if (name)
> +					printf("%.*s%s", p_len - hexsz, p_start, name);
> +				else
> +					printf("%.*s", p_len, p_start);
> +				break;
>   			default:
>   				BUG("uncovered case: %d", cmd->type);
>   			}
> @@ -718,3 +774,133 @@ int cmd_name_rev(int argc,
>   	object_array_clear(&revs);
>   	return 0;
>   }
> +
> +static enum stdin_mode parse_stdin_mode(const char *stdin_mode)
> +{
> +	if (!strcmp(stdin_mode, "text"))
> +		return TEXT;
> +	else if (!strcmp(stdin_mode, "revs") ||
> +		 !strcmp(stdin_mode, "rev"))
> +		return REVS;
> +	else
> +		die(_("'%s' needs to be either text, revs, or rev"),
> +		    "--stdin-mode");
> +}
> +
> +static char const *const format_rev_usage[] = {
> +	N_("(EXPERIMENTAL!) git format-rev --stdin-mode=<mode> --format=<pretty> [--notes=<ref>]"),
> +	NULL
> +};
> +
> +int cmd_format_rev(int argc,
> +		   const char **argv,
> +		   const char *prefix,
> +		   struct repository *repo UNUSED)
> +{
> +	const char *format = NULL;
> +	enum stdin_mode stdin_mode;
> +	const char *stdin_mode_arg = NULL;
> +	struct display_notes_opt format_notes_opt;
> +	struct rev_info format_rev = REV_INFO_INIT;
> +	struct pretty_format format_pp = { 0 };
> +	struct string_list notes = STRING_LIST_INIT_NODUP;
> +	struct strbuf scratch_buf = STRBUF_INIT;
> +	struct command cmd;
> +	struct option opts[] = {
> +		OPT_STRING(0, "format", &format, N_("format"),
> +			   N_("pretty format to use")),
> +		OPT_STRING(0, "stdin-mode", &stdin_mode_arg, N_("stdin-mode"),
> +			   N_("how revs are processed")),
> +		OPT_STRING_LIST(0, "notes", &notes, N_("notes"),
> +				N_("display notes for pretty format")),
> +		OPT_END(),
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, opts, format_rev_usage, 0);
> +
> +	if (argc > 0) {
> +		error(_("too many arguments"));
> +		usage_with_options(format_rev_usage, opts);
> +	}
> +
> +	if (!format)
> +		die(_("'%s' is required"), "--format");
> +	if (!stdin_mode_arg)
> +		die(_("'%s' is required"), "--stdin-mode");
> +
> +	init_display_notes(&format_notes_opt);
> +	stdin_mode = parse_stdin_mode(stdin_mode_arg);
> +
> +	get_commit_format(format, &format_rev);
> +	format_pp.ctx.rev = &format_rev;
> +	format_pp.ctx.fmt = format_rev.commit_format;
> +	format_pp.ctx.abbrev = format_rev.abbrev;
> +	format_pp.ctx.date_mode_explicit = format_rev.date_mode_explicit;
> +	format_pp.ctx.date_mode = format_rev.date_mode;
> +	format_pp.ctx.color = GIT_COLOR_AUTO;
> +
> +	userformat_find_requirements(format,
> +				     &format_pp.want);
> +	if (format_pp.want.notes) {
> +		int ignore_show_notes = 0;
> +		struct string_list_item *n;
> +
> +		for_each_string_list_item(n, &notes)
> +			enable_ref_display_notes(&format_notes_opt,
> +						 &ignore_show_notes,
> +						 n->string);
> +		load_display_notes(&format_notes_opt);
> +	}
> +
> +	init_format_rev_command(&cmd, &format_pp);
> +
> +	switch (stdin_mode) {
> +	case TEXT:
> +		while (strbuf_getline(&scratch_buf, stdin) != EOF) {
> +			strbuf_addch(&scratch_buf, '\n');
> +			name_rev_line(scratch_buf.buf, &cmd);
> +		}
> +		break;
> +	case REVS:
> +		while (strbuf_getline(&scratch_buf, stdin) != EOF) {
> +			struct object_id oid;
> +			struct object *object;
> +			struct object *peeled;
> +			struct commit *commit;
> +
> +			if (repo_get_oid(the_repository, scratch_buf.buf, &oid)) {
> +				fprintf(stderr, "Could not get sha1 for %s. Skipping.\n",
> +					scratch_buf.buf);
> +				continue;
> +			}
> +
> +			object = parse_object(the_repository, &oid);
> +			if (!object) {
> +				fprintf(stderr, "Could not get object for %s. Skipping.\n",
> +					scratch_buf.buf);
> +				continue;
> +			}
> +
> +			peeled = deref_tag(the_repository, object, scratch_buf.buf, 0);
> +			if (peeled && peeled->type == OBJ_COMMIT)
> +				commit = (struct commit *)peeled;
> +			if (!commit) {
> +				fprintf(stderr, "Could not get commit for %s. Skipping.\n",
> +					*argv);
> +				continue;
> +			}
> +
> +			get_format_rev(commit, &format_pp, &scratch_buf);
> +			printf("%s\n", scratch_buf.buf);
> +			strbuf_release(&scratch_buf);
> +		}
> +		break;
> +	default:
> +		BUG("uncovered case: %d", stdin_mode);
> +	}
> +
> +	strbuf_release(&scratch_buf);
> +	string_list_clear(&notes, 0);
> +	release_display_notes(&format_notes_opt);
> +	return 0;
> +}
> diff --git a/command-list.txt b/command-list.txt
> index f9005cf4597..df729872dca 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -108,6 +108,7 @@ git-fmt-merge-msg                       purehelpers
>   git-for-each-ref                        plumbinginterrogators
>   git-for-each-repo                       plumbinginterrogators
>   git-format-patch                        mainporcelain
> +git-format-rev                          plumbinginterrogators
>   git-fsck                                ancillaryinterrogators          complete
>   git-gc                                  mainporcelain
>   git-get-tar-commit-id                   plumbinginterrogators
> diff --git a/git.c b/git.c
> index 2b212e6675d..af5b0422b00 100644
> --- a/git.c
> +++ b/git.c
> @@ -578,6 +578,7 @@ static struct cmd_struct commands[] = {
>   	{ "for-each-ref", cmd_for_each_ref, RUN_SETUP },
>   	{ "for-each-repo", cmd_for_each_repo, RUN_SETUP_GENTLY },
>   	{ "format-patch", cmd_format_patch, RUN_SETUP },
> +	{ "format-rev", cmd_format_rev, RUN_SETUP },
>   	{ "fsck", cmd_fsck, RUN_SETUP },
>   	{ "fsck-objects", cmd_fsck, RUN_SETUP },
>   	{ "fsmonitor--daemon", cmd_fsmonitor__daemon, RUN_SETUP },
> diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
> index c824c1a25cf..360a9323343 100755
> --- a/t/t1517-outside-repo.sh
> +++ b/t/t1517-outside-repo.sh
> @@ -114,7 +114,8 @@ do
>   	archimport | citool | credential-netrc | credential-libsecret | \
>   	credential-osxkeychain | cvsexportcommit | cvsimport | cvsserver | \
>   	daemon | \
> -	difftool--helper | filter-branch | fsck-objects | get-tar-commit-id | \
> +	difftool--helper | filter-branch | format-rev | fsck-objects | \
> +	get-tar-commit-id | \
>   	gui | gui--askpass | \
>   	http-backend | http-fetch | http-push | init-db | \
>   	merge-octopus | merge-one-file | merge-resolve | mergetool | \
> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index 62789f76381..725f7d81b6b 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -801,4 +801,108 @@ test_expect_success 'do not be fooled by invalid describe format ' '
>   	test_must_fail git cat-file -t "refs/tags/super-invalid/./../...../ ~^:/?*[////\\\\\\&}/busted.lock-42-g"$(cat out)
>   '
>   
> +test_expect_success 'name-rev --format setup' '
> +	mkdir repo-format &&
> +	git -C repo-format init &&
> +	test_commit -C repo-format first &&
> +	test_commit -C repo-format second &&
> +	test_commit -C repo-format third &&
> +	test_commit -C repo-format fourth &&
> +	test_commit -C repo-format fifth &&
> +	test_commit -C repo-format sixth &&
> +	test_commit -C repo-format seventh &&
> +	test_commit -C repo-format eighth
> +'
> +
> +test_expect_success 'format-rev --stdin-mode=revs' '
> +	cat >expect <<-\EOF &&
> +	eighth
> +	seventh
> +	fifth
> +	EOF
> +	git -C repo-format format-rev --stdin-mode=revs \
> +		--format=%s >actual <<-\EOF &&
> +	HEAD
> +	HEAD~
> +	HEAD~3
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'format-rev --stdin-mode=text from rev-list same as log' '
> +	git -C repo-format log --format=reference >expect &&
> +	test_file_not_empty expect &&
> +	git -C repo-format rev-list HEAD >list &&
> +	git -C repo-format format-rev --stdin-mode=text \
> +		--format=reference <list >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'format-rev --stdin-mode=text with running text and tree oid' '
> +	cmit_oid=$(git -C repo-format rev-parse :/fifth) &&
> +	reference=$(git -C repo-format log -n1 --format=reference :/fifth) &&
> +	tree=$(git -C repo-format rev-parse HEAD^{tree}) &&
> +	cat >expect <<-EOF &&
> +	We thought we fixed this in ${reference}.
> +	But look at this tree: ${tree}.
> +	EOF
> +	git -C repo-format format-rev --stdin-mode=text --format=reference \
> +		>actual <<-EOF &&
> +	We thought we fixed this in ${cmit_oid}.
> +	But look at this tree: ${tree}.
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'format-rev with %N (note)' '
> +	test_when_finished "git -C repo-format notes remove" &&
> +	git -C repo-format notes add -m"Make a note" &&
> +	printf "Make a note\n\n\n" >expect &&
> +	git -C repo-format format-rev --stdin-mode=revs \
> +		--format="tformat:%N" \
> +		>actual <<-\EOF &&
> +	HEAD
> +	HEAD~
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'format-rev --notes<ref> (custom notes ref)' '
> +	# One custom notes ref
> +	test_when_finished "git -C repo-format notes remove" &&
> +	test_when_finished "git -C repo-format notes --ref=word remove" &&
> +	git -C repo-format notes add -m"default" &&
> +	git -C repo-format notes --ref=word add -m"custom" &&
> +	printf "custom\n\n" >expect &&
> +	git -C repo-format format-rev --stdin-mode=revs \
> +		--format="tformat:%N" \
> +		--notes=word \
> +		>actual <<-\EOF &&
> +	HEAD
> +	EOF
> +	test_cmp expect actual &&
> +	# Glob all
> +	printf "default\ncustom\n\n" >expect &&
> +	git -C repo-format format-rev --stdin-mode=revs \
> +		--format="tformat:%N" \
> +		--notes=* >actual <<-\EOF &&
> +	HEAD
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'format-rev --stdin-mode=revs on annotated tag peels to commit' '
> +	test_when_finished "git -C repo-format tag -d version" &&
> +	git -C repo-format tag -a -m"new version" version &&
> +	cat >expect <<-\EOF &&
> +	eighth
> +	EOF
> +	git -C repo-format format-rev --stdin-mode=revs \
> +		--format=%s \
> +		--notes=* >actual <<-\EOF &&
> +	version
> +	EOF
> +	test_cmp expect actual
> +'
> +
>   test_done

