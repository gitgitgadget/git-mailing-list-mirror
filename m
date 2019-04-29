Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC5FC1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 22:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbfD2WGN (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 18:06:13 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:40104 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbfD2WGN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 18:06:13 -0400
Received: by mail-ed1-f48.google.com with SMTP id e56so4246247ede.7
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 15:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:mime-version:content-transfer-encoding
         :fcc:content-transfer-encoding:to:cc;
        bh=DO52RJ/SVvfCyD7UeoKxs9VYQn2aaXhSelxHe0cpFpo=;
        b=NCxW6mNkwCmHNWthiXkvLzeIK3s6exCHA41mWjiuovHynRM65mSi9Wo52kglQ1jrqd
         pensyoIOrFeeBJ5Wf9XpOIkjgygMK81TiKTzEsy0ELV9NMCLyOi1/OBzexTio9GkNmXl
         ZcaLFj7wTQea2lIKb5w7K8GY+G0vlJv5cnUfC6dDzPUuXIQk7I0Jof9GoUVA/kU8R911
         RWSgII21WM3ZFSPwHuCIanaMNUIsp4ToQ/pGOU9/mKL+rVppqq+/VSunKSC+sWzIeKYC
         i9uarTx3D2LxBMnVZg++BGCtKU7e3eEaQV2uf6WRQd+7KD0oV5YYWENRlVrQS1FAZ6Cp
         O34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=DO52RJ/SVvfCyD7UeoKxs9VYQn2aaXhSelxHe0cpFpo=;
        b=X6r81q/g7I6azWdYHIysdyxokHnrrkwVxJ+2R/jSzcavY2g9WBRfiDGU8wOba/Q6Ov
         9WixOrfQiQn8TyXNe/9YREn0PuTayTSygDpkaZqn4tA4RKyUfwFC3rIV1BfCQoGYG7Sa
         6DDSXfebK6gf4btY7Z296eWL9T3jrjwgF/aiOAbMez2QfW5RQwmv7x43O23FxyuB5PdL
         j8yc80XBIeBiRoJwjoGQO2BGWuGucpBtwT6njawRkQjLmwDMzlI6vH98BZK2WGdZfQ/A
         IJn1DuXj7NxL+VVFvq6A7Ml8nVIlpTkUZhnd3wbeeu16dL1cS6Gomi7sfIu6uhZxvvVf
         24oQ==
X-Gm-Message-State: APjAAAXQQ7S/BgV0j2yq5EGiUpMd4kpeT+R66sXcxvpy0/LD3SncGB3x
        EU2hh9qhYAo+wC+4jUrharjl6ccN
X-Google-Smtp-Source: APXvYqwllLOMc/ygXRMEpD1Cv1J67rhtWyIABpxgSG35nmi2HNTxQor7qduBlvtBjPpS1UcqgVr/2w==
X-Received: by 2002:a17:907:104e:: with SMTP id oy14mr309436ejb.253.1556575571377;
        Mon, 29 Apr 2019 15:06:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y2sm9417768eda.52.2019.04.29.15.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 15:06:10 -0700 (PDT)
Date:   Mon, 29 Apr 2019 15:06:10 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Apr 2019 22:06:09 GMT
Message-Id: <pull.138.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] credential: do not mask the username
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is yet another patch that finally makes it from Git for Windows into
core Git.

Jarosław Honkis (1):
  credential: do not mask the username

 credential.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-138%2Fdscho%2Funmask-credentials-username-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-138/dscho/unmask-credentials-username-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/138
-- 
gitgitgadget
