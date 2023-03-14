Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6238C6FD19
	for <git@archiver.kernel.org>; Tue, 14 Mar 2023 01:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCNBGw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 21:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCNBG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 21:06:29 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CE78C523
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 18:06:26 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s17so8008045pgv.4
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 18:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678755985;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DntCCC7oRAhSRIytsB79R22y9SHubYFxZju0tcKOFOA=;
        b=crvjZbOc2K8yQ5Zv18Usjp3GOg1vkQge4C1zy6aMP4mOdkXWW3L2ATil01sQ0/ZuY4
         cZLXF0gSY2yuADZXk16v40YbVLtzmz/PxiEfl1m82dBWFptpIkMMjw4MsobsDKMWdBFs
         ZceudebVlMi6UnkiCZ0CE2zKsyZDO426wu5/i0Oaz9+rfKpt8SoAPd3/fm/uMBGTDDbX
         lw2VGO8RbrnYcerZJaeSaAC53b+Svv8/PKlSIxUBtQLCWLXWfEsYSig3mfBeYhR8lhmO
         EAjnXZ/nz7yHaT5LIAnWr9tIn/lvti3VYtZOXOv8K0Ocj9yBcbZp/Sw6Dgsu/EsQb7Ov
         IoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678755985;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DntCCC7oRAhSRIytsB79R22y9SHubYFxZju0tcKOFOA=;
        b=4lPNhKJ/gK5P2XLqFPLOk/3pHuGFb9tAav7cw2E0G+Ipkegm3V168h3WghIiHXEQfK
         wSNs1T+t7U/mKz7w2aV/+Mxnl57drugaabnHvj24EE6c2GCeDWkZ433vaJIl9MKOQKLw
         aN7NAA/tkUl3yqzQS/Q2reWi8Hr/eTlguoo2Mghyrk1BE5g9RSbTdHcRBAvjwGQT7x0E
         /dQUC/ibCFVP4Ijax0poCpKCtg0Sw0Wg+tVYmbfa2AV7ZG7tRCq+VDxtleM4WDfWvY8/
         P4DMUvpqKJs+1cgmnpUyyCwIlVEY/CkqPV2fBnc2vYAChuPEYtAuQeEVF2DP7sXs79h+
         uZKQ==
X-Gm-Message-State: AO0yUKUj1JVULyjJSx3eDJDwsBsnp7DidBZeWUsmawjZkGLY48oP95Gl
        C3vtMsQ6O3nuXuYrhDkhiQhj+5DIG9D0kSMyIIMX7Uuizeo=
X-Google-Smtp-Source: AK7set8cdfguY85DJBxtSWDUrAi8Kh3/8kL/e5st8teaTIvtFy8Zs8YpUvfUGqpfMf1PpEpizMk+4wEXBFWCbGAlSZU=
X-Received: by 2002:a65:6897:0:b0:50b:cc91:56b4 with SMTP id
 e23-20020a656897000000b0050bcc9156b4mr115490pgt.1.1678755985338; Mon, 13 Mar
 2023 18:06:25 -0700 (PDT)
MIME-Version: 1.0
From:   "Edward J. Ouellette" <ejouellette@gmail.com>
Date:   Mon, 13 Mar 2023 21:05:47 -0400
Message-ID: <CA+A2caFjpWZ_UqZx8YOOTxsYDWWxrXfapPBaNdQGdEX+m9GEsw@mail.gmail.com>
Subject: Bugs in config of Git-2.39.2-64-bit.exe
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
I just installed Git using Git-2.39.2-64-bit.exe on Windows 10.
Windows' OpenSSL was added to my PATH, and Git was NOT added to my
PATH even though in the config, I selected "Git from the command line
and also from 3rd party software" and "Use bundled OpenSSH"

Would you please fix these issues in the next release?
Thanks,
Ed Ouellette
