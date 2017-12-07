Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A287F20954
	for <e@80x24.org>; Thu,  7 Dec 2017 14:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753396AbdLGOOn (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 09:14:43 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38295 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753058AbdLGOOm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 09:14:42 -0500
Received: by mail-wm0-f46.google.com with SMTP id 64so13108713wme.3
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 06:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=r6zZqVWyF51eluOs2S1jWZLZBkPxTR5x5bljCmmPcCg=;
        b=MYGhkat5siHnYcCLVv+N8FTUbOguW8JtVQrKUEzj/GnY/gat4975urPerrVAUZf1pw
         FjpP8b05GFMkEJwcvb93fU3bR2PgiBLXHo0Ysw8Afr+8MZGRinLE3rb+bUxLT1EOGG9p
         o6e3k2/lM+Xy7Pu7OMmWXtYBd3Z8ddqPD8PEuD8eblYakSMNULjtEOqu8tTUp2J+Etiz
         uymYUAfuucRYC3PgI0r9fG7CAFzhYj8nE8kO9jW67H3QSR78HBhP2+WL8Uc9i6REJTlz
         a/FagQ6sF1Q/MvK5DpHkF15SBnXCUTzHBlaJ6d/PENJvFXg+3r3Lkgv3V7mhBVStDXif
         Stmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=r6zZqVWyF51eluOs2S1jWZLZBkPxTR5x5bljCmmPcCg=;
        b=VL/ipW2v+k8wNkn2eWM5euQLioR58TlVVjcrYmyeeS3+wn6f/lfnaOO76nEQeYbTF9
         vIgSnBQ2one6y1mN2BTuivw9qB7HffSeqrjThhjDw0/A/FVF59ROgLjcjbxr0Z/rSDVb
         Ea4h9RPev+UX225DCYkP28wgHMIjOT5Vdf51nZJt3RNStEIKq63zOReAgp5rCHgW+7w8
         WZPD8Xba3OFEQbCoYF6PNsKxETEmMrSIIiA9cOziD2yyANGxnOF4VQwD9yWR8A/ltfOI
         QR1QpVxYnPAuOvo4bsZIZgkPejFF9JdwhbhxwjJPFLf/NbwJ4P1mWbonXKSZa6+H61ky
         IVnQ==
X-Gm-Message-State: AJaThX4ksdhupAIypZ6tbUlrFXtPI+cYZkRhU1616aOf3jnH4bUc3Dqh
        0SWbjhVJTrmA9lX7yNdL2VU=
X-Google-Smtp-Source: AGs4zMadG2kaDO2yShELH9kT4rpxRZiBV1b3ORL/FxHv33FJm2TtFK2/LUspZBkqSsCDKb7t1D/OLA==
X-Received: by 10.80.222.1 with SMTP id z1mr40062346edk.277.1512656081025;
        Thu, 07 Dec 2017 06:14:41 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id h56sm2372300eda.97.2017.12.07.06.14.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Dec 2017 06:14:39 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eMwwh-00015O-18; Thu, 07 Dec 2017 15:14:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
Cc:     PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ALBERTIN TIMOTHEE p1514771 
        <timothee.albertin@etu.univ-lyon1.fr>,
        BENSOUSSAN--BOHM DANIEL p1507430 
        <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
Subject: Re: [PATCH v4] send-email: extract email-parsing code into a subroutine
References: <20171206230225.18873-1-nathan.payre@etu.univ-lyon1.fr> <ff9066a7209b4e21867d933542f8eece@BPMBX2013-01.univ-lyon1.fr> <q7h94lp2oepu.fsf@orange.lip.ens-lyon.fr>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <q7h94lp2oepu.fsf@orange.lip.ens-lyon.fr>
Date:   Thu, 07 Dec 2017 15:14:38 +0100
Message-ID: <87po7qzktt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 07 2017, Matthieu Moy jotted:

> Not terribly important, but your patch has trailing newlines. "git diff
> --staged --check" to see them. More below.
>
> PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr> writes:
>
>> the part of code which parses the header a last time to prepare the
>> email and send it.
>
> The important point is not that it's the last time the code parses
> headers, so I'd drop the "a last time".
>
>> +	my %parsed_email;
>> +	$parsed_email{'body'} = '';
>> +	while (my $line = <$c>) {
>> +		next if $line =~ m/^GIT:/;
>> +		parse_header_line($line, \%parsed_email);
>> +		if ($line =~ /^\n$/i) {
>
> You don't need the /i (case-Insensitive) here, there are no letters to
> match.

Good catch, actually this can just be: /^$/. The $ syntax already
matches the ending newline, no need for /^\n$/.

>> +sub parse_header_line {
>> +	my $lines = shift;
>> +	my $parsed_line = shift;
>> +	my $pattern1 = join "|", qw(To Cc Bcc);
>> +	my $pattern2 = join "|",
>> +		qw(From Subject Date In-Reply-To Message-ID MIME-Version
>> +			Content-Type Content-Transfer-Encoding References);
>> +
>> +	foreach (split(/\n/, $lines)) {
>> +		if (/^($pattern1):\s*(.+)$/i) {
>> +		        $parsed_line->{lc $1} = [ parse_address_line($2) ];
>> +		} elsif (/^($pattern2):\s*(.+)\s*$/i) {
>> +		        $parsed_line->{lc $1} = $2;
>> +		}
>
> I don't think you need to list the possibilities in the "else" branch.
> Just matching /^([^:]*):\s*(.+)\s*$/i should do the trick.

Although you'll end up with a lot of stuff in the $parsed_line hash you
don't need, which makes dumping it for debugging verbose.

I also wonder about multi-line headers, but then again that probably
breaks already on e.g. Message-ID and Refererences, but that's an
existing bug unrelated to this patch...

>> +			$body = $body . $body_line;
>
> Or just: $body .= $body_line;
