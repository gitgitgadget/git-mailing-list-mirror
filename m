Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DC4F1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 23:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752091AbeDRXxX (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 19:53:23 -0400
Received: from mail-yb0-f169.google.com ([209.85.213.169]:36292 "EHLO
        mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752291AbeDRXxW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 19:53:22 -0400
Received: by mail-yb0-f169.google.com with SMTP id v140-v6so1241727ybe.3
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 16:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MWnLVvJU/AzF92h2LWSVb4tNDqChvLo++Wu2oyhqdUU=;
        b=R8/iPCWO3O5l3dI6DM2fpafvvMah5Xo9UND6GS2yI4Fiz7ehHLRogvLLI26A+D+Z8r
         FICaIDWcpodjJJ2hwrwzvdOqmTDK9mP/d+0gOFQWYZE5yPBrbKUCv9MVg8QSD0Vd6nsu
         lPIf2SBviERClUeDbR3aAb7ZfKDbE2Mu1yTl/gxA1BIz+MUcwxX+Y0UdRXlxB5Mqpeps
         zp+pH5DmXV2LFFcmq/mS8oWjeMeMSwagM0lnOfo7sO8N8zyEzkiRKSlVru/neVBcKFUj
         3YEQYaRknof1v/H2QQzFkWjeq+buQjrrYZaent4GVNjQ54EKiPQJVu0XTFwjg5Q+oc0L
         gotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MWnLVvJU/AzF92h2LWSVb4tNDqChvLo++Wu2oyhqdUU=;
        b=bOKIKqZR6nPNPkV8PpuTKqB0DJ+NBN9v4Z7YSJS/zLY8gJW/1nAW5Hk4T5MNT7gFX8
         tOxB8lq7gwGmpYdth9YsBjOQuKGcosscOXjv6B+3mCUyq85we8LxpC0kLb/Vi97B/ZRg
         1GMVGhDAqoHxk/icVbA+GTP5NS5rJvJCKIDQNXS8VN8KlvnC6lR/aQCWjB76ovqqJLHI
         kr8gpAAt8U9BfEzXd5t684BQqrjYNtGtMFm+14G7WYUjqDMhRTftQDTpK0qrtZ+UOq6P
         eZmuVN7EhRXR6hWlrKM1nRgJ6rP3MWa2/YViOWU+lMtV3xzaTEZAifKHbvM2jPHHbY1z
         xbBg==
X-Gm-Message-State: ALQs6tAtb8T73PkgO88hC+aUKBecqcIu1SmeK56GlQ8qHgqOtfAazQ0N
        NRc9Kq0+RnseTJrn1JuaVM2gV1YLrt9qTmSq8gf6iA==
X-Google-Smtp-Source: AIpwx49Diwk6SOr+YGPesdKV62vWTPJCjkQeXdoahjf87XFMAo54AJW7OmSSFv/E+pAT3QUEXcQ3YRp0Q0jwcC+f1CY=
X-Received: by 2002:a25:6cc2:: with SMTP id h185-v6mr2567272ybc.307.1524095601623;
 Wed, 18 Apr 2018 16:53:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Wed, 18 Apr 2018 16:53:21
 -0700 (PDT)
In-Reply-To: <20180418223552.18345-1-eddy.petrisor@codeaurora.org>
References: <CAGZ79kbT+AnVu-AJ9=OSt=Z2ErM5ocfoLfgx=qmHFfbnkqJqwg@mail.gmail.com>
 <20180418223552.18345-1-eddy.petrisor@codeaurora.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Apr 2018 16:53:21 -0700
Message-ID: <CAGZ79kZL_+AZx2kFyoOokUPsqRzQFT32aj1XqHf8o7OJFwsABA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/9] git-submodule.sh:cmd_update: if submodule
 branch exists, fetch that instead of default
To:     =?UTF-8?Q?Eddy_Petri=C8=99or?= <eddy.petrisor@codeaurora.org>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Eddy_Petri=C8=99or?= <eddy.petrisor@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eddy,

all the following patches 3-9 are touching the test as added in patch
2, which would go best with this patch.
Could you squash all commits into one?

There are a couple ways to do it:

  git reset --soft
  git commit -a --reuse-commit-message=<...>

or using

    git rebase --interactive origin/master
    # and then marking all but the first as "fixup"

I think the end result looks good, but that is best reviewed as one
piece instead of 9 patches.

Thanks,
Stefan
