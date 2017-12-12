Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DC5D1F41E
	for <e@80x24.org>; Tue, 12 Dec 2017 21:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752566AbdLLVem convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 12 Dec 2017 16:34:42 -0500
Received: from elephants.elehost.com ([216.66.27.132]:52609 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752547AbdLLVem (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 16:34:42 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id vBCLY19R021752
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 12 Dec 2017 16:34:01 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, <git@vger.kernel.org>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Jeff King'" <peff@peff.net>, "'Dan Jacques'" <dnj@google.com>,
        "'Alex Riesen'" <alexander.riesen@cetitec.com>,
        "'Jonathan Nieder'" <jrnieder@gmail.com>,
        "'Brandon Casey'" <drafnel@gmail.com>,
        "'Petr Baudis'" <pasky@ucw.cz>, "'Gerrit Pape'" <pape@smarden.org>,
        "'martin f . krafft'" <madduck@madduck.net>,
        "'Eric Wong'" <e@80x24.org>,
        "'Ramsay Jones'" <ramsay@ramsayjones.plus.com>,
        "'Joachim Schmitz'" <jojo@schmitz-digital.de>,
        "Bill Honaker" <bhonaker@xid.com>
References: <20171129195430.10069-1-avarab@gmail.com> <20171210211333.9820-1-avarab@gmail.com>
In-Reply-To: <20171210211333.9820-1-avarab@gmail.com>
Subject: RE: [PATCH v3] Makefile: replace perl/Makefile.PL with simple make rules
Date:   Tue, 12 Dec 2017 16:33:54 -0500
Message-ID: <003f01d37390$ed0e0440$c72a0cc0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHg9CAbAY7kKpvgrPjv6cdrIrakxgEtB1JPoxvPgUA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----Original Message-----
On December 10, 2017 4:14 PM, Ævar Arnfjörð Bjarmason wrote:
Subject: [PATCH v3] Makefile: replace perl/Makefile.PL with simple make rules

>Replace the perl/Makefile.PL and the fallback perl/Makefile used under NO_PERL_MAKEMAKER=NoThanks with a much simpler implementation heavily inspired by how the i18n infrastructure's build process works[1].
>The reason for having the Makefile.PL in the first place is that it was initially[2] building a perl C binding to interface with libgit, this functionality, that was removed[3] before Git.pm ever made it to the master branch.
<big snip>

I would like to request that the we be careful that the git builds do not introduce arbitrary dependencies to CPAN. Some platforms (I can think of one off the top, being NonStop) does not provide for arbitrary additions to the supplied perl implementation as of yet. The assumption about being able to add CPAN modules may apply on some platforms but is not a general capability. I am humbly requesting that caution be used when adding dependencies. Being non-$DAYJOB responsible for the git port for NonStop, this scares me a bit, but I and my group can help validate the available modules used for builds.

Note: we do not yet have CPAN's SCM so can't and don't use perl for access to git anyway - much that I've tried to change that.

Please keep build dependencies to a minimum.

Thanks for my and my whole team.

Randall

-- Brief whoami: NonStop&UNIX developer since approximately UNIX(421664400)/NonStop(211288444200000000) 
-- In my real life, I talk too much.



