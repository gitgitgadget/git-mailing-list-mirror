Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAB98200B9
	for <e@80x24.org>; Tue,  8 May 2018 16:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755464AbeEHQjO (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 12:39:14 -0400
Received: from mail-yb0-f178.google.com ([209.85.213.178]:38595 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755434AbeEHQjN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 12:39:13 -0400
Received: by mail-yb0-f178.google.com with SMTP id w14-v6so11362175ybm.5
        for <git@vger.kernel.org>; Tue, 08 May 2018 09:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ppdYPdVN1+23KaUSPxVVByQCra0DcuZYM7Lyxvmrr08=;
        b=pmhiYtz0VhfkGUKNq9YlbKCqYbG1J4JOeIMjU3Z+ulOEGobz7iJMlO0ALbDihjkXH3
         lP8ZwwC+wpI3UhOzcZEFg3QaLKkmX0l1SLqdrlWzAt1hgLRiQHdZehClNGGsxtDgotPA
         rEwc2lyf7/SRZEkN8P7aWj9GCquUIzx3Gdgqkca779a5o6/YyRT3HGjmHapkdEPI5ZOi
         t06s7Mz0sxTjq0h8a+25lfYoSKFQ/gRntZO0Xd+onHYXfEB1+CTquRmlqyzu61mOGy0H
         BhyA+3xb2LNeHifnj/w11r3Ko/SCOvt6quUK0etOqmDaFWpS8+JJn9Wfk0sZ+ncR97WE
         /LCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ppdYPdVN1+23KaUSPxVVByQCra0DcuZYM7Lyxvmrr08=;
        b=ij8flVZLx82Iv/G3kgn8uz9kxEnpZrD6fjP9jbIdcdPHXB6Q9SnnDGKmXizZ3LgjQZ
         pAPQcMqCMdkre5Ptj5ELwWomsBdYShKL78b1U5nJkKF3PJPXWlSXnVOCpXeJfxEdF+2s
         5ya00tg/hGRSdm97IiE4FJ1wTGlP0Zku3VeZ2zT1QT3qy1NhVDKIE0hy1vJiQ34wYXhw
         fWE5R6e6ofc52oQXXEeqQ634+Zmwb5hygJG/NKzMDyWhS/WCDKcWokX/9DJJhp/YA8rb
         Po/6sRgnEE7NKfFCqCieuaejFIgVUhrf8zchPnGL1gABpAn/BCaD5ot04/Pk+XXvN7Ou
         9Ycw==
X-Gm-Message-State: ALQs6tDsYsCrjtYKQcgOV0pFqcdmE4gL4keZjC8etUx1LPUK+Om+msuy
        J4LG/1g2F3QezyDvwyqBgwiofo/NAlT8SU+qbH7fIQ==
X-Google-Smtp-Source: AB8JxZrGAOwx2JgvXDuCaNH8rX6/erKfFoCxVZR3jWZdy1mYgADglY+oVQAu247AcEe34/oFPJWdOnhBitaiyYtmXGo=
X-Received: by 2002:a25:500e:: with SMTP id e14-v6mr25347318ybb.334.1525797552856;
 Tue, 08 May 2018 09:39:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Tue, 8 May 2018 09:39:12 -0700 (PDT)
In-Reply-To: <CACsJy8BGs7EOYFKayL-bgvEbKOJiROF52o3SneLyG9Nm6nUngA@mail.gmail.com>
References: <20180417181300.23683-1-pclouds@gmail.com> <CAPig+cRkUrdtbyGEsY=DQCDoEWTrC-9n4=vKXHEap2gokB2uQg@mail.gmail.com>
 <CACsJy8BGs7EOYFKayL-bgvEbKOJiROF52o3SneLyG9Nm6nUngA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 8 May 2018 09:39:12 -0700
Message-ID: <CAGZ79kb1VEkB4aw9ukx1LsOUX7=HzFcC=2=LwU4ipFEH60ALag@mail.gmail.com>
Subject: Re: [PATCH/RFC] completion: complete all possible -no-<options>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 8, 2018 at 8:24 AM, Duy Nguyen <pclouds@gmail.com> wrote:

> I'm arguing about this because I want to see your reaction, because
> I'm thinking of doing the very same thing for config completion. Right
> now "git config <tab>" gives you two pages of all available config
> variables. I'm thinking that we "git config <tab>" just shows the
> groups, e.g.
>
>> ~/w/git $ git config
> add.              interactive.
> advice.           log.
> alias.            mailmap.
> am.               man.
>
> Only when you do "git config log.<tab>" that it shows you log.*

How cool is that? I'd love it.
