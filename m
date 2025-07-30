Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E15E269AFB
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753870133; cv=none; b=mH8yCRkIsqE0lcMRNIh73g9su3UkKngRDwsQWJQA3YI1n0tzHuESY/IKPceRVB6RbsBb//G0X2/zOXBu1zAVnFEcKK1yshE7BafKGkoV+qKwfg4zy9NQX7MLER9vxXfg3smEvQNuxM+8fnfFOMXI1695tKNt+2luP70RuVbSqq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753870133; c=relaxed/simple;
	bh=cKDt8kB7Z/eVlvIiYKKoF3+I8Y8WUgERCXcXM1bnqMc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BQehoyrps5WdxUf3eaulDxp8PKEfRn+VYGAyoO1TTDLEE4jzayD16KrXM3Eg3iN7QXIssfU9CiH4BVQiAxiPfQ9igvptV1C1bgR5C78v31OHliYJZrjV/XEIcZ6Aj0daHDgaquWMCt10UmKBZsnJvWHDoG5PpOPJsKePNA3tvpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtejdjBT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtejdjBT"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45892deb1dcso3698935e9.1
        for <git@vger.kernel.org>; Wed, 30 Jul 2025 03:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753870130; x=1754474930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b9D9OjyEdwJ/TGY0nz8xi7oWqgly6K+8zAxsMNz9J1c=;
        b=FtejdjBTJm61glBqcMQ1ZSEw6Tur55tuD3GPvwV7h8IOCdUrGMInBSZNIjbF7XhTSj
         qQ+OG8vSiQvhFr2RQy31ljcNyz/3WM10y4uWYH753c8xf+RXFXkyextGWoCRjIxk8vaq
         3uuyw9CASNlsLaDzI3D3nlJDim7dseUjefcM9tqI57sW3CbV1jjc/Sh28PNIlLul0eIw
         wDOkuzbuti7o5eyhoS4/22J1yOjRA44OtM+3SUhFe24GoGEKns+q7tA/y55gCcLsQyJQ
         JjakDDyd1wTqoDNSRktRyP0H9mKPuvHLT0B5Q6dYAtrkdc5Ha9cVsFwmBAbM9JvgoOEA
         yMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753870130; x=1754474930;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b9D9OjyEdwJ/TGY0nz8xi7oWqgly6K+8zAxsMNz9J1c=;
        b=th10ob5ahqg7EHwP1JOyS/OSClQMlJ7qepJl6nT+jhQRM4a0QztJIwj3XrM9a2P1lb
         0XWEiZKZ8cMGR2jlFes/Kf4l90ikYbwEvnaRzFAw9py2c9M8KQpYo5DwO4SE17qCNKWu
         FED8c6AV3/OzkbxyQkurzA0JkN1SyR8VQNe5c8D6B5f7oUPI8xFqyG8XpQ7Dh9DSfXfe
         WiUl3QsF9g0IZH4SV68Mj8f1J71N1GVReGPCM+3WXk/yO/yXD8VbPgvSyP6UzJwW4K6B
         EqYR4IU/9fD7MEF9CstodZt3/Zd0fBbjC7I+ikIdYxKrC2d4jAIMAUvrztptNy5hkWXw
         UNIg==
X-Forwarded-Encrypted: i=1; AJvYcCUpmtCojjo6PGVR4ZS8jcpwGLvlGCxozsOxGqq8K52GDz6hFUEC176HMLsC3aszvlUgb/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB6j2S3yM7EWQ+6flhLyx//Ccl0DvzOwy75bGHDN+5Ds0dcwcT
	vhV+To2VXGQpPJPhst6t2j/NtTxI+ilyU9/cgaoR7jDlUPepLK85wsr/
X-Gm-Gg: ASbGncs3aj+sErt7GphZ7ExQOHa1StnOhoJcH30uhHxlXzIXuWDOoub0+ewqyerQvMl
	N0x3LA1qSeCGbeyk+HMlyDJ1Yy/iJNuXwfbE5BhErrZH0vliVVachw3gxspvg1Kzv7bPbDChbVz
	woTeaSD5yrYPjfJRk8eJHyRTV5ruoT5ZxBCo44hcQcdndvRQy9xaPTpkpzJS2ge5NuByurn8/6p
	/QobvzXv/qa7DRtluKjjNoA3MFx4Go0ArDwSPnqCcAMrw64rZMcSBLa3XY5z/DKln3TN6yMD9Ej
	iUPYEGOQ0veRKrkGjJwD6U12zZ044lJB373mmXvgCSpjsRdLYDW+7XSaEL75uN4JUUo9dp7ledZ
	qp2lT6nenJYjQu2VOUtrPooYjXEBo6tD7hkUAwWETkrikhR/mmh+KfDx6Vn6X+sHBSVTv26YtJX
	X0gdPvqGD4DaI=
