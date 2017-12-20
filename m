Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA0881F406
	for <e@80x24.org>; Wed, 20 Dec 2017 06:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754150AbdLTGPv (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 01:15:51 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:45972 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754133AbdLTGPu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 01:15:50 -0500
Received: by mail-qk0-f172.google.com with SMTP id o126so12974430qke.12
        for <git@vger.kernel.org>; Tue, 19 Dec 2017 22:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SD5sV2KlBRd7RKn+Z4bEPvPM/mkguPiheA2fdtLQG5A=;
        b=acFtpHz6D0QQ/GR8otQP14HV3dFkTPBn7htDbwIn7knoFg4vwwdWtb6jfP8BlzFxPz
         yNephhVzbRMK6cZ+rNVdA4ERWT+Tf/iZMrm7pUAC6WoHqb05+OqQ9cWHL5c3kwrTikRI
         8RIYkJ5RJkCEqPUyf6MwuMtuAQH7DSj/3WaohKeakGfZO+d0cSofoCog3nWyybEFxrTw
         W6JUNyIGSA8xlmTkRbIL47daB9iSrqqEq6rOYT1TLPcLWwHG1srr+R3bTZiHTiaXS+90
         1YoKqMmH2IKd5lBoU6wjrj6sUC4CwWKMkhNDm8TsxCPxfwm+l3ZTl/Mb2gftrtGvM4K3
         5+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=SD5sV2KlBRd7RKn+Z4bEPvPM/mkguPiheA2fdtLQG5A=;
        b=JA75EgjHCvMThe4o5ywjaEp8afElCGLaVyDm9T6l2Ynke2nmpaJzSkmchOZ0lLZM93
         cU0M2cxNHv0Lay7f5MncOqLevZmc7jM7EeXtTSOTzvh3tJPU0AoqHg//nyfn9KhZKRtI
         g2OXe+8SARhKIT0OCIxSXIO8Y/03xRACvfYTsBhV5RH7YGhpic1fKjaS5toQaghWvgJ5
         hgChyN75O/6NZOjq/oqBbKpcGine8gvi5eeQchVVi+7GVyMzMNljIvIvAOdVf4O+SKJ1
         +roRt3zupBEPa2ifh5okAaWB48Z/j+ZJwhxpmRwX0Stde4Lf2lh2TowryrNdjaKDyGx9
         9SAg==
X-Gm-Message-State: AKGB3mISjAvzq6oY83IpYGp9umeeN4SCIZPeeUd+izqL8aXmCTgwOZvU
        TkBs9UCrej5C2KgE1dTdFes=
X-Google-Smtp-Source: ACJfBos2jNhBAJIAmk0Kb5OHWy+QOdbWCv5b1Bid7lkIzdnCmlqs1ZngaRJnKu64aJ9b+UiEXvr7nA==
X-Received: by 10.55.165.213 with SMTP id o204mr4808488qke.300.1513750549670;
        Tue, 19 Dec 2017 22:15:49 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id q12sm10767306qtk.32.2017.12.19.22.15.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Dec 2017 22:15:47 -0800 (PST)
Date:   Wed, 20 Dec 2017 01:15:45 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Alex Riesen <alexander.riesen@cetitec.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Casey <drafnel@gmail.com>, Petr Baudis <pasky@ucw.cz>,
        Gerrit Pape <pape@smarden.org>,
        "martin f . krafft" <madduck@madduck.net>, Eric Wong <e@80x24.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>,
        Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH v4] Makefile: replace perl/Makefile.PL with simple make
 rules
Message-ID: <20171220061545.GF3693@zaya.teonanacatl.net>
References: <xmqqy3lyww6r.fsf@gitster.mtv.corp.google.com>
 <20171219235759.27570-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171219235759.27570-1-avarab@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

Ævar Arnfjörð Bjarmason wrote:
> Here's a hopefully final version. The only difference with v3 is:
> 
>     -    local @_ = ($caller, @_);
>     +    unshift @_, $caller;
> 
> As it turns out localizing @_ isn't something that worked properly
> until
> https://github.com/Perl/perl5/commit/049bd5ffd62b73325d4b2e75e59ba04b3569137d
> 
> That commit isn't part of the 5.16.3 version that ships with CentOS 7,
> which explains why Michael J Gruber had issues with it. I've tested
> this on CentOS 7 myself, it passes all tests now.

Thanks for tracking this down!

FWIW, I applied this version to next and tested it with
CentOS 6 and 7.  The tests pass on both (though there are
some unrelated failures on CentOS 6 in t5700-protocol-v1,
which I haven't looked into further yet).

I also applied this patch to 2.15.1 and ran the tests in the
Fedora build system for all fedora and epel releases, which
also passed (though with some spurious git-svn failures on
x86_64 in fedora 28, AKA rawhide).

The .pmc extensions seem to cause rpm to fail to parse the
files for rpm 'provides' as it normally would.  This causes
scripts like git-send-email which generates a 'requires' on
Git::Error to fail to find anything which provides it.

I'm not familiar with the .pmc extenstion.  Searching the
fedora repositories, there is only one other package - and
one file within it - which has a .pmc extension.

(The package is perl-test, the file is
/usr/libexec/perl5-tests/perl-tests/t/run/flib/t2.pmc.)

Perhaps it's a bug in rpm's perl dependency generator, but
I'd like to think that git wouldn't be the first package to
find it.

Is the .pmc extension important to ensure these files are
loaded in the right order?  Since they're all in the Git
namespace, I don't imagine there should be anything else in
@INC which would be provided by the system or another
package.

Pardon my ignorance if I've missed the obvious (I haven't
fully read "perldoc -f require" which you referenced in the
commit message).

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Suppose I were a member of Congress, and suppose I were an idiot. But,
I repeat myself.
    -- Mark Twain

