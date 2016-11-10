Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5710B20229
	for <e@80x24.org>; Thu, 10 Nov 2016 12:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932619AbcKJMKa (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 07:10:30 -0500
Received: from mx1.imag.fr ([129.88.30.5]:36316 "EHLO mx1.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932197AbcKJMK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 07:10:29 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id uAACAGvW011291
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Thu, 10 Nov 2016 13:10:16 +0100
Received: from anie (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id uAACAHtq000799;
        Thu, 10 Nov 2016 13:10:17 +0100
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        me@ttaylorr.com
Subject: Re: [RFC] Add way to make Git credentials accessible from clean/smudge filter
References: <4C8C5650-7221-4F62-A9CC-81AE01EF6DC7@gmail.com>
Date:   Thu, 10 Nov 2016 13:10:17 +0100
In-Reply-To: <4C8C5650-7221-4F62-A9CC-81AE01EF6DC7@gmail.com> (Lars
        Schneider's message of "Thu, 10 Nov 2016 12:52:36 +0100")
Message-ID: <vpqoa1n1qom.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Thu, 10 Nov 2016 13:10:16 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: uAACAGvW011291
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1479384617.58962@L6pATivpr5O+BHBYyeDpew
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> I haven't looked at an implemenation approach at all. I wonder if this could
> be OK from a conceptional point of view or if there are obvious security 
> problems that I am missing.

Did you consider just running "git credential" from the filter? It may
not be the perfect solution, but it should work. I already used it to
get credential from a remote-helper (git-remote-mediawiki). When
prompting credentials interactively, it grabs the terminal directly, so
it work even if stdin/stdout are used for the protocol.

Asking the main git process to get the credentials probably has added
value like the ability to prompt once and use the same for several
filter processes.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
