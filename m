Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C76502021E
	for <e@80x24.org>; Sat, 12 Nov 2016 18:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966720AbcKLStD (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Nov 2016 13:49:03 -0500
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34928 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966565AbcKLStC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2016 13:49:02 -0500
Received: by mail-yw0-f193.google.com with SMTP id b66so3284875ywh.2
        for <git@vger.kernel.org>; Sat, 12 Nov 2016 10:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UKV8MJxOpY1JlEdZ0QDRaUS6lK3WDQhbg/Dej1gH+dA=;
        b=jiggQ2EX7j90OIrj1Dj6Qa7c/BB8kpX8onVYVguZMVS3P8m959qI6ggy648al2qRmv
         w/rVLVrN7e/qbsT8kEljkytSzIXXlkjKfRuMt5lQsV/FS8GDln8UCTynRCzTNnbY91FM
         Bli/+puA/z72Bwqa2+KjboZjYVxi71uqmehvP6goupjqlLyUW3dUX9mhuaqoNefyH7lY
         hdYXyghiqnv6Kw1my1jn0wLJVC0JGJZ6iIkHKRyHJJ3hsNjYHOjpSayIpb36jr0D55F+
         NA4ITocAXK7lK+jYrR3Jz4QYGPonC/ZS+fcUJM7Xjb43QGTKzC2xKDFApnB2+KMYH676
         X9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UKV8MJxOpY1JlEdZ0QDRaUS6lK3WDQhbg/Dej1gH+dA=;
        b=cEwEKXi/fBUCAVpnwziml0dCmhPmbNNsQtiX6HeZh8bOVy3ziguOgf/FLbQ/e2XOPv
         uumk4OGhg/mjd74BekGclorA8SFUPCG+ZwH7+6xYv4lS4FdGZYhFcNsbU79kqBvoEvrj
         ZTD6V47v41eCGceKFK8QDPdWh9Xp7+e1U+XENocu1Jf6jqIIvu73bRfJcG7ahP9BiwFC
         VCiL9Mi4HjDiXMl4AQ1Pd88kyCDMCMSlF51k1t/9bbNGQ61eziAE8Wrm8EbvSCrC7bao
         bPkZO5uHROR0YCRSeUOOY2+rtVsqoAqI+hL5ymBUw/WtdEvdou6x9r73M2+UJHTpLgdr
         qR0g==
X-Gm-Message-State: ABUngvebIF+LTQ6r5GzEkJqUnG150bOfjs03V+vy/+toqBS7T2+DJ5SzdZDVbcuC/EIfUR42TgzAWS1bGld5Lw==
X-Received: by 10.129.78.84 with SMTP id c81mr3661839ywb.346.1478976541306;
 Sat, 12 Nov 2016 10:49:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Sat, 12 Nov 2016 10:48:30 -0800 (PST)
In-Reply-To: <CA+P7+xoKxGiNJO4g=Nm+KY=5=u8g2edoLOoe5K0ZAPrvoGj-Ug@mail.gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-8-Karthik.188@gmail.com>
 <CA+P7+xoKxGiNJO4g=Nm+KY=5=u8g2edoLOoe5K0ZAPrvoGj-Ug@mail.gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Sun, 13 Nov 2016 00:18:30 +0530
Message-ID: <CAOLa=ZQJ9jTN7G5ZgLqs0ZzcPouQcf_4xateTaM=2=Ckbo4mGA@mail.gmail.com>
Subject: Re: [PATCH v7 07/17] ref-filter: make %(upstream:track) prints
 "[gone]" for invalid upstreams
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 9, 2016 at 5:07 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> Make changes to t/t6300-for-each-ref.sh and
>> Documentation/git-for-each-ref.txt to reflect this change.
>>
>
> This will change behavior if people were expecting it to remain
> silent, but I think this could be considered a bug.
>

Didn't get you.

>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>> Helped-by : Jacob Keller <jacob.keller@gmail.com>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  Documentation/git-for-each-ref.txt | 3 ++-
>>  ref-filter.c                       | 4 +++-
>>  t/t6300-for-each-ref.sh            | 2 +-
>>  3 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>> index 92184c4..fd365eb 100644
>> --- a/Documentation/git-for-each-ref.txt
>> +++ b/Documentation/git-for-each-ref.txt
>> @@ -119,7 +119,8 @@ upstream::
>>         "[ahead N, behind M]" and `:trackshort` to show the terse
>>         version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
>>         or "=" (in sync).  Has no effect if the ref does not have
>> -       tracking information associated with it.
>> +       tracking information associated with it. `:track` also prints
>> +       "[gone]" whenever unknown upstream ref is encountered.
>>
>
> I think this is poorly worded. If I understand, "has no effect if the
> ref does not have tracking information" so in that case we still print
> nothing, right? but otherwise we print [gone] only when the upstream
> ref no longer actually exists locally? I wonder if there is a better
> wording for this? I don't have one. Any suggestions to avoid confusing
> these two cases?
>

Dropping this, since its taken care of in the next patch.

-- 
Regards,
Karthik Nayak
