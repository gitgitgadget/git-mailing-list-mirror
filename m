Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D686C433EF
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 02:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F396660FF2
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 02:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhJSCt2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 22:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbhJSCt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 22:49:27 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A17C06161C
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 19:47:15 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id h4so8469859uaw.1
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 19:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:message-id:subject:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=z6SPyeGiRQxLMjHsl+dNO6kOgqiqP2ppFQZUHaUOhvc=;
        b=gPgkLhY2Yf6Joq6ecjDpDl7py4Vr2NqFuqyLL+dC3W6HzvYL4lZEKxItLrsjx7wi1d
         Gct0xBbQxBret+ht5zRdGgcwz/ZWIp9uwIzLvBqyz5mQOQg8Nrpa1rxlvu0Tt9hgQpzM
         z6tfzfXJrABZZ/RJrhubxd2PgTO34caE0ta+vT6xEG2aq7A3bZhNn62v/12Q6YgsvTBo
         WmCkTN1rip78m2YSxhtgCfRudVIltDg0VTOkJqUMP4aLQEejTc+0NVYEQpOr66A1Fcc6
         Z0voCvwGr/RzgntZCw71BR45vDZIcYTIo/YVMkE44SqpfSTNM/PUJqCGWCKU84fVyWSa
         xA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:subject:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=z6SPyeGiRQxLMjHsl+dNO6kOgqiqP2ppFQZUHaUOhvc=;
        b=T/zlgxVeVcqo9QipGhzI/qk6HtkWTX6B0yNgmwRV1lyNgghbpwHJlW+dObkyUS449I
         Tt5uzGKjy0/Cn29x1Glk1vII1ftZeGkLR2/YL6YwGLQ0P/eTfUCd2ATrb6wDOEeEutDW
         uVCjkX9AIXniuR4irY9Czex+ME+SrdsDJqcxReVpdEM0bs+mhow5LCp5JPQl3ZOLui/r
         K/emrCBfHIkd4NIdr1/YBf7d+yqTRdGKrU/PkJTpBEps0aMnuyrJ3NfMJo8MegQE047d
         uIhrFK7doASRSvJPC1qZsQzJ5Y4qg283Y/xbeauZbp9lYYaIrRwtgOIZoBuZlYoKeqly
         Kjyw==
X-Gm-Message-State: AOAM531PqzDhHOPKUZBIgrBV8vpN1E9N8fweMbK4rw/9NottF8+rjt5H
        ozsyZ67DfxqA/JaHJlubfuja45EReP8KOg==
X-Google-Smtp-Source: ABdhPJz9vpNEVoqMPKQZlLZQxvyYzvItRDIAIlIfDcwShGaT4CPmxk+GfwCjH+zzKQ6uxZSiHWn6KQ==
X-Received: by 2002:a05:6102:3910:: with SMTP id e16mr32142146vsu.16.1634611635030;
        Mon, 18 Oct 2021 19:47:15 -0700 (PDT)
Received: from [192.168.44.4] ([177.75.142.230])
        by smtp.gmail.com with ESMTPSA id p8sm9953274vke.11.2021.10.18.19.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 19:47:14 -0700 (PDT)
From:   Bruno Moreira-Guedes <brunodout.dev@gmail.com>
X-Google-Original-From: Bruno Moreira-Guedes <brunodOut.dev@gmail.com>
Message-ID: <d7de2654254a8b542deda4b11475bc919b87c3f9.camel@gmail.com>
Subject: Re: Bug - added changes are not shown in the diff view anymore (
 not added
To:     Raphael Biersbach <raphael.biersbach@gmx.net>, git@vger.kernel.org
Date:   Mon, 18 Oct 2021 23:47:12 -0300
In-Reply-To: <7d2751d1-949e-cc90-4063-f9f576c6febf@gmx.net>
References: <7d2751d1-949e-cc90-4063-f9f576c6febf@gmx.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2021-10-18 at 16:40 +0200, Raphael Biersbach wrote:
> 
> Greetings,
> 
> when using gitk I am encountering this bug:
> 
> - added changes are not shown in the diff view anymore ( not added
> changes and commits are fine)

I tried to reproduce through with the version on "master" branch
with the following steps:
1. I have written a new file with some short text
2. I added it to index with `git add`
3. I ran gitk
4. I went to the top point in the graph, "Local changes checked
in to index but not commited"
5. I verified Diff option was checked

I got precisely what I would expect:
   Author:   
   Committer:   
   Parent: 9b803221a51430fc491a4b3536bb8a1088c1af6e (Update
   README.md)
   Branch: 
   Follows: 
   Precedes: 
   
       Local changes checked in to index but not committed
   
   ----------------------- test.txt -----------------------
   new file mode 100644
   index 0000000..9daeafb
   @@ -0,0 +1 @@
   +test

If I did something different from what you have in mind,
could you please add the steps you can do to reproduce the
problem? Also, could you check if the reported behavior
appears on git's latest version (from "master" branch)?

> 
> git version 2.33.0
> 
> running on 5.10.70-1-MANJARO , window manager i3
> 
> 
> Raphael Biersbach


