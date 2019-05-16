Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 914911F461
	for <e@80x24.org>; Thu, 16 May 2019 11:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfEPLZv (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 07:25:51 -0400
Received: from mail-it1-f182.google.com ([209.85.166.182]:53898 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfEPLZv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 07:25:51 -0400
Received: by mail-it1-f182.google.com with SMTP id m141so5481878ita.3
        for <git@vger.kernel.org>; Thu, 16 May 2019 04:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lE0i+5VtdTIjirYmGo5SVZ6sG9PNdxoU7IbpHUftF8w=;
        b=BY+JvOZPHCQtzLAFnzyze2za8dT0YzuEwfteLM7YfHn2oqnIVYmXCQw9qKklMS+yMB
         541Kuo4x8PaWvjtIZ8//grVeLfB6YKqLOtm5TPrRIf+kj0slwVxNvKsCDbnnCkAJKG8A
         trQueMljung3W6MhIG+D3yMXUKj5SpdVfzX2AZc3pf3ua+VnMIsKbwFH2BCWUCRVcGyN
         JGld6It+tEMfLX5+9KzryDi0XuPg1RiZIjSAZQeyV+S2iaPzH/8zo32/cNO+fmZWHKtF
         OrDvFXGC2k05iYtV0eyRg8HEKAvV1byShONoHS1g2EqXRoJYo4ZlzNGPFZwq83PtLrEB
         kyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lE0i+5VtdTIjirYmGo5SVZ6sG9PNdxoU7IbpHUftF8w=;
        b=RKL+k56eEimLe0tH5EOn+Dtp5gNxY9w5xYxRgFZgGOZ768uZlt0F8eYLvtEBLM3ZZG
         XuylqVuj5mD6vHYZfGTZfI4Q6zZtfuGX9Zhdhftvlgaf37a1KRGCBLWCmeYDIuiOfwpI
         Xmz0veaW3nDmu5AGxYBQhOWTWJOmw9l6T0VImnppBsr2VJ7C5l17ODB220V1q+d/oCwv
         TltTV0OSmyi794SOymB8VhjwK77dwVUNsrf6+BMSchwsnsu+/guVFbbcUxWfecxVn+0i
         r0+7JGjSBmqDCrrLUmhUXLMG1WDQ3RFMGn2RQq2icJOB7enBD6NkBsGf0fF1bYU9GJSg
         geMg==
X-Gm-Message-State: APjAAAUioqzOnJW3u4/vaoG/FM8Mo7B3INXPRH4WIR3Gjh0LRYKuc/Pe
        OVuyyEijIVb9RyVvr24k7eRn9ct8mzHOWgItz58VIg==
X-Google-Smtp-Source: APXvYqx0KWuM/7FeJvYPNPfTqkPxlKW9hUIXuzV5iYY0pDattjgfJ7KktZRCFYKi88K6kk0zbb3hmbf7SFaIK9f5P+w=
X-Received: by 2002:a02:ba85:: with SMTP id g5mr31077984jao.92.1558005950112;
 Thu, 16 May 2019 04:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAJFQqN+Z9eX6onaj8vVSqpvf-nOC7-Y0Un4NLUie6x6bGfmvZA@mail.gmail.com>
In-Reply-To: <CAJFQqN+Z9eX6onaj8vVSqpvf-nOC7-Y0Un4NLUie6x6bGfmvZA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 16 May 2019 18:25:24 +0700
Message-ID: <CACsJy8DnkjuZD-9pbhAsFo16jHKt8U831LLxb3-nCQP5_FOmtA@mail.gmail.com>
Subject: Re: Running 'git worktree add' in 'pre-commit' hook
To:     Cosmin Polifronie <oppturbv@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 9:53 PM Cosmin Polifronie <oppturbv@gmail.com> wrote:
>
> Hello! I am trying to run 'git worktree add <path> HEAD' in the
> 'pre-commit' hook, more specifically in a Python script that is being
> called from the hook. When doing so, I am greeted with the following
> error:
>
> On Windows 10:
> Preparing worktree (detached HEAD cbfef18)
> fatal: Unable to create 'C:/Users/meh/Desktop/abc/.git/index.lock': No
> such file or directory
>
> On Arch Linux:
> Preparing worktree (detached HEAD cbfef18)
> fatal: Unable to create '/home/cosmin/Downloads/abc/.git/index.lock':
> Not a directory
>
> Is it forbidden to call this command from a hook?

pre-commit hook sets GIT_INDEX_FILE to this "index.lock" so you have
the latest index content (which is not the same as from
$GIT_DIR/index). This variable will interfere with any commands that
work on a different worktree.

So you probably can still make it work by backing up $GIT_INDEX_FILE
(in case you need it), then unset it before you use "git worktree" (or
cd to it if you keep a permanent separate worktree for pre-commit
activities). To make sure you don't have similar problems, you
probably should do "env | grep GIT" from the hook and see if any other
variables are set.

> If yes, what kind of
> alternatives do I have? I need to make a copy of the repo in its HEAD
> state, process it and then decide if I will pass the current commit or
> not.
>
> Thanks! :)



-- 
Duy
