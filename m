Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwMUOaks"
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAC9124
	for <git@vger.kernel.org>; Sat,  2 Dec 2023 09:24:57 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-42548f6c565so3673851cf.2
        for <git@vger.kernel.org>; Sat, 02 Dec 2023 09:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701537896; x=1702142696; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=whTtG50wCZ1Esg/VYRkOJ8nmNojApUOYiKkjbIX7Dks=;
        b=HwMUOaksp2tVaIGCLGmOzxOKrrIlHrYoD/kQHaPwLGPiZt7MOq82gfQdeah3lm+Abe
         3JGFyYkpqAaT5YPnbH44huWEmXqNYAasmy3RBiXMPIDl/IscL+4AcTWEgGZJcYouIZmc
         QxHToYoB5Jhx+sFi0IibLbt6lWt/eJWCoHXzg3aM2KUDXCNa0penbWcLxp4cg3HMXHwL
         rguf6Iv52BuEv6Z7ShvqF8OpP7zZVkirSuMOuPNKdAWqFc7534Px6CYzqQMwJ0ZQtCh7
         PlqEuVsh2P4tTvfudajRup4XAQP/g9LrzDgLZrDr0uTjXVeOeD6/1PhgpKlLY+euQGp5
         51Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701537896; x=1702142696;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=whTtG50wCZ1Esg/VYRkOJ8nmNojApUOYiKkjbIX7Dks=;
        b=D8/yl86QYmDPy/p3SkXpHUQaKA0ESmjEUtMeODc0L1yMSULRBtWlBy903EHrGo0OUx
         v4TOrw2sSZQY33GTJ3hDMl/zrZH7FXFF0b6WKT6I6KuWvluoQ48WF73hdTwAQqGUvhu+
         QsCP4wVuysot3wNavrfWC+uR2hMs2mWAhQehukfeAyz2S8Ej15guHX1AfcZUhfgjwsUM
         Wx02HHaWRrdxedKKllsH9pgFcEjRVwBMNzhEXsqb1OC86PudXvxF3hbr2LlosiplP2Lt
         q+6jUi1A//JB5K9hfwlboispEGzqI5Oae9K1KJm8CtwP6GTJ72jLorIQBigOOGZFdfAv
         9OxA==
X-Gm-Message-State: AOJu0Ywvlf4hJRJYuIprXjUFoG9PZwjYHRxRoA2deGlQT+qR1hIjUWvM
	Kk/SCbEgOkuCo5MDaV6dDf14VKvKGHSVMHbNussZGq+4gAc=
X-Google-Smtp-Source: AGHT+IHjBCP1KJTbhCWomxjoBtZGH9mRKdeDWe5BUvqnnOokCK7nvn7oMEZdl9Pctng/uanTxhe+/iL6/ZAZ81/qw+E=
X-Received: by 2002:a05:622a:30f:b0:425:4043:96e4 with SMTP id
 q15-20020a05622a030f00b00425404396e4mr2671186qtw.113.1701537896087; Sat, 02
 Dec 2023 09:24:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Date: Sat, 2 Dec 2023 22:54:45 +0530
Message-ID: <CAPYXD64yCuMta_iGE+ZwgxrJn0U5shcwcB9jaiNkFhvff=R7MQ@mail.gmail.com>
Subject: [Patch] test-lib-functions.sh : change test_i18ngrep to test_grep
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Recently the test_i18ngrep was deprecated from the source code and
test_grep was implemented but in the test-lib-functions.sh file , in
the test_grep() function definition,
it is written BUG "too few parameters to test_i18ngrep".
So the following patch solves the minor problem.

Signed-off-by: Shreyansh Paliwal <Shreyanshpaliwalcmsmn@gmail.com>
---
 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertions(+), 1 deletions(-)

 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)diff --git
a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 9c3cf12b26..8737c95e0c 100644
--- a/t/test-lib-functions.sh
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1277,7 +1277,7 @@ test_grep () {
        if test $# -lt 2 ||
           { test "x!" = "x$1" && test $# -lt 3 ; }
        then
-               BUG "too few parameters to test_i18ngrep"
+               BUG "too few parameters to test_grep"
        fi

        if test "x!" = "x$1"
--
2.43
