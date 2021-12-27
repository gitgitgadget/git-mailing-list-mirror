Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C570C433EF
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 07:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbhL0HJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 02:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbhL0HJK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 02:09:10 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1E7C06173E
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 23:09:10 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id j13so10856906plx.4
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 23:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PoRGQoC9f+MUZLMgpMsaTB7WO0wk1QH1BI2MLQucJtE=;
        b=UtjqPyJpgB+I2BPNEEC9S2MrOVqm0zKwhxX7ez4NjygBa1Z6C/mldg8UjH5kvLsRfj
         cKD4YHDMpquVyS0u+aH2Q/RpZPobbeYf1sl/PjqMG3mPWt/mTHb/ZmlWrCWFJAj+e69V
         E229yaZAXrHE1JceZaH/YAYmNaUnCwCQvDXjthEJLl6nVRaMZ00BpNhO141+RykKas72
         xoQYFDMA+d6uBSjxJtGnxgDitcgSpQrlNZtDdsVxKTcGvKXZ8Yb/aJ6vOh/CVqbwxYMZ
         DEm5RhdlWScrM7i74eaYTcUgT2FuCs8TevQP2D8972e+T/9uHeUWyjzILxw+pif0YCA8
         +IKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PoRGQoC9f+MUZLMgpMsaTB7WO0wk1QH1BI2MLQucJtE=;
        b=KxTUHzCwiEwb9oKpk4PaJbyZ663rhzmXU57wcaePcCeXJ1Q2yVlInQi7EEgAG7A6Xy
         Vhvpn+SQILN6Z3xxyVG/j297f5DOa7O9YZoM2fJctlzk5L/HgJwAY1S5HvkJrTqb8/6K
         uZrimI1I/mhEbYySCQfTeSJ3qU/VM6ZB79yoAPBXET7Y1X1oYpYVWlJJJFsyAc2qKTPO
         Dp+mRd/0zms+94RLLeKAwh0aTFRVmIjFclRmsfVk52pGNaHiY/MuJ+IjboMr1T5Ugqim
         HR/UJZV7gSQNwgz+vef61pNMVrnZkaJCJ9DHJjhJBQk+U+GjERLKtaSw2AG2Fn6BK5yF
         29tg==
X-Gm-Message-State: AOAM532DHjMmSfBpr3bQQ9hV/UP7GVBtPxXgIv5rBCU3p/BNWYCo4p0n
        fvmkFB11mxaumg3z00qrO30=
X-Google-Smtp-Source: ABdhPJwT+cGcBzvCBf6mR+OEssDmnB3LZyjc7etLYeoRRidXQy6nSwiancl+TttC7tUM6SP1/gL1NQ==
X-Received: by 2002:a17:902:e541:b0:149:35bd:b260 with SMTP id n1-20020a170902e54100b0014935bdb260mr16111008plf.41.1640588950222;
        Sun, 26 Dec 2021 23:09:10 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.100])
        by smtp.gmail.com with ESMTPSA id o4sm15371531pfb.119.2021.12.26.23.09.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Dec 2021 23:09:09 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     avarab@gmail.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: What's cooking in git.git (Dec 2021, #05; Thu, 23)
Date:   Mon, 27 Dec 2021 15:09:02 +0800
Message-Id: <20211227070902.4656-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.1.11.ga38cbfc207.dirty
In-Reply-To: <211226.8635mfgu7o.gmgdl@evledraar.gmail.com>
References: <211226.8635mfgu7o.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 26 Dec 2021 18:15:53 +0100, Ævar Arnfjörð Bjarmason wrote:

> Yes there's the test problem I mentioned in [1], but in addition to that
> your current set of patches have around a ~10% performance regression,
> as noted in [2]. My RFC series[2] side-steps that by leaving the current
> code in-place, and only introducing a new optional --format path for new
> output formats.
> 
> I really don't mind if you go for "WAY-1" first over my RFC --format
> "WAY-2", but I do think any such change should be prominently
> noting/selling that this new feature is worth the performance
> regression, or finding some alternate "WAY-1+" to avoid it.

Yes, I see what you mean, and what I'm trying to say is that we see eye to eye on
this.

As I mentioned above, the performace regression is compelling and I looked
into it on the night before and already found out why the regression was
produced (But I can not send patch over gmail at home because of the network,
maybe i'd like to try with GitGitGadget next time). I will not omit this problem
and go on working at it today, similarly, wouldn't reply this thread otherwise
the new patchset is reach the standard (As I see the "cooking" is let others know
what's new and the corresponding progress currently and discussions should still
be made under the "patch").

Thanks.
