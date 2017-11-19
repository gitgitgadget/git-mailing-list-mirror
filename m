Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED2B6202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 18:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751194AbdKSSE2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 13:04:28 -0500
Received: from mr26p44im-ztdg08103301.me.com ([17.111.247.49]:21933 "EHLO
        mr26p44im-ztdg08103301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751189AbdKSSE1 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2017 13:04:27 -0500
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Nov 2017 13:04:27 EST
Received: from process-dkim-sign-daemon.mr26p44im-ztdg08103301.me.com by
 mr26p44im-ztdg08103301.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0OZO00900CONOC00@mr26p44im-ztdg08103301.me.com> for
 git@vger.kernel.org; Sun, 19 Nov 2017 17:04:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;     s=04042017;
 t=1511111066;  bh=ZeOT+OGH1EBp1fpZSJKpB1wU9nt8f7p6arniSdMpu10=;
        h=From:Content-type:MIME-version:Subject:Message-id:Date:To;
        b=r018aROQfs6h/dKbIX8CA6AXOc7YZoRhb0IKQlbH0c7DjCjqyELawy243wY3YTnaZ
 qNg8RXJm2SHGZGDa3uFaPTO3kUCH8mS2NKnhjYUxcGAeN0jWk1SYtfUJ8SR2keNo3t
 4Lp39jBK7ps938M/1erCArFl7s2DNhIiS2ZW+bBlYfLefWzq+4YkfvCwroWz+IjxrR
 3+7cofT+YprCzqFCxfGj2YQYD5S0kLgkqKGn8dWYPuXgy+T2iCpPfukyCmxBGNiVBP
 4/YbHqxsUxC+ALo91rESxNmtJXIx4hkF0zGYgvBf3OWpH4UAPfRzgWQpD8adOx0CWe
 voUcOd6D6g0+A==
Received: from icloud.com ([127.0.0.1]) by mr26p44im-ztdg08103301.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) with ESMTPSA id <0OZO00NZTCRAXF00@mr26p44im-ztdg08103301.me.com>; Sun,
 19 Nov 2017 17:04:26 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2017-11-19_05:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1711190241
From:   Ilya Kantor <ilya.a.kantor@icloud.com>
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: quoted-printable
MIME-version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Why gc --auto is called so rarely?
Message-id: <C47F730C-18AE-411E-AC57-2DA8625451C4@icloud.com>
Date:   Sun, 19 Nov 2017 20:04:21 +0300
Cc:     git@vger.kernel.org
To:     =?utf-8?B?0JzQvtC5INCl0L7RgNCy0LDRgtC40Y8=?= <iliakan@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

...It seems sane to git gc --auto from command that are expected to take =
time.

That's probably the reason why it's not called on commits and called on =
receive-pack.=20

But then why call it on merges? Especially on those that have no =
conflicts and should run fast.
Also, merges are not supposed to introduce unreachable objects.

P.S. The old gmane discussion referenced by some previous posts on this =
subject is lost.

