Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3830A6FAE
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCpxZsBb"
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9288E4
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 13:02:51 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4084e49a5e5so22556945e9.3
        for <git@vger.kernel.org>; Sun, 22 Oct 2023 13:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698004970; x=1698609770; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SQ2o25tD84mmGPcwWXOUscMd++Nbpc7qoI249u+Uh+Y=;
        b=dCpxZsBbeA6RjK2gtgdvs3A9m/2jXVZb7KkGPetoOMr74wvvflzQI4/mroDCJvDqVE
         ooKQb/tUhHXMVdgpMifOgSAXtJPj9HuEChLFZw5Y2qcrYZFrFEtn6ufcJEHl24YmneGs
         +w9qa5gFelINPsI5S2X/w9wKeDDh1mgsc+d4FTUjlclbyom5kMnF+D44eRrFyG6w+StZ
         WLO7R+LYjzcxxZyAt5UDnUOQhvRTWZrA3FAZRFOZLNZI3dGmi5DI2JLw8ZJqs3usc/7G
         zesWtfOXkB1cPXAdpa/OOcrPGy/Ps5PnXW7kSPl5imv56kOqvNZM+AF4jTWZqnTYqwFl
         G/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698004970; x=1698609770;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQ2o25tD84mmGPcwWXOUscMd++Nbpc7qoI249u+Uh+Y=;
        b=W+C9BBwkOYE9utFPO1PNC+UceLQFMs4DT+oBqH+TOUR2pt6V1ZuSD2hdLywzW29hnc
         5iCRPehI/RvuzdZUfXAfrmxtDoZN1iHW+ysBw5krBt4eORKhOEv6AhOkJVXrGwuuomk1
         ajxkzr+YLOexqFB7ys6aGwAdQWr+Paa90CgE9NICOyLghe+KODkguGAkN8W64WwhwfaK
         wkF4vumGrW4EetsRfW+161JQakQ9kAJc0qA01E7ZiTwqVl3p9F8uYsiKE3oecwz8/Vl+
         QXCIy6FOwH4L/sRurANbzS5UCXqp6UkESCqCdzmibfUBWAtyMva/LCdjwUkdQVyzyocr
         e+RQ==
X-Gm-Message-State: AOJu0Yxh0S5AojmqSUXIlM0gscUM58DJI2BfS3mv5Ns9+0meQKUDFNQh
	MA3fUcE62E7LhGvkZQ7EbFRHaZSd9yg=
X-Google-Smtp-Source: AGHT+IEHB7HJtPmSVaoRFFjDIesuwPXDOZM9Gll8YyaHXZBWtmojr/od7xEtu4OS7AWn+TYy+B1V5g==
X-Received: by 2002:a05:600c:1d06:b0:408:4eb2:3b1b with SMTP id l6-20020a05600c1d0600b004084eb23b1bmr5617994wms.21.1698004969595;
        Sun, 22 Oct 2023 13:02:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15-20020adfe78f000000b003197869bcd7sm6269034wrm.13.2023.10.22.13.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 13:02:49 -0700 (PDT)
Message-ID: <pull.1602.git.1698004968582.gitgitgadget@gmail.com>
From: "cousteau via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 22 Oct 2023 20:02:48 +0000
Subject: [PATCH] doc/git-bisect: clarify `git bisect run` syntax
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: cousteau <cousteaulecommandant@gmail.com>,
    Javier Mora <cousteaulecommandant@gmail.com>

From: Javier Mora <cousteaulecommandant@gmail.com>

The description of the `git bisect run` command syntax at the beginning
of the manpage is `git bisect run <cmd>...`, which isn't quite clear
about what `<cmd>` is or what the `...` mean; one could think that it is
the whole (quoted) command line with all arguments in a single string,
or that it supports multiple commands, or that it doesn't accept
commands with arguments at all.

Change to `git bisect run <cmd> [<arg>...]` to clarify the syntax.

Signed-off-by: Javier Mora <cousteaulecommandant@gmail.com>
---
    doc/git-bisect: clarify git bisect run syntax
    
    I saw someone in IRC wondering about the syntax for git bisect run for a
    command with arguments, and found that its short description at the
    beginning of the manpage is not very clear (although it gets clarified
    later when it is properly described). It describes the syntax as git
    bisect run <cmd>... which is a bit confusing; it should say git bisect
    run <cmd> [<arg>...], otherwise it somehow looks like you have to "enter
    one or more commands", and that each command is a single argument.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1602%2Fcousteaulecommandant%2Fman-git-bisect-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1602/cousteaulecommandant/man-git-bisect-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1602

 Documentation/git-bisect.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 7872dba3aef..19bbed49238 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -26,7 +26,7 @@ on the subcommand:
  git bisect (visualize|view)
  git bisect replay <logfile>
  git bisect log
- git bisect run <cmd>...
+ git bisect run <cmd> [<arg>...]
  git bisect help
 
 This command uses a binary search algorithm to find which commit in

base-commit: ceadf0f3cf51550166a387ec8508bb55e7883057
-- 
gitgitgadget
