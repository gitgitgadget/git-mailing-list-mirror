Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 410C11F404
	for <e@80x24.org>; Thu, 19 Apr 2018 05:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbeDSFno (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 01:43:44 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:41936 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753293AbeDSFnj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 01:43:39 -0400
Received: by mail-wr0-f173.google.com with SMTP id v24-v6so10455112wra.8
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 22:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GpzQXk4ErX9G3zpD0QEV0tR7/upG1KPU7F4oUW9DZhA=;
        b=FD/B+rGle3hyfnxRHbzQwoTgabk3Iv1e97fLw4hLy0bwLW/6Vf1AZEPZJ67VgFtyWr
         c9up5PgZmN7Gob0lNthsloUK6USKappHkO+AtJK6ytzRpdK2JmyaPbeXv4p2KaKdORRh
         1HD7MTypqtJmyZKI/kKIXgzae6crbigPDZUVdIiOYQ/xbP7+4b7tKmw05705iTN0TNlt
         3PaH8Lnqm0lplQ8BTFrvrHWJO0hG18onMo8IKXOX+M4k8pxkLYlFWb8fgMMFxJx/cQWm
         w76/DRXO7R1z/Ah0rg/xLY+VJzGDSTZMeNVFgUpwbOn0gPljeS4BcixFGevoOcvEc6XX
         7LwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GpzQXk4ErX9G3zpD0QEV0tR7/upG1KPU7F4oUW9DZhA=;
        b=NV6SysYbye9hPkqQ8B0ug1te9hqrnKe0fyarg7Nqo47j24jNFVIn9gYr0vfv3mwQ03
         nqg+pfmuRkJLrZ5JihpRmOekfMDPt1EJfwJq4rEReOrq8J3ageXcsbyWYHJFONS594q+
         WryXNJGy8zewo1MYQmqLAbhFpxvyMLVL7zHRQ3WDeJ3u2+X0XAQpZ079opD6pkBpfp+5
         jFbx5QIMfIrKAT+L/OVEsG0XK/xoGUqkrL3YG2VLxg5mnTj+fYmevYA1CHyd0mMjOe+W
         fZKUJvHjlrYo0QoSH3BW9g/Z5+kmjMjXo63S83Ina2GG1EcHJc5WUYvhEHg//ZVLfO6i
         4e7Q==
X-Gm-Message-State: ALQs6tAOqWfNAzas94efxvjxY1R1F2+WJSEkIY8PNDxJreen2np3Tp3Z
        Y6q+TFN4VhW89X7gIuMwmCFw+886oG44yPe1dkE=
X-Google-Smtp-Source: AIpwx4+WBvKpdxBWaW9JJaK8vZczVOALMcz7cmVLiLxky5DKn0/ytWt8OGCi6L9ddAZVE8WJ+GUSYe+CaM0zR/OsSeo=
X-Received: by 2002:adf:b937:: with SMTP id k52-v6mr3537311wrf.116.1524116618863;
 Wed, 18 Apr 2018 22:43:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.146.194 with HTTP; Wed, 18 Apr 2018 22:43:38 -0700 (PDT)
In-Reply-To: <CAGZ79kZL_+AZx2kFyoOokUPsqRzQFT32aj1XqHf8o7OJFwsABA@mail.gmail.com>
References: <CAGZ79kbT+AnVu-AJ9=OSt=Z2ErM5ocfoLfgx=qmHFfbnkqJqwg@mail.gmail.com>
 <20180418223552.18345-1-eddy.petrisor@codeaurora.org> <CAGZ79kZL_+AZx2kFyoOokUPsqRzQFT32aj1XqHf8o7OJFwsABA@mail.gmail.com>
From:   =?UTF-8?Q?Eddy_Petri=C8=99or?= <eddy.petrisor@gmail.com>
Date:   Thu, 19 Apr 2018 08:43:38 +0300
Message-ID: <CAK0XTWcOpb5DS5c0MAomfaS2G0TPDTDtchm9FhkOSDBS5r5j+g@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/9] git-submodule.sh:cmd_update: if submodule
 branch exists, fetch that instead of default
To:     Stefan Beller <sbeller@google.com>
Cc:     =?UTF-8?Q?Eddy_Petri=C8=99or?= <eddy.petrisor@codeaurora.org>,
        Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-04-19 2:53 GMT+03:00 Stefan Beller <sbeller@google.com>:
> Hi Eddy,
>
> all the following patches 3-9 are touching the test as added in patch
> 2, which would go best with this patch.
> Could you squash all commits into one?

Yes,

I did not have time yesterday to put all changes into a single commit
with an associated note (because note managment seems to be a huge
pain), so I preferred small commits.

But I wanted to get your feedback on something, I'll reply in thread
arm where you actually suspected the problem.

> There are a couple ways to do it:
>
>   git reset --soft
>   git commit -a --reuse-commit-message=3D<...>
>
> or using
>
>     git rebase --interactive origin/master
>     # and then marking all but the first as "fixup"

I am aware of git rebase -i and use it regularly, that's why patches
3-9 have the 'fixup' prefix.

> I think the end result looks good, but that is best reviewed as one
> piece instead of 9 patches.


--=20
Eddy Petri=C8=99or
