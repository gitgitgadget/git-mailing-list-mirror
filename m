Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672C4C433F5
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 11:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352607AbhLXLp2 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 24 Dec 2021 06:45:28 -0500
Received: from mail-il1-f171.google.com ([209.85.166.171]:42646 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343860AbhLXLpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 06:45:25 -0500
Received: by mail-il1-f171.google.com with SMTP id w1so6368108ilh.9
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 03:45:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CNaZe4XqAZRObynFZzUvYubCrk3oUu27LXK1jWxmM3Y=;
        b=ouLNxc6zm6Js80awVRbkUJ2jQTN5I7kVPyWNp9OZCfYaDlUAdpCnAy/fYFh3rvFMpR
         eTkjrwXud2jeAZgaMpC/ctAM48ceLSspoF7tYOrFHX5dVcaYcFyOfm0TRks4XoaguRux
         x5j9lZyAhAMihpkLUKVhTfL/03TXZ8WJ9bjiLvpkwjbhFRhq7ipVSj+ftVljchBz5Bww
         BSneAOxKp0YCm9SiIVL8jtkTqOD0E6oBeA5iNpCoMWKOc8nak9PhUmZLoJHNGe7L5/ZJ
         zpxuCTZ+exHDnH9V0lRLKKvbhvxlFwJjG/1//jm2I6soaP7twDuoKGvMqJU31lncPg5d
         W4WA==
X-Gm-Message-State: AOAM531sxpr2mXR1gFrBj/UVFVneMlqwFfvmo+yp3jK8VyhptuFZLPa+
        mB8GwWlDeITy+ENwoSDptrGDin50DUdKDEn8qtJ2kPoS7Io=
X-Google-Smtp-Source: ABdhPJwWppeI9e5XxSUd3OWPJBMwLeYaJmmtdgKpL74GskDx21RWXmg5CwDYF7YwbmDLkes3ibmBjpyj5ImGOc4MeFA=
X-Received: by 2002:a92:504:: with SMTP id q4mr2693726ile.126.1640346325340;
 Fri, 24 Dec 2021 03:45:25 -0800 (PST)
MIME-Version: 1.0
References: <CA+JQ7M-ORVCj6teGjVy01SF=f0=PdKKYdHNU9ruK9XUAX9F8Ag@mail.gmail.com>
 <DA9B4728-C45D-4CA0-A40D-4A81665AB0E6@gitlab.com> <D22DF4C4-C98C-45FB-8D26-57B50A44FA3F@gmail.com>
In-Reply-To: <D22DF4C4-C98C-45FB-8D26-57B50A44FA3F@gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Fri, 24 Dec 2021 12:44:49 +0100
Message-ID: <CA+JQ7M9xEHezQG0ui+jrhdWRHAausqxe5W7ucj4XkiLwnFL+Yw@mail.gmail.com>
Subject: Re: bug: git name-rev --stdin --no-undefined on detached head
To:     John Cai <johncai86@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Fri, Dec 24, 2021 at 7:09 AM John Cai <johncai86@gmail.com> wrote:
> This would have the potential of breaking scripts that rely on the current behavior.

Presumably, using --no-undefined scripts rely on presumed behavior
that doesn't exist.
Similarly, using --name-only should expect to return a symbolic name
While it's possible, I think it's rare that this would break scripts
in an unacceptable way.

> On Fri, Dec 24, 2021 at 7:09 AM John Cai <johncai86@gmail.com> wrote:
> Since I’m a bit new, I’m wondering how we generally handle these cases?

I'm also new so I can't really comment on this :)
Though I believe the git suite in general is quite adamant on
backwards compatibility
