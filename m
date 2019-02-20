Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0364E1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 19:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfBTTmB (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 14:42:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35748 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfBTTmB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 14:42:01 -0500
Received: by mail-wr1-f66.google.com with SMTP id t18so27483016wrx.2
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 11:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LJCCSiKFgUp/G2x8lwmdrJWMozvUF5SE2HZdiesV8ww=;
        b=cfWHFzXhMj/65iSl8LGEvhYk7RVfbPi8e+aICn1uXRuR+DFw+i+G+RufsG24ltgqKR
         siPUL1C2/GI5iKEYbdlzXrThpFSCgvhZxZnrVopjQG4RWF4cpoVFcXVgaf1W5WgAvWKe
         7Xy7O6RNu7Gb0+KWHc6rlW1vxOWj0fChdSR0eNRE1IZ661rI6+FCx823pn15OR3DpBDn
         k4EQKkaGPzkIANhBMlW2YNHmvfSshucMN8KcGGo/ZQF/Ny8+DyOZJ9b0ZpN4lv6wJN22
         02R8UT74r75Md6Byehq7x3cX6IWHkxFG6abdAlJCH7qZFQNHReT99+eDYAzbdCMMQxtt
         uP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LJCCSiKFgUp/G2x8lwmdrJWMozvUF5SE2HZdiesV8ww=;
        b=Q+aUnMv/meWyjYudTAaehuRUXLqWT66ECLCw8HnYxm9HWSzspe+rJibSEvRiWAsge7
         VWJS9gfS2FSnE9EbUH/cexdBkycsp2ZKGMDypf/VDbXdbynGZHWUwZp52LRfbErIIzZA
         pWcbjO2A3iYx+5ImTTWaEsFBJNnyqlVYy20YXHnbVTbaaGHJYlSUKdD5bipUhh7QXnaE
         t2pooVXgFUD1DJ2lLla5rBgCNyXYTXI4cB1Y55Dutk1/6oTbLBMZ11jRHfYDGUpnfOzQ
         Z6n0MPNKUDm2fj7TWYeKKEttDgG+1Bsk1jDgzoZwTsN38ovMWruySJhFCnbUA+7YyTmL
         sdJg==
X-Gm-Message-State: AHQUAuYk9IjlRS7TaNJiM5ttmmlTbGkTno9dkqPIrVPGSvLhFWo0FldK
        i+kfUjQCiRYzn3UDgk0nyiA=
X-Google-Smtp-Source: AHgI3IabEoBAOlAfq7zezUWpXHEcxkfIEvz4Sc1iloPt3Y4jjnEJEOqmgiyJY6n81fsLvKr0xyt9XA==
X-Received: by 2002:a5d:6b8f:: with SMTP id n15mr26315100wrx.110.1550691718421;
        Wed, 20 Feb 2019 11:41:58 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b3sm12576448wme.27.2019.02.20.11.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 11:41:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.21.0-rc2
References: <xmqq8sybz7b2.fsf@gitster-ct.c.googlers.com>
        <012601d4c8b5$54f1b730$fed52590$@nexbridge.com>
Date:   Wed, 20 Feb 2019 11:41:55 -0800
In-Reply-To: <012601d4c8b5$54f1b730$fed52590$@nexbridge.com> (Randall
        S. Becker's message of "Tue, 19 Feb 2019 19:43:37 -0500")
Message-ID: <xmqqftsiw8l8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> On February 19, 2019 18:29, Junio C Hamano wrote:
>> A release candidate Git v2.21.0-rc2 is now available for testing at the usual
>> places.  It is comprised of 474 non-merge commits since v2.20.0, contributed
>> by 61 people, 16 of which are new faces.
>
> Thanks. t5562 works properly on NonStop (3 tests under various
> loads). I am starting a full regression test now - see you in two
> days or so with a full report.

Thanks.  In the end I ended up doing the following:

 - kept most of your "feed NULs generated from a helper program via
   pipe, instead of reading from /dev/zero" patch,

 - replaced the helper program used in the above with the test-tool
   one by Dscho,

 - used Max's "do not reuse the output file---the background writer
   about to die may still have it open when the next test starts",

 - used Max's "when testing the program with overly large input
   declared with content-length, do not have to feed from /dev/zero;
   /dev/null suffices as a mistaken program attempting to read would
   die when seeing EOF anyway" patch to reduce one mention of
   /dev/zero (or one pipe from the helper output) further.

Hopefully Dscho's Azure thing would also be happy with one less use
of Perl script.

As I said earlier, a few places in t/ still mention /dev/zero and I
think it is a real bug on platforms without /dev/zero in t4153:

    $ git grep -h dev/zero t/
            test_must_fail test_terminal git am --3way </dev/zero &&
            test_must_fail test_terminal git am --reject </dev/zero &&

Curiously, applying the attached patch and running the test on Linux
would notice that we do not have such a device file, and the use of
test_must_fail does *not* make it a-OK [*].  I am not sure why you
are not getting hit by the same issue.

	Side note: test_must_fail is to ensure that the command
	exits in a controlled way without segfault, so at the first
	glance, replacing /dev/zero with something nonsensical and
	nonexistent ought to make the command pass, but that is not
	the case.  The shell notices redirection failure and aborts
	the &&-chain.  This behaviour matches what we want, so I
	won't complain ;-)

Another mention of /dev/zero appears in t/helper/test-sha1.sh (not
to be confused with t/helper/test-sha1.c).  This seems to be run
only with an explicit "make -C t/helper check-sha1" request, so
perhaps nobody on your platform ran it to get hit by it.  I wonder
if anybody runs this on any platform, to be honest, though.  Duy
Cc'ed as the last person to touch that particular target---yes, I
know I was guilty of introducing it in b65bc21e ("Makefile: add
framework to verify and bench sha1 implementations.", 2006-06-24).

 t/t4153-am-resume-override-opts.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4153-am-resume-override-opts.sh b/t/t4153-am-resume-override-opts.sh
index 8ea22d1bcb..29ef22c94f 100755
--- a/t/t4153-am-resume-override-opts.sh
+++ b/t/t4153-am-resume-override-opts.sh
@@ -40,7 +40,7 @@ test_expect_success TTY '--3way overrides --no-3way' '
 
 	# Applying side1 with am --3way will succeed due to the threeway-merge.
 	# Applying side2 will fail as --3way does not apply to it.
-	test_must_fail test_terminal git am --3way </dev/zero &&
+	test_must_fail test_terminal git am --3way </dev/zarro &&
 	test_path_is_dir .git/rebase-apply &&
 	test side1 = "$(cat file2)"
 '
@@ -94,7 +94,7 @@ test_expect_success TTY '--reject overrides --no-reject' '
 	test_path_is_dir .git/rebase-apply &&
 	test_path_is_missing file.rej &&
 
-	test_must_fail test_terminal git am --reject </dev/zero &&
+	test_must_fail test_terminal git am --reject </dev/zarro &&
 	test_path_is_dir .git/rebase-apply &&
 	test_path_is_file file.rej
 '
