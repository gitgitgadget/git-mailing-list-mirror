Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B71941F454
	for <e@80x24.org>; Fri,  8 Nov 2019 21:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfKHVsp (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 16:48:45 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40922 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbfKHVsp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 16:48:45 -0500
Received: by mail-pf1-f193.google.com with SMTP id r4so5596936pfl.7
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 13:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F8+sz6x1/l8jFo6v0oWxL4vMEtfbX06W3BXm3EM/IVM=;
        b=Z/xhvWyOe9nYRqdTZj9j0a4cI8jF/GZwfDpxDDtj4O4R2+S6FPAXG4We65TnWAwEcj
         3LLhdsCvaI4eCJw5nL77VFTuCXJJOgkxP41SXOPVGXOl0Wk5jKsedI9vVIT+6ej75Y22
         mndbrclEeYzLsHsjO0gkC7zKFqznCJKvpVKzag74kY63xCJwckGkP/qAdPU2wlRtEtv9
         DLFWIc6qtxODyztfUH7K5EJ1K+gpbIcBpQ0sY1RmB3q+Dsegw4MP9PtRUWCE8ojk2vVY
         0wEjYrpgE7UyRPtCr0LYERvZ5vHzhjmCQmd5UYmVmojCrZyJu22H46Rzhm0i7i9oxFqR
         gNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F8+sz6x1/l8jFo6v0oWxL4vMEtfbX06W3BXm3EM/IVM=;
        b=IK01vtSFJ3ZU5GwmYCNSuZcEteInQrATi6/UwAj1WnA4FPe0b+HoEvLxNF+O4WvZmr
         IpVY6BL6F39LVEOmVyiO6318AKKJtNicAB2IhIDRSug1klSztg6puiDZWKFnTVglhQM2
         HlaVAIlyJbNzjS9G6rFKweHqpTPRUjOYY/Rma50VqxM3CGgmhVnky7Bc1oDcKWwl/+Yh
         KY4Xx03mNC9PgwhgKj653gyYc7n1FSEQdvb5VYsyfUYWTLpPZPWbX3Hf2Qdux/19OIPk
         bwtP79hmyqFORXgjaB9D5Ccp3S+NgEwYogwd99+Ns56dotQh9xXKpl+sIEOPHKlKOajO
         /KSg==
X-Gm-Message-State: APjAAAV25ta96QB2OQg9OXumiaJEhna9VUmqsly6UzGngD6gY1feOimT
        8P0Qv8Y1dSJJhhr60eM4+VK3sgfTdNI=
X-Google-Smtp-Source: APXvYqypwBCA/eGI7hF25qyuEBfuzD/5Z7VoeJlKtkH5DWvwu/XaET8dlSSjxlxjlqj8Hhgj/RRP/w==
X-Received: by 2002:a62:fb0f:: with SMTP id x15mr15115060pfm.59.1573249723076;
        Fri, 08 Nov 2019 13:48:43 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id x10sm6203996pgl.53.2019.11.08.13.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 13:48:42 -0800 (PST)
Date:   Fri, 8 Nov 2019 13:48:37 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 3/9] bugreport: add version and system information
Message-ID: <20191108214757.GB22855@google.com>
References: <20191025025129.250049-1-emilyshaffer@google.com>
 <20191025025129.250049-4-emilyshaffer@google.com>
 <nycvar.QRO.7.76.6.1910281432180.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910281432180.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 28, 2019 at 02:49:29PM +0100, Johannes Schindelin wrote:
> Hi Emily,
> 
> On Thu, 24 Oct 2019, Emily Shaffer wrote:
> 
> > diff --git a/bugreport.c b/bugreport.c
> > new file mode 100644
> > index 0000000000..ada54fe583
> > --- /dev/null
> > +++ b/bugreport.c
> > @@ -0,0 +1,55 @@
> > +#include "cache.h"
> > +
> > +#include "bugreport.h"
> > +#include "help.h"
> > +#include "run-command.h"
> > +#include "version.h"
> > +
> > +void get_system_info(struct strbuf *sys_info)
> > +{
> > +	struct child_process cp = CHILD_PROCESS_INIT;
> > +	struct strbuf std_out = STRBUF_INIT;
> > +
> > +	strbuf_reset(sys_info);
> > +
> > +	// get git version from native cmd
> 
> Please use C-style comments instead of C++ ones.
> 
> > +	strbuf_addstr(sys_info, "git version: ");
> > +	strbuf_addstr(sys_info, git_version_string);
> > +	strbuf_complete_line(sys_info);
> > +
> > +	// system call for other version info
> > +	argv_array_push(&cp.args, "uname");
> > +	argv_array_push(&cp.args, "-a");
> > +	capture_command(&cp, &std_out, 0);
> 
> Mmmkay. I am not too much of a fan of relying on the `uname` executable,
> as it can very well be a 32-bit `uname.exe` on Windows, which obviously
> would _not_ report the architecture of the machine, but something
> misleading.
> 
> Why not use the `uname()` function (that we even define in
> `compat/mingw.c`)?

Very glad to have your review and point this kind of thing out. :) It
simplifies the code, too. I wasn't sure about these system calls, so I
appreciate you suggesting alternatives.

