Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DB66203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 17:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbcGVRQL (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 13:16:11 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35894 "EHLO
	mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbcGVRQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 13:16:09 -0400
Received: by mail-it0-f66.google.com with SMTP id j124so3455950ith.3
        for <git@vger.kernel.org>; Fri, 22 Jul 2016 10:16:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9usTp/1FMnF3WdhlwlkErZl+rNBC7ExLHg6GwwluRUo=;
        b=VlzJg8mAog3AUQdOKO1Bo9i7Z9vUqMuf/r2igazuXjxlTjEj2584UIr5DdW6Dq7oVN
         KWpgLMpl0CuiO88acWxTxTWZ35qQCh86OyrqPr1oVJv5XxgvUuVbl/AxmvkLsWLTA/RV
         20ktxYMJH//M1aHCjqQtsI0jqSWn2NGr2MMFpaEU9D2TuIE93ihqRgnH6PvojzB2SbHR
         AstCDpdtFoIIViawcDeezSEM0uRfTLoHZCzKLhBISYpdg8n/i6KfbyYByw83az30lMm4
         pXCPaH09SuN9F7sZMmfckg9NxeOm9ILCDcWl6P+KbmRXplxcwDi27d9w5GA1VJwILt7O
         rcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9usTp/1FMnF3WdhlwlkErZl+rNBC7ExLHg6GwwluRUo=;
        b=gzX0gqDCCTTr/hLYVP0j6RU/0W9ZMpYMq5Ncht8UkyRJHB/x7ZpL7kcrdiBKBdKtXk
         yN7fWOGH5jzDYI1/i4Xo34N4623LWrN0r3GZ+vS6paFFdKxZPmNme7ddlwR8TxN6uCcZ
         07nP53s/lhExxNJD4OdhWll1lgtEEAgcH9MVqgLoz7YwiEJ4VGyNw3j4uJFpq6g62x6o
         5AdpQypS7S06hXiUCyKFRF7nG95kpkCm3T8Zr/wsGCKZYZgftbHF7fYJc3077EcajfCH
         PHHlgAsPcBV72//PVN9pan4bU/cw+nfCDgRq64l9YFoEBfv8FXgNeoyTpU6LiDYPW1v9
         jjoA==
X-Gm-Message-State: ALyK8tJi4zQQzzF6CIwJamUN9mtuxOEh+V/bDegcm6rz4CqxUoWAo15mnOV1kPsZw0NBTh9Wgse9cT+HKtJGbQ==
X-Received: by 10.36.43.88 with SMTP id h85mr53717646ita.57.1469207769098;
 Fri, 22 Jul 2016 10:16:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Fri, 22 Jul 2016 10:15:39 -0700 (PDT)
In-Reply-To: <CAGZ79kZg-E8p1WW8j5ghOC=EJU++Dy++esv=vVRt8iuOYsrNpQ@mail.gmail.com>
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
 <20160720172419.25473-1-pclouds@gmail.com> <20160720172419.25473-3-pclouds@gmail.com>
 <CAGZ79kZg-E8p1WW8j5ghOC=EJU++Dy++esv=vVRt8iuOYsrNpQ@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Fri, 22 Jul 2016 19:15:39 +0200
Message-ID: <CACsJy8Dyw4DefzPj2oy0SYZZC0TTjVCD+p5Ued265VogG_eNSw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] submodule: update core.worktree using git-config
To:	Stefan Beller <sbeller@google.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 21, 2016 at 12:04 AM, Stefan Beller <sbeller@google.com> wrote:
>> diff --git a/submodule.c b/submodule.c
>> index abc2ac2..b912871 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -1128,7 +1128,9 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
>>  {
>>         struct strbuf file_name = STRBUF_INIT;
>>         struct strbuf rel_path = STRBUF_INIT;
>> +       struct strbuf path = STRBUF_INIT;
>>         const char *real_work_tree = xstrdup(real_path(work_tree));
>> +       struct child_process cp = CHILD_PROCESS_INIT;
>>
>>         /* Update gitfile */
>>         strbuf_addf(&file_name, "%s/.git", work_tree);
>> @@ -1136,13 +1138,17 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
>>                    relative_path(git_dir, real_work_tree, &rel_path));
>>
>>         /* Update core.worktree setting */
>> -       strbuf_reset(&file_name);
>> -       strbuf_addf(&file_name, "%s/config", git_dir);
>> -       git_config_set_in_file(file_name.buf, "core.worktree",
>> -                              relative_path(real_work_tree, git_dir,
>> -                                            &rel_path));
>> +       strbuf_addstr(&path, relative_path(real_work_tree, git_dir,
>> +                                          &rel_path));
>> +       cp.git_cmd = 1;
>> +       argv_array_pushl(&cp.args, "-C", work_tree, NULL);
>> +       argv_array_pushl(&cp.args, "--work-tree", ".", NULL);
>> +       argv_array_pushl(&cp.args, "config", "core.worktree", path.buf, NULL);
>> +       if (run_command(&cp) < 0)
>> +               die(_("failed to update core.worktree for %s"), git_dir);
>
> Do we need to make this conditional on the extensions.worktreeConfig
> variable, though? When I just run
>
>     git config --worktree . foo bar
> fatal: Per-worktree configuration requires extensions.worktreeConfig
> Please read section CONFIGURATION in `git help worktree` before
> enabling it.
>
> which would trigger the failure here?

It was intended, but I was probably just paranoid. The thinking back
then was, you are switching from "share whole config" to "not share
something". This should not be taken lightly and you should examine
your config file and decide what to share, before making the switch.
It's dangerous!

But then, if everything has been shared before (assuming there are
more than one worktree) and you are probably happy with it (or you
would have made done something to unshare), so it's probably good to
keep on sharing. Which means we can set extensions.worktreeConfig
automatically here (when "git config --worktree" is used) instead of
dying. We would need to move core.bare and core.worktree to main
worktree, but that's manageable.

So in short, you would not see this message in this context in future again.
-- 
Duy
