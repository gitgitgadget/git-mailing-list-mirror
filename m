Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D3951F406
	for <e@80x24.org>; Thu, 14 Dec 2017 10:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbdLNKGL (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 05:06:11 -0500
Received: from mail-yb0-f173.google.com ([209.85.213.173]:39283 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751957AbdLNKGK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 05:06:10 -0500
Received: by mail-yb0-f173.google.com with SMTP id 69so3023747ybc.6
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 02:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GS/Gg6cj/D8/7vnYJD/p3UlQvUqpB2ab9P36a5aGdSY=;
        b=uVp1ucmuereTHAwyfofnkMc59vlXPpIf9wdmQ9rnHnFWA6v8V1r7r1gBKo0gBJKVpl
         Z4H5+ak2g00aPkTLGx0H4Lfm41pu+kZfU1SFd4MNiQsSpNPZIDKA4qhS+DUwYf3R7EYT
         IKfO8RuX8csQlxhsNHPL29FqlHh2h+nwPO3gWsHxyt3q5HkmfZTUwqwOTH6hOebTUIx7
         W01xigrCYwiK5Xw2zE3vbHmE6u0s+TJ/meYU2UumZF9UiVPf2/HxJusnHEenGpwOjUzy
         Wq6WSn3EsXR+nSzWjXRysh38r64j23GcunOcUhvZJHL+NRIwprrDFZpGIVfbZGw1WpCN
         XV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GS/Gg6cj/D8/7vnYJD/p3UlQvUqpB2ab9P36a5aGdSY=;
        b=lWlPbmj/QSnsw5gP1zjTVRdh4yyHVa33ehAoP/l+mYsi6oGv6MmlMpuneEKFvFaANy
         LqYONvwpVqjz15apFmogRTlaIYkXzDwUGrfpwW6ozqxYv2ek4c0/iUDUp8jEiPd4SvD4
         LKY45xpd/fG4Qj69ZFr0gg9V5pxqLBZAMzx8m4R1Jw1k8Pury6K8a0esaYZ2+RzC6aIX
         HDQosK03e+0GCeF/QLiqhMrM2gQWVZqIiVgCU3F3zjFYym76pZ/n3m180o4kwvvQXTE9
         /Bsxf+cPpdsilVQAOMMpKn0dcH+M1FNedvP9qVOIvYNrqju5h1RQnkGzfY8F3E18hGd7
         MQgg==
X-Gm-Message-State: AKGB3mJqb681Cjcsd/ST9efRF6RsqATMMOv53XV12RfUgfy9987jjYgU
        BH7yl1g+rptYDfGY31e2vh5fXYt1CzQ5sUmr524=
X-Google-Smtp-Source: ACJfBov+g94vNBvGgbshCfr9fQfvCtY2P6gJG3gpohdD0oese3n9HKwRP0AP3CmC2GQtSucCfn7ZcFty0QMU8SkMi7Y=
X-Received: by 10.129.177.133 with SMTP id p127mr1256393ywh.416.1513245969478;
 Thu, 14 Dec 2017 02:06:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.135.70 with HTTP; Thu, 14 Dec 2017 02:06:08 -0800 (PST)
In-Reply-To: <1718292310.23922425.1513026746802.JavaMail.zimbra@inria.fr>
References: <CAGb4CBWZciqxdfpSkK1vezhiuSYX5Yy-xSq=Uj4h+vhRo9uyoQ@mail.gmail.com>
 <34c53164f4054ee88354f19fc38ae0c4@BPMBX2013-01.univ-lyon1.fr> <1718292310.23922425.1513026746802.JavaMail.zimbra@inria.fr>
From:   Nathan PAYRE <second.payre@gmail.com>
Date:   Thu, 14 Dec 2017 11:06:08 +0100
Message-ID: <CAGb4CBVcUv111dUy9waScAL2WATkk0LVqJQ55g3-XbH1H228YQ@mail.gmail.com>
Subject: Re: [PATCH] send-email: extract email-parsing code into a subroutine
To:     Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Cc:     PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ALBERTIN TIMOTHEE p1514771 
        <timothee.albertin@etu.univ-lyon1.fr>,
        BENSOUSSAN--BOHM DANIEL p1507430 
        <daniel.bensoussan--bohm@etu.univ-lyon1.fr>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-12-11 22:12 GMT+01:00 Matthieu Moy <matthieu.moy@univ-lyon1.fr>:

> "PAYRE NATHAN p1508475" <nathan.payre@etu.univ-lyon1.fr> wrote:
>> +     my %parsed_email;
>> +     $parsed_email{'body'} = '';
>> +     while (my $line = <$c>) {
>> +             next if $line =~ m/^GIT:/;
>> +             parse_header_line($line, \%parsed_email);
>> +             if ($line =~ /^$/) {
>> +                     $parsed_email{'body'} = filter_body($c);
>>               }
>> -             print $c2 $_;
>
> I didn't notice this at first, but you're modifying the behavior here:
> the old code used to print to $c2 anything that didn't match any of
> the if/else if branches.
>
> To keep this behavior, you need to keep all these extra headers in
> $parsed_email (you do, in this version) and print them after taking
> care of all the known headers (AFAICT, you don't).

This case is not that easy to correct because:
- It's could weigh the code.
- The refactoring may not be legitimate anymore.

I've found two way to resolve this:
.1) After every if($parsed_email{'key'}) remove the corresponding key
and just before closing $c2 create a new loop which add all the
remaining parts.

.2) Making a mix between the old and new code. Some parts of
my patch can improve the old code (like the removing of
$need_8bit_cte) then it will be kept and the while loop will be
similar the old code

I think that the first version will look like better than the second
one, easy to read, but it will change the order of the email header.
