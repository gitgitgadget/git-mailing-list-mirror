Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20D211FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 21:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750808AbdALVCV (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 16:02:21 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:33295 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbdALVCV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 16:02:21 -0500
Received: by mail-it0-f67.google.com with SMTP id v14so3128902itb.0
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 13:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=03hNswqHU5bMO8lVdmfy3ntXi9+PyyEnlgMr10eNU8M=;
        b=Mu66zB1NlFC2A2mk1TWoA2JeT4e87fo/BAOHMrwdoez2ILY6QlREh20LpuivttDSYT
         lol4UE7HS6yC6ks7g/eiwGQjoseIb1ag1PP/I5gTVzSCZdNzgJFUFc+WtMGU6N42WF13
         actyNfM9eyiIi8IlmI59Odol7gU6jXv5wdujdiOXSvsFtl/ixQkDg6MLglu/O9d+JwWh
         Jyt9StE6f8lUFgsqktyHEZnR30ig7DhLlVDr/Pwq/HbMXRKyFM40AwV7/24FfVlKE7sW
         VAgGAbmTS5T3AtZt7PzRqhrghbfy//z2hJXuS6Uw1V2lq3qPXPU39i16PCveO1WZ0Jf2
         Wi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=03hNswqHU5bMO8lVdmfy3ntXi9+PyyEnlgMr10eNU8M=;
        b=GF0AqDNc9z+pLskpIzNBYCGl2JocnP8JvWv9Eg4HnJzLj02e8embnZiHa8MqazfTkL
         7y4NEMCOeO07vJyAaCcBdhZknfFUWpC9HixjWG49c8diIhueki3MpXCR57gBH/3pcGXN
         8mvHw3C7kG9PU9YGt1rUAHwk8RToUI6f7T0YInvoslBF5YMtziTDqJhi77P4p/yDvQ6E
         7mX348fwuaGbu/uEmh3fgBr9fayosbZl4C/zAot99k9J0QS4VWSxztTGZspgRval8Sp+
         DpGwwlktRTPGEA0fVmYuLeluKW6dFyMryWI0xSURjcUvj240+fkO8L2+jcw+wR6vNwX0
         wQ8A==
X-Gm-Message-State: AIkVDXJJZHfhfo9EzfIDQzGx1UtBD1NhbNkLPC8kOHHWv2cqX6WLFFu/bwW+F46bs9fYGxBxCnz4NOI+a9DpIA==
X-Received: by 10.36.74.197 with SMTP id k188mr75253itb.1.1484254940264; Thu,
 12 Jan 2017 13:02:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.50.131.84 with HTTP; Thu, 12 Jan 2017 13:01:59 -0800 (PST)
In-Reply-To: <xmqqbmvcj9le.fsf@gitster.mtv.corp.google.com>
References: <20170112055140.29877-1-pat.pannuto@gmail.com> <20170112055140.29877-3-pat.pannuto@gmail.com>
 <6fe462dd-929a-671b-a210-36ee38e99115@kdbg.org> <CAAnLKaGbf9-GAF19+61=7_RfCOBM0=Ounwf8KkL1jS6HX3pOag@mail.gmail.com>
 <alpine.DEB.2.20.1701121118170.3469@virtualbox> <xmqqbmvcj9le.fsf@gitster.mtv.corp.google.com>
From:   Pat Pannuto <pat.pannuto@gmail.com>
Date:   Thu, 12 Jan 2017 16:01:59 -0500
Message-ID: <CAAnLKaGvz4Wzs36gMSdoYCg+tzx6KFCe59FNnk5zNQ-L58ww1g@mail.gmail.com>
Subject: Re: [PATCH 2/2] Use 'env' to find perl instead of fixed path
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm happy to let this drop.

I've filed the missing perl library as a homebrew issue [1], so
hopefully this won't be an issue for folks in the future.

You may still want the 1/2 patch in this series, just to make things
internally consistent with "-w" vs "use warnings;" inside git's perl
scripts.

-Pat

[1] https://github.com/Homebrew/homebrew-core/issues/8783

On Thu, Jan 12, 2017 at 3:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> So if this patch would make it into upstream Git, I would *have* to revert
>> it in Git for Windows, adding to my already considerable maintenance burden.
>
> I do not think we want "#!/usr/bin/env $language" in the upstream,
> either.
>
