Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF3A81F454
	for <e@80x24.org>; Fri,  1 Nov 2019 08:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbfKAIZg (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 04:25:36 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32853 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730098AbfKAIZg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 04:25:36 -0400
Received: by mail-pl1-f195.google.com with SMTP id y8so4064102plk.0
        for <git@vger.kernel.org>; Fri, 01 Nov 2019 01:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GrX1dz8CP07MXMk9VyzYMZ7Phc1XjJjwt03QpqDe3S8=;
        b=a60PAbBDFmAEwYaCbNNvrUTdjAgaWPYCU+WBw5j1D9jCVOikD/Grm/78/z4Psbro20
         4aMrj5Ulx4iewm5643G2l9kmkawVFBCFGHxLDbjuzVe/Vju9Jkq9872hQKNJMUOEDPgw
         uA7fd/l1X9HQmg+ZSda84pQDfPQkX6SN7EyJdO7+bdiqkNK2P74+toGSyGY0lNxKJolJ
         hJgWSgiBmYJnb67yx9V+Kq/Nf+1sLQFEqD2VDJTBck8g3nDAkCKmQKNoxzDhw1Gyocnb
         DYXat9b6ul8/GiQljTKNmnvCZZao8dXnXGmY0lX3WnmEG1htcf6WGvdbXigtwzUmVHNg
         gNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GrX1dz8CP07MXMk9VyzYMZ7Phc1XjJjwt03QpqDe3S8=;
        b=EBxbl6XY3TCB9U2lfRf2URESMeuaTEUTdTmD4NTYUmxDdscuOb/vwO0hQ3Gmm8eLbY
         WogLAk1TEFqy+5tCqw65ovKq5PKt9thGBsdJR6Q/+yv0O5uagU2ASFtVPwP4zm0Jpm2d
         wOygDy7ddYQbzuFsbCyCqjnUAW9NhjP+lMaxdSwHg9sAUCwIwuHhmogwWpetWZo3u2+w
         zGzaOPk76vitc5gjPYRKL1U4sQcXJHRD/dP+s5x1XbF0kucniKeOxaCoSvoKIbEe0kgJ
         BbitzBgL9pp/U1lDP1dASwBfrHVolroEkPKiVMdicIsRueMj9NPoFwiUrOf/D0DjDMeK
         r+Mg==
X-Gm-Message-State: APjAAAXdJ3z+jsDwOB8q+wz8GWTor+CFGafA2ataPiXSzc/kzV6NQgvl
        qD5EMkc8o2foc5pIeYhQC0wLaNoA
X-Google-Smtp-Source: APXvYqzZ9x9vMsGC09sLALxbRAgTxjN6yaAXwah/Q0T68SnzRCVosLEl9IHK4KUQCEj12dqt4XQRug==
X-Received: by 2002:a17:902:6f01:: with SMTP id w1mr11546215plk.35.1572596735750;
        Fri, 01 Nov 2019 01:25:35 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:e1c2:8c5a:c959:6fca:fa1a])
        by smtp.gmail.com with ESMTPSA id q13sm17158395pjq.0.2019.11.01.01.25.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 01:25:34 -0700 (PDT)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v2 3/3] sequencer: reencode to utf-8 before arrange rebase's todo list
Date:   Fri,  1 Nov 2019 15:25:11 +0700
Message-Id: <b7927b27235422ac53595cfaa63b4f1cbe009013.1572596278.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.rc2.296.geaf699fcc3
In-Reply-To: <cover.1572596278.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1572596278.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On musl libc, ISO-2022-JP encoder is too eager to switch back to
1 byte encoding, musl's iconv always switch back after every combining
character. Comparing glibc and musl's output for this command
$ sed q t/t3900/ISO-2022-JP.txt| iconv -f ISO-2022-JP -t utf-8 |
	iconv -f utf-8 -t ISO-2022-JP | xxd

glibc:
00000000: 1b24 4224 4f24 6c24 5224 5b24 551b 2842  .$B$O$l$R$[$U.(B
00000010: 0a                                       .

musl:
00000000: 1b24 4224 4f1b 2842 1b24 4224 6c1b 2842  .$B$O.(B.$B$l.(B
00000010: 1b24 4224 521b 2842 1b24 4224 5b1b 2842  .$B$R.(B.$B$[.(B
00000020: 1b24 4224 551b 2842 0a                   .$B$U.(B.

Although musl iconv's output isn't optimal, it's still correct.

From commit 7d509878b8, ("pretty.c: format string with truncate respects
logOutputEncoding", 2014-05-21), we're encoding the message to utf-8
first, then format it and convert the message to the actual output
encoding on git commit --squash.

Thus, t3900 is failing on Linux with musl libc.

This problem wasn't specific to musl libc. On Linux with glibc, this
problem can be observed by:

for encoding in utf-8 iso-8859-1; do
	# commit using the encoding
	echo $encoding >file && git add file
	echo "éñcödèd with $encoding" | iconv -f utf-8 -t $encoding |
	  git -c i18n.commitEncoding=$encoding commit -F -
	# and then fixup without it
	echo "$encoding fixed" >file && git add file
	git commit --fixup HEAD
done
git rebase -i --autosquash --root

Reencode to utf-8 before arranging rebase's todo list.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
The code that demonstrate the problem on Linux with glibc is written by Jeff.
But I don't know how to attribute him properly.

 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 9d5964fd81..69430fe23f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5169,7 +5169,7 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 		*commit_todo_item_at(&commit_todo, item->commit) = item;
 
 		parse_commit(item->commit);
-		commit_buffer = get_commit_buffer(item->commit, NULL);
+		commit_buffer = logmsg_reencode(item->commit, NULL, "UTF-8");
 		find_commit_subject(commit_buffer, &subject);
 		format_subject(&buf, subject, " ");
 		subject = subjects[i] = strbuf_detach(&buf, &subject_len);
-- 
2.24.0.rc2.296.geaf699fcc3

