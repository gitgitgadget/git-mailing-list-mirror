Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00D5B20954
	for <e@80x24.org>; Sun,  3 Dec 2017 09:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751560AbdLCJgK (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 04:36:10 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:43856 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbdLCJgI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 04:36:08 -0500
Received: by mail-wm0-f47.google.com with SMTP id n138so1002644wmg.2
        for <git@vger.kernel.org>; Sun, 03 Dec 2017 01:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=POt3KiTUm3VOuhnML4pyEN3j6GiwumwpIFV+jPTfUxg=;
        b=AmuULoRvGRmzsSeX5rhx5RqNofig5RpnEIXXonNztOKyBCZiO2ewH7yDP9mEpl7ZIk
         x1oIFE3oNs8+vZdqVqfFjohqzDcnJrpFcIQpxlPGBP67qgSef2MkCo7Bz09sMSULvJnb
         cUNzacuWyHN6+WKrSXyriFgj30uizOo2j0MK4230WBy4e+rMMxzpnNlf20ti4LcVt+EH
         1bKVLY5nSdab0F5bNO2NTCsPJFoATCvbP94xfPFXf/ymk1UxNPDlvpPhQphpz+cyC5xQ
         x/mo8NIdETRivXurcc5ewKl6pdVbE+5iQhxhK3g5ajAFvK8qQsIgUHyvrKtpuQ/oEEze
         pR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=POt3KiTUm3VOuhnML4pyEN3j6GiwumwpIFV+jPTfUxg=;
        b=gIbfKx9MsOxuZ2AZTImFhVTGEPEutHS3tmqNOJ7h6icqUZeq2EBAuX4o4W6qhAprVt
         DemFTqB0Uir5+IIuQTNN/Se6TpX7yfkUF6IYMu361I9je/mA9AHfCsJEPwcyBi0aVjFS
         7O6eyX5qcfDMxUnx4Ve8TnD5MCA7cQLyHSPZFMaRtaPegYlZTjQ5Pw0FOaJ8zwiifw4r
         t6lu5ZdkDXQ/A9VNXadajAYAGuScSecAsVqg4uBv4KC37LSh6pWOv/BBIqdm6Fv2b8ss
         4Ip5hcIH34O+Jjz5Y5q+dQ8M3gjrnLfRXcjokKwxK6Tk8npse1eS9zH0jAvgbigynble
         ZBaw==
X-Gm-Message-State: AJaThX7wqgZvtqHxLtuDa2PsT/BZrlLdchG60UEoemr8+9hzoUgeQ9JK
        S2As7RQHw0Eof7OH783Ui/o=
X-Google-Smtp-Source: AGs4zMawNOyGVGt+pcZKR8XdO8NDUWxl0HRbtz+hPRMkX9S18vfnsKZPrQCqAKpD07xljECp7SpUBg==
X-Received: by 10.80.163.138 with SMTP id s10mr25248153edb.302.1512293767480;
        Sun, 03 Dec 2017 01:36:07 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id h16sm6638267edj.34.2017.12.03.01.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Dec 2017 01:36:07 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eLQXF-0007Qj-Jz; Sun, 03 Dec 2017 10:26:05 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Dan Jacques <dnj@google.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v4 1/4] Makefile: generate Perl header from template file
References: <20171129155637.89075-1-dnj@google.com> <20171129155637.89075-2-dnj@google.com> <3c897f4c-0cb5-ca44-f144-598a623c1dc3@kdbg.org> <xmqqr2scjsb4.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqr2scjsb4.fsf@gitster.mtv.corp.google.com>
Date:   Sun, 03 Dec 2017 10:26:05 +0100
Message-ID: <87a7z0upqq.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Dec 03 2017, Junio C. Hamano jotted:

> Johannes Sixt <j6t@kdbg.org> writes:
>
>>> +	sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
>>
>> This doesn't work, unfortunately. When $(pathsep) is ';', we get an
>> incomplete sed expression because ';' is also a command separator in
>> the sed language.
>
> It is correct that ';' can be and does get used in place of LF when
> writing a script on a single line, but even then, as part of a
> string argument to 's' command (and also others), there is no need
> to quote ';' or otherwise treat it any specially, as the commands
> know what their syntax is (e.g. 's=string=replacement=' after seeing
> the first '=' knows that it needs to find one unquoted '=' to find
> the end of the first argument, and another to find the end of the
> replacement string, and ';' seen during that scanning would not have
> any special meaning).
>
> If your sed is so broken and does not satisfy the above expectation,
> t6023 would not work for you, I would gess.
>
> t/t6023-merge-file.sh:sed -e "s/deerit.\$/deerit;/" -e "s/me;\$/me./" < new5.txt > new6.txt
> t/t6023-merge-file.sh:sed -e "s/deerit.\$/deerit,/" -e "s/me;\$/me,/" < new5.txt > new7.txt
> t/t6023-merge-file.sh:sed -e 's/deerit./&%%%%/' -e "s/locavit,/locavit;/"< new6.txt | tr '%' '\012' > new8.txt

Since this whole thing is guarded by "ifndef NO_PERL" Dan could just be
using "perl -pe" here instead of fiddling around with the portability
edge cases of sed, e.g.:

    perl -pe 's[foo][bar[g' <in >out
