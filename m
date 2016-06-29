Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97DDE2018A
	for <e@80x24.org>; Wed, 29 Jun 2016 05:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbcF2F6M (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 01:58:12 -0400
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:52415 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbcF2F6K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jun 2016 01:58:10 -0400
Received: from vsmta13.fe.internet.bosch.com (unknown [10.4.98.53])
	by imta23.fe.bosch.de (Postfix) with ESMTP id AD47015801B0
	for <git@vger.kernel.org>; Wed, 29 Jun 2016 07:56:24 +0200 (CEST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/simple; d=bosch.com;
	s=2015-01-21; t=1467179784;
	bh=dVxL/RmIaS7QiBjg/YqGSM5ntG46EhSxcy1wGwghUD0=; l=10;
	h=From:From:Reply-To:Sender;
	b=tkh56hT4qqc6t7gy0FEuHqn0RRnsRbbfrYL0tt2vyCtnfKUxbX0YORUi4FdvADCvU
	 9MnDvPy9AW82HgW5mdRLlKg+l+sYvNOk1SYXSgGKzqWKCtTaklCIXiCPci9x3+FPjO
	 X4q39xzRO0GNANZssLn3uwy8NHlLuAWjNIA9GmF0=
Received: from SGDS00560.zf-lenksysteme.net (vsgw22.fe.internet.bosch.com [10.4.98.11])
	by vsmta13.fe.internet.bosch.com (Postfix) with ESMTP id 5E5F92E40252
	for <git@vger.kernel.org>; Wed, 29 Jun 2016 07:56:24 +0200 (CEST)
Received: from SGDS00759.zf-lenksysteme.net ([fe80::1563:32:9d91:d0e6]) by
 SGDS00560.zf-lenksysteme.net ([fe80::b166:abcb:a645:9cbf%15]) with mapi id
 14.03.0266.001; Wed, 29 Jun 2016 07:56:24 +0200
From:	Roessner Silvester SGD AS-ER/QMM1 * <Silvester.Roessner@bosch.com>
To:	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git Gui 0.20 messes up UTF-8 author names when amending a commit
Thread-Topic: Git Gui 0.20 messes up UTF-8 author names when amending a
 commit
Thread-Index: AdHRyJt5BPZp+vlXTOqa1Jyzs+pAig==
Date:	Wed, 29 Jun 2016 05:56:23 +0000
Message-ID: <52E1627956F20E458D872C5961027EDC654FE17C@SGDS00759.zf-lenksysteme.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.96.215.164]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
X-TM-AS-Product-Ver: IMSS-7.1.0.1679-8.0.0.1202-22418.006
X-TMASE-MatchedRID: T5h6mHJlcbvxGh/jocyg+S1Hx9UxMGjd+q1Y+/eEAraCsBeCv8CM/a3L
	5qKkEBJgDXTrAgd0ymXH/DOYtstoBW8BlJMEDE+D05yZiz1u26RQCOsAlaxN74sR/hEH7GRhszI
	aiGWR/RdoEiT0d+PrPNiRFWPTp2j8QQJJoIdNNmfI89FT1JwQNYYrUBjVTlyzgFn1RZSxn3o7hR
	NXLmm0eS97OLZjBcrLNDQwhKnS+w3Uu3synNQKJJ4CIKY/Hg3AhGBk0/7pshLEQdG7H66TyH4gK
	q42LRYkl0DipTxwXR9TsO88fhyb4nCy6WtdsPz6R2MVtz2ytvh+3BndfXUhXQ==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

first I want to thank all involved in developing git.
It is really one of the - no! - it is the greatest tool I ever worked with!

So I want to help improving it at least with this bug report.

Since git version 2.9.0 git git-gui messes up my author name
- which contains UTF-8 characters: Silvester Rößner -
when I amend a commit.

When I do the same with git-bash it's all ok.

git log after first amend:

    $ git log
    commit 8ac8115c3af04bd8f5171452141398b0cfb57f87
    Author: Silvester RÃ¶Ã?ner <silvester.roessner@bosch.com>
    Date:   Wed Jun 29 07:31:46 2016 +0200

        asdf

    commit ae34f23a9a3d7f673ad3ed57dbea5af302d4f0c1
    Author: Silvester Rößner <silvester.roessner@bosch.com>
    Date:   Wed Jun 29 07:31:21 2016 +0200

    test


git log after second amend:

    $ git log
    commit 9240372e8e7336a2c523f27a75b3ac4e07315039
    Author: Silvester RÃ?Â¶Ã??ner <silvester.roessner@bosch.com>
    Date:   Wed Jun 29 07:31:46 2016 +0200

        asdf

    commit ae34f23a9a3d7f673ad3ed57dbea5af302d4f0c1
    Author: Silvester Rößner <silvester.roessner@bosch.com>
    Date:   Wed Jun 29 07:31:21 2016 +0200

        test


To reproduce the bug

    1. create an empty repo,
    2. set up the author name to "Silvester Rößner"
    3. commit a file with git gui
    4. amend the commit with git gui

I use this version

    git-gui version 0.20.GITGUI
    git version 2.9.0.windows.1

    Tcl/Tk version 8.6.5

The versions I used before just work great!

Mit freundlichen Grüßen / Best regards

Silvester Rößner

Automotive Steering, Electric Power Steering Rack, Quality Processes & Engineering (AS-ER/QMM1)
Robert Bosch Automotive Steering GmbH | 73527 Schwäbisch Gmünd | GERMANY | www.bosch-automotive-steering.com
Tel. +49 7171 31-4120 | Fax +49 7171 31-64120 | silvester.roessner@bosch.com

--
Robert Bosch Automotive Steering GmbH, Richard-Bullinger-Str. 77, 73527 Schwäbisch Gmünd, Germany
Vorsitzender des Aufsichtsrats/Chairman of the Supervisory Board: Dirk Hoheisel
Geschäftsführung/Management Board: Christian Sobottka (Vorsitz/Chairman), Hanns Bernd Ketteler, Marcus Parche, Henning Wagner
Sitz der Gesellschaft/Headquarters: Schwäbisch Gmünd - Handelsregistereintrag: Amtsgericht Ulm HRB 701678/Trade register of the municipal court of Ulm HRB 701678
