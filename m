Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CE681FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 17:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbdFMRG0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 13:06:26 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33371 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751805AbdFMRGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 13:06:25 -0400
Received: by mail-pf0-f194.google.com with SMTP id w12so12621522pfk.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 10:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UULtmL4CPFvgApGvGK1RXMO/8ZA3i0Tk2JgFoZPvGSM=;
        b=IFhDcA7xRddN45DFsGfrIgD9iOPdyPN8rXcs+yLC7EmI/rUmTu8XnNKace30bQwShq
         YSmfsZ+9nVcSHAXrgx3QJiWESJxhdpfLO55O2rdcXRavsmg2gQDLdiCYqBIoLnuK6PFj
         D3oUeIZx4gmVqEBe6tCCoA9xep5M3hbjVjNMLpanu459X0NkhIrQ1h3NQQRtI/0ru4lv
         fh2KorKeAn2KVB3j6Gmy9OXkWI4gxT38Tq4noUh9BsHqWKmueX/fIo0CdwHV6QFKpOgR
         D6rn1vRyI62UQTM7u4yFG8wlDUQFKlsdxf377vK9npRRM/qyOPra8iNnOkjLti9Blo4E
         fAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UULtmL4CPFvgApGvGK1RXMO/8ZA3i0Tk2JgFoZPvGSM=;
        b=fsnS/T6Gk58plqhQ2P6Vu8EPZ7eGA7pdrFdD/OGOgfrv6kwDWBBZR3vcxoqYwPR7c5
         ln1glgZEqvOJqGAPR8z7jT+jb6zW0QgVOyg+gQEygpDn3kM43XtMAJZWg0X1qT0Xmzao
         I6pfBfO4/8qev/dyHJ6Dfy6E3yBfH0Eq4AxHBZ8Scf5IIEa5vEGMphZW8V5f+8boFtlr
         SKP5eP2K5iU94GcVaZnIPAkcr0aOI1jW3WFo3muiRAdi0DNLeDu5RosmAkBlHxMCpCW7
         OScNoUkERZpINZZ9sUuj8fH+q0v4GeZ4T9wo9ZaJMWs2T/Ax+Lxv4YCHrOgCIsSQ9Lsr
         NqLQ==
X-Gm-Message-State: AKS2vOykOg1cZ4EQfEuX8uuXZ8+RPCI/gDY3paaz7o6k5qdhwGjKQ+FN
        2N3KovROz0CyzHmj0Tg=
X-Received: by 10.84.238.201 with SMTP id l9mr707090pln.153.1497373585147;
        Tue, 13 Jun 2017 10:06:25 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:e453:89d5:deb:c7b6])
        by smtp.gmail.com with ESMTPSA id u194sm27177963pgc.2.2017.06.13.10.06.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 10:06:24 -0700 (PDT)
Date:   Tue, 13 Jun 2017 10:06:21 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 4/4] config: don't implicitly use gitdir
Message-ID: <20170613170621.GG133952@aiede.mtv.corp.google.com>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170612213406.83247-5-bmwill@google.com>
 <20170613010518.GB133952@aiede.mtv.corp.google.com>
 <20170613012337.GH154599@google.com>
 <20170613013817.GE133952@aiede.mtv.corp.google.com>
 <20170613025945.v54vrza2n23tk5pw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170613025945.v54vrza2n23tk5pw@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, Jun 12, 2017 at 06:38:17PM -0700, Jonathan Nieder wrote:
>> Brandon Williams wrote:
>>> On 06/12, Jonathan Nieder wrote:

>>>> Alternatively, could this patch rename git_config_with_options?  That
>>>> way any other patch in flight that calls git_config_with_options would
>>>> conflict with this patch, giving us an opportunity to make sure it
>>>> also sets git_dir.  As another nice side benefit it would make it easy
>>>> for someone reading the patch to verify it didn't miss any callers.
>> [...]
>>> And I don't know if I agree with renaming a function just to rename it.
>>
>> I forgot to say: another way to accomplish the same thing can be to
>> reorder the function's arguments.  The relevant thing is to make code
>> that calls the function without being aware of the new requirements
>> fail to compile.
>
> If the parameter is now required, then it might make sense for it to
> become an actual function parameter instead of being stuffed into the
> config_options struct. That would give you your breaking change, plus
> make it more obvious to the reader that it is not optional.

I like it.  I also like that in your proposed patch the no longer
necessary local git_dir goes away.

What's the next step?  The discussion of get_git_common_dir() reveals
that switching from git_path() to mkpathdup() loses the
adjust_git_path() step and everything becomes complicated.  So perhaps
adding opts.git_common_dir and using that instead of git_path should
happen as a preliminary patch, making this patch afterward a more
straightforward refactoring.

Thanks,
Jonathan
