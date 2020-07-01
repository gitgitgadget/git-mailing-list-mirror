Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B66C433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 19:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C77FA20760
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 19:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="OzAOCDaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgGATo3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:44:29 -0400
Received: from mout.gmx.net ([212.227.15.19]:57063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgGATo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 15:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593632667;
        bh=2MwGD3slY9MZ5GfPxwn7EqdoZhCgaWTDWcnvaWA+4b8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OzAOCDaJgg3c+dGnMRMz6MNaLpvT+KLsEyYbeB8Aste/aRwSIIl6sUS3jWTmL7siG
         ztJ+LCIoouuReuBr5vIU5GOqe011lLo3ACwAEK+naohZFDO0FS6YopXN6fLqm9nIVn
         zQ1wgptAj8Osi2ACGzwESYWHLBivX6tPEuf82JZo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.116.87] ([213.196.213.153]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBUmD-1jfPam0ocp-00D0ug; Wed, 01
 Jul 2020 21:44:27 +0200
Date:   Wed, 1 Jul 2020 21:44:24 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "WARRELMANN, RASMUS" <rasmus.warrelmann@lhind.dlh.de>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [bug-report] Segmentation fault on git subtree push
In-Reply-To: <DB7PR09MB225265C74CACD564A82641ABCA6F0@DB7PR09MB2252.eurprd09.prod.outlook.com>
Message-ID: <nycvar.QRO.7.76.6.2007012143270.56@tvgsbejvaqbjf.bet>
References: <DB7PR09MB225265C74CACD564A82641ABCA6F0@DB7PR09MB2252.eurprd09.prod.outlook.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1513048340-1593632668=:56"
X-Provags-ID: V03:K1:VGW4Gwaqro5+m8XXeSXc6mO7o0nIhpZt9J1ntrFcCCnk6ffxZfo
 K3/wW1bFjRnZlVKnXpQ8xfjarhGN45xtbp0cYNmVWmVnPFt0omJ7LgK/wPLBzkfpOd9O86j
 /tZKSgqf17RqcR4E7SNJEATOl5wg9lV3FJiSiqNVn2+KDkIBbJ55IoU/A6Atw89v3Bihb/V
 0UVQIsSh1uTkHVDsIFC2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F6qnAv3+Wsc=:50tgzfGk8ivOT3UQGPRR78
 PzyvgS1I8/hhlW2eUsOlk5Tl5YKRSoC2Y6ZA29Rbw5Y7gIMs8bi/41Bxy5+4YjcH968/o/bY6
 Yepmagry2aioSbJOehd3ReUDPHmsxGMAFzKeoYkZNB6woZP3swutQOQklZiL2vRE+by2lf/T9
 6VtYahc4E25B9qa03sCzyAcfh2H0AxNEDRsxBVv5jHS8a3Qm4TD66dMnfkwj2odAq1AwcCaf/
 hWGTFZP34Wwsx9lK5XZXtUGFlH1Ek5kCgZ/95G/oOsdmtkogIiwhsQTDckNtb05b73Gz/Y4oL
 bSmtdwHTqNSV1J5O51LO3rZydcAq/ct5gKV2cW6Q6m+JW6ii4CdbLdzDUQvC659n9hZkPuxYC
 K0OVw2IVsZrdewfFGWUlz6SJ5vUn6IBJqDtdr9fRvoy0CBb6cY+k6ioccVgBbfLAVYToISIh5
 N+VizvfFyhsWVLKsxDNl4fpL52ynL91fjA/KCVVLowANdAAe1BFvtQ8TPnTbnwuK0F2NOMn+P
 ynuQShnNJ3RhgvvN861wP3GR/IKAoHYfwIqaHvchwEdiU0PRB22LyBGm7FujoN/cw4ViP9zex
 VUs8RB9bB6UVe+aqsCCQkzy/OCCkH3EmNG6h+g9i1i+sfMR0QMRoh2B2xKK0sa3THwtfkCg9h
 cy0Y7ymX+Fa88MEkfmee2TF+Hgc/4UXMzq6ZfoQ7iEyF/lntLToubiacIbrchBTzquo+n1V5V
 EnV366kDprhr8lClKlB9P1lHb1gKceuW6g+JwT67xNfYhNdxiiimZVze2Ta+4EWkU6Ms5+iX5
 Cmc3kRDc/xgOZ6NhpFpW++FEOOzpXDlQ+1ttLijKs+n/REJ46Q7k+GNpA5qFbmtJLJXbENQf+
 xJM0xdU0XoJVUXACbE4NjM7eoflQuZnMujGQvSQrKvyb859pbFSSCnG3FnqY+4by5fasnwCP1
 fTTytESy77MhkUG41T6SgSihnqmZgqQL3qeU5eLEDl/ZozFZVqjaqVrRjSLmqL2EfTAOO3JBg
 Y9Vyk+9Mnjk/wQN4yrwgfoKOSqDM17iMrtqY92W8IHqqYiJT02mbofJiEsOct6eUbVA4Ky5mK
 txXL7JoTlWl0rkhs+2s55M4eT2WxHBcDyIAur4s5plpL8lSoPLuCqxKsu7ljmAegGjUnhzKbW
 Qnr4knuHvH11m4Tf0d2IW6Uxtgt2So7PaqsBo7w6i45/WvCCKU8FFIoVnr7qx2HiriBxM/9nv
 jKkNgs+jJbJGTsig8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1513048340-1593632668=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Rasmus,

On Tue, 30 Jun 2020, WARRELMANN, RASMUS wrote:

> =EF=BB=BFHello,
>
> I get a segmentation error when p-repo using git subtree push. I have th=
e current version of git (2.27.0.windows.1) installed.
> The issue seems to be related to (https://stackoverflow.com/questions/57=
033081/git-subtree-push-fail-applications-xcode-app-contents-developer-usr=
-libexec-gi/61380907#61380907). The answer from Jakub Zloczewski of April =
23 suggesting to downgrade to git version 2.19.2 worked for me, but I don'=
t like to use an outdated version of git.
>
> The error message is:
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 757:  10=
44 Done                    eval "$grl"
>       1045 Segmentation fault      (core dumped) | while read rev parent=
s; do
>     process_split_commit "$rev" "$parents" 0;
> done
>
> Do you need more information on the issue?

Yes.

This needs at least an MCVE
(https://stackoverflow.com/help/minimal-reproducible-example)

Ciao,
Johannes

>
> Thanks for your help.
>
> Best reguards,
> Rasmus Warrelmann
>
>
>
> Sitz der Gesellschaft / Corporate Headquarters: Lufthansa Industry Solut=
ions AS GmbH, Norderstedt, Registereintragung / Registration: Amtsgericht =
Kiel 3688 NO
> Geschaeftsfuehrung / Management Board: Bernd Appel
>
>
>
>

--8323328-1513048340-1593632668=:56--
