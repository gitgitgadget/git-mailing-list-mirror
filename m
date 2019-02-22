Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE49F202AA
	for <e@80x24.org>; Fri, 22 Feb 2019 20:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfBVUkm (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 15:40:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36020 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVUkl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 15:40:41 -0500
Received: by mail-wm1-f67.google.com with SMTP id j125so3115984wmj.1
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 12:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wrPWoQMpdTkBUXi2JkpS9+dthJ/ZRfI6XKz9e7af418=;
        b=uuHTY7YVB6BatiibiaMV8jj820JZiMqaSGb9OdLI9E/W0I6K4WGP/m1abp28Oy9Sn/
         uh42Ju0svwtkovxUHuK1T8vLYarkwqEPvKa25RY+cvkaJls22L5hiVlTi6h+YXHu7hn8
         wzFqptIeDo/0sCoV0/Ikkj/1+eXjkmHdRbI2Fjn6kbtGWnEaM4dc+xWF7mMrKlhQfxIX
         cbfdhHYpuTdaWxGQhcjd6uacb0+dXNy8bnwpwLD18I6wn+hDDgB+qGLP9Vg8erWyZNCO
         j34z8GQ/UBgO70ugSO9G8MHukYHxjHaT12xShkHDQsgNTAi2Ak0ocIaRawncK4ZsS88s
         wXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wrPWoQMpdTkBUXi2JkpS9+dthJ/ZRfI6XKz9e7af418=;
        b=QT50OGFp9YmC5FjrFkvClJtdd7xEbvn44GNDvxdBJn6JSOMkKDctZC645kQtDaiVLh
         LGlTqY2lpf8HzHaOJiup6KfqZWt7w/WBFwB/WEJyY6yYwszVEYbu3rPE4pYEBPMcGTAq
         zvcxUQxvE4mk3oPmbVF0sZ3o0mBeaz5tfpqAXeWcTBVeNk/PcENUKp6hXIGsX1mejmCi
         fNk4dFa5OqnDVTI9k6vqrAKxSGyRf/K5cu8rRsxLH+o94uee9ZaZ7OuZt/8GTfja4x16
         7yzAbGmTextpfPJmIMYn6Bw2XDKm79RuUslHasCM4QvokMFBu2JPSn6hqan317lD3dVx
         2z2w==
X-Gm-Message-State: AHQUAua0Tx+ePAH/gA5dcH9B3ZuCxgLviG6uMowMm1GC7NcajZTtMbbO
        NLeIzosqwR/GRT11PgFfu2W5EivL
X-Google-Smtp-Source: AHgI3IagIUYgDfbuDOadmnkKas/YUkGTN48RFAbXCk9y6NlRbJG4YLpUXlr3AWXi6HlaTDx1hqxPvA==
X-Received: by 2002:a1c:a5c8:: with SMTP id o191mr3507350wme.137.1550868039497;
        Fri, 22 Feb 2019 12:40:39 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s127sm3009807wmf.39.2019.02.22.12.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:40:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] builtin/log: downcase the beginning of error messages
References: <20190222201111.98196-1-gitster@pobox.com>
        <20190222201111.98196-2-gitster@pobox.com>
        <CAPig+cRhk-0LBCmUQ4LszJrnmnXCDz7HxWqDnKX53woBYhr-KQ@mail.gmail.com>
Date:   Fri, 22 Feb 2019 12:40:38 -0800
In-Reply-To: <CAPig+cRhk-0LBCmUQ4LszJrnmnXCDz7HxWqDnKX53woBYhr-KQ@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 22 Feb 2019 15:24:15 -0500")
Message-ID: <xmqqmumnpneh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> -                       die(_("Failed to get upstream, if you want to record base commit automatically,\n"
>> +                       die(_("failed to get upstream, if you want to record base commit automatically,\n"
>>                               "please use git branch --set-upstream-to to track a remote branch.\n"
>>                               "Or you could specify base commit by --base=<base-commit-id> manually."));
>
> The capitalized "Or you..." is odd after s/Failed/failed/.

It briefly bothered me, too, but after realizing that this is not
the whole sentence, it no longer looks so bad to me.  The thing is
that "Failed" (or "failed") is *not* what starts the message.  This
one is die(), so what you'd actually see is

	fatal: failed to get upstream, ... to track a remote branch.
	Or you could ...

with "fatal:" prefix.
