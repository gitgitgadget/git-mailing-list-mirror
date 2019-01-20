Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 829181F453
	for <e@80x24.org>; Sun, 20 Jan 2019 07:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfATHyB (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Jan 2019 02:54:01 -0500
Received: from mout.web.de ([212.227.15.14]:46007 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbfATHyB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jan 2019 02:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1547970833;
        bh=E48AOvV3ddC+tAzXt45ORW9F5tBHdrHqtUIkF34vOQM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SSUUjnokCqbNVm7wcRKrE+OrOUYg1APyxW+GZF9LWs9tzpc3sJ0jb9x931aGEudJX
         lW4NynbeOvHvXuidphnjAkAG1Pm0GRyT8nAkIpVKGYSbJssZE26HC0y90imbHw0L/G
         JB+uHNqK/MGQefjMTYuw1J/rF9MsXjKSy8FPIjcE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([213.64.64.87]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LcPhu-1hSgUQ4AJ4-00jrFd; Sun, 20
 Jan 2019 08:53:53 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, szeder.dev@gmail.com,
        zhiyou.jx@alibaba-inc.com, sunshine@sunshineco.com,
        avarab@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH/RFC v2 1/1] test-lint: Only use only sed [-n] [-e command] [-f command_file]
Date:   Sun, 20 Jan 2019 08:53:50 +0100
Message-Id: <20190120075350.5950-1-tboegi@web.de>
X-Mailer: git-send-email 2.20.1.2.gb21ebb671
In-Reply-To: <20190110115704.GL4673@szeder.dev>
References: <20190110115704.GL4673@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l59sjzrgegthVPe6QttpUpsN+VR6N1+TlScxwrWiTHOMIfSc+uY
 IPGFpjcRfuhH+AJ4Yu/XCdT3ere2qwUOykDap368BNCm2VOP4uSLcI/pYxM4BXHtJzX33L0
 4p+9UUZ9GGoFF9IdFyZw/lYZoevR5/5NsnrSlgGwjxHiYi15AkaXZLaWbcu3G909FFiUscd
 Pnu+oR+fWJ4atzPcZQYNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JWGyUnRxHjw=:HJpQKahQU3qf7ayynMMu9S
 9hfiOE449uUj4Yt1l57oOnIF75gaApMhCpxP7+/yIwXSIpiYiK1JQmq8BNLjINIYVEvlaiP28
 pT+wYXfxHIWEtxcnU5WdqcK9McTAbSLHtwQKXkdJ3Z5XJ6eQJvbWovgXUTruUGGCXmqabB3fu
 +pt2/L4PBPrRpKFT0W9bP4ZA60rbGqggbxUPuhWGBGoopgLh1RJIJdXYfrtdUf9oGTdo0LkVj
 9MJjt6El2EZkRq2vbdJVUtvUMFAqXdOn8l7rBp7yxRWiUFqMlwoyMqXzU9Yj09lqCjyaRQxGq
 hyRn04blKezGILHQBVej5X3/yRpQyC7+HTtqb29hEwHeZ42KdY4HfKEd5yvl9ghYvSH+iDyA+
 STfOBC4VF+3n9dVEm1xx+DYD5bVfNkS0EL/63nFQTydW5i4KEhBtlsMHrK5vNi4gZDvGbJtOm
 EKZzdF0XOCLe30oAhSIBmnjhbf0PUaNSVvqeZPk+2+1gChThVFcRLlU2bBtEZUfHOjphnxvXL
 dkyN5v2whmg0ZYplv8Qi7kMlUwf4VKHt/qfuLsl+858X/vMJuis+4L9XGMSH1pfamts7/5HFq
 3p21e26jgnG8jLNUC5uzQuGiUdPB+SnxkjLftc/3qbDaOC5MxXPhgyQVb5AuHkRdz6hmFjsLD
 quXIaiaIY4lQ6e5l5Cb05ZudGYxsdgY3oah90N4LNoa7GB+PjLgJyPFp+319B89NNScgzTI60
 NrDpvXs0iDfLYm+8VD7za1NC1LiMihwYrc5AJD5jcHi1/tKZ8F2bUfC5L6XvbCE6qQabnUWJY
 oJWvSOjhX3y0XsYtvtE88GNs6QH8YBRlVFnMjxTOiIrAtWxGKW8ZOgZLx6+QjozqGGoKINCMk
 se/QaA1bLOm/FGtPpykLCYN4mEYkgWmQzj2Xq0/RUHE7R4VV+iH3uFCU4yezJA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten B=C3=B6gershausen <tboegi@web.de>

=46rom `man sed` (on a Mac OS X box):
The -E, -a and -i options are non-standard FreeBSD extensions and may not =
be available
on other operating systems.

=46rom `man sed` on a Linux box:
REGULAR EXPRESSIONS
       POSIX.2 BREs should be supported, but they aren't completely becaus=
e of
       performance problems.  The \n sequence in a regular expression matc=
hes the newline
       character,  and  similarly  for \a, \t, and other sequences.
       The -E option switches to using extended regular expressions instea=
d; the -E option
       has been supported for years by GNU sed, and is now included in POS=
IX.

Well, there are still a lot of systems out there, which don't support it.
Beside that, IEEE Std 1003.1TM-2017, see
http://pubs.opengroup.org/onlinepubs/9699919799/
does not mention -E either.

To be on the safe side, don't allow -E (or -r, which is GNU).
Change check-non-portable-shell.pl to only accept the portable options:
sed [-n] [-e command] [-f command_file]

Reported-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 t/check-non-portable-shell.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index b45bdac688..6c798608a9 100755
=2D-- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -35,7 +35,7 @@ sub err {
 		chomp;
 	}

-	/\bsed\s+-i/ and err 'sed -i is not portable';
+	/\bsed\s+-[^efn]\s+/ and err 'Not portable option with sed (use only [-n=
] [-e command] [-f command_file])';
 	/\becho\s+-[neE]/ and err 'echo with option is not portable (use printf)=
';
 	/^\s*declare\s+/ and err 'arrays/declare not portable';
 	/^\s*[^#]\s*which\s/ and err 'which is not portable (use type)';
=2D-
2.20.1.2.gb21ebb671

