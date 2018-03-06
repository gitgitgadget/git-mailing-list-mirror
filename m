Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8FA31F404
	for <e@80x24.org>; Tue,  6 Mar 2018 21:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753926AbeCFV2q (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 16:28:46 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39014 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753805AbeCFV2p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 16:28:45 -0500
Received: by mail-wm0-f65.google.com with SMTP id i3so873553wmi.4
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 13:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5rTLO+9iVX058LD+VOTDQI5/5+IEpkVjDfNdbHSxrUQ=;
        b=O8onxFNMUJ4iWEJGCeBUV9iYbd8RqZM77bLm4nDce0c4E89j51hSdy49Rcp3QXSMl5
         pUBi9/huwTYq25xFyLNy90QNnmqvVfZYOcbIRE4PLKWzqLTADXiBDmGYMyIpzOPxZG2f
         lA/8QE+OUWfXXrJFCzNguW6RN6vOHeb6U6wvbeVs4Oxu9w1qj0tyHT7EYD9LW5RctBtN
         1GcdxtC7wKhAtd6JZL+SzWqAs3dGQg8JOIClJtcYL38J8e1pmZQflu7oar6ZZQi6rLAm
         IES7eRkgbNgAe6uyEzA2ROdLnZe3ULps095s8wmP/pwod29EAlaa71BRaM/0PSUe2oE+
         cZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5rTLO+9iVX058LD+VOTDQI5/5+IEpkVjDfNdbHSxrUQ=;
        b=ln171+apvn++WyNR+vA4yI54SrdjwYdi1W1ON20L5LOV/0MZXN4OE7K4jd/rVNAXo3
         xk+vWGX9R1sND5oAVPA7oEduQIospwSaYo1czOiuXIi+Qgq7aVUbw2lSjGZVZpwNrUE9
         RIMWqehx8JkInFsvo8q0SSOib1Bw8Y0qwVo9yi+ZUL3IkxtLgidazA2V32eCRc8hCqup
         9zA8UfsB2P/pdLn+/M6sQ6ub6UcOVg7y9wurkwi5ZWR0bqsODcisT++KGAa7LEfQisQU
         ihtcgFBcb4jdp6V4i/6dzfpgLkdzka3HidXA7uVYeH9H2Q9dOB7EzZQ2eKwH9b89vE6a
         AeBw==
X-Gm-Message-State: AElRT7Hkw4e5HlEk8/Qj3o+jaNDnDGGiGUhs2HjrCuqOmewK3dtH0NsV
        KYsbVdYkB8KYj2uPeJAVl/w=
X-Google-Smtp-Source: AG47ELv3tm2pzJdtpZrmOB3yC/OOTYN0z6KiUunYxsRRI9N2O5uzqts0F2+x3v+UQYdk1FASLb5vMA==
X-Received: by 10.28.241.15 with SMTP id p15mr11892323wmh.42.1520371724051;
        Tue, 06 Mar 2018 13:28:44 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c14sm14884270wrd.17.2018.03.06.13.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Mar 2018 13:28:43 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v4] Make options that expect object ids less chatty if id is invalid
References: <20180306193116.23876-1-ungureanupaulsebastian@gmail.com>
        <xmqqlgf43nxo.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 06 Mar 2018 13:28:42 -0800
In-Reply-To: <xmqqlgf43nxo.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 06 Mar 2018 13:16:03 -0800")
Message-ID: <xmqqh8ps3ncl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I kind of find it surprising that the one single case I happened to
> have noticed is the only one that needed special treatment.  Did you
> go though all the codepath and made sure that the ones that still
> return -1 (not -2 and not -3) to parse_options_step() are all OK (in
> other words, I was just lucky) or does this version change only the
> "ambiguous" case, simply because that was the only one I noticed in
> my review (in other words, this may still not be sufficient)?
>
> Just double checking.
>
> The changes to existing tests have become a lot less noisy, compared
> to the previous one, which is probably a good thing.

I guess I should stop reading my inbox in reverse order.  In your
reply to my v3 review you said you studied all the codepaths from
parse_short_opt() and parse_long_opt() and addition of -3 was needed
only for the "ambiguous" case, so the answer to my question above is
"I was just lucky and happened to have hit the only problematic
case" ;-)

Will revert what is in 'next' and queue this one.

Thanks.
