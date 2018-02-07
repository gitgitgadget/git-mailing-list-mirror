Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C62401F576
	for <e@80x24.org>; Wed,  7 Feb 2018 07:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753424AbeBGH0d (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 02:26:33 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38965 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752682AbeBGH0c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 02:26:32 -0500
Received: by mail-wm0-f41.google.com with SMTP id b21so1240775wme.4
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 23:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XdfIi0UmKkNxcrmkcGnfmebDHWN/efYS9AOzADnuawE=;
        b=E15qRo6K2Pd64qyclFIUDt1uF4ci8NY7/ahtsSHOiGfv2Hk2M8dADn7gABTy/FS9lJ
         iNCrT3SuaJ7lhaemE8N42HKdu2w4gGY6j6QjLQ8JFzV0oRiuCK3hYkmZQSt7S5wdfjb/
         CB2lpwwg1GFwICtl51gicOeE2SzToYyR5xGWJMaRsZA2f8mez9RbJf6o/QCSVhTlFb4o
         ysPEgj6aLBci/tvAcD8wjDKjbeqelVVEcXIqHzAhdKhiaFYUh62BQnsEpcLZ6CIUZwdU
         jUpsrEo0g6CewXmGsvfGvsd8Z9MBqTTW0FhDNIaPDs75IW/J4shejlusq9CA2+LUd+RC
         h9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XdfIi0UmKkNxcrmkcGnfmebDHWN/efYS9AOzADnuawE=;
        b=U79pIsFecywUIEe++afrWKJdhd/EyqonA67q19kskrJXBvanckUvjJ5QoSvq1SCXV+
         CmposoIjBrzQS+ae3HTYvaf++tMqKg7hensxjZ9ZGxc+tlDipdQp0U30cisUcqPDAlQk
         iybRcpUwkXz04BPLVMKD1QpGJK/atXzfTgUp+YC411+yFwfp3DEGkuJJwafxB9NACiXD
         9QyWnYeJtlU1AZnfLub7cHTLI0MpOw0MMrsNlnspTcKbAgAHzZWGDwrVf16jEQg5ZV0Q
         MpTJJyBV7BVRgaX0Jf/ZkHF6EqpL1OyeTm5ALMpGxOBxr3sGzB9Ab0SM1iuYyZlauqYR
         u7mA==
X-Gm-Message-State: APf1xPAJ09Fmay3muycJZ4GZ/f2NffuxBlw7BStq+ScrTWzb7+72Q1xj
        NBxev/QO0zrhXV/ZAQbMyx9iFhfWlgNQCm+t3AM=
X-Google-Smtp-Source: AH8x2265jvfsukefgkx+21rYWR2vFib8AObxxYK+tcvARaeyDficrwowYmXHhYzqhkrJu4N/moBRtIeIXFQp83QdO2c=
X-Received: by 10.80.184.77 with SMTP id k13mr7178466ede.187.1517988391688;
 Tue, 06 Feb 2018 23:26:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.177.180 with HTTP; Tue, 6 Feb 2018 23:26:11 -0800 (PST)
In-Reply-To: <87k1vpqq85.fsf@javad.com>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
 <87k1vpqq85.fsf@javad.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 6 Feb 2018 23:26:11 -0800
Message-ID: <CA+P7+xqs=cEC+9LJ9VB4XZU-oS7CX6eQSNSGfPeg-whRCwU1Lg@mail.gmail.com>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 6, 2018 at 10:16 PM, Sergey Organov <sorganov@gmail.com> wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
> [...]
>
>> +--recreate-merges::
>> +     Recreate merge commits instead of flattening the history by replaying
>> +     merges. Merge conflict resolutions or manual amendments to merge
>> +     commits are not preserved.
>
> I wonder why you guys still hold on replaying "merge-the-operation"
> instead of replaying "merge-the-result"? The latter, the merge commit
> itself, no matter how exactly it was created in the first place, is the
> most valuable thing git keeps about the merge, and you silently drop it
> entirely! OTOH, git keeps almost no information about
> "merge-the-operation", so it's virtually impossible to reliably replay
> the operation automatically, and yet you try to.
>

I'm not sure I follow what you mean here?

You mean that you'd want this to actually attempt to re-create the
original merge including conflict resolutions by taking the contents
of the result?

How do you handle if that result has conflicts? What UX do you present
to the user to handle such conflicts? I don't think the normal 3-way
conflicts would even be possible in this case?

Thanks,
Jake

> IMHO that was severe mistake in the original --preserve-merges, and you
> bring with you to this new --recreate-merges... It's sad. Even more sad
> as solution is already known for years:
>
>     bc00341838a8faddcd101da9e746902994eef38a
>     Author: Johannes Sixt <j6t@kdbg.org>
>     Date:   Sun Jun 16 15:50:42 2013 +0200
>
>         rebase -p --first-parent: redo merge by cherry-picking first-parent change
>
> and it works like a charm.
>
> -- Sergey
>
