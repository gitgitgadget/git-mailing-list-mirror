Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50771200B9
	for <e@80x24.org>; Thu,  3 May 2018 17:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbeECRgX (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 13:36:23 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:40420 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbeECRgV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 13:36:21 -0400
Received: by mail-oi0-f51.google.com with SMTP id c203-v6so16832204oib.7
        for <git@vger.kernel.org>; Thu, 03 May 2018 10:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x07816+4VvZLVlDV0+eHG1VxsXEZLuCpdcFHyDLG9yM=;
        b=d2DXUJBoaD4YK8rDNXmo+yO5+f1wLafnZgkEr/uzFV6qqwfV7nXcdbZyb0ZEhiQHXm
         8osDMC+P/D6c7YvKRsxWw3PZ/jm8/+uVB0NiuWa1HD7KbR6IepulEHmdeD+Vq7ENRbBC
         D2mibFoRt5WxJktYmFoFyC5G28l3dXTxo3ifHWV3v8Lnk5JSpPln3agMbWX1yQgJyBXN
         DoHZ6kvN4TjF2Z1eORxgWk1mbP9Q8uS4jXAZ035aPRrWKr7kT7eyJKmVsk8UD7hS+Xbv
         Mjkco6yT/d9g9n2GkULe8YzcHXNTlCW/9ib8qWrIOPc555Oyd1nSQezDi9tNarlizNak
         hLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x07816+4VvZLVlDV0+eHG1VxsXEZLuCpdcFHyDLG9yM=;
        b=Drnn9AcYiRyD+eSgo0IhZEZLdw7V4+L/qti3hJPzRS0udyFn9aAq3WqVc/8t5CShgd
         9GVz7uYuxo0FqVtBc9qmgRaVblpEFsGON4aGjTX3Mnds6ZdKNhcCLCeXZz0X0RWtCqiC
         +vFNu28FcnyUWPRoCI6h13ONn8uciF4eVBNx6euso6M5U/QYJYvMdJ5mYcOquNolfS9J
         8Dm5m37k3RabD5C4iPehDbOBCm9R1zpw27wXLULUtkzq9XWqJFmdHOXoAcHDbfQP6hPw
         EbZcteDlx3rH/GiyK2DmFkh4LhdWZF85reJC3TzX/Jm/H9Jf3x5GNfE5bsSfw8Jkjkn4
         Dwgw==
X-Gm-Message-State: ALQs6tAaATWXI3ciNPZP7EHLbpTqyriMyn6Ofgsd6H39ByX9WOKmoLF7
        5cafSFx+B3H0PvQGC9ZS6SGzAR+l57pPpacVXhiaNQ==
X-Google-Smtp-Source: AB8JxZpNHZ2kkES/8/ZY8aOSX8AcdydIE5ZdED6n8cI6U/rJvlt79xvO8IFjovsyC/l1r92Eg5KfWxUnazJ6/e/Rp+8=
X-Received: by 2002:aca:ce42:: with SMTP id e63-v6mr15875196oig.34.1525368980566;
 Thu, 03 May 2018 10:36:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Thu, 3 May 2018 10:35:50 -0700 (PDT)
In-Reply-To: <CAGZ79kaNNFYyTAH_Kq=bO_Q9tLGMgnnxQKpDZSftuh7deDoFxA@mail.gmail.com>
References: <20180501213403.14643-1-sbeller@google.com> <20180501213403.14643-14-sbeller@google.com>
 <CACsJy8B=i_0EKGRLxS5N5tfz8666hm_aTns949eb9DAW1--XWg@mail.gmail.com> <CAGZ79kaNNFYyTAH_Kq=bO_Q9tLGMgnnxQKpDZSftuh7deDoFxA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 3 May 2018 19:35:50 +0200
Message-ID: <CACsJy8BoiCjz889q0cAjSZ4DvhLbRArqG9+CqQJZxss4vd9sFQ@mail.gmail.com>
Subject: Re: [PATCH 13/13] alloc: allow arbitrary repositories for alloc functions
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jameson Miller <jamill@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 3, 2018 at 7:24 PM, Stefan Beller <sbeller@google.com> wrote:
>>> +void clear_alloc_state(struct alloc_state *s)
>>> +{
>>> +       while (s->slab_nr > 0) {
>>> +               s->slab_nr--;
>>> +               free(s->slabs[s->slab_nr]);
>>
>> I think you're leaking memory here. Commit and tree objects may have
>> more allocations in them (especially trees, but I think we have
>> commit_list in struct commit too). Those need to be freed as well.
>
> I would think that tree and commit memory will be free'd in the
> parsed_objects release function? (TODO: I need to add it over there)

What release function? I know tree->buffer is often released since you
don't want to keep much in memory. But the user should not be required
to release all objects before calling object_parser_clear(). For
struct commit, I'm pretty we make the commit_list (for commit parents)
and never free. Now we need to do it, somewhere.

Oh you mean object_parser_clear() as release function? Yes. I've been
wondering if it makes more sense to go through obj_hash[] and release
objects before free(obj_hash) than doing it here. It's probably better
to do it there since obj_hash[] would contain the very last pointers
to these objects and look like the right place to release resources.

> Thanks,
> Stefan
-- 
Duy
