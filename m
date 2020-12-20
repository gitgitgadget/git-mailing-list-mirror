Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C90C4361B
	for <git@archiver.kernel.org>; Sun, 20 Dec 2020 16:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F6BE230F9
	for <git@archiver.kernel.org>; Sun, 20 Dec 2020 16:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgLTQZZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Dec 2020 11:25:25 -0500
Received: from mout.web.de ([212.227.15.14]:41113 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbgLTQZY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Dec 2020 11:25:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1608481409;
        bh=tI7iKEBGA2mdlnr+zqwPO4WP61rR5fUj+D1w1TYkCvE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=r9iCE+DD3QqJG5YC1MSs0k6x0SW6wOclGAruMKKR1zDaFqrg2TrOIJ2yQVAN9oOO+
         Z9Sa4Ys0FLo86biH1zWwp+MbQMA19n8a2A21ox2y8U69dae216C5fuEj1RFPb3qVys
         ZSgxQKAfSJ3ooM+0xrnswTLQMcn2k4jNVnqHrP80=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqZMK-1kMJJx1Pge-00mkkp; Sun, 20
 Dec 2020 17:23:29 +0100
Subject: Re: [BUG] Regression in 'git mergetool --tool-help'
To:     Johannes Sixt <j6t@kdbg.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git List <git@vger.kernel.org>, pudinha <rogi@skylittlesystem.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <CADtb9DyozjgAsdFYL8fFBEWmq7iz4=prZYVUdH9W-J5CKVS4OA@mail.gmail.com>
 <CAMP44s15CJVGRg5Qxcgqq8xVkDhpVyxND67-iQZF9uZ_PRstEQ@mail.gmail.com>
 <xmqqczz6qs0p.fsf@gitster.c.googlers.com>
 <5fddeda8a5a92_1de0de2088a@natae.notmuch>
 <xmqqsg81pvm8.fsf@gitster.c.googlers.com>
 <c4f2330f-715b-1745-5ad7-5477f4e833db@gmail.com>
 <568f42a0-f630-64ca-9f77-183dcaa56d1e@kdbg.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a9e6f3aa-e88e-6cc2-fb16-c26bdd3bf4d3@web.de>
Date:   Sun, 20 Dec 2020 17:23:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <568f42a0-f630-64ca-9f77-183dcaa56d1e@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cWeCEHbvImgEm7KWyz/mjCNA/2/bqgZzdTQ0Ha8MpjqZOQd5HoB
 sRqEJBo9BVeo/Ek+4m2rXWXdfh+2OkN/RMJUT7vLknZ9zdmySukpIdHPfB2TyeiUk9CkgET
 +neFjWV0yhAGOrHRJSIp634UaMcINiKAzZuQZ9F3Y3mSZnRHqwJKeZAJh3g1QRdOLsHxCj2
 HZhXGrthu+FhW+19a1ACg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dqk9P5vR+zQ=:f+h4Za4Y93pw/jm6S976t+
 YWN9WmPZbR8NnL+Gz2xF/hoXNrgelYRoBIV2HDqL7TidARlAmbscY44W3031Uw6CHLXiFRdPu
 sLOuDKcJzE4MfTsPNhX1sBSF6d0GZG7Zb7zCS2vLODVpdJFJNtYbozX85/EDO1S0Hn6nbyAPH
 FpZhRYmouxiuflFe1kgkHJ+Vp4XWQL5Z1jjNLSMUq3SVRTyhUft2a8ErrgUsCnztB7DKPQj6B
 Iaah20lLKsgafQkouuYMcbTYoOgy5mWkPFYk/G5HTPqKecK6hzBKA35y9XJ0HhsRxmD3awXHS
 IGSk70CzutQLKZJiAIHsFHhsXlDgykJCKbpS/P0wHYVwJlxsfFlRERHk0+uPaxt1FwPqvz7Rr
 kk/X4YK/X3eBglMrEuJEkffIfDyguERROOdWfcq7OtFqBPP7GSP5+K2BMLT9lnQANJ3Q5IR4Q
 iNaaibmG76pLQgZRcBZgcFqL+rPWXRyUFpIHa0NQjrpfWPi0PuXwhmOz9uGS7UuThOrwpEUOL
 Qz5q7wNYbUEs6OSkpLN2l5PXUe5SXjvgEfodbWa3iWkyYdeqkoBTkrjDZOpcCxBhFJXRtOfYY
 ncYCv8Tlup3hY2s0YJJO/EXQnVp30qS/gd7NuJ79U5YdYEftBpobl2GyJ66rjPJlbljkQlkv2
 e1cYrESjcsNfqkGp/Pgrop7r3eKvXctLJYA7L89CSpEOxYnwe01sDzZSCGIYmOB5kOy5DZ/y/
 jri/Tb1vBHM8gAMRVergWui8zwSqND77pi+CWjjqpHGtHzDc262uVxMzOWvDpBIsbYV4jFK1T
 kZViwpg4QEDfz3kxw9fvrvSTzTuBK+MwOEa9NKod4GNH42crQVu7Gn5h5NkQhvLKXFbVG1sLO
 r3bex4C7zmNI1mDQwZIQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.12.20 um 11:28 schrieb Johannes Sixt:
> Am 20.12.20 um 03:13 schrieb Philippe Blain:
>> Thanks for both answers. Felipe's solution does the trick, but Junio's
>> does not;
>> it seems we do have to have a newline there. The following also works,
>> and I think
>> is portable:
>>
>> diff --git i/git-mergetool--lib.sh w/git-mergetool--lib.sh
>> index 2defef28cd..6f03975493 100644
>> --- i/git-mergetool--lib.sh
>> +++ w/git-mergetool--lib.sh
>> @@ -46,7 +46,7 @@ show_tool_names () {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while read scriptname
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 setup_tool "$scriptname" 2>/dev/null
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 var=
iants=3D"$variants$(list_tool_variants)\n"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 var=
iants=3D"$(echo "$variants" && list_tool_variants)"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 done
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 variants=3D"$(echo "$v=
ariants" | sort | uniq)"
>>
>> I figured out what was different between the different Ubuntu versions =
I
>> was testing:
>> the Ubuntu 14 and 18 systems have Bash as /bin/sh, but my Ubuntu 20 sys=
tem
>> has /usr/bin/dash as /bin/sh (the default for Ubuntu these days).
>>
>> I'll try to send a formal patch with the diff above, time permitting...
>
> If possible, please do not use sub-processes like in your suggested
> patch. How about
>
> 		variants=3D"$variants
> $(list_tool_variants)"

This still starts a subshell in the last line.  How about something
like this?

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 7225abd811..79d5ed1fa9 100644
=2D-- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -46,11 +46,9 @@ show_tool_names () {
 		while read scriptname
 		do
 			setup_tool "$scriptname" 2>/dev/null
-			variants=3D"$variants$(list_tool_variants)\n"
-		done
-		variants=3D"$(echo "$variants" | sort | uniq)"
-
-		for toolname in $variants
+			list_tool_variants
+		done | sort | uniq |
+		while read toolname
 		do
 			if setup_tool "$toolname" 2>/dev/null &&
 				(eval "$condition" "$toolname")

It requires setup_tool to be silent, though.

> It leaves a blank line at the beginning of $variants instead of the end
> and should not make a difference in the outcome of
>
> 	variants=3D"$(echo "$variants" | sort | uniq)"
>
> BTW, is `sort -u` not available everywhere?

It's used by the function mergetool_find_win32_cmd in the same file
and by several test scripts, so that shouldn't be a problem.

Ren=C3=A9
