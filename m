Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4244EC7EE2F
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 14:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjFJOvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 10:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFJOvb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 10:51:31 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AC730E8
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 07:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1686408673; x=1687013473; i=l.s.r@web.de;
 bh=1fnr8nEXeuSkaREVdsIC/2C00I1XOLC334by4aVITyM=;
 h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:In-Reply-To;
 b=t51sHJFEDLxFFsG5FZXoXUAaJUk93GPfaRxQ7AcKTcwOY/+8qy62qEzQRJd1aEM4WWBLBwq
 A2/aGqeqUiUxlaF/wB+boMvURXJbCoQ2M/GfY4+dTjBKC7u/T0HvR61qjF4+7EXZ1I8fFj3lQ
 FwbVcHcVe+dvB3fL5uftB3zfyDx2KUqdDbSUEmZH4kj1qWlSwwkaV8QBz/R2oOUnjP8miOYkF
 B/v6YdYqNQu3H9hX0AnnEB+f/QPpyC1sE4cwNSI2UpZSK7+w5c4lt+SytI3ESsqTB99xDn4EF
 OH0VMOHJ3x80683IHbbGnj0tHj/JKAw70Dt/TqJN+BNWKC/C9mbg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.146.76]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmymz-1phDYU3LxX-00k6UU; Sat, 10
 Jun 2023 16:51:13 +0200
Message-ID: <14e1be60-3765-0ba5-00f5-2848bb57bf53@web.de>
Date:   Sat, 10 Jun 2023 16:51:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] t1800: loosen matching of error message for bad shebang
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <022e01d8ceb5$c2da52c0$488ef840$@nexbridge.com>
 <003501d8cf8d$21ce5ba0$656b12e0$@nexbridge.com>
 <013701d90f80$692ba9c0$3b82fd40$@nexbridge.com>
 <2e3be2e9-191d-fbfd-54c6-a3958e35637c@web.de>
 <013501d98cee$e58dc980$b0a95c80$@nexbridge.com>
 <013601d98cf2$392153c0$ab63fb40$@nexbridge.com>
 <f5519f93-bca7-ecbc-9da3-b25ce8aef618@web.de>
 <28d808e4-77b4-d91e-8a86-c21287019b56@web.de> <xmqqwn0h4ek3.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqwn0h4ek3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IMad7irnXOa0mEwYYMTxMroZ9ZcK8ByzkOUubGa3GoMGn6LeneA
 s4tfCRQtsrX4nCgumdgYqcY0/00nafWITB+P/HMvo4Pd8JBGPgVVd9tjbKgeoCii33S4ibb
 7YO9F7mM5bNb4qSUUYYjDtpD5cJB/BvqRZl4sf5xN2CoInh2/ol1CYvZbWD9UbW+4gQIPUj
 g9Dn4q6toOHLntBpzX6TQ==
UI-OutboundReport: notjunk:1;M01:P0:4475kk75aRM=;8PoWbjoItDblzfIU0awpBuQI3fX
 pBvx1xgTyR09K5ratx5QfELooNsGf0A+5tcZymXzLu9H4GmXbEzW4nvZahZep6NXSnJvazeDZ
 +AC7oNNeWcdYDZFHogGBANm7Ep9wXxlT803pjYOySInvyM6BAB5X1f7GZ1OwCurvJgVYbwhWj
 Mn3JST1uR2zVMkbgo85TKdSkz27pWJbZJdKdthRvDX6/xWiv57j9kajsiQdbZuX/DNZh+9vq/
 2N6w7hzPsa58PMhl5dm6mh0tPKHDJbTa3WuIdlVI5w8EqXNQV+OfZfHdANr1ePUYwS5BHzDaK
 qOtuyhkODVz+gG40Cpl0iKz0ZGE/3370VNXrUUQovyE7H5LeZrBDSvMtYx5rQ7w9VexlVFWyU
 +kAYVkT12jiJuwqwRxo0Nt4SwGu/u+7gzplp2e8bps3UgwtNlJUoEeOF7vc4nHmQSdpl290vd
 +GTvA8UDsOPe5jl7P0E9wATZznlrreRecBcC7/8T1znmri9z6CJlgXG6Mhopo+nyHSJAC8A8D
 UQgGlub+r/Sgj5Tpy28gZmoFDIPr4PzLFxsGHGP6z/5cThMtF72oWZvOPgwelZhQ+Z4YpRYNp
 b9MI0E5QsmBKV8h2gZK7T+UtWFTo1WPY2QPsh3iWcJdBOL1RPpM1HPHEAWRmaqVHFPYgEkaNq
 psCCzxTEuXTE3U4CoiI8ZGVFSxvngA0qfXxX/DamPw5AU23JZf3cypCmyFYuju1T4LQMwS4IW
 jpYESI0bi47y2GUSCcYm9a1TOkavcWSD40T3Krp8yNUHoEfW/EW/P1fBBaVIwu7hgaElRbELo
 vqf5Rrmg8FmoS+5jUjgJ2Jzya7sf5/zNVXo6TsIBvHEE4WvaxN+ACQrJP+qFKTS8Ywp2Kv984
 C8teA8aeAY9DJvx1XNGPBID3r7P89iKP4mIz3m/hAXuclL0RcFFuQoRtnCz+VW4MRbfHdj7xp
 WqO6IYao9As/ndhqkliMfn2UYxc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t1800.16 checks whether an attempt to run a hook script with a missing
executable in its #! line fails and reports that error.  The expected
error message differs between platforms.  The test handles two common
variants, but on NonStop OS we get a third one: "fatal: cannot exec
'bad-hooks/test-hook': ...", which causes the test to fail there.

We don't really care about the specific message text all that much here.
Use grep and a single regex with alternations to ascertain that we get
an error message (fatal or otherwise) about the failed invocation of the
hook, but don't bother checking if we get the right variant for the
platform the test is running on or whether quoting is done.  This looser
check let's the test pass on NonStop OS.

Reported-by: Randall S. Becker <randall.becker@nexbridge.ca>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t1800-hook.sh | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 3506f627b6..c156d6decc 100755
=2D-- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -156,25 +156,15 @@ test_expect_success 'git hook run a hook with a bad =
shebang' '
 	mkdir bad-hooks &&
 	write_script bad-hooks/test-hook "/bad/path/no/spaces" </dev/null &&

-	# TODO: We should emit the same (or at least a more similar)
-	# error on MINGW (essentially Git for Windows) and all other
-	# platforms.. See the OS-specific code in start_command()
-	if test_have_prereq !MINGW
-	then
-		cat >expect <<-\EOF
-		fatal: cannot run bad-hooks/test-hook: ...
-		EOF
-	else
-		cat >expect <<-\EOF
-		error: cannot spawn bad-hooks/test-hook: ...
-		EOF
-	fi &&
 	test_expect_code 1 git \
 		-c core.hooksPath=3Dbad-hooks \
 		hook run test-hook >out 2>err &&
 	test_must_be_empty out &&
-	sed -e "s/test-hook: .*/test-hook: .../" <err >actual &&
-	test_cmp expect actual
+
+	# TODO: We should emit the same (or at least a more similar)
+	# error on MINGW (essentially Git for Windows) and all other
+	# platforms.. See the OS-specific code in start_command()
+	grep -E "^(error|fatal): cannot (exec|run|spawn) .*bad-hooks/test-hook" =
err
 '

 test_expect_success 'stdin to hooks' '
=2D-
2.41.0
