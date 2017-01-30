Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 881261FF1E
	for <e@80x24.org>; Mon, 30 Jan 2017 22:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753041AbdA3WWB (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 17:22:01 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33926 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751950AbdA3WWA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 17:22:00 -0500
Received: by mail-pf0-f173.google.com with SMTP id e4so93874603pfg.1
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 14:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZlQohXFP4BlI4sKZuguLiR/TtlO7ISNJJqTEJaubVrM=;
        b=eex6vbShxy5+4jpSPxCUcGrAUBKguNpSlHKluh0oFQEiNgG4WnPYY1sp2YdxlMsf62
         wjsbyUvn/Ps+BXy5ZdVWX0odVld1vvaAGLDZ/7KU3pVJncSKFofzPtGJEL93A2mS2zIW
         YzEruSNGgXtptjYSfSK+ZGttu0awbcR+K44gzfluczATLI7Yw3LqBnmrTmdJp8g5aSN3
         sjuFNPu3/4KOs9gWAWjMUL3uiiIhguk4NhaE0nJPQZJOHTebo4FHVM+ZRTa7x7W4o9VH
         l83/3QeBNsLAr41fKDzDIYcVBtMlnbiO3UYK/3+sSI1yj2Sdpsm5BSmXwRuI+UMY0uKI
         Kwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZlQohXFP4BlI4sKZuguLiR/TtlO7ISNJJqTEJaubVrM=;
        b=WwnJYxnKJDOMFDZ1MScCy4TgJ+4MEWxV76qrRXLwdEOnwcuY8umxmDBTTAxHaIdfOk
         5GxCepvL+3suHhi9MaEiUXoVvt+7JjKiUdHQLJZv3/O33O1FZHZG7lsdwbzdYw+3tHC9
         y6XfwJoVPsWBIkHzzhxUAy3Vjzi/LcyrPlqVY+79tRnQgnQJUKPZgDGW0Ogd3AxfLJGT
         1N7WKhBc5ySd0p3Ejmiob0YsPbj5VvljvbCJzD3suhB60rWSLMDlUwT9E6Lgz0SKKt/z
         ZFm8845L83R7MtNw3eNPQoK9JxIz8UmcNNsujMij+nuKCm0wUYGcNXqJqZVJOJ6QG+EW
         nuVg==
X-Gm-Message-State: AIkVDXIPMaeoNbXnXwNEiVjvahcfIgWUoZxkSI9jC9hTcfZPWASuu4fwvkVBbiibXxw84h95
X-Received: by 10.99.227.5 with SMTP id f5mr26667673pgh.102.1485814919868;
        Mon, 30 Jan 2017 14:21:59 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:64a9:79a2:c65f:35e9])
        by smtp.gmail.com with ESMTPSA id v4sm35081617pfb.36.2017.01.30.14.21.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Jan 2017 14:21:58 -0800 (PST)
Date:   Mon, 30 Jan 2017 14:21:57 -0800
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] add SWAP macro
Message-ID: <20170130222157.GC35626@google.com>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
 <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
 <alpine.DEB.2.20.1701301643260.3469@virtualbox>
 <aa653d57-4a97-ac50-b20c-f94ed43a22fb@kdbg.org>
 <alpine.DEB.2.20.1701302158110.3469@virtualbox>
 <77098ac8-1084-a5c4-a5e6-fb382e3dc3a0@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77098ac8-1084-a5c4-a5e6-fb382e3dc3a0@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/30, René Scharfe wrote:
> Am 30.01.2017 um 22:03 schrieb Johannes Schindelin:
> >It is curious, though, that an
> >expression like "sizeof(a++)" would not be rejected.
> 
> Clang normally warns about something like this ("warning: expression
> with side effects has no effect in an unevaluated context
> [-Wunevaluated-expression]"), but not if the code is part of a
> macro.  I don't know if that's intended, but it sure is helpful in
> the case of SWAP.
> 
> >Further, what would SWAP(a++, b) do? Swap a and b, and *then* increment a?
> 
> That might be a valid expectation, but GCC says "error: lvalue
> required as unary '&' operand" and clang puts it "error: cannot take
> the address of an rvalue of type".
> 
> René

Perhaps we could disallow a side-effect operator in the macro.  By
disallow I mean place a comment at the definition to the macro and
hopefully catch something like that in code-review.  We have the same
issue with the `ALLOC_GROW()` macro.

-- 
Brandon Williams
