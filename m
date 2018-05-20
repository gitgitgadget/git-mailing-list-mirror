Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 134421F51C
	for <e@80x24.org>; Sun, 20 May 2018 14:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751675AbeETOt2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 10:49:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54391 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbeETOt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 10:49:26 -0400
Received: by mail-wm0-f67.google.com with SMTP id f6-v6so21217429wmc.4
        for <git@vger.kernel.org>; Sun, 20 May 2018 07:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q+nY7tykqZNq6zw3EiBKhDsHoS/gy6SX5XagO8dQrOo=;
        b=OOn8ug9Vjl3yIOLxb2HNNVbMyr1ZZUxFSWDrm9cZ6X7MRuOUdRfENSChIUIoXqVrk/
         tNQpbLzm1jKQz8MxQbFrC3cHor8MMHbj4aB8ABDS5HP7IHlUlf1i3meCWMMiFrlIVz+6
         +pXfZ8jT97QHlg3rN9jvi4UsZJd0tCEmWmZgR4zPBlIYOm0lE+UR6sjc/CqJGwvSdVVB
         6pwju+se/rWvwcSNyr6KxRM2iWFQ4/Jon1bUC5o9KoZOOKlLtoI/Cq/zcfpwU0Lq6KGx
         0z9/ORHz8XRsiZN4FAI51u9d+yTP3y3pz1NEh3d/0BRTfIZRPmDmJS6E/jwzdTal4nYs
         3fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q+nY7tykqZNq6zw3EiBKhDsHoS/gy6SX5XagO8dQrOo=;
        b=W6XP4n6/hRnhn/qYnCbAuE/9RtnvYKUHOAGyFZGyl025Sg9t6SsxKppamR5MbCmimY
         w6jASjsqeWz/itqXINj4Oj4aTlhf0gTAcTGDw25xwFkHbT/JwQLkznF5v0/T9tYVzuo3
         Y0QnWUnDyV2ig5d8hrdwWdzdW6OSuS0VD3VFH9IrFeEPOrWvrEVWEf/xdzGvZqY65Xsm
         Yau0uvbA6zB1ATT3YwBIZeNZfdHVECOImMx8tXCf9abplQy2tnp59ke1vAi/UZJaLVgO
         VKzxucSfa7J2XwqDbq0wBJLR6iwDUHzl5or6WaULUlYvqwaIXBABqVs5xyOd7ulRZ6e0
         pKHg==
X-Gm-Message-State: ALKqPwdBYJAl2vJfou2p6OywNJxF78spzJqU6aKRKlNnctDJOd6+6XPm
        VlwZzP/zMqfmYHeXKqIZ8II=
X-Google-Smtp-Source: AB8JxZpeIZ2z4mftOW2QA1QOoRzkC0ZqNerFZT0FmuEOZWvcKsfPcBmMtKjHDhR1VnoY9F4pgoWWyg==
X-Received: by 2002:a1c:eb0e:: with SMTP id j14-v6mr8094177wmh.87.1526827765623;
        Sun, 20 May 2018 07:49:25 -0700 (PDT)
Received: from localhost.localdomain (x4db14276.dyn.telefonica.de. [77.177.66.118])
        by smtp.gmail.com with ESMTPSA id f8-v6sm5996426wrf.67.2018.05.20.07.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 May 2018 07:49:24 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>
Subject: Re: [PATCHv4 1/1] git-p4: add unshelve command
Date:   Sun, 20 May 2018 16:49:16 +0200
Message-Id: <20180520144916.5064-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.799.gd371044c7c
In-Reply-To: <20180519100020.616-2-luke@diamand.org>
References: 
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

Style nit: space between function name and ()

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

Broken && chain.

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
> +
> +# This is the tricky case where the shelved changelist base revision doesn't
> +# match git-p4's idea of the base revision
> +#
> +# We will attempt to unshelve a change that is based on a change one commit
> +# ahead of p4/master
> +
> +test_expect_success 'create shelved changelist based on p4 change ahead of p4/master' '
> +	git p4 clone --dest="$git" //depot/@all &&
> +	(
> +		cd "$cli" &&
> +		p4 revert ... &&
> +		p4 edit file1 &&
> +		echo "foo" >>file1 &&
> +		p4 submit -d "change:foo" &&
> +		p4 edit file1 &&
> +		echo "bar" >>file1 &&
> +		p4 shelve -i <<EOF &&
> +Change: new
> +Description:
> +	Change to be unshelved
> +Files:
> +	//depot/file1
> +EOF
> +		change=$(last_shelved_change) &&
> +		p4 describe -S $change | grep -q "Change to be unshelved"
> +	)
> +'
> +
> +diff_adds_line() {
> +	text="$1" &&
> +	file="$2" &&
> +	grep -q "^+$text" $file || (echo "expected \"text\" $text not found in $file" && exit 1)
> +}
> +
> +diff_excludes_line() {
> +	text="$1" &&
> +	file="$2" &&
> +	if grep -q "^+$text" $file; then
> +		echo "unexpected text \"$text\" found in $file" &&
> +		exit 1
> +	fi
> +}

It appears that these two function aren't used anywhere.

> +
> +# Now try to unshelve it. git-p4 should refuse to do so.
> +test_expect_success 'try to unshelve the change' '
> +	test_when_finished cleanup_git &&
> +	(
> +		change=$(last_shelved_change) &&
> +		cd "$git" &&
> +		! git p4 unshelve $change >out.txt 2>&1 &&
> +		grep -q "cannot unshelve" out.txt

Please use 'test_must_fail' instead of '!'; the latter would report
success even if git were to segfault.

Furthermore, don't combine stdout and stderr, but look for the message
only in the stream where it is expected to appear.

> +	)
> +'
> +
> +test_expect_success 'kill p4d' '
> +	kill_p4d
> +'
> +
> +test_done
> -- 
> 2.17.0.392.gdeb1a6e9b7
> 
> 
