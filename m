Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59B8D20248
	for <e@80x24.org>; Wed, 10 Apr 2019 11:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbfDJLSm (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 07:18:42 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46070 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbfDJLSm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 07:18:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id bf11so1225538plb.12
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 04:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=09A0mXQFs15UxMWdNJ9XZ9MYfucRobnJ9Y/M51tYG4k=;
        b=mS5swk21fTynojLFHRYtJEX78PBQHGEXNM2qdfqTuFqhuA3xZozE74EafLP+Z4eMti
         lEV5qXBPuqirnxhhk/hKJSdY2SJkpRDODO7adVeC0j3jBnz1UT4A5+BS8pVjkFfiI/Bc
         oPzauglOohoRgabTlaBujZaoIc6po2X2glP33LyobjscqCuQl4KU5D+m7Nn/osN31tra
         qnbFRCninGZKUus1v7rBSDzHq/5Sa/aHxw1nJfF7c93DMlfCbIrqaOFi3J9p2Wz/Pho7
         w9L2GeYG4FzfsWoXOTnpONmfYCMQf2RD3K+w2reZjzFcb42RVlMQQ0wcBGLXlcp/BX2w
         NneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=09A0mXQFs15UxMWdNJ9XZ9MYfucRobnJ9Y/M51tYG4k=;
        b=ewjkEOq2iOr0hwxEFrPQcQslVPYwQsAi0dbl+1SUZxmzEX2jq+ScO2v9EvHo8FTX0h
         0DoXknJB95BFdxYNiDqykC9qXTQtLRmk5xEDYdVva5fvZwwF9DwzxWyLrM/PTsT9bcx7
         EwjzOGVzZ3Zi2XlHaNlzIhUCZ0zGsxnBw+nmj2kkVIhzH15fNX/63dZ25CqWlI1gtVlN
         keoGH7S5VvpKH9HxSWQpsrSUg+XXmC0vemInuxdfphtp5CZqEWpxo5X/blaopGyuSEEU
         HyoZLFQiiu3nlVutd2PpnskRbp9ircJYGYDcnusePxlsbrd8/EBIkIrfhHySheNwxi6J
         ykOQ==
X-Gm-Message-State: APjAAAVqD7AYaR1syF7N8z4ZEd5kedtZ68ymsL08eVq/wyJk4cDtP7jh
        lR+MnwzjH7xNTCpzfITfWoA=
X-Google-Smtp-Source: APXvYqwhau+ir6lmYIbG4hPR0RLr7iDwjtJBw+6ZX1D8BYHcLNBUtk4wN7vqR+Jktz1tUTeQcoipng==
X-Received: by 2002:a17:902:5ac4:: with SMTP id g4mr41219948plm.261.1554895120825;
        Wed, 10 Apr 2019 04:18:40 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id a6sm49313871pfn.181.2019.04.10.04.18.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 04:18:39 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 10 Apr 2019 18:18:35 +0700
Date:   Wed, 10 Apr 2019 18:18:35 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: regression AGAIN in output of git-pull --rebase
 --recurse-submodules=yes --quiet
Message-ID: <20190410111834.GA25638@ash>
References: <robbat2-20180120T054223-685328376Z@orbis-terrarum.net>
 <robbat2-20190410T062730-540884809Z@orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <robbat2-20190410T062730-540884809Z@orbis-terrarum.net>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 10, 2019 at 06:41:05AM +0000, Robin H. Johnson wrote:
> A year ago, I raised <robbat2-20190410T062730-540884809Z@orbis-terrarum.net> as an issue,
> which lead to commit commit a56771a668dd4963675914bc5da0e1e015952dae.
> 
> The exact same workload somewhere between 2.18.0 and 2.19.0 has caused
> the message to come back. I noticed it first in a 2.18.0->2.21.0
> upgrade, and did a partial bisect based on tags to trace it to 2.19.0.
> 
> ===
> $ git submodule foreach --quiet git pull origin master --quiet >/dev/null
> From git://anongit.gentoo.org/data/gentoo-news
>  * branch            master     -> FETCH_HEAD
> From git://anongit.gentoo.org/data/glep
>  * branch            master     -> FETCH_HEAD
> ===

If you run this with GIT_TRACE=1, you can see that --quiet is passed
to submodule--helper correctly.

trace: built-in: git submodule--helper foreach --quiet git pull --quiet origin master

The problem here is the option parser of this command would try to
parse all options, so it considers both --quiet the same thing and are
to tell "submodule--foreach" to be quiet, the second --quiet is not
part of the "git pull" command anymore.

So the fix would be to pass "--" to stop option parsing.
submodule--helper should not parse options it does not understand
anyway. Something like this should work.

-- 8< --
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6bcc4f1bd7..6394222628 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -571,7 +571,7 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, module_foreach_options,
-			     git_submodule_helper_usage, PARSE_OPT_KEEP_UNKNOWN);
+			     git_submodule_helper_usage, 0);
 
 	if (module_list_compute(0, NULL, prefix, &pathspec, &list) < 0)
 		return 1;
diff --git a/git-submodule.sh b/git-submodule.sh
index 2c0fb6d723..a967b2890d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -346,7 +346,7 @@ cmd_foreach()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper foreach ${GIT_QUIET:+--quiet} ${recursive:+--recursive} "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper foreach ${GIT_QUIET:+--quiet} ${recursive:+--recursive} -- "$@"
 }
 
 #
-- 8< --

I'm a bit reluctant to follow up with a proper patch because I can't
digest the t5572-submodule-pull.sh tests. And we definitely need to
add a test case about --quiet to make sure it won't happen again.
--
Duy

> 
> I suspect it was a result of:
> ea27893a65cc41cad2710466aa6a58866ff22f1e Merge branch 'pc/submodule-helper-foreach'
> 
> But I haven't done a full bisect to prove it yet.
> 
> On Sat, Jan 20, 2018 at 05:57:29AM +0000, Robin H. Johnson wrote:
> > Somewhere between 2.13.6 & 2.14.1 there's an output regression. I
> > haven't done a bisect to trace it down further yet.
> > 
> > Specifically, --rebase --recurse-submodules=yes seems to cause --quiet
> > to not be effective anymore.
> > 
> > Full commandline:
> > $ git pull --rebase --recurse-submodules --quiet
> > 
> > In 2.13.6, there is no output, it's quiet as expect.
> > 
> > In 2.14.1, you get:
> > HEAD is up to date.
> > Submodule path '_data/news': rebased into 'a50b763c338161b4621d23e9fa5cd6e11455d6ca'
> > HEAD is up to date.
> > Submodule path 'glep': rebased into 'e1f100ec3ba44ab1672d61cabf4690b355e46158'
> > 
> > Steps to reproduction:
> > 1. git clone --recurse-submodules \
> >  https://anongit.gentoo.org/git/sites/www.git
> > 2. cd www
> > 3. git submodule foreach --quiet git pull --quiet origin master
> > 4. git pull --rebase --recurse-submodules=yes --quiet
> > 
> > Repeat step 4 for repeated bug output.
> > If you drop the --rebase, then you need to re-run step 3 first.
> > 
> > -- 
> > Robin Hugh Johnson
> > Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
> > E-Mail   : robbat2@gentoo.org
> > GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
> > GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136
> 
> 
> 
> -- 
> Robin Hugh Johnson
> Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
> E-Mail   : robbat2@gentoo.org
> GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
> GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136


