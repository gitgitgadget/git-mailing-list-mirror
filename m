Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D62011F404
	for <e@80x24.org>; Fri, 23 Feb 2018 22:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752341AbeBWWuV (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 17:50:21 -0500
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34714 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751907AbeBWWuU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 17:50:20 -0500
Received: by mail-yb0-f194.google.com with SMTP id e3-v6so3452159ybk.1
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 14:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qs1u6ydBxwciHeovJ2NLcBDwuP93n/ANcK5wHy4f8s0=;
        b=BL9Bxwlal5uk3Js4vJXqLFiNKEH2K4aaoWPrS381lvAbEP5ubeTTGl49Rf471dGzOb
         r7is14kteg3OwoCmA++cCrIR6v2tgGigNiGklmQPqnw778e1/yVERyDnXoM4C9R4xOVg
         jHxz4jwRyj+FcN83oUIQSOJaQ2QruWzQSIZ15kYnBCbTiaXbpJkk1t/FSMpi7CH5FfZn
         L2pQAQJMOm9B5RboENQpK0Dg4tabnpYQ8JaXqLAAv8Oqn98WCW2irRtmx54nKB8Bm4NU
         AJ47uJ/35uZMexf6giZBIFlo1P+eSN/RF2aUSF0b8b1eWatl4+cPJy3ni6eqA1pziErN
         fLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qs1u6ydBxwciHeovJ2NLcBDwuP93n/ANcK5wHy4f8s0=;
        b=F3wN+j/TvI5L6SBdhJcOiGs402mQJO4d+yVZ9lrrD5R8Hqk5C6qGP3WwQjLyu9mwDR
         0Ib6kdjcuz9P3/EIrcmf5EguTqEVxlzGrigHXEZOR30ixhfywJpYxriqn65W7TBRPYeh
         sN5EzBLWmDWODofTu4pgxFSzkty2EDCS93r+S942ho5dY8PxnXqXH8fqkOTduyMIqFbx
         DtGCSquCEr2dNycaAtxn+FfLV2KBAxt47xYHTiUvPYuyEWgxOpSJKe4QNlvZAuYgJ5lz
         VtLWbz7T67iKhgGaDKM6p/Rk9PPSP63DkolcQDOHQdivSO2NtwMC0jk+TMnLF9s/sGBk
         4lIA==
X-Gm-Message-State: APf1xPC16yhuji33QXAcBpuhaNDbNVkBcZMD4IrxYIWO6V2qm7FUPfbE
        Vd2hW9XSJ8AlywxpJCrgeFuASxUP/Q7oMnVZqlql2w==
X-Google-Smtp-Source: AG47ELtiisjlo3lyOAP/psiM7owBErZVpxoHPIKKAw3DMtV83cK6SnLjnan14vT+U/NGPYLPWnSxTGIk6LEioXAnWyA=
X-Received: by 2002:a25:9185:: with SMTP id w5-v6mr2301821ybl.352.1519426219956;
 Fri, 23 Feb 2018 14:50:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Fri, 23 Feb 2018 14:50:19
 -0800 (PST)
In-Reply-To: <20180221164406.c98170765e454b51de80c680@google.com>
References: <20180216174626.24677-1-sbeller@google.com> <20180221015430.96054-1-sbeller@google.com>
 <20180221015430.96054-23-sbeller@google.com> <20180221164406.c98170765e454b51de80c680@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 23 Feb 2018 14:50:19 -0800
Message-ID: <CAGZ79kaSTz+CjpZ8cijRcK_npWnh1TK9btzgWAXPHUDYKx--cQ@mail.gmail.com>
Subject: Re: [PATCH 22/27] sha1_file: allow sha1_file_name to handle arbitrary repositories
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 21, 2018 at 4:44 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Tue, 20 Feb 2018 17:54:25 -0800
> Stefan Beller <sbeller@google.com> wrote:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
>
>> -void sha1_file_name_the_repository(struct strbuf *buf, const unsigned char *sha1)
>> +void sha1_file_name(struct repository *r, struct strbuf *buf, const unsigned char *sha1)
>>  {
>> -     strbuf_addstr(buf, get_object_directory());
>> +     strbuf_addstr(buf, r->objects.objectdir);
>>       strbuf_addch(buf, '/');
>>       fill_sha1_path(buf, sha1);
>>  }
>
> In the future, we should probably have:
>  - a function to get the object store out of a repo (so that it can
>    lazily initialize the object store struct if necessary)
>  - when the object store is obtained, its objectdir field is guaranteed
>    to be populated
>  - sha1_file_name should take the object store struct, not the repo
>    struct

We had that in v2, but I reverted it as the consensus seemed that we prefer
the_repository to be passed around.

>
> but this is outside the scope of this patch.
