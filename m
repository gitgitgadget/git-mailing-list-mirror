Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F6341F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 20:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfJ2U3t (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 16:29:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38240 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfJ2U3t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 16:29:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id w3so10420675pgt.5
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 13:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=szsmtsTJvc5Y/93fJu3cf42TJZYaO21zoGbPPuzbrt0=;
        b=KqYTkia3kKBqsvaYWD8lxJt1lpVWLCrFw6WBDetyQfzZRIXou+DYD5+yms7bYxTn9v
         byGYb9idWQIyW50NGye9B1zkjZJCalojUSHbi/AJ2ySGgtVIh9O9v63V4AZlCsVXjmsj
         AsEKcVobn0h29Y0b1RcfAbQ0EnZkbn8yC2XKUf+t+SI7elvZOoP9qdHhz+bLkg8ZVLgV
         P6pK4ZKJL4brR6O0nMe5bXK8TvIdh1sibpQSQbnWt9dsN15V/sMPJTS8T22mnsnYQOme
         mx5r20eW+iGHHn5WnpisrE5zt5GCfmdZ6dnR29OTY3sKw01foE6fBgr56TmZprDq/3YR
         mcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=szsmtsTJvc5Y/93fJu3cf42TJZYaO21zoGbPPuzbrt0=;
        b=ofp4i4+GPtrqNR+l7GlvBXWqI77xmrgHDG9i5FingA/YvleCfHV0lO8yB9azjKwC72
         Rm6K7LNDcO4ePWDCbp0ZgyDpkp4buqA8BbxXs2QBvDwEYglT8wH5Mk2eDsp6AJw+XBI2
         WHRu28GwF+Ksli7Dg8VTn8bPFaE2LCGceBhyndvJYPJ4cF5urYSLTwieX6oyHPv7uWW1
         hkZPnZIJDXEAVnxMkDXwhGKmbW4q74/sYcjz4wZq6wHjU5m5MYFG9NYEKdI1LRtlcsCN
         EWeAW3gS9l3/EHcMXQFikg24Gxv9cWLIZlMvAsOgmqZeVeoLC6qJSsOa7BlJhIBc3AmY
         GgDA==
X-Gm-Message-State: APjAAAU7C7E5dyxlLj3Vwnwj3kl32VS7hIdlYq9+AISEg6nE/NWnAuNq
        XMQp4Sb05Z+ZJunD85u3HDpTMnKPoyo=
X-Google-Smtp-Source: APXvYqy3XigGeDy6ZgS5n/4qptKWgHkrlbBHi6rzLJTLJCQZ1gfjE0T6OZRo3nu1NZxh3yn1hKGzjQ==
X-Received: by 2002:a63:18d:: with SMTP id 135mr30193076pgb.326.1572380987570;
        Tue, 29 Oct 2019 13:29:47 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ece8:7fe:c1f1:a20f])
        by smtp.gmail.com with ESMTPSA id l23sm649936pjy.12.2019.10.29.13.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 13:29:46 -0700 (PDT)
Date:   Tue, 29 Oct 2019 13:29:40 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/9] bugreport: add tool to generate debugging info
Message-ID: <20191029202940.GA12243@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20191025025129.250049-1-emilyshaffer@google.com>
 <20191025025129.250049-2-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191025025129.250049-2-emilyshaffer@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.10.24 19:51, Emily Shaffer wrote:
