Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A68F1F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 16:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751644AbdFIQhI (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 12:37:08 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:32951 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751622AbdFIQhG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 12:37:06 -0400
Received: by mail-pg0-f44.google.com with SMTP id f185so28216181pgc.0
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 09:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=CtV2PaQ8D8msmCYEPhmIj4Y8Lo9vuZaYpmeQvzahyeQ=;
        b=YWbkH3BnrTqMp2QfkuqQoGAys+gUxHyuit9MsX8ZZR3MQD8zlVb5RSW5kYhmzBXSfx
         9Sh4lRw4ux5MJG+Pm8hN0YECq+9Frwfyz8CGXXaOIliHTR1tonG9bg7coIfVa518DvSv
         Xm0nGhD1aMf5ci7WtDKnW1NwATjhBj6BwE0J7cDn7YWkEAki8DED2ei7+aH3HUjxySMd
         Rq4AGu37FT5b3lrVI2rL10w/w1TKC14egN/NBm76WvL7bEr3YKZPAI5NOWWVbhDMmiss
         1qOGdkItwwSLP9Z8YUp1Ybv7WUgF/2PRDGb2rBqete+A5WxI+eCOGfTihAIC6IAKR4gO
         sDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=CtV2PaQ8D8msmCYEPhmIj4Y8Lo9vuZaYpmeQvzahyeQ=;
        b=BQlx1vz5FdHFa+WZLsjj/dovSVSzf13Wgwl7Z7shQ34CQ6HKedSOoZjSfW+eWd2rLS
         95LWPptmUt63LSF6DeXOE3ChsphShm0f8p+Niq9hTsCaKBDRb5ehgfn9UTdjanA3xHT6
         67rmgGFyymkuLSpu4jylbVJs/Ugnjziz+61Qg72b+VKZJbxiGnMyxiXqMAKynsNNGt3h
         FGNftiqfMIFQvxfPRalqJgYB+UqwsulEzSt6pp67/pXKYfM63zTmKCipB7AJQCvsMajR
         V1A8kJP41i2mT4yaGKRIsv/J1C8ZYZ1OiYr1jp0zxZYLGkZc1605LZXXqTsRyXpZXgBZ
         d2zQ==
X-Gm-Message-State: AODbwcAO8639CjGDq+tTENE3EG1SVpQ7AuhZFwd8HyaZ8ntqgPTroJpG
        jqqEV1L/PqR/SA==
X-Received: by 10.99.181.30 with SMTP id y30mr43489037pge.83.1497026226221;
        Fri, 09 Jun 2017 09:37:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:25b5:3bc1:d744:5d92])
        by smtp.gmail.com with ESMTPSA id u85sm4330709pfg.73.2017.06.09.09.37.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 09:37:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Liam Breck <liam@networkimprov.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: send-email: Net::SMTP::SSL failure
References: <CAKvHMgTBmdKrz-i9-uBFtx08pegjuY2=jKQE21pi=MabTuicrw@mail.gmail.com>
        <CAKvHMgSgOyDhffPm=-QEQNzoCoPtmWbV_R7JDtBFTHQ-sL3Wug@mail.gmail.com>
        <CACBZZX6AKYA5PmE6Le4cxCTCOOix1ErHyT21C=L83CQBYaN=RQ@mail.gmail.com>
Date:   Sat, 10 Jun 2017 01:37:04 +0900
In-Reply-To: <CACBZZX6AKYA5PmE6Le4cxCTCOOix1ErHyT21C=L83CQBYaN=RQ@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 7 Jun
 2017 19:16:41
        +0200")
Message-ID: <xmqqvao55d8v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I have not looked deeply at this, but the error you're getting means
> "we tried to load it before and failed, and here you are trying
> again".
>
> This is almost definitely due to this line in git-send-email:
>
>         if (eval { require Net::SMTP; 1 }) {
>
> And more generally, this code is all buggy:
>
>     4 matches for "eval.*require" in buffer: git-send-email.perl
>     153:my $have_email_valid = eval { require Email::Valid; 1 };
>     154:my $have_mail_address = eval { require Mail::Address; 1 };
>    1118:        if (eval { require Net::Domain; 1 }) {
>    1129:        if (eval { require Net::SMTP; 1 }) {
>
> Well, "buggy" in the sense that we're just happy-go-lucky trying to
> load these modules, and if they have an error we don't report it, then
> when we try to load them again perl just emits a generic error saying
> you're trying to require() something that already failed somewhere
> before...

Thanks for the discussion.  My short summary from reading the thread
from the sideline is:

 * "eval { require module; 1 }" pattern seems to have spread by
   copying and pasting without thinking, all of which should be
   corrected not to retry;

 * The error OP encountered is not an issue in git-send-email
   per-se, but was made harder to diagnose due to the above.

I think we still lack the definite "here is the right way to fix
these not to retry" patch for application, but anything else I
missed?
