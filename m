Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 953801F404
	for <e@80x24.org>; Fri,  6 Apr 2018 21:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbeDFVFd (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 17:05:33 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:38668 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751746AbeDFVFU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 17:05:20 -0400
Received: by mail-wr0-f179.google.com with SMTP id m13so2886572wrj.5
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 14:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=5wib7vhe56yUa7gyLfLSc9pkENXAGiONYgS6fCfkYCo=;
        b=TSpHQGdODNBfpj+yW3B90feX839EC1o0SFT+VbNbQTK+gwXrU2hQ2SHqWaoyiqJLw6
         UdpDFV9DwW8kModo9yrZHBbzDe3jpH7O0oLRUoCsssrZmCk10g6WCvnlVT5QiqVnh7iz
         UAzR8K3TiUDVJ4YE2WVCJt7TydUzdBekjuSw2iIAEMnneshJWXSgM/t9VkWJIFtSTZOO
         XWOlmw8cKOSwDZuE3EGs2+NZKjTXTPNe56OqYhcZpFDSDBT4rFeBHy5H9p19TkvpS616
         dyqn2pyuE0WFainvqF3J6TeTZ9+4PNWV7zO7WEmp1pc9xIWlzRdf9OKk6TCZdNz81uM0
         hX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=5wib7vhe56yUa7gyLfLSc9pkENXAGiONYgS6fCfkYCo=;
        b=gYTXyrt3JtI1J39usRyO5+iwBIe21Fyv9FQy9MpRhrJj+R0vhHJvwODrGb43+DVVDI
         JEogK0H0Fd0In/8sA9uHzW1MlSGKTAKKbgGdBpmwHxdTyuUU4LOttWWPmvEJKou/tqsM
         A60DdOuq3DQSQCo99HLi8TYcpqsvlUF7ROQR9tPiIpTEG1BG7AHw9dYNBDc5k6GdbhkT
         VYPBCbqzEb0XiqrZzygSj9cBmfGqRDrfUXNn51WctGVMLDL5klVEqzIPtXdYca6bSvyg
         qWGuTwzzE0kbZCOiy/NV8JT1ognJc/gDSKkO8w3yPA1Gdli3ZZauzBISt9OrPr8Z4h8w
         ao+w==
X-Gm-Message-State: ALQs6tAyu+sF3CjaHIJuU7jCI2NLozcYf1ThSFwXc2kiGyDcIIH2CdZ4
        W3DimlUKOqUvSAx/LAIKXnA=
X-Google-Smtp-Source: AIpwx4/nwEB3R9IcxjH7+3RgSmJ1B/Ci5wms8+4Wb9EaQzz8F92/ERUc/k7DJGjkEzfiFMjzunWayg==
X-Received: by 10.223.185.73 with SMTP id b9mr3742175wrg.229.1523048718827;
        Fri, 06 Apr 2018 14:05:18 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id y6sm6964200wmy.16.2018.04.06.14.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Apr 2018 14:05:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Joseph Mingrone <jrm@ftfl.ca>, garga@FreeBSD.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Caradoc-Davies <ben@transient.nz>, 894997@bugs.debian.org
Subject: Re: [PATCH] git-svn: avoid warning on undef readline()
References: <86h8oobl36.fsf@phe.ftfl.ca>
        <20180406131514.740-1-avarab@gmail.com>
        <20180406165618.GA6367@80x24.org> <87y3i0yz1t.fsf@evledraar.gmail.com>
        <20180406204906.GA27677@whir>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180406204906.GA27677@whir>
Date:   Fri, 06 Apr 2018 23:05:16 +0200
Message-ID: <87sh88yrjn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 06 2018, Eric Wong wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>> On Fri, Apr 06 2018, Eric Wong wrote:
>> > Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>> >
>> >> --- a/perl/Git.pm
>> >> +++ b/perl/Git.pm
>> >> @@ -554,7 +554,7 @@ sub get_record {
>> >>  	my ($fh, $rs) = @_;
>> >>  	local $/ = $rs;
>> >>  	my $rec = <$fh>;
>> >> -	chomp $rec if defined $rs;
>> >> +	chomp $rec if defined $rs and defined $rec;
>> >
>> > I'm struggling to understand the reason for the "defined $rs"
>> > check.  I think it was a braino on my part and meant to use:
>> >
>> > 	chomp $rec if defined $rec;
>>
>> Whether this makes any sense is another question, but you seem to have
>> explicitly meant this at the time. The full function definition with
>> documentation:
>>
>>     =item get_record ( FILEHANDLE, INPUT_RECORD_SEPARATOR )
>>
>>     Read one record from FILEHANDLE delimited by INPUT_RECORD_SEPARATOR,
>>     removing any trailing INPUT_RECORD_SEPARATOR.
>
> I've always known chomp to respect the value of $/; so chomp($rec)
> whould only cut out whatever $rs is, and be a no-op if $rs is undef.

Yup, you're right. I missed that.
