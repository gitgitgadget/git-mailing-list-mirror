Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 044AC2036D
	for <e@80x24.org>; Wed, 22 Nov 2017 01:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751504AbdKVBPf (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 20:15:35 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:45063 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbdKVBPf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 20:15:35 -0500
Received: by mail-it0-f45.google.com with SMTP id x13so4298011iti.4
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 17:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SgPhEz2D8ONpETL676s8Zn+0W9mq7gFUs0WIySoFanE=;
        b=QkjXbgDQBDv4DnHrpWud/WpW00WFycV8BVVIYu/we5O22cJLjeIafk+TOaYNQQD8Fi
         hvlN9j0rQNiPUG3bw4OvKiSRyIKP73ZDt4vd0pTe8/8h7OP0EEVp7zqdJPPA9le9gU7x
         9euIBQihMdBkfTqk04yCSvxyAxVt5MUDKtSzaB+jx2uIGTMa8g2TcyTd+665og/UEmn+
         Mx921KK/4kjM+04pICbccAmgYBbp+7kWh6pR5xCYaUPNOIOkFdtBsqfujrhFUNaIKXlA
         DqU6UucGngQa5WvW+d9n7dKWsDy2YTgwAEye+ux87rmuBZExOkxVyNSbv2BAnU2oVzTY
         6Ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SgPhEz2D8ONpETL676s8Zn+0W9mq7gFUs0WIySoFanE=;
        b=hv4wDFemEF6FyDqfmSxStaH0gFyj7frMmL/zPmXziu7Ow9zKqsD/XLq/VEKucuSdkW
         p8bGVJGes2vr+v00/V90cRzeOiRJfxuWSnquzZOBmlDr61tvFO123k/dieIWt4Nr+WCZ
         K8reqBFOFHJxBOFyZ4ORT49CNCBdiifZ8E9jPzPWaCg9YlqoYDRuLcBjn/WnZJP9/NeH
         6RLZN/AV+MX4h8s+OYMW6W6mmKI03hzv18mBa67ao2rsFo/GUf13rVI+QTTpm6D2G5Uq
         vN7Xjglo4N8XOP2f15EPKJQEKLYMq7rw+9LS5etr+OVKSr9RS7gONKPN47rmIbHie3Q0
         /NHg==
X-Gm-Message-State: AJaThX4ZUKP+JqYUbGSkPnfKu6ueGpCzT8m1pnTqQI537JK2lch45iKO
        aic2CyK8ifeZuV7DfX8PbQ8=
X-Google-Smtp-Source: AGs4zMYPyBuoHEWayPldxPRwbif6xXJtQuzX370+pcHGwpz5s+DUhSmV3veBNxr7S32BD5LSbFALsQ==
X-Received: by 10.36.200.138 with SMTP id w132mr4508824itf.24.1511313334323;
        Tue, 21 Nov 2017 17:15:34 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id m72sm6019073ioe.40.2017.11.21.17.15.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Nov 2017 17:15:33 -0800 (PST)
Date:   Tue, 21 Nov 2017 17:15:31 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Anders Kaseorg <andersk@mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Documentation: allow overriding timestamps of
 generated asciidoc
Message-ID: <20171122011531.GQ3429@aiede.mtv.corp.google.com>
References: <20171121232935.GM3429@aiede.mtv.corp.google.com>
 <20171121233432.GN3429@aiede.mtv.corp.google.com>
 <20171122005433.kwv4bin6y65xuxm5@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171122005433.kwv4bin6y65xuxm5@genre.crustytoothpaste.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

brian m. carlson wrote:
> On Tue, Nov 21, 2017 at 03:34:32PM -0800, Jonathan Nieder wrote:

>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> @@ -410,6 +410,7 @@ $(patsubst %.txt,%.texi,$(MAN_TXT)): %.texi : %.xml
>>  howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
>>  	$(QUIET_GEN)$(RM) $@+ $@ && \
>>  	'$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(wildcard howto/*.txt)) >$@+ && \
>> +	$(if $(SOURCE_DATE_EPOCH),touch -d '@$(SOURCE_DATE_EPOCH)' $@+ &&) \
>
> touch -d @SECONDS isn't POSIX compliant, and non-Linux systems don't
> provide it.  POSIX only allows certain fixed format, and I assume that
> non-Linux parties (maybe OpenBSD) will want to have reproducible builds
> as well.

Interesting.  My knee-jerk preference is still to go with this patch
as-is for now, since the non-portability only triggers when
SOURCE_DATE_EPOCH is set.

> It's unfortunate for shell users that this variable is in seconds from
> the epoch, since there's no portable way to format such a time in shell.
> (POSIX doesn't allow date(1) to format anything but the current time.)
>
> My proposed solution was to use Perl to do so, and simply require that
> if you wanted a reproducible build, then you had to have Perl.  That
> would, of course, require a separate variable in the Makefile holding
> the formatted date.
>
> Maybe something like the following in the Makefile:
>
> ifndef NO_PERL
> SOURCE_DATE_TIMESTAMP=$(shell perl -MPOSIX -e 'print strftime("%FT%TZ", gmtime($ENV{SOURCE_DATE_EPOCH}));')
> endif
>
> and then:
>
> +	$(if $(SOURCE_DATE_TIMESTAMP),touch -d '$(SOURCE_DATE_TIMESTAMP)' $@+ &&) \

Neat.  I can play with this a little.

http://asciidoc.org/CHANGELOG.html is stale but asciidoc still seems
to be getting changes at https://github.com/asciidoc/asciidoc.  I
wonder how difficult it would be to add any required SOURCE_DATE_EPOCH
support there.

Longer term, I wonder what it would take to move to a markup language
that is more widely known, like commonmark.

Thanks,
Jonathan
