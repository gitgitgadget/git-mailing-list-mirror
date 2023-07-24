Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4711C0015E
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 12:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjGXMgx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 08:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjGXMgv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 08:36:51 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9462E66
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 05:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690202206; x=1690807006; i=l.s.r@web.de;
 bh=t6rwo/FTqmHCsxWuRvsK8g19w6YwkG7IMlY2RSTmCLg=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=Dp3TC4kpK0sgwmgGs83za7Z5yR1GzjYBsswqkVwKJiPFW3eZ3H5v7d/vrN82srEIGif5Y8a
 fGNDpWEI9GXV/BaQoas8PjlfWbBAKtRqyMXErUPn9vgzeuyR4XkI7U8dET9RYYXvHgRcmQh9y
 zU9q4DLVs9eAOSBL433urCFUBdsNMXGbgbbeg9cbaJF+oRWwOXMrpkoCEl8MkcpP2EHlaEM1x
 ooScMPcIyuhPNTWZ9IOuPav9rijW52N+kx+B9u9/GgjaNdfkjBpqYYECIGwXagY7EpjkZhEUV
 d0teyLWTwtTK5vP78q4pWmlgb3LrluFtPIP3qyIwa/pNVus7ZBvA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M5Qq9-1qN5zP0sg1-001dgS; Mon, 24
 Jul 2023 14:36:46 +0200
Message-ID: <472f65b4-76a1-619f-269e-e8edf8f60463@web.de>
Date:   Mon, 24 Jul 2023 14:36:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: [PATCH v2 2/5] t1502, docs: disallow --no-help
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
 <xmqq351hz5xp.fsf@gitster.g> <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de>
 <xmqq4jlxuiuu.fsf@gitster.g> <4d01e971-07cb-4f11-3cc6-9d9f21e590c1@web.de>
In-Reply-To: <4d01e971-07cb-4f11-3cc6-9d9f21e590c1@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fH8DpACoszHsFIKMkaHenr8GnkH1T94afRA+2i9k7BgRrwJ+Dvw
 irKdZSWOZJTHJFPuzM1DeEyq9q0Ok3IHe+9AfgtZX82U71WH5iQzfZn3zrtIoyOSEkdWa8I
 s/7DzyIR2rD8n36KSnD6uo7Mltkq3y6FzSepVtQKBX2FmUWYrliE2X4R2J9riFe5or/ZVi2
 E8qQRbDNBCJSwAmSaL9IQ==
UI-OutboundReport: notjunk:1;M01:P0:Vkxb6p7PG+U=;s5P9Ktg0QmiIWDln/ISg06jcNt8
 0N+wSCL+otc6ulhf9zSwslEIkXLtLgg4MyPXET/F1dWelTxLIb9GdYLedO8xF+MSGVGu7IfRo
 t2lxCOI5t9HlPtQVXx8nGYlhvNJCnJ7+knU9jaWQZbni+uRMcIU3jApM8ur+N0PX2ZSnRCWz3
 R9gvfsI0UiT3uVuq8ept+sxFTm0kTWMU5oh+xQX6Gor3zt+Qfko15Q7lfzmocAyxLV2PSO5sW
 VKK+Dc+SzPzz6a3Chmgc7ppaLvlZTTZ3SsQ1mSAL9QKFhGC85RX70WtmnvEJgE5HDXXz9vVfF
 ysO4JNpi0v6UBE0K8T4yye/F+gaJLCE0YZfxM1UdMkcrScNeiI7LNZO+gdYNR+MizJk9HUvck
 GT43Uw1PxJBkXfAoiP6wPuEaPZ+uiqqueGengGk3OA56P8VXyZYh4BiEX/Hxv0s9ZR035x/Id
 bh7JYSRVC463n+13io6YsvTkm2rlFSf4THcZHtKZCS5ZJgJkWnJAN9eWxHwoMhwnTt5vIZkI6
 S/E8iaXBnxfQJ6WIfFLl+CEbsbgLGDwSgmzYNChxAqFEHH60vLuX+GINscx6BziXupK2rNJ3M
 9EZYK2tHmqkL/CuEPIEMHqfr40uMFM6vV61K2ReGN8nfeLHJviVNdS+pG8kFId3h3FI5KLyxy
 6YaMVjjoglb2np1e15+gsNjHc7UjmY0TtlTwRXHdjihBGjzzQW3oVwledRMF87X5H/J2j6xjh
 5Gb6RYBsWeGC337OZ/nzU0sKNxX89tePNrPQTS/XuLz3K3qUfinj4MCqiNk36mQUrP27xvwdX
 grpZPFfr+aJAxEJmRIdvnpXHOfDz3OGvC+xKbExcafw7anBf3w4rv9g6EcWvVgBxSpikLqL7N
 UMOUb2HHpdl254ERrGXr7ooVo98laciH9LoilSngU1k1c65aeRUHw/7lEgnLGoM8ianLssXCq
 hyH93A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git rev-parse --parseopt" handles the built-in options -h and --help,
but not --no-help.  Make test definitions and documentation examples
more realistic by disabling negation using the flag "!".

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git-rev-parse.txt | 2 +-
 t/t1502-rev-parse-parseopt.sh   | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse=
.txt
index f26a7591e3..6e8ff9ace1 100644
=2D-- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -398,7 +398,7 @@ some-command [<options>] <args>...

 some-command does foo and bar!
 --
-h,help    show the help
+h,help!   show the help

 foo       some nifty option --foo
 bar=3D      some cool option --bar with an argument
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index dd811b7fb4..0cdc6eb8b3 100755
=2D-- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -9,7 +9,7 @@ test_expect_success 'setup optionspec' '
 |
 |some-command does foo and bar!
 |--
-|h,help    show the help
+|h,help!   show the help
 |
 |foo       some nifty option --foo
 |bar=3D      some cool option --bar with an argument
@@ -288,7 +288,7 @@ test_expect_success 'test --parseopt help output: "wra=
pped" options normal "or:"
 	|    [--another-option]
 	|cmd [--yet-another-option]
 	|--
-	|h,help    show the help
+	|h,help!   show the help
 	EOF

 	sed -e "s/^|//" >expect <<-\END_EXPECT &&
@@ -322,7 +322,7 @@ test_expect_success 'test --parseopt help output: mult=
i-line blurb after empty l
 	|line
 	|blurb
 	|--
-	|h,help    show the help
+	|h,help!   show the help
 	EOF

 	sed -e "s/^|//" >expect <<-\END_EXPECT &&
=2D-
2.41.0
