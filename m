Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3B411F404
	for <e@80x24.org>; Thu, 22 Feb 2018 20:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbeBVUCr (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 15:02:47 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44767 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbeBVUCq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 15:02:46 -0500
Received: by mail-wr0-f196.google.com with SMTP id v65so11797459wrc.11
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 12:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=74Y+xDZrwuqvJ9pkf6cdgQ3cDwf7S2EfozGeDFgtBuc=;
        b=Am4m5Uh6jLlK3zm4YAvupcQouxDG1B4tFmoMjt0yseXY4IM0p72N2320v7a1ydiG/x
         iLre4AvGca9A9hWtRW2hyGN0M99VBWv2l5oVhQyetJuJrsZCJgtMPzxQUY8yeHx0eE7/
         ALN9p4MrpPnHbj228gbL/Er7AzZ9oD0i1LD5AV4TP5/pKP4Y2As3YS/m9GC7qU8xjvn6
         zquwFnakLuAmUQ2GwkXS6BX7lSMPGBWpwZb+ienUkT4Mq8Zmg0VxLcPo8Al5jh/gkyRR
         cdxUMUqqWs/5IBG2Byr5o72gVLGKnfARL2VyuQZ1MJfY2LIh/Mf/2BRmJiAprWYOZ8Ed
         tNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=74Y+xDZrwuqvJ9pkf6cdgQ3cDwf7S2EfozGeDFgtBuc=;
        b=T0lBJRH6eJN8w1dvqhcGECov9bFOZvajZ6b3YMon+mYHxQjY9pQynSuaHn6FZVIuXL
         IcRwfJcrXirsb8dohkkJOSZ/wtyiUkwbnOi2cLJirTh0nG6nFivBq2AfOhJy53Ztf7Fa
         wIo3u2NG4+3E7P3SUj8CUydbRnx/Hy1rinrU13FcuMuTSJ1CnNTA30JGhpt/4NU2Ty9P
         QKFh/4tQe7TQzi5lgoXD72UzHMAF+xAZbNOhstoeVCfls1kXXuso0W9OMWu/GDN/sO/j
         8yzSUdUk/LrKzuOajYYPKtLbyqvAgjUSrZZjYplKwN8v6Hu5vvyfQdy1luoUD5EpbrCP
         B2mQ==
X-Gm-Message-State: APf1xPCmvs4gGA8MEsxAwzt1oGCTIQ1L+PWmzdY650MIxB/jt6dmgnT7
        qB2L/6r2Bs/12aM0SJPsYFo=
X-Google-Smtp-Source: AH8x225s/7SUdmXS4KODYID4AuwGIlDZsHZOdPP7EWguCxQN6beg5kFd4ro+buZKkN6FGmWhRavqtw==
X-Received: by 10.223.153.230 with SMTP id y93mr7124302wrb.215.1519329765138;
        Thu, 22 Feb 2018 12:02:45 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 69sm226588wmw.32.2018.02.22.12.02.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 12:02:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Dorian Taylor <dorian.taylor.lists@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>
Subject: Re: bug in HTTP protocol spec
References: <4F85B1C3-9B5B-4D7C-8907-B728C18A70CD@gmail.com>
        <20180221221516.GA7944@sigill.intra.peff.net>
        <89E9DF80-F811-4F7A-AA35-0F52F1180BAF@gmail.com>
        <20180222053722.GB133592@aiede.svl.corp.google.com>
        <614A9A36-9DE3-4A85-BFA8-8380C4AC21B8@gmail.com>
        <20180222100840.GD12442@sigill.intra.peff.net>
Date:   Thu, 22 Feb 2018 12:02:44 -0800
In-Reply-To: <20180222100840.GD12442@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 22 Feb 2018 05:08:40 -0500")
Message-ID: <xmqqbmggx063.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This indentation is funny. But I suspect it is because your whole patch
> seems to have been whitespace-damaged (see the section on gmail in
> "git help git-format-patch").

I saw somewhere "Apple-Mail" and a phrase "repaste".  So perhaps
copy&paste on the client is involved in the whitespace damage (of
course the original could be broken, but I somehow doubt it).

>> The client may send Extra Parameters (see
>> Documentation/technical/pack-protocol.txt) as a colon-separated string
>> -in the Git-Protocol HTTP header.
>> +in the Git-Protocol HTTP header. Note as well that there is *no* newline
>> +after the `0000`.
>
> I guess I'm not opposed to calling that out, but this is normal for
> pktline (the flush packet has no data; in the other lines the newline is
> not a syntactic part of the pktline stream, but is actually data
> contained inside each of those pktlines).

For what it's worth, I am slightly negative on this addition.  It
makes it inconsistent if we only mention it about _this_ flush and
not any other flush.  It even gets in the way of learning the
protocol by new people reading it, by giving an impression that
somehow LF is outside and in between packet line.

Thanks.


