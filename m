Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03DD0202A7
	for <e@80x24.org>; Wed,  5 Jul 2017 17:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbdGERAR (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 13:00:17 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35774 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbdGERAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 13:00:16 -0400
Received: by mail-pg0-f65.google.com with SMTP id d193so14541945pgc.2
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 10:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qF8Ygy4JYE00vLpjyVTLm+3WfCOyTDLLu6AN0K2mnL0=;
        b=uo3ceNqgUyYfCZm3maxsGJVqhVe7XKKG5hcjCpXQGwM4aEatIaD3H05ObutA9fKeLS
         zNW067/501IAaV1GDv1hR4dv4RkW2c45Vo+cPXTlCLn+VckunsOelB5JfTiv4e4ddX8k
         HS/ytVYKptTL1RcH5ODsm7f7iIv23v70av0YJ6oGEKfNk5Fvm3sbRAHTRgmeS4RK/mD+
         fCXUEf/6HFh1nINTSMy4o2EfwPlG0Sd/QBqc1wkWSsdScgQgQNPdALHzdvUuky+ONjQS
         1ynfdhvpRUx9pHzYR3j87mzBaHoqLZHoRhDKaE4QN66OfV/yzMRJwStNSl0dEfUocxuB
         gA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qF8Ygy4JYE00vLpjyVTLm+3WfCOyTDLLu6AN0K2mnL0=;
        b=KAqZI1nmvlZq3FDXQaQZPVuPcjmo4BH9wNl/72apN1E9nkkh902CFrezP/cpLdTJ5b
         VQg8rclj2YteUOoUIE8/J6oLUnKg5IxJvfmzSFK4gDahqcdBQ4F3zgtikstK+bUAlXW7
         3RaIiUxtAvU0uAamKQHFpMuKuF2D+jhCsfBYc0L48bba8ooEKm8nUiONTYT8qzsABeUP
         1dikEYnVpnQugQmnYCWqjtvZaILtIHG3U6skdg+rMQ8clkjWwJIR012iLY1TGaSippXf
         ni1UDzIuDeQvFA2hEH6W6vrRUSAz+Pu397+YtwzWX7vy480CHq0tcVp9u1ps6qP85IDs
         hsmg==
X-Gm-Message-State: AIVw110jhv+a/rkPZh4ewzwlVmEl94hhaHnRXAdAn2vDOf6dUjv9fwi/
        0DEP+Ul4homjoQ==
X-Received: by 10.99.114.73 with SMTP id c9mr21316146pgn.267.1499274015065;
        Wed, 05 Jul 2017 10:00:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ad13:9505:c2bc:e887])
        by smtp.gmail.com with ESMTPSA id s66sm51997245pfg.21.2017.07.05.10.00.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Jul 2017 10:00:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Requesting suggestions for a good sample "prepare-commit-msg" hook
References: <1499273152.16389.2.camel@gmail.com>
Date:   Wed, 05 Jul 2017 10:00:12 -0700
In-Reply-To: <1499273152.16389.2.camel@gmail.com> (Kaartic Sivaraam's message
        of "Wed, 05 Jul 2017 22:15:52 +0530")
Message-ID: <xmqqwp7miztv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> So, we're searching for scripts that
> could both be  helpful to users and could serve as a good sample to
> prove what could be done using the hooks.

I am not so sure that we are searching for them, to be honest (who
are we in this context anyway?)  

This sounds like a solution looking for a problem to me.  The
simplest option may be to remove the sample hook---perhaps it
outlived its usefulness.
