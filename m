Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 253C820136
	for <e@80x24.org>; Fri, 17 Feb 2017 18:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934386AbdBQSSt (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 13:18:49 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36473 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934053AbdBQSSt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 13:18:49 -0500
Received: by mail-pg0-f67.google.com with SMTP id a123so2732042pgc.3
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 10:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=e9SI8KL9VlX2Hxu+A82kiKOvpfIBdw9x8FaJZ72h9HU=;
        b=KGUixZH6bgqg0imdxT/DHUd+Pwky6uY/R2RJ3jiDSKoovU7vFeB8lP/sAxk3nfH1nQ
         UgScDwkveMnUZc9UOTnB7iWOWuk2X0vx441iY6dTRNDyGF7WSTowdsul2kk7/QcGhHUt
         /gDraR3439vpzZBMj9PeKc6snkdRPl/YPzd8ter3TticBT4iRprwBORp1a9dWxWn4Xfw
         HqPzlnfUsIZ0CrIa8d+Ke2jxj9k5ZW4/mgtpWFiYj4gihwo1DA8k6C8x/ybh+9fa0tKB
         s7Y2bKmlNuxPqhDsYVRMhAlFLWQzYs/0rr2vJAp8oBvgjTwkaQYGPdaugk4ZYS9bw4F+
         602g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=e9SI8KL9VlX2Hxu+A82kiKOvpfIBdw9x8FaJZ72h9HU=;
        b=CK0w65+4+ve4LEaA1ndc7ZKGRMyWQSw1Elimb0B13IJAz0O+hhoXj9EWRle3+PZJeI
         x18A+38tDnEzK24DYdae2YmnNpw2R6GUWItuX/Lnp6CE85cfRkLZIv5bbNsPIaPHT0X/
         BhLS43Z59Wt5ePi4le7meLCa8uaahrnJu3JZYWNDZ7sODz6Sgr+VWf3BLbtInohw3PHu
         FF7t8JyhdKvp1OpP9NximVjrBkUecXjEcela6PpOvrUOFWBHNuWfqCkPQph+53aEeq2N
         D84IJeBua2bN0s2CjkFyueplDPFFqD3ra6lF7sM7CL24o+l2Lkx7Sx4SAELbpRazH7sv
         lhSQ==
X-Gm-Message-State: AMke39mSOEvERAAXMb364qssh4XF1zRwRfT6Zeh6Hmc9Kt65rADKy2z7CYbLT3j/qGWAKg==
X-Received: by 10.84.136.7 with SMTP id 7mr13246569plk.100.1487355528276;
        Fri, 17 Feb 2017 10:18:48 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id 67sm20823316pfd.120.2017.02.17.10.18.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 10:18:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Johan Hovold <johan@kernel.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Kevin Daudt <me@ikke.info>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: body-CC-comment regression
References: <20170216174924.GB2625@localhost> <vpqlgt6hug6.fsf@anie.imag.fr>
        <20170217110642.GD2625@localhost> <vpq7f4pdkjp.fsf@anie.imag.fr>
        <20170217164241.GE2625@localhost> <vpq4lzs7o0s.fsf@anie.imag.fr>
Date:   Fri, 17 Feb 2017 10:18:46 -0800
In-Reply-To: <vpq4lzs7o0s.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
        17 Feb 2017 17:58:11 +0100")
Message-ID: <xmqqd1egu1dl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> On Fri, Feb 17, 2017 at 02:16:42PM +0100, Matthieu Moy wrote:
> ...
> If I had a time machine, I'd probably go back then and forbid multiple
> addresses there, but ...
>
>> There does not seem to be single commit in the kernel where multiple
>> address are specified in a CC tag since after git-send-email started
>> allowing it, but there are ten commits before (to my surprise), and that
>> should be contrasted with at least 4178 commits with trailing comments
>> including a # sign.
>
> Hey, there's a life outside the kernel ;-).
> ...
>>> 1) Stop calling Mail::Address even if available.[...]
>>
>> Right, that sounds like the right thing to do regardless.
>>
>>> 2) Modify our in-house parser to discard garbage after the >. [...]
>>
>> Sounds perfectly fine to me, and seems to work too after quick test.
>
> OK, sounds like the way to go.
>
> Do you want to work on a patch? If not, I should be able to do that
> myself. The code changes are straightforward, but we probably want a
> proper test for that.

The true headers and the things at the bottom seem to be handled in
a separate loop in send-email, so treating Cc: found in the former
and in the latter differently should be doable.  I think it is OK to
explicitly treat the latter as "these are not e-mail addresses, but
just a single e-mail address possibly with non-address cruft",
without losing the ability to have more than one addresses on a
single CC: e-mail header.
