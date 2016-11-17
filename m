Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1DFB1FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 22:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbcKQWmO (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 17:42:14 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33711 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbcKQWmN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 17:42:13 -0500
Received: by mail-qk0-f178.google.com with SMTP id x190so241242789qkb.0
        for <git@vger.kernel.org>; Thu, 17 Nov 2016 14:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lgY+bbm9h9EjSP+cVGVIVrC7xh2KgZnt7lmYayTWpsE=;
        b=cYRQADzHPRuriPrnr43akwMRm6kxyrTomi7D7EOhTwgNWFTZwbInxpNgV+MUPJG6yB
         n9+iREC9hgu3dSJUjnYhK3Y1I21+UtbcDpuObrNY0PDltXg02KYH11Wt+k/hCJaxjC2A
         5q/Hc7dPQu0FzE0H6bL4+TQw4lr0osBEt4DVjr5UdCYb5uW8QhQn9mZV+89QO5wk/5vL
         jBLziixsZOo5kD6VwMwmL+i8WCa+oY54EgxI3M0zNoPaW1W8sLMWr1eBC4OkDoTym/Ku
         O6Ptl+tC/Ob9OVm/uf9FFeWE30yVdkUHI7tXpSTtXM3QmvwACijYnV/AaKC0xhR47a5F
         R3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lgY+bbm9h9EjSP+cVGVIVrC7xh2KgZnt7lmYayTWpsE=;
        b=ANQD9qDk24AGtDDTceC6x2v3JFFcGpkQjwDO0JqAu5p2O9VMyH0n6w9XhcOjnrTG4d
         T5BfKw9JeO+mhDFqCAup6P3+KxdbD97FH3XuFszDAycpuIJHzx07XJYabgQHA/FBx9Kp
         aqA+p2pVXNrL7qJh7qoCP9pjqv1+JhSyvc3h2hiOK1L0kTQxA4l8G5YZz8+RYUtHi/1O
         CsSTMp/5gZIPa/XK+WS6UTaI3DrveUL2q7JELhi96BisdUclVy81NkbJRiK2lZKjoepE
         wrK1/UYS+6xjjnRWVeYgMQTNqJXP9EQc11aAW07sGi5w/LQq1J+4pJDHtOXkB+iLkseI
         7wfA==
X-Gm-Message-State: AKaTC01UDukYqT5LIGVSie/iYOh1BTwRxXv/P2RacikyJFdx8vOgR/3Tc73R7AIkPsPzdPAqni3R2kqfwtMgoOvb
X-Received: by 10.55.186.3 with SMTP id k3mr7292499qkf.47.1479422532274; Thu,
 17 Nov 2016 14:42:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Thu, 17 Nov 2016 14:42:11 -0800 (PST)
In-Reply-To: <20161117222926.GN66382@google.com>
References: <20161115230651.23953-1-sbeller@google.com> <20161115230651.23953-9-sbeller@google.com>
 <20161115234403.GE66382@google.com> <CAGZ79kbCqLsRzrsX29uM7pobs_11UZtFOQWP9RO8ptS5PyDfmw@mail.gmail.com>
 <20161117222926.GN66382@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 17 Nov 2016 14:42:11 -0800
Message-ID: <CAGZ79ka0-JFvogHRoTA4ioMK86zD=zkgEfBb-gpU8tbOjwEoFA@mail.gmail.com>
Subject: Re: [PATCH 08/16] update submodules: add depopulate_submodule
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Martin Fick <mogulguy10@gmail.com>,
        David Turner <David.Turner@twosigma.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 17, 2016 at 2:29 PM, Brandon Williams <bmwill@google.com> wrote:
> On 11/17, Stefan Beller wrote:
>> Well first you get the warning:
>>
>>     "cannot remove submodule '%s' because it (or one of "
>>     "its nested submodules) uses a .git directory"),
>>
>> and in case a d/f/ conflict arises in a later stage (e.g. when the submodule
>> is replaced by a file or symlink), you get another related error with
>> less helpful description how to debug it.
>
> Maybe a warning isn't the right thing?  Shouldn't the checkout fail if
> there are any issues?  This would force the user to stash/commit their
> changes and then retry.

Well if the path is not reused, e.g. you just delete a submodule in a commit
without anything else, you could proceed and have the submodule laying
around dirty?

>
>> >  All other submodules will actually be removed? Couldn't
>> > you end up in an undesirable state with a checkout effecting one
>> > submodule but not another?
>>
>> Yes you could. Maybe it's time to add
>> "git submodule intern-git-dir", which can be given as a helpful hint
>> or even run here first.
>
> That would be a good idea, does that functionality already exist in one
> form or another?  I'm assuming it must since git update does just that
> when cloning a submodule.

No it doesn't (it is roughly these three steps):

    mv ${SUBMODULE_PATH}/.git ${GIT_DIR}/modules/${SUBMODULE_NAME}
    git config -f ${GIT_DIR}/modules/${SUBMODULE_NAME}/config
core.worktree ${SUBMODULE_PATH}
    echo "gitdir: ${GIT_DIR}/modules/${SUBMODULE_NAME}" >
${SUBMODULE_PATH}/.git

The last 2 steps are done via

    void connect_work_tree_and_git_dir(const char *work_tree, const
char *git_dir);

in submodule.{c,h}

However we'd need to make sure the first step is performed correctly. (and make
damn sure we don't loose that git dir), so I think rename(2) does the
correct thing
for directories, except when these two locations are on a different mount point.

I think I'll just write this functionality in C and optionally expose
it via the submodule--helper,
such that the user facing git-submodule.sh only has to call that helper.
