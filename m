Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F7391F6C1
	for <e@80x24.org>; Fri, 19 Aug 2016 03:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754130AbcHSDXC (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 23:23:02 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:35007 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754097AbcHSDXB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 23:23:01 -0400
Received: by mail-it0-f47.google.com with SMTP id x131so16537156ite.0
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 20:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FD99ULyfH1uhNc1r8EE56mMmOePMkUNEJEqDGsYR4UA=;
        b=DG9xEoPT+6u9Epe//ktU3iDULiYMnFrhGXHhhwNz1nAL3Jt8ZsIQ5p1y2uIjFu6ugf
         5fgqy3ftCFKOb7FJnsSPo9ig+YvCfbTeoyEKWeGNKyeo4IvpuihFkOr0Eh33NRkVjvxW
         gHzY0Pk1tzLFCBYRKEs5ZRIskGIsg/KeE8P6BnArnxRqnVD9bf8LQbpq7wkx9ZowfnyO
         W/tjPHjWFitRvXfdJC442KM+vHKqjU8KB5aR6Ekx9o0wVcZHcu7asyTwcVgNEDoyavQa
         3+sby/DQ9OljpAIxDh6vAkS5tZFTTvJz9lIE4edZPSESwuquRuALFZy8feToAT8MY0D+
         XZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FD99ULyfH1uhNc1r8EE56mMmOePMkUNEJEqDGsYR4UA=;
        b=gcvT6iIVzXTazLeJ/d1RsHanNT++LRVPVbPMtqBv01Z4mKfJ0KXrIJeYMd3KEtQz0m
         ZM+8QfOYudWw5PfwSfZHvO6xny8+Q5C7icU8R4TBh7eZ2uUdaha+j6yfbhByvbJNxWZz
         rplWGrUgWtjh/X+xoS23WFhMrF6Oyzjw9sVWyCKzTjeHfIvVIzZlu5UtxFbAFzUeSJr8
         ZrEIRDcjpy46XqgWvLqJvSYhLSoetPBJsHVPY3qppwQiKpPrToUj1dbbWRYIlGm4Fxcg
         J+QwG7EOHhvA/4PjbsJRrN++Gwg1PVOztNqoLs52v4f24kfYcaVmyaNct5CIMz3FYcdh
         dJdg==
X-Gm-Message-State: AEkoout2nEgDVugwaqCd5SzioFbAxyWamO/PdK9efGswsSQBjwCWVfvJzhcxWPWMGauAdiAc9buHSzHNpZa1PGJn
X-Received: by 10.36.228.138 with SMTP id o132mr1076773ith.49.1471544723110;
 Thu, 18 Aug 2016 11:25:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 18 Aug 2016 11:25:22 -0700 (PDT)
In-Reply-To: <20160818005131.31600-6-jacob.e.keller@intel.com>
References: <20160818005131.31600-1-jacob.e.keller@intel.com> <20160818005131.31600-6-jacob.e.keller@intel.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 18 Aug 2016 11:25:22 -0700
Message-ID: <CAGZ79kZdXXe7QwgtK8ZNHS+aKDx5vOc9rvETP9zo+ZCTCX10oQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] submodule: correct output of submodule log format
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 17, 2016 at 5:51 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> The submodule log diff output incorrectly states that the submodule is
> "not checked out" in cases where it wants to say the submodule is "not
> initialized". Change the wording to reflect the actual check being
> performed.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  submodule.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/submodule.c b/submodule.c
> index 1b5cdfb7e784..e1a51b7506ff 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -348,7 +348,7 @@ void show_submodule_summary(FILE *f, const char *path,
>         if (is_null_sha1(two))
>                 message = "(submodule deleted)";
>         else if (add_submodule_odb(path))
> -               message = "(not checked out)";
> +               message = "(not initialized)";

I think "not checked" out is actually correct here.

    $ git clone https://gerrit.googlesource.com/gerrit
    $ cd gerrit
    $ git submodule update --init
      ...
    $ git diff cc82b24..5222e66 plugins/
    Submodule plugins/cookbook-plugin 2d40ee2..69b8f9f:
     > Organize imports
    $ rm -rf plugins/cookbook-plugin/
    $ git diff cc82b24..5222e66 plugins/
    Submodule plugins/cookbook-plugin 2d40ee2...69b8f9f (not checked out)
    $

Mind that by "rm -rf" of the working dir I create the "not checked out,
but initialized state and even cloned state".

So as a long term TODO:
    I guess we could teach `add_submodule_odb` to operate
    inside its git directory instead of its working directory, to have
    it working whenever we have the object database (no matter if
    checked out or not). Although this may collide with the plan of a
    different refs backend? I dunno.

add_submodule_odb is used in a variety of places:
    show_submodule_header
    submodule_needs_pushing
    push_submodule
    is_submodule_commit_present
    merge_submodule

And all of them seem to not require a checkout, but the presence of
objects is fine.
