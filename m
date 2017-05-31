Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67CCB1FD09
	for <e@80x24.org>; Wed, 31 May 2017 22:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751029AbdEaWjT (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 18:39:19 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33349 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdEaWjT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 18:39:19 -0400
Received: by mail-pf0-f196.google.com with SMTP id f27so4629691pfe.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 15:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3WTvQc0I8wN/wxXYLoL2FXfY2vYhAKBElAAqZ814KhQ=;
        b=Z5smr9Ty2+hsrx3ObDHtX3Sz2QPtJXHN3vFLCuOaBQYOpX15vSCeaRADWiGAaXM/Hl
         0ETmAfoF+FPlv7E014H8xq8k0D4s/5ABH9A/B52vQWxvrBgEomCXneJI66b9HPXewVbD
         rv2CG2MUxo3AsvK5V4ZpN/5ohuASRrdoN7BK4ZW3m4/16kZzJaXNDnPmKj+Rq/qkNrdf
         ku3dVI7CdIXG7wBA/tpgWF/q1gxwpGMEKXhzta89LF7vAx+5CNHQrMWgVPBUg1u/jt4N
         HtRuO9QyMBHHy2AjofJhzwQI2RasB2WHktyH8u6KIGTGdOXOrnECZtCV7QQ++NwDzuUc
         j4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3WTvQc0I8wN/wxXYLoL2FXfY2vYhAKBElAAqZ814KhQ=;
        b=h+Oog8zXpBDxO2yF+GqMRnWwf7LK51Mp3fLfcANBnO8p2pkSks2QcBIxCxVRQPGYoo
         0Mvu0ET8w9nYgrAaaRPfNuc5SxU75Fo3EUBPMC+WMU86UGx4xWcnEOcHHlGezbZcYvUB
         9pE6KCc17Gq46Ls3mCc47Dz+D9K3wTdGiWwur3nz4nwIoOCyNvONxWpMgjtJ1snKqAfb
         W9Kb2utXPHamql2nlVaQN9apBCXlQXf1Z5cLAHBzDQq295XY8C31UjPnAir2m5uTPK2b
         BgrKnADLQUGVefdzztcRMbEDowcfEsxX+2SQJszpWsFaTOyQImUdVkbgZWMRveWBwfJz
         LLpw==
X-Gm-Message-State: AODbwcD5atCBIjR9h+pr075KXUAFcl6Vg7+lPExTD/16eQO3f2NWzG3I
        8RFMgNgnm5eCcg==
X-Received: by 10.98.68.197 with SMTP id m66mr32846966pfi.80.1496270358292;
        Wed, 31 May 2017 15:39:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d156:5238:7809:132c])
        by smtp.gmail.com with ESMTPSA id o66sm30461984pga.64.2017.05.31.15.39.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 15:39:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v2] send-email: Net::SMTP::SSL is obsolete, use only when necessary
References: <CACBZZX5j1dYk8aeRED7T7iJ=b32aFUpfUWPpMpmtofBL3QnVXQ@mail.gmail.com>
        <20170324213732.29932-1-dennis@kaarsemaker.net>
        <20170531214634.GB81679@aiede.mtv.corp.google.com>
Date:   Thu, 01 Jun 2017 07:39:16 +0900
In-Reply-To: <20170531214634.GB81679@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Wed, 31 May 2017 14:46:34 -0700")
Message-ID: <xmqq7f0wabxn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Dennis Kaarsemaker wrote:
>
>> Net::SMTP itself can do the necessary SSL and STARTTLS bits just fine
>> since version 1.28, and Net::SMTP::SSL is now deprecated. Since 1.28
>> isn't that old yet, keep the old code in place and use it when
>> necessary.
>
> This broke git send-email for me.  The error message is
>
>   Can't locate object method "starttls" via package "Net::SMTP" at /usr/lib/git-core/git-send-email line 1410.
>
> Is 1.28 the right minimum version?
>
>   $ perl -e 'require Net::SMTP; print version->parse($Net::SMTP::VERSION); print "\n"'
>   2.31
>   $ grep VERSION /usr/share/perl/5.18.2/Net/SMTP.pm
>   use vars qw($VERSION @ISA);
>   $VERSION = "2.31";
>   $ grep starttls /usr/share/perl/5.18.2/Net/SMTP.pm
>   $ dpkg-query -W perl
>   perl    5.18.2-2ubuntu1.1
>
Thanks.  

Let's revert the merge for now until we know (this time for certain)
what the minimum version is.
