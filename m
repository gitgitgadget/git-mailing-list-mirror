Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C4B120357
	for <e@80x24.org>; Mon, 17 Jul 2017 21:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbdGQVTP (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 17:19:15 -0400
Received: from mail-ua0-f175.google.com ([209.85.217.175]:36107 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751491AbdGQVTF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 17:19:05 -0400
Received: by mail-ua0-f175.google.com with SMTP id 35so2017644uax.3
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 14:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nuBpQa2n7P7AB2OiJIDc/vidQK6ZJQUt0JfHRBTlfQo=;
        b=JAsQcliIUOS17I6BiVOYwWBTwtYX5frNpHj9+uh3T0JzVnuiDjy2oqrXZJ9xLaymo2
         Q9HB1UHCZWgcibpwPdg4UZaNch24xRcL8c/KvIIizcbasL5G9ajMcxWqALf5HfPdl2ve
         90XQs0TwLGkkpGgNSpUAyXr1lXrktJUQWMgpaDerSt0P3XUe3ZEtQTfajAabBaejFg/8
         wCHfB5RtLAkAGK95SMQYwuQULvLkjhrqyAUwJqLgMENlo8PiPHl3UhfKMkbKpNPGNl7L
         oYphlmVhYpmzG0XNq7CO51wHZk4Z4rWFZSNqqDPnXXvYrF5tcYuKSElKo4g7QUxS2t1I
         SS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nuBpQa2n7P7AB2OiJIDc/vidQK6ZJQUt0JfHRBTlfQo=;
        b=WKfscuZ2sDYLf4DD8wikvErOFP7gqy9UJEqw+ItFuvmQdLpsWqLD+P03V8fGuM0FWy
         M0248UiZEldHCdV5MCRRTGmUdNwXLosUgBPxsIZSh9Xtn1mNOMI3zO5Yb7MoN1fN9VM2
         0Ly+r+Ph2Z9Z6NslaUpW6LTmeMIZ68XhnrnQSPT+zeavhijxqLidu7halyj7uFVS0lXW
         bElJ04MJ9AMAhoNlsqy4/CKSU1g0c36xnka2aw7WtUKomchbEVvNqYSvHowj7kHBPRGN
         5jjD2hEYXaEEYJBnQoo2QSpn8fkbmMo/spxwlb7cZybDAE7VirAX4sRzvrU/XHhjnVOr
         7d+A==
X-Gm-Message-State: AIVw1131L2aIfNgJ76Ta7QeuUZfc/fIhFUr/3SeFuAaixG3ERyXa4Y3t
        ls2N+G61deSl+Z6dICuJVfG779HlsQ==
X-Received: by 10.31.129.20 with SMTP id c20mr13518152vkd.117.1500326344212;
 Mon, 17 Jul 2017 14:19:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.69.25 with HTTP; Mon, 17 Jul 2017 14:18:43 -0700 (PDT)
In-Reply-To: <20170717172709.GL93855@aiede.mtv.corp.google.com>
References: <CAKY_R-uk9hpR2hbkPsw2cqoMo6bQKoyp6cWTO20L3fOWfLW2-Q@mail.gmail.com>
 <20170714180313.apsnbnw7no2nvtf5@sigill.intra.peff.net> <20170714181831.fvi2coppzhm747mk@sigill.intra.peff.net>
 <20170717172709.GL93855@aiede.mtv.corp.google.com>
From:   Marko Kungla <marko.kungla@gmail.com>
Date:   Mon, 17 Jul 2017 23:18:43 +0200
Message-ID: <CAKY_R-vsZo_OsA8F6DVx_4zi5=RpBfOn-w1Ou7pq-F7HTtptzg@mail.gmail.com>
Subject: Re: [PATCH] check-ref-format: require a repository for --branch
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I guess that should only be about that it should not hit a (BUG).
In my case in the example I gave I scan trough the directories to
check repository status one of the tasks make use of check-ref-format.
Since it may hit directory which is not a git repository it should not
expose error (BUG) right.

On Mon, Jul 17, 2017 at 7:27 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Jeff King wrote:
>> On Fri, Jul 14, 2017 at 02:03:13PM -0400, Jeff King wrote:
>
>>> So I think the patch below is probably the right direction.
>>
>> And here it is with a real commit message, if this is what we want to
>> do.
> [...]
>> --- a/t/t1402-check-ref-format.sh
>> +++ b/t/t1402-check-ref-format.sh
>> @@ -161,6 +161,10 @@ test_expect_success 'check-ref-format --branch from subdir' '
>>       test "$refname" = "$sha1"
>>  '
>>
>> +test_expect_success 'check-ref-format --branch from non-repo' '
>> +     test_must_fail nongit git check-ref-format --branch @{-1}
>> +'
>> +
>>  valid_ref_normalized() {
>>       prereq=
>>       case $1 in
>
> I don't think it's right.  Today I can do
>
>         $ cd /tmp
>         $ git check-ref-format --branch master
>         master
>
> You might wonder why I'd ever do such a thing.  But that's what "git
> check-ref-format --branch" is for --- it is for taking a <branch>
> argument and turning it into a branch name.  For example, if you have
> a script with an $opt_branch variable that defaults to "master", it
> may do
>
>         resolved_branch=$(git check-ref-format --branch "$opt_branch")
>
> even though it is in a mode that not going to have to use
> $resolved_branch and it is not running from a repository.
>
> Thanks and hope that helps,
> Jonathan



-- 
Mail:    marko.kungla@gmail.com
Phone: +31 (0) 6 2546 0117
