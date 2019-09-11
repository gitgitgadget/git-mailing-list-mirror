Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1A2F1F463
	for <e@80x24.org>; Wed, 11 Sep 2019 20:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfIKU2t (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 16:28:49 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32936 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbfIKU2s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 16:28:48 -0400
Received: by mail-qt1-f193.google.com with SMTP id r5so26983270qtd.0
        for <git@vger.kernel.org>; Wed, 11 Sep 2019 13:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L/F+veVJWO91GtrCkgJIsYP+Tf7UDx1NLsCNw9Td/AY=;
        b=vKhCKyDAjkwZpMnUJYBqOiLtY2aCDQku2jD5Y/XqSwC9VqQsR2PPXL0CLJ9Hbhc+7f
         bRwx5ryWj2nGGqunuajOlMkxvLvThDeyovPowDaLZySWFvlSShl08SkEct3CA8IatLZW
         uypQoL8m9aH2jouF08Vg/037HxeWnbfvmo8rdOtkuqAQe8ALYy60zbH9lUdoZG1IPf+8
         C3Ej8RcGJeGg/lxa9xHeuQI2O/jTBApmURjRv1ooMukAdzbof+1rbOWc01/8/6UI8dD7
         xMS6LhUlvzqU3axtMeLjOZOvtD1fKHRWOj4cSTk+Nvku4mxm5uOIbsqGsEFmFcZo77pg
         9IJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L/F+veVJWO91GtrCkgJIsYP+Tf7UDx1NLsCNw9Td/AY=;
        b=eDipDd6jvusBaCYJk+Y2KC5HzQ272zjhvWpq3uHCglxCMmZNRFozkyf5TZF8b40wFx
         nE7BuXeX+b3h6O1mIXDReNE0Kw08hm+G5aEHQdSNoJfXUyC+vmgeFs6Eo0CiT2XIKQmy
         8N3Z/N0Ru85emaUefZf3Wfv7xX8KKZ8Kc1YiFozjJ4Ej3mcU7WgRNLbGhdE8BjX9jcZV
         Dy/2NNi+G+uARQTo86+NWgfthvTcDZKnGd2xOInymOSOcs7moUCTBmCYoJCVf+9V6iIO
         rdga9oZCd/acjKjI64VWJxSB7Y9gy/L0OzSqiIvP+cB8GWDPLmTZANllQR06yKktPEXN
         9vwQ==
X-Gm-Message-State: APjAAAVzYiFlOucWRMuY23t2ErJJkX1C35/gtJPHJbGVGbcgJ+VP8bhd
        1tIt5qv4uCWHfDzC4ADSKPg=
X-Google-Smtp-Source: APXvYqzs00CNioyWgeV2jD9WKQUTLKlS1Z/uQVmJePCkzdZLTp2GMnfc2uM2u1LHHbHnU5ZHFBoTQg==
X-Received: by 2002:ac8:3482:: with SMTP id w2mr4676899qtb.379.1568233727372;
        Wed, 11 Sep 2019 13:28:47 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4d96:7f18:9479:c2b0? ([2001:4898:a800:1010:fecb:7f18:9479:c2b0])
        by smtp.gmail.com with ESMTPSA id i23sm9495077qkl.107.2019.09.11.13.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2019 13:28:46 -0700 (PDT)
Subject: Re: [PATCH 2/9] sparse-checkout: create 'init' subcommand
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.316.git.gitgitgadget@gmail.com>
 <e6e982e5a6e4517d97a7a404384057110f3a151d.1566313865.git.gitgitgadget@gmail.com>
 <CABPp-BEmwSwg4tgJg6nVG8a3Hpn_g-=ZjApZF4EiJO+qVgu4uw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ab98c292-a1b1-ff47-2e8e-f74b7ade2b94@gmail.com>
Date:   Wed, 11 Sep 2019 16:28:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEmwSwg4tgJg6nVG8a3Hpn_g-=ZjApZF4EiJO+qVgu4uw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/23/2019 7:02 PM, Elijah Newren wrote:
> On Tue, Aug 20, 2019 at 8:13 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> +static int sc_read_tree(void)
>> +{
>> +       struct argv_array argv = ARGV_ARRAY_INIT;
>> +       int result = 0;
>> +       argv_array_pushl(&argv, "read-tree", "-m", "-u", "HEAD", NULL);
>> +
>> +       if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
>> +               error(_("failed to update index with new sparse-checkout paths"));
>> +               result = 1;
>> +       }
> 
> `git read-tree -m -u HEAD` will fail if the index has any higher stage
> entries in it, even if those higher stage entries correspond to files
> which are included in the sparseness patterns and thus would not need
> an update.  It might be nice if we can find a way to provide a better
> error message, and/or implement the read-tree -m -u HEAD internally in
> a way that will allow us to not fail if the conflicted files are
> included in the sparse set.

I agree that this is not the _best_ thing to do, but it does mimic the
current recommendation for a user interacting with sparse-checkout.

I'll rename this helper to something like "update_working_directory()"
so it can be swapped with a different implementation later, after we
work out those usability kinks.

The other thing that is needed here: allow reverting the sparse-checkout
settings if this fails. I'll isolate that to a new commit so we can
examine that behavior carefully.

> 
>> +
>> +       argv_array_clear(&argv);
>> +       return result;
>> +}
>> +
>> +static int sc_enable_config(void)
>> +{
>> +       struct argv_array argv = ARGV_ARRAY_INIT;
>> +       int result = 0;
>> +       argv_array_pushl(&argv, "config", "--add", "core.sparseCheckout", "true", NULL);
> > Why --add?  That seems really odd to me.

Yeah, that's a mistake. Good find.

> 
> This should also have "--worktree".  And this function should either
> set extensions.worktreeConfig to true or die if it isn't already set;
> not sure which.  There's some UI and documentation stuff to figure out
> here...

I was planning to switch my `git config` subcommand to use in-process
methods, but I'm struggling to find a way to ensure we follow the
`--worktree` option. It likely would work if extensions.worktreeConfig
was enabled when the process starts, but adding it in-process likely
causes a problem.

> 
>> +
>> +       if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
>> +               error(_("failed to enable core.sparseCheckout"));
>> +               result = 1;
>> +       }
>> +
>> +       argv_array_clear(&argv);
>> +       return result;
>> +}
>> +
>> +static int delete_directory(const struct object_id *oid, struct strbuf *base,
>> +               const char *pathname, unsigned mode, int stage, void *context)
>> +{
>> +       struct strbuf dirname = STRBUF_INIT;
>> +       struct stat sb;
>> +
>> +       strbuf_addstr(&dirname, the_repository->worktree);
>> +       strbuf_addch(&dirname, '/');
>> +       strbuf_addstr(&dirname, pathname);
>> +
>> +       if (stat(dirname.buf, &sb) || !(sb.st_mode & S_IFDIR))
>> +               return 0;
>> +
>> +       if (remove_dir_recursively(&dirname, 0))
> 
> flags = 0 implies not REMOVE_DIR_EMPTY_ONLY.  I'm not familiar with
> remove_dir_recursively(), but won't this delete everything...including
> untracked files?  If so, that sounds like a bug.
This whole thing isn't needed any more, since read-tree does the right
thing.

> 
>> +               warning(_("failed to remove directory '%s'"),
>> +                       dirname.buf);
>> +
>> +       strbuf_release(&dirname);
>> +       return 0;
>> +}
>> +
>> +static int sparse_checkout_init(int argc, const char **argv)
>> +{
>> +       struct tree *t;
>> +       struct object_id oid;
>> +       struct exclude_list el;
>> +       static struct pathspec pathspec;
>> +       char *sparse_filename;
>> +       FILE *fp;
>> +       int res;
>> +
>> +       if (sc_enable_config())
>> +               return 1;
>> +
>> +       memset(&el, 0, sizeof(el));
>> +
>> +       sparse_filename = get_sparse_checkout_filename();
>> +       res = add_excludes_from_file_to_list(sparse_filename, "", 0, &el, NULL);
> 
> But 'el' isn't used again?  Why are we getting the list of files from
> sparse_filename then?

This is the only way I could think to check that the sparse-checkout file parses well without just doing the file open myself. Maybe we only need to check if the file exists (and is not empty).

>> +
>> +       /* If we already have a sparse-checkout file, use it. */
>> +       if (res >= 0) {
>> +               free(sparse_filename);
>> +               goto reset_dir;
>> +       }
>> +
>> +       /* initial mode: all blobs at root */
>> +       fp = fopen(sparse_filename, "w");
>> +       free(sparse_filename);
>> +       fprintf(fp, "/*\n!/*/*\n");
>> +       fclose(fp);
> 
> Makes sense.
> 
>> +
>> +       /* remove all directories in the root, if tracked by Git */
>> +       if (get_oid("HEAD", &oid)) {
>> +               /* assume we are in a fresh repo */
>> +               return 0;
>> +       }
>> +
>> +       t = parse_tree_indirect(&oid);
>> +
>> +       parse_pathspec(&pathspec, PATHSPEC_ALL_MAGIC &
>> +                                 ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
>> +                      PATHSPEC_PREFER_CWD,
>> +                      "", NULL);
>> +
>> +       if (read_tree_recursive(the_repository, t, "", 0, 0, &pathspec,
>> +                               delete_directory, NULL))
>> +               return 1;
> 
> Since this is only needed on Windows, as per your commit message,
> should it be #ifdef'd?  Or is this actually a bug that should be fixed
> in "git read-tree -mu HEAD"?

(this will not be needed, but thanks!)
 
>> +
>> +reset_dir:
>> +       return sc_read_tree();
>> +}
>> +
> 
> The rest looks fine.

Thanks,
-Stolee

