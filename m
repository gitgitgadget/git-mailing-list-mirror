Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53493C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38ABF60F9D
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241111AbhI1NiG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 09:38:06 -0400
Received: from forward105o.mail.yandex.net ([37.140.190.183]:41296 "EHLO
        forward105o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241153AbhI1Nh6 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Sep 2021 09:37:58 -0400
Received: from forward100q.mail.yandex.net (forward100q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb97])
        by forward105o.mail.yandex.net (Yandex) with ESMTP id C075B4C4C1D
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 16:36:17 +0300 (MSK)
Received: from vla3-424b09af403e.qloud-c.yandex.net (vla3-424b09af403e.qloud-c.yandex.net [IPv6:2a02:6b8:c15:3511:0:640:424b:9af])
        by forward100q.mail.yandex.net (Yandex) with ESMTP id BC9726F40002
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 16:36:17 +0300 (MSK)
Received: from vla3-3dd1bd6927b2.qloud-c.yandex.net (2a02:6b8:c15:350f:0:640:3dd1:bd69 [2a02:6b8:c15:350f:0:640:3dd1:bd69])
        by vla3-424b09af403e.qloud-c.yandex.net (mxback/Yandex) with ESMTP id u2bWzdyYuI-aHESQvjn;
        Tue, 28 Sep 2021 16:36:17 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1632836177;
        bh=3+l/GN66yzNGRKiNQarRwU2lSudUGCAiVjpljDOh0fM=;
        h=Subject:To:Message-ID:From:Date;
        b=LslAFXri3vHqkA+mep4hKUmj/pmWLOcWnojbhAk2Qq/Qona4fId4EVk3ZO4+oLean
         dOMoOWSuBeefS3b3rq3f3og9LN4bqUJ/zms60mEXVZEuoDkICHOc3U5QrfQAJW69A0
         QDOSWr4YAaUO2jXqrhbYBmg0SOWgEebaRpGjvkE0=
Authentication-Results: vla3-424b09af403e.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla3-3dd1bd6927b2.qloud-c.yandex.net (smtp/Yandex) with ESMTPS id I0sP9WhW6S-aHxShs9X;
        Tue, 28 Sep 2021 16:36:17 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Tue, 28 Sep 2021 16:36:16 +0300
From:   Eugen Konkov <kes-kes@yandex.ru>
Message-ID: <691467377.20210928163616@yandex.ru>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Commit is marked as new, despite on it already on branch
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

Here is comparison of two branches. All same commits are marked as '='
But in my situaltion commit is marked as new '>'

Here is my main 'dev' branch
*   8fd53c7d (HEAD -> dev, local/dev) Merge branch 'frontend' into test-dev
|\  
| * 3da9e49c (local/frontend, frontend) 'Save/sync' button is active always
| * d192d9a7 Added library 'materialize' and facelifted the contractor table
|/  
* 0cb280f5 Do not export test data
*   ce1df25f Merge branch 'frontend' into dev
|\  
| * da78b64f Display disabled element title
| * 5f741628 Gen podio ref using document or agreement info
| * 2d756923 Added ref to 'Podio'
| * 129c972d Clean forms when load o reload the page
| * d96c45e4 Use production and test modes in parallel
| * 20bf7186 Added refs to download document and sandbox link for agreement
* | a0e338cb Display only tick for user experience
* | 2b2fb1d5 Merge branch 'frontend' into dev
|\| 
| * d868d72b Added fonts link and some changes for user experience
| * 74426fd0 Added message to say "The docn has been used. Use another docn."
| * b183803b Fill client passport form by parsed passport data
| * b40234ed Fill client form by parsed client data string
|/  
* ed3f3026 Invert data to show provider as 'true' value

Here we see our interesting commit:
a0e338cb Display only tick for user experience

