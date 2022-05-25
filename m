Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0ADC433FE
	for <git@archiver.kernel.org>; Wed, 25 May 2022 07:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244343AbiEYHcr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 03:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiEYHci (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 03:32:38 -0400
Received: from weald.air.saab.se (weald.air.saab.se [136.163.212.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D836D3C720
        for <git@vger.kernel.org>; Wed, 25 May 2022 00:32:34 -0700 (PDT)
Received: from mailhub1.air.saab.se ([136.163.213.4])
        by weald.air.saab.se (8.14.7/8.14.7) with ESMTP id 24P7WR42092237
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 May 2022 09:32:27 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 weald.air.saab.se 24P7WR42092237
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=saabgroup.com;
        s=weald_2; t=1653463947;
        bh=BVJBC5eYhAkkZ84SyMC4qpZm48g/TQPhxYXBDYFNCo4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=sQbdFiWCB7IpwCz/RLtXqjiWl0rQtUuqMOo0NY2EMB7GwUc0W+lqwbMe/LSwZkpgd
         1oA1IyE5320mVQkpIfj6/Ey0Y6G3tdeext+nUWmWA5udXk89msTVJYxvPQx01tNjZ0
         VkGSrneM73t8gnSo4regSHQA4uwrXWR6a+LtaKNDuuhAzQVIn2zev1mWNesvedov0e
         Bjnek+9Fbp/hLtIh2Kw+jBmkKZjhpzeSGUG/RzlmYb3AYlFlp8/spSOaFKk3zt6+BQ
         d9FsT2ZhKkwSUeMYznM5iYHEPRXNxSTb+S2LDEHEgjxQi7gg8wuVOaLvKpkaU0u31C
         STKB6J9oVoRag==
Received: from corpappl17772.corp.saab.se (corpappl17772.corp.saab.se [10.12.196.79])
        by mailhub1.air.saab.se (8.15.2/8.15.2) with ESMTPS id 24P7WRiS3155943
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 May 2022 09:32:27 +0200
Received: from corpappl17781.corp.saab.se (10.12.196.88) by
 corpappl17772.corp.saab.se (10.12.196.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Wed, 25 May 2022 09:32:18 +0200
Received: from corpappl17781.corp.saab.se ([fe80::988b:c853:94fe:90aa]) by
 corpappl17781.corp.saab.se ([fe80::988b:c853:94fe:90aa%5]) with mapi id
 15.02.0986.026; Wed, 25 May 2022 09:32:18 +0200
From:   Olsson John <john.olsson@saabgroup.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: Error handling when giving empty command line
 arguments
Thread-Topic: [EXTERNAL] Re: Error handling when giving empty command line
 arguments
Thread-Index: Adhvbv33EYLm80KPScCjpHIHZomAfwAUeVDZABEtmIA=
Date:   Wed, 25 May 2022 07:32:18 +0000
Message-ID: <8767dbe0c22540a4ab3e18684aa7e030@saabgroup.com>
References: <dc08a8ee5ed64850872fd6529d1462e1@saabgroup.com>
 <xmqq35gyee7r.fsf@gitster.g>
In-Reply-To: <xmqq35gyee7r.fsf@gitster.g>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [136.163.101.124]
x-tm-as-product-ver: SMEX-14.0.0.3092-9.0.1002-26914.006
x-tm-as-result: No-10--4.660200-5.000000
x-tmase-matchedrid: oTBA/+sdKabK19rKCr/Ovgrcxrzwsv5uXPK9y3z82Gs+KSDQ9ztlrSc+
        QrY0Pxmfb0fmCWHRknFucftoZZ+9SvnlySD+8Ss5L7p//vLv4bN2LVAkzutP5Pmt2wtrXQjMBk0
        sRysFrTCzWVOWI+JSh5I49Eva7YXhf7OyDqSnYLfGsO9QyW2iBNhQO8CvZj/XDwPOPApEJd3MoA
        Jfsjm0TgURjmNRpEDiEzvXiPvr1j6McUzJS3sH3Rd8ENHLtW0zfS0Ip2eEHnxlgn288nW9IAuTL
        po5HEc1joczmuoPCq0Tvm/lD9MJOzlhzJ/6CMuFjaSt38wKx3R5q2Xb951x/QVGr+mzk8ohaWST
        rU8OKnI4JWMU/YGbDPCa3UIfT4sCJA5tg53RUuMorPY7HEKSnM0bQv3yPxsy+toqr+8ptZ9j6l0
        ihn9/SoywwyXyfWbHlExlQIQeRG0=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--4.660200-5.000000
x-tmase-version: SMEX-14.0.0.3092-9.0.1002-26914.006
x-tm-snts-smtp: BC69E0ACC68EF8C74C7F413A106D83FAEBC1BB0FA53DC6C3E42D1C9506C6A84E2002:B
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The user is not giving enough information to Git to allow it to tell if "=
git fetch ''" it got came from any of these with unset variable:
>
>	$ git fetch "$path"
>	$ git fetch "$url"
>	$ git fetch "$force"
>
> because all Git sees is an empty string.
>
> It is unfair to complain "is completely unrelated".  The user didn't give=
 enough information to even allow Git to tell if it is or is not related.

That is exactly my point! I was thinking along the lines that perhaps the G=
it command(s) could complain about that it got an empty string as an argume=
nt since that is probably a mistake by the user due to that an empty string=
 is neither a path, a URL/URI, or an option. It is thus an error case of it=
s own.


The git checkout command actually complains about the case when you give it=
 an empty string

$ git checkout "" feature/foobar
fatal: empty string is not a valid pathspec. please use . instead if you wa=
nt to match all paths


When it comes to git fetch it could assume that the given empty string is e=
ither a path or a URL/URI and write a similar error message. For instance

$ git fetch ""
fatal: empty string is not a valid pathspec or URL; see 'git help fetch' fo=
r valid syntax

For me there is an important distinction between "no path specified" and "e=
mpty string". The former says that an argument is missing and the latter sa=
ys that an argument is indeed given but it is an empty string.

