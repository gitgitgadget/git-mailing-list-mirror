Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEFA61F428
	for <e@80x24.org>; Fri,  5 Jan 2018 22:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753290AbeAEWMr (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 17:12:47 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:44168 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753070AbeAEWMp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 17:12:45 -0500
Received: by mail-wm0-f54.google.com with SMTP id t8so4872866wmc.3
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 14:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7uGZcn2D2FgtwaC8xHHc+41LKtyPrSTQ/ykJkfI0s60=;
        b=IVmxYUWv+qhhR8nl1UfzSdVlxr8xsStja0/kfoUpia4DTQPFimwEJ3QKvGgKWoMM5b
         KsiCb3L8XN+yYePI+Uqf8R0mD9xw8cJ7nj+563UFV0SiQS1Dn/89USR50hK6vKm66xwm
         3slyp1vSbSzRYl1TYhWJcT9grgR3t2mPhGIk0J3LWtcdl2C492b41VLeKTaTl5d6RLMG
         yp4/kBhcAc4aN+/eyvoQnGDZ13KqdnFUJYZjhWRaLX++lvNv3iTZWsQJ28xxidz593KE
         UzkJOmw7yn5WNQtVvUGCSBV1cHw6e2bQ00mABNWNNk1h/a500maols00W/EfI0lKa4wq
         538w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7uGZcn2D2FgtwaC8xHHc+41LKtyPrSTQ/ykJkfI0s60=;
        b=np/+FjFFf3EHkINWXnd74b8UbPP/sIYo8fT8RH1oHfsyO6Ua65wbZ6TVShx/WK4I3u
         9AwqQ30RyNM2fDt+Ot2HJYrdO2TvJYlGeHxpFW53Vw2Z1zguKvGM835r2ivXM9nfavQ5
         bDNgprjibRV6KwiuLx/BmucNWANbSBXoFTw4zNja7uKnaT+4oBXkHgJmZ+9fXKyaNjtt
         yiANPwG0T/hjkd6RdPJfvrRLg+nKEPuvp3+VmJeMFPaZL2hglM+5ouayaj72u5HGgkzE
         sosUGkJcMl+MlUiMsJxNGzuyhlzOk8XgDHHJeCHIc2FI+uVKe0pGBZBhUgcvfnSOvlHo
         67XQ==
X-Gm-Message-State: AKGB3mJMXV2upiWtuF3zvQdC0hsjgdgQS7XWanHETSJPd1O6xyHrrVF5
        iScW6vquEyIZ6t3pgUILLeBP48rj
X-Google-Smtp-Source: ACJfBosZ8CT3ZwhpDyWU9gpbLL+w6r/bv4R7ybMGuXqXFVCR93cIMjtakQ3AIDS9V6Ar3GjyoWz4gA==
X-Received: by 10.28.218.207 with SMTP id r198mr3227006wmg.37.1515190363347;
        Fri, 05 Jan 2018 14:12:43 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e7sm5162341wrd.82.2018.01.05.14.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jan 2018 14:12:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 8/7] wildmatch test: skip file creation tests on Windows proper
Date:   Fri,  5 Jan 2018 22:12:22 +0000
Message-Id: <20180105221222.28867-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <nycvar.QRO.7.76.6.1801052133380.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1801052133380.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Skip the newly added file creation tests on Windows proper, these
already work under Cygwin, but as that involves a significant
emulation layer the results are different under Windows proper with
MinGW.

Ideally we'd get exhaustive coverage for this area on all platforms,
but having any increase in test coverage anywhere is a net
improvement.

Particularly in this case where there's no reason to suspect (aside
from perhaps odd edge case like \foo meaning C:\foo) that the actual
pattern matching engine will behave differently on Windows. The tests
can't be run due to limitations elsewhere.

The thread starting at
https://public-inbox.org/git/?q=nycvar.QRO.7.76.6.1801051622010.1337%40wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet
has more details about specific issues under Windows.

Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Fri, Jan 05 2018, Johannes Schindelin jotted:

> Hi Ævar,
>
> On Fri, 5 Jan 2018, Ævar Arnfjörð Bjarmason wrote:
>
>> On Fri, Jan 05 2018, Johannes Schindelin jotted:
>> 
>> > [...]
>> >
>> > In short: the Unix shell script t3070 manages to write what it thinks is a
>> > file called 'foo*', but Git only sees 'foo<some-undisplayable-character>'.
>> >
>> > I tried to address this problem with this patch:
>> 
>> ...I don't see any particular value in trying to do these full roundtrip
>> tests on platforms like Windows. Perhaps we should just do these on a
>> whitelist of POSIX systems for now, and leave expanding that list to
>> some future step.
>
> I don't think so. Windows is already handled as a second-class citizen, as
> if nobody developed on it. As a consequence, only very few of the
> gazillions of Windows developers... develop Git. We could worsify the
> situation, of course, but why? Shouldn't we at least pretend to try the
> opposite?

I don't think we should never test for this on MinGW, but given the
increase in test coverage, and not making perfect the enemy of the
good I think (as explained in the commit message above) that we're
better off *starting* with just disabling these tests under MinGW, and
then fixing that platform later.

> [...]
> That's all good and dandy, but what about regressions? I know how much I
> will curse in your vague direction when I encounter the next
> wildmatch-related bug in, say, half a year and have to wade through the
> jungle of unintuitive tests in t3070.

If we have a new wildmatch-related bug we'll be a lot better off with
exhaustive test coverage, even if we can only run those tests on
*nix-like platforms.

> Can't we do a lot better than this? Shouldn't it be a lot more obvious
> what the heck went wrong when running t3070 with -i -v -x?

I had something closer to that in v1 in
20171223213012.1962-7-avarab@gmail.com, but trying again I didn't find
a good way to compromise between -x readability and the entire patch
basically not being the copy/pasted code all over again, and I think
e.g. doing string interpolation into the test code would be even
nastier.

 t/t3070-wildmatch.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index f606f91acb..50a53e7a62 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -7,6 +7,14 @@ test_description='wildmatch tests'
 create_test_file() {
 	file=$1
 
+	# These tests limp along under Cygwin, but the failures on
+	# native Windows are still too many. Skip file tests there
+	# until they're sorted out.
+	if test_have_prereq MINGW
+	then
+		return 1
+	fi
+
 	case $file in
 	# `touch .` will succeed but obviously not do what we intend
 	# here.
@@ -28,7 +36,7 @@ create_test_file() {
 	*/)
 		return 1
 		;;
-	# On Windows, \ in paths is silently converted to /, which
+	# On Cygwin, \ in paths is silently converted to /, which
 	# would result in the "touch" below working, but the test
 	# itself failing. See 6fd1106aa4 ("t3700: Skip a test with
 	# backslashes in pathspec", 2009-03-13) for prior art and
-- 
2.15.1.424.g9478a66081

