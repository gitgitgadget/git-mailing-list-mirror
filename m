Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A799C54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 11:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiITLTT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 07:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiITLTR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 07:19:17 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019DB73923
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 04:19:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id s14so1784530wro.0
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 04:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=wSc3xGcQyArf8ki39KjokR4QxgBLthikAveacvTEhjA=;
        b=CgbIpudF0M4fbugru2ox0A8Ovqp+sUeSaOpDpg6W5FJbdmzhVaZF0BSg7AopzmViGj
         tNWqeVFzNF1nPTbcYDoPCQ0eBhQE5gcnQYDYDFHAbMpaNppkvnQ6LvUNan5tO8FXSzQO
         SsMgJoOhoeunohSC3TTBlnAeODRBvUMHO41E0gXht4ceTVF7/OlCUkTJTyB7RkvrhtqR
         bjPeqepT+ketZ0Cg9ksxZV97Q+bTuO6InOGoX+jlg5K1ulXqWOfjuxY4FyPfBR4++/o0
         IL4NU38TEPXHc4N9hfR1m94OIeNX1SRnO5hzzOoX+iYRpaNfEl/8sSKi3ZB6Avm5kub9
         W6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=wSc3xGcQyArf8ki39KjokR4QxgBLthikAveacvTEhjA=;
        b=0hj9Nemi70xLFk7IvMlUj3BLwoowPKG18SzUWXSXDSXpK0VDY4ae35T4A8lczMZ+AS
         NS02k5iBry3+aS+72ScMmPdkY7lkXVelVbCrhifFjjZ5laSWHa+R2DNPx0cRYHOkmhI7
         VN0Qlp/ZDLyxQcsLNuFfJ016Vazke8incLM/f/K1M+A7qsdpgaokWaiHzQmlBZ+LmxA9
         m+XetnAYVdS/ao5di7RY3dH7oWPxTidtuHEivgDQ3ZRKYFLopDx/7UfPWUqtWBUIYFpb
         tIXINS66Zl8IgEoDqSWe9Fftoz/oMbH1pMThWiuTD6d5KK1z6yVLNVXkSUjo2JWtA8Lw
         CzAQ==
X-Gm-Message-State: ACrzQf3ryZO+U2diLAlD8RGMF5W77yN3aG5G1DwDB3Ewhw4pj0CeU9aa
        pxbwPDWgWmZW0b68JvG14YVNXV2kj+Y=
X-Google-Smtp-Source: AMsMyM7gPQpvW18VRI5PcsMH1Pye5KSezN+uicvCWQ4apYVPWDUpYewVGtbN47K2fT8ry5OwpEZFKA==
X-Received: by 2002:a05:6000:1864:b0:22a:e349:f031 with SMTP id d4-20020a056000186400b0022ae349f031mr11927584wri.476.1663672753365;
        Tue, 20 Sep 2022 04:19:13 -0700 (PDT)
Received: from [10.41.178.59] ([163.5.10.3])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c4f4600b003b47581979bsm19084425wmq.33.2022.09.20.04.19.12
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 04:19:12 -0700 (PDT)
Message-ID: <f9e1c3a8-9b2b-3940-7538-ce7bc367d089@gmail.com>
Date:   Tue, 20 Sep 2022 13:19:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To:     git@vger.kernel.org
Content-Language: en-US
From:   "adrienhoupert1@gmail.com" <adrienhoupert1@gmail.com>
Subject: [CONFIG][SUGGESTION] ask for check in git-config
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Some of my friends wrote recently there config for git on their new
computer, but they miss typed  some character. Nonetheless the config
was written as usual. So we would like to ask if it was possible to add
some basic syntax check as in visudo for sudo.

Regards,

-- 
Adrien HOUPERT
"EPITA student"
