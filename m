Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C785720282
	for <e@80x24.org>; Tue, 13 Jun 2017 07:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbdFMHfL (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 03:35:11 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:35615 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbdFMHfK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 03:35:10 -0400
Received: by mail-wr0-f170.google.com with SMTP id q97so129279688wrb.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 00:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qLqmQsQBmQwsKKQkaCc4ikI0KwQU8MyVfBolH8PtQbY=;
        b=pgq8Be4fSMiC22Nu2QEHjsIwqnyMaan/D07uxQiOP4VrS4AiKKS9AOeiuDL79OH6gW
         ChS2tT+MoXdmm7wqlKfqOV+ZjDOLgb14qzV9oRSTb8FeBY6HctbPo7cYPD0B0Tm7GDVh
         UH4vu8aGaG2wqH1y+6Xb7Ej1HTBtE6te57mav8L7rwg077dI7p+QyXLSe4jsu7DNuXVp
         +gzakq3DIU0HjOvLvqI0oBe4o5OSe9aZ0xJXUF3KoqsSIbRqFcB23X6zVum6i46i/Pd4
         EQLxruujdki+6bEJLMbE4ohMxHJezur7C/M0GV/zNorFpkLP/5fyAMSyzDDdkp8MNDSt
         Uymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qLqmQsQBmQwsKKQkaCc4ikI0KwQU8MyVfBolH8PtQbY=;
        b=nSFpNcUdJh09Idj0gAvYfg/r2Vy+tSNc7MW3jQ3IWInu9SGlbQi2K0xXHYjBWY/nb6
         OETMmFk0Ej9VfsOtcuKJoCOpiJwaUv76E1Haw3A4qPv4I9pqU88xbVQaT2RYBLc/BSdz
         sO5IT7oxY4vGndMyIG5xLgX6C3sR+OLuu8St08tdNOptnLupJIBAVkaJg8rsc68X7WEU
         qyKLQ31ITxPsm4qkAJ67ZwPj3L/1prsR2BAKf8tuzwnh9DBJon3L1xz+rhMHSU2+D+T7
         0w7YBLxWZrO6JInKseLQk95UVZVsMKeh9uooiCyh1MeQUNjhui+IiXLCfogMwSuC9T1n
         xrIg==
X-Gm-Message-State: AKS2vOxTEm603Aw2kQeXG7KERVdwjvzQK5DfjlkRb1glIGknvg+r9N/4
        rzhsjFkemlhb0g==
X-Received: by 10.28.65.68 with SMTP id o65mr1128408wma.68.1497339308769;
        Tue, 13 Jun 2017 00:35:08 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4C1A.dip0.t-ipconnect.de. [93.219.76.26])
        by smtp.gmail.com with ESMTPSA id c11sm5799325wrb.58.2017.06.13.00.35.07
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 00:35:08 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Fix KeyError "fileSize" in verbose mode
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq1sqpp1vv.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 13 Jun 2017 09:35:06 +0200
Cc:     Git Mailing List <git@vger.kernel.org>,
        Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B3689D6E-A6B8-42F8-9105-242178FE16E0@gmail.com>
References: <0102015c9b535a84-fd59d55d-387a-419e-b8ec-439873c4b7f5-000000@eu-west-1.amazonses.com> <xmqq1sqpp1vv.fsf@gitster.mtv.corp.google.com>
To:     Sergey Yurzin <jurzin.s@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 12 Jun 2017, at 19:11, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Sergey Yurzin <jurzin.s@gmail.com> writes:
>=20
>> Subject: Re: [PATCH] Fix KeyError "fileSize" in verbose mode
>=20
> ...
>=20
>> git-p4.py | 7 +++++--
>> 1 file changed, 5 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/git-p4.py b/git-p4.py
>> index 8d151da91b969..b3666eddf12e3 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -2523,8 +2523,11 @@ def streamOneP4File(self, file, contents):
>>         relPath =3D self.stripRepoPath(file['depotFile'], =
self.branchPrefixes)
>>         relPath =3D self.encodeWithUTF8(relPath)
>>         if verbose:
>> -            size =3D int(self.stream_file['fileSize'])
>> -            sys.stdout.write('\r%s --> %s (%i MB)\n' % =
(file['depotFile'], relPath, size/1024/1024))
>> +            if 'fileSize' in self.stream_file:
>> +                size =3D int(self.stream_file['fileSize'])
>> +                sys.stdout.write('\r%s --> %s (%i MB)\n' % =
(file['depotFile'], relPath, size/1024/1024))
>> +            else:
>> +                sys.stdout.write('\r%s --> %s\n' % =
(file['depotFile'], relPath))
>>             sys.stdout.flush()
>=20

Are you working with P4 Streams? I think I ran into the same problem
if Streams are involved and I solved it like this:

         if verbose:
-            size =3D int(self.stream_file['fileSize'])
+            if 'fileSize' in self.stream_file:
+                size =3D int(self.stream_file['fileSize'])
+            elif 'streamContentSize' in self.stream_file:
+                size =3D int(self.stream_file['streamContentSize'])
+            else:
+                size =3D 0
             sys.stdout.write('\r%s --> %s (%i MB)\n' % =
(file['depotFile'], relPath, size/1024/1024))
             sys.stdout.flush()

However "streamContentSize" is something we define ourselves elsewhere
in git-p4 and not something we get from P4. Therefore it might be
garbage. I haven't looked into it further, yet.

Your 'fileSize' check is definitively correct!

Cheers,
Lars


> I can see from your patch that self.stream_file[] sometimes may not
> have `fileSize` and when that happens the current code will barf.  I
> also can see that with your patch, the code will NOT barf but output
> would lack the size information (obviously, because it is not
> available).
>=20
> However, it is not at all obvious if this is fixing the problem or
> sweeping the problem under the rug.  The proposed log message you
> write before the patch is the ideal place to say something like
>=20
>    In such and such circumstances, it is perfectly normal that
>    P4Sync.stream_file does not know its file and lacks `fileSize`.
>    streamOneP4File() method, however, assumes that this key is
>    always available and tries to write it under the verbose mode.
>=20
>    Check the existence of the `fileSize` key and show it only when
>    available.
>=20
> Note that the above _assumes_ that a stream_file that lacks
> `fileSize` is perfectly normal; if that assumption is incorrect,
> then perhaps a real fix may be to set `fileSize` in the codepath
> that forgets to set it (I am not a git-p4 expert, and I am asking
> Luke to review this patch by CC'ing him).
>=20
> Also note that in a real log message that is helpful for future
> readers, "In such and such circumstances" in the above illustration
> needs to become a more concrete description.
>=20
> Thanks, and welcome to Git development community.
>=20
>>         (type_base, type_mods) =3D split_p4_type(file["type"])
>>=20
>> --
>> https://github.com/git/git/pull/373