> Teach Git how to prompt the user for a good bug report: reproduction
> steps, expected behavior, and actual behavior. Later, Git can learn how
> to collect some diagnostic information from the repository.
> 
> If users can send us a well-written bug report which contains diagnostic
> information we would otherwise need to ask the user for, we can reduce
> the number of question-and-answer round trips between the reporter and
> the Git contributor.
> 
> Users may also wish to send a report like this to their local "Git
> expert" if they have put their repository into a state they are confused
> by.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  Makefile            |  1 +
>  builtin.h           |  1 +
>  builtin/bugreport.c | 50 +++++++++++++++++++++++++++++++++++++++++++++
>  git.c               |  1 +
>  4 files changed, 53 insertions(+)
>  create mode 100644 builtin/bugreport.c
> 
> diff --git a/Makefile b/Makefile
> index 58b92af54b..132e2a52da 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1039,6 +1039,7 @@ BUILTIN_OBJS += builtin/archive.o
>  BUILTIN_OBJS += builtin/bisect--helper.o
>  BUILTIN_OBJS += builtin/blame.o
>  BUILTIN_OBJS += builtin/branch.o
> +BUILTIN_OBJS += builtin/bugreport.o
>  BUILTIN_OBJS += builtin/bundle.o
>  BUILTIN_OBJS += builtin/cat-file.o
>  BUILTIN_OBJS += builtin/check-attr.o
> diff --git a/builtin.h b/builtin.h
> index 5cf5df69f7..c6373d3289 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -135,6 +135,7 @@ int cmd_archive(int argc, const char **argv, const char *prefix);
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix);
>  int cmd_blame(int argc, const char **argv, const char *prefix);
>  int cmd_branch(int argc, const char **argv, const char *prefix);
> +int cmd_bugreport(int argc, const char **argv, const char *prefix);
>  int cmd_bundle(int argc, const char **argv, const char *prefix);
>  int cmd_cat_file(int argc, const char **argv, const char *prefix);
>  int cmd_checkout(int argc, const char **argv, const char *prefix);
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> new file mode 100644
> index 0000000000..2ef16440a0
> --- /dev/null
> +++ b/builtin/bugreport.c
> @@ -0,0 +1,50 @@
> +#include "builtin.h"
> +#include "stdio.h"
> +#include "strbuf.h"
> +#include "time.h"
> +
> +int get_bug_template(struct strbuf *template)

Compilation fails here for me with:
  builtin/bugreport.c:6:5: error: no previous prototype
      for ‘get_bug_template’ [-Werror=missing-prototypes]

Can you make this function static?


> +{
> +	const char template_text[] =
> +"Thank you for filling out a Git bug report!\n"
> +"Please answer the following questions to help us understand your issue.\n"
> +"\n"
> +"What did you do before the bug happened? (Steps to reproduce your issue)\n"
> +"\n"
> +"What did you expect to happen? (Expected behavior)\n"
> +"\n"
> +"What happened instead? (Actual behavior)\n"
> +"\n"
> +"What's different between what you expected and what actually happened?\n"
> +"\n"
> +"Anything else you want to add:\n"
> +"\n"
> +"Please review the rest of the bug report below.\n"
> +"You can delete any lines you don't wish to send.\n";
> +
> +	strbuf_reset(template);
> +	strbuf_add(template, template_text, strlen(template_text));
> +	return 0;
> +}
> +
> +int cmd_bugreport(int argc, const char **argv, const char *prefix)
> +{
> +	struct strbuf buffer = STRBUF_INIT;
> +	struct strbuf report_path = STRBUF_INIT;
> +	FILE *report;
> +	time_t now = time(NULL);
> +
> +	strbuf_addstr(&report_path, "git-bugreport-");
> +	strbuf_addftime(&report_path, "%F", gmtime(&now), 0, 0);
> +	strbuf_addstr(&report_path, ".txt");
> +
> +	report = fopen_for_writing(report_path.buf);
> +
> +	get_bug_template(&buffer);
> +	strbuf_write(&buffer, report);
> +
> +	fclose(report);
> +
> +	launch_editor(report_path.buf, NULL, NULL);
> +	return 0;
> +}
> diff --git a/git.c b/git.c
> index ce6ab0ece2..2d6a64f019 100644
> --- a/git.c
> +++ b/git.c
> @@ -473,6 +473,7 @@ static struct cmd_struct commands[] = {
>  	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
>  	{ "blame", cmd_blame, RUN_SETUP },
>  	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
> +	{ "bugreport", cmd_bugreport, RUN_SETUP },
>  	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY | NO_PARSEOPT },
>  	{ "cat-file", cmd_cat_file, RUN_SETUP },
>  	{ "check-attr", cmd_check_attr, RUN_SETUP },
> -- 
> 2.24.0.rc0.303.g954a862665-goog

Can you also add /git-bugreport to .gitignore?

