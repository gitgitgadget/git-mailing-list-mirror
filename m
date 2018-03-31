Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62BD11F404
	for <e@80x24.org>; Sat, 31 Mar 2018 17:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752895AbeCaREy (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 13:04:54 -0400
Received: from mail-yb0-f178.google.com ([209.85.213.178]:44836 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752321AbeCaREx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 13:04:53 -0400
Received: by mail-yb0-f178.google.com with SMTP id m185-v6so3869173ybm.11
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 10:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ywTQJINkRxWuLjAwBFVZ+Ap2YCmOaCE5dALGGibJm3I=;
        b=gTVmBxODXrr6Mk3H7cM9KNIqG9f3AIi6TEffDUQRO2xZJ4q3NGb85YazwKDC6eP0vy
         woTrdZj6ouV5QTdIDeUN4Ui3DPsUxH6AbfL4At2Xxg3iRTLR5/PreiFU2Rw5Wb4rCwzz
         Xa9DDXeSnfh4BeZNXn3csgZ0CyHsiUYACMc9mmrvJ6ciTR2DE7/ktNu+Y/EOjpYl3oyb
         mlye1GR86FpY+iCrK/bygJ4qDLP2gugU7zvBdUyVywGjrZZYkzIGC4V8nCC12xXyvG3+
         1T9xWRsqI+5moAUZPhJ7wydIhxqLJ0g5vnVRK4h+DMYcxVfgrnyXjBTbdfTtjMWFGkXW
         AF7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ywTQJINkRxWuLjAwBFVZ+Ap2YCmOaCE5dALGGibJm3I=;
        b=X51YlCDUcBsmUvUoO5SZIgPauinItZz/6vKETlJIZ9aTK72G4X4H8UlWP9on9xu97z
         Bgiuxudl9rtiOq4mZm7flPc27I/yUZieA1jHK+5PMptTdNQooxzfBSDLhhE1S9B9X8fH
         bLVE5WVCR/RoF3fOLYN3QKXM6QCM/rYGrQE/ce/GRESfI5wAl8R34DViomkFIG0TMemz
         sWmqLIqAmeEgp1wD/JGLQEV38p06RdB0onCrcmwSnfahFfMMUsyoz9EQsKc8jL7J/2Xm
         YsZdPsQZP5fB5agW0nUG61em4hshpSbvJm6QZKvk0k6IwU0KDtK+oy2Dh5BJplDrDUCv
         Q0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ywTQJINkRxWuLjAwBFVZ+Ap2YCmOaCE5dALGGibJm3I=;
        b=mp8R9Z3QHADFhRPS6i8hIlhWMqdoG3ah3WLYorpfdyLSlo5wHtQ0PtSSJ2R6fT/89f
         ER0xf/mE64v+XQdeoxFr82yihafAqS77K5wNQNqO0h3rcIR/vobf6xqw4XDwiISqIl13
         ubhLvz/ufuqfI+h/WBRl76XSj41dfwgIlZp2HX1mK+v7Oro/dHYgX73twKwP1GhwBoO8
         tpf8Ma6CHBiVvVDjlAKlRWniLXJa+aBARfqhMHDudptuAfCu36+xMJf5EvCM3AA7oxMD
         6yBIdPXnPtiS1iWxa+R05PjXorZ0RWSnaccrwITtWYq1V8hZirxyhMS1MScg9sTccGDc
         8MSA==
X-Gm-Message-State: ALQs6tALJfAh/dF2CgGYy+hv/JUe0fqXHVcXsAZy0zhEQfZu8QIpxiRE
        BhkYhgeArnAajzhfhdtEG5jzOxq7ueyNQLd0QOg=
X-Google-Smtp-Source: AIpwx48jSgm3P+l+iEcsAIzRguBuxx0F8xYq8HehjZUPnbADZGeSTGkZUfXWQe2+eRC+cZKYasmJifgB3H5uqYZHGWo=
X-Received: by 2002:a25:e757:: with SMTP id e84-v6mr1328463ybh.217.1522515892593;
 Sat, 31 Mar 2018 10:04:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3804:0:0:0:0:0 with HTTP; Sat, 31 Mar 2018 10:04:32
 -0700 (PDT)
In-Reply-To: <xmqqlgea63xu.fsf@gitster-ct.c.googlers.com>
References: <20180328222129.22192-1-joel@teichroeb.net> <20180328222129.22192-3-joel@teichroeb.net>
 <xmqqlgea63xu.fsf@gitster-ct.c.googlers.com>
From:   Joel Teichroeb <joel@teichroeb.net>
Date:   Sat, 31 Mar 2018 10:04:32 -0700
X-Google-Sender-Auth: TzNCgrFAvnpibBuOjCLMGWEWnjQ
Message-ID: <CA+CzEk9vLRMGSMmdpEe6mm9f4f8+Cs+ZBb3sTS0TeZDbWKemcw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] stash: convert apply to builtin
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 29, 2018 at 1:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Joel Teichroeb <joel@teichroeb.net> writes:
>
>> +static int get_stash_info(struct stash_info *info, int argc, const char **argv)
>> +{
>
> So, this roughly corresponds to parse_flags_and_rev function, it seems.
>
>> +     struct strbuf w_commit_rev = STRBUF_INIT;
>> +     struct strbuf b_commit_rev = STRBUF_INIT;
>> +     struct strbuf w_tree_rev = STRBUF_INIT;
>> +     struct strbuf b_tree_rev = STRBUF_INIT;
>> +     struct strbuf i_tree_rev = STRBUF_INIT;
>> +     struct strbuf u_tree_rev = STRBUF_INIT;
>> +     struct strbuf symbolic = STRBUF_INIT;
>> +     struct strbuf out = STRBUF_INIT;
>> +     int ret;
>> +     const char *revision;
>> +     const char *commit = NULL;
>> +     char *end_of_rev;
>> +     info->is_stash_ref = 0;
>> +
>> +     if (argc > 1) {
>> +             int i;
>> +             struct strbuf refs_msg = STRBUF_INIT;
>> +             for (i = 0; i < argc; ++i)
>> +                     strbuf_addf(&refs_msg, " '%s'", argv[i]);
>> +
>> +             fprintf_ln(stderr, _("Too many revisions specified:%s"), refs_msg.buf);
>> +             strbuf_release(&refs_msg);
>> +
>> +             return -1;
>> +     }
>> +
>> +     if (argc == 1)
>> +             commit = argv[0];
>> +
>> +     strbuf_init(&info->revision, 0);
>> +     if (commit == NULL) {
>> +             if (have_stash()) {
>> +                     free_stash_info(info);
>> +                     return error(_("No stash entries found."));
>> +             }
>> +
>> +             strbuf_addf(&info->revision, "%s@{0}", ref_stash);
>> +     } else if (strspn(commit, "0123456789") == strlen(commit)) {
>> +             strbuf_addf(&info->revision, "%s@{%s}", ref_stash, commit);
>> +     } else {
>> +             strbuf_addstr(&info->revision, commit);
>> +     }
>> +
>> +     revision = info->revision.buf;
>> +     strbuf_addstr(&w_commit_rev, revision);
>> +     ret = !get_oid(w_commit_rev.buf, &info->w_commit);
>> +     strbuf_release(&w_commit_rev);
>
> Use of strbuf w_commit_rev looks completely pointless here.  Am I
> mistaken to say that the above three lines are equivalent to:
>
>         ret = !get_oid(revision, &info->w_commit);
>

Right, it was refactored to this in a previous version, but I didn't
quite think it through.

>> +
>> +     if (!ret) {
>> +             error(_("%s is not a valid reference"), revision);
>> +             free_stash_info(info);
>> +             return -1;
>> +     }
>> +
>> +     strbuf_addf(&b_commit_rev, "%s^1", revision);
>> +     strbuf_addf(&w_tree_rev, "%s:", revision);
>> +     strbuf_addf(&b_tree_rev, "%s^1:", revision);
>> +     strbuf_addf(&i_tree_rev, "%s^2:", revision);
>> +
>> +     ret = !get_oid(b_commit_rev.buf, &info->b_commit) &&
>> +             !get_oid(w_tree_rev.buf, &info->w_tree) &&
>> +             !get_oid(b_tree_rev.buf, &info->b_tree) &&
>> +             !get_oid(i_tree_rev.buf, &info->i_tree);
>> +
>> +     strbuf_release(&b_commit_rev);
>> +     strbuf_release(&w_tree_rev);
>> +     strbuf_release(&b_tree_rev);
>> +     strbuf_release(&i_tree_rev);
>
> For the same reason, these strbuf's look pretty much pointless.  I
> wonder if a private helper
>
>         static int grab_oid(struct oid *oid, const char *fmt, const char *rev)
>         {
>                 struct strbuf buf = STRBUF_INIT;
>                 int ret;
>
>                 strbuf_addf(&buf, fmt, rev);
>                 ret = get_oid(buf, oid);
>                 strbuf_release(&buf);
>                 return ret;
>         }
>
> would help here?  Then you wouldn't be writing something like the
> above, and instead you'd grab four object names like so:
>
>         if (grab_oid(&info->b_commit, "%s^1", revision) ||
>             grab_oid(&info->w_tree, "%s:", revision) ||
>             grab_oid(&info->b_tree, "%s&1:", revision) ||
>             grab_oid(&info->i_tree, "%s&2:", revision)) {
>                 ... we found an error ...
>                 return -1;
>         }
>
> which would be a lot easier to follow, no?

Very much agreed! I felt like that part of the code was the weakest
part of my patch before. I'm very happy to have it cleaned up like
this!

>
>> +int cmd_stash__helper(int argc, const char **argv, const char *prefix)
>> +{
>> +     int result = 0;
>> +     pid_t pid = getpid();
>> +     const char *index_file;
>> +
>> +     struct option options[] = {
>> +             OPT_END()
>> +     };
>> +
>> +     git_config(git_default_config, NULL);
>> +
>> +     argc = parse_options(argc, argv, prefix, options, git_stash_helper_usage,
>> +             PARSE_OPT_KEEP_UNKNOWN|PARSE_OPT_KEEP_DASHDASH);
>> +
>> +     index_file = get_index_file();
>> +     xsnprintf(stash_index_path, PATH_MAX, "%s.stash.%"PRIuMAX, index_file, (uintmax_t)pid);
>
> Wouldn't it make more sense to get rid of PATH_MAX and hold it in a
> strbuf instead?  I.e.
>
>     static struct strbuf stash_index_path = STRBUF_INIT;
>     ...
>     strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file, (uintmax_t)pid);
>

That makes it a lot cleaner, thanks!

>> +     cd "$START_DIR"
>> +     git stash--helper apply "$@"
>> +     res=$?
>> +     cd_to_toplevel
>> +     return $res
>>  }
