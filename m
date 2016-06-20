Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF48A20179
	for <e@80x24.org>; Mon, 20 Jun 2016 07:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbcFTHjR (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 03:39:17 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33195 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbcFTHjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 03:39:16 -0400
Received: by mail-pa0-f48.google.com with SMTP id b13so48427678pat.0
        for <git@vger.kernel.org>; Mon, 20 Jun 2016 00:39:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aqkCIDaMY4uOgsD4KJV/2zIBG0QyLgI+4X+SPFc/7e0=;
        b=rPRMUp19ENrzwikA1AKMST/peSGhbmaGWE1uw+jDJAArjgOjKBcjO81KgHCsQg8F8G
         mFwU5y1FwI+sZZjE35V4mwQHp7S58jTVlWdBIYq/JZfI0z4bX4YcnZ3Q/UuYif1sXqSO
         mXJLEsRYvAekMtYpyLpaRYXKcL4M1O88LbdFEGOmXIfeVaIe/h9dugccdZyJO1njmcYs
         NUuqlBywX0dhqiE3KqVJZSIbzyr6/mKwNZw7FRKdh/9Qaw72Y+RL+oZ3TaXpoy8q69da
         EvQx6T+67daPftsbBGfdyH73IIVw7rI0MA2dfws24wsxzZMx4wnkLlQsLz/hbDjV2YgV
         D8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aqkCIDaMY4uOgsD4KJV/2zIBG0QyLgI+4X+SPFc/7e0=;
        b=GPqqG1HQvVFT/trc6i2UMnMt0JRT130oeKNxu5yS51Yo/fwyRmHzPH4X8KBVtdaPWA
         A9AaCs66fpp6tRn5lU1z3kwnUVPi1igvxrRF0K7RoQMzpDH28pGhY9nI+cljCg0S4hbA
         mavi3bsCPWD2eA9yUqlm8tDF23AMpzSkFWhmhDzMXOOTfxHBVxwJWAYwMVRJ6bHdW5cF
         6OhwYWnzeBw3QGpnZcTsamoSbNe9t5p/y5MAOI1OTEykRxjE8SBQKRozSc1o8P1D6JSL
         /QY5npk3wcUp/BtCCq4+rwJhiaRbqnFLCn5KO39dbpbIjyVgFRUmnjT6U2mKxC52mqwh
         u9ag==
X-Gm-Message-State: ALyK8tIE8KPRuG8Cl9b8e5Gyvg6TlHrMtRr3/IMOoV/1wdqGS02sTTFSBPR2K6J6qPjUdA==
X-Received: by 10.66.248.35 with SMTP id yj3mr4726714pac.138.1466408355391;
        Mon, 20 Jun 2016 00:39:15 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id i68sm31905049pfe.64.2016.06.20.00.39.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 Jun 2016 00:39:14 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Cc:	larsxschneider@gmail.com, christian.couder@gmail.com,
	chriscool@tuxfamily.org, Pranit Bauva <pranit.bauva@gmail.com>
Subject: [GSOC Update] Week 7
Date:	Mon, 20 Jun 2016 13:07:55 +0530
Message-Id: <20160620073755.2934-1-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160613080656.5013-1-pranit.bauva@gmail.com>
References: <20160613080656.5013-1-pranit.bauva@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

================================= SUMMARY ==================================
My public git.git is available here[1]. I regularly keep pushing my work so
anyone interested can track me there. Feel free to participate in the
discussions going on PRs with my mentors. Your comments are valuable.


=============================== INTRODUCTION  ==============================
The purpose of this project is to convert the git-bisect utility which partly
exists in the form of shell scripts to C code so as to make it more portable.
I plan to do this by converting each function to C and then calling it from
git-bisect.sh so as to use the existing test suite to test the function which
is converted.

Mentors:
Christian Couder <chriscool@tuxfamily.org>
Lars Schneider <larsxschneider@gmail.com>


================================== Updates =================================
Things which were done in this week:

 * I have converted check_and_set_terms() and have also sent an RFC[2] to the
   mailing list for discussion which hasn't yet collected any comments. It is
   kind of important to discuss this as it uses a way to set the global
   variables in the script by writing it to a file and then reading it.

 * I have also converted bisect_next_check() but this has a bug which will
   soon be fixed. This is available here[3].

 * I have converted get_terms().

 * I am on my way to convert bisect_terms() which should probably finish by
   tomorrow.

 * I also send out a patch[4] which describes the return value of
   strbuf_read_file() and is queued on the pu branch.

================================= NEXT STEPS ================================
Things which would be done in the coming week:

 * Finish off bisect_terms().

 * bisect_run().

 * bisect_replay().

 * I have my mid term evaluations this week. Hope I clear it successfully.

[1]: https://github.com/pranitbauva1997/git
[2]: http://thread.gmane.org/gmane.comp.version-control.git/297520
[3]: https://github.com/pranitbauva1997/git/pull/17
[4]: http://thread.gmane.org/gmane.comp.version-control.git/297266

Regards,
Pranit Bauva
