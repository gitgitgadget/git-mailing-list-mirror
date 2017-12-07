Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1C7520C31
	for <e@80x24.org>; Thu,  7 Dec 2017 07:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750803AbdLGHcM (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 02:32:12 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:47023 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbdLGHcL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 02:32:11 -0500
Received: by mail-qt0-f181.google.com with SMTP id r39so15248234qtr.13
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 23:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=5WNo/jimoWc5Lxqyh7JDbk9AWo8khhl7T8HhkD0AquU=;
        b=JhnI3KPQJCtN23A3IkB0PNceMFjUp8PDUtWf7bNA/xz8r9IH0C0dGaTp2+c05/TffW
         cKWJ7fjsEldWuMhu8uspm6mZSg5eiqd5PSQNChj/9/MHRTipqNE2Y4cg1lRlyPW0iHWm
         tFwfwHNyemtK5s6ZL1BpDbdG/fhZa3JB2wYrPjTLYAQB7ScYI0+hrMCQlGKyIdiG+u8k
         d6cE7YfYahHyaNgaos+panUZYvZVIT9GXB+DHYUQZa4sD/TQndrdiFGnqZ/T9O5ft3pg
         xvbn3HufVTVmf5ojjJA82vQJWtLtP+dZbiJuCPFkO6mvFbKc6W237e9/IQA5zF40Tbj+
         rF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=5WNo/jimoWc5Lxqyh7JDbk9AWo8khhl7T8HhkD0AquU=;
        b=TzQ7WulbICiBKOGVcmGwV22RElV+hoSOCmCl+L//HbomuuQBAPGnjABPYGVacaGucs
         NEBTFiEBjt6WayoaZDzwZ3dVw2Vj0QUKkRe3Y/di6hactq3qPcTLElg/RjPQFohAr9Mt
         rFw5Nb7+TEmLIPBRXNhNLkwD7SYjZ7GklcdLaSqCFktBDApQCJBzonJ8cEu4yGJVcTPG
         WftAM7vQJoQeqvykgrK++iXOhGqU8EgO8AueZN9/B81ASsdrQm9xXTEvogP09FtlkKmI
         CrOxTnP2vXDo41TsIzfZHhCcwzZySpgYfCs9tMd+oesbrMnIvEvttH7Y0GTEGWX/qcqy
         UZkw==
X-Gm-Message-State: AKGB3mJK9Nvr6eNSMN+ZAQD79aalkZPkLGiI8sZk1w773qZGDv/ajVjm
        WZNiF2aFBhktLa35FE3n1ZlEHsO4XLznvcNtOZ8=
X-Google-Smtp-Source: AGs4zMa/9SYQoldxxRy0F+Xb444JRNXLnOwSB4nPjFHHvZIKRq4O2GCZK+RViBFQbX9Bs7NYl2lR5KroKzEAhihQQSY=
X-Received: by 10.55.93.198 with SMTP id r189mr28825097qkb.210.1512631930644;
 Wed, 06 Dec 2017 23:32:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Wed, 6 Dec 2017 23:32:10 -0800 (PST)
In-Reply-To: <CAGb4CBWZciqxdfpSkK1vezhiuSYX5Yy-xSq=Uj4h+vhRo9uyoQ@mail.gmail.com>
References: <xmqqlgiiobcy.fsf@gitster.mtv.corp.google.com> <20171206153821.24435-1-nathan.payre@etu.univ-lyon1.fr>
 <xmqqvahjfsdx.fsf@gitster.mtv.corp.google.com> <CAGb4CBWZciqxdfpSkK1vezhiuSYX5Yy-xSq=Uj4h+vhRo9uyoQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 7 Dec 2017 02:32:10 -0500
X-Google-Sender-Auth: u44wQRB4lm0lD_wnTyvGp4gi1bU
Message-ID: <CAPig+cSmdZds=9P91v4YhHkPyLPaUFcnV1ynMswhKKKauMhRWw@mail.gmail.com>
Subject: Re: [PATCH v2] send-email: extract email-parsing code into a subroutine
To:     Nathan PAYRE <second.payre@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nathan Payre <nathan.payre@etu.univ-lyon1.fr>,
        Git Mailing List <git@vger.kernel.org>,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>,
        Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>,
        Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 6, 2017 at 5:55 PM, Nathan PAYRE <second.payre@gmail.com> wrote:
> Junio C Hamano <gitster@pobox.com>: writes:
>> Also "reusable in other place" is by itself not an unconditional
>> plus, until readers can be convinced that that 'other place' really
>> wants to be able to call this function.  Is there some untold
>> motivation behind this change---such as a planned update to actually
>> use this helper subroutine?
>
> This subroutine will be used to implement, initially a new option called
> "--quote-email", but became "--cite" added after "--in-reply-to".
> This will permit to the user to cite a mail and reply with a patch and keep
> Cc, To ...
> See discussion :
> https://public-inbox.org/git/20171030223444.5052-1-nathan.payre@etu.univ-lyon1.fr/

Although he didn't state so explicitly, please take Junio's question
as a strong hint that you should update the commit message to include
the above rationale/explanation about why you consider this a good
change. The reason for including the motivation in the commit message
is that you want, not only to convince Junio now that this is a useful
change, but to convince future readers of the project history that
this change is desirable.
