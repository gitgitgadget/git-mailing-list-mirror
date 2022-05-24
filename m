Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA61C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 14:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237272AbiEXOHw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 10:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237682AbiEXOHv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 10:07:51 -0400
X-Greylist: delayed 2517 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 May 2022 07:07:45 PDT
Received: from weald2.air.saab.se (weald2.air.saab.se [136.163.212.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B1922BD8
        for <git@vger.kernel.org>; Tue, 24 May 2022 07:07:45 -0700 (PDT)
Received: from mailhub1.air.saab.se ([136.163.213.4])
        by weald2.air.saab.se (8.14.7/8.14.7) with ESMTP id 24ODPklW027695
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <git@vger.kernel.org>; Tue, 24 May 2022 15:25:46 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 weald2.air.saab.se 24ODPklW027695
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=saabgroup.com;
        s=weald2_2; t=1653398746;
        bh=XsBHnrFRpHk+lWAcHIRH9anU0DxZde0QwGujXe33sMI=;
        h=From:To:Subject:Date:From;
        b=Ar4NxShxEkB7OlTPNANbOguhmoC1/9JT1OlMEyG8R6NzGt4PcMroPOXegwoIZTmXO
         pWturaBuC1RjjEAYYngO8lKPYbioLnu1IROyw/MSoLjXpfBs58SW5CNqC3ZOyvodhO
         VSei0b3ittZ9xNIPjdkxQaOpaOVfgOVwGRPjdSOMuyzNoSeKX/envNv4GnKbaCpxjI
         GXsoeBxI37hDmfR0zGZYOBs7plAZzaLtCXPjsQ6yWzaDrtpPSh4CZgTmVe5AsKgSvE
         Pq99CAHf1WgKwY3chSbHFHO440KGSmEEyULbTTtQNMHbJDAafL6tmDB4RoIdvgrOT0
         W33pPVA0NvZKw==
Received: from corpappl17779.corp.saab.se (corpappl17779.corp.saab.se [10.12.196.86])
        by mailhub1.air.saab.se (8.15.2/8.15.2) with ESMTPS id 24ODPk452858698
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Tue, 24 May 2022 15:25:46 +0200
Received: from corpappl17781.corp.saab.se (10.12.196.88) by
 corpappl17779.corp.saab.se (10.12.196.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Tue, 24 May 2022 15:25:43 +0200
Received: from corpappl17781.corp.saab.se ([fe80::988b:c853:94fe:90aa]) by
 corpappl17781.corp.saab.se ([fe80::988b:c853:94fe:90aa%5]) with mapi id
 15.02.0986.026; Tue, 24 May 2022 15:25:43 +0200
From:   Olsson John <john.olsson@saabgroup.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Error handling when giving empty command line arguments
Thread-Topic: Error handling when giving empty command line arguments
Thread-Index: Adhvbv33EYLm80KPScCjpHIHZomAfw==
Date:   Tue, 24 May 2022 13:25:43 +0000
Message-ID: <dc08a8ee5ed64850872fd6529d1462e1@saabgroup.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [136.163.101.122]
x-tm-as-product-ver: SMEX-14.0.0.3092-9.0.1002-26912.007
x-tm-as-result: No-10--5.887500-5.000000
x-tmase-matchedrid: 3C+gAndgRrt4GcCqxQcAiAewBVjD2SDGlKvhkP88iXT/Gd9Sm0XpG7y5
        zA+nB60F8sfxw8Kspfftyssmx6PkxnHPBvSspzfjGXGu0jdPFGRITEcvqjcF4Jr6aNifCis8aOV
        lkCHubAFuf5ur5byPparP+04pA0BmxzdZUAxpvx2rm7DrUlmNkF+24nCsUSFNjaPj0W1qn0TKay
        T/BQTiGsKRxzhjL0lRi9+dihKZ3oM4qTOLvMus50kt6DZf9h4RSz2fw9kSQzDAvpLE+mvX8g==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--5.887500-5.000000
x-tmase-version: SMEX-14.0.0.3092-9.0.1002-26912.007
x-tm-snts-smtp: 440D31FE037F1D94F4869B3FC222A15E86B8E88E517460757A26317501052BA72002:B
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have so far only seen this behavior with 'git fetch' command, but it migh=
t be more general depending on how command line parsing is implemented.

In a Bash script I had something similar to (but more complicated than what=
 I show below)

  git fetch "${force}"

where $force is either an empty string or '--force'. Due to that you usuall=
y want to expand all variables within double quotes when writing Bash scrip=
ts I did not realize that I had made a mistake here. Instead I got this str=
ange error message and spent a couple of hours chasing it

  fatal: no path specified; see 'git help pull' for valid url syntax

This problem eventually turned out to be of the trivial kind once I realize=
d why I got it, and also very simple to reproduce. Just do
  $ git fetch ""
  fatal: no path specified; see 'git help pull' for valid url syntax
  $

That is, 'git fetch' does not check if the given string is an empty string =
before writing the error message. The empty string is completely unrelated =
to any path/URI and in this case it was not that helpful.

What do you say? Wouldn't it be better with a more specific error message w=
hen an option value/argument is an empty string? Or should perhaps empty st=
rings be ignored by the git commands?


/John

