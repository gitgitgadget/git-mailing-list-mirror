Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCD7F1F406
	for <e@80x24.org>; Thu, 10 May 2018 12:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757069AbeEJMRg (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 08:17:36 -0400
Received: from mail-pl0-f42.google.com ([209.85.160.42]:46868 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbeEJMRf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 08:17:35 -0400
Received: by mail-pl0-f42.google.com with SMTP id 59-v6so1201840plc.13
        for <git@vger.kernel.org>; Thu, 10 May 2018 05:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Hm2TwJeM9rGn7Yhr4/CoOk6CyWlGgyv2ZSWFyid/dj8=;
        b=nSbIj+tYKOL/Ik/YOS+LISAdO+YZAkzoRikyzMgU1FkCCpbE8X76RdkTW0nLgbH187
         7Qz/CFtwekPTS4R1R+VTcv2tFWOJczE9eA1PFxc6qtLy81/chIPX+liRGP65HISrc8E4
         OKCF4et1B5WrO6XOARAdVziI1t2ScyrLu8ObtF45hqh6SXTzaR3dy+66JyvQsNNEh69g
         1NV9VDznZv5hvKPCiNyT8jTsjQDzftBWphtJtQ0VV6Qddz3ZCNJ7fsiDj+FBejvaLFGy
         QYnwds+/6QnmLfRvkjvapEdkmQWT0MynC+mGqjX8mEV+DCOS2hh4ZIDEHqeW95Wh/xZ7
         IDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Hm2TwJeM9rGn7Yhr4/CoOk6CyWlGgyv2ZSWFyid/dj8=;
        b=cF8uWhQNEVapKNVUbtH1E1VYrETpsoN8rfBTdpeoAPQ+mIHafdOzHTfjdnsXmpLx7M
         lrF/PWNDHK8AQWb3Q+L0O/BW8RfHFoxkTcsMf8OQLlgRP6oM8rWRQRWK0AuXgFciQmB2
         p0qOLOYTbVXllagnINVO+D/52SQ5aoYwvIZjGmIWqqVlbkqQp48G0C8g87v0rxsFpOxR
         TN8w9+CQcxj2kU+fS9JmhhN6nxKPf6R7hnN+IkSvKM2+W2179icdp5fBQ8J/eLExBB3u
         ph49U4e8oBKJ4/YBfkMe0XGm+m66UiLdLLnVceWoVlsk7L1vpICIVjAN1gtySzDCLums
         2zmA==
X-Gm-Message-State: ALKqPwenMkVUL8p8rfmZy9Ke/eU4EyGTpKYagjGvS57Fl+Cj7b9q87C6
        bGqhV+vMX4wUKRui2O35kOGwM3zIPFdoPNNhpNprkbaA
X-Google-Smtp-Source: AB8JxZrxK1z/UDVakvC7tOpIswP+7JoIFPzijbbSsXe/R81hqzfRRVu0pvHDb72IuAaBEmq5NsGlAvh+sSg7vCeUlfI=
X-Received: by 2002:a17:902:b94a:: with SMTP id h10-v6mr1200951pls.321.1525954654680;
 Thu, 10 May 2018 05:17:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Thu, 10 May 2018 05:17:34 -0700 (PDT)
In-Reply-To: <20180510104136.8653-1-oliverjash@gmail.com>
References: <01010162c940b8bb-d8139971-3ee2-4cd6-bb19-35126d46753b-000000@us-west-2.amazonses.com>
 <20180510104136.8653-1-oliverjash@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 10 May 2018 14:17:34 +0200
Message-ID: <CAN0heSq5SyPgoEURRVHupcabVu3jX+tmX+0U-6azrJDDgfZ5Gw@mail.gmail.com>
Subject: Re: Regression in patch add?
To:     Oliver Joseph Ash <oliverjash@gmail.com>
Cc:     mqudsi@neosmart.net, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10 May 2018 at 12:41, Oliver Joseph Ash <oliverjash@gmail.com> wrote:
> I just ran into a similar problem: https://stackoverflow.com/questions/50258565/git-editing-hunks-fails-when-file-has-other-hunks
>
> I can reproduce on 2.17.0. The issue doesn't occur on 2.16.2, however.
>
> Is this a bug?

I would think so. Thanks for finding this thread. To keep history
around, it would be nice to have your reproduction recipe on the list,
not just on stackoverflow. That said, I cannot reproduce on v2.17.0
using your recipe. I suspect there is something quite interesting going
on here, considering how trivial your edit is.

As a shot in the dark, does your test involve unusual file systems,
funny characters in filenames, ..? You are on some sort of Linux, right?

The first thing to try out might be something like

$ # create the initial file as before, with "bar"
$ # git add, git commit ...
$ # do the "change bar to bar1" everywhere
$ git diff >test-patch
$ git reset --hard
$ # edit the *FIRST* hunk in test.patch like before (bar1 -> bar2)
$ git apply --check test.patch && echo "ok..."
$ git apply test.patch

Does that succeed at all?

$ git diff

should now show bar2 in the first hunk and bar1 in the second hunk,
just like your edited test.patch.

If that works, it would seem that the problem is with `git add -p`, and
how it is generating the patches for `git apply`. I have some ideas
about how to debug from there, but ... How comfortable are you with
building Git from the sources? Or with temporarily fiddling around with
your Git installation? (git-add--interactive is a Perl script, so it
would be possible to edit it in place to emit various debug
information. That has potential for messing up royally, though.)

Martin
