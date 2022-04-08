Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C880DC433F5
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 08:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbiDHIEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 04:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiDHIEo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 04:04:44 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903A666CBE
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 01:02:34 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id j17so6270286pfi.9
        for <git@vger.kernel.org>; Fri, 08 Apr 2022 01:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vhUIodTx0PDVY7kk7yXrRy6kczUx0FbS/wVlnOZQHkE=;
        b=E97LMeoqMyf5FZdmKeQb/4iv2x4Ut7TAgIIR74nU7k9zt3pe5qJlgDr7j8MjZr4jat
         N9qaFMl2cmuk2Vvc7xQiXrY+6NvK8dDdirzmrtaFsh1thrfTnU4YoAKzKFeTEWfeW9XK
         tllg+WQGgKkdnH/L74jUZAy541gw7DdqvPx21MuqJJTe3m9qw3qbRRR3tBxsCQO23gCH
         BAFqBw8DXOmmMJHS0GanWs8PPKBUzXmkBHuiSpUSo7PidmQ1hTCHPZYjcH3cD2QzmUjP
         boFDJrWu52LuJNmnoeCL6hcN9ZTICrfdZ1ENdT7yw7Up/88JqBnO06oSu33apRjgkv4b
         YWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vhUIodTx0PDVY7kk7yXrRy6kczUx0FbS/wVlnOZQHkE=;
        b=i7uudf73u5wK0pZjvx/si/EiIAEI0Fpba/gluSFDBeIwBHHZE7sAsC5y/RKlTCJkHM
         44hPTc0BTGHmESAFTosBnI9MfvuNIEGM7otr5d+aUd5IYl+phlfEO2w3ii+VlOhffh3y
         bfd0bbqp4q1BKNQqduW/voLqcyC84xhtlNeVCDjIvNIaFmQOmyUj4R6Ki+VScjpgcrZV
         g9oGKw/cgzi+c/tdvxgC6995u5Qw1E6pfRg1M89PFVMvyaIA+r4tLnDVh5TfHnT3kIAz
         pp5H+2yu14XrTz5o4dL2WJc57yNRN+TSpOJdbU/ro0VL1SvoiD0ewxBqxxTMtkVxHlyO
         Rb0Q==
X-Gm-Message-State: AOAM530cS6h0EwVw3OjXCXu6VA4ZE7WAx3Zxhz7d2w5H/AfXTCX+BETG
        j3CDA6SVBfPNJcvD46Yo/jtOaTV7eu34CNq3k5oyuheaZAU=
X-Google-Smtp-Source: ABdhPJxyyqzgdOo+KRq2a4uh2sbizVbwmtQN4khx3HRUDHUcQIABRtMOnYlD/XPbR2j0LZ7RWNpKc346AhLpjO6WkrQ=
X-Received: by 2002:a63:4421:0:b0:385:d870:d598 with SMTP id
 r33-20020a634421000000b00385d870d598mr14525183pga.361.1649404953523; Fri, 08
 Apr 2022 01:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com>
In-Reply-To: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 8 Apr 2022 10:02:21 +0200
Message-ID: <CAP8UFD2Tk-FuGcFN0DEKK6g3O8G=SGuU99FPRRqPM_-39i9t0A@mail.gmail.com>
Subject: Re: Make commit messages optional
To:     jurgen_gjoncari@icloud.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 8, 2022 at 6:10 AM <jurgen_gjoncari@icloud.com> wrote:
>
> I think that often commit messages are unnecessary. I propose that by default a user should be able to commit without a message.

We prefer to encourage users to do the right thing by default and
provide a commit message. We think that good software development
practices should be encouraged and that providing a good commit
message is good software development practice.

> I don't think this would be a problem from the UX point of view, because a user could get a lot of information about a change, from the history of the GitHub repository, such as from the time of change, and seeing the diff.

What about `git log --oneline`?

> I think that making commit messages options wouldn't even be a problem for retro compatibility because the feature would remain still functional for those who would want to use it.

Yeah, there is no compatibility issue because `git commit` already has
an `--allow-empty-message` option, so empty commit messages are
already supported. That's not a good reason to make it the default
though.
