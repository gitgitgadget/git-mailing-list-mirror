Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 929451FD99
	for <e@80x24.org>; Sat, 20 Aug 2016 16:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753107AbcHTQCT convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 20 Aug 2016 12:02:19 -0400
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:50825 "EHLO
        smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752796AbcHTQCS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2016 12:02:18 -0400
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
        by smtpfb2-g21.free.fr (Postfix) with ESMTP id 77715CAD2C9
        for <git@vger.kernel.org>; Sat, 20 Aug 2016 18:02:12 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e35:2ef1:f910:86a6:c8ff:fe05:d3e0])
        by smtp1-g21.free.fr (Postfix) with ESMTPS id 8C0B6B0053F;
        Sat, 20 Aug 2016 16:01:24 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Alexander Shopov <ash@kambanaria.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Marco Sousa <marcomsousa@gmail.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Nelson Martell <nelson6e65@gmail.com>,
        Brian Gesiak <modocache@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [L10N] Kickoff of translation for Git 2.10.0 round 1
Date:   Sat, 20 Aug 2016 18:01:55 +0200
Message-ID: <9262712.D6TC1VHfMN@cayenne>
User-Agent: KMail/5.2.3 (Linux/4.6.0-1-amd64; KDE/5.23.0; x86_64; ; )
In-Reply-To: <CANYiYbGL+GVRNuhszp1UShaN_oJgm3netsQxZfbW74pVK0gOYQ@mail.gmail.com>
References: <CANYiYbGL+GVRNuhszp1UShaN_oJgm3netsQxZfbW74pVK0gOYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Before anyone tries to localize this round, I'd like to make some preliminary 
comments:

1.  In config.c, the changes to the function die_bad_number tried to flatten the 
translated strings (no message building logic). I think it went too far, and 
the reason of the failure can be factorized so that we don't have to 
retranslate each time. I might be wrong on this one, but I have no example of 
language where we would need differentiated error reasons.

2.  in sequencer.c, there is a mistake in the original string to translate 
"Cannot revert during a another revert"

3. git-rebase--interactive, in this_nth_commit_message and 
skip_nth_commit_message are not localizable, because the logic of declination 
of numeral attributes is in the code and is really oriented towards English 
and doesn't make sense for other languages (with 28 strings to translate !). 
In this case, I would suggest to step back and just have a single string per 
function.

If translators can quickly agree on these issues and maybe others I haven't 
seen, I can prepare a patch for review this weekend.

BR

Jean-Noël (french translation)



