Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8B911F404
	for <e@80x24.org>; Mon, 29 Jan 2018 16:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751264AbeA2QHU (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 11:07:20 -0500
Received: from brain.meldce.com ([178.62.52.251]:52686 "EHLO brain.meldce.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750959AbeA2QHT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 11:07:19 -0500
Received: from [10.19.35.21] (unknown [2.121.255.169])
        by brain.meldce.com (Postfix) with ESMTPSA id 2D43420116;
        Mon, 29 Jan 2018 16:07:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 brain.meldce.com 2D43420116
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bytes.nz; s=mail;
        t=1517242032; bh=zpYBkqdZcY8wzd5cEsvKT5OSEhrsTPfzDO8nPQ9cWpQ=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=A9SKJcBds0pXLbCOortRBiHeV6XVKuIjbLnOUcazcqkEEIdRwruZTWogWnN2Tcw0I
         IP4RazYuGKqplqQl9cqREFVmwfjimIypOYvXyVrzYQb5zPBLPKzCdV/Z3Dmn+EtYUm
         aqtSB0vMLz0Vd5HVzIQiRUCJ//dNwTFoX41nORA8kGv79r8xI7MNZhLqDQGwtWZtuI
         2SNwacdMMsPCzERV5PzlVjq1nWqjJUHnoO6Y+p4BFHsQRKZPFq+RUnh3KZooP6sydL
         Z8SKXjDJnck7mLVrK3P6G1rnw5M5djB9cq7rCzQy/QlBgjSRynKKgVonZ+OOmAXH2a
         A7OA7D/CHo3tw==
Subject: Re: Missing ? wildcard character in gitignore documentation
To:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
References: <903a193c-0360-59bc-4d86-6470ac8dc1a8@bytes.nz>
 <000f01d39918$70009eb0$5001dc10$@nexbridge.com>
From:   Jack F <jack@bytes.nz>
X-Priority: 4 (Low)
Message-ID: <6c66708f-cd86-2c54-fc8c-b1260abfadd8@bytes.nz>
Date:   Mon, 29 Jan 2018 16:07:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <000f01d39918$70009eb0$5001dc10$@nexbridge.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ah. Yes it does. Apologies. Maybe a "See glob(7) for more pattern
matching options, including ! ? [] *"

Thank you very much.

Cheers.

From,
Jack

On 29/01/18 15:47, Randall S. Becker wrote:
> On January 29, 2018 6:30 AM, Jack F wrote:
>> I have just noticed that the documentation for gitignore is missing
>> documentation on using the ? to match any single character. I have inc=
luded
>> a example below with git version 2.14.1.
>>
>> |11:05:09 j ~/Development/ls-ignore [master] $ git status On branch
>> master Your branch is up-to-date with 'origin/master'. nothing to comm=
it,
>> working tree clean 11:05:11 j ~/Development/ls-ignore [master] $ cat
>> .gitignore *~ node_modules yarn* 11:05:21 j ~/Development/ls-ignore
>> [master] $ touch test.swo 11:05:31 j ~/Development/ls-ignore [master]?=
1 $
>> git status On branch master Your branch is up-to-date with 'origin/mas=
ter'.
>> Untracked files: (use "git add <file>..." to include in what will be c=
ommitted)
>> test.swo nothing added to commit but untracked files present (use "git=
 add"
>> to track) 11:05:35 j ~/Development/ls-ignore [master]?1 $ echo "*.sw?"=
 >>
>> .gitignore 11:05:40 j ~/Development/ls-ignore [master]=E2=89=A01 $ cat=
 .gitignore *~
>> node_modules
>> yarn* *.sw? 11:05:51 j ~/Development/ls-ignore [master]=E2=89=A01 $ gi=
t status On
>> branch master Your branch is up-to-date with 'origin/master'. Changes =
not
>> staged for commit: (use "git add <file>..." to update what will be
>> committed) (use "git checkout -- <file>..." to discard changes in work=
ing
>> directory) modified: .gitignore no changes added to commit (use "git a=
dd"
>> and/or "git commit -a")|
>>
>>
>>
>> Noticed it when checking an npm package (ignore) that uses the
>> documentation (https://git-scm.com/docs/gitignore) to determine its
>> functionality. It is documented in https://git-scm.com/book/en/v2/Git-=

>> Basics-Recording-Changes-to-the-Repository#Ignoring-Files
> The implication of support for ? is there through the following paragra=
ph from the gitignore documentation:
>
>     "Otherwise, Git treats the pattern as a shell glob suitable for con=
sumption by fnmatch(3)
>     with the FNM_PATHNAME flag: wildcards in the pattern will not match=
 a / in the
>     pathname. For example, "Documentation/*.html" matches "Documentatio=
n/git.html"
>     but not "Documentation/ppc/ppc.html" or "tools/perf/Documentation/p=
erf.html"."
>
> Of course you have to go read fnmatch(3), so it might be good for expan=
d on this here :).
>
> Cheers,
> Randall
>
> -- Brief whoami:
>  NonStop developer since approximately 211288444200000000
>  UNIX developer since approximately 421664400
> -- In my real life, I talk too much.
>
>
>

--=20
https://bytes.nz
https://keybase.io/bytesnz


