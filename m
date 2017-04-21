Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3C04207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 14:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1040939AbdDUOZY (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 10:25:24 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:33852 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1039917AbdDUOZW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 10:25:22 -0400
Received: by mail-qt0-f176.google.com with SMTP id c45so70721239qtb.1
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 07:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zwIZkoRDYWwGfAz6QJYwXpqFvO2/y8YZdSeaOz34aPY=;
        b=tbFkVaTxeJnwhfICM3g1T1wXF3SNotfPuDnpqMW6asVp8Ku5/NLl4zI176KiOWOsxD
         CQksHzMEwag6zaBuQjEkuvDuGNhZEyEwFqvfEIkrlBf7hHlEMkp6d+ugN9TZ5DSVd9Fu
         TBMVNIcnKj5VcYKckKS+klXBgNqtH70C/fiy1m66BCkV9TY/2snfIPYRxKDwZODF1nN+
         QBwmpAr1jhu8KhOE/B/KWousYWhDPTyAqGd7xTxW79RkWYjD+oupx+kwyxhJ3wNJ4Tkj
         NT+nx6KTZF/vcQabAn3no8DuJZhT7QASynBXI9UI7Z91VukXlCCDzjfRcoXu6z5Rh3qH
         sn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zwIZkoRDYWwGfAz6QJYwXpqFvO2/y8YZdSeaOz34aPY=;
        b=OmdlZNEBRPEpxPStBLmItp1tD3SnWJyYDDnG5ao2ulc4mI4UNUfUAsPebGamIPMArS
         /9wgMtPXjpVB9Ce+sDL4TehiHVGbYbYoIexTDWDG95bBMXq7nfCnlN1bjXvn5WTc8pGo
         PkIaPusuRlPaTJn6Q23EvPyaOqZv3lz3vQsGClYB/jkLjpmwrAOwQvyRepH59psOMhaB
         LAFYKfj6ZsJokGv2MWLhXF9e74Hr3pT5BjLHuYpD6t2OAw7ruwvUlYnWLv4TV4Xec6o7
         p5F2ku0czen1LrOegCDpz9+kGSfMmsNEPM/lzbPHgbeDV/s2hfkIFFlCN+255MVmYPeo
         cPlw==
X-Gm-Message-State: AN3rC/7k+/kgT3evTDe4GDASyr4niYaMVYxl55WBgp9jZmYDehP5dFDV
        U+Og+0hwDFaU3EjPxPoD+JutXJYFjkpD
X-Received: by 10.237.36.103 with SMTP id s36mr14370782qtc.71.1492784720859;
 Fri, 21 Apr 2017 07:25:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.96.65 with HTTP; Fri, 21 Apr 2017 07:25:20 -0700 (PDT)
In-Reply-To: <20170420212436.GC4989@hank>
References: <20170420205214.GB4989@hank> <CAP8UFD1LAU8hg4ioes=y4o_Phgd1zBhUJOmkqTPo++4SprWWpw@mail.gmail.com>
 <20170420212436.GC4989@hank>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 21 Apr 2017 16:25:20 +0200
Message-ID: <CAP8UFD2f9g__ykCjReSoaAUvFTPmgRDbsWFQMRrFoFw8haV0uA@mail.gmail.com>
Subject: Re: [BUG] test suite broken with GIT_TEST_SPLIT_INDEX
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2017 at 11:24 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> On 04/20, Christian Couder wrote:
>>
>> Could you try with the following patch:
>>
>> http://public-inbox.org/git/20170330210354.20018-1-chriscool@tuxfamily.org/
>
> Yeah, I tried with and without that patch with the same result.
> Unless I'm screwing something up when testing I don't think this fixes
> the issue unfortunately.

I just tried on "pu" and only the first test
(t7009-filter-branch-null-sha1.sh) fails there.