X-Google-Smtp-Source: AGHT+IFfHzoxHtZEzEFwq3jn9TC0elXQZ6H3rMcax+tgj0333RH7QxUlmebqjrO6fFhL9i37KNDlGg==
X-Received: by 2002:a05:600c:8114:b0:456:23aa:8c8 with SMTP id 5b1f17b1804b1-45892b9e4bcmr25136095e9.13.1753870129588;
        Wed, 30 Jul 2025 03:08:49 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778eba147sm15283089f8f.27.2025.07.30.03.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 03:08:49 -0700 (PDT)
Message-ID: <2da722a3-2ed0-4f2b-a623-df0dc4aaad77@gmail.com>
Date: Wed, 30 Jul 2025 11:08:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] status: add --json output format to git status
To: Tachera W sasi <tacherasasi@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Tach via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1937.git.1753856826464.gitgitgadget@gmail.com>
 <c4658ae9-007d-4645-9561-febe03dc612d@gmail.com>
 <CA+m0rScismG8VVf8mYS=+_AjwgrgX8GNZrFD+8-0EaeCDYPgbg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CA+m0rScismG8VVf8mYS=+_AjwgrgX8GNZrFD+8-0EaeCDYPgbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Tachera

On 30/07/2025 10:15, Tachera W sasi wrote:
> 
> For v2, I will:
>    * Rework the patch to use `json-writer.h` so escaping and JSON 
> compliance are handled
>      properly.

That will handle the escaping problems but we still have the problem 
that filenames and refnames are not guaranteed to be utf-8 encoded. I 
think the only way to handle that is to base64 encode them so that the 
caller can retrieve the raw bytes. See 
https://lore.kernel.org/git/ZvXMSKaUWWA-MG9J@tapette.crustytoothpaste.net/ 
for a previous discussion about this.

>    * Add tests covering filenames with quotes, newlines, and non-UTF-8 
> cases.
>    * Include tests under `t/` to prevent future regressions.

That's great, you should update Documentation/git-status.adoc as well to 
document the new option and output format

Thanks

Phillip

