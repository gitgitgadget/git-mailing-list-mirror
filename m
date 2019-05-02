Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09A661F453
	for <e@80x24.org>; Thu,  2 May 2019 14:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfEBOtJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 10:49:09 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43908 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfEBOtI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 10:49:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id g4so2753952qtq.10
        for <git@vger.kernel.org>; Thu, 02 May 2019 07:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IYd5YDaAwJDR062n3C3UV1FSLxEX0e3rRHYQmw3S5+4=;
        b=cuHeAilbaCLzAY2uax5FQxVobKOmMt84TgFKcrnwHc9E4sz/oz/cwS4B7dso+sTMlT
         XINT4bmIYHomKBEipcAt0NVUBlXf3lisMe0BY7thNvaAg+A7AZyiYv3fFZiXzapxQhls
         PTfh0JJBAv8OYQXFcS+aBKuzytT6YNTgPBcvMY6Ewo8HpMsjb665tSyRq95AS1J6iz0T
         DOlJ0wAmye42QdG5bjI7erdsFKhAeE50kC5H8LtQhZ6kLzJD1+IN5AfQgXXR8QCXNzLw
         8WU0rMlgpxGiJ5YoTDyCfL182wtqiS4BERSvf9UgP6gxpivm2j6Wd5qvQz+vtVlLV55y
         KEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IYd5YDaAwJDR062n3C3UV1FSLxEX0e3rRHYQmw3S5+4=;
        b=QDYfDSDvZQawuma+3hzfDGgHAnsDLGipxbkCPHwLFyFgXIfiP+wuK+a7DYCAHJjj+g
         dC2Q+loaBeeWvEHgUWvHEnicbUXrgI0V72Hayc9DcUW/1uME++WxS4gC3nUuZmzjCHKl
         TljIanOYjKEXjSsc039rPJ9KVGjkAH0uT+nUruvCjDFvg9V/TjOMKIaPF2CNXME0m1yY
         Yh33qoGfXkYIbAh2azYpl0IemvXlw4vrePl/maT++MiOTmcX3JLlprBifzOOoZAOgvoK
         VmeZAi2L0/Y3Ctpq0VxSBIbHVmwzrKyS7Aacd3Ip9oq7+VmahXZLLH1GABILvJhOJ973
         1Vpg==
X-Gm-Message-State: APjAAAXlfq+fqjykcw+fpteixFNLuChIiEQWwisHusJXR1Cl4IP71RPy
        mKKcIWtjaihmppU/PTcJURGzQ/3aEbE=
X-Google-Smtp-Source: APXvYqw7lpo2Eu27RaBhvbDE06LCZD117ea0RlA3ird4tDPJDp27OrltKV0SZUoO7p9RPaiPke9zqg==
X-Received: by 2002:ac8:66d6:: with SMTP id m22mr3413964qtp.323.1556808546168;
        Thu, 02 May 2019 07:49:06 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id s64sm22002880qkc.39.2019.05.02.07.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 07:49:05 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        kernel-usp@googlegroups.com, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [GSoC][PATCH v6 07/10] clone: copy hidden paths at local clone
Date:   Thu,  2 May 2019 11:48:26 -0300
Message-Id: <20190502144829.4394-8-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502144829.4394-1-matheus.bernardino@usp.br>
References: <20190330224907.3277-1-matheus.bernardino@usp.br>
 <20190502144829.4394-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the copy_or_link_directory function no longer skip hidden
directories. This function, used to copy .git/objects, currently skips
all hidden directories but not hidden files, which is an odd behaviour.
The reason for that could be unintentional: probably the intention was
to skip '.' and '..' only but it ended up accidentally skipping all
directories starting with '.'. Besides being more natural, the new
behaviour is more permissive to the user.

Also adjust tests to reflect this behaviour change.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Co-authored-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/clone.c            | 2 +-
 t/t5604-clone-reference.sh | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index d1aba3b13f..f117a6b206 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -428,7 +428,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 			continue;
 		}
 		if (S_ISDIR(buf.st_mode)) {
-			if (de->d_name[0] != '.')
+			if (!is_dot_or_dotdot(de->d_name))
 				copy_or_link_directory(src, dest,
 						       src_repo, src_baselen);
 			continue;
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 0800c3853f..c3998f2f9e 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -247,16 +247,25 @@ test_expect_success 'clone a repo with garbage in objects/*' '
 	done &&
 	find S-* -name "*some*" | sort >actual &&
 	cat >expected <<-EOF &&
+	S--dissociate/.git/objects/.some-hidden-dir
+	S--dissociate/.git/objects/.some-hidden-dir/.some-dot-file
+	S--dissociate/.git/objects/.some-hidden-dir/some-file
 	S--dissociate/.git/objects/.some-hidden-file
 	S--dissociate/.git/objects/some-dir
 	S--dissociate/.git/objects/some-dir/.some-dot-file
 	S--dissociate/.git/objects/some-dir/some-file
 	S--dissociate/.git/objects/some-file
+	S--local/.git/objects/.some-hidden-dir
+	S--local/.git/objects/.some-hidden-dir/.some-dot-file
+	S--local/.git/objects/.some-hidden-dir/some-file
 	S--local/.git/objects/.some-hidden-file
 	S--local/.git/objects/some-dir
 	S--local/.git/objects/some-dir/.some-dot-file
 	S--local/.git/objects/some-dir/some-file
 	S--local/.git/objects/some-file
+	S--no-hardlinks/.git/objects/.some-hidden-dir
+	S--no-hardlinks/.git/objects/.some-hidden-dir/.some-dot-file
+	S--no-hardlinks/.git/objects/.some-hidden-dir/some-file
 	S--no-hardlinks/.git/objects/.some-hidden-file
 	S--no-hardlinks/.git/objects/some-dir
 	S--no-hardlinks/.git/objects/some-dir/.some-dot-file
-- 
2.20.1

