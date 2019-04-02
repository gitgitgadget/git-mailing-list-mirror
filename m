Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85E3A20248
	for <e@80x24.org>; Tue,  2 Apr 2019 18:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbfDBSUL (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 14:20:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:55165 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfDBSUL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 14:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554229200;
        bh=2QXOD9ZbZNfg+PbGGNqMCxoiAdjpKOq3Yhr5oLmhTGU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Zvjef8sKr4xDZKWF5mVHeCCt+S6dX6qVtPK/idimBmlgyTOK8tdTSZ8xJGPQO+9Gf
         NzfwNTfGIdcSxVDlzjeMD2/YAjnNWEylOSI4iDa/XeKEjooxCbCYN25M0VAjnTVkUX
         dOZHbMkPuCTgjDsWZVR0mE4fjP4BZHNPpQSU3/mI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lcjdr-1gTU5n112l-00k93H; Tue, 02
 Apr 2019 20:20:00 +0200
Date:   Tue, 2 Apr 2019 20:20:05 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Bj=C3=B6rn_Pettersson_A?= 
        <bjorn.a.pettersson@ericsson.com>
cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Bad performance when using git log --parents (used by gitk)
In-Reply-To: <HE1PR0702MB378867A3A8F81CB475882A28B0560@HE1PR0702MB3788.eurprd07.prod.outlook.com>
Message-ID: <nycvar.QRO.7.76.6.1904022017510.41@tvgsbejvaqbjf.bet>
References: <HE1PR0702MB3788FCDAB764252D9CBB42E5B0560@HE1PR0702MB3788.eurprd07.prod.outlook.com> <20190402132756.GB13141@sigill.intra.peff.net> <HE1PR0702MB378867A3A8F81CB475882A28B0560@HE1PR0702MB3788.eurprd07.prod.outlook.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-748568384-1554229206=:41"
X-Provags-ID: V03:K1:Nb9q1Sq/MQUveU/UObymGiWywWVPNoUFsfbj08GCZpOCa5ALx0E
 /TOHbzvZ0rv/dW71OxghFHp+EYyB4+OEJXbUp6OHGzLRhFbcd/q7tPuF6GIO++itgakg3cn
 e1qWCIGCe8hqBQHQedIRFmB4z1Wms0CnPCtGm5+UqHbbdZCnGTGZypXqDXy2Nk6ix6AP6qW
 xuTuoKFqCmTpcTo+DHPbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OlDkiDJjmJo=:VG7My/3+qU7Nh8MWDGwiMS
 HP5m7kYzMmA1X4+H7wqoqAUQcJWFp0qeZjwOy5jvCY8yBSfNQ2Znumfvm/tItAOBbEvBGe1VV
 4fHGGdXHjpFFPunK1rR7NI2dFNl0nE13x3uFvn1ziQY4uRVEhoWitHrr/XkUJ6I0WtRtbYrAV
 Y9wivRhrcEmUyqDNVA97qHsp5xwE0qCe5SW5BJdV60F1rky1FF1BFSgE8qM6nf5/SvPt3U4HO
 uNSAn+oNPCN1vK56eeM52qEqCWfndn4IvtHMaiGxusGO0bsGCr8XzS9tw4F8HFMabnXo2zZuh
 l84z59fC+dUy3s6/fjz+XK7UKmfHcjL6ZP9+JR24oUJqtz6qnoCTC9jor0D66jlEEe4opyQu/
 PITsnz35X4SJwTtw0l9wuhRx79Ml1lBDGMrR8m2dLNB73x9i9/m2lhF5cKKalNdpo0877KDP/
 jDHQlNWnV+r/oPmsJVCI2ZJGBmGiNRqEBmIwuTRwZLZlAqf4zLH2RhdjnApCd6C3dIK6ohhIw
 C4jHinKS4oDuYJwxFrDeOwpM8f6aaCXjeh3pGPQxQa/jDlBAaupvJMnKypleubOyOi/dqB1uO
 IN5AhzL1jw94B+iZRZxpxXXYXeNY5XSk/HCzdy7KvW9EktyoNVaEZ8039Ct+HmBZ+9z5JcQ2/
 1i6k9DmkP/Kwfsvo8NuSpX67+IOtQnh3sH3XbWx+VnmCAeb5KbWoN8tW4hOKx91UxLgfiH7MS
 9aswj9T8X5cesIdU0+D5Tg2LbXrY0GekAvYbt1sMvjZcY3zjoJt1aBa5tX5PsJDnSSDtcpNJ5
 8SeLY1rJALCqi4NJ92s/r3ELZeKNYsv/X/pnXjMJLBOAUlpGT4MvPuDt4jDpjFdKbKquUNCLd
 PT7Eu5lryn+6kmHJwA4foWWf/mGY6g4E07ejfp6PgjSohsZSsi3SiTP0I86QoBT1TJIAqEeYB
 iOCAXqzCTIw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-748568384-1554229206=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Bj=C3=B6rn,

On Tue, 2 Apr 2019, Bj=C3=B6rn Pettersson A wrote:

> Thanks for a quick reply (with lots of details).
>
> Hitting some quadratic complexity algorithm explains why the "degradatio=
n"
> is so huge. And if I understand it correctly we are more or less "unluck=
y"
> to hit such access patterns more often in the new repo.
>
> Anyway, nice to see that you already have some ideas regarding how to
> improve this.

In the meantime, maybe the commit graph feature can help you?

	git config --global core.commitGraph true
	git config --global gc.writeCommitGraph true
	git commit-graph write --reachable

The idea being that the commit graph extracts a lot of information
pre-emptively and makes the lookup of those bits faster than unpacking the
commits all the time.

Ciao,
Johannes

--8323328-748568384-1554229206=:41--
