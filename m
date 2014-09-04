Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 28672 invoked by uid 107); 4 Sep 2014 08:35:30 -0000
Received: from Unknown (HELO cloud.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Sep 2014 04:35:30 -0400
Received: (qmail 31677 invoked by uid 102); 4 Sep 2014 08:35:12 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by cloud.peff.net (qpsmtpd/0.84) with ESMTP; Thu, 04 Sep 2014 03:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756227AbaIDIec (ORCPT <rfc822;peff@peff.net>);
	Thu, 4 Sep 2014 04:34:32 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:63113 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756201AbaIDIeb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 04:34:31 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1XPSUu-000DNw-JC
	for git@vger.kernel.org; Thu, 04 Sep 2014 10:34:28 +0200
Received: by mail-pa0-f47.google.com with SMTP id hz1so19510381pad.6
        for <git@vger.kernel.org>; Thu, 04 Sep 2014 01:34:20 -0700 (PDT)
MIME-Version: 1.0
X-Received: by 10.70.91.208 with SMTP id cg16mr1298459pdb.91.1409819660051;
 Thu, 04 Sep 2014 01:34:20 -0700 (PDT)
Received: by 10.70.10.5 with HTTP; Thu, 4 Sep 2014 01:34:20 -0700 (PDT)
In-Reply-To: <xmqq7g1kxzxi.fsf@gitster.dls.corp.google.com>
References: <1409753034-9459-1-git-send-email-johan@herland.net>
	<1409753034-9459-3-git-send-email-johan@herland.net>
	<xmqq7g1kxzxi.fsf@gitster.dls.corp.google.com>
Date:	Thu, 4 Sep 2014 10:34:20 +0200
Message-ID: <CALKQrgcdEMcFWhT7ZSKYR23QL7=_CKXRKxwZ_nOCSzRzPk0TGg@mail.gmail.com>
Subject: Re: [RFC/PATCH 2/3] revert/cherry-pick: Add --no-verify option, and
 pass it on to commit
From:	Johan Herland <johan@herland.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git mailing list <git@vger.kernel.org>,
	=?UTF-8?Q?Lars_Gullik_Bj=C3=B8nnes?= <larsbj@gullik.org>,
	Neil Horman <nhorman@tuxdriver.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Sep 3, 2014 at 9:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>> diff --git a/builtin/revert.c b/builtin/revert.c
>> index f9ed5bd..831c2cd 100644
>> --- a/builtin/revert.c
>> +++ b/builtin/revert.c
>> @@ -91,6 +91,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>>                       N_("option for merge strategy"), option_parse_x),
>>               { OPTION_STRING, 'S', "gpg-sign", &opts->gpg_sign, N_("key-id"),
>>                 N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
>> +             OPT_BOOL('n', "no-verify", &opts->no_verify, N_("bypass pre-commit hook")),
>
> I doubt we want this option to squat on '-n'; besides, it is already
> taken by a more often used "--no-commit".

Oops. I never meant to squat on '-n'. Will fix in re-roll.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
