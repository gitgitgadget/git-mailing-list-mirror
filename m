Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5927B20401
	for <e@80x24.org>; Wed, 21 Jun 2017 18:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751922AbdFUSez (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 14:34:55 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36611 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750992AbdFUSez (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 14:34:55 -0400
Received: by mail-pf0-f193.google.com with SMTP id y7so32298935pfd.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 11:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Wm+f/xR007Qe1hy159R07te63h634YAG7A63L7wKebo=;
        b=ILPQoBzKa88y/5KuKAz2XkQQahc3gPsDNXcB0HpvRa+45+ixaOYMa5c4uPSJMp+tDu
         d5BuLJgW8BYaR/eQCgkcunCQv/HTNIWuhtMb9bk7SMQFLxN5WsFT/1zyhjVIOgxCow31
         Cfe3Vuu382/feRiT5B6hg+ABJ84icLd1pmjuyo1vP0ljz9NCzdMZWgZtq+6g8Ew+Wvvg
         0M++6pwnU/UEAZOABdvUrKrTQYWUcS2km3GjZbDfG2Tf50WziOl5vNxSFAUsYY/AFJHO
         ok6i4IJf947JpwlqbD5ulkDYEkx3PXGoE0wq26MePKFHhyS1ONmw5I25hPCCidP4lazP
         rF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Wm+f/xR007Qe1hy159R07te63h634YAG7A63L7wKebo=;
        b=XKtgbx56Oq0yfyfOOXkKsOhytMkhfVMnMMjaDp8TQWwuboPttRpK7QPr7Wzz+Adtwg
         8ImT+u5jnu7exFtahQir/2Ec2lVB4pL/5UFCQEM1QwVaByFCJGjXv4OncekDlALKBouw
         4NeQdN12/6ktwdFyHk0jqjBdXWRDlAv8DE6FMxbI3DVNecXSB3XkKhOKQAI1kl3InKT3
         4bgibQZW1fVe94rMfBNPUv47zoAjg3+R+hegc1lRw7qv815PhhLJVNDsq1tTZjgy79Qa
         Xx+eRqTM0el4x+DKUhHTnMwgpRPHFbKwKkUzWNDK91G1e1eTul6av8db6Pe7KUl1nFZJ
         TxSw==
X-Gm-Message-State: AKS2vOx2Pq7t4yCXzfwVr9GaxbXagh2pjERE+E0olK0HLIGMpcJH+r7N
        jmksI9//QJo9fg==
X-Received: by 10.99.97.76 with SMTP id v73mr33513445pgb.188.1498070094382;
        Wed, 21 Jun 2017 11:34:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id i14sm34629078pgn.14.2017.06.21.11.34.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 11:34:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Does 'git config' accept the '--remove' option?
References: <1498068738.32360.7.camel@gmail.com>
Date:   Wed, 21 Jun 2017 11:34:51 -0700
In-Reply-To: <1498068738.32360.7.camel@gmail.com> (Kaartic Sivaraam's message
        of "Wed, 21 Jun 2017 23:42:18 +0530")
Message-ID: <xmqqzid1p4tw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> I recently noticed that when I run 'git config' with the '--remove
> <non_existing_section>' I get a warning that section doesn't exist.
> When I scrolled through the man page of git-config I could see any
> mention about the '--remove' option. I only see that there is a '
> --remove-section' option. Sample output,
>
>> $ git config --remove test
>> fatal: No such section!
>> $ git config --remove-section test
>> fatal: No such section!
>
> Is this a bug (or) is the documentation stale ?

Neither, I would say.  I think that you would get exactly the same
behaviour from 

    $ git config --remo test
    $ git config --remove-sec test

These are merely "unique prefix can be abbreviated in option names"
kicking in, I think.


    
