Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBA591F803
	for <e@80x24.org>; Wed,  9 Jan 2019 19:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfAIT6t (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 14:58:49 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:39750 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbfAIT6t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 14:58:49 -0500
Received: by mail-ed1-f45.google.com with SMTP id b14so8324143edt.6
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 11:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=r5bQMMNP/26F1oN4yhJFaNu66yT7OpiCtVtVmarrfU8=;
        b=eesu+5WAcGBFRyQy5y+iMipxCXiFkszY+NAe+/i6R/HcVxL81sHxvw1HjLgBgkE+M2
         HAe7pIIuVCP2p59nYmRp/5C3y3mfjf8j+G1comTtjIbr+ibiCJ0adULeKsNfRvBf/Fa+
         wAW/pVebzul19vJIxjjWyL7zc2VnqS1V6szzk2dPDxBLZnDwXVhBDuyRAEk7wvJRZAlk
         9uUJkQYw/ymZ0vFUjh8Nwx+m6m/+x7Rx18j6NpA4E0+VPsP98u/fJS8OzfG5b1MVE0Di
         +cjchp0jv90Hp9U3beH3DkEBFQu4cJYaXQNY1R/7/zP5BM5+uoK+DpZWqXwRdgh/dh+1
         R+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r5bQMMNP/26F1oN4yhJFaNu66yT7OpiCtVtVmarrfU8=;
        b=DAk1xSLRwnx+a5vLnpupTAD3kLpOo2GQs37osIKPP1re+vuAoUHp/NzfbGyDpMneUe
         JnRSHkvIlc1I+XeA06IW8PZ9bst/r69edfUB5bN4CgZt+UF6noLuVnmSNDx3VFrugGAl
         xkZXkrP1xhoGgNpeKWnpsxVvI6/dD2nhfGGFZ4dJZ7yh3/c4ygKQX40ZkxpkHHJWSSU8
         Wr0Vd4R26/o0QtI91cFds34cTVgmjDO/HQPonyR7MtwtsDQe00DOmypgqo1gJjkIr10T
         sf6T4LuiOqLCloTrPjFqZv6YUPK6VZzwHK20YgNPa6h78BnHAxJP7RlpiZgaxKNq0b3+
         ix5g==
X-Gm-Message-State: AJcUukd7LnO+AtItShlnVOWJhD63bTenz5auIo09TNSEDK2wFxeA0pXU
        FFWyYggzmxGbqcguNiALy23C8ml1
X-Google-Smtp-Source: ALg8bN4Qm7zI88iBgcXCcL4aPEO8RUHT7hGemh7jLTa/qNEsc869Jyabob8DXTZO4EdDqWvEOzdK5w==
X-Received: by 2002:a50:b006:: with SMTP id i6mr7282760edd.84.1547063927710;
        Wed, 09 Jan 2019 11:58:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p22-v6sm838975ejb.76.2019.01.09.11.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 11:58:47 -0800 (PST)
Date:   Wed, 09 Jan 2019 11:58:47 -0800 (PST)
X-Google-Original-Date: Wed, 09 Jan 2019 19:58:45 GMT
Message-Id: <pull.106.git.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] git-show-ref.txt: fix order of flags
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A trivial documentation fix...and testing out gitgitgadget. :-)

Elijah Newren (1):
  git-show-ref.txt: fix order of flags

 Documentation/git-show-ref.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: ecbdaf0899161c067986e9d9d564586d4b045d62
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-106%2Fnewren%2Fshow-ref-docfix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-106/newren/show-ref-docfix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/106
-- 
gitgitgadget