> 
> Also, why not include the same information as `git version
> --build-options`, most importantly `GIT_HOST_CPU`?
> 
> In any case, if you are capturing the output of `uname -a`, you
> definitely will want to pass the `RUN_COMMAND_STDOUT_TO_STDERR` flag (in
> case, say, the MSYS2 `uname.exe` fails with those dreaded Cygwin error
> messages like "*** fatal error - add_item
> ("\??\D:\git\installation\Git", "/", ...) failed, errno 1").
> 
> > +
> > +	strbuf_addstr(sys_info, "uname -a: ");
> > +	strbuf_addbuf(sys_info, &std_out);
> > +	strbuf_complete_line(sys_info);
> > +
> > +	argv_array_clear(&cp.args);
> > +	strbuf_reset(&std_out);
> > +
> > +
> > +	argv_array_push(&cp.args, "curl-config");
> > +	argv_array_push(&cp.args, "--version");
> > +	capture_command(&cp, &std_out, 0);
> 
> This will be almost certainly be incorrect, as most _regular_ users
> won't have `curl-config`. I know, it is easy to forget that most Git
> users are no hard-core C developers ;-)

Heresy! :)

> 
> A better alternative would be to use `curl_version()`, guarded, of
> course, by `#ifndef NO_CURL`...
> 
> > +
> > +	strbuf_addstr(sys_info, "curl-config --version: ");
> > +	strbuf_addbuf(sys_info, &std_out);
> > +	strbuf_complete_line(sys_info);
> > +
> > +	argv_array_clear(&cp.args);
> > +	strbuf_reset(&std_out);
> > +
> > +
> > +	argv_array_push(&cp.args, "ldd");
> > +	argv_array_push(&cp.args, "--version");
> > +	capture_command(&cp, &std_out, 0);
> 
> Again, this command will only be present in few setups. I am not
> actually sure that the output of this is interesting to begin with.

It was a suggestion, I believe, from Jonathan Nieder.

> 
> What I _do_ think is that a much more interesting piece of information
> would be the exact GLIBC version, the OS name and the OS version.

The glibc version is easy; I've done that. It certainly looks nicer than
the ldd call.

I guess I may be missing something, because as I start to look into how
to the OS info, I fall down a hole of many, many preprocessor defines to
check. If that's the approach you want me to take, just say the word,
but it will be ugly :) I suppose I had hoped the uname info would give us
a close enough idea that full OS info isn't necessary.

> 
> > +
> > +	strbuf_addstr(sys_info, "ldd --version: ");
> > +	strbuf_addbuf(sys_info, &std_out);
> > +	strbuf_complete_line(sys_info);
> > +
> > +	argv_array_clear(&cp.args);
> > +	strbuf_reset(&std_out);
> > +}
> > diff --git a/bugreport.h b/bugreport.h
> > new file mode 100644
> > index 0000000000..ba216acf3f
> > --- /dev/null
> > +++ b/bugreport.h
> > @@ -0,0 +1,7 @@
> > +#include "strbuf.h"
> > +
> > +/**
> > + * Adds the Git version, `uname -a`, and `curl-config --version` to sys_info.
> > + * The previous contents of sys_info will be discarded.
> > + */
> > +void get_system_info(struct strbuf *sys_info);
> > diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> > index 2ef16440a0..7232d31be7 100644
> > --- a/builtin/bugreport.c
> > +++ b/builtin/bugreport.c
> > @@ -1,4 +1,5 @@
> >  #include "builtin.h"
> > +#include "bugreport.h"
> >  #include "stdio.h"
> >  #include "strbuf.h"
> >  #include "time.h"
> > @@ -27,6 +28,13 @@ int get_bug_template(struct strbuf *template)
> >  	return 0;
> >  }
> >
> > +void add_header(FILE *report, const char *title)
> > +{
> > +	struct strbuf buffer = STRBUF_INIT;
> > +	strbuf_addf(&buffer, "\n\n[%s]\n", title);
> > +	strbuf_write(&buffer, report);
> 
> This leaks `buffer`. Why not write into `report` via `fprintf()`
> directly?

Rather, to match the style of the rest of the builtin, modified
get_header to add the header to a passed-in strbuf instead of
modifying the file directly.

> 
> Ciao,
> Dscho
> 
> > +}
> > +
> >  int cmd_bugreport(int argc, const char **argv, const char *prefix)
> >  {
> >  	struct strbuf buffer = STRBUF_INIT;
> > @@ -43,6 +51,11 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
> >  	get_bug_template(&buffer);
> >  	strbuf_write(&buffer, report);
> >
> > +	// add other contents
> > +	add_header(report, "System Info");
> > +	get_system_info(&buffer);
> > +	strbuf_write(&buffer, report);
> > +
> >  	fclose(report);
> >
> >  	launch_editor(report_path.buf, NULL, NULL);
> > --
> > 2.24.0.rc0.303.g954a862665-goog
> >
> >


Based on Dscho's comments, each piece of system info is gathered
differently enough that I will do each in an independent commit now.
