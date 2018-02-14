Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7CF51F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161915AbeBNSbe (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:31:34 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34323 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161897AbeBNSbd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 13:31:33 -0500
Received: by mail-wm0-f52.google.com with SMTP id j21so18957643wmh.1
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 10:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=XAQA9BFZk1uwhHd3Q9YQITLB7W6wU5An8M4pt2ULHik=;
        b=EHnkyvRPTSZvpkptmK1NG4BPW9pWRYdrHuP+kY4t7u72n7EpcFDaxBbnRoPwTfGaK2
         FSwLrwaG8tFZFgwUJpvcQRLkRqep2xIXTcuE8pPFwIbj6l/jXVq1tU4rfmaG//oa2Pz9
         DEykgQNTkMTm9U+2SJE6ENwCuL8lEVFahqRF3cirCQYC76JfIuKd4R5iHp2k8whOyI/Q
         hDSk3SpefEtxI/kp6hKoJVQwv4efCwuaPo4htZ4dWHTEztzPW8ui4vDlEZqmU5iq9kSM
         aGnhauUI0GKj9VO6jmq+y7aK6UD9eFT1Dzyo4O4n7Ps8rw51KoM2mEcDiW97QIqpbtmM
         sTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:to:from:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=XAQA9BFZk1uwhHd3Q9YQITLB7W6wU5An8M4pt2ULHik=;
        b=Da4zv4icezsqTNw19u9uT9+wbzHXgtkxjHyfTZ6Xjz1CQ7mD60sVlCbzR2shxMx6Rt
         WlSrwUFwQuIuZL5nzcIQ431DV7kGV0FyXHRyqFMpLvK3MFvtaU/37e3fCqVdCpY6znwL
         i7zORJ6RRuxj1ENK6S72HGhf4HbUB0lZp+8Dn2GiJRtmYCIGkWDVMnOqGJff3sOQdH41
         IaieUph23jzPG07UoyDhUvMWXyQeEdUq1vRLKw6jkkOciJRYm3dCx0dB4ODvcTPxe7U4
         qKfvOUzofA2bLoyp4Ab6wCrtvtP2vJuzlxZgLE0V0fFEZHBP7FbVtdXqX+guGTA5uIi2
         iFiQ==
X-Gm-Message-State: APf1xPDI0Bq5yylXSWgN1R+k99VpQGuXP7rgUwBjaYtXxER5QjPIckhe
        BTZg5T+ypMj45CuyM1Y3u/apdw==
X-Google-Smtp-Source: AH8x226rWHVhGGwBk/i/XGjvn5Nrq02Aksed9cZxhPrVxOQ1rn0dxyhBVlk5JmHiriiQDMkvjxNXIQ==
X-Received: by 10.28.40.198 with SMTP id o189mr1640wmo.141.1518633091679;
        Wed, 14 Feb 2018 10:31:31 -0800 (PST)
Received: from venice.bhome (94-38-17-252.adsl-ull.clienti.tiscali.it. [94.38.17.252])
        by smtp.googlemail.com with ESMTPSA id r68sm1749946wmr.14.2018.02.14.10.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Feb 2018 10:31:30 -0800 (PST)
Reply-To: kreijack@inwind.it
To:     git@vger.kernel.org, Goffredo Baroncelli <kreijack@gmail.com>
From:   Goffredo Baroncelli <kreijack@gmail.com>
Subject: "git add" with several pathspecS and one doesn't match
Message-ID: <d5e4138e-d5d6-3a84-a222-8d0170a52ccb@gmail.com>
Date:   Wed, 14 Feb 2018 19:31:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

I am facing this issue: I am ADDing some file with several pathspec, and one of these fails. The results is that no file is added at all.

Simple test case:

$ git init .
$ touch 123.txt
$ git add "*.txt" "*.doc"
fatal: pathspec '*.doc' did not match any files
$ git status
[...]
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	123.txt
[...]


Results: no file is added
Expected results: the files which match any pathspec should be added

Looking at the code, git works properly:

from builtins/add.c, near line 500
[...]
		for (i = 0; i < pathspec.nr; i++) {
			const char *path = pathspec.items[i].match;
			if (pathspec.items[i].magic & PATHSPEC_EXCLUDE)
				continue;
			if (!seen[i] && path[0] &&
			    ((pathspec.items[i].magic &
			      (PATHSPEC_GLOB | PATHSPEC_ICASE)) ||
			     !file_exists(path))) {
				if (ignore_missing) {
					int dtype = DT_UNKNOWN;
					if (is_excluded(&dir, &the_index, path, &dtype))
						dir_add_ignored(&dir, &the_index,
								path, pathspec.items[i].len);
				} else
					die(_("pathspec '%s' did not match any files"),
					    pathspec.items[i].original);
			}
		}


It seems that if any pathspec doesn't match, all add action fails. Which is the rationale of this choice ? I would expect that an error message would be printed, but the matched files would be added.

My use case is the following: I use "git" as backup system, and I do something like:
$ git add paths/*.doc 
$ git add paths/*.pdf
$ git commit -m "bla bla"

I know that git is not the best method for that, however we have a lot of files which are moved between different directories, and git seems to handle this job quite nicely. 
Unfortunately the filesystem is quite slow and quite huge, so I would prefer to do a single "git add", in order to avoid to traverse all the filesystem more times. But this would not work because if one pathspce fails, it prevents all other pathspecs to success.


Please put me in CC because I am not subscribed.


BR
G.Baroncelli


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
