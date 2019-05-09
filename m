Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DE9C1F45F
	for <e@80x24.org>; Thu,  9 May 2019 09:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfEIJLH convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 9 May 2019 05:11:07 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:37257 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfEIJLF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 05:11:05 -0400
Received: by mail-wr1-f44.google.com with SMTP id a12so1937662wrn.4
        for <git@vger.kernel.org>; Thu, 09 May 2019 02:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kZMSkO3ePPq6MsF1Zpc6m6m2LqtbPS8KkEf8vGCjWyI=;
        b=I6AdlWXzQMXxHuM1A0Rax/WIsyJGzTszuu07h9DNE/ya0vCrotl3ujFmY/43bWxCBI
         OXSeKhx7v1cAoDg6TUcAbv8HTWI1X+DA7lOSvHKbXb28KQmFkbyADpS7Tp2bgma7vXOQ
         SOUdD0eX+o+n0X1H2/pLj7oyuqRqIfLBW1AG7qmWl0JdzCPp2ag6oJ9Q5Lu7VXaJpaGg
         y7KkEOwIqrkxcdDOoxJOxv2zJn+OHbVrDsw107VBfwBJVBhI0uuQz9XYbFrr/mltS2bH
         onYPOlR+EIrPOB7b/XxVvRNIorAcN4vyU6yaym30CoPNlrzNj6xxv9EWCYpJAA4y3j4v
         Odpw==
X-Gm-Message-State: APjAAAULRzrMFALkUtTeIhb4YTwQ0soBr4cOYyjb+2eJS9+L6AWtfKDR
        ExTr3fxFXzOqx4hieb3PN63YLvecQ/d5AD2ywmE=
X-Google-Smtp-Source: APXvYqyrXTEBG5Bhrn9Ug4YPgxSoWMSzL6e1ZECWe7K1JpU1cWRhHWxcNiMjb4VUz6KxkHpoo6NlCabh5Q3U31f2SX4=
X-Received: by 2002:adf:e6ce:: with SMTP id y14mr2058016wrm.217.1557393063991;
 Thu, 09 May 2019 02:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8nTyq5Fjc-6fUNn1iwkCO9i1Vrc0vFqxEVg4Eor3h-0Lw@mail.gmail.com>
 <CAPig+cSzsmeHp1S5WG3TVXEyZKt9eVrsCsWEkpwbNUZK_SJ53g@mail.gmail.com> <87mujwh98z.fsf@evledraar.gmail.com>
In-Reply-To: <87mujwh98z.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 9 May 2019 05:10:53 -0400
Message-ID: <CAPig+cTM-ObsvvNy8uDmO1mS_KfcjppeRBMe=pnM5GkvS5ZVgQ@mail.gmail.com>
Subject: Re: Git build on antique PowerMac
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeffrey Walton <noloader@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 8, 2019 at 6:28 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Sun, May 05 2019, Eric Sunshine wrote:
> > On Sun, May 5, 2019 at 3:43 PM Jeffrey Walton <noloader@gmail.com> wrote:
> >> readline() on unopened filehandle       test_must_fail
> >
> > Given [1], I can see (I guess) why it's complaining about modification
> > of a read-only variable. However, the unopened filehandle complaint
> > looks odd.
>
> It's because "while (<>) { readline }" didn't use to be supported until
> 5.10, and he's on 5.8.

Thanks for researching this. Now it makes sense.
