Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73BFC2027C
	for <e@80x24.org>; Fri,  2 Jun 2017 23:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751603AbdFBXu7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 19:50:59 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36535 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbdFBXu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 19:50:57 -0400
Received: by mail-pf0-f172.google.com with SMTP id m17so58289662pfg.3
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 16:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=SXLkjuNR5HcCrE9kNO7bdRt9NUjLor34hKihTrp1dzY=;
        b=uPVvjTXDdbz9L6ZdqNKiI+Je0zH6RjLkJgdbKtDLAfN41JXVN98BCOA/JLqrl58Svw
         p7b0Y5rH6NSgg4W2h6FgD4zZm7KY1rmQPStSafwfxj+qw8xkkwvCaGOZhaD1as0eNjOU
         HcsQvQ2/sql8rBwGozqpwOAxXL+pnwdRCxppAYqvy2AQzpiHf024QW0YnmHU+pScTZoJ
         oaVVpwfOCo5ZInZrI0dD7kSh54JLVyQPJyCNRpM8hZZjR2IWTBz5f5RXuV300UI9Dl9b
         yCnUwjg/lf4Tv6U+RovZpzqWXEhSjNWTh3dKTxouPGpDNX9sCW3AhFmgktNRg3Jj9Vxi
         +d4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=SXLkjuNR5HcCrE9kNO7bdRt9NUjLor34hKihTrp1dzY=;
        b=oFc2ySHpyUoPztEgJSJVOU9saGC2gJOXOy9qrkUR4RBIiTAnff/w+BnYlOJ4A/yOKD
         LP5RrD7ORw7eYSSZOvjZfn/qSSch3swx+spVHt8NrQlDqSk9/HeejkB/hlH+vc+Xy7as
         iUpy8ATEEbxkl9/SRCOOYY0fXOLQwFQ1vPYYjx6ONYeFueyGSsJ8JyqVWIOCrZ3G1xy4
         vT4knqnnXTqrzgG9Aof/pdSE/2exBaRRNLesHNHVge7Ot+2315shKMZw+B6BbscbLE31
         SW2WMBclvNrxAqanLWihKfHbBwpnghUSJYuuHpjS8jTMbB6JRIWFFpyQdeg5D88ykLi+
         T4nw==
X-Gm-Message-State: AODbwcAhwapauQ2OGgr0kYliQpDXPAFZVMcyXhdq/52aSEQi0qORDXr8
        A9Watv32C1exIw==
X-Received: by 10.99.165.29 with SMTP id n29mr9681047pgf.233.1496447441995;
        Fri, 02 Jun 2017 16:50:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:49ac:b4b9:21bb:8989])
        by smtp.gmail.com with ESMTPSA id 23sm44764293pfr.127.2017.06.02.16.50.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Jun 2017 16:50:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeffrey Walton <noloader@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        Git List <git@vger.kernel.org>
Subject: Re: How to avoid "Please tell me who you are..."?
References: <CAH8yC8k9pJHLuzWneb4aRAEF2zOTCVO_5YJxrCpw28x8bDox0A@mail.gmail.com>
        <CAH8yC8mjTXQ_5uRedHi=fytKtQttyq_WemGFNQTP9C3PK4x5cQ@mail.gmail.com>
        <20170602070052.3lq22arcncuh6rrl@tigra>
        <CAH8yC8nGR1heD9_xRuHRG-oerdoQr6Pi8mT=ZpFhoeH6LaFK2w@mail.gmail.com>
        <xmqqy3tayi53.fsf@gitster.mtv.corp.google.com>
        <CACBZZX4vEOD-4a-eK-uBxmFrb1GLSvJKxHW51whCSbCZdh7amQ@mail.gmail.com>
Date:   Sat, 03 Jun 2017 08:50:40 +0900
In-Reply-To: <CACBZZX4vEOD-4a-eK-uBxmFrb1GLSvJKxHW51whCSbCZdh7amQ@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 2 Jun
 2017 09:38:52
        +0200")
Message-ID: <xmqqh8zyx833.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Fri, Jun 2, 2017 at 9:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jeffrey Walton <noloader@gmail.com> writes:
>>
>>> Is there no switch? Its the most efficient way to accomplish the task.
>>
>> This is a safety to help normal human users from hurting themselves,
>> and it does not make any sense to have "I have no name, so record
>> garbage, please" option, switch or setting that is different from
>> "Here is the name I want you to use when recording things".
>>
>> The switch _is_ to set the names with whatever standard way.
>
> Presumably OP doesn't want to mess with the env for whatever reason,
> in that case:
>
>     git -c user.name=Nobody -c user.email=nobody@example.com
> cherry-pick <commit>

Exactly.  That is what I meant as one of the "whatever standard
way".
