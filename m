Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B61EC4332F
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 17:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiKER2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 13:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiKER2j (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 13:28:39 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B599A11171
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 10:28:38 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id g12so10873273wrs.10
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 10:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z7c9Osir4B+wVz9UfmUBzkJhqfvqekMQsiDegCkGIp8=;
        b=RjsDWRJUXftfyOcg3Pi234GNz1XiTLqq+ra/Cgdxa3bWORlofdgEiuIkwb1ZEnCMBT
         7TLk+yNk5EhE29BkuhibZirwp8twoO6Sn2QCVPhhAcTuME5ZoWBiKh2HB8G0fhG3hI9X
         s+QMMuV3U5IZW5YienztCEWci2maMFudmXFrsICFa0Wl2e5CeEtjz/KnLD9dn/EvNTGu
         j7bS9wT4Qc//3Ftfq/HNqv+vlwpGcUOdYKtFaUU3lIatoYChFWzLbjTEZn5rqBqcyGtu
         2wGERsawyRtHcvBd4GG6nWyhZix24u61pqwJs4ke9UyKeq4K932ILopWBR/uLN7hSpP8
         cR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7c9Osir4B+wVz9UfmUBzkJhqfvqekMQsiDegCkGIp8=;
        b=TyZGz4/m4cZkLrLkzXY5jsse1Dfu5kK+s/K/aAcjMCByfg/oHHoVumth4AmQpGPSg1
         BrnAXVI2MAbA+YIJBWQIeXS5+m8ajqYg/Bfl5RH79hX6qohQ39WhxKpxWdsIhHpCsyJR
         yrT1dd38AUmo+PTZs+/IT1V5GvqF8/ZnT88LOcizaOuEAXvVSmOGY43aGSmL4+6G3lgS
         DqQ5t72hTr6jmpkaA7qaZBJ5nnai6xgP+VElokMrPlqVFb/O+sh81AvoETsRJIIbdQ21
         I0E/nvjU1V4MjMQFTuZl85xlgDj+Eba7bB9glklZuXFne8dpKv+tKR+PJ9xXlJd3/pYs
         TptA==
X-Gm-Message-State: ANoB5pmL1GUY2Cp5Xro4RVmIahseztp5SW6JCTSeX+rvtn384Qw4raBr
        t9n0mnDFo+0ziEzi3d8SxoQE2W3m/GU=
X-Google-Smtp-Source: AA0mqf6PyLu5xdHtufjR07NpVe4G5ZStDEPyn/2dQbCHHp5O0nEaTH116Vd94qFIFD3hrNI9b1rV3g==
X-Received: by 2002:adf:e18a:0:b0:23e:2928:b51a with SMTP id az10-20020adfe18a000000b0023e2928b51amr58894wrb.370.1667669317083;
        Sat, 05 Nov 2022 10:28:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x15-20020a1c7c0f000000b003cf537ec2efsm3001725wmc.36.2022.11.05.10.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 10:28:36 -0700 (PDT)
Message-Id: <pull.1374.git.git.1667669315.gitgitgadget@gmail.com>
From:   "Alison Winters via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 05 Nov 2022 17:28:33 +0000
Subject: [PATCH 0/2] add case insensitivity option to bash completion
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alison Winters <alisonatwork@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 3bb16a8bf2 (tag, branch, for-each-ref: add --ignore-case for sorting and
filtering, 2016-12-04), support was added for filtering and sorting refs in
a case insensitive way. This is a behavior that seems appropriate to enable
with shell completion. Many shells provide case insensitive completion as an
option, even on filesystems that remain case sensitive.

This patch adds a new variable that, when set, will allow Bash completion to
use the --ignore-case option to match refs. Additionally, some basic support
is implemented to match pseudorefs like HEAD.

Alison Winters (2):
  completion: add optional ignore-case when matching refs
  completion: add case-insensitive match of pseudorefs

 contrib/completion/git-completion.bash | 51 ++++++++++++++++++++++++--
 t/t9902-completion.sh                  | 32 ++++++++++++++++
 2 files changed, 80 insertions(+), 3 deletions(-)


base-commit: 3b08839926fcc7cc48cf4c759737c1a71af430c1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1374%2Falisonatwork%2Fbash-insensitive-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1374/alisonatwork/bash-insensitive-v1
Pull-Request: https://github.com/git/git/pull/1374
-- 
gitgitgadget
