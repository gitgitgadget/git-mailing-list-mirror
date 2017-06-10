Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77FA01F8CF
	for <e@80x24.org>; Sat, 10 Jun 2017 01:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbdFJBxD (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 21:53:03 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35102 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbdFJBxC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 21:53:02 -0400
Received: by mail-pf0-f171.google.com with SMTP id l89so33742961pfi.2
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 18:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+m0eF/6Tt2wdYwWOlxi12z/A/AyU0XwBgTARKI0jCQI=;
        b=r7C53m0hY9Jjp6kpXR2riRa3DWfG9UcpL/1rQwZJpujo1t+UOH5dJJa16OotjEpFnS
         ds1sCRzJcKVG/xtQYbsUnFjn5wewggpvx+XDr1hXaIQjbJUxpHZt/S4s3N/zru/V1ERg
         w3Q2REWP5tAkbfXbr3ReKNRFxn2tmSucRtIQNELSXnddcfpRRzRJvR6bhhPgFNMaNXvh
         2eP66vojNKhE40x6nKi3CZ79W3LyAbG623YIfeh2MdoiWZr/8QjdUx5zRB8+bDAacrfe
         L6CBH7b6aI9mCmO4izkJBHvwGkCs1l937eqtyI7qy2BWj5J6ZgtG5ckUHnsS4hWVra/X
         KOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+m0eF/6Tt2wdYwWOlxi12z/A/AyU0XwBgTARKI0jCQI=;
        b=RnJTKqOWYhNmlYxbqrlKCBcWv4QvPXuctHlnvjzSLOiOam+0cE4Eke/aY+uR0bx6XB
         Fi/fCyg15d2399gROqtrUm5BfCSTRoTet5aTvGvLqR9kUfi7gOcH7VpZSdiFGFkC5pVk
         gGvE6i0Ih3NbLIJpxt45Ky8nJKtEuz+GJ9gtgqKIzZlWAKmLRWjuj3BuoPmjjewUgWEZ
         48Fy/+clsxSt6dptHRZI67hh3IrNtE/M2Q83tmtMXdXMsWvSxKbwkzWWhlA4euLK5mD+
         UU2l9t13c2RVG9FgEkuKXSh4RSFQoRd5bWS50Ts1+9LrVhPx5jrs6o1yua/gZNOkztIU
         dUbg==
X-Gm-Message-State: AODbwcAdayksvZ3/CD2NpdxZAEkbyy78pD5sD+Oaqd0MyUoolQ6RlXBW
        cuZz142svcgKhg==
X-Received: by 10.84.231.135 with SMTP id g7mr43847084plk.110.1497059581861;
        Fri, 09 Jun 2017 18:53:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:25b5:3bc1:d744:5d92])
        by smtp.gmail.com with ESMTPSA id r85sm5468321pfb.61.2017.06.09.18.53.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 18:53:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: How to git push mirror local refs only?
References: <CAHd499BBNsai4SScOe6kADsgbGRLyGnDKyUcm8LZL-w8c9Webw@mail.gmail.com>
Date:   Sat, 10 Jun 2017 10:53:00 +0900
In-Reply-To: <CAHd499BBNsai4SScOe6kADsgbGRLyGnDKyUcm8LZL-w8c9Webw@mail.gmail.com>
        (Robert Dailey's message of "Fri, 9 Jun 2017 11:12:22 -0500")
Message-ID: <xmqqpoec4nib.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Dailey <rcdailey.lists@gmail.com> writes:

> So I want to update my remote fork with all my local branches.
> Normally I'd do this:
>
> $ git push --mirror fork
>
> However this will also push everything under `refs/remotes` which I do
> not want. And it fails if I specify a refspec parameter with --mirror.
>
> Is there a way to achieve this through one or more git commands? Note
> I'm doing this on a non-bare clone and have to keep it that way since
> I'm pushing branches I actively work on.
>
> An intrinsic benefit of what I'm trying to do is that the mirror
> command will also batch delete branches on the remote that do not
> exist locally, which is behavior I want since I do not need them
> anymore.

Something along this line in your .git/config:

	[remote "fork"]
		url = ...
		push = refs/heads/*:refs/heads/*

and then

	$ git push --prune --follow-tags fork





