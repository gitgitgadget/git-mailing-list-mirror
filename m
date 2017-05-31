Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A01C51FD09
	for <e@80x24.org>; Wed, 31 May 2017 23:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751106AbdEaXCB (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 19:02:01 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34961 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbdEaXCA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 19:02:00 -0400
Received: by mail-pf0-f196.google.com with SMTP id u26so4698510pfd.2
        for <git@vger.kernel.org>; Wed, 31 May 2017 16:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=md+Bf/EzjctTwQzd+xsXRHSH+mkmNEHrgoUA4JGtu5E=;
        b=XoTETtz88QY60xA367AagSDJulI8HNNgy+QxpkUEtpUo40S0vtK4RwtBc12NfQGg0L
         Lu2jFOMlZ6vejbxsv1OnqY0T+SD0XX9wPrm/lXNEpWn2IAUK23A+Z/HU+E4N7MgYI6k8
         6iN28a8LAHOXKWYOekLNBJldPVttEQiE+YkQTZd20gfcWo7g8QAzqhANlM6h9dzOJHR8
         1OB4tuHsvVgAM1x5BLNqsGpooZTwHE2Zp7WtAaiSaxCtqSH8RZ4xxnMEaQufJEFN976n
         BpQ7oiCm5xwU//yGreb7kQU633Gh3hVG4OXixezX5Vjrhl/gdGYdyNShM9uNWcPzlNXE
         1Lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=md+Bf/EzjctTwQzd+xsXRHSH+mkmNEHrgoUA4JGtu5E=;
        b=Eqjg49IS7G+0BS3QcFBheZvHPM2A/AHK8FfYajTpSByZ0u6T/Xe0C/JQ/R6q23cHME
         R1thGpPaaqBCfIA7G+CexH8rTS+esHXQJ+fguwzmNWSBgqZeklbRUnxAZ+Zta01UQurg
         ltT5H8GvlusYAJZpp9PJEQ2Z9yQR3y1jTgyL+89zg11M/a/5Q3Yml+VgEeQcL//1awqb
         AF63eMwL+xV/CXfEaOPWhjtmvLZLMUnOtRl7P+5cmYZCGl66rO8yUg//8yFpyX3FHMLJ
         PbdQJqmJidmllE/Z4Ro7/hCSnZjN6rQ4RWST+rSLWALUhykbuf5O78c7bqwZcG0x4v/k
         NpdQ==
X-Gm-Message-State: AODbwcCzQmVpfImDppuN7y2gPgcrv9R7Jk5TJhEqHUFkJLGIGBq+lKBr
        qIhKy6CKS1O23w==
X-Received: by 10.99.54.141 with SMTP id d135mr35879986pga.85.1496271719581;
        Wed, 31 May 2017 16:01:59 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:6469:e172:b5f4:6d97])
        by smtp.gmail.com with ESMTPSA id 192sm27025784pfb.10.2017.05.31.16.01.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 16:01:58 -0700 (PDT)
Date:   Wed, 31 May 2017 16:01:56 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     git@vger.kernel.org, Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Brandon Williams <bmwill@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: Net::SMTP::starttls was introduced in v3.01
 (Re: [BUG] git-send-email broken: Can't locate object method "starttls")
Message-ID: <20170531230156.GE81679@aiede.mtv.corp.google.com>
References: <20170531222455.GD72735@gmail.com>
 <20170531224415.GC81679@aiede.mtv.corp.google.com>
 <20170531225708.GE72735@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170531225708.GE72735@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Biggers wrote:
> On Wed, May 31, 2017 at 03:44:15PM -0700, Jonathan Nieder wrote:

>> Subject: send-email: Net::SMTP::starttls was introduced in v3.01
>>
>> We cannot rely on the starttls method being present in the copy
>> of Net::SMTP shipped with perl until v5.21.5~169 (Update libnet to
>> CPAN version 3.01, 2014-10-10).
>>
>> Reported-by: Brandon Williams <bmwill@google.com>
>> Reported-by: Eric Biggers <ebiggers3@gmail.com>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> ---
[...]
>> +++ b/git-send-email.perl
>> @@ -1354,7 +1354,7 @@ EOF
>>  		}
>>  
>>  		require Net::SMTP;
>> -		my $use_net_smtp_ssl = version->parse($Net::SMTP::VERSION) < version->parse("1.28");
>> +		my $use_net_smtp_ssl = version->parse($Net::SMTP::VERSION) < version->parse("3.01");
>>  		$smtp_domain ||= maildomain();
>>  
>>  		if ($smtp_encryption eq 'ssl') {
>> -- 
>
> Yes, that solves the problem for me.

Thanks.  Mining through https://github.com/gbarr/perl-libnet, I find

  $ git log -Sstarttls
[...]
  commit b4a7a274a7fe5344c154abc4b3fdd7c446d36370
  Author: Steffen Ullrich <Steffen_Ullrich@genua.de>
  Date:   Fri May 9 23:15:48 2014 +0200

      SSL and IPv6 support for Net::SMTP
  $ git show b4a7a274a7fe5344c154abc4b3fdd7c446d36370
[...]
  diff --git a/Net/SMTP.pm b/Net/SMTP.pm
  index 705b5c5..fcc124f 100644
  --- a/Net/SMTP.pm
  +++ b/Net/SMTP.pm
  @@ -18,7 +18,31 @@ use Net::Config;
 
   $VERSION = "2.33";
[...]
  $ git log -p --ancestry-path b4a7a274a7fe5344c154abc4b3fdd7c446d36370..HEAD  -- Net/SMTP.pm
[...]
  commit 67b37d5c7118f9af50e5a5a00c242992caba3b8d
  Author: Steve Hay <steve.m.hay@googlemail.com>
  Date:   Mon Jun 2 14:13:55 2014 +0100

      Bump $VERSION in changed modules

  diff --git a/Net/SMTP.pm b/Net/SMTP.pm
  index 4496f6f..9dfaadf 100644
  --- a/Net/SMTP.pm
  +++ b/Net/SMTP.pm
  @@ -16,7 +16,7 @@ use IO::Socket;
   use Net::Cmd;
   use Net::Config;
   
  -$VERSION = "2.34";
  +$VERSION = "2.35";
   
   # Code for detecting if we can use SSL
   my $ssl_class = eval {

I think 2.35 is the correct minimum version.

Jonathan
