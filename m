Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADA531F597
	for <e@80x24.org>; Mon, 30 Jul 2018 20:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbeG3WgE (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 18:36:04 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33094 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbeG3WgE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 18:36:04 -0400
Received: by mail-pl0-f67.google.com with SMTP id 6-v6so6090854plb.0
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 13:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pSeILxdtdCd5xuoDAXAm8fPxKOOhqNuOZijKMvqtHus=;
        b=aQBqm16QSR9fukWzJrD46yZBsVrxB2VjvA+Ttvb5dMHgJNAwOiNokTaVrqC2GxbeOo
         aPKWdt879lOenEnja+cmXfaetC/3ajREIs0mrIpMtflchr3gbrSlqwvPnNqJ6MIBBVT5
         SW86EeCo0CsxOnLMnlsh/qwbvZUC+Px3zbmu1LDBejAKKGI3UO8iYBN7418H3FeMbRts
         NAmfrNaz+toS2/ejrmnRcU5bxoQnJyC7XJIsK1jwDeqhj8/k93VCuioJhObVG8ascAxA
         0aNm0yKkk1L04q9rdFmTLyfJ0ncMoyBXoxZr02seA75Pe3OlrmSYWPigD9VUbtFY/W7z
         XU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pSeILxdtdCd5xuoDAXAm8fPxKOOhqNuOZijKMvqtHus=;
        b=nxjuY3imApUC4nKl2QnTeRvPn/lwvLOyoF7FK570tY0PcJBgIxABO2zPQZzFQuO0xD
         Rzt8uQrb+fHZiIDv4ocfpIQBfCMpFI7BCsdvrMFW2xWA+kAKfslbiBnBbcSt8pYgaGkr
         EHfaxPSsgYivDQfckvOgCMZrSUSrxIi6mNw2zPZs/7rJWDa3EY+lcLHNPg+D3xnWu+un
         vf6Cl9fH4JjG3bpPCoN1XbMg9Rc42l0JgKp37JK2bhTbMVlOYsTqrSGoahZ+bMw5AcBW
         wQ3IcVAoZaHXmut9yBUQCRLrgspKzXwpINsxk1s/5EUC0oUqPoRezyL5UQG1RljN3C3K
         Gdgg==
X-Gm-Message-State: AOUpUlE7LZeussmlHA7SozF+968hM7ZIDKDQXaWXiMjI6EvS+OmQIfiP
        bWfk95uKTuAWHm03+EYAVxU=
X-Google-Smtp-Source: AAOMgpcAbBxkbxgxwSJKm9EpiT+sOas7Gn88lMC5yXygaR4Hqv3wnluPQXFnTjqZmW7XwZD9x4grdw==
X-Received: by 2002:a17:902:8ecb:: with SMTP id x11-v6mr18146714plo.308.1532984356242;
        Mon, 30 Jul 2018 13:59:16 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id k123-v6sm27279417pga.21.2018.07.30.13.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 13:59:15 -0700 (PDT)
Date:   Mon, 30 Jul 2018 13:59:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 01/10] t/test-lib: teach --chain-lint to detect broken
 &&-chains in subshells
Message-ID: <20180730205914.GE156463@aiede.svl.corp.google.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180711064642.6933-1-sunshine@sunshineco.com>
 <20180711064642.6933-2-sunshine@sunshineco.com>
 <20180730181356.GA156463@aiede.svl.corp.google.com>
 <CAPig+cRFMKBQVVYjhS6-Yyy-aQCYXGiqG6XoqucJoedCvAzheQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRFMKBQVVYjhS6-Yyy-aQCYXGiqG6XoqucJoedCvAzheQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine wrote:
> On Mon, Jul 30, 2018 at 2:14 PM Jonathan Nieder <jrnieder@gmail.com> wrote:

>>         (
>>                 chks_sub=$(cat <<TXT | sed '\''s,^,sub dir/,'\''
>> $chks
>> TXT
>> ) &&
>>
>> Ugly quoting, useless use of "cat", etc, aside, I don't think it's
>> missing any &&.  Hints?
>
> Yes, it's a false positive.
>
> The subshell linter would normally fold out the here-doc content, but
> 'sed' isn't a proper programming language, so the linter can't
> recognize arbitrary here-doc tags. Instead it has hard-coded knowledge
> of the tags commonly used in the Git tests, specifically EOF, EOT, and
> INPUT_END.

Oh, hmm.  I also see some others (outside subshells, though):

	EXPECT_END
	FRONTEND_END
	END_PART1
	SETUP_END
	EOF2
	EXPECTED
	END_OF_LOG
	INPUT_END
	END_EXPECT

I wonder if it should look for something like [A-Z][A-Z_]* to catch
all of these.

> The linter also deals with multi-line $(...) expressions, however, it
> currently only recognizes them when the $( is on its own line.

That's reasonable, especially if "on its own line" means "at end of
line".

What would help most is if the error message could explain what is
going on, but I understand that that can be hard to do in a sed
script.

[...]
> I could try to update the linter to not trip over this sort of input,
> however, this test code is indeed ugly and difficult to understand,
> and your rewrite[1] of it makes it far easier to grok, so I'm not sure
> the effort would be worthwhile. What do you think?

I'd be happy to look over a change that handles more here-doc
delimiters or produces a clearer message for tests in poor style, but
I agree with you that it's not too important.

Thanks for looking it over.

Sincerely,
Jonathan

> [1]: https://public-inbox.org/git/20180730190738.GD156463@aiede.svl.corp.google.com/
