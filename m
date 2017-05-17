Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C0D72023D
	for <e@80x24.org>; Wed, 17 May 2017 04:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751427AbdEQEXt (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 00:23:49 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34585 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbdEQEXs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 00:23:48 -0400
Received: by mail-pf0-f181.google.com with SMTP id 9so857667pfj.1
        for <git@vger.kernel.org>; Tue, 16 May 2017 21:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HX1utY976gSsOtwbSaci6JS6iGwEg7d3laf+hNyQS8A=;
        b=asugm4COPKqTnCSAooXH0GzetIxqg4zvYC7LjjSr8FLprpjlXxtET85gDv2n2ir/y9
         gy01VUK9jkj/uvOqKjDgCEMSbxQruQfJ1bam6ef4a1GVZ/bgsXkPu7WJGLkPHUHN1rVn
         o7ikSvTpJn0mQDEFb5su3E4DBclc0wwzVMbsV7jxoY58dgJUBxVuye+5zzsR7ZsDmcOF
         GAJInN983dNqeGb+qCXZMNVzvTWOMZ6+8PM3jkLPiS7M24ekErCfSP5Wv67Sn/qoQB5S
         XdsFBr3C6HeoifuAttqjK9gRd3725AyAJgBGbIl9/svanSveaSWMvps0F/Z8vpuglTBe
         3zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HX1utY976gSsOtwbSaci6JS6iGwEg7d3laf+hNyQS8A=;
        b=Q8DuBzSgX994Qc3Smsde/Pj9s0Fng4jQPvTJDnLWttFhRtBzZyQ+XE0T1evOpx7Q4Q
         91HMrdpVaxJmmwhADdiWWENAZ9N0aftTCZn+QNF2f63+3VguN3pxd/lAQ7477alS3qO0
         iom+6inZiP/Anx1FXYt9UIrXeJEq46NNuVc+KaBrM3kvXxdDFYKBGqSg/pGegwrr3BLF
         5F1l7CJibPG7DiVbXnMLgU+kzNZ6iK7tmqQye5eR0zql03hOcdLpg5iVABGA8q/fJemH
         mcPeCe+aTw8qLtAGpX8sLo++WQ+UDdLiO3ry03CwfyErdK75f8ga5xJlalQ8UihXgE56
         pjoQ==
X-Gm-Message-State: AODbwcCm2ZQLKbehUFOanQ89FRb4HJQiqvb9V7TkZoZmT/1rUsemEBZ5
        fUd5707cufXS8w==
X-Received: by 10.99.115.29 with SMTP id o29mr1676402pgc.140.1494995027378;
        Tue, 16 May 2017 21:23:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:78bf:56b6:7690:fdbd])
        by smtp.gmail.com with ESMTPSA id f24sm944483pfk.66.2017.05.16.21.23.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 21:23:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Stefan Beller <sbeller@google.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: t5545: reduced test coverage
References: <ca942ab1-db57-5794-4587-1a756686c833@ramsayjones.plus.com>
        <xmqqbmqsyzn7.fsf@gitster.mtv.corp.google.com>
        <xmqqmvacxhk0.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 17 May 2017 13:23:45 +0900
In-Reply-To: <xmqqmvacxhk0.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 17 May 2017 12:56:15 +0900")
Message-ID: <xmqqinl0xga6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> It appears to me that only a few tests in the entire script wants to
>> work with HTTP server, so perhaps moving them to the end, together
>> with the inclusion of lib-httpd and start_httpd that 438fc684 ("push
>> options: pass push options to the transport helper", 2017-02-08)
>> introduced, may be sufficient?
>
> Probably not, as lib-httpd, when it gives up, does the
> "skip_all=message; test_done" thing, which makes test_done
> to trigger this:
>
> 	# Maybe print SKIP message
> 	if test -n "$skip_all" && test $test_count -gt 0
> 	then
> 		error "Can't use skip_all after running some tests"
> 	fi
>
> So a bit more work is needed, than just moving things around, I am
> afraid...

And now I am visiting bf4b7219 ("test-lib.sh: Add check for invalid
use of 'skip_all' facility", 2012-09-01), which is yours ;-)

I am wondering what the fallouts would be if we did the following to
test-lib.  We used to say "1..0 # SKIP <why>" when we skip
everything, which is still kept, so that prove can notice why things
are skipped.

When we abort early but after executing any test, we used to error
out, but instead we pretend that the test finished right there, as
it seems that we are not allowed to say "1..4 # SKIP <why>" after
running 4 tests.

 t/test-lib.sh | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 13b5696822..46f29cf112 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -745,20 +745,25 @@ test_done () {
 	fi
 	case "$test_failure" in
 	0)
-		# Maybe print SKIP message
-		if test -n "$skip_all" && test $test_count -gt 0
-		then
-			error "Can't use skip_all after running some tests"
-		fi
-		test -z "$skip_all" || skip_all=" # SKIP $skip_all"
-
 		if test $test_external_has_tap -eq 0
 		then
 			if test $test_remaining -gt 0
 			then
 				say_color pass "# passed all $msg"
 			fi
-			say "1..$test_count$skip_all"
+
+			# Maybe print SKIP message
+			test -z "$skip_all" || skip_all="# SKIP $skip_all"
+			case "$test_count" in
+			0)			    
+				say "1..$test_count${skip_all:+ $skip_all}"
+				;;
+			*)
+				test -z "$skip_all" ||
+				say_color warn "$skip_all"
+				say "1..$test_count"
+				;;
+			esac
 		fi
 
 		test -d "$remove_trash" &&

