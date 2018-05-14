Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D65841F51A
	for <e@80x24.org>; Mon, 14 May 2018 17:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932975AbeENRDI (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 13:03:08 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:55898 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932969AbeENRDF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 13:03:05 -0400
Received: by mail-wm0-f53.google.com with SMTP id a8-v6so14767772wmg.5
        for <git@vger.kernel.org>; Mon, 14 May 2018 10:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F5Up56HyQ8d6rABtTyOMkBi4VTfC8qJM4SEstBqvKdw=;
        b=d86hetkW2zZf6o1BsCAz1QnOGETVOvx2cJlDo6SuOv9U2aTWpi2OOIvif+XDY15kY0
         ziIjPnudEnewiwYF0Zq7sYSU13YOHOPi8cGL2iLKCppP2Aw45wSnhvtKMyZ12VQk/xK1
         5JVHYiQ/aw1AslvcJYw6z26Wjt5W2ve77DyIg935a7T0Baox5EBP8PLs63C0JpixBwBA
         n1c6gnPuJtVqhr4TKfngbHoMXKQBMrjtvnheHgZzxRE8t/pELvcAPldnhEPoOeqmUaBd
         ek+TNYkt/uCRTvUwH7WnUsotI7bw/9iBRNp+dbwLvQ4/pIwHRecCJ5Dpppt+3hHBkhTT
         lsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F5Up56HyQ8d6rABtTyOMkBi4VTfC8qJM4SEstBqvKdw=;
        b=grxCI8CKpfVf4Vt58OxEHpy7ShCB3krJd2UrIhorqaa9zso+G7zCV3WOuRWaLz9J13
         Zjt5UvJ2+RT8SufByO27jVL/ccCVE/C0wSRWC1nQ+IcB5T6TGIp5lKTM65CTrC1C2dvz
         xUMYdPbCrdKi9n3uXKEAAAdd7NfBJEftz9fGMcLBP/AIKqF+WlseiPz14UAM67tlw/L6
         3Sb9deGRmnWqaPJrlWkHM0N+vtiMXsOwkROE+jlZwd+tI7eNlxQbiIXl6iOo+enx40Uc
         gigT78wOUGUpT/aeyFxk0wgdX3eg/AWU2+uUT2t1NKN6hVkuVjxJaJ8dwsPYK1zL6K2Q
         w3Bw==
X-Gm-Message-State: ALKqPwf3otctH/OytRuEkNNzu81sQ0T5olnh0IpSIB3MdvJhb0VbKxF+
        N3fPWG9ThawcSxHfkojX60nNJA==
X-Google-Smtp-Source: AB8JxZrBvRGJ1GmKAPdRTbakvQP+eGLP9Zpo4nZbIw8WjPB9hPa2EUDG0yPOnv1DuIaydQVhDe1AgQ==
X-Received: by 2002:a1c:404:: with SMTP id 4-v6mr5240133wme.23.1526317383752;
        Mon, 14 May 2018 10:03:03 -0700 (PDT)
Received: from ?IPv6:2001:a62:81d:ab01:6c22:aed3:f6e9:6f89? ([2001:a62:81d:ab01:6c22:aed3:f6e9:6f89])
        by smtp.googlemail.com with ESMTPSA id h66-v6sm10735794wmf.8.2018.05.14.10.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 May 2018 10:03:02 -0700 (PDT)
Subject: Re: [PATCH/RFC] completion: complete all possible -no-<options>
To:     Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <20180417181300.23683-1-pclouds@gmail.com>
 <CAPig+cRkUrdtbyGEsY=DQCDoEWTrC-9n4=vKXHEap2gokB2uQg@mail.gmail.com>
 <CACsJy8BGs7EOYFKayL-bgvEbKOJiROF52o3SneLyG9Nm6nUngA@mail.gmail.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <ef3709f1-d9c2-860a-23d3-8d496294e1ac@gmail.com>
Date:   Mon, 14 May 2018 19:03:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8BGs7EOYFKayL-bgvEbKOJiROF52o3SneLyG9Nm6nUngA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.05.2018 um 17:24 schrieb Duy Nguyen:
> On Mon, Apr 23, 2018 at 7:36 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> I haven't looked at the implementation, so this may be an entirely
>> stupid suggestion, but would it be possible to instead render the
>> completions as?
>>
>>     % git checkout --<tab>
>>     --[no-]conflict=                   --[no-]patch
>>     --[no-]detach                      --[no-]progress
>>     --[no-]ignore-other-worktrees      --[no-]quiet
>>     --[no-]ignore-skip-worktree-bits   --[no-]recurse-submodules
>>     --[no-]merge                       --theirs
>>     --[no-]orphan=                     --[no-]track
>>     --ours
>>
>> This would address the problem of the --no-* options taking double the
>> screen space.
> 
> It took me so long to reply partly because I remember seeing some guy
> doing clever trick with tab completion that also shows a short help
> text in addition to the complete words. I could not find that again
> and from my reading (also internet searching) it's probably not
> possible to do this without trickery.

The fish-shell does something like that.

    > git status --<tab here>
    --branch  (Show the branch and tracking info even in short-format)
    --help                       (Display the manual of a git command)
    --ignore-submodules                 (Ignore changes to submodules)
    --porcelain    (Give the output in a stable, easy-to-parse format)
    --short                      (Give the output in the short-format)
    --untracked-files              (The untracked files handling mode)

Another tab will put a selection-cursor on the displayed list - you can
navigate that list with Cursor-Up/Cursor-Down, select an entry and that
entry will be inserted into the commandline. That selection process
would be useless if the options are presented as "--[no-]x" because THAT
cannot be inserted into the commandline without manual editing. And
that's the point of the fast option selection process.

> 
>> It's also more intuitive than that lone and somewhat weird-looking
>> "--no-" suggestion.
> 
> It's not that weird if you think about file path completion, where you
> complete one path component at a time not full path, bash just does
> not show you full paths to everything.
> 
> I'm arguing about this because I want to see your reaction, because
> I'm thinking of doing the very same thing for config completion. Right
> now "git config <tab>" gives you two pages of all available config
> variables. I'm thinking that we "git config <tab>" just shows the
> groups, e.g.
> 
>> ~/w/git $ git config
> add.              interactive.
> advice.           log.
> alias.            mailmap.
> am.               man.
> 
> Only when you do "git config log.<tab>" that it shows you log.*
> 

