Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19BDE1F462
	for <e@80x24.org>; Wed, 29 May 2019 13:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfE2NUY (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 09:20:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51084 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfE2NUX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 09:20:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id f204so1688530wme.0
        for <git@vger.kernel.org>; Wed, 29 May 2019 06:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5z1m3TpLww6eVPKc6o3YofU14vxs+SooZz+vzG1TBnQ=;
        b=UjpzwNC6YmGsYO60Mp9qC0QCsHTVy6GcxrG50CUcHDDOqFNiF5PXUh8xLGWkfoBgqB
         toLoI23GNmouewrS8HhhX2KQ5rNqcc4Rva571jzjxfQuF8fDTAKS5DIZqpsApNArYRKr
         EAPeG0MK7mWtTW1M0tQKaR8hauAA9+OGeaQBWlJ3GijzViXt2I2ZT0Wo7bmHSocixuAC
         /MpUw3rE9tR2G5+eUWuhS3DJu1+IGeXQGjV6lKufWbm+kxvDqmlrHlW8/z68jczIoobD
         NAbDtYAxbNysarTWS8VPF/FjvyDQG9fupQBJQ3I8FHhbc8j+AM6/yH1TPfmtq2KdcjGr
         aoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5z1m3TpLww6eVPKc6o3YofU14vxs+SooZz+vzG1TBnQ=;
        b=nvogW8Xcw5jpCLakFqfMzJuUGdAXCBrrYvQEURNu1hP3joRKEdDF0MYK022AaFWEBz
         jLsP4tEeGg2BzvZcSsf0K1zjMhGkPzDyxwid3Cbqf/BxBJ7F8YaDrGMW4HoXXHuW5b1E
         l4vSOs61atUFCoIyTtSNeefVA1Je2uysKev5HSkaWpXfKbmmN8pRb8ySIOjfFTGCPn+a
         CI0CZk83nAp9JvkWQeGA0gYsv7UpSA0Zqvmhw/PYsKMDhoAG5VDUtY6QlW4647sGHBaG
         9U7dvbpnD5EGpXsy0lwzLqsuPXPYuE/t7ZmXWVHrkDHHKSvmzwvetTc22/OoK+FRpHXT
         7KAw==
X-Gm-Message-State: APjAAAXD8Cbf1F+FCCuAWAwJoVipbIsIquZy3jBwJfuWQC8wV3lL4gfc
        YTpE6G94R9t5SHkGb7zi9t8=
X-Google-Smtp-Source: APXvYqyQdcsUkEQTBAcC0EYSs40vPNyXJACdvt4DJLvb7q6h8f05ND6EhnrAjpgzXEEe+cRh8OdMMg==
X-Received: by 2002:a7b:c943:: with SMTP id i3mr6641822wml.128.1559136020748;
        Wed, 29 May 2019 06:20:20 -0700 (PDT)
Received: from szeder.dev (x4db54514.dyn.telefonica.de. [77.181.69.20])
        by smtp.gmail.com with ESMTPSA id c131sm6923015wma.31.2019.05.29.06.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 06:20:19 -0700 (PDT)
Date:   Wed, 29 May 2019 15:20:17 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Jeff King <peff@peff.net>, Alexander Huynh <alex@grande.coffee>,
        git <git@vger.kernel.org>
Subject: Re: git-clone --config remote.origin.fetch regression
Message-ID: <20190529132017.GM951@szeder.dev>
References: <CAFQ2z_O7rupGS4rntiUwJCHUj3bO0U88bVAToveEo_uU0Eu96w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFQ2z_O7rupGS4rntiUwJCHUj3bO0U88bVAToveEo_uU0Eu96w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 28, 2019 at 07:34:58PM -0300, Han-Wen Nienhuys wrote:
> (see also https://github.com/google/zoekt/issues/81)
> 
> It looks like git 2.21 included a regression. The command
> 
> git clone --bare --progress \
>   --config "remote.origin.fetch=+refs/heads/*:refs/heads/*" \
>   https://github.com/google/zoekt.git \
>   /tmp/zoekt-git2.20.git
> 
> would succeed with git 2.20, but fails with
> 
>  fatal: multiple updates for ref 'refs/heads/master' not allowed
> 
> in git 2.21, probably caused by commit 515be83.
> 
> Should I call git in another way? I originally included
> "remote.origin.fetch=+refs/heads/*:refs/heads/*" to avoid getting
> Gerrit refs (refs/changes/*), but maybe I should use a different
> incantation?

On first sight I was wondering why you don't use '--mirror', but yeah,
that would fetch 'refs/changes/*' as well (the whole 'refs/*',
really).  In the meantime a workaround would be to run separate
commands to accomplish what 'git clone' would do under the hood:

  git init --bare zoekt.git
  cd zoekt.git
  git config remote.origin.url https://github.com/google/zoekt.git
  git config remote.origin.fetch '+refs/heads/*:refs/heads/*'
  git fetch


This is indeed caused by 515be83382 (clone: respect additional
configured fetch refspecs during initial fetch, 2018-11-14): since 
then the same refspec comes up twice in remote->fetch, once from the
configuration that you specified on the command line and once from the
default refspec that 'git clone' would have used anyway, and in the
end 'git clone' tries to write each ref twice, once for each of those
two refspecs, in a single ref transaction, hence the error.

I'm not quite sure how to properly handle the situation.  The patch at
the bottom makes your case (and the case in an earlier report [1])
work by omitting 'git clone's default refspec if one of the configured
refspecs have the same destination side as the default refspec.  I
think this is a step in the right-ish direction, but there are some
open questions:

  - Should it only check the destination side of the refspecs, or the
    source as well?  IOW, in case of e.g.

      git clone --bare \
                -c 'remote.origin.fetch=refs/foo/*:refs/heads/*' ...

    should it only fetch from 'refs/foo/*' or both from 'refs/foo/*'
    and 'refs/heads/*'?  With the patch below it's only 'refs/foo/*'.
    If we were to fetch from both, then I expect trouble when both
    'refs/foo/feature' and 'refs/heads/feature' happen to exist, but
    this is a more general issue not limited to 'git clone -c ...'.

  - Even if it were to check the source side of the refspec, it should
    ignore the optional leading '+' in the refspecs, because otherwise
    the command

      # no leading '+' in the additional configured refspec
      git clone --bare \
                -c 'remote.origin.fetch=refs/heads/*:refs/heads/*' ...

    would lead to the same error, because the default refspec for
    '--bare' is '+refs/heads/*:refs/heads/*'.

    (Sidenote: 'git clone's default refspec always has the leading
    '+', but I think that's unnecessary, because during cloning there
    are no existing refs to be updated in the first place.)

  - What should be written to the configuration?  Writing the default
    refspec configuration uses a different logic than assembling the
    default refspec for the initial fetch.  As a result, even if the
    default refspec is not used in the initial fetch, the command

      # no leading '+' in the additional configured refspec
      git clone \
        -c 'remote.origin.fetch=refs/heads/*:refs/remotes/origin/*' ...

    will still write it to the config, resulting in:

      $ git config --get-all remote.origin.fetch
      refs/heads/*:refs/remotes/origin/*
      +refs/heads/*:refs/remotes/origin/*

    Alas, we can't simply avoid writing the default refspec to the
    configuration if it matches one of the additional configured
    refspecs from the command line, because there is

      git -c remote.origin.fetch=<refspec> clone ...

    as well...

  - Alternatively, we could make ref transactions a bit more lax about
    duplicated entries, and ignore multiple updates to the same ref if
    all of those ref updates want to do the same thing, i.e. have the
    same old and new OID.  However, the issue with writing the
    configuration would still remain.


[1] https://public-inbox.org/git/20190307214447.GA4909@chabuduo/

 --- >8 ---

Subject: [PATCH] [PoC] clone: avoid redundant default refspec

---
 builtin/clone.c         | 19 ++++++++++++++++++-
 t/t5611-clone-config.sh | 15 +++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 85b0d3155d..f104510cfe 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -907,6 +907,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	struct remote *remote;
 	int err = 0, complete_refs_before_fetch = 1;
 	int submodule_progress;
+	int i, add_default_refspec = 1;
+	const char *default_refspec_dst;
 
 	struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
 
@@ -1093,7 +1095,22 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	strbuf_addf(&default_refspec, "+%s*:%s*", src_ref_prefix,
 		    branch_top.buf);
-	refspec_append(&remote->fetch, default_refspec.buf);
+	/*
+	 * Don't add the default refspec if the user specified an additional
+	 * refspec in the configuration whose destination matches the
+	 * destination of the default refspec, because then both would want
+	 * to update the same ref(s), leading to "multiple updates" error
+	 * from the refs transaction.
+	 * TODO: Or should it check both the source and the destination?
+	 */
+	default_refspec_dst = strchr(default_refspec.buf, ':') + 1;
+	for (i = 0; i < remote->fetch.nr; i++)
+		if (!strcmp(default_refspec_dst, remote->fetch.items[i].dst)) {
+			add_default_refspec = 0;
+			break;
+		}
+	if (add_default_refspec)
+		refspec_append(&remote->fetch, default_refspec.buf);
 
 	transport = transport_get(remote, remote->url[0]);
 	transport_set_verbosity(transport, option_verbosity, option_progress);
diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
index 60c1ba951b..e63eec2894 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -92,6 +92,21 @@ test_expect_success 'clone -c remote.<remote>.fetch=<refspec> --origin=<name>' '
 	test_cmp expect actual
 '
 
+test_expect_success 'clone -c remote.origin.fetch=<refspec> matches the default refspec' '
+	rm -rf child &&
+	git clone -c "remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*" \
+		. child &&
+	# TODO: look, the same refspec is stored in the config twice:
+	git -C child config --get-all remote.origin.fetch &&
+	git -C child for-each-ref --format="%(refname)" >actual &&
+	cat >expect <<-\EOF &&
+	refs/heads/master
+	refs/remotes/origin/HEAD
+	refs/remotes/origin/master
+	EOF
+	test_cmp expect actual
+'
+
 # Tests for the hidden file attribute on windows
 is_hidden () {
 	# Use the output of `attrib`, ignore the absolute path
-- 
2.22.0.rc1.423.g9b4f2abbc5
