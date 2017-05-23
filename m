Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA70E20281
	for <e@80x24.org>; Tue, 23 May 2017 19:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935641AbdEWTRl (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 15:17:41 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36677 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933104AbdEWTRk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 15:17:40 -0400
Received: by mail-it0-f68.google.com with SMTP id i206so15732272ita.3
        for <git@vger.kernel.org>; Tue, 23 May 2017 12:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R1fZW+0gCSMVcbC/thx3/wGNTbcvf/AL5QsU/AkyXag=;
        b=Wo6sNNAN3u568Vy0P09XUjWu9Xb8qHFvca3FSgqea+iHZzjobj4RpIw7Hyt/EWpqjF
         sErSR1Hnd9VNNzsKYHQlJYvI2H1MR1mFSJady7V4YRfWGBXqKOBw/pSTgeLyCSXDAhWu
         0plHs8aqXb4LSwlnJ5Hjgijr9JXnIGDcK4TclS/MHz/vaYnJwEEe+TUum31kO1Kav1W+
         x+c2Cx+lCAFl0vCQtauDejEMRjmGe86b7yHun3GGhl1xMNM39fRRJ5CD95ylDd625ZqF
         4e1LQ+0uZ3NrmZBhFG8EQEm7XdqybOb0qZt26pFYQqDuZIQ4sdZXmtw9JOWNKBDaVlXZ
         WQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R1fZW+0gCSMVcbC/thx3/wGNTbcvf/AL5QsU/AkyXag=;
        b=CDV9pMJGuQgEiUdytBsSjHFFwGH/VV5OXE++CJqKj3R1YQukhP4rWnqzgn6Wks3gfc
         etbj+KpXm5RBAkvo4dTG/cUNKoOVWZ8ERBkMwHtiG6JNBYliVCNoVWCIITRxlwEfJS+W
         b4BPcRu1MnWT90iVAHTtRQWwSnxOtM8YQHr9Urpc3bJKtVO+BX2iUyL/y6RHThY3QwKm
         0C58GMxv9ReoFsmVAWEvFefFe+OnQnn7WdejQU89yCp/aanOOxs4Cqcx9bcRNhWldbiG
         ptCim4luBetVVIevCzatVoXB0zzr78g9M4iIdJv2y5Yrs5qMEwDO5MjM6eN1JR0ffqhe
         kNJQ==
X-Gm-Message-State: AODbwcAoehfOp73bPi6EBjujUeibqkic+wXc4lalqQqFc89H3PznQj/k
        W6PW5KWyS09whkwOaNcMQ1RMdkEk3Q==
X-Received: by 10.36.210.193 with SMTP id z184mr4505218itf.86.1495567059762;
 Tue, 23 May 2017 12:17:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Tue, 23 May 2017 12:16:59 -0700 (PDT)
In-Reply-To: <xmqqshjvka5x.fsf@gitster.mtv.corp.google.com>
References: <20170523091829.1746-1-sxlijin@gmail.com> <20170518082154.28643-1-sxlijin@gmail.com>
 <20170523091829.1746-7-sxlijin@gmail.com> <xmqqshjvka5x.fsf@gitster.mtv.corp.google.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Tue, 23 May 2017 15:16:59 -0400
Message-ID: <CAJZjrdWgthKzACE6=tpYOHwXr-zGO2SyX=W6Hbnxw7kk1cQn0Q@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] clean: teach clean -d to preserve ignored paths
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 23, 2017 at 8:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Samuel Lijin <sxlijin@gmail.com> writes:
>
>> @@ -931,6 +961,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>>                      prefix, argv);
>>
>>       fill_directory(&dir, &pathspec);
>> +     correct_untracked_entries(&dir);
>>
>>       for (i = 0; i < dir.nr; i++) {
>>               struct dir_entry *ent = dir.entries[i];
>
> You used to set SHOW_IGNORED_TOO and KEEP_UNTRACKED_CONTENTS in
> dir.flags early in the function, and then free dir.entries[] and
> dir.ignored[] after we are done.  They are gone in this version.
>
> Intended?

Embarrassingly, no. Rerolling.

>> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
>> index 3a2d709c2..7b36954d6 100755
>> --- a/t/t7300-clean.sh
>> +++ b/t/t7300-clean.sh
>> @@ -653,7 +653,7 @@ test_expect_success 'git clean -d respects pathspecs (pathspec is prefix of dir)
>>       test_path_is_dir foobar
>>  '
>>
>> -test_expect_failure 'git clean -d skips untracked dirs containing ignored files' '
>> +test_expect_success 'git clean -d skips untracked dirs containing ignored files' '
>>       echo /foo/bar >.gitignore &&
>>       echo ignoreme >>.gitignore &&
>>       rm -rf foo &&
