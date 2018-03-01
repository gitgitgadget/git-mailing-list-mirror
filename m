Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1EC41F404
	for <e@80x24.org>; Thu,  1 Mar 2018 20:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161490AbeCAUO5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 15:14:57 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33045 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161420AbeCAUO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 15:14:56 -0500
Received: by mail-qk0-f172.google.com with SMTP id f25so9236630qkm.0
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 12:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=SIS9iI0Wwow3F+4RUGIrNdbw6ZO/ZkyRnSu4cZgLvYo=;
        b=b0GqOtZ+65lGQ6nOx0iXjLXdlGL8l6KXjwJtE3k24htIcVUm2A63GBgZ5hqARnu/IF
         QKo334VjGfVdtKSqZ8iW2MDz3E/hAdmRQKdMVuLRqRNdz7gITB5sZOPw0pI3HlKs+IeE
         sswlW+fWkPDSJwSnW21i7dYytXF/zMek5HRxLDfwRwuMYXDXv2fzY81Am5R0OphxfiSa
         R/9xfTiAairXfSXLK9S3dgoNIcizTGi/rGZpc4JEgAZzlVeH6XoABzLw/FPO3BAj1SYi
         2ywY/iHwBzz3Hf4Kk5ZwtoKB79W9rcBUVIOMC5SosEFHzrQbOeCFBlFC8lhCJgw6Er8g
         o/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=SIS9iI0Wwow3F+4RUGIrNdbw6ZO/ZkyRnSu4cZgLvYo=;
        b=gepFUrH3tQc4M04k7cwB7xs9PZNH/oMQeGcp9l06XwSqDNiYcrcjTlDE7Bc6X5Vk9t
         Dy4IXZmqKI/qRGtOFzgZhsCufd3MNcbxBnORDJZwiVYREPQfGoClwWEx6EhHhTMZy/1f
         Jg53d3mm4EqxVUKOsoQpvafsGXXz5Wvt/Wic3WGFQr90pVSC4Q69zWB8/9MwOX2YwKZx
         mv5luvcnDN4grVv6B3yZLFKa0eL+1Z/aC1U2U6aYo69ZmEqhhNjoc0jWZAZ3jVtRB5IT
         h+E2YIU2xTxxs5NuWouz8NzYVFRxVzC7E52omepzR2B0xVYFOe9ayVJ3MCdLQSPbsblc
         dKlA==
X-Gm-Message-State: AElRT7GTUwwMAfXdLJV22HJaup9oeGuvmPaybC3fttZTn3jPeCW7so2p
        mRUFfd0rV1qBE9X0zsenKIfcVuAn9Tby9gYLqvJgwg==
X-Google-Smtp-Source: AG47ELvmyDk+xoi4aywVYyFisN2RfAmW24n20/Rf2CTKY3wepSmcllcUZ27rOx8a/2Q0tuna3IOWlbgrqGe8UQcaD/Y=
X-Received: by 10.55.32.2 with SMTP id g2mr4703799qkg.176.1519935296153; Thu,
 01 Mar 2018 12:14:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Thu, 1 Mar 2018 12:14:55 -0800 (PST)
In-Reply-To: <adf7a7a0-3571-5b68-5d15-30a9067e3826@aegee.org>
References: <aa98f187-4b1a-176d-2a1b-826c995776cd@aegee.org>
 <CAPig+cSGJhNR8dapLXN0TU8ZpTqi7m6OQf_cCGmHc9FLGcwNyg@mail.gmail.com> <adf7a7a0-3571-5b68-5d15-30a9067e3826@aegee.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 1 Mar 2018 15:14:55 -0500
X-Google-Sender-Auth: YIhpiW5EnyDK9uPe2QQVFIZ6T0w
Message-ID: <CAPig+cTPFSbT7WxyoNEOSg=3Ft1pVzkgieGp44kHnZ9=NbYsqg@mail.gmail.com>
Subject: Re: Worktree silently deleted on git fetch/gc/log
To:     =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <dilyan.palauzov@aegee.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 1, 2018 at 2:24 PM, =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=
=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2
<dilyan.palauzov@aegee.org> wrote:
> /git/A/.git/worktrees/b/ is missing - that is the point.
> /git/B/,git wasn't modified since the worktree was created, cat:
> gitdir: /git/A/.git/worktrees/b

I'll assume that the lowercase 'b' was a typo in your email (as it was
in mine), and that the real content is "gitdir:
/git/A/.git/worktrees/B".

You should be able to get back to a working state like this:

% cd /git/A/
% mkdir -p .git/worktrees/B
% echo 'ref: refs/heads/g' >.git/worktrees/B/HEAD
% echo ../.. >.git/worktrees/B/commondir
% echo /git/B/.git >.git/worktrees/B/gitdir

% cd /git/B/
% git reset

As far as I know, there isn't any code in Git which would
automatically remove the .git/worktrees/B directory, so it's not clear
how that happened.
