Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F06620D0A
	for <e@80x24.org>; Tue, 30 May 2017 04:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751061AbdE3ErB (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 00:47:01 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36033 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbdE3Eq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 00:46:59 -0400
Received: by mail-pf0-f196.google.com with SMTP id n23so15178836pfb.3
        for <git@vger.kernel.org>; Mon, 29 May 2017 21:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SWY63T8xcNgUCdbLP3HC/+nXkr56r44ueXlA+dACvdc=;
        b=O6riHzlij0iTD6ItlwIbK6vPWhM3uUYJsplIcWsW3xf1pe+nLIFtjTJ1rUJPu8JYAl
         KfthWvph5w7+Da5AkI413ykmFN8VFecE5zRVb9CNVFwl3+OyP82jVQxvsZNxYXcQWvbS
         hh/QQDeGv72s6c2vWASZoMQOcTq7WCiBEH5/DuVfnffqnLER/9K4QHZR5Kql/QclY+/8
         /MZ9GyVIaC9B7orcDkt70XogbuhTclV5DiR90RKXfz4Pl+5oyWy4KAsQzaZ6prmkGJrg
         YWmZP/GeOYDTcm/Od3GKJhykaVKUAXL3wH7CPc2d4m9YKFmXjyLrFJLC6rCRN0rLRX4Z
         zdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SWY63T8xcNgUCdbLP3HC/+nXkr56r44ueXlA+dACvdc=;
        b=UXh3lSBkbjjqPWrMKrT4gO0FK6k3/j3tPwte6oDWM1H9wY3YS3d/fHzuSR6r3LHF4C
         qPa2AFMbUcXrVYJZRG2r3uoBn/JNbv+siDY1pJ3PIX18q/KT4Ywf20KA4bTk6qnXsBv/
         cgMOv93VyOAVYBgYhuIi8sJC88bFyPLPRo57DXdF2jWnnuJC1R3kac87paM635Z7DuLs
         jiNY+/aa4wIByisaNT8IvR9e8aZMTAL5u87B0HKuaIfcP4hGYS+ROUxyFC06Kg3z+2od
         42CFdz3ePDyq/vz/3bO6h4SnXLHLo1X0W5uN8GrJT4gNIjH0K4Il+NtLb3snsPk1zAic
         ieQg==
X-Gm-Message-State: AODbwcAJ2XST+fs5ZNLlIenGjMg5ttXT8zOmaA9zV9C+AKxsq6Drd1IT
        sh8rHy1GqCrMFR3RFx8=
X-Received: by 10.99.129.66 with SMTP id t63mr22886872pgd.224.1496119614078;
        Mon, 29 May 2017 21:46:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f830:fc5f:a16b:f475])
        by smtp.gmail.com with ESMTPSA id 64sm18716773pfi.111.2017.05.29.21.46.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 May 2017 21:46:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] mingw: verify that paths are not mistaken for remote nicknames
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
        <20170526033510.1793-1-gitster@pobox.com>
        <20170526033510.1793-14-gitster@pobox.com>
        <17b3d445-0cc7-2000-dc67-11fb53c7040b@kdbg.org>
        <CACBZZX5BgVbUFEwQjHqJVfHFUitTJRaCx-Lg+j7q54uErEpqcg@mail.gmail.com>
        <34029b29-9f65-78c0-c2ed-649b179a79ac@kdbg.org>
Date:   Tue, 30 May 2017 13:46:52 +0900
In-Reply-To: <34029b29-9f65-78c0-c2ed-649b179a79ac@kdbg.org> (Johannes Sixt's
        message of "Mon, 29 May 2017 23:02:15 +0200")
Message-ID: <xmqqpoerc5oj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>> Doesn't this need test_i18ngrep?:
>
> Good catch! It would be this one in warn_on_inaccessible:
>
>>      wrapper.c:581:  warning_errno(_("unable to access '%s'"), path);
>
> But actually, I'm more worried about the unholy mix of
> one-test-first-then-skip_all-later that occurs in this test script (I
> do not mean the skip_all that is visible in the context, there are
> others later). I think there was some buzz recently that prove only
> understands a summary line that reads "1..0", but here we would see
> "1..1". What to do? Reorganize the test script? Dscho, any ideas?

For now I've queued this on top of 1/2, so that suggestions are not
lost, and then tweaked 2/2 (as context for the patch to the test
changes).  

Either an ack or a reroll is appreciated (I do not think we'd
terribly mind if this test were added to another script, or if this
test were skipped when UNC path cannot be determined even though it
does not need that prereq.  Also UNC_PATH can become prereq that is
tested by individual test in this script and the new test can be
added without requiring that prereq).

Thanks.

 t/t5580-clone-push-unc.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t5580-clone-push-unc.sh b/t/t5580-clone-push-unc.sh
index fd719a209e..944730cddc 100755
--- a/t/t5580-clone-push-unc.sh
+++ b/t/t5580-clone-push-unc.sh
@@ -8,12 +8,6 @@ if ! test_have_prereq MINGW; then
 	test_done
 fi
 
-test_expect_failure 'remote nick cannot contain backslashes' '
-	BACKSLASHED="$(pwd | tr / \\\\)" &&
-	git ls-remote "$BACKSLASHED" >out 2>err &&
-	! grep "unable to access" err
-'
-
 UNCPATH="$(pwd)"
 case "$UNCPATH" in
 [A-Z]:*)
@@ -51,4 +45,10 @@ test_expect_success push '
 	test "$rev" = "$(git rev-parse --verify refs/heads/to-push)"
 '
 
+test_expect_failure 'remote nick cannot contain backslashes' '
+	BACKSLASHED="$(pwd | tr / \\\\)" &&
+	git ls-remote "$BACKSLASHED" >out 2>err &&
+	test_i18ngrep ! "unable to access" err
+'
+
 test_done
-- 
2.13.0-493-g9105ebc082

