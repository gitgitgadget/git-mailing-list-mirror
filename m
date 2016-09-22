Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CECA1F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 20:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934636AbcIVUy2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 16:54:28 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:34941 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933377AbcIVUy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 16:54:27 -0400
Received: by mail-it0-f52.google.com with SMTP id r192so169184102ita.0
        for <git@vger.kernel.org>; Thu, 22 Sep 2016 13:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E+XGKrX9Bf/sz5rSXH27NBVIp0iA/6iR+F68q4ARPao=;
        b=Qqj0OK8aBoz56Y9W6gSz12zUpXrMS/BCrwAWEpYLjRB/kGbmEPeFQ5J0iyGQnKJhaM
         5joMOV7jKUh+8h5i6g/RqRByXl+ox1zbzc3Qujb2Ww43eilWr79n4JqgrzW15ShX7GxM
         SSUxsxk4J72uuNa7BFlWK/fEHyGVLYwENU8ZrbEBmc/bzghqyafP+Cm958Wh8cL569ZU
         bUN4lSrLhkOWd2c1pG81wj+dImtbfMLzGNTGVnY5/UHiDiSmKSYl0IqM3vPMtbNScoQr
         qnL1rvqABxCcHf+XXXLjVSKIGrXE54v0GexEcQhp3eKT8bc7mybScZm+NpPkhzs2045t
         dXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E+XGKrX9Bf/sz5rSXH27NBVIp0iA/6iR+F68q4ARPao=;
        b=eCgrP3WknquI+zJ1vdXRbDleqe/FqZPzJdpbMrIAAa7rjdtx89/bEFrBxrlfA1veWu
         zSR6wL2Ybe96pp5hcezl4Df5L16WHJgidgJeapph/EYr5iiT6t1J6SDVIRYUD4V1w5qy
         8ZQPOIMHrudaDH4gPnxjsTkGEEichT4yjBQgY1GQ5KlbFqGmU3VsjY3GlX1EBhngpLeO
         us7PEBGAJiorNayRi7qojwYv/0HfdQkUiEDVFM4xrlsrO4dlD73O/hgEK7hm7VSUjYa9
         NC4fAn8WMLlNoFDKR8+sthxBoJNX/HTvBDuLa6yPU9cC6/Z6tNgKtsD3esL5bvnpwj9t
         E4JA==
X-Gm-Message-State: AE9vXwOWYWAYDYdzkwICaaGmuWsWgEmXHBt9QUSwb/nnlJ1sUI9azh8fBP/P9MTV44sDfrM4PDTzuk95KZ3SXV2R
X-Received: by 10.36.211.197 with SMTP id n188mr5005310itg.65.1474577666293;
 Thu, 22 Sep 2016 13:54:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Thu, 22 Sep 2016 13:54:25 -0700 (PDT)
In-Reply-To: <20160922194848.GB6641@ikke.info>
References: <1mtveu4.19lvgi1c0hmhaM%lists@haller-berlin.de>
 <ns1bln$2ej$1@blaine.gmane.org> <20160922194848.GB6641@ikke.info>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 22 Sep 2016 13:54:25 -0700
Message-ID: <CAGZ79kYoFH0dbQwvL_2JOtd8aybH8MKCtzy+p_88+QykVTGUtg@mail.gmail.com>
Subject: Re: Limitiations of git rebase --preserve-merges --interactive
To:     Kevin Daudt <me@ikke.info>, lists@haller-berlin.de
Cc:     Anatoly Borodin <anatoly.borodin@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2016 at 12:48 PM, Kevin Daudt <me@ikke.info> wrote:
> On Thu, Sep 22, 2016 at 07:33:11PM +0000, Anatoly Borodin wrote:
>> Hi Stefan,
>>
>> this section was added to the manual in the commit
>> cddb42d2c58a9de9b2b5ef68817778e7afaace3e by "Jonathan Nieder"
>> <jrnieder@gmail.com> 6 years ago. Maybe he remembers better?
>>
>
> Just to make it clear, this section explicitly talks about 'bugs' with
> preserve-merges and interactive rebase.  Without the --preserve-merges
> option, those operations works as expected.
>
> The reason, as that section explains, is that it's not possible to store
> the merge structure in the flat todo list. I assume this means git
> internally remembers where the merge commit was, and then restores it
> while rebasing.
>
> Changing the order, or dropping commits might then give unexpected
> results.
>

The commit message may help as well:

    rebase -i -p: document shortcomings

    The rebase --preserve-merges facility presents a list of commits
    in its instruction sheet and uses a separate table to keep
    track of their parents.  Unfortunately, in practice this means
    that with -p after most attempts to rearrange patches, some
    commits have the "wrong" parent and the resulting history is
    rarely what the caller expected.

    Yes, it would be nice to fix that.  But first, add a warning to the
    manual to help the uninitiated understand what is going on.
