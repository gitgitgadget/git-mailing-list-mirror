Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D9641F51C
	for <e@80x24.org>; Mon, 21 May 2018 21:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754461AbeEUVjf (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 17:39:35 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:52860 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753746AbeEUVjc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 17:39:32 -0400
Received: by mail-wm0-f52.google.com with SMTP id w194-v6so27492400wmf.2
        for <git@vger.kernel.org>; Mon, 21 May 2018 14:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SEkCN29p0Yg5QEZPEu5glyZy2YBqC0l+BiwjHNI0aa8=;
        b=ePInnt1wDZl+Zi/s75QjJxhEN4C0V1puOY0Ag7VnnfrAAdJ5nndPlCIK7Fm9Rf6eZ0
         3hNkT2M1i6/gBrJw2OA2bJOYvbdUa/KZRoqLGF+FjYZc8Igak067/Ozd6arZ5gCimKrh
         nsf7ugsLd8wr6nkHSEaAbDrVvAe+PUBwEWQw9ZTbsqrq39irRL8uE1p8xnQTxLsh0Hwx
         3ZvPSubGT9/UC7gOOh1bXMtbz4kZt9a0iewdj+RtDqkUM/k13aFGMxhB/vPlsxHQJVhT
         kLHFe28bMQCsrIxlQFreL04Uy4ERl37DCOvPVEXTyxHPJ0lAQvGx8KyC7QgmIGy+9d5R
         2B7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SEkCN29p0Yg5QEZPEu5glyZy2YBqC0l+BiwjHNI0aa8=;
        b=qCLj/R7gFFgscNr3XYt1RYFbMb2dpbzE04TytMAnyXatIdyXbVE/MFx63NTppbPnI6
         P94BZS9GdJt4oD/ASHuQpZhuHL1bN5WCSDUTRKZ1i+YOuLr3LmaufFxfX1k3AC4g35nU
         VMEAKtMTPQZ2K4dxb9R8MwLfWhISs3GIdCyw4L/e2skDrFUV1jydMH4ej36Ng0gu/QB1
         34Assr9GFURxxrc8yPYM+TQNxj2YZLYKhxEzxJlF89vA5v55MuaE2ofvi35Zed927Yvi
         qgc1b1P086BAV+qz5U9rzgY8Fjth8uuCUZ3LZNc2MzO92cuN0/ETKrty1JGjr47W17iC
         i2bw==
X-Gm-Message-State: ALKqPwcsSoveOZED7Ll9mpAl/mYJJ8DnpUS6KVZE95KjqE1+oaAWETH1
        JvwdzJNarPVNgLzNBwrRTes=
X-Google-Smtp-Source: AB8JxZqgr9ZNdYUvOAs1Ft5Kz1FBjAVQjDaiwkDEbfA3cCEcumw4uzK80ZNnn7Dh4W+0shIXICOoog==
X-Received: by 2002:a1c:a609:: with SMTP id p9-v6mr317222wme.146.1526938770928;
        Mon, 21 May 2018 14:39:30 -0700 (PDT)
Received: from localhost.localdomain (x590cf651.dyn.telefonica.de. [89.12.246.81])
        by smtp.gmail.com with ESMTPSA id t14-v6sm12863515wrm.82.2018.05.21.14.39.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 May 2018 14:39:30 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>
Subject: Re: [PATCHv4 1/1] git-p4: add unshelve command
Date:   Mon, 21 May 2018 23:39:24 +0200
Message-Id: <20180521213924.4491-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.799.gd371044c7c
In-Reply-To: <20180519100020.616-2-luke@diamand.org>
References: <20180519100020.616-1-luke@diamand.org> <20180519100020.616-2-luke@diamand.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
> new file mode 100755
> index 0000000000..cca2dec536
> --- /dev/null
> +++ b/t/t9832-unshelve.sh
> @@ -0,0 +1,153 @@
> +#!/bin/sh
> +
> +last_shelved_change() {
> +	p4 changes -s shelved -m1 | cut -d " " -f 2
> +}
> +
> +test_description='git p4 unshelve'
> +
> +. ./lib-git-p4.sh
> +
> +test_expect_success 'start p4d' '
> +	start_p4d
> +'
> +
> +test_expect_success 'init depot' '
> +	(
> +		cd "$cli" &&
> +		echo file1 >file1 &&
> +		p4 add file1 &&
> +		p4 submit -d "change 1"
> +		: >file_to_delete &&
> +		p4 add file_to_delete &&
> +		p4 submit -d "file to delete"
> +	)
> +'
> +
> +test_expect_success 'initial clone' '
> +	git p4 clone --dest="$git" //depot/@all
> +'
> +
> +test_expect_success 'create shelved changelist' '
> +	(
> +		cd "$cli" &&
> +		p4 edit file1 &&
> +		echo "a change" >>file1 &&
> +		echo "new file" >file2 &&
> +		p4 add file2 &&
> +		p4 delete file_to_delete &&
> +		p4 opened &&
> +		p4 shelve -i <<EOF
> +Change: new
> +Description:
> +	Test commit
> +
> +	Further description
> +Files:
> +	//depot/file1
> +	//depot/file2
> +	//depot/file_to_delete
> +EOF
> +
> +	) &&
> +	(
> +		cd "$git" &&
> +		change=$(last_shelved_change) &&
> +		git p4 unshelve $change &&
> +		git show refs/remotes/p4/unshelved/$change | grep -q "Further description" &&
> +		git cherry-pick refs/remotes/p4/unshelved/$change &&
> +		test_path_is_file file2 &&
> +		test_cmp file1 "$cli"/file1 &&
> +		test_cmp file2 "$cli"/file2 &&
> +		test_path_is_missing file_to_delete
> +	)
> +'

This test fails on my box and on Travis CI (in all four standard Linux
and OSX build jobs) with:

  + cd /home/szeder/src/git/t/trash directory.t9832-unshelve/cli
  + p4 edit file1
  //depot/file1#1 - opened for edit
  + echo a change
  + echo new file
  + p4 add file2
  //depot/file2#1 - opened for add
  + p4 delete file_to_delete
  //depot/file_to_delete#1 - opened for delete
  + p4 opened
  //depot/file1#1 - edit default change (text)
  //depot/file2#1 - add default change (text)
  //depot/file_to_delete#1 - delete default change (text)
  + p4 shelve -i
  Change 3 created with 3 open file(s).
  Shelving files for change 3.
  edit //depot/file1#1
  add //depot/file2#1
  delete //depot/file_to_delete#1
  Change 3 files shelved.
  + cd /home/szeder/src/git/t/trash directory.t9832-unshelve/git
  + last_shelved_change
  + p4 changes -s shelved -m1
  + cut -d   -f 2
  + change=3
  + git p4 unshelve 3
  Traceback (most recent call last):
    File "/home/szeder/src/git/git-p4", line 3975, in <module>
      main()
    File "/home/szeder/src/git/git-p4", line 3969, in main
      if not cmd.run(args):
    File "/home/szeder/src/git/git-p4", line 3851, in run
      sync.importChanges(changes, shelved=True,
  origin_revision=origin_revision)
    File "/home/szeder/src/git/git-p4", line 3296, in importChanges
      files = self.extractFilesFromCommit(description, shelved, change,
  origin_revision)
    File "/home/szeder/src/git/git-p4", line 2496, in
  extractFilesFromCommit
      not self.cmp_shelved(path, file["rev"], origin_revision):
    File "/home/szeder/src/git/git-p4", line 2467, in cmp_shelved
      return ret["status"] == "identical"
  KeyError: 'status'
  error: last command exited with $?=1
  not ok 4 - create shelved changelist

The next test fails with the same backtrace, too, so I won't include
it.

> +
> +test_expect_success 'update shelved changelist and re-unshelve' '
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$cli" &&
> +		change=$(last_shelved_change) &&
> +		echo "file3" >file3 &&
> +		p4 add -c $change file3 &&
> +		p4 shelve -i -r <<EOF &&
> +Change: $change
> +Description:
> +	Test commit
> +
> +	Further description
> +Files:
> +	//depot/file1
> +	//depot/file2
> +	//depot/file3
> +	//depot/file_to_delete
> +EOF
> +		p4 describe $change
> +	) &&
> +	(
> +		cd "$git" &&
> +		change=$(last_shelved_change) &&
> +		git p4 unshelve $change &&
> +		git diff refs/remotes/p4/unshelved/$change.0 refs/remotes/p4/unshelved/$change | grep -q file3
> +	)
> +'
