Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1CAE20286
	for <e@80x24.org>; Thu,  7 Sep 2017 16:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752917AbdIGQcW (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 12:32:22 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36309 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751576AbdIGQcV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 12:32:21 -0400
Received: by mail-wm0-f43.google.com with SMTP id i189so147236wmf.1
        for <git@vger.kernel.org>; Thu, 07 Sep 2017 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=qPt98a2n0qpALa2/vkuTGVTdv/ug9gx35LK+6twCNhM=;
        b=JJQyJWJxo+QNgtWbG0MQniJHkMsgG5qkB02ZoOaAX96PtiglAI0ghQ/ipwapP1/HkO
         lAHRO7Uw9Cv7b6x0sXJlYD2XVvxQcMJW8+x/MUiLXs2vnrKYF3NFrtmTixSVxqYDvMov
         kf+Q/9FyIcnSTcOUq8L2QpzCbXeWrozAH29qw/xQC106epQs51orVSXQ2XTHGFe2Fcdx
         r2yqYAgHkjtdJWAgSXnXu6kxV0imHlpzwNsFACR/KHFECq7vTOnr28mruZHATA34k6AB
         lVLYHHtYyvXauUD0JvXPwrmA8x4+yq8hdJudEgmkoWiOU+S4wv++rNxkeqiRm1Q2lCZz
         7iSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=qPt98a2n0qpALa2/vkuTGVTdv/ug9gx35LK+6twCNhM=;
        b=BUhLm/Lz0N7pZZou4Uu0jE4IlU3mT7yGcq3o1o6aD+WcgXucTIcNCBpCGUD8E7Tgpn
         wynVZc34UgrIcCbLDuomgpAUzbz0ILCmCNjAWi6+vALo4v+jEv9ZqrUYFx/hUlZpGF9W
         wYDMz08++RznY3+QLvbVanut5YCgKteKcvdpFvw2eBNNgs2B87WYgin3weM7CDqkt9DG
         D7LyEajF6U6DB4y0tWz4lB1YSFwCW/HCSE/graXT+AcHVZV+mgRmztzu0t4mbBJSwSG3
         BTSkbGpL5SoEcw7g4E8Qgn2Q8ncTGuVlagGT/O5qH6hCMvs9joLb97EZbNu5BUyga1as
         clDA==
X-Gm-Message-State: AHPjjUhxnOGtfgL7J/fmaIWKy9ayp2CB6H8SqLSnmFZsROnWCVmV04vY
        GN2Y5jXWew8z5sHp
X-Google-Smtp-Source: ADKCNb6A7WSGSmjTUFzKaWmK7K0a5fd6ndM8KG/IMMVNYgGf/BAvTzp0+RyWn9EO0BTacltkGMUs0Q==
X-Received: by 10.80.182.129 with SMTP id d1mr3049681ede.188.1504801939610;
        Thu, 07 Sep 2017 09:32:19 -0700 (PDT)
Received: from ?IPv6:2a00:13c8:2000:16:b802:5440:fb60:7513? ([2a00:13c8:2000:16:b802:5440:fb60:7513])
        by smtp.googlemail.com with ESMTPSA id h33sm30036edd.60.2017.09.07.09.32.18
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Sep 2017 09:32:18 -0700 (PDT)
To:     git@vger.kernel.org
From:   Olaf Klischat <olaf.klischat@gmail.com>
Subject: git diff <commit> doesn't quite work as documented?
Message-ID: <0696f94d-28c2-1f4b-03ee-16553d97f318@gmail.com>
Date:   Thu, 7 Sep 2017 18:31:58 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

oklischat@oklischat:/tmp$ mkdir gittest
oklischat@oklischat:/tmp$ cd gittest/
oklischat@oklischat:/tmp/gittest$ git init
Initialized empty Git repository in /private/tmp/gittest/.git/
oklischat@oklischat:/tmp/gittest$ echo foo > foo.txt
oklischat@oklischat:/tmp/gittest$ git add foo.txt
oklischat@oklischat:/tmp/gittest$ git commit -m foo
[master (root-commit) 54d55f2] foo
 1 file changed, 1 insertion(+)
 create mode 100644 foo.txt
oklischat@oklischat:/tmp/gittest$ echo bar > bar.txt
oklischat@oklischat:/tmp/gittest$ git add bar.txt
oklischat@oklischat:/tmp/gittest$ git commit -m bar
[master 83b2e74] bar
 1 file changed, 1 insertion(+)
 create mode 100644 bar.txt
oklischat@oklischat:/tmp/gittest$ git tag bar-added
oklischat@oklischat:/tmp/gittest$ git rm bar.txt
rm 'bar.txt'
oklischat@oklischat:/tmp/gittest$ git commit -m 'rm bar'
[master 3ca4ff9] rm bar
 1 file changed, 1 deletion(-)
 delete mode 100644 bar.txt
oklischat@oklischat:/tmp/gittest$
oklischat@oklischat:/tmp/gittest$ git checkout bar-added -- bar.txt
oklischat@oklischat:/tmp/gittest$ git reset HEAD
oklischat@oklischat:/tmp/gittest$ git status
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	bar.txt

nothing added to commit but untracked files present (use "git add" to track)
oklischat@oklischat:/tmp/gittest$ git diff bar-added   # would expect this to show no differences
diff --git a/bar.txt b/bar.txt
deleted file mode 100644
index 5716ca5..0000000
--- a/bar.txt
+++ /dev/null
@@ -1 +0,0 @@
-bar
oklischat@oklischat:/tmp/gittest$ 
oklischat@oklischat:/tmp/gittest$ git diff bar-added  -- bar.txt   # dito
diff --git a/bar.txt b/bar.txt
deleted file mode 100644
index 5716ca5..0000000
--- a/bar.txt
+++ /dev/null
@@ -1 +0,0 @@
-bar
oklischat@oklischat:/tmp/gittest$ 


`git diff --help' says:

git diff [--options] <commit> [--] [<path>...]
           This form is to view the changes you have in your working tree relative to the named <commit>.

If that were entirely true, the last two commands shouldn't have shown
any differences, right?

On closer inspection, it seems that what `git diff <commit>' really
does is take only those paths in the working directory that are also
in <commit> and compare the resulting tree against <commit>.

We should add some option to that git diff form to make it really do
what the docs claim it does.

Or am I missing something?