Here is branch I do comparison to:
*   ec655271 (HEAD, xtucha/dev) Merge branch 'frontend' into dev
|\  
| * a6085d95 'Save/sync' button is active always
| * bbca694b Added library 'materialize' and facelifted the contractor table
| * 92103b2d Display only tick for user experience
| *   4f0a1881 Merge branch 'frontend' into dev
| |\  
* | | 0cb280f5 Do not export test data
* | |   ce1df25f Merge branch 'frontend' into dev
|\ \ \  
| | |/  
| |/|   
| * | da78b64f Display disabled element title
| * | 5f741628 Gen podio ref using document or agreement info
| * | 2d756923 Added ref to 'Podio'
| * | 129c972d Clean forms when load o reload the page
| * | d96c45e4 Use production and test modes in parallel
| * | 20bf7186 Added refs to download document and sandbox link for agreement
* | | a0e338cb Display only tick for user experience
* | | 2b2fb1d5 Merge branch 'frontend' into dev
|\| | 
| |/  
|/|   
| * d868d72b Added fonts link and some changes for user experience
| * 74426fd0 Added message to say "The docn has been used. Use another docn."
| * b183803b Fill client passport form by parsed passport data
| * b40234ed Fill client form by parsed client data string
|/  
* ed3f3026 Invert data to show provider as 'true' value


$git log --graph --decorate --pretty=oneline --abbrev-commit --cherry-mark --boundary --left-right dev...xtucha/dev
<   8fd53c7d (HEAD -> dev, local/dev) Merge branch 'frontend' into test-dev
|\  
| = 3da9e49c (local/frontend, frontend) 'Save/sync' button is active always
| = d192d9a7 Added library 'materialize' and facelifted the contractor table
|/  
| > ec655271 (xtucha/dev) Merge branch 'frontend' into dev
|/| 
| = a6085d95 'Save/sync' button is active always
| = bbca694b Added library 'materialize' and facelifted the contractor table
| > 92103b2d Display only tick for user experience
| >   4f0a1881 Merge branch 'frontend' into dev
| |\  
| | o da78b64f Display disabled element title
| o ed3f3026 Invert data to show provider as 'true' value
o 0cb280f5 Do not export test data

Here you can see that '92103b2d Display only tick for user experience' commit is marked as new

If I do explicite comarison of a0e338cb and 92103b2d, then we see that is marked as '='

git range-diff a0e338cb...92103b2d
-:  -------- > 1:  20bf7186 Added refs to download document and sandbox link for agreement
-:  -------- > 2:  d96c45e4 Use production and test modes in parallel
-:  -------- > 3:  129c972d Clean forms when load o reload the page
-:  -------- > 4:  2d756923 Added ref to 'Podio'
-:  -------- > 5:  5f741628 Gen podio ref using document or agreement info
-:  -------- > 6:  da78b64f Display disabled element title
1:  a0e338cb = 7:  92103b2d Display only tick for user experience

if I do range-diff between branches dev...xtucha/dev
git range-diff 8fd53c7d...ec655271
-:  -------- > 1:  92103b2d Display only tick for user experience
1:  d192d9a7 = 2:  bbca694b Added library 'materialize' and facelifted the contractor tabl
2:  3da9e49c = 3:  a6085d95 'Save/sync' button is active always

We again see 'Display only tick for user experience' commit as new


I think problem arise because git does not see that all three commits:
   
| | o da78b64f Display disabled element title
| o ed3f3026 Invert data to show provider as 'true' value
o 0cb280f5 Do not export test data

have same fork-point  "ed3f3026 Invert data to show provider as 'true' value"


Probably because git merge-base get analyzed only left branch and not right:
$ git merge-base ec655271 8fd53c7d
0cb280f544113926e1059568811f99c311489d4c





I expect that end of out should look like this:

| |  |
| |  * da78b64f Display disabled element title
| * |   0cb280f5 Do not export test data
| |  |
........
| |  /
---  
|/  
o ed3f3026 Invert data to show provider as 'true' value





-- 
Best regards,
Eugen Konkov

