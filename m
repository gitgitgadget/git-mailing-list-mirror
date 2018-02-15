Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B00DC1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 20:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166656AbeBOUoE (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 15:44:04 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33736 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161706AbeBOUoB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 15:44:01 -0500
Received: by mail-wm0-f65.google.com with SMTP id x4so2769089wmc.0
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 12:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=oEBoDOkudRTDEPZki2tKdOLTCbWYT9XzpNijX+GvwUY=;
        b=Nk9YwDTTw8sx1ZgWugA2wzqHPTEA2amw1ZqSosG76SJvd6F2hWRH2FjvtTj5mXycyK
         A5RxBSJ9CJyFOpBXSgRVLoa+jowh2NLs9jGONL31Y/WXWWmnY4+58uCa3oM0V7Wkfanm
         uDCTFx59ysWUzNi9diK7+EdLivjaXZfi868wEnXvVWlS8vrNLNzgsV19Qr96VLijPda2
         sjinPXtFH8FbOp6Ylb2my0eyf3o7qLbFUuXJDY7Q3iZDwSx/xoob+fpxDTTOcEgUNybV
         wOZxcD6Xj6UOzLxSE4OmrMJQZ/sErKQLCtUPaCWEl2BxHd3geP5R3YkjRL/d4RVMH9ek
         a4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=oEBoDOkudRTDEPZki2tKdOLTCbWYT9XzpNijX+GvwUY=;
        b=szx2ERJaXUvciLc4vhN7nvx/jX58u5/AbI4VZn4My0CnFystsF0kPEa2LX2zCkDYeh
         Np7Gy2Rtk4ZkuIlpTCrDwnst6b52V9POlgT664/0pGsMUw8ggvaEUH+mvPMT+JLURhWt
         ThUrtR9fCmR1vG48bH19BMTfOW2FYA1GJ3ENrzRIyJxgJWw1IyWM36NlgI/2qHvvgEbN
         XUQ5ieoWOIpAfs4fbwnVZEYwG9B56XIGCqBZNiU1aERL2Ws+/OXnryYNr7+ca7GGmkNs
         S41v2wAd1bAZElUAAvaFNnvw316b6tCs5W4/FHgvG9kzagS22GNGurAOrW5iivhExMeW
         C8Jw==
X-Gm-Message-State: APf1xPBxRTQHEeHQD0ErA+ZmLvVlwL/UumLsV1Zr3AUpw9/J+QuRGfnl
        EJDvRk7Qs1wR6TwvIdu49YH1g/02
X-Google-Smtp-Source: AH8x227NU7EstRSFgz+sEQd/YBHEfGXEenVF4YcH0ftW2bpVRscOez0SO26zKArrGEoXKfF+3cRZCA==
X-Received: by 10.28.111.28 with SMTP id k28mr2990588wmc.54.1518727439946;
        Thu, 15 Feb 2018 12:43:59 -0800 (PST)
Received: from evledraar (static-2-73-24-46.ipcom.comunitel.net. [46.24.73.2])
        by smtp.gmail.com with ESMTPSA id r70sm18150184wmg.30.2018.02.15.12.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Feb 2018 12:43:59 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@slb.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 6/8] git-send-email: unconditionally use Net::{SMTP,Domain}
References: <20180214222146.10655-1-avarab@gmail.com> <20180214222146.10655-7-avarab@gmail.com> <20180214234901.GF136185@aiede.svl.corp.google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180214234901.GF136185@aiede.svl.corp.google.com>
Date:   Thu, 15 Feb 2018 21:43:57 +0100
Message-ID: <87po56f0fm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 14 2018, Jonathan Nieder jotted:

> Ævar Arnfjörð Bjarmason wrote:
>
>> The Net::SMTP and Net::Domain were both first released with perl
>> v5.7.3, since my d48b284183 ("perl: bump the required Perl version to
>> 5.8 from 5.6.[21]", 2010-09-24) we've depended on 5.8, so there's no
>> reason to conditionally require this anymore.
>>
>> This conditional loading was initially added in
>> 87840620fd ("send-email: only 'require' instead of 'use' Net::SMTP",
>> 2006-06-01) for Net::SMTP and 134550fe21 ("git-send-email.perl - try
>> to give real name of the calling host to HELO/EHLO", 2010-03-14) for
>> Net::Domain, both of which predate the hard dependency on 5.8.
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>  git-send-email.perl | 24 +++++++++++-------------
>>  1 file changed, 11 insertions(+), 13 deletions(-)
>>
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index 85bb6482f2..69bd443245 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -1143,10 +1143,9 @@ sub valid_fqdn {
>>  sub maildomain_net {
>>  	my $maildomain;
>>
>> -	if (eval { require Net::Domain; 1 }) {
>> -		my $domain = Net::Domain::domainname();
>> -		$maildomain = $domain if valid_fqdn($domain);
>> -	}
>> +	require Net::Domain;
>> +	my $domain = Net::Domain::domainname();
>> +	$maildomain = $domain if valid_fqdn($domain);
>
> Now that we indeed require the module, any reason not to 'use' it?
> E.g. is it particularly expensive to load?
>
> I haven't checked the assertions above about minimal perl versions
> including these modules, but I assume they're true. :)  So this looks
> like a good change.

FWIW this is easily found out for any given module by running `corelist
<module name>` on a system with perl installed:

    $ corelist File::Spec
    Data for 2017-01-14
    File::Spec was first released with perl 5.00405
