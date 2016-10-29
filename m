Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D6D72022A
	for <e@80x24.org>; Sat, 29 Oct 2016 22:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753752AbcJ2WUC (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Oct 2016 18:20:02 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36700 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753030AbcJ2WUB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2016 18:20:01 -0400
Received: by mail-lf0-f65.google.com with SMTP id b75so5531335lfg.3
        for <git@vger.kernel.org>; Sat, 29 Oct 2016 15:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gZhPRYlLqMMG8BHwFeW6q5u/OrOMFd7eE9i/VYhHeu0=;
        b=Ng7zGYB6FA1jSVMUK16LGQ0I+HS3Sc2M4kfSAEbLcM/KsDfmZ0Kh62Ve/jVklD6V0+
         ecNNBuqOh58kEwEjcfLEjajio/UmOgn31HnhNaBKFWFPDaBsxvny7geYSiDZe4DQW4J0
         0ASieRGtOrP1i5CmFN4yNnVd7tPvsYVj1HPV3h3AoV6eq2tyA9UTmC5iZg8k7ryCm4TT
         usiQCZkTIGoWxnXiuMd+YNvbF7HKZLqhYMVcgguKlp3hkouHm1TizC6rIgYm5s4ECkA2
         3XwkV9JB9Qm9sUaY6ig6UeKJsJ6v2de5uTSuQLM0OAG1vgxNh+FghtNnMxNgMnerJEyS
         AkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gZhPRYlLqMMG8BHwFeW6q5u/OrOMFd7eE9i/VYhHeu0=;
        b=MzdYa24jYuXsNmi5xq4lCXIsuFd+DQbH0NI3T0CqE2MFW7ojQ5qnaprC0DaLnL6Tyt
         CDJyGXBuJ/E05om36rX0paQErhaUghokySqmqHUrwYVdrIbQmu2gNfgBTJiSBYoQFKVp
         xjOKerjracd96hUHYfPAQCCu/FqLfLrT/FROHEtB93CJDfvYSczLK3edOeZPt49Pn/ui
         RHgC2oVF6zlPPvZxYeDNfCrsCtbJ5yp9XNrqZ29+eUxOeHA+kmBkxm/k8i/3J96Vi0Sx
         JPAC389JzPfb0SjDCG6l4gh4J0fggnA7EuhF82L8PqksyJ3Cx4j4vVGK32+frysg+7cD
         2iZg==
X-Gm-Message-State: ABUngvfdlHl1mR0l8zJAfOvqQQB6fSGRV8CtebMBjlVrpgNyQ8kIDmegBQxyBvqhFeOwsVK0GpEq5ioah+umMg==
X-Received: by 10.25.155.211 with SMTP id d202mr11823004lfe.129.1477779600019;
 Sat, 29 Oct 2016 15:20:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.163.84 with HTTP; Sat, 29 Oct 2016 15:19:59 -0700 (PDT)
In-Reply-To: <CACsJy8Br2q0aadTFjkNgb=oN8nSzbkWJEK7bCCgr7v-oOZtrSA@mail.gmail.com>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
 <20161023092648.12086-6-chriscool@tuxfamily.org> <CACsJy8Br2q0aadTFjkNgb=oN8nSzbkWJEK7bCCgr7v-oOZtrSA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 30 Oct 2016 00:19:59 +0200
Message-ID: <CAP8UFD2SX+wUg0=+cfRY5oo5SEigKU-AjrQg0_zsYsfXdb53HA@mail.gmail.com>
Subject: Re: [PATCH v1 05/19] update-index: warn in case of split-index incoherency
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 25, 2016 at 12:00 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Oct 23, 2016 at 4:26 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> When users are using `git update-index --(no-)split-index`, they
>> may expect the split-index feature to be used or not according to
>> the option they just used, but this might not be the case if the
>> new "core.splitIndex" config variable has been set. In this case
>> let's warn about what will happen and why.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  builtin/update-index.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/update-index.c b/builtin/update-index.c
>> index b75ea03..a14dbf2 100644
>> --- a/builtin/update-index.c
>> +++ b/builtin/update-index.c
>> @@ -1098,12 +1098,21 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>>         }
>>
>>         if (split_index > 0) {
>> +               if (git_config_get_split_index() == 0)
>> +                       warning("core.splitIndex is set to false; "
>> +                               "remove or change it, if you really want to "
>> +                               "enable split index");
>
> Wrap this string and the one below with _() so they can be translated.

Ok, it will be in the next version.
