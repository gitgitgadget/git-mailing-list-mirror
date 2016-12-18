Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8442F1FF6D
	for <e@80x24.org>; Sun, 18 Dec 2016 20:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753535AbcLRUgn (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Dec 2016 15:36:43 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:33454 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753376AbcLRUgn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2016 15:36:43 -0500
Received: by mail-io0-f170.google.com with SMTP id d9so138446570ioe.0
        for <git@vger.kernel.org>; Sun, 18 Dec 2016 12:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Ud2LguFqwTRHitpYtSX2abE6uAwcDMlwQi+4IxQY9cs=;
        b=o6DTrQTONMAx56jwGLP2rAwLjFrRp9/HheU8CJx086uxiii9gaBOut55p7kXOxPXtG
         uQSV42FH2E4LK/WOPDTLjRoLa6VdPul2DN+GPNiZjwfhlKB8fe2jbF/dupuUwxX4aXKL
         UZ3mkd/Y3EX/Rshi84Dn3DECkAFCDaqsXkvd08m0S8BQ3vNCN4BJQUmsqruZrsVzo6ke
         +8cObYJfBedWWRkFqmTaq7Uu0YDLtYrTJoKsM2LbrsWdAAYJQ0FdPuOWPeKJwsFwm1Je
         65tINfHTuTOZ88BPUSeiTXwwC5rroLe0cVUpZ1lycCF8nPA0dablgR0pvDUNnqE0tvvU
         2TdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Ud2LguFqwTRHitpYtSX2abE6uAwcDMlwQi+4IxQY9cs=;
        b=ZRQ9Kh7OX60WrHYxMZjvOASDLtAA+Ui10zRrdZ7SjsJADdNYvZ9+/U55xgKe/wHuRL
         z/pv/lK9tgF3IlM0JKXtBKgiDmUKphxP2Y7K2LoDUrZAwucA89rf536PDyRA+HHbBPTr
         IjiT0jUUJXE4mE7SorHMav46pmYz4Qk4Hha/BNf9c3mrZjUAr+5q7Snj5vMFl6/yXWZn
         osRIksqTETZUMVH6cNQhhPwqYDFVPkt+3SA9uvrJu6R7MhQQQFoecMzVJGAZYWXAyyPm
         ojPpej/nzqyvJlS7Mn8XgMSRRzBiZD4x6Pt+43mKNqHeF8zyo3F8p6AUYyrIXfYFYLO1
         8ySQ==
X-Gm-Message-State: AIkVDXLAlYilUwGJxDxYYzG3qXfJAUfDk8kKZoVYB6GRMA9hkNiNoKQVmbDPnSLcicU8gKKCUJRI49qZ4/hH8w==
X-Received: by 10.107.11.81 with SMTP id v78mr12063998ioi.20.1482093401659;
 Sun, 18 Dec 2016 12:36:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.87.169 with HTTP; Sun, 18 Dec 2016 12:36:01 -0800 (PST)
From:   Josh Bleecher Snyder <josharian@gmail.com>
Date:   Sun, 18 Dec 2016 12:36:01 -0800
Message-ID: <CAFAcib8yauNRB6UbO8qS2_Ff4fDt-7mMsmgop8d1V0j=RoTBSA@mail.gmail.com>
Subject: Bug report: $program_name in error message
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To reproduce, run 'git submodule' from within a bare repo. Result:

$ git submodule
fatal: $program_name cannot be used without a working tree.

Looks like the intent was for $program_name to be interpolated.


As an aside, I sent a message a few days ago about a segfault when
working with a filesystem with direct_io on, but it appears not to
have made it to the archives on marc.info. Am I perhaps still
greylisted?

Thanks,
Josh
