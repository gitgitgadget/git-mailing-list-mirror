Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5FB120372
	for <e@80x24.org>; Fri,  6 Oct 2017 18:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbdJFSNi (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 14:13:38 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:43707 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752292AbdJFSNh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 14:13:37 -0400
Received: by mail-qk0-f179.google.com with SMTP id w134so18731677qkb.0
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 11:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dYhUZGfusCSeaXL3XUH+/twlnrgCjjtBb3KK6+MLfPk=;
        b=tWKBcQ7of4LPv/6TQ74cLtSWUhEUlFBpHj2v7LH9IJcZeUFOnmJI8XuHa/Ge9+Aluv
         W9JNU3K9gvscu0gyhuyrHQvGvrVOGoNRASvBgV8SmDOFQPzMI44/+kUv9KJxwI7rw5KM
         zAU9sBKva/F8ZOSTUGwoAMv+Oq38kJAsBUCb1E5Dd/qD8qpZXLqm0GdQbItP0YfhoP0b
         +76kAiuhrSmXsEZj0zmxFOChIjsyo8cT8jJlsHjBNYpXvhRb93EfkwToCIOxElHxUY9X
         g1ghAIDyZPnCfmFd5U1pJhSgd3y2eCaCfqdmRWEy1j4iGqgQqDw2VTn6HjnTLmXrTMVh
         9mTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dYhUZGfusCSeaXL3XUH+/twlnrgCjjtBb3KK6+MLfPk=;
        b=ZVnyvDvOpymVNxB/ODRL5DlVA/VuWOHATF71aNwmxPT17XPE7qStLdvQ9/BvuLq5bE
         3/YttJZsfb6uJtzhya6d7cB0J3eP8Yl49LWQnmLChLu6hYyVealGPGMcpwUPfUbOc1pf
         WQIrZiVp1KCdtfjH3+0J3Bf/1jCYcQsU/iim7PjPCaMMO/gycAHyELAuHAh4IHU9aegi
         KkMr1dPEFcwW0lVY6C8ASCyDwALYdGsDJL6jAmCzg37YgFte5P0mAhBN1ZPYZMnJkKLg
         8OQY5iZM006D6WYFtXGvkm0AJSQrxMqm0Z2GmKIh7Si9LO4ucL2E3oJvUo8z9H67LHlJ
         6FEg==
X-Gm-Message-State: AMCzsaUiLp+q/kPzgm1/RzAMvZLAXyWXcaT9o2CXDN0SxVHrdZeT4W0n
        Cm3kd+rl2Xh4w1jCPzBasXX6DsOkXwrPBrxp9wjMAfBRNEY=
X-Google-Smtp-Source: AOwi7QBTXHRtCWwRLJpl33ExeqASXjRvreoU116o6CibZ6vMMXZ6chjpeBYn3UpP/BObPn/nMW6hLMUsPiolGg6KW3A=
X-Received: by 10.55.90.199 with SMTP id o190mr38799352qkb.180.1507313616657;
 Fri, 06 Oct 2017 11:13:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Fri, 6 Oct 2017 11:13:36 -0700 (PDT)
In-Reply-To: <AE36B16D-0284-4AC0-BD5E-CD346036D69D@theunraveler.com>
References: <AE36B16D-0284-4AC0-BD5E-CD346036D69D@theunraveler.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 6 Oct 2017 11:13:36 -0700
Message-ID: <CAGZ79kZBKhg7buTDXZxG7mtr7gLE0ZmJkPFSd0xUCyTiuR2rng@mail.gmail.com>
Subject: Re: git add --patch displays diff and exits
To:     Jake Bell <jake@theunraveler.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 6, 2017 at 11:09 AM, Jake Bell <jake@theunraveler.com> wrote:
> Hello,
>
> I'm not sure if this is the right place to report this issue, so apologie=
s in advance if it isn't.
>
> Recently, I upgraded from git 2.14.1 to 2.14.2, and noticed that "git add=
 --patch" does not work properly. It just prints a diff of what's changed a=
nd exits, instead of presenting the dialogs to add changes to the index. I =
did some bisecting and tracked the bug down to this commit: https://github.=
com/git/git/commit/136c8c8b8fa39f1315713248473dececf20f8fe7.
>
> Unfortunately, I'm not familiar with the codebase and don't know C well e=
nough to debug the issue. Please let me know what additional information I =
can provide to help you all figure it out.
> Thanks!

Please see
https://public-inbox.org/git/20171003093157.gq7za2fwcqsouire@sigill.intra.p=
eff.net/T/
and replace the color=3Dalways by color=3Dauto setting to see if it fixes
your problem.
(If it doesn't we're dealing with a new problem and not the one
reported more than 5 times already :)

Thanks,
Stefan



>
> -- Jake
>
