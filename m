Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B958E1F859
	for <e@80x24.org>; Fri, 19 Aug 2016 23:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754947AbcHSX1N (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 19:27:13 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36294 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755551AbcHSX1M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 19:27:12 -0400
Received: by mail-yw0-f195.google.com with SMTP id u134so1378153ywg.3
        for <git@vger.kernel.org>; Fri, 19 Aug 2016 16:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eKF+KVggXdyjctzJrErUXjst3szR6dpgDEMpNzrY4mg=;
        b=rFJlRjRX0M2ZadEqK0K3ZQEalfgDVGDsY4R9D8+8GHhsAeTH41fGH5uMXsH0fz/GMo
         B4sPzFgo7hIfwGs0OhHjOTNI/kvO9Jc5Mz/vFjRv87w3xd4htiQQdrLzLRxrr02LmBkH
         ph+kJvvtx6plxMOx0gxxC9gFl58Pn12DrDX/dnNpuiSEWduYpiZXjOuIXK2hu4qtkv+s
         SNex1PQn5aBZVlvvN+B4ff0ZjfhbhJHGXNLSzOmDWzkH/oq8uxglKWZVK5+LPgrupaAQ
         +oMlZATPm9jChGCR2tE6slwAYA3tOhu24B/FnWzL07VGKjgwFK+PgYiQPsWKADzwNwls
         szJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eKF+KVggXdyjctzJrErUXjst3szR6dpgDEMpNzrY4mg=;
        b=SdgcovHhQKFpB1pWm6NGQEnBwaOydecIoKQ+hTbdzuWQfy1jgsSWsupmqYVW9bGBym
         r4V9BFe5PhYO7OfROos78fuaqp8OPO2uShoOO3roMS2gf5SQN9y8Oto4cM0FM0bGApue
         zzaM9i3atUu/C4nW7SFEUId5IsQvRygu8sx5A8l+T+gEpnbExlZ7lOz40Lxmq04wIZrX
         96FY9iqtxTmRP2KU8VEP+Fct5NwMLSOGkLRLyGY85YUN2tJaSUDelw2zc4wQ4c8GryWd
         jqJBqGGIYFjHstoKFvNTyTUfGQ91OAqQrc4JrxNLrNAv517Nc+v0Z4QbNrVgmF6OD7DV
         vDkg==
X-Gm-Message-State: AEkooutHKbU5MeHuduBSoH11UvGmB3ZoqovqnuryYvyXDKkwb4m2WTOrDaH4roxch9oxkWTwr8hMfL7urIsVMg==
X-Received: by 10.129.46.136 with SMTP id u130mr8911773ywu.234.1471649145348;
 Fri, 19 Aug 2016 16:25:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Fri, 19 Aug 2016 16:25:21 -0700 (PDT)
In-Reply-To: <xmqqinuwz97k.fsf@gitster.mtv.corp.google.com>
References: <20160819000031.24854-1-jacob.e.keller@intel.com>
 <20160819000031.24854-5-jacob.e.keller@intel.com> <xmqqvayw1q1z.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xrFkCbLyvXKt1PKYsdFH2rCmjdMEyB27sDEScvGhxs7XA@mail.gmail.com>
 <xmqqy43szcom.fsf@gitster.mtv.corp.google.com> <CA+P7+xoy+dNY_LVZC4auavHZtPg-tKs_iwaBJF6kgYv_u+ubEA@mail.gmail.com>
 <xmqqinuwz97k.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 19 Aug 2016 16:25:21 -0700
Message-ID: <CA+P7+xpbtoZNGOpEJa-6P2VYmi5K2Ahn3mj7y4LiaY2e0AWHbQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/8] submodule: allow add_submodule_odb to work even if
 path is not checked out
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2016 at 3:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> Is there a way to do this lookup? I couldn't find it.
>
> Perhaps submodule_from_path(), that is used to implement "git
> submodule--helper name $path"?

Yep, thanks. I also added a test to show that the use of name works.

Regards,
Jake
