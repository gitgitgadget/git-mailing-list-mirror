Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DF9C1F859
	for <e@80x24.org>; Tue,  9 Aug 2016 17:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbcHIR0P (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 13:26:15 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:38095 "EHLO
	mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932235AbcHIR0O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 13:26:14 -0400
Received: by mail-it0-f49.google.com with SMTP id x130so20867149ite.1
        for <git@vger.kernel.org>; Tue, 09 Aug 2016 10:26:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=va7lJwJOiUmkMRa7JbY1TXXWuSv9bGPoku/PqfA+a6Y=;
        b=mc8jlSw4tqL77Ar345gxBRIVj5WAmyqLNJqvSQA6rgbkZqeW7hRMoH0hkTpV2wgfjD
         lLpfOiBiqnh7qU8wUvgCCTx8shQZ5oAxZv7QHInA3zRdUZLDeLUbXFhovVNVuntp39pQ
         VjtS4rpf9r2myCu7RMnwLXz6X9cwN/EdaCKAnMzJgQusPNUlpwat3FnG3iNlOlOoXc7Z
         z/q1UTnQazER5QRRl17BDCqBCl2hykr5XrF4rtTBLpHmnDdqWU6xXFReTzv/UqH2g4Fe
         sqDcAY5ofqD0EUeejSJHlXFptMvyvCP29RTlCEmYKi+G1XibGOTdV4JwqugY2mF55UXu
         2S9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=va7lJwJOiUmkMRa7JbY1TXXWuSv9bGPoku/PqfA+a6Y=;
        b=EnDneEuTtu9kC1JFFZWtnktb9Zvbj7Mh1/BvBAMl4RckePr30ptyKj4NRLvrosZ5m6
         nIgZV/E6p3KhFaAuXnF0ODt6dIXEWXOd1+kkL9ilH5euQ7exnRSzj0V+aWI+GHRFhY1A
         YsYytAsoufMJ3Ot2fDUDRAMxYcAgUw/cr3i77XBEpdW4rP4VemncmpK4DPcSqgQhGjr4
         gudbi4dtzKxTBCu5nwAi7pvSuA9IVUyapczvmUpJTCR/M9e7FUY6pfxJM34ZSJGbt6WU
         diCWEQCT8xjj0VRPwmwrzcprGLefWKfk19F0It7qqhOIaozrZ7kvnJos3w7ApRUxgClP
         poTA==
X-Gm-Message-State: AEkoouudFyl6pgWa0tQgTDm6iBd/G/otJkw/mkNIRUOEB5ANvBX6+OCyfW1JEVgNqmeNS4IY+YUFrZSOfNqtnwdr
X-Received: by 10.36.217.9 with SMTP id p9mr245545itg.46.1470763573015; Tue,
 09 Aug 2016 10:26:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 9 Aug 2016 10:26:12 -0700 (PDT)
In-Reply-To: <xmqqk2fqc583.fsf@gitster.mtv.corp.google.com>
References: <20160809040811.21408-1-sbeller@google.com> <xmqqk2fqc583.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 9 Aug 2016 10:26:12 -0700
Message-ID: <CAGZ79kZKTV5PCAR41O1t1c_y6N18u6gsoWozOfr=EPHic-7wYw@mail.gmail.com>
Subject: Re: [PATCHv2 0/6] git clone: Marry --recursive and --reference
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, mst@redhat.com
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 9, 2016 at 8:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> v3:
>>
>> Thanks to Junios critial questions regarding the design, I took a step back
>> to look at the bigger picture.
>>
>> --super-reference sounds confusing. (what is the super referring to?)
>> So drop that approach.
>>
>> Instead we'll compute where the reference might be in the superproject scope
>> and ask the submodule clone operation to consider an optional reference.
>> If the referenced alternate is not there, we'll just warn about it and
>> carry on.
>
> I like the general direction, but I hope that the warning comes only
> when the user said "--reference" on the command line (i.e. "you
> asked me to use reference, but for this submodule I couldn't find a
> usable one").

No it comes all the time now, as there is no difference between
"clone --recursive" and later running "submodule update" manually.

Assume a new submodule is added and you forget to update your
main alternate all your other clones are borrowing from. If there is
no warning you create a real clone for the new submodule all the time,
which is what you wanted to avoid in the first place?

>  If the implementation allows the same mechanism to
> help later "submodule init && submodule update" borrow from the
> submodule repositories of the superproject the current superproject
> borrows from (i.e. no explicit "--reference" on the command line
> when doing init/update), I would think the case that needs warning
> is "you didn't explicitly ask me to borrow objects, but I found one
> we could, so I did it anyway without being asked", and it is not a
> warning-worthy condition if we didn't find a cloned submodule in the
> repository our superproject borrows from.

"you did ask me to use alternates once and for all when setting up the
superproject: now for this added submodule I don't find the alternate;
That is strange?"

Thanks,
Stefan
