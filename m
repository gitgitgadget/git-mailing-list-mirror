Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 038911F453
	for <e@80x24.org>; Fri, 21 Sep 2018 23:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391571AbeIVFt4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 01:49:56 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:50731 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeIVFt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 01:49:56 -0400
Received: by mail-io1-f73.google.com with SMTP id z25-v6so25961515iog.17
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 16:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xH+LeIOj1Ws9K4eyiP0umCDChOLjI5OJAbALP0nwozI=;
        b=LAmlZ4SKowqbL7xL285VW/o/iZs15PYTCGp7bFQc6lmnNWK2Eqse8/v7YQvy9LUL2e
         KK9T7HycEB5lrsLcVNx5c9OC3dyZfsOMX4oriTU/K7JWdlPoqp/Wv1FqIz9I+zLAmNyU
         4z8wY3AMEMsTkEAxU8Mu0vxLK2+odUbnJj/DnkeYMD1qKs1AWIbF9pM/qY3Jupblz03n
         oJE9DiC/rhGdANA2DgZRc5wfw+Pr/FXjQzZGrhpZvhT74MGQhklXaVzM4ZhEm5HD+JAT
         t6qhkqip4UD+qHXuACui57ucZjdKEK8kyqR4nHX+QoeSXnH2iaCt/xrJwIty2Kpn8AmC
         wHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xH+LeIOj1Ws9K4eyiP0umCDChOLjI5OJAbALP0nwozI=;
        b=QPtlyG99MovK39UpjJHR7XVKyZVRJM2ILJrhGm+PD0RvEFkQnrf740ZIs8uoyisNhU
         5abvvKdBFVZbJFzGV3gnk1KOq7VHHea0VkwTS/Kc5edaLlIqTCBzYl6T6VI58NwtiJ57
         xHmsWDaEy+yCeKvjLMbagUqAnFUowmerMbvrv4BORuknCJ0UpIAzuEU/Q2ibXXLkkNrA
         F6bc6IAs99u9vbCUZ5NSXKOWNH7fZFeuAvUOIqj7NjQRu3FuTnOI6c+qcUITjkXeNAti
         WEXEXDTcOqYkfltOdCppyLTrT831dDWIti/V/IW/TE91aj/N0HfbnzuTQljpzQwziY+x
         sCGA==
X-Gm-Message-State: ABuFfoiZagLKqAKUJpv9aW6qCx8trUGjg4x368iK0e8P3MBciMOrqGva
        edhCZcjuuXOvnGNyNDK/Pw9DXXc/kRqJrw/6VYFxX+wPY+YIxLyL2X+w338lmAbkAw4sXpcsxmZ
        YR5R6y12foHLphGLmrhtOi5ZN43O7/w5IennOBKIJfULuxIwTvI24RAS/ch1e
X-Google-Smtp-Source: ACcGV62Y8LFShvV+XPUECEpGc2O13ZI8R+C+fGIYQEm7o5P2bUEnX7CrHI+5o4GY/0/qwBpEsfeike90uzEG
X-Received: by 2002:a24:7c48:: with SMTP id a69-v6mr2915itd.15.1537574323574;
 Fri, 21 Sep 2018 16:58:43 -0700 (PDT)
Date:   Fri, 21 Sep 2018 16:58:30 -0700
Message-Id: <20180921235833.99045-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH 0/3] bring some tests to newer style.
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old formatting style is a real hindrance of getting people up to speed
contributing as they use existing code as an example and follow that style.
So let's get rid of the old style and reformat it in our current style.

This was reported off list by Derrick and Jeff as both of them followed
outdated formatting style for their first patches only to have a long
discussion on the mailing list on style.

The tests changed are not modified in origin/master..origin/pu,
and they were changed using a hacky script:
--8<--
#!/usr/bin/python
import sys
def applyformat(fname):
	with open(fname, 'r') as f:
		lines = f.readlines()
		state = "lookingforstart"
		outlines = []
		for line in lines:
			if state == "lookingforstart":
				if line == "test_expect_success \\\n":
					print "AHA!"
					state = "firstlinefound"
				else:
					outlines += [line]
			elif state == "firstlinefound":
				l = line.strip()
				must_strip = False
				if l.endswith("\\"):
					l = l[:-1]
					must_strip=True
				if l.endswith("'"):
					l = l[:-1].strip()
				if l.startswith("'"):
					line = "test_expect_success " + l + " '\n"
					outlines += [line]
					state = "re-indent-until-done"
				else:
					print "what?"
					exit(1)
			elif state == "re-indent-until-done":
				l = line.strip()
				if must_strip:
					if l.startswith("'"):
						l = l[1:]
						must_strip = False
					else:
						print "what 1?"
						exit(1)
				if l.endswith("'"):
					l = l[:-1]
					state = "lookingforstart"

				if len(l):
					line = "	" + l + "\n"
					outlines += [line]
				elif state == "lookingforstart":
					# skip an empty line before test is done
					pass
				else:
					outlines += ["\n"]

				if state == "lookingforstart":
					outlines += ["'\n"]
			else:
				print "what?"
				exit(1)
	with open(fname, 'w') as f:
		f.write(''.join(outlines))

for n in sys.argv[1:]:
	print n
	applyformat(n)
--8<--

Thanks,
Stefan

Stefan Beller (3):
  t7001: reformat to newer style
  t7004: reformat style
  t0030: reformat style

 t/t0030-stripspace.sh | 525 ++++++++++++++++++++----------------------
 t/t7001-mv.sh         | 268 ++++++++++-----------
 t/t7004-tag.sh        | 149 +++++-------
 3 files changed, 444 insertions(+), 498 deletions(-)

-- 
2.19.0.444.g18242da7ef-goog

