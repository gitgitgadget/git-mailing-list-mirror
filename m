Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FDAD206FB
	for <e@80x24.org>; Fri,  8 Jul 2016 22:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756290AbcGHWna (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 18:43:30 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:33830 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbcGHWn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 18:43:28 -0400
Received: by mail-io0-f179.google.com with SMTP id i186so54193331iof.1
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 15:43:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MxTbLLjWXVKdnMjoSrc+PC9npZtQT8SrSBVxnILKzMU=;
        b=M6cPMlHrjeqdjM8vHtb4krmfKOHQaniDrlVLHRD+AD7rPlM9iYnxKpOXVk/alcOf6g
         J/yuO9a6NHbLCA53U6dpnzgKCYBmZ/A690Qli4mfrysmw+DnjcXFzKE7G3bpSKrfolGe
         Wr+xbSCnD62N5IXSW1mfSfc6PACYnPqrtCibrOlzgdt7RWq+M66qTiLtvqQeIqPGTJkV
         cDdIAthgUs8AQV3YojhVDxYryAE73sxmDqnIsVxw7HKR1XXUQ1CbM/C8cz+q6LD/Oxhr
         rRwBmAzr2TLkazYybbzwU6ccrLdl7oJ/Gs4xA6BLfp/3vaQiselswdpSbIjoi/y9fO5K
         ZuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MxTbLLjWXVKdnMjoSrc+PC9npZtQT8SrSBVxnILKzMU=;
        b=Z8pw2yEsLYRWPz37j1KWH0TE84ZTOq/rA7Q5EjTkrTi1BRUOtU5MAGgcnsAIJFehVh
         CTYyUTCajTJORLbQV1MrHuWQ9uTEOdo22K97+59W4JiRqvTmH4TrLSIe6b14z+HPg6H1
         ed/eKTiYRKgo8O+mKua2OBGkP8B/2ZPcTAKl4+YdxJ0Vdrq27IZ5CUch/Rz+ZIJWtFxu
         EEIaSWiGQuFbpgDsT1dEB/IMxwIXznUSgpFYJdH81RUXR4cWHmsga6pPX4fmG0O6f/Bh
         u7/zzGLlh6/Og43ip3Yr/z4XmEILe7KhGNFFVMU0EheDxLStylpGVxGi/qpoEYSSqBHZ
         bmUA==
X-Gm-Message-State: ALyK8tLime62iPX0YnqyXSB9jqb680xyt50LYvlw1KHXTL1j+KWbJzc/RS5ppGwMtVdFZu7ogDbmC7WiUKPFiTO1
X-Received: by 10.107.186.196 with SMTP id k187mr11127861iof.173.1468017807733;
 Fri, 08 Jul 2016 15:43:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Fri, 8 Jul 2016 15:43:27 -0700 (PDT)
In-Reply-To: <20160708223533.GA11056@sigill.intra.peff.net>
References: <xmqqa8htp4kc.fsf@gitster.mtv.corp.google.com> <CAGZ79kbkv5P0wP2kKt9gzmZBe1DjLSB8JpZD66DT_Xd4NKqmKQ@mail.gmail.com>
 <xmqqh9c1nlvm.fsf@gitster.mtv.corp.google.com> <20160708175821.GA29326@google.com>
 <xmqqshvkkm86.fsf@gitster.mtv.corp.google.com> <CAGZ79ka8eHOx28Ja+S6DOGEOrV_ijUvi_NnjprhuzQ+3O9BAoQ@mail.gmail.com>
 <20160708214637.GB9820@sigill.intra.peff.net> <CAGZ79kZOdcJwd0ePMquhfJTv=xZGP_+w4BRV=GyTy3ejb79yrQ@mail.gmail.com>
 <20160708222127.GA10756@sigill.intra.peff.net> <CAGZ79kbu1ec-8LiFrvnXqFqsjFnEofhjZnxcENa1aA1K56m9Fg@mail.gmail.com>
 <20160708223533.GA11056@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 8 Jul 2016 15:43:27 -0700
Message-ID: <CAGZ79kbj8tGb9BsTo_CGqOdfsinJrafHAY5HhQEQDCtAXQqKgw@mail.gmail.com>
Subject: Re: [PATCH 2/4] receive-pack: implement advertising and receiving
 push options
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Wong <e@80x24.org>, Dan Wang <dwwang@google.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 8, 2016 at 3:35 PM, Jeff King <peff@peff.net> wrote:
>
> Yes. I haven't been following the intermediate discussion and patches,
> but I don't see anything wrong with the general design above. I think
> you do need to use rp_error() to get the die message to the client for
> non-ssh cases, though (that is a problem with other protocol-error
> messages, too; I wonder if we should install a custom die handler, or
> convert them all to some kind of rp_die()).

Some of the rp_error messages do not want to die(), but most seem to
be ok when the rp_error would die.

I'll look into that.

>
> -Peff
