Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FB1C1F404
	for <e@80x24.org>; Sun,  7 Jan 2018 13:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753946AbeAGNpv (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 08:45:51 -0500
Received: from mail-pl0-f53.google.com ([209.85.160.53]:35519 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753935AbeAGNpu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 08:45:50 -0500
Received: by mail-pl0-f53.google.com with SMTP id b96so6081766pli.2
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 05:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version;
        bh=1IURKYxBZy+8Yzz9nyoFFD5B1UxClNe1ohvTLjU7oJs=;
        b=b3/OBYJFrTXpATjRM0FTE0SuSj6QhbshmGXiVNN+TJBfTq76gaNGiTzj7pg0PMCCYr
         wfafZrnZQCxGZ8BvGgrCXGes6HIVx7m8jEBGi0fQjHorEJj3eMeW2z6YqFaz3mVIAEZZ
         /67QOZPNLYmEVLIXcn+pok9+F9Lgch62TnQjz/CKGiIsIdzFE5o6dx/3ZcFlV+3bGKj6
         R8fhPItidE6Gokh4MPkOaojJxP4xQRWw29v9Tt/cUhcuqp7F2ReTxd9r9mFc1nqp7StR
         BC2qB0p3XRbS7LLnQhHXnqL3Tg57jLABTPJXR+/Fk+TdUcnwC9yIGcNABI7ib6FmlKNJ
         jfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version;
        bh=1IURKYxBZy+8Yzz9nyoFFD5B1UxClNe1ohvTLjU7oJs=;
        b=HfdPWU9RZ9pLKDFwdLlv2yCFldf4mQAKOYnnZXvDHbm3aNqjvc5JAXrZbiGbk6QWx3
         7A703v0HXA/eIggm1kWY73XhQFfHRRPE5IV2DQJRXXM/jG8x8v1ixRjGCkZpB/POPjjc
         AdT2UUMQaI4hCET5HKcbKZfSKCucoNZYAx765xPmKQW1OSw48gKsCTQakcpEUjgGzZ5O
         Mt2bEynEIKhRtmF0bK2eXygFQXpGUNSdiQZ4nH+RBdDNScF+H3tqDEGzmkCo0Z8S7ApD
         yTHmuie+7qmMWOgez2ZN7kwDzHp3uXGKI7Ks7l2f6cG79oqXgsE6AKAq9MSzkzVvad/3
         Bivw==
X-Gm-Message-State: AKGB3mKdQ5z6UNpz4eukGMAvCPSzFSM04H7ulgniH59lD6kr33heJgUG
        in488KsIR0zku8p70k+0Q6HtAOSe
X-Google-Smtp-Source: ACJfBovHe0fdvwIgmcYU32vSK5mwjgAPOfwvfQWrV4lr043D1T8NOYwdqQKqjDUESMP1ZuXr5fd0Gg==
X-Received: by 10.84.245.151 with SMTP id j23mr9244936pll.232.1515332749833;
        Sun, 07 Jan 2018 05:45:49 -0800 (PST)
Received: from [192.168.206.100] ([117.209.170.57])
        by smtp.gmail.com with ESMTPSA id z5sm9448302pgs.18.2018.01.07.05.45.46
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jan 2018 05:45:48 -0800 (PST)
To:     Git Mailing list <git@vger.kernel.org>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [BUG] "git stash -p" doesn't work well when splitting nearby changes
Message-ID: <aa43f1ff-9095-fb4d-43bc-bf8283b7dabb@gmail.com>
Date:   Sun, 7 Jan 2018 19:15:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xFWabpCUGg2HOfYDrjczM4anxUMVnhekH"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xFWabpCUGg2HOfYDrjczM4anxUMVnhekH
Content-Type: multipart/mixed; boundary="A4Cu8lvjs5mrHZYemuWIaG8xRaOLizwSU";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Git Mailing list <git@vger.kernel.org>
Message-ID: <aa43f1ff-9095-fb4d-43bc-bf8283b7dabb@gmail.com>
Subject: [BUG] "git stash -p" doesn't work well when splitting nearby changes

--A4Cu8lvjs5mrHZYemuWIaG8xRaOLizwSU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

I recently made two changes to nearby lines (approx. 3 lines b/w them)
in a file and wanted to stash one part of it and not the other. I tried
to use "git stash -p" for this. I split the hunk of concern (of course,
they came out as a single hunk) and gave 'y' for one and 'n' for the
other. The stash was created successfully but the discarding that change
from the work tree failed with the following error,

error: patch failed: Documentation/gitsubmodules.txt:57
error: Documentation/gitsubmodules.txt: patch does not apply
Cannot remove worktree changes

I guess this a bug that has been for a very long time now (I generally
use the one built from 'next' but this error occurs even if I use 2.11)?
Or is this intentional? I couldn't glean any reason for that, though.

In case you need a reproduction recipe,

git init stash-patch-test &&
cd stash-patch-test &&
echo 'Let us put some lines to ensure
Git would allow us to split
a change we make
to this text.
It should be a little longer, I guess.
A little more.
Almost there.
And DONE.' >test-files &&
git add . &&
git commit -m "Initial commit"


Apply this patch or do something similar to what it does,

diff --git a/test-files b/test-files
index daa67cf..d3142e7 100644
--- a/test-files
+++ b/test-files
@@ -1,7 +1,7 @@
-Let us put some lines to ensure
+Let's put some lines to ensure
 Git would allow us to split
 a change we make
-to this text.
+to this text
 It should be a little longer, I guess.
 A little more.
 Almost there.

Then,

$ git stash -p
diff --git a/test-files b/test-files
index daa67cf..d3142e7 100644
--- a/test-files
+++ b/test-files
@@ -1,7 +1,7 @@
-Let us put some lines to ensure
+Let's put some lines to ensure
 Git would allow us to split
 a change we make
-to this text.
+to this text
 It should be a little longer, I guess.
 A little more.
 Almost there.
Stash this hunk [y,n,q,a,d,/,s,e,?]? s
Split into 2 hunks.
@@ -1,3 +1,3 @@
-Let us put some lines to ensure
+Let's put some lines to ensure
 Git would allow us to split
 a change we make
Stash this hunk [y,n,q,a,d,/,j,J,g,e,?]? n
@@ -2,6 +2,6 @@
 Git would allow us to split
 a change we make
-to this text.
+to this text
 It should be a little longer, I guess.
 A little more.
 Almost there.
Stash this hunk [y,n,q,a,d,/,K,g,e,?]? y

Saved working directory and index state WIP on master: f0dff20 Initial
commit
error: patch failed: test-files:1
error: test-files: patch does not apply
Cannot remove worktree changes



--=20
Kaartic

Quote: "Be creative. Be adventurous. Be original. And above all else, be
young." - Wonder Woman


--A4Cu8lvjs5mrHZYemuWIaG8xRaOLizwSU--

--xFWabpCUGg2HOfYDrjczM4anxUMVnhekH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlpSJIQbHGthYXJ0aWMu
c2l2YXJhYW1AZ21haWwuY29tAAoJEL3nWtrD1hlpUoUP/0mDLqOcvT94zz/+9ENm
vD6AH2cO+rPzoTaY7+LimA3BcNXzId0ykwt1glpj7B/XC1KJFJZDJwOuM6Xutikf
2V1Wtxi/KBgUXEJcgk8bSTqLmyaDQucTnwC35JaP6EZTzNXn+7f1k4mZ4RY1iYP3
OJJsZV/mpJkywWs0maOMBylJ2LpTTK9QVVH+5luVvkOR9DSQhv9fFmTc9/9cfutA
Ek+OaVyxPjHC0f8CzZqDrabayez4ikLlgMsZtW327fddtForLJO86epWBJSux45V
/9La/qSG1XVFc7D/w1zPYKpDps2suSfLHnItJmW8wOqCVuDk3817ReebzVYSPa6I
Y/0ZLBYmsnFr9soGilWX3+JvSVMVMvMXgzj/IQXOWB1Sdkn4FCKLiywhiAivFrhn
on0GUs+JrkUi+vWmcEA7c6WnMHpjMREXUKFhbxNu3/H2+S4Pd1NZyh453Ryy/YQ7
R0tp41uvIZ1iVavH3Tc5PpU9RmafnImH76lQ2Px89h+RPmqEEYSTS8kv2VTddyoD
MHIElQCnH44U+CBrVO6jB1Hm78JLw8lMG4ayC8OQnBMQhR8FA8+qbRp5EmAcuHbw
UZAw2fo62G2A++6fhbolGFUrt4KUy0ubUjB2Y2bCksJBkF6Lc8eVdRlas1xMPbrI
cLMnGKYJDKPM1MrQ641e2qg2
=IL5J
-----END PGP SIGNATURE-----

--xFWabpCUGg2HOfYDrjczM4anxUMVnhekH--
