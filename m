Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E3A1206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 17:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934145AbcLLRS6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 12:18:58 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33188 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753929AbcLLRS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 12:18:56 -0500
Received: by mail-yw0-f194.google.com with SMTP id s68so8293959ywg.0
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 09:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QWAWVVeXj881sh+Nt02GynZZMnbGin4sU7SWh7y8GnU=;
        b=NZe8VamrK2eDk3fvLamv3AXGnySXnJ9BMBfFv0Ds+3KxMgBDMty4g9xJRCtxZg4P5e
         yFY9MGM5M9SUl8TJTZVcTyq+RkjMgIVtOFPsnJD8/4nocLSGSo0Hmc7a05wKBuEGgloe
         8OcpttPup93KMjn9WLnz7RUWqtH5qBritCHX5UyCwtmQLgGiI55rs3G/bK8G1UuXnIRm
         Aopor+d5zXA+bAU35Tc0KMnzW8zLKDEW3Pis/+bN4xAdd9IUp8XdGZjzE9Ud7PnV0t63
         L7ip9UP9iSfgguEjstR3KZ8NdNavt3K+dZ5FbuBbU3L4DrcKk4qH8IQfVgO2ZjLpRh30
         Ptkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QWAWVVeXj881sh+Nt02GynZZMnbGin4sU7SWh7y8GnU=;
        b=jgc087K1m1yRmbfyZpiDFSSif4fWUuXm1KUMdrTfAIAWQdw4UKEkGDbTybaAsGEA7I
         XyOqhNB8W9n5G/rTuoUk0AsR5hbx8DoqqB61pWojQZ4bdWgOAaUXAV7bBV/N/8NKiMXA
         UEUihC999kqlqV4TeGfPpnOYAjWtxNxHbsGn27e6ay/wWBl9KyNFI3BXKOYwWJhT5Bo9
         n06bMZ2X1TViuAXva+aBpKbQzRpit7hQRTxcG07B8O9ss+4lmqBVMRgSBgR6YCQr2hti
         Jcdph9avTV0LkC8ml4UU2vpelp4b6v5IbKzCXhILCNhFQrg1HphSAwNnlmIZLOyDfQMn
         xO0w==
X-Gm-Message-State: AKaTC024rc04+/iD6/uGIiUXLYwnWoAuwTREYNCO6+2eyxp+C7jv4rrBbH7IdboTez+M92HB6UbJUbSNrfvsjQ==
X-Received: by 10.129.62.24 with SMTP id l24mr88572315ywa.346.1481563135127;
 Mon, 12 Dec 2016 09:18:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.19.214 with HTTP; Mon, 12 Dec 2016 09:18:24 -0800 (PST)
In-Reply-To: <20161212164020.btrrg2f62haxt7sh@sigill.intra.peff.net>
References: <20161207153627.1468-1-Karthik.188@gmail.com> <20161207153627.1468-19-Karthik.188@gmail.com>
 <20161209140345.76ybodldmg2lxgbn@sigill.intra.peff.net> <CAOLa=ZSPDLwziGEvyixebAkS2M1JMYidQNHfDbnmYarFCjn80A@mail.gmail.com>
 <20161212121548.aj2ptnmrqt67anlc@sigill.intra.peff.net> <CAOLa=ZT1KN_iw7JzB78hPb-LrY_yaDZk0D+TqY2W9hCOftzumA@mail.gmail.com>
 <20161212164020.btrrg2f62haxt7sh@sigill.intra.peff.net>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Mon, 12 Dec 2016 22:48:24 +0530
Message-ID: <CAOLa=ZQQfi3W3z1_QcvxkW_4oM=PDx3MZupFehMyxs4YQvTb2w@mail.gmail.com>
Subject: Re: [PATCH v8 18/19] branch: use ref-filter printing APIs
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2016 at 10:10 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Dec 12, 2016 at 09:59:49PM +0530, Karthik Nayak wrote:
>
>> >> > This caller never stores the return value, and it ends up leaking. So I
>> >> > wonder if you wanted "static struct strbuf" in the first place (and that
>> >> > would explain the strbuf_reset() in your function).
>> >>
>> >> Ah! Yes this should be 'static struct strbuf' indeed, I blindly copied Junio's
>> >> suggestion.
>> >>
>> >> strbuf_detach() is also a better way to go.
>> >
>> > One of the other, though. If it's static, then you _don't_ want to
>> > detach.
>> >
>>
>> Wait. Why not? since it gets added to the strbuf's within
>> build_format() and that
>> value is not needed again, why do we need to re-allocate? we can use the same
>> variable again (i.e by keeping it as static).
>>
>> I'm sorry, but I didn't get why these two should be mutually exclusive?
>
> What is the memory ownership convention for the return value from the
> function?
>
> If the caller should own the memory, then you want to do this:
>
>   char *foo(...)
>   {
>         struct strbuf buf = STRBUF_INIT;
>         ... fill up buf ...
>         return strbuf_detach(&buf, NULL);
>   }
>
> The "detach" disconnects the memory from the strbuf (which is going out
> of scope anyway), and the only pointer left to it is in the caller. It's
> important to use "detach" here and not just return the pointer, because
> that ensures that the returned value is always allocated memory (and
> never strbuf_slopbuf).
>
> If the caller should not own the memory, then the function retains
> ownership. And you want something like this:
>
>   char *foo(...)
>   {
>         static struct strbuf buf = STRBUF_INIT;
>         strbuf_reset(&buf);
>         ... fill up buf ...
>         return buf.buf;
>   }
>
> The same buffer is reused over and over. The "reset" call clears any
> leftover bits from the last invocation, and you must _not_ call
> strbuf_detach() in the return, as it disconnects the memory from the
> strbuf (and so next time you'd end up allocating again, and each return
> value becomes a memory leak).

Ah! perfect, makes perfect sense. Sorry you had to spell that out for me.
'strbuf_detach() in the return, as it disconnects the memory from the strbuf'
that was what I was missing, thanks.

-- 
Regards,
Karthik Nayak
