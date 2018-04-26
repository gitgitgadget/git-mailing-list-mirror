Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 029A21F424
	for <e@80x24.org>; Thu, 26 Apr 2018 19:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755242AbeDZTja (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 15:39:30 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:37651 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753665AbeDZTj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 15:39:29 -0400
Received: by mail-lf0-f45.google.com with SMTP id b23-v6so32478574lfg.4
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 12:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0GroDy7bjbCDqitJJ2aILzkoW2QkiADUAi0jDx/xmhk=;
        b=XelBN6GK9yzyyNlwEOv67OAPokCIRQ6niXcFXqRnvVd9Dp2cPNYFZvuNFIsJZ034Xm
         hf9n6HImAMqsiOh7QFj73wlr6oSnouft1ZfMlTVpCdpEpxPi9tWi/NVy8yzgguqTHgo/
         Mzc+3e/F3sL1c+JrBrkIlv25t4gfjF5fR6YFmQA0YosAk3PFRBS6rt/PaVE2hMzC6tnK
         vEUBvfTEdMzEOnKpc2I++hJ0Uxsbrd4rlbVGG/Rex3uDxV0VVVKTMNFUWJ7pmHTSxyvp
         6B8XUNMx4YYQLU0y4p9F18BlxvNJ8Uakbyw3PmrfLYlU3N+I0om2twNzOvIGBytf3lsr
         JVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0GroDy7bjbCDqitJJ2aILzkoW2QkiADUAi0jDx/xmhk=;
        b=SF6N0jfvcJmaCep6oqqITKCmI/UoFfL+q6PqVzrfWgr9G37M7j4nPrEMyUHdOV6OMG
         P6vd7C3Dgzx3RcTbpvi0YnGRQWzOT1P3IOTvTVSKWzzFQtbVcLTZUFssyKawl05CyUKT
         BMtlmyTpDwaqi7J8tNTUNonLN7aV7KvDZzCzwkAQJIb6Fsaxn7T/e1uv7ceHOBXZlb9E
         L5AR8vQoLeJFB8GkRmD6WloqZQbw6tX/wGaN6D8/KBaxGxirOBcOsY7Jk3939xR/dtLY
         DtWBpKp6h+W+Xe9GeiAJeSKJtHeV7AJlceWErojY1PV0TDku4rHVAJl5PamzW8IggeEA
         QYcw==
X-Gm-Message-State: ALQs6tDlrNvspxwvbk5cYDxWZClFl+3jMuEJ+n5NfxJF7qxBTVMuAcW+
        KeqGLfUUn7S6QXvRSE53csqJcwnHlqFf6qsFpgZpWg==
X-Google-Smtp-Source: AB8JxZo2KOtMGWSC6F30yx0Z+K1uXJx2qwZNfew11A0iRDInSgqARfYrg8htnshUrsO3HQ1bxessYQbIVMLApsl6zYU=
X-Received: by 10.46.133.65 with SMTP id u1mr3529869ljj.10.1524771567457; Thu,
 26 Apr 2018 12:39:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9690:0:0:0:0:0 with HTTP; Thu, 26 Apr 2018 12:39:06
 -0700 (PDT)
In-Reply-To: <CAKk8isr-7bSVqEv8EjF2UgFfw75D2oVZPJFui30pbY6kWfeL_Q@mail.gmail.com>
References: <CAKk8isrAmWOdioJe2CdY+2F_AzKxcTGwd+kBsrAmGx-U=ZHGgA@mail.gmail.com>
 <xmqqzi1s3y5h.fsf@gitster-ct.c.googlers.com> <CAKk8isr-7bSVqEv8EjF2UgFfw75D2oVZPJFui30pbY6kWfeL_Q@mail.gmail.com>
From:   Wink Saville <wink@saville.com>
Date:   Thu, 26 Apr 2018 12:39:06 -0700
Message-ID: <CAKk8ispWBoG7D+u8x+s+iB+wzXUN=7vpxgmz5wjL67P6XUmw9g@mail.gmail.com>
Subject: Re: Fetching tags overwrites existing tags
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've tried to teach 'git remote add' the --prefix-tags option using the
technique Junio provided. At moment it is PR #486 on github [1]
and I'd love some comments on whether or not this the right direction
for fetching tags and putting them in the branches namespace.

-- Wink

[1] https://github.com/git/git/pull/486
