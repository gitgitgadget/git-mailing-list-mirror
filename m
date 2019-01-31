Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 024231F453
	for <e@80x24.org>; Thu, 31 Jan 2019 07:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfAaHoJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 02:44:09 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:33322 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfAaHoI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 02:44:08 -0500
Received: by mail-io1-f68.google.com with SMTP id t24so1869323ioi.0
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 23:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=siFfdnAx0Rn2O1lHpJtPi8vbxfQb4SiRdmtSv9ULars=;
        b=Ip4l4dQioWxpYB0HH65XIWRmxpe7t9+KiB0VvtEcTr4YYY5M5fLqalmC8pwWYcExsv
         lLeYDeJcCNOmjTDza1+YNuvYNVeo5sBj/df++GbDsac1JbpZWlouabTK8UVIPK3lnpq2
         GtmtHCYY13p64K/gGxnEf1HZCzer/ZpZ9aLdz89Stob6MWKvKiq2+cEGqMglIIPfE23G
         cRMx5G0XLAEZ9k6M7KkJcv4MYVTuyprdaJG1YgtL907D1jPxfLOgqsR5z7QubidOyHll
         JIkjtewBDA8pC7//DrnytvSwjp+ZB1ZeC9ufNMF8t/32fP0NyIQ/3qQga9bDb5uAK6zW
         jMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=siFfdnAx0Rn2O1lHpJtPi8vbxfQb4SiRdmtSv9ULars=;
        b=lGbT3leQzF83jcGUbMUFscwdJmEh2o7Rtz+qvkP7P74t4DDLH+AOiFyXkGcdouP1+M
         kmvdXlHxL2G3JZ2H/+pk23J1g3U2PKXsgEg17mghaO9AhB4nSKxg5LBBJaCFoX2DJ4Yd
         MMtc621bnOPf83A6CO0VCZFS17npNaUmnePwCQzafqXd7Tp/HZh7belnF8tJOcICdd8a
         5nzMBkQobkQcApx41dk22bI7Expq6Npkj35hfo+Kef/ef7vcH3gOqXOfmzQBc82ZV5hK
         BVFrtQuZRlONMQ3xZ33nOqRvdGp+wRkQKxC1DBnceCLm7m/SL179p/I+h3fOtzweyq6j
         GKuA==
X-Gm-Message-State: AHQUAuanw9OmuE5ptPmtySN3kq99L7a7DaR/B/b8TqHtoJseA3YXFhvV
        ajNJ8AKxTdvSiG1J3J0HWQJSuy7j2atu/nEWuSq+731c
X-Google-Smtp-Source: AHgI3Ibn6gIh3Uw13/YewfZiK/viWGOWlk/kh9kKA2XAyrk72ShUkKEk4Up66CkrwrI/wPbRxi5jM6GNZv+y6oLBCu4=
X-Received: by 2002:a5d:9456:: with SMTP id x22mr16558998ior.282.1548920648107;
 Wed, 30 Jan 2019 23:44:08 -0800 (PST)
MIME-Version: 1.0
References: <20190130094831.10420-1-pclouds@gmail.com> <20190130094831.10420-9-pclouds@gmail.com>
 <CAPig+cQ3L4NcMojWYV3spazJNzEa6yhBJQ0wwbwcLSzG3Vmzjw@mail.gmail.com>
 <CACsJy8BKxf6Q1Q-u92enPgw6a18XhAOvYSewZs-G+tB+-MSkNw@mail.gmail.com> <CAPig+cS4Dmgh+hCMXp8ND5DMy6QFVCJOgvDwpcbwZ0HV4MscpA@mail.gmail.com>
In-Reply-To: <CAPig+cS4Dmgh+hCMXp8ND5DMy6QFVCJOgvDwpcbwZ0HV4MscpA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 31 Jan 2019 14:43:41 +0700
Message-ID: <CACsJy8C2fx-+NxS+ahmmHDgLrwtyiCV6WEEfpmYwfcPM3kYVvA@mail.gmail.com>
Subject: Re: [PATCH 08/19] checkout: split part of it to new command switch
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 31, 2019 at 1:25 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> I find, however, that the top-level git-switch "DESCRIPTION" section,
> which talks about "switching branches" doesn't actually ever explain
> what it means to "switch" to a branch. Even adding a simple sentence
> stating that "switching to a branch means that a newly-created commit
> will be a direct child of the current head of the branch, and that the
> branch will be updated to point at the new commit" would help cement
> the meaning of branch switching in the reader's mind (rather than
> assuming the reader understands that implicitly).

Thanks. How about this? I skipped the "update branch to point to the
new commit" because that sounds like something you should learn from
git-commit and hopefully the word "commit" would be enough to recall
that knowledge (or direct the user to git-commit.txt). I notice
git-commit.txt does not say anything about branch update business
though. Maybe some more updates there...

DESCRIPTION
-----------
Switch to a specified branch. The working three and the index are also
updated to match the branch. All new commits will be added to the tip
of this branch.

Optionally a new branch could be created with either `-c` or `-C`, or
detach the working tree from any branch with `--detach`, along with
switching.


-- 
Duy
