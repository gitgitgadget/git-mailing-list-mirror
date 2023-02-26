Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AF5C6FA8E
	for <git@archiver.kernel.org>; Sun, 26 Feb 2023 10:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjBZKxK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 05:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBZKxI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 05:53:08 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5758A10A98
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 02:53:07 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o12so14502416edb.9
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 02:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yxWS5tVPd63RoqHgkqUte10tH+Rm6eplPY6htRm/VI=;
        b=bj3Vznp6BeHN3PLnxxakB61e8fx89J+efhQALtgQAT91znUy1GTL2vRIqzcWM5j/ie
         wopIBfPIeCB5EE6IQwDAhC9dcQNPjq85Lhkbdv6Crygsjzjd2C5D1dJeOPlrEa+9j6wk
         /s0R0zHTcWSJEvg+a9I9MnKcIV1JSsUmXm4S2e7lYPNTjmmvEOi6ikt2WuFesEgaDKAi
         CFuXybWiNdhfZPAFznUaZmtqx/T9aWgO6xIBw1i/nAy8NIRYkrY1HVPdsl5KGiukAaDb
         si3nohghf5vDNktW16L77gMczbubSiwifCn3bJ5MqVVlFUtIJiL4+gdi8YExUXs6oV+/
         IBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yxWS5tVPd63RoqHgkqUte10tH+Rm6eplPY6htRm/VI=;
        b=P5DAFSbsKndONhx86S9T916ji01gU5VSGgP/tZqmgIm/MnFOrniRHrIU12zx+LnVRS
         10NjN5nzGHa3JSLGbTAHVxmqmXXujyhmfwF8HLZA9AMUzxA/d5ck+Nn/7gLCrj4dAOwd
         Aa8ja/xp8q17VcAhQLfFXaJ6hnjXkDBvY82TbYeE83Cl/iyc1PmkTqsYDb/pT+sPngVp
         ensO73KdD8PZCiIZobipON8KaAulWKWsWre7qpc/cD1/oaaoE9x1Jw9QYov7jfj+eLwC
         qnSbkSEIp5esDspINJmu7EAUJn/KR0pn3WieUpD3BbaHSEjJVx2ltS4KH9NhuMm9FIm6
         Dg1g==
X-Gm-Message-State: AO0yUKWm0I1JOgrj0NoWQ88+FRJttd3PP1FDOVv7Q2Yey6g3m6MIfG/I
        11d0fbUqkB+p5gn8A1W1Gjh1tfoWnKI=
X-Google-Smtp-Source: AK7set+ssVSlbe8MPTZWLiUvX6dbEVwJ/YfTjH9LBipGubWXThd/oyqTPHynPG8eGSQf9P0g62aFcg==
X-Received: by 2002:aa7:df12:0:b0:4ad:66b:84a5 with SMTP id c18-20020aa7df12000000b004ad066b84a5mr22345082edy.22.1677408785628;
        Sun, 26 Feb 2023 02:53:05 -0800 (PST)
Received: from titov.fritz.box ([216.24.216.236])
        by smtp.gmail.com with ESMTPSA id gw26-20020a170906f15a00b008e204a57e70sm1846830ejb.214.2023.02.26.02.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 02:53:05 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3] test-lib: drop comment about test_description
Date:   Sun, 26 Feb 2023 11:53:03 +0100
Message-Id: <20230226105303.55033-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230225190526.21780-1-rybak.a.v@gmail.com>
References: <20230225190526.21780-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a comment describing how each test file should start was added in
commit [1], it was the second comment of t/test-lib.sh.  The comment
describes how variable "test_description" is supposed to be assigned at
the top of each test file and how "test-lib.sh" should be used by
sourcing it.  However, even in [1], the comment was ten lines away from
the usage of the variable by test-lib.sh.  Since then, the comment has
drifted away both from the top of the file and from the usage of the
variable.  The comment just sits in the middle of the initialization of
the test library, surrounded by unrelated code, almost one hundred lines
away from the usage of "test_description".

Nobody has noticed this drift during evolution of test-lib.sh, which
suggests that this comment has outlived its usefulness.  The assignment
of "test_description", sourcing of "test-lib.sh" by tests, and the
process of writing tests in general are described in detail in
"t/README".  So drop the obsolete comment.

An alternative solution could be to move the comment either to the top
of the file, or down to the usage of variable "test_description".

[1] e1970ce43a ("[PATCH 1/2] Test framework take two.", 2005-05-13)

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---

  On 2023-02-25T23:50, Junio C Hamano wrote:
  > Andrei Rybak <rybak.a.v@gmail.com> writes:
  >> An alternative solution is to move the comment down to the usage of
  >> variable "test_description".
  > 
  > Or at the beginning, as the comment is about "how you can use this
  > test-lib.sh test library in your tests".

Here's v3 with updated description of the dropped comment and updated
description of the alternative solution.

  > I have no strong preference.  Just dropping it sounds easier, as a
  > more readable description already exists elsewhere.

Also, at the top of "test-lib.sh", there is a comment pointing to that other
place:

  # Test framework for git.  See t/README for usage.

added in c74c72034f (test: replace shebangs with descriptions in shell
libraries, 2013-11-25).

 t/test-lib.sh | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index d272cca008..62136caee5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -645,12 +645,6 @@ u200c=$(printf '\342\200\214')
 
 export _x05 _x35 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID OID_REGEX
 
-# Each test should start with something like this, after copyright notices:
-#
-# test_description='Description of this test...
-# This test checks if command xyzzy does the right thing...
-# '
-# . ./test-lib.sh
 test "x$TERM" != "xdumb" && (
 		test -t 1 &&
 		tput bold >/dev/null 2>&1 &&
-- 
2.39.2

