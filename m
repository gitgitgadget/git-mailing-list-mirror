Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A254C1F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 17:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394004AbfJXRYt (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 13:24:49 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33657 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389384AbfJXRYt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 13:24:49 -0400
Received: by mail-ed1-f67.google.com with SMTP id c4so19282001edl.0
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 10:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/Zg5kouzMcsI3qmZQLOQ7hWMwf43rVeuKwc+6DUdo9U=;
        b=DFcUPoaQBhFquVJUvso3lU32P7B7u5iBlhwnDzu8kUtD1nD3tqQTTnjewKo6G4v3sa
         TCNvx0Z0A1zzZPMMmcaOQkdVamTj1fx/r/rYoSmlqERJt7qYOGAhH+g9z27OLErqvvTe
         /OcO5I5706U/4w0Fo20HovE98ydm5gGUeShzf4NhDz7Jmv240JOVtVbw90ocznFKd7JC
         cH5oFnLclZgfQrJk4/HG0dsf5/TdOec+y+ZpomHKT/MzQJxGi0dx9vYjlcglyTVk1fQw
         VjDtVX9SPjljMgbc16JfCa7BwmMQK5OwwzURWMeqAun8S2jviK9ElpEQQATivKZML79r
         o46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/Zg5kouzMcsI3qmZQLOQ7hWMwf43rVeuKwc+6DUdo9U=;
        b=CfzLTIMMLKHyVObFcUjFwspQSmICAz+DWsP4k+EVLd8Sl1XE4WnP8OM6110loyOhDN
         O+B0Ad6quc4vvvDXj8bYGEPqjjlVaON5pfRobbpvGgj2EF1I5v2WlWyRh2jKnh/MPI/w
         lHnKyW4oPIJbZQzWjX/dv8ySvRy6XbkUTe4jDinOrZzgs7Bj1jjUQFdyBcHIUhI5k6MX
         SBw9+ULNuof9gHTHjWbAniyT+efegUe7wKFPR6JWjMcfPmPsCbtpz54S56yDz7Qde2B5
         ruO4r6n0mlduBwOAPf/AjSttQIQeKolaknxB5hw9yLlYVAjHajrJAvQhXEI6N73RSLiu
         tRDw==
X-Gm-Message-State: APjAAAVRDUW3x3mdwZtbhyDWHu2vr3OVIYbB7Pp6voEQnqdeUnFQ2mmE
        N5WbSz9xkikYS9uzw4itCi0=
X-Google-Smtp-Source: APXvYqzjhNWryo0tvtUg5SsfWJoBLfn3mNZgS7NbwLbn1qt4wKBcUcjuG5UrRvQFA8coZeaN4aUnNw==
X-Received: by 2002:a17:906:5115:: with SMTP id w21mr27604125ejk.32.1571937885450;
        Thu, 24 Oct 2019 10:24:45 -0700 (PDT)
Received: from szeder.dev (x4dbd3359.dyn.telefonica.de. [77.189.51.89])
        by smtp.gmail.com with ESMTPSA id v5sm20312eda.33.2019.10.24.10.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 10:24:44 -0700 (PDT)
Date:   Thu, 24 Oct 2019 19:24:42 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-progress: fix test failures on big-endian systems
Message-ID: <20191024172442.GM4348@szeder.dev>
References: <b0bec82e-ad0a-32f6-e2e6-e1f0e6920639@physik.fu-berlin.de>
 <20190731071755.GF4545@pobox.com>
 <f1ce445e-6954-8e7b-2dca-3a566ce689a5@physik.fu-berlin.de>
 <20191019233706.GM29845@szeder.dev>
 <xmqq36fmor7o.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq36fmor7o.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 21, 2019 at 09:52:11AM +0900, Junio C Hamano wrote:
> I can sympathize, but I do not think it is worth inventing OPT_U64()
> or adding "int total_i" whose value is assigned to "u64 total" after
> parsing a command line arg with OPT_INTEGER() into the former.

I agree, we should wait for the first real use case where specifying a
larger-than-32bit integer actually makes sense in practice.

> Catching a pointer whose type is not "int*" passed at the third
> position of OPT_INTGER() mechanically may be worth it, though.
> Would Coccinelle be a suitable tool for that kind of thing?

The semantic patch below will do that, but this is one of those "I
don't have the slightest idea what I am doing" patches...

It's output looks like this when applied to an older version without
the big-endian fix upthread:

  potential error at apply.c:4982:26:
    passing variable 'state -> p_context' of type 'unsigned int' to OPT_INTEGER
    OPT_INTEGER expects an int
  potential error at builtin/column.c:29:30:
    passing variable 'colopts' of type 'unsigned int' to OPT_INTEGER
    OPT_INTEGER expects an int
  potential error at builtin/column.c:32:24:
    passing variable 'copts . nl' of type 'const char *' to OPT_INTEGER
    OPT_INTEGER expects an int
  potential error at builtin/grep.c:884:38:
    passing variable 'opt . pre_context' of type 'unsigned' to OPT_INTEGER
    OPT_INTEGER expects an int
  potential error at builtin/grep.c:886:37:
    passing variable 'opt . post_context' of type 'unsigned' to OPT_INTEGER
    OPT_INTEGER expects an int
  potential error at builtin/upload-pack.c:28:29:
    passing variable 'opts . timeout' of type 'unsigned int' to OPT_INTEGER
    OPT_INTEGER expects an int
  potential error at t/helper/test-progress.c:42:27:
    passing variable 'total' of type 'uint64_t' to OPT_INTEGER
    OPT_INTEGER expects an int

  https://travis-ci.org/szeder/git/jobs/602423358#L436

I think most of them are harmless, like the number of context lines in
apply and grep, or the timeout in seconds in upload-pack.  So I think
the semantic patch should allow 'unsigned' and 'unsigned int' as well.

But note the one in 'builtin/column.c', where we pass a 'const char
*' to OPT_INTEGER.  That can't possibly be good; I suspect copy-paste
error and it should have been OPT_STRING.


 --- >8 ---

Subject: [PATCH] coccinelle: warn about passing a non-int to parse-options'
 OPT_INTEGER

parse-options' OPT_INTEGER wants to parse an integer argument into a
variable of type 'int', and passing e.g. an 'uint64_t' causes troubles
[1].

Add a Coccinelle semantic patch that checks the type of the variable
where the integer argument should be parsed into, and print an error
if that variable is not of type 'int'.

Note that this semantic patch won't result in a proper and applicable
patch, because who knows where that variable of the inappropriate type
is defined.  However, the printed error message will still cause our
static analysis CI jobs to fail, drawing our attention to the issue.

TODO: refusing an 'unsigned int' might be unnecessarily harsh...

[1] 11a803d861 (test-progress: fix test failures on big-endian
    systems, 2019-10-20)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/coccinelle/parse-options.cocci | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 contrib/coccinelle/parse-options.cocci

diff --git a/contrib/coccinelle/parse-options.cocci b/contrib/coccinelle/parse-options.cocci
new file mode 100644
index 0000000000..e0cddef421
--- /dev/null
+++ b/contrib/coccinelle/parse-options.cocci
@@ -0,0 +1,18 @@
+@ optint @
+identifier opts;
+type T;
+T var;
+expression SHORT, LONG, HELP;
+position p;
+@@
+struct option opts[] = { ..., OPT_INTEGER(SHORT, LONG, &var@p, HELP), ...};
+
+@ script:python @
+p << optint.p;
+var << optint.var;
+vartype << optint.T;
+@@
+if vartype != "int":
+	print "potential error at %s:%s:%s:" % (p[0].file, p[0].line, p[0].column)
+	print "  passing variable '%s' of type '%s' to OPT_INTEGER" % (var, vartype)
+	print "  OPT_INTEGER expects an int"
-- 
2.24.0.rc0.502.g7008375535


