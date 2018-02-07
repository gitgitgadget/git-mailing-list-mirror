Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 577AD1F576
	for <e@80x24.org>; Wed,  7 Feb 2018 09:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753424AbeBGJyN (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 04:54:13 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:40362 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752758AbeBGJyM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 04:54:12 -0500
Received: by mail-qk0-f193.google.com with SMTP id e20so315203qkm.7
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 01:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=54bSMjx24W/UwrETOLbsXufCb2aQVFalhd4fh+srA0g=;
        b=HZTBEfRIKQy7GolrrGcFEmywVi8/08GhKbUMvwSPzOx8x6ZlqXsz8ZzO1YO2tDpJxy
         vfqKEzLI/RaAcuKnn5qeLX08jKMZKXjvAGnWFlNIFNWFPESGARNxAm2pHGBf0rCNR1Jf
         yMMcripRQx1n7akh8ATJ4acncoUi9ee1GbEVmy3/xicxPJNx3TekfKkUhgYESB0LAE9P
         nzFq9TogDJzzilSfCEpK71YAw1ZKttaEPdNzamww+LA6RZ5gMj5wTm+VuhdI2pRIAdGU
         TtfmNiUybYR15yrnui/cB22Lm0JbIsJRC14li61fXKrsUHwBbQ+uNGmyEbL+tv/eU1LW
         so0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=54bSMjx24W/UwrETOLbsXufCb2aQVFalhd4fh+srA0g=;
        b=Ivejbhxqm4vuZX9a1+8XW8Ck/ieMW2X3nueXyiGcgCUOivdEJuvCDfl6GGYaz2dX+G
         SrOcT2rrOgLA1j4fy3vK314hw5ChVjNUQbNs7H4wzBxK0q+h6LE26A1afAkMCrHB8APD
         eJuvdGFMz/vaXkaZGyTZSbB5Q1TyTr3V11WP0O6VaXJexTUsJNerHiiDkAYpw/ihbyla
         Renap+RVbpXncG4tAdT8UprK3dqFOT66Tfh6xLkAEE/tOShBcydbjAftiYuXPMDb76Ot
         I9es9gc4dGyp39oFea9ZbjtTKRh15sCHh+np7J+bPha6VZzw7iBpKG0lcta0vcd/6DqO
         l9xQ==
X-Gm-Message-State: APf1xPDLeZiscynyNCHJ6Bu6WPL705ZoXgfIYV8S7dXMMmFcTo9MMSn9
        NL+bvv6yVMXUQrSNZjhSc1PHlRF0JyrPHtE74Jo=
X-Google-Smtp-Source: AH8x225++Dzj6DcH8Ics3/VpWdEK2EKelTKNu7HPapvmeM0aok2382qvY6DJHTQwpcwBnAxGlLNUlSzygS8XPIXgGtM=
X-Received: by 10.55.177.135 with SMTP id a129mr8329810qkf.112.1517997251615;
 Wed, 07 Feb 2018 01:54:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Wed, 7 Feb 2018 01:54:11 -0800 (PST)
In-Reply-To: <CAGZ79kYYZ-dmHA5jZeKTk9TFxn+7_zzxLPR7jNS4X8+K-JU_dg@mail.gmail.com>
References: <20180205235508.216277-1-sbeller@google.com> <CAGZ79kYYZ-dmHA5jZeKTk9TFxn+7_zzxLPR7jNS4X8+K-JU_dg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 7 Feb 2018 04:54:11 -0500
X-Google-Sender-Auth: jYshAIalz693HgWDg0oUHHHkfk4
Message-ID: <CAPig+cSFcjV8RfWhaZsy2CqYG0JYfn4u0vKkf_XkUAmC12uONA@mail.gmail.com>
Subject: Re: [RFC PATCH 000/194] Moving global state into the repository object
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 6, 2018 at 3:25 PM, Stefan Beller <sbeller@google.com> wrote:
>> Any suggestions welcome!
>
> Eric repeatedly points out leaking memory.
>
> As of today we do not care about memory leaking as it is cleaned
> up at the end of the program anyway, for example the objects
> hash table is never cleared.

Is this still true/desirable when multiple 'repos' are involved?

> In a resend I will put the infrastructure in place to free the memory via
> adding
>
>   raw_object_store_clear(struct raw_object_store *)
>   object_parser_clear(struct object_parser *)
>   ref_store_clear(struct ref_store *)
>
> and calling these functions on repo destruction. The functions
> itself will be empty code-wise and contain TODO comments listing
> all variables that need care.

I'm confused. If you go to the effort of inserting TODO's why not go
all the way and instead insert the actual code?

> Follow up patches can figure out what is best to do, such as closing
> the memleaks. As repo_clear is not called for the_repository
> we'd even keep the property of relying on fast cleanup by the OS.
