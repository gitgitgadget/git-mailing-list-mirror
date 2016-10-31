Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92F452022C
	for <e@80x24.org>; Mon, 31 Oct 2016 00:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752800AbcJaAar convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 30 Oct 2016 20:30:47 -0400
Received: from dmz-mailsec-scanner-6.mit.edu ([18.7.68.35]:56517 "EHLO
        dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752165AbcJaAaq (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Oct 2016 20:30:46 -0400
X-AuditID: 12074423-1a3ff7000000298a-9d-581690b4e54d
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by  (Symantec Messaging Gateway) with SMTP id BD.83.10634.4B096185; Sun, 30 Oct 2016 20:30:45 -0400 (EDT)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id u9V0UhCh026464;
        Sun, 30 Oct 2016 20:30:43 -0400
Received: from localhost (buzzword-bingo.mit.edu [18.9.64.24])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id u9V0Uew5009081
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 30 Oct 2016 20:30:41 -0400
Date:   Sun, 30 Oct 2016 20:30:39 -0400 (EDT)
From:   Anders Kaseorg <andersk@mit.edu>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>, 842477@bugs.debian.org,
        Git Mailing List <git@vger.kernel.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH] git-sh-setup: Restore sourcability from outside
 scripts
In-Reply-To: <CACBZZX6ArQdG202n-SouwDhoTE1LF=69mKjWQv8HPKJ+K_0fJQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1610302021060.20998@buzzword-bingo.mit.edu>
References: <alpine.DEB.2.10.1610292153300.60842@buzzword-bingo.mit.edu> <CACBZZX4SnJj6ZYK-Ha3EtiWUf_n=+LZ=UeS=7vxgsj8s=bi3Sg@mail.gmail.com> <alpine.DEB.2.10.1610301503280.60842@buzzword-bingo.mit.edu> <223121D101D844DEBF086AC40A5AF4CB@PhilipOakley>
 <20161030211227.4gqovv7mt7mtnpy7@sigill.intra.peff.net> <CACBZZX6ArQdG202n-SouwDhoTE1LF=69mKjWQv8HPKJ+K_0fJQ@mail.gmail.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixCmqrbt1gliEwdRnqhYL515itlj77A6T
        RdeVbiaLht4rzBY/WnqYLTqnylp0zlzC7sDucWHrJBaPnbPusnssX7qO0eNZ7x5Gj4uXlD36
        7k5n8/i8SS6APYrLJiU1J7MstUjfLoEr41DvLsaCtawV9zasYWtg3MDSxcjJISFgIjHhxGnW
        LkYuDiGBNiaJPf82MEE4GxklLp77yw7h7GaS+NjfwNzFyMHBIqAt8fmjA0g3m4CaxIejX1lB
        wiICnhJH1hqBlDMLvGSUWLltMiNIXFjAT2LVMheQck6BQIk/r86CLeYV8JB4/nUv1K6fTBIv
        +6cygiREBXQlDv37wwZRJChxcuYTsAZmAXWJA58uMkLY2hL3b7axTWAUmIWkbBaSsllIyhYw
        Mq9ilE3JrdLNTczMKU5N1i1OTszLSy3SNdPLzSzRS00p3cQIigN2F+UdjC/7vA8xCnAwKvHw
        RkiLRQixJpYVV+YeYpTkYFIS5d3vKBohxJeUn1KZkVicEV9UmpNafIhRgoNZSYTXDxh9Qrwp
        iZVVqUX5MClpDhYlcd7/bl/DhQTSE0tSs1NTC1KLYLIyHBxKErw3+oEaBYtS01Mr0jJzShDS
        TBycIMN5gIaD1fAWFyTmFmemQ+RPMepyvNv87gGTEEtefl6qlDhvOEiRAEhRRmke3BxI+nKQ
        eMUoDvSWMO9FkCoeYOqDm/QKaAkT0JK0QhGQJSWJCCmpBkb9q+rcC0VbTQNbZv398MzycVC3
        HkfjDvbpM1cxCvx4eb24a7GmsmBb4VEO8cuR57Uk5bqlAw//VosQNE/Z8KW1gzdkrdGunfyJ
        flce3omQPO6w2yKo+OHlj0/uPhab0zGrLPyueMfz3ekOV+v31M9puvKUua4pOzPtpqOc6zSh
        1VWTXWNPfVBiKc5INNRiLipOBADf73HZOgMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 30 Oct 2016, Ævar Arnfjörð Bjarmason wrote:
> This did break in v2.10.0, and it's taken a couple of months to notice
> this, so clearly it's not very widely used, which says something about
> the cost-benefit of maintaining this for external users.

For the record, in case this affects the calculation, it was noticed that 
guilt was broken a just couple of days after the first git 2.10.x upload 
to Debian, which was last weekend.

https://bugs.debian.org/842477
http://repo.or.cz/guilt.git/blob/v0.36:/guilt#l28

(I have no further opinion; I trust that Junio has all the information 
needed to decide one way or the other.)

Anders
