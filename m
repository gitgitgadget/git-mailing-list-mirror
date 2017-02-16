Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C79E71FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 21:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933251AbdBPVdq (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 16:33:46 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:37179 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933079AbdBPVdq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 16:33:46 -0500
Received: by mail-it0-f47.google.com with SMTP id x75so40984855itb.0
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 13:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dtIjsD9WNUOXTbz0r9Z4u18OVgOkQKqmk68cAUsC6Qk=;
        b=gDgq5AYh8+Dk8S2PeSnV9+nFfTsx+2PIb8g7SZV9KxTq92NRI9TJn6O2fGUYV7ND6h
         hfm+jqRL9Y7cfAT48fHZYIWZ/vboxYfgXca8GQB7YPxosV7+knQwEiHastbOkezV7ZYa
         JrgHxbnxcGTFiPDnXiNiHAfnzGDrCcmNdP/8osW5WET5niF9g9tVrywFEo6K1OH5hGSB
         Bs97ca7ryhafAf2RwNAQw/HOCKlRL9OjMPw/pidsyTsexItLnX7BE+ijdtldOklc6bsq
         0zVMh8zfsNgJm1/TD5lPraEmySf9WFLIm6WbJ5m0S+4jElLKewJD5A20RzbqH8s9gHPw
         EKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dtIjsD9WNUOXTbz0r9Z4u18OVgOkQKqmk68cAUsC6Qk=;
        b=exL5moDZXVHKatWArmhK2VME4qlnsw0DDY5ugSZ+ubsiXLKjCshLwghYILXFnUaO7o
         yLflLDctlTqfrF1KcCebBbca2/zJiHORbQ9ozuyBvOhd1g39r0KGUntisU6cYBDwnOSo
         yyGxJM2BfXa73zvTufbWWqFSobN4LLH+MZ0fFLkYDx1kEpUdbYNlDjlV0v1tdEkOVx90
         de/1gtKAaK9Ki6ycLqqeN3lyyeiUx1iTbl3F3JTDzXp/v+RtBbn0H0RtmlNnsgqDm/kW
         T+k5Ne0rOgQMs1wZCjUnMrvqTRfXQyzJ+Ho2xji/DAYmxkJTrrOm0YsBc/wLKkajYNGC
         v7bQ==
X-Gm-Message-State: AMke39ncubaeZtQzNvaSNz6RaXENg7Txx/q38Dph76o4Q5Ef5SGb3seEPcNefkn9QrSxTEwMi8TYdNKAwmP92zuM
X-Received: by 10.107.16.14 with SMTP id y14mr4082264ioi.164.1487280825043;
 Thu, 16 Feb 2017 13:33:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Thu, 16 Feb 2017 13:33:44 -0800 (PST)
In-Reply-To: <xmqq7f4px2fi.fsf@gitster.mtv.corp.google.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com> <20170216003811.18273-1-sbeller@google.com>
 <20170216003811.18273-11-sbeller@google.com> <xmqq7f4px2fi.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 16 Feb 2017 13:33:44 -0800
Message-ID: <CAGZ79kYqa4jX-q_GHLyCE80VipBOHq48RZ_f=bGAw1CkyyLCBw@mail.gmail.com>
Subject: Re: [PATCH 10/15] update submodules: add submodule_go_from_to
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2017 at 1:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> [administrivia: I've been seeing "unlisted-recipients:; (no To-header on input)"
> for all of your recent patches.  Can it be corrected on your end, please?]

I cc'd everyone and had no to field, actually. Maybe git-send-email should
complain more loudly when I am holding it wrong.

>> +     cp.git_cmd = 1;
>> +     argv_array_pushl(&cp.args, "diff-index", "--cached", "HEAD", NULL);
>
> We'd want to use the QUICK optimization here, I suspect.  This
> caller does not need to (or want to) learn which exact paths are
> modified, right?

ok

>> +     if (run_command(&cp))
>> +             die("could not clean submodule index");
>> +}
>
> Do s/clean/reset/ everywhere above.

ok

>
>> +/**
>> + * Moves a submodule at a given path from a given head to another new head.
>> + * For edge cases (a submodule coming into existence or removing a submodule)
>> + * pass NULL for old or new respectively.
>> + *
>> + * TODO: move dryrun and forced to flags.
>
> The reason why this seeingly trivial thing is left as TODO is...???

will do. The reason was to first get the grand design right before
spending more time in the details.

>
>> + */
>> +int submodule_go_from_to(const char *path,
>> +                      const char *old,
>> +                      const char *new,
>> +                      int dry_run,
>> +                      int force)
>> +{
>
> go-from-to does not tell me what it does, but my cursory read of the
> body of the function tells me that this is doing a checkout of a
> branch in the submodule?  The operation in builtin/checkout.c that
> conceptually correspond to this is called switch_branches(), I
> think, so perhaps submodule_switch_branches() is a better name?

Well as of now all submodule operations (submodule update mostly)
end up with detached HEADs in the submodule. So it is rather
going from one state (sha1) to another given sha1.

I would rather compare it to checkout_entry/write_entry in entry.c
except that there are more things to go wrong. A single file has no
notion of its own index or dirtiness.

>
>> +     int ret = 0;
>> +     struct child_process cp = CHILD_PROCESS_INIT;
>> +     const struct submodule *sub;
>> +
>> +     sub = submodule_from_path(null_sha1, path);
>> +
>> +     if (!sub)
>> +             die("BUG: could not get submodule information for '%s'", path);
>> +
>> +     if (!dry_run) {
>> +             if (old) {
>> +                     if (!submodule_uses_gitfile(path))
>> +                             absorb_git_dir_into_superproject("", path,
>> +                                     ABSORB_GITDIR_RECURSE_SUBMODULES);
>> +             } else {
>> +                     struct strbuf sb = STRBUF_INIT;
>> +                     strbuf_addf(&sb, "%s/modules/%s",
>> +                                 get_git_common_dir(), sub->name);
>> +                     connect_work_tree_and_git_dir(path, sb.buf);
>> +                     strbuf_release(&sb);
>> +
>> +                     /* make sure the index is clean as well */
>> +                     submodule_clean_index(path);
>> +             }
>> +     }
>> +
>> +     if (old && !force) {
>> +             /* Check if the submodule has a dirty index. */
>> +             if (submodule_has_dirty_index(sub)) {
>> +                     /* print a thing here? */
>> +                     return -1;
>> +             }
>
> Isn't it too late to do this here?  You already reset the index
> in the submodule, no?

Yes this is confusing.
We run this function first as a dry_run, and in a second pass
as a real run. So the order inside the function is confusing
as we would run this first in the dry run.

>
> Is the idea that changes that are only in the submodule's working
> tree are noticed by later "read-tree -u -m" down there?  Not
> complaining but trying to understand.

I think (as a first step) we only want to allow a clean index in
submodules, as then we have to implement less cases at first.
