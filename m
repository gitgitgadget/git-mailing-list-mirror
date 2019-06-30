Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC4D11F461
	for <e@80x24.org>; Sun, 30 Jun 2019 14:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfF3OBI (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jun 2019 10:01:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38146 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfF3OBI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jun 2019 10:01:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id z75so4730831pgz.5
        for <git@vger.kernel.org>; Sun, 30 Jun 2019 07:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7KNX6jB64JlnK+muGguzzHslpoKq1yB3GXNzfzno99I=;
        b=B3A5sMd4KWD1sYWoKbIVqSusQqMzGrRiIiYEaba6dN1iuHCeJyYh3MjI3RLDsCsze+
         G1968DJgtQM2YTsxY9J2nHyBsbqJBIK5FrEbzIo3vJUoF5otA8xTtFEUneKYz/Qvgp9e
         W1FAbMuFpPhLY0Z9QTuVSH6se4eOzWNFm3pD5/Jzfh1Z1mybrB8cQ1HkmuJiuDCUj4tx
         4IlC12/ZWc064Rgqx0mLgTtRhDagx2gyNaSC7EuaTWMb0uDhtZQoMsOQq2e9bNhYDx7y
         x3zNHorNtjQ/jXEcPGstB6pzPcYj4k3XhVqm4vFUow/esGPFnVi/1JkKKZL7sruBZT2h
         WH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7KNX6jB64JlnK+muGguzzHslpoKq1yB3GXNzfzno99I=;
        b=O43brUDs2CJfd7ORx9VsvWvDlaSj/mEZpj43A3yhGKwEbaWXGh4UfJ72tN5uoEZycQ
         Mz5NigYAlD8a4SaC0gw7PG3rDrHANvjp1DPeXlQmUA3JblDgZfmEhiaZylRTFdcksH6c
         BXO9jnvyYqoY879ZLzR/i9pjWaHQ+ZjZhl4QkWaxLwfMcKqNpeWPNFrmSioQvsN9pgVL
         qylen2sKHB0ucJ/t+L1H+Jk945eLGTlaUt5tfekcxuGGTPMrtrzfxxTUxOF/59qVqiJW
         j6HEeCmEEneu4IkxQtPraNcdDk6xUpeQ20OQtH1LtA07TQtpQQOKu+31vZLueAUgpft/
         LR5w==
X-Gm-Message-State: APjAAAU6FQN7nzVe2OmQjRF1UycJjfqRI8zfk9maG9VCdWQPopgdy+nx
        jjYjxURwUUe+pZeg9fFRbrs=
X-Google-Smtp-Source: APXvYqz0k0NzY8VByy6/DxpewVPmM8LV2qr5rXtDAMd54EP2dpSACUhKR6nNFKPtayHgXMJlzJyzDQ==
X-Received: by 2002:a17:90a:d80b:: with SMTP id a11mr23933907pjv.53.1561903267680;
        Sun, 30 Jun 2019 07:01:07 -0700 (PDT)
Received: from ?IPv6:2601:647:cb00:ba40:f99a:b411:32b7:17a? ([2601:647:cb00:ba40:f99a:b411:32b7:17a])
        by smtp.gmail.com with ESMTPSA id q1sm11583842pfn.178.2019.06.30.07.01.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jun 2019 07:01:07 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [BUG] Symbolic links break "git fast-export"?
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CABPp-BE8um5g98jqWawsuG2dAvO6AZcR54vrRzAkJbq+L3K6Zw@mail.gmail.com>
Date:   Sun, 30 Jun 2019 07:01:06 -0700
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3AA3CC52-84FE-4FD0-8977-D4FBCF0DCE2C@gmail.com>
References: <95EF0665-9882-4707-BB6A-94182C01BE91@gmail.com>
 <CABPp-BE8um5g98jqWawsuG2dAvO6AZcR54vrRzAkJbq+L3K6Zw@mail.gmail.com>
To:     Elijah Newren <newren@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Jun 24, 2019, at 5:33 AM, Elijah Newren <newren@gmail.com> wrote:
>=20
> On Mon, Jun 24, 2019 at 5:05 AM Lars Schneider =
<larsxschneider@gmail.com> wrote:
>>=20
>> Hi folks,
>>=20
>> Is my understanding correct, that `git fast-export | git fast-import`
>> should not modify the repository? If yes, then we might have a bug in
>> `git fast-export` if symbolic directory links are removed and =
converted
>> to a real directory.
>>=20
>> ...
>=20
> My first reaction was, "we regressed on this again?", but it looks
> like my original fix for directory/file changes only handled one
> direction.  Thus, my commit 060df6242281 ("fast-export: Fix output
> order of D/F changes", 2010-07-09) probably *caused* this bug.  We
> should probably just sort not based on filename, but on changetype --
> send all the deletes to fast-import before we send the modifies.

060df6242281 is interesting! If I revert the changes in =
builtin/fast-export.c,
then the "t9350:directory becomes symlink" test still passes nowadays.=20=


Plus, my my new test case passes too:

	test_expect_success 'when transforming a symlink to a directory' =
'
		test_create_repo src &&

	   	mkdir src/foo &&
		echo a_line >src/foo/file.txt &&
		git -C src add foo/file.txt &&
		git -C src commit -m 1st_commit &&

		ln -s src/foo src/bar &&
		git -C src add bar &&
		git -C src commit -m 2nd_commit &&

		rm src/bar &&
	   	mkdir src/bar &&
	   	echo b_line >src/bar/b_file.txt &&
		git -C src add . &&
		git -C src commit -m 3rd_commit &&

		test_create_repo dst &&
		git -C src fast-export --all &&
		git -C src fast-export --all | git -C dst fast-import &&
		git -C src show >expected &&
		git -C dst show >actual &&
		test_cmp expected actual
	'

Do you think it would make sense to revert the qsort change
in fast-export? I haven't bisected yet which other change made
the qsort change obsolete.

Thanks,
Lars=
