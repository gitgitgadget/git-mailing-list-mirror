Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5A3520282
	for <e@80x24.org>; Fri, 23 Jun 2017 18:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754625AbdFWSE2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 14:04:28 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33826 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754478AbdFWSE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 14:04:27 -0400
Received: by mail-pg0-f47.google.com with SMTP id e187so24093834pgc.1
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 11:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Dclzdqrk8npuHfWiOtXzFQ3pk8UmeYNDiC1+U0OeVpA=;
        b=ZkwFy+8uR50Xr6/t+gLJ9GQgXFtTJv9epciikYo2kwfPxg8sergJ0497s9te3seOr1
         gPemhxhS9tNLm1qAg2wVwKAf9RS7gH/tHH3On768z3cgGGeyAtikf722sg5/kPQDh8gi
         l0dMCgjsWXdQIDS+vwOQ8ljNQuednU/NELfJoumlQpNIyufm8lSXhnZ0Q7ccAUEHeRSF
         gRqGGtT2ASCJEZCLWn35HPvusZhp+e9qioChZEQkvB2M85ayy8tvzF+VsfTgBepJM6lZ
         Fd/olxdN7l2GxSP2LJGIaBVzuZ/5HSpsDIiTW0+89+QtJD6KIwk7aKEloh/+Eo6B/BC1
         mpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Dclzdqrk8npuHfWiOtXzFQ3pk8UmeYNDiC1+U0OeVpA=;
        b=lY1MwITxCDrsXfmG0m8jgN7emXJlQWv+vbFGDBgpGVnNASm8ud51HS6hkQfJTQ+436
         sWo1WFpOpF0vIRE/mo5Cv2VQ8zhq9oUiYYGeIhbN+GEOr1iKycK4a0QGe49o7vyF9aSm
         T7etJZ4PwdD29/1/IgPT6DODBUhnyT5dBntXESjZATDuiIriEppgV3Hoi96oUNG3Zjfc
         cyYY8Hm3WEvMEWQm7/pmZgc3Jz6jZzGLgDRQPCHsPbMZsG5MYKxozwgt3wNa+PnuWMSJ
         2uma5UJIoveCvv5Wvuq+TtacgaCLnfUQVTX7Vcj9SoyHAe9pKkrBpBbv7DmaefnV6gsA
         J1qg==
X-Gm-Message-State: AKS2vOzQjokp78ECWgsbca/MwwXtP5o50czBO84q1T5alIIprFf1tY1T
        zUX8yrQuD/YqV8k7kCqx2Q==
X-Received: by 10.84.171.132 with SMTP id l4mr5872464plb.175.1498241066853;
        Fri, 23 Jun 2017 11:04:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id d19sm11362194pfd.35.2017.06.23.11.04.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 11:04:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Xie <emilyxxie@gmail.com>
Cc:     git@vger.kernel.org, David Turner <novalis@novalis.org>
Subject: Re: [PATCH] pathspec: die on empty strings as pathspec
References: <20170607033308.33550-1-emilyxxie@gmail.com>
        <xmqqfuf82xr5.fsf@gitster.mtv.corp.google.com>
        <CAAin2ARfUCYM95L_k3fSQ--reQD3uMG72ah=Xg1xvvgKcU+QkQ@mail.gmail.com>
        <xmqqefubgxa3.fsf@gitster.mtv.corp.google.com>
        <xmqq60fngvky.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 23 Jun 2017 11:04:14 -0700
In-Reply-To: <xmqq60fngvky.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 22 Jun 2017 21:46:21 -0700")
Message-ID: <xmqqzicyeg2p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I am not sure if we even want the dot there, but at least that is
> what the original author of the test intended to do when s/he
> decided to pass an empty string as the pathspec.
>
>  t/t0027-auto-crlf.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'll queue the following _before_ your "final step", so that the
whole thing can be advanced to 'next' and hopefully to 'master' in
some future releases.  

Given that we ourselves did not even notice until now that one of
our scripts get broken by this "final step", even though we kept
issuing the warning message, we may want to re-think our overall
strategy for deprecation.  We've assumed that "keep behaving as
before but warn for a few years and then finally give a hard
failure" would be sufficient, but depending on how the script that
employ our programs hide the warnings from the end users, that may
not be a good enough transition strategy.

At the same time we re-think the deprecation strategy, we also need
to see if we can update our test framework to help us better.
Ideally, we could have caught this existing breakage of passing ""
as pathspec in the test soon after we went into "keep behaving as
before but warn" stage.  We didn't and found it out only when we
switched to "finally give a hard failure" stage.  That is very
unsatisfactory.

Needless to say, neither of the above two comes from _your_ change.
It's just something we need to improve in a larger scope of the
whole project I realized.

Thanks.

-- >8 --
Subject: [PATCH] t0027: do not use an empty string as a pathspec element

In an upcoming update, we will finally make an empty string illegal
as an element in a pathspec; it traditionally meant the same as ".",
i.e. include everything, so update this test that passes "" to pass
a dot instead.

At this point in the test sequence, there is no modified path that
need to be further added before committing; the working tree is
empty except for .gitattributes which was just added to the index.
So we could instead pass no pathspec, but this is a conversion more
faithful to the original.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0027-auto-crlf.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 93725895a4..e41c9b3bb2 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -322,7 +322,7 @@ test_expect_success 'setup master' '
 	echo >.gitattributes &&
 	git checkout -b master &&
 	git add .gitattributes &&
-	git commit -m "add .gitattributes" "" &&
+	git commit -m "add .gitattributes" . &&
 	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONE\nLINETWO\nLINETHREE"     >LF &&
 	printf "\$Id: 0000000000000000000000000000000000000000 \$\r\nLINEONE\r\nLINETWO\r\nLINETHREE" >CRLF &&
 	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONE\r\nLINETWO\nLINETHREE"   >CRLF_mix_LF &&
-- 
2.13.1-678-g93553a431c




