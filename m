Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC5B620A17
	for <e@80x24.org>; Thu, 19 Jan 2017 23:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753283AbdASXqC (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 18:46:02 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35213 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753217AbdASXqC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 18:46:02 -0500
Received: by mail-lf0-f67.google.com with SMTP id v186so6921480lfa.2
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 15:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KXDgIdNMHK99DZ9XYlr9eJrrVvIcU5m93WsxZXXRb5Y=;
        b=XVkcnQpPP1HTkakplq36fjB50263FAS5wY13/PZxvWTDDPMCFxn2eFip+G8w8S7EN+
         2m6TO508nv8zkDlJM24wR0tEc3dlYnZL3VC8cFFBsOxKLkp78bEFJNEWriACr5Bio/1g
         iHtnBWWHTPVnOeFpuiHhC08j9WXIkX1f3HuIAgjP1DsoD+6cNplO5Yh7291DX0jh3Ja0
         CQD9+FxPn/6itlbw4AbnoT0ai61RiKhIABishWZgGXdG8CUSaGteqYEQ+3FR7LNGr49j
         4Co93f/hlmCN8nWMPpljjCgHp2HQW2fK17ybtKosIQNjOiP6z5rFmtvVA5x/FbY1knIQ
         M/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KXDgIdNMHK99DZ9XYlr9eJrrVvIcU5m93WsxZXXRb5Y=;
        b=t3BBbWiJkL3zWprDdA9fqOfgEJdwLj23IaEN2kqpLnxWTt1FDqhYsYNecxGyIEXsgw
         /ugAOCsrbHIBUU1uEmDiK7BmQZQo74hDjVIZKKQMMN6ynoxm1JP1tCO8Wf0dpiVs13ru
         daGfqnPsvsxybKz8kWOmShWXya4bhtd8SnlbBMErZJDnlGdr/oT9YQlKte8YuE3yk4MX
         3Q8UJcQjaRlpJ8nvZUpetvMnCu1djhyf0nTWsrxmHNB1vV8UF5DU9WJdTU3S/5gl7FRk
         TwkYSzevEwnDZRrPU4GK8jl2pCH0PzVcDjwIa296GhehJoYCPvBiwZwlqwCiHbucLQSA
         WqXg==
X-Gm-Message-State: AIkVDXIuDF7i8ZJSID5Mn2NrauWQTfrvGV/4GPXmb9ByFHF2OTG44qE+oKJcticwzrf4r2DEIUgU8wC6gee/Zw==
X-Received: by 10.46.77.17 with SMTP id a17mr5597697ljb.2.1484869560229; Thu,
 19 Jan 2017 15:46:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Thu, 19 Jan 2017 15:45:39 -0800 (PST)
In-Reply-To: <xmqqfukezrmh.fsf@gitster.mtv.corp.google.com>
References: <20170118230608.28030-1-jacob.e.keller@intel.com>
 <20170118230608.28030-3-jacob.e.keller@intel.com> <xmqqfukezrmh.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 19 Jan 2017 15:45:39 -0800
Message-ID: <CA+P7+xp20UPrwZBU9hC45yKLOjp0Jm0r4exAvzL=tuXCV8KwUA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] name-rev: extend --refs to accept multiple patterns
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2017 at 1:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Teach git name-rev to take multiple --refs stored as a string list of
>> patterns. The list of patterns will be matched inclusively, and each ref
>> only needs to match one pattern to be included. A ref will only be
>> excluded if it does not match any of the given patterns. Additionally,
>> if any of the patterns would allow abbreviation, then we will abbreviate
>> the ref, even if another pattern is more strict and would not have
>> allowed abbreviation on its own.
>>
>> Add tests and documentation for this change. The tests expected output
>> is dynamically generated, but this is in order to avoid hard-coding
>> a commit object id in the test results (as the expected output is to
>> simply leave the commit object unnamed).
>
> Makes sense.
>
> I do not see anything that requires "... generated, but" there,
> though, as if it is a bad thing to do to prepare expected output
> dynamically.  I'd just reword "generated.  This is..." to make it
> neutral.

To clarify my earlier comment, I think the SQUASH?? you queued looks great.

Thanks,
Jake
