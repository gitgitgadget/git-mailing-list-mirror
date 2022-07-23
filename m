Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D43C433EF
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 06:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbiGWGGe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jul 2022 02:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiGWGGb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jul 2022 02:06:31 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CA313F98
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 23:06:30 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s206so6026957pgs.3
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 23:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JLfg53x6utKU5YIBHcrvf6Qo22C7lqH1l51VbvvwcO8=;
        b=B5u870zZ0lOASXsuK/ETIcOhkB8ANUwnD/PmFLxcN/ISl9PhPwc4EYZrnVWpenRvvZ
         u1pa4H63OBgcaYjPh8X3RHXRbXdBj3/wRBFnGeY9xP+WgaPhPf0NK+QlqK2qst2U6sLz
         jrulR7CVL25whTLATatFZg8NIAL1ZxDZrRt47kXwAECQqHulFSVmaLzGp0V5RUjaJv5G
         crLqWKwMqZpLJXpAmBEUSUpV6WpktlEQ6dl8rJO14u0Zy1NcuzpIUZ1PYD/va5A6obVm
         hb6Ys324p1btflRNB3Xl30GlpdJI675LhquIMhxM2pMg7K/4cqy2pRzCWhtRngQOAR8A
         PlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JLfg53x6utKU5YIBHcrvf6Qo22C7lqH1l51VbvvwcO8=;
        b=YDAnVzuirFAe+jhiekjvpgzOkVDDFAJjhGGNJcRnAGFU82j4ERFxYeYgVkRDXQqmFi
         hV4CAPRY/XOpuO9iTi/JNDKdqVLEcIStoe0CAfa/5eMyYiq1JEYnUpp3Hnnk+L3VTEf7
         1DZJ4Jy5T4CBAZ6OLWH5aKZucDGuPPAZpoMKUDAKsYWRr7eXc+CF+LA68VLyYgj1OVMg
         qFJLlg7Uw1LfYyAi98mvobCeh4lde5SEAXdP++0q7GDWRHCef3Qc8EZhs90agwuQWmxp
         NXgbAm1YLir01PDYvDZ2uyUJmQhzVsnjOOVdpo3/YI9NzpfE87KWuuRGsCeyVhUfCpqF
         2Grg==
X-Gm-Message-State: AJIora/f7RwWVF8o37ZYvDdtGPgk0tMV3cSwyffUyWAlHiua88DYSPQD
        9oPMSmlCT1OmfuIbsdjlUQ4=
X-Google-Smtp-Source: AGRyM1sjieMo9p7bd0Qeca9yMTaXG3jwD1b9t8kUjCYC6A6YHhYddLD/gRvEtRGjUUrG2fOMshCueg==
X-Received: by 2002:a05:6a00:134b:b0:52a:d832:543a with SMTP id k11-20020a056a00134b00b0052ad832543amr3076144pfu.69.1658556390181;
        Fri, 22 Jul 2022 23:06:30 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.97])
        by smtp.gmail.com with ESMTPSA id w126-20020a623084000000b0050dc76281e0sm1225286pfw.186.2022.07.22.23.06.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jul 2022 23:06:29 -0700 (PDT)
From:   "tenglong.tl" <dyroneteng@gmail.com>
X-Google-Original-From: "tenglong.tl" <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@jeffhostetler.com,
        git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v1 1/2] api-trace2.txt: print config key-value pair
Date:   Sat, 23 Jul 2022 14:06:19 +0800
Message-Id: <20220723060619.24566-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.37.1.1.g8cbb44ffc4.dirty
In-Reply-To: <xmqqy1wkc0yw.fsf@gitster.g>
References: <xmqqy1wkc0yw.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Isn't this a bit premature to do in [PATCH 1/2]?

Yes, one oversight, sorry for that and will fix.

Thanks.
