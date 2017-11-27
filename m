Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97A5820954
	for <e@80x24.org>; Mon, 27 Nov 2017 10:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751725AbdK0KMS (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 05:12:18 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35690 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbdK0KMR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 05:12:17 -0500
Received: by mail-oi0-f65.google.com with SMTP id e142so18995330oih.2
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 02:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XeiQ+J6vZv0fLP/Nv0TN6xB3Ok90YxNed+bBQ4Wyrls=;
        b=AJ2xj+ZngNkOdS6RHmg4xLfiLsR08P/2V8DRHBq8V/sK2ax+IgoUvX1uAmUB6Z6Zyj
         tryaQFMuEesAzN3Fvoz+1lIiZ3CoVB7D9YqDOAGCxpMrWA0QLqt7hCmggALSq6RZWAhD
         IaEYg/la+desLOhR2YUNef9UqPMVwgvQVudItOeq6VbP+GvQOg9jQBTMNkgUh1kigaHQ
         GNY4xs97Vf0A4NZi95yL1uhd6b/CghEUeaRaLqJkq555ZkuiCag21R2UpsCjFMOEvzQ6
         iR11b1mreuR6Y5WTxSQFyNtIWFH6JiFlbr7+hhYkuWw0mqyZIEwR2R8cV96Hl2GSVcDd
         0W6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XeiQ+J6vZv0fLP/Nv0TN6xB3Ok90YxNed+bBQ4Wyrls=;
        b=VhXXGLtc5pOhlMViwiDpEmpPMEsTQNqjmEyzR5QwPZROKcTJ6R7W7sycmk2dkLCkg7
         EtcCg/pX++6htJVfGvK31KLXfNqNwAHIkdYWMum+OAAQu3cWJMCliEvuEJSDSPjOMaIs
         oLgjRnPWhz55JQgTvatJxIHAZCmee5VVKDNaHpGrWTaK/w47QfwSX52tUmocxCG8P7Fh
         TA85P11RUWJ0+s/5gjlApCh2rmRiliuz9UNwSflreyK/oaHIx2IIMban9msS5b6032s6
         07ObX3XJf2POXp+V6UWqAgQmYZhnfqmn9Zc9cx76cBaLF9zuEzKYFLc0+S9QFEBMRdtg
         fj0g==
X-Gm-Message-State: AJaThX4OK/FN4UrjyeKq1o4v9bCVJD8pqs3YO1BrJ5bRQumZLOqqdInm
        pAHz1COTZ/CSVesQHr13hH6CoIYCw1szrSADWQE=
X-Google-Smtp-Source: AGs4zMZfhDAMYzSCYGFlYOCYSZ/IbHVwl9OVLSyOpDDmPm5/mEqjqL/ESeejR00TUpM3o2gZ9AcrN1NYjUNJ9RVLgbA=
X-Received: by 10.202.244.212 with SMTP id s203mr15827245oih.145.1511777536821;
 Mon, 27 Nov 2017 02:12:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.1.137 with HTTP; Mon, 27 Nov 2017 02:12:16 -0800 (PST)
In-Reply-To: <xmqq8tesflne.fsf@gitster.mtv.corp.google.com>
References: <xmqqvai5lf4a.fsf@gitster.mtv.corp.google.com> <20171126201119.24313-1-gennady.kupava@gmail.com>
 <20171126201119.24313-2-gennady.kupava@gmail.com> <xmqqpo84fre1.fsf@gitster.mtv.corp.google.com>
 <xmqqlgisfquy.fsf@gitster.mtv.corp.google.com> <xmqq8tesflne.fsf@gitster.mtv.corp.google.com>
From:   Gennady Kupava <gennady.kupava@gmail.com>
Date:   Mon, 27 Nov 2017 10:12:16 +0000
Message-ID: <CAPu-DQpKRvU05pgfFpdguAfMKJnHpshsajivTCtNa56GtToUtg@mail.gmail.com>
Subject: Re: [PATCH 2/2] trace: improve performance while category is disabled
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Gennady Kupava <gkupava@bloomberg.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Spotted yet another.  This function in a header file, that is
included by many source files, must be made "static inline" (which I
already did as without the fix I couldn't get 'pu' to compile).

Thanks, missed that, seems my compiler inlined all calls and I didn't
notice the problem.


On 27 November 2017 at 03:25, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Just in case others notice style and whitespace issues, I've applied
>> the following to fix them, so there is no need to reroll only to fix
>> these.
>> ...
>> -inline int trace_pass_fl(struct trace_key *key) {
>> +inline int trace_pass_fl(struct trace_key *key)
>> +{
>>       return key->fd || !key->initialized;
>>  }
>
> Spotted yet another.  This function in a header file, that is
> included by many source files, must be made "static inline" (which I
> already did as without the fix I couldn't get 'pu' to compile).
>
>
>
