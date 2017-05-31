Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E66E1FD09
	for <e@80x24.org>; Wed, 31 May 2017 22:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751029AbdEaWvi (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 18:51:38 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35010 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbdEaWvh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 18:51:37 -0400
Received: by mail-pf0-f193.google.com with SMTP id u26so4654136pfd.2
        for <git@vger.kernel.org>; Wed, 31 May 2017 15:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/F0FP8iEl19aMpxd8b29Uj4iLhO1SqPHSVffoCresdg=;
        b=ThRXkWuyMPDGQIn5u6XrFrdtFd+2cOX+YTzrVOswGgN/3gPmriH0xS5v37WNpkF1+G
         dw3rcMHf3odyW0QkC+Z5RcwWfmuZg2wQSrpOiW0F8bKGLyqhn1jRPzA6UapzXzCIGW5G
         b5YrgoJNJLUBoR6HOyS+JOM8OCq2CXiBWC1Da08LqLlOKIbaKRh3LY36udySdvK4EeyC
         kDBm1uUClrftv9SfdZqXrhAr++01kBHIzMsKrPwOQZ4bjE+k11SmJ1wLfE8Dgp2RsPdd
         o1g8pk6clm9e13ONwIyQ3GGvF1EmdEgyey6ArgWHPQ4sWApJYDHAZGIS10+zASaxh7f5
         IHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/F0FP8iEl19aMpxd8b29Uj4iLhO1SqPHSVffoCresdg=;
        b=Hl0iUQRUv5vfQpFS1K6matFgjd63e+Tq4qGrZjlPeqCooa8hm0W15yB6IPKR5WXIqQ
         8Zicmi8ZspHO9kVEUn2DX58Gnj+ZUehJI+tbjEnmu44UbQb+tK2TZE49AT3bOkhB/N3x
         IOJK9qDOPgAwWjdP1sQ7osK5TNGW0GF7whrURJMZ2CV1YboTR6sdnhCm8GIiBLboCUoQ
         3FEPxG/8K1Cn6lhaHKUC6IQt3EeW/PpVSztptaUgKXEZrHN98OKWEitGKfxPoUpbdHe7
         xhBPdxO4NyPGqN66RSdP2V0hcGuxPNbZT4xMQxDtvwHJO+dsa2OkgiIZ22bqAKQ05LPm
         YD9g==
X-Gm-Message-State: AODbwcDf8nrseIgHt6pI27uCuOspKOMMbJBmAhLi+SKjmu3NbFtiNgXk
        qmGrjLTuHdWFBA==
X-Received: by 10.98.201.15 with SMTP id k15mr33015375pfg.14.1496271096912;
        Wed, 31 May 2017 15:51:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9c1c:dca9:c6e3:133e])
        by smtp.gmail.com with ESMTPSA id q9sm27323719pfg.77.2017.05.31.15.51.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 15:51:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Eric Biggers <ebiggers3@gmail.com>, git@vger.kernel.org,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Brandon Williams <bmwill@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] send-email: Net::SMTP::starttls was introduced in v3.01 (Re: [BUG] git-send-email broken: Can't locate object method "starttls")
References: <20170531222455.GD72735@gmail.com>
        <20170531224415.GC81679@aiede.mtv.corp.google.com>
Date:   Thu, 01 Jun 2017 07:51:35 +0900
In-Reply-To: <20170531224415.GC81679@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Wed, 31 May 2017 15:44:15 -0700")
Message-ID: <xmqqy3tc8wso.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Subject: send-email: Net::SMTP::starttls was introduced in v3.01
>
> We cannot rely on the starttls method being present in the copy
> of Net::SMTP shipped with perl until v5.21.5~169 (Update libnet to
> CPAN version 3.01, 2014-10-10).
>
> Reported-by: Brandon Williams <bmwill@google.com>
> Reported-by: Eric Biggers <ebiggers3@gmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Hi Eric,
>
> Eric Biggers wrote:
>
>> There seems to be a bug in 'git send-email' caused by this commit:
>>
>>     commit 0ead000c3aca13a10ae51a3c74c866981e0d33b8
>>     Author: Dennis Kaarsemaker <dennis@kaarsemaker.net>
>>     Date:   Fri Mar 24 22:37:32 2017 +0100
>>
>>         send-email: Net::SMTP::SSL is obsolete, use only when necessary
>>
>> When running git send-email I get the following error:
>>
>> 	Can't locate object method "starttls" via package "Net::SMTP" at /usr/lib/git-core/git-send-email line 1410.
>>
>> The perl version is 5.18.2, and the Net::SMTP version is 2.31.
>
> Thanks for reporting.  Does this patch help?

Good, you beat me to it ;-)  Once we get this confirmed, let's queue
an emergency fix.

Thanks.

>
> Regards,
> Jonathan
>
>  git-send-email.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 0d90439d9..3441e3cf5 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1354,7 +1354,7 @@ EOF
>  		}
>  
>  		require Net::SMTP;
> -		my $use_net_smtp_ssl = version->parse($Net::SMTP::VERSION) < version->parse("1.28");
> +		my $use_net_smtp_ssl = version->parse($Net::SMTP::VERSION) < version->parse("3.01");
>  		$smtp_domain ||= maildomain();
>  
>  		if ($smtp_encryption eq 'ssl') {
