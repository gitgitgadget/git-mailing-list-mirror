From: Stefan Beller <sbeller@google.com>
Subject: Fwd: [PATCH] submodule: Test a shallow branch
Date: Mon, 12 Oct 2015 14:59:32 -0700
Message-ID: <CAGZ79kYHZcByZc5Ju5K6YCcrWDt7Wt2Q0z4YYA4NTezg=358OQ@mail.gmail.com>
References: <CAELgYhcmzDEVRH9neGwZeqVBduL-nb=d+XoSMwRGKpmLUeX83g@mail.gmail.com>
	<1444685784-29598-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, carlosjosepita@gmail.com
X-From: git-owner@vger.kernel.org Mon Oct 12 23:59:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll8O-0003Bb-7T
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbbJLV7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:59:53 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36499 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660AbbJLV7d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:59:33 -0400
Received: by ykey125 with SMTP id y125so24425838yke.3
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=82QEYSpIT7OXYs9PP8528pvamaHuxdQIiHe99nHm72s=;
        b=oVuq22cy45Z5oZczqQ0Vd8EpU1EDZUL65Tx1tNg2lMX8thP8kxdBd2RuBwJpRf6Vtv
         UO0VZmXgiexjDJx67Te7sxMJmEerrzBnyMtYVoz5ETwoQ93IjQfLtKtF3+11WEJ8GPV3
         oKM3OKr+gTd88ROnUdHtPXKCbAgqXSB7dPV5veyi2q0MJoJNvgPlD1xvH5Ky4r06G49A
         Je2kjMjiQA9z1uAPCSuuc6zQWcSIMQi9J4iSj4RSywpl6LAe4rF6SlpIh4pnap0j8S1r
         z0YK64aNt5MmQucN68jThdXcc15xZouVjODyM+2YI98SKG/63xJrA2nVV5tmUOaAE6GI
         eIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=82QEYSpIT7OXYs9PP8528pvamaHuxdQIiHe99nHm72s=;
        b=TKQeuFx6wII1pzusrP6Mshl8B7Tp0iV5bE/Ee8K42onGMP+HI+v+QQ3e9qtZkgMm0l
         kWpjJyRwIb3cR1bK0IT85bfe5vZZ44GZHyZzZXTsTn2V9StZBWsSfThkH5YXfWJxB41W
         Yu9iM53xtpWHwlMKJ6VZH46gA3wizX9PP+rXmAJzKoR4XTeykYyP3Wz3FTua8IYgSdZa
         8yYQjrsfiNK2tSpD4A2rUYIyV6oaCuues4hcOSaNsnijt2dKfugITr82zg1IvY8+W6CV
         0Whqzh/l3w3bB8vU51AY93GB54xeEarfa109dGGQzVyMR1f/8/XZCcSDuff5kFJrE/+J
         9upQ==
X-Gm-Message-State: ALoCoQkgChJYV1azPkPlACv0sF9y+AUx1JspV6XP5ZVOIPIqC1JUv3AJp3Woi6wUUdvYa8WSWcg4
X-Received: by 10.129.80.214 with SMTP id e205mr21909454ywb.199.1444687173007;
 Mon, 12 Oct 2015 14:59:33 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Mon, 12 Oct 2015 14:59:32 -0700 (PDT)
In-Reply-To: <1444685784-29598-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279464>

I forgot to CC you guys.

---------- Forwarded message ----------
From: Stefan Beller <sbeller@google.com>
Date: Mon, Oct 12, 2015 at 2:36 PM
Subject: [PATCH] submodule: Test a shallow branch
To: gitster@pobox.com
Cc: git@vger.kernel.org, carlosjosepita@gmail.com, Stefan Beller
<sbeller@google.com>


Instead of tracking the submodule at the specified branch, using a shallow
clone, we get the following error:

fatal: Cannot update paths and switch to branch 'anotherbranch' at the
same time.
Did you intend to checkout 'origin/anotherbranch' which can not be
resolved as commit?
Unable to checkout submodule 'submodule'

Noticed-by: Carlos Pita <carlosjosepita@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Hi Carlos,

 I can reproduce your issue and have a patch which we can add to the
 testing suite to document this faulty behavior.

 Thanks,
 Stefan

 t/t7400-submodule-basic.sh | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 540771c..cee74cb 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -846,7 +846,8 @@ test_expect_success 'submodule add with an
existing name fails unless forced' '

 test_expect_success 'set up a second submodule' '
        git submodule add ./init2 example2 &&
-       git commit -m "submodule example2 added"
+       git commit -m "submodule example2 added" &&
+       git checkout -b anotherbranch
 '

 test_expect_success 'submodule deinit should remove the whole
submodule section from .git/config' '
@@ -987,6 +988,7 @@ test_expect_success 'submodule with UTF-8 name' '

 test_expect_success 'submodule add clone shallow submodule' '
        mkdir super &&
+       test_when_finished "rm -rf super" &&
        pwd=$(pwd) &&
        (
                cd super &&
@@ -999,5 +1001,21 @@ test_expect_success 'submodule add clone shallow
submodule' '
        )
 '

+test_expect_failure 'submodule add a shallow branch' '
+       mkdir super &&
+       test_when_finished "rm -rf super" &&
+       pwd=$(pwd) &&
+       (
+               cd super &&
+               git init &&
+               git submodule add --depth=1 --branch anotherbranch
file://"$pwd"/example2 submodule &&
+               (
+                       cd submodule &&
+                       test 1 = $(git log --oneline | wc -l)
+               )
+       )
+'
+
+

 test_done
--
2.5.0.268.g453a26a
