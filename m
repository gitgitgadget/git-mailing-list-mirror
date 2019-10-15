Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E089A1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 08:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfJOIpy (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 04:45:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33587 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfJOIpy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 04:45:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id b9so22789622wrs.0
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 01:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hyD6ypRCuE+816KNbZvgEKQabn8t0qqESX4J+45EVVw=;
        b=iHdP3wV+2CYQlTOxJcOzuSZCuCYO61lQNoJ4Eq3qp181RvtyBmp6XrfDXSJbzBifeg
         8N8C5t4uUKxGqxOIYIoRuW73QrvVQ6plQhTO6JP8C65rPg/E06FlD9Mu0RPp/8YOhqHB
         giN+ckoaT2tYYtW06aA+2uH+aMIjvF9AxQD9QVmoKNmtas2B3PJl8Uanx69b3nOTJeYW
         Ww8juDkR/BASDxQRs4wb0JQTrCBK1j+ba4tZdrkrsDikS9d3rzMXeFyjSHCEzbh7Mbdv
         JQcqqCR9j4emNJA8ZzSrdeesbN78XKtrxJqUlE4Fjrxs8xS50MyGpEuTBrPlgp8inKaY
         1FRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hyD6ypRCuE+816KNbZvgEKQabn8t0qqESX4J+45EVVw=;
        b=MygJiU72WeyI46P74wCdxVMp8JMbOE8BUicv5D8/xvwuEOHTkAuSDW5xh/K99lv939
         MHN/avt3RdYNK+ZU0uGrAyxVUN1mJgw2nhcf5xg/Vy2mNz8oLjQcpBkfmO5Q8IC+TrIk
         5k8oEZWksPSyHEjDKAOFEQuDSUj6lBC2hZkdwY5aW8vDQOkTB0ITGhhiFO/Nmq4C1u20
         H4/9lieXSqxMGwPl1ImW1EYH5gCmBYXrv9cr0A+Mf15i0wMCC5C+3OcvXZqThfW9VZbt
         iqFFYX2bbqezE6kpbjI7xRKOsTl76DrcOmjjmtjFQmFV2CHyIdqNkDv1klW/SX/YiQxJ
         hSEw==
X-Gm-Message-State: APjAAAVq8FXV1fsHNQSQEke76i6sZx78AoSs2uJQfu+0umSbUxK5unNM
        R4nO/+Qoo/gDPsxKkzCV8kY=
X-Google-Smtp-Source: APXvYqz06pqNVMgkmRvpfBa5KAxFhhqD98XvmC0ReBP0kVFhJlPcfGwU0B3NHtkzrLS8JVz/RMIKNg==
X-Received: by 2002:a5d:4701:: with SMTP id y1mr2835103wrq.385.1571129152365;
        Tue, 15 Oct 2019 01:45:52 -0700 (PDT)
Received: from szeder.dev (x4db42b5d.dyn.telefonica.de. [77.180.43.93])
        by smtp.gmail.com with ESMTPSA id j26sm36811092wrd.2.2019.10.15.01.45.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 01:45:51 -0700 (PDT)
Date:   Tue, 15 Oct 2019 10:45:49 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitster@pobox.com, wambui.karugax@gmail.com, git@vger.kernel.org
Subject: Re: [Outreachy] [PATCH] blame: Convert pickaxe_blame defined
 constants to enums
Message-ID: <20191015084549.GU29845@szeder.dev>
References: <xmqqk19ag60g.fsf@gitster-ct.c.googlers.com>
 <20191014182754.82302-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191014182754.82302-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 14, 2019 at 11:27:54AM -0700, Jonathan Tan wrote:
> > Jonathan Tan <jonathantanmy@google.com> writes:
> > 
> > >> > Also, I have a slight preference for putting "= 02" on the BLAME_COPY
> > >> > line but that is not necessary.
> > >> 
> > >> That is absolutely necessary; it is not like "we do not care what
> > >> exact value _COPY gets; it can be any value as long as it is _MOVE
> > >> plus 1", as these are used in set of bits (and again, I do not think
> > >> it is such a brilliant idea to use enum for such a purpose).
> > >
> > > Good point.
> > 
> > Doesn't that also show that enums are not quite a good fit for set
> > of bits (i.e. 1<<n)?
> 
> Well, I agree that it could be better, but with the C language as we
> have it now, I still slightly prefer an enum to a list of #define. Both
> ways, we still have to manually enter values for each flag, but with
> enum, we get better debugger display (at least in gdb) and in the
> function declaration and definition, we can put a specific type (instead
> of "unsigned" or "int").

And then with any halfway decent editor (i.e. with ctags support) we
can jump to the definition of that enum, see all the constants and
read the comments.  A proper IDE might even display all that as a
tooltip when hovering over.

> gdb supports the notion that a few people use
> enums this way too, but if we decide as a project to not use enums in
> this way, that's fine too.

In a curious coincidence, today we celebrate the 12th anniversary of
Git starting using an enum as a set of bitflags.  Yay! :)

> For what it's worth, I tried doing a search
> online, but most of the results I got was for C# (where it is
> recommended - they have a "[Flags]" attribute for enums), so maybe I am
> indeed in the minority.

I looked around among the various sources I have lying around, and
found enums used as a set of bitflags in libgit2, linux, gcc, glibc,
curl, vim, dash (but not Bash :).


Anyway.  Using an enum for a set of related bitflags has some very
practical benefits.  OTOH, I'm still not sure what its drawbacks are,
especially what those drawbacks are that outweight the benefits.

