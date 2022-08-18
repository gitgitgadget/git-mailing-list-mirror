Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F49C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 20:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240922AbiHRUqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 16:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238275AbiHRUqb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 16:46:31 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE37DD2EB4
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 13:46:30 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-334dc616f86so72985857b3.8
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 13:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=u/q8M9SUCa6ZYle4hqYu+OcaCzbvX3IwIH6DUWos5mA=;
        b=qHwMcWaOm1UUoqKyGRPsNwPHPHkXYqCyp5ekBa3/tz0f2EGKArZajyWWCZC/zRzfOM
         +lSxTcqID08rIgoHfwfBpX2v+eO9wgZVzhofC8feeUN22+2RRrwdsvQ3OHpW8w+arePz
         ACKAAW5XmCijNhxTjerOD7q48amrbbL8k4eJgtCLEHIhVylrDQ+bDhFwysvuSG8DS1+z
         gSi/AzhRZ1xuYt4S7/c4txFLY/mEIK6jallPEhB4WwY2syr7/dFxT5bRrIWXjzJG9Dla
         vk43nOugVZFMyhHbBqMq7lbmg4FaMVentMIKoBTUFBrUBuqa2tUe4BO/RTu7hUThfB2T
         Jrpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=u/q8M9SUCa6ZYle4hqYu+OcaCzbvX3IwIH6DUWos5mA=;
        b=4P/LHLEJhye2qtOgNRxzwjLsm/sy1Ke92POXrE9OD6yL6DZG5uxOeDN8RoW+fs6sBw
         UgenTULWajOmIjTV+y2rxpegtrHY4JvfQxbBWwJk5ZRgrKpqArDo1+VmMgi7ikm6GqeA
         xsy/tXrITFpC6RTb/9acOjuh7Q5wszsgpEkYEpfScGxkHlMVPU3g+pfT4bPNTT4kMLF+
         LkWZ/Ei3VVltZ27zb0VH+EPFlYEdoqNPLaHapVHyyIeuM+SYaAEfiFTcXM2i1KQU7oF2
         QqsENHF560Wm8qV7gJSn/7X8zWB/mQChC6iFzt1TnJuzQjOqvcoVmgYFn7fiU3TDdNvd
         XvHw==
X-Gm-Message-State: ACgBeo0v4zymRdhRVVbtjmyn5DIPZz06WVwlGawnEdhic0kVCBcy0ekN
        pDlVeCezkpI5TEyy66v2Vo8qBavFyAQSxUlOOvFZbgS/Tvc=
X-Google-Smtp-Source: AA6agR7RvyX7QJWuAPLqhqWfGtkMZbe5C7MNRH3xyjvmH/4DgKHDbMrHJWJOqiGT4uY1Uc1EjNS1BAwn8Lo00A6KGr8=
X-Received: by 2002:a81:6e87:0:b0:334:344:6fdf with SMTP id
 j129-20020a816e87000000b0033403446fdfmr4640916ywc.130.1660855589820; Thu, 18
 Aug 2022 13:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1309.git.git.1660806376021.gitgitgadget@gmail.com>
 <pull.1309.v2.git.git.1660809243298.gitgitgadget@gmail.com>
 <xmqqk075qyq0.fsf@gitster.g> <CM9DZ4Z18PY9.1T2O8U54X66FD@cedar>
In-Reply-To: <CM9DZ4Z18PY9.1T2O8U54X66FD@cedar>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 18 Aug 2022 22:46:18 +0200
Message-ID: <CAP8UFD1304rQh+9jMUkTmTvmNBxm6BNDt3=d07+C8iXSbJb2RA@mail.gmail.com>
Subject: Re: [PATCH v2] trailer: allow spaces in tokens
To:     Maxwell Bernstein <tekk.nolagi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Max Bernstein via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Max Bernstein <donotemailthisaddress@bernsteinbear.com>,
        Max Bernstein <max@bernsteinbear.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2022 at 9:03 PM Maxwell Bernstein <tekk.nolagi@gmail.com> wrote:
>
> On Thu Aug 18, 2022 at 9:54 AM PDT, Junio C Hamano wrote:
> > So, the updated code mistook the body of the message that is not a
> > sign-off, because there is a colon on the line, the line does not
> > begin with the colon, and everything before the colon is an alnum or
> > a whitespace, so squashed the paragraph break before the real
> > trailer block and the last line of the body and made it a body-less
> > commit log message?
>
> I agree that it is not ideal, and I'm not sure how to fix it. This commit
> probably shouldn't go in as-is; I modified the test in order to demonstrate
> this problem.
>
> > This might be a good demonstration of why it is a mistaken design to
> > allow whitespaces, which may steer us toward fixing the documentation?
> >
> > I dunno.  What do others think?
>
> I think allowing whitespace is good at least for the Phabricator project, which
> despite being dead, has a number of existing users and existing commits. It
> unfortunately has a "Differential revision" trailer with whitespace.

I think allowing one white space before the separator is a good idea
for the following reasons.

First, if people use something like #, !, ~ or % as a separator, for
example in the case of a trailer like "Bug #43", it is very natural to
have a white space before the # separator.

Note that GitLab for example uses the ~N format, where N is a number,
for issues, !N for merge requests and %N for milestones. I think
Bugzilla and many other bug trackers use a #N format for bug numbers.

Also in some languages, like French, the typographical rules when
writing regular text is to have a space (technically it's supposed to
be a "non breaking space", see:
https://en.wikipedia.org/wiki/Non-breaking_space, but in practice
people use a regular space most of the time) before a colon. So it is
very natural for a number of people in the world to automatically add
a white space before a colon.

https://en.wikipedia.org/wiki/Colon_(punctuation)#Spacing says: "In
print, a thin space was traditionally placed before a colon and a
thick space after it. In modern English-language printing, no space is
placed before a colon and a single space is placed after it. In
French-language typing and printing, the traditional rules are
preserved. "

I think it would be very annoying for users to find out that a number
of otherwise proper trailers would not be taken into account only
because they have a white space before the colon. At least there
should be an option to allow that.
