Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A90B91F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 09:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbeKLTrb convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 12 Nov 2018 14:47:31 -0500
Received: from mut-mta1-se01a-zose1-fr.yulpa.io ([185.49.21.248]:54984 "EHLO
        mut-mta1-se01a-zose1-fr.yulpa.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725873AbeKLTrb (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Nov 2018 14:47:31 -0500
X-Greylist: delayed 2764 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Nov 2018 14:47:30 EST
Received: from mut-zose1-mta-hub-out01-fr.yulpa.io ([185.49.20.54] helo=mut-zose1-mta-hub-outweb01b-fr.yulpa.io)
        by mut-mta1-se01b-fr.yulpa.io with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <matthieu.moy@matthieu-moy.fr>)
        id 1gM8DG-000H4a-J5; Mon, 12 Nov 2018 10:09:04 +0100
Received: from localhost (localhost [127.0.0.1])
        by mut-zose1-mta-hub-outweb01b-fr.yulpa.io (Postfix) with ESMTP id 0094B102033;
        Mon, 12 Nov 2018 10:08:52 +0100 (CET)
Received: from mut-zose1-mta-hub-outweb01b-fr.yulpa.io ([127.0.0.1])
        by localhost (mut-zose1-mta-hub-outweb01b-fr.yulpa.io [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8ER8TcSKAtl2; Mon, 12 Nov 2018 10:08:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mut-zose1-mta-hub-outweb01b-fr.yulpa.io (Postfix) with ESMTP id 66612102046;
        Mon, 12 Nov 2018 10:08:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at mut-zose1.yulpa.io
Received: from mut-zose1-mta-hub-outweb01b-fr.yulpa.io ([127.0.0.1])
        by localhost (mut-zose1-mta-hub-outweb01b-fr.yulpa.io [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id a1m4G_JJTaYb; Mon, 12 Nov 2018 10:08:51 +0100 (CET)
Received: from zose-store11.web4all.fr (zose-store11.web4all.fr [10.101.13.41])
        by mut-zose1-mta-hub-outweb01b-fr.yulpa.io (Postfix) with ESMTP id 39076102033;
        Mon, 12 Nov 2018 10:08:51 +0100 (CET)
Date:   Mon, 12 Nov 2018 10:08:51 +0100 (CET)
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     Per Lundberg <per.lundberg@hibox.tv>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, jost@tcs.ifi.lmu.de,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Junio C Hamano <gitster@pobox.com>,
        Clemens Buchacher <drizzd@gmx.net>,
        "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Message-ID: <1205132135.1189562.1542013731020.JavaMail.zimbra@matthieu-moy.fr>
In-Reply-To: <591ab1f7-ef39-13e5-83b8-76fe372ecc2c@hibox.tv>
References: <875zxa6xzp.fsf@evledraar.gmail.com> <20181111095254.30473-1-pclouds@gmail.com> <871s7r4wuv.fsf@evledraar.gmail.com> <CACsJy8CYpuc7-CZhk7kQQVQFxOfLFZu4TVpG=b0a7j8P1J394Q@mail.gmail.com> <591ab1f7-ef39-13e5-83b8-76fe372ecc2c@hibox.tv>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Mailer: Zimbra 8.8.9_GA_3019 (ZimbraWebClient - FF63 (Linux)/8.8.9_GA_3019)
Thread-Topic: Introduce "precious" file concept
Thread-Index: AQHUebrNrQJxbaGKnUecpgicPjXQo6VKtoSAgAEKlYDQQjhiUQ==
X-Originating-IP: 185.49.20.54
X-yulPa-Domain: mut-zose1.yulpa.io
X-yulPa-Username: 185.49.20.54
Authentication-Results: yulpa.io; auth=pass smtp.auth=185.49.20.54@mut-zose1.yulpa.io
X-yulPa-Outgoing-Class: ham
X-yulPa-Outgoing-Evidence: Combined (0.19)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5ilwZWR5hHm4eYfL7znQDzt602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvOwrYoqzMxT6gMCeBPAUkqyTd0OdycLrFwplXhuDK90+d0K1OjpbLkxRIIIitSw0kgWU1
 4rbI/TN8RgeeDQjOMw5UXyCr4vWvOHKd6wZekJLCR6XcmIYRik09yurxqi70msPAk9r6k6fm6gF4
 gK7rShlAJ9vJeTIIg5zgcQb6a5UUxwpc6A9OD4Fn8U9VXRPNJNcPxYVfHEFkjqep3NcqYEMyGKze
 weAAkylM4jos6ydwt8C9mOBdONdnsxgsk1D2p+Yf/nImmE+hRE1rrEKLsybAyhuu1SrWhb6tluvw
 1gUx58fMnqZUTt7CyKlJUh+zhl5ldCgFJoY+LjdOQUQASMaMGiM4lWTK9XyzHsozIwC6Dp+eCZHp
 Uq8aFg88BZTPuefTkX1GtLhBHnbSgy+bSE07V5XdAaVhb6PzwedoXgk7eojJCimrFgJg48+TIHuv
 ZQwGQ2wFFUfjD6l0r5nXfjPv3fM0+/vnClcH0d6jCvbhELMC8D3yOaf6fqqXzbGFIkVhMYrVULd4
 VQ4Of3YsWUZY7deLHDlPwleoMjQLxaFAdq34LtyaOXfPkPsThccJNwJn/WIwozFfxoIYVJyQ2PTs
 bb/6LV2j8CFMbRsbZTK411fxLt3slfjzwGSwcEaad6SoOE974E0u5C4r82NtIfsPL+7rCDgcgnaw
 rfesEAde8fMw35OKN+o5n0cyixWW145fVifF+NWlUZRfW+mgLoNoh9VoIekQHpwUfpYnEThmjoa3
 MWrGdnDybMVzwlTIqY1UWRTuoMc0srHG/toabEFFYt5N+vRTLsnqjn/NT1Yuagur5vmmmHUHQFg8
 u1a0lGNRzv/xHPLKBT66EN3p0kgywSTBNJoTk8u2l/Yj0gceqK8aQ0XZqGSxS5jtUtB4mK9OnGUJ
 PfR69O7mS4M7RdKxzDtA9C+Pr25CUChQaAJxmmCNgsKGWSYPj4LAObAH1lM5o3SmpEgs3d0KRYf8
 Xm28LPMQqfGAjxUwgXlAQo44OJkgZVm1mDtBe8oc+Wpm0mPl5pzTrUs+QVfAE1oAasCrxuSn2DJ/
 QMexCXMtoywQafnCRpB1wyqTi749ASgh/UkL8FjYphVBCZHqFNgy1p9Lzk1cYEEpRhY6qTDNHAGb
 Bdi9lZ1rQxfGtDhQpBr/7oUd1sHKnHeyYVXDFjxe3lYfLIn41GZ5QQUtpQ5vVECSJWRZJkkBrrHD
 e4KkET3hmm/XpH02IrofntHHep5nHOM=
X-Report-Abuse-To: spam@mut-mta1-se01a-fr.yulpa.io
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Per Lundberg" <per.lundberg@hibox.tv> wrote:

> On 11/11/18 5:41 PM, Duy Nguyen wrote:
> > On Sun, Nov 11, 2018 at 1:33 PM Ævar Arnfjörð Bjarmason
> > <avarab@gmail.com> wrote:
>
> >> That will lose no data, and in the very rare cases where a checkout of
> >> tracked files would overwrite an ignored pattern, we can just error out
> >> (as we do with the "Ok to overwrite" branch removed) and tell the user
> >> to delete the files to proceed.
> > There's also the other side of the coin. If this refuse to overwrite
> > triggers too often, it can become an annoyance.

I may have missed some cases, but to me the cases when checkout may try
to overwrite an ignored file are essentially:

* Someone "git add"ed a file meant to be ignored by mistake (e.g.
  "git add -f *.o").

* A file that was meant to be kept private (e.g. config.mak.dev) ends
  up being tracked. This may happen when we find a way to make per-developer
  settings the same for everyone.

I both cases I'd want at least to be notified that something is going on,
and in the second I'd probably want to keep my local file around.

> If we feel thrashable is stretching it too far (which I don't think it
> is), we could add a "core.ignore_files_are_trashable" setting that
> brings back the old semantics, for those who have a strong feeling about it.

May I remind an idea I sugested in an old thread: add an intermediate level
where ignored files to be overwritten are renamed (eg. foo -> foo~ like Emacs'
backup files):

https://public-inbox.org/git/vpqd3t9656k.fsf@bauges.imag.fr/

One advantage of the "rename" behavior is that it's safer that the current,
but still not very disturbing for people who like the current behavior. This
makes it a good candidate for a default behavior.

This could come in complement with this thread's "precious" concept:

* If you know what you're doing and know that such or such file is precious,
  mark it as such and Git will never overwrite it.

* If you don't know about precious files, just keep the default setting and
  the worse that can happen is to get your file overwritten with a bakup
  of the old version kept around.

This would probably play better with a notion of "precious" files than with
a notion of "trashable" files.

-- 
Matthieu Moy
https://matthieu-moy.fr/