> Thanks again for your review and for pointing me towards the proper helpers.
> 
> Best regards,
> Tachera Sasi
> 
> On Wed, Jul 30, 2025 at 12:01 PM Phillip Wood <phillip.wood123@gmail.com 
> <mailto:phillip.wood123@gmail.com>> wrote:
> 
>     On 30/07/2025 07:27, Tach via GitGitGadget wrote:
>      > From: tacherasasi <tacherasasi@gmail.com
>     <mailto:tacherasasi@gmail.com>>
>      >
>      > Add a new --json flag to 'git status' that outputs repository state
>      > in a structured JSON format. This enables reliable machine parsing
>      > of status information for tools and automation.
>      >
>      > The JSON output includes:
>      > - Branch information (name, detached state, ahead/behind counts)
>      > - Staged files array
>      > - Unstaged files array
>      > - Untracked files array
>      > - Ignored files array (with --ignored flag)
>      >
>      > Implementation details:
>      > - Add STATUS_FORMAT_JSON to wt_status_format enum
>      > - Add JSON output option to git status and git commit
>      > - Implement JSON formatting helpers for arrays and branch info
>      > - Structure output for easy parsing and future extensibility
>      >
>      > Example:
>      >    $ git status --json
>      >    {
>      >      "branch": {
>      >        "current": "main",
>      >        "detached": false
>      >      },
>      >      "staged": ["file1.txt"],
>      >      "unstaged": ["file2.txt"],
>      >      "untracked": ["file3.txt"]
>      >    }
>      >
>      > This provides a robust alternative to parsing traditional output
>      > formats, making it easier to build reliable tools and automation
>      > around Git status information.
> 
>     What problem are you having paring the current output? You say this
>     patch provides a robust alternative but I'm afraid it does not seem to
>     handle filenames containing newlines or double quotes and it assumes
>     they are utf-8 encoded. It also seems to print a trailing comma if an
>     array has more than one item which is not allowed by the json spec. We
>     already have support for generating json output as documented
>     json-writer.h which will help with most of that but not the filename
>     encoding problem. New features should also be accompanied by tests to
>     prevent future regressions. I'm not opposed to adding json output if it
>     is robust and handles non utf-8 filenames but it would be helpful to
>     understand what problems you are having parsing the output of "git
>     status --porcelain[=v2]".
> 
>     Thanks
> 
>     Phillip
> 
>      > Signed-off-by: Tachera Sasi <tachera@ekilie.com
>     <mailto:tachera@ekilie.com>>
>      > Signed-off-by: tacherasasi <tacherasasi@gmail.com
>     <mailto:tacherasasi@gmail.com>>
>      > ---
>      >      status: add --json output format to git status
>      >
>      > Published-As: https://github.com/gitgitgadget/git/releases/tag/
>     pr-1937%2FtacheraSasi%2Ffeature%2Fjson-status-output-v1 <https://
>     github.com/gitgitgadget/git/releases/tag/
>     pr-1937%2FtacheraSasi%2Ffeature%2Fjson-status-output-v1>
>      > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git
>     <https://github.com/gitgitgadget/git> pr-1937/tacheraSasi/feature/
>     json-status-output-v1
>      > Pull-Request: https://github.com/gitgitgadget/git/pull/1937
>     <https://github.com/gitgitgadget/git/pull/1937>
>      >
>      >   builtin/commit.c |  9 ++++-
>      >   wt-status.c      | 98 +++++++++++++++++++++++++++++++++++++++++
>     +++++++
>      >   wt-status.h      |  1 +
>      >   3 files changed, 107 insertions(+), 1 deletion(-)
>      >
>      > diff --git a/builtin/commit.c b/builtin/commit.c
>      > index fba0dded64a..f1db4fdfd9a 100644
>      > --- a/builtin/commit.c
>      > +++ b/builtin/commit.c
>      > @@ -1540,6 +1540,9 @@ struct repository *repo UNUSED)
>      >               OPT_SET_INT(0, "long", &status_format,
>      >                           N_("show status in long format (default)"),
>      >                           STATUS_FORMAT_LONG),
>      > +             OPT_SET_INT(0, "json", &status_format,
>      > +                 N_("show status in JSON format"),
>      > +                 STATUS_FORMAT_JSON),
>      >               OPT_BOOL('z', "null", &s.null_termination,
>      >                        N_("terminate entries with NUL")),
>      >               {
>      > @@ -1603,7 +1606,8 @@ struct repository *repo UNUSED)
>      >                      prefix, argv);
>      >
>      >       if (status_format != STATUS_FORMAT_PORCELAIN &&
>      > -         status_format != STATUS_FORMAT_PORCELAIN_V2)
>      > +         status_format != STATUS_FORMAT_PORCELAIN_V2 &&
>      > +         status_format != STATUS_FORMAT_JSON)
>      >               progress_flag = REFRESH_PROGRESS;
>      >       repo_read_index(the_repository);
>      >       refresh_index(the_repository->index,
>      > @@ -1735,6 +1739,9 @@ int cmd_commit(int argc,
>      >               OPT_SET_INT(0, "long", &status_format,
>      >                           N_("show status in long format (default)"),
>      >                           STATUS_FORMAT_LONG),
>      > +             OPT_SET_INT(0, "json", &status_format,
>      > +                 N_("show status in JSON format"),
>      > +                 STATUS_FORMAT_JSON),
>      >               OPT_BOOL('z', "null", &s.null_termination,
>      >                        N_("terminate entries with NUL")),
>      >               OPT_BOOL(0, "amend", &amend, N_("amend previous
>     commit")),
>      > diff --git a/wt-status.c b/wt-status.c
>      > index 454601afa15..7192fb4d057 100644
>      > --- a/wt-status.c
>      > +++ b/wt-status.c
>      > @@ -2564,6 +2564,101 @@ static void wt_porcelain_v2_print(struct
>     wt_status *s)
>      >       }
>      >   }
>      >
>      > +
>      > +static void wt_json_print_string_array(struct wt_status *s,
>     const char *name, struct string_list *list)
>      > +{
>      > +     int i;
>      > +     fprintf(s->fp, "  \"%s\": [", name);
>      > +     for (i = 0; i < list->nr; i++) {
>      > +             if (i > 0)
>      > +                     fprintf(s->fp, ", ");
>      > +             fprintf(s->fp, "\"%s\"", list->items[i].string);
>      > +     }
>      > +     fprintf(s->fp, "]");
>      > +}
>      > +
>      > +static void wt_json_print_change_array(struct wt_status *s,
>     const char *name, int change_type)
>      > +{
>      > +     int i;
>      > +     struct string_list files = STRING_LIST_INIT_DUP;
>      > +
>      > +     for (i = 0; i < s->change.nr <http://change.nr>; i++) {
>      > +             struct wt_status_change_data *d;
>      > +             struct string_list_item *it;
>      > +             it = &(s->change.items[i]);
>      > +             d = it->util;
>      > +
>      > +             if ((change_type == WT_STATUS_UPDATED && d-
>      >index_status &&
>      > +                  d->index_status != DIFF_STATUS_UNMERGED) ||
>      > +                 (change_type == WT_STATUS_CHANGED && d-
>      >worktree_status &&
>      > +                  d->worktree_status != DIFF_STATUS_UNMERGED)) {
>      > +                     string_list_append(&files, it->string);
>      > +             }
>      > +     }
>      > +
>      > +     wt_json_print_string_array(s, name, &files);
>      > +     string_list_clear(&files, 0);
>      > +}
>      > +
>      > +static void wt_json_print_branch_info(struct wt_status *s)
>      > +{
>      > +     struct branch *branch;
>      > +     const char *branch_name;
>      > +     int ahead = 0, behind = 0;
>      > +
>      > +     fprintf(s->fp, "  \"branch\": {\n");
>      > +
>      > +     if (s->branch && !s->is_initial) {
>      > +             if (!strcmp(s->branch, "HEAD")) {
>      > +                     fprintf(s->fp, "    \"current\": \"HEAD\",\n");
>      > +                     fprintf(s->fp, "    \"detached\": true");
>      > +             } else {
>      > +                     if (skip_prefix(s->branch, "refs/heads/",
>     &branch_name)) {
>      > +                             fprintf(s->fp, "    \"current\":
>     \"%s\",\n", branch_name);
>      > +                             fprintf(s->fp, "    \"detached\":
>     false");
>      > +
>      > +                             branch = branch_get(branch_name);
>      > +                             if (branch && branch->merge &&
>     branch->merge[0] && branch->merge[0]->dst) {
>      > +                                     if (!
>     stat_tracking_info(branch, &ahead, &behind, NULL, 0, 0)) {
>      > +                                             fprintf(s->fp, ",
>     \n    \"ahead\": %d,\n    \"behind\": %d", ahead, behind);
>      > +                                     }
>      > +                             }
>      > +                     } else {
>      > +                             fprintf(s->fp, "    \"current\":
>     \"%s\",\n", s->branch);
>      > +                             fprintf(s->fp, "    \"detached\":
>     false");
>      > +                     }
>      > +             }
>      > +     } else {
>      > +             fprintf(s->fp, "    \"current\": null,\n");
>      > +             fprintf(s->fp, "    \"detached\": false");
>      > +     }
>      > +
>      > +     fprintf(s->fp, "\n  }");
>      > +}
>      > +
>      > +static void wt_json_status_print(struct wt_status *s)
>      > +{
>      > +     fprintf(s->fp, "{\n");
>      > +
>      > +     wt_json_print_branch_info(s);
>      > +     fprintf(s->fp, ",\n");
>      > +
>      > +     wt_json_print_change_array(s, "staged", WT_STATUS_UPDATED);
>      > +     fprintf(s->fp, ",\n");
>      > +
>      > +     wt_json_print_change_array(s, "unstaged", WT_STATUS_CHANGED);
>      > +     fprintf(s->fp, ",\n");
>      > +
>      > +     wt_json_print_string_array(s, "untracked", &s->untracked);
>      > +
>      > +     if (s->ignored.nr <http://ignored.nr> > 0) {
>      > +             fprintf(s->fp, ",\n");
>      > +             wt_json_print_string_array(s, "ignored", &s->ignored);
>      > +     }
>      > +
>      > +     fprintf(s->fp, "\n}\n");
>      > +}
>      > +
>      >   void wt_status_print(struct wt_status *s)
>      >   {
>      >       trace2_data_intmax("status", s->repo, "count/changed", s-
>      >change.nr <http://change.nr>);
>      > @@ -2583,6 +2678,9 @@ void wt_status_print(struct wt_status *s)
>      >       case STATUS_FORMAT_PORCELAIN_V2:
>      >               wt_porcelain_v2_print(s);
>      >               break;
>      > +     case STATUS_FORMAT_JSON:
>      > +             wt_json_status_print(s);
>      > +             break;
>      >       case STATUS_FORMAT_UNSPECIFIED:
>      >               BUG("finalize_deferred_config() should have been
>     called");
>      >               break;
>      > diff --git a/wt-status.h b/wt-status.h
>      > index 4e377ce62b8..e929af832b2 100644
>      > --- a/wt-status.h
>      > +++ b/wt-status.h
>      > @@ -74,6 +74,7 @@ enum wt_status_format {
>      >       STATUS_FORMAT_SHORT,
>      >       STATUS_FORMAT_PORCELAIN,
>      >       STATUS_FORMAT_PORCELAIN_V2,
>      > +     STATUS_FORMAT_JSON,
>      >
>      >       STATUS_FORMAT_UNSPECIFIED
>      >   };
>      >
>      > base-commit: cb3b40381e1d5ee32dde96521ad7cfd68eb308a6
> 

