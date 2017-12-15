Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,URI_HEX
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B97C31F407
	for <e@80x24.org>; Fri, 15 Dec 2017 15:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932260AbdLOPSr convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 15 Dec 2017 10:18:47 -0500
Received: from cisrsmtp.univ-lyon1.fr ([134.214.188.146]:52539 "EHLO
        cisrsmtp.univ-lyon1.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932250AbdLOPSo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 10:18:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTP id 07A60A0181;
        Fri, 15 Dec 2017 16:18:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at cisrsmtp.univ-lyon1.fr
Received: from cisrsmtp.univ-lyon1.fr ([127.0.0.1])
        by localhost (cisrsmtp.univ-lyon1.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4FbFnriqNItE; Fri, 15 Dec 2017 16:18:42 +0100 (CET)
Received: from BEMBX2013-01.univ-lyon1.fr (bembx2013-01.univ-lyon1.fr [134.214.201.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTPS id 45AA4A015B;
        Fri, 15 Dec 2017 16:18:42 +0100 (CET)
Received: from BEMBX2013-01.univ-lyon1.fr (134.214.201.247) by
 BEMBX2013-01.univ-lyon1.fr (134.214.201.247) with Microsoft SMTP Server (TLS)
 id 15.0.1263.5; Fri, 15 Dec 2017 16:18:41 +0100
Received: from BEMBX2013-01.univ-lyon1.fr ([fe80::b1ea:14ef:61b9:d4cd]) by
 BEMBX2013-01.univ-lyon1.fr ([fe80::b1ea:14ef:61b9:d4cd%15]) with mapi id
 15.00.1263.000; Fri, 15 Dec 2017 16:18:41 +0100
From:   ALBERTIN TIMOTHEE p1514771 <timothee.albertin@etu.univ-lyon1.fr>
To:     MOY MATTHIEU <matthieu.moy@univ-lyon1.fr>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jordan DE GEA <jordan.de-gea@grenoble-inp.org>,
        "PAYRE NATHAN p1508475" <nathan.payre@etu.univ-lyon1.fr>,
        "BENSOUSSAN--BOHM DANIEL p1507430" 
        <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
Subject: RE: [PATCH v2] doc: add triangular workflow
Thread-Topic: [PATCH v2] doc: add triangular workflow
Thread-Index: AQHTdOzJb7DwFrQEtUaHSO/jj67o3KNEhgCG
Date:   Fri, 15 Dec 2017 15:18:41 +0000
Message-ID: <1513354712419.77557@etu.univ-lyon1.fr>
References: <1512034932-14499-1-git-send-email-timothee.albertin@etu.univ-lyon1.fr>
 <9a0556ac403845f39a564bbc55df5b3a@BPMBX2013-01.univ-lyon1.fr>,<1547311095.1194033.1513263844281.JavaMail.zimbra@inria.fr>
In-Reply-To: <1547311095.1194033.1513263844281.JavaMail.zimbra@inria.fr>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [134.214.126.172]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


>> +
>> +........................................
>> +------------------               -----------------
>> +| UPSTREAM       |  maintainer   | PUBLISH       |
>> +|                |- - - - - - - -|               |
>> +------------------      <-       -----------------
>> +              \                     /
>> +               \                   /
>> +        fetch | \                 / ^ push
>> +              v  \               /  |
>> +                  \             /
>> +                   -------------
>> +                   |   LOCAL   |
>> +                   -------------

>This kind of diagram deserves a bit of text to explain the situation.
>For example, LOCAL is local only for the contributor (the maintainer
>doesn't need to know about it for example). I'd add a sentence to
>explain that this gives the overall view on the flow, from the point
>of view of a contributor.

Ok, we'll do that

>> +* `git push`

>This will push to UPSTREAM, right?

Yes, we will specify it.

>> +Adding **UPSTREAM** remote:
>> +
>> +===================================
>> +`git remote add upstream <UPSTREAM_url>`
>> +===================================

>In which circumstance shall one write this? If you don't say it, the
>reader will probably assume that this is to be done after the commands
>you specified right above. But then: it doesn't make sense. You've
>just cloned from UPSTREAM, you already have the UPSTREAM remote.

Indeed, we just remove it.

>> +For each branch requiring a triangular workflow, set
>> +`branch.<branch>.remote` and `branch.<branch>.pushRemote` to set up
>> +the **UPSTREAM** and **PUBLISH** repositories.

>This neither tells me how to set the variables, nor what the effect
>will be ("set up"?).

We'll fix that in the next patch.

>> +Example with master as <branch>:
>> +===================================
>> +* `git config branch.master.remote upstream`
>> +* `git config branch.master.pushRemote origin`
>> +===================================

>origin is the remote you've cloned from. From the text above, I guess
>you meant it to point to PUBLISH. But all the examples "git clone" you
>gave are from UPSTREAM.

>You're mixing the case where one "git clone"s from UPSTREAM and "git
>remode add"s PUBLISH, and the converse. Both are possible, but the
>"origin" remote will be different depending on which one you chose.

I think I don't really get it. IMHO UPSTREAM is name from the repository
you pull from and PUBLISH from the repositiry you push to.

>> +Making your work available
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +The `git push` command sends commits to the **PUBLISH** repository and not to
>> +the **UPSTREAM** thanks to the configuration you did earlier with the
>> +`git config remote.pushdefault origin` command.

>This explanation should be next to the place where you recommend
>setting remote.pushdefault.

Done.

>> +When a contributor pushes something, the `git config push.default
>> +current` command can be used to specify that the name of the
>> +**PUBLISH** branch is the same as the name of the **LOCAL** one.

>I already said it multiple times, but I don't think it's a good idea
>to recommend changing push.default. The default, "simple", was
>specifically designed to be appropriate for triangular workflow:

  >http://git.661346.n2.nabble.com/PATCH-0-6-push-default-in-the-triangular-world-td7589907.html
  >(PATCH 3/6 in particular)

>You may disagree with me, but then please explain your motivation (by
>replying to my messages and/or by explaining the rationale in the
>commit message).

I read this discussion and so I understand the point here. I agree we
shouldn't recommend this.

>> +=================================
>> +`git rev-parse --abbrev-ref @{push}`
>> +=================================
>> +
>> +.Display the fetch remote's name:
>> +[caption="Recipe: "]
>> +
>> +===================================
>> +`git rev-parse --abbrev-ref @{upstream}`
>> +===================================

>I don't think "rev-parse" is the best example to give.

>I use @{upstream} all the time to see what commits I have which aren't
>in upstream yet:

  >git log @{upstream}..

git log seems a better exemple.

We are ok we the rest of the review


Thank you for your time

Timothée Albertin
