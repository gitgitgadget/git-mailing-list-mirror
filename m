Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FC41207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 17:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbdFZRuN (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 13:50:13 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36066 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751308AbdFZRuN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 13:50:13 -0400
Received: by mail-pf0-f196.google.com with SMTP id z6so1089625pfk.3
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 10:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nGwaj/2r3TJ84kNTtZobreztsHLFJGbr0yMSVVyal60=;
        b=uzOVKx23/3I3vJ/rYzhKJpq3vCZUCyYNPvPyoRS7uVqNJwhYDsye3CCccSZz0Se6MV
         t9kBmhyVu/Q74Mi0c1JJA38zQpg8DuU0jtAYcNVseeG/JH/5WHCcLXJ1RCKfu3jyxtm+
         ERsxEJNzsHx9fz8eECx9gplEiB/iTDQwSO1Ja/PpxVus+fg9c+6SkOogkwLSaLf389kb
         5A5bQOoX7Y75YpMNfnKghFqUhzdP7K9Ny6UTi/R/fRPG3MZgTDZ422CI6YxiJ4cz3JO9
         vajkKZz300NBQ4Vx9Kv6zekemLEixJmv5iveky5JbWgUa9J7sSkuRi7L/5uFeW1tsEw+
         XF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nGwaj/2r3TJ84kNTtZobreztsHLFJGbr0yMSVVyal60=;
        b=t8ZvN2TNJuvAyQTCrEXTNYbTieizm+QSAv9TevJ1s33v/s99FliseWDw4AYQ1XelIW
         pUvPktqdT6AH/BtpGr9Bn678YHgEep+/QvKLfsDzSrggtr3il57Pa1B6nTHAS09NsCw/
         N8PEm7lsQh/7WyUshgKr1bktJ0OQF5aaSPswbxTvG3tLABW4cY1qfv0VSG1YYmVxPM35
         5Fdjtl3jmjYZrY9m8P06wpj/fIWl+0vBXR7O0KURgI/fjk0Yeer+2K1WTGAsL4aDbPf7
         Qe3cRFMgUMmFaI74qrgnPU/4tuiizGJixybQckTrkuEElCxT1oH2dESjE4/kRznJ0OpH
         V9Ww==
X-Gm-Message-State: AKS2vOzcWmBtHAnYS6z9AVHCOqSUZfcs0898D122Z6Cco6pdpaiInBBy
        mqBtjDDQ6BzpdA==
X-Received: by 10.98.101.6 with SMTP id z6mr1246775pfb.221.1498499412141;
        Mon, 26 Jun 2017 10:50:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b537:cc1a:8e81:b9ca])
        by smtp.gmail.com with ESMTPSA id 67sm1176120pfa.83.2017.06.26.10.50.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 10:50:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: Re: [PATCH v6 3/6] t0021: write "OUT" only on success
References: <20170625182125.6741-1-larsxschneider@gmail.com>
        <20170625182125.6741-4-larsxschneider@gmail.com>
        <xmqqlgof7lw7.fsf@gitster.mtv.corp.google.com>
        <0FC46284-650F-411D-845F-0DF4F32071FF@gmail.com>
Date:   Mon, 26 Jun 2017 10:50:09 -0700
In-Reply-To: <0FC46284-650F-411D-845F-0DF4F32071FF@gmail.com> (Lars
        Schneider's message of "Mon, 26 Jun 2017 11:26:30 +0200")
Message-ID: <xmqqr2y663la.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 26 Jun 2017, at 00:17, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> Lars Schneider <larsxschneider@gmail.com> writes:
>> 
>>> "rot13-filter.pl" used to write "OUT <size>" to the debug log even in case of
>>> an abort or error. Fix this by writing "OUT <size>" to the debug log only in
>>> the successful case if output is actually written.
>> 
>> Again, use of "Fix this" without clarifying what the problem is.  Is
>> this change needed because the size may not be known when the new
>> filter protocol is in use, or something?
>
> How about this?
>
>     "rot13-filter.pl" always writes "OUT <size>" to the debug log at the end
>     of an interaction.
>
>     This works without issues for the existing cases "abort", "error", and 
>     "success". In a subsequent patch 'convert: add "status=delayed" to 
>     filter process protocol' we will add a new case "delayed". In that case 
>     we do not send the data right away and it would be wrong/misleading to
>     the reader if we would write "OUT <size>" to the debug log.

I still do not quite get "we do not send the data right away" as
opposed to "at the end of an interaction" makes it wrong/misleading
to write "OUT <size>"?

    A new response "delayed" that will be introduced in subsequent
    patches accepts the input, without giving the filtered result
    right away, and at that moment, we do not even have the output
    size yet.

might be a very reasonable rationale for omitting "OUT: <size>" in
the output when "delayed" request is seen, but that still does not
explain why it is sensible to drop "OUT: <size>" for error or abort
case.

Having said all that, I tend to agree with the actual change.  When
we abort or error, we aren't producing any useful output, so it may
be sensible _not_ to say "OUT: 0" in the log output from the test
helper in these cases.  And if the change is explained that way,
readers would understand why this step is a good thing to have, with
or without the future "delayed" step in the series.

Thanks.
