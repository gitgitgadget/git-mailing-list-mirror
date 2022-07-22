Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FD9C433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 06:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbiGVGMv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 02:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiGVGMu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 02:12:50 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371D92F66C
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 23:12:49 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b10so3524714pjq.5
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 23:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cwJrPTL2atuEO3dHpSIu5kjTS+EEMk55uTcXmwEchMA=;
        b=KGm761ZLQLWITXkDoV81RGlUOqB0dHyodHkKFKfvHZuJf2EAUzDbhDSolxwr/NTda8
         hOinvyhDnhxl2xW8WrLw7fKnxOfv59vbF24zSljj9NX717W/80uSr3aq2m5ZqgPq6MOu
         krEYvQ5pTdxwH7Fs5lWUdw55waEwpAiXNq9A4ZMx+ByXFaVrWSBbYohsf/6wk8D21mkv
         iS96szEu/OtYRwHujxU7EP8xfilYc3hBbRs9i65TiuxCGDxABjtyTXntKHMi5CS9byG0
         UyxKfJu21pNhZUHevWlp7VDzzM6czzSIOUT9bdD0LhPPHL+Sv6IYqisNMreckcG0LELX
         vuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cwJrPTL2atuEO3dHpSIu5kjTS+EEMk55uTcXmwEchMA=;
        b=7x3aTJfrWkSXhafFBRK8Jlot4mjv06B/3ebZ1a4rl022pMBx388cp+EFlPJtAiXzz2
         AD5+PXeZPyrfGymHORAyXsz9bBxEOfXK/9S3SVMwt55uTxkpp5sAxEtv1U0czN/HYEf9
         SlrqFqTXW2CkL+wcxbXqOlQkLm3HN2YJC6BZxUsq6h4yzZc3vkGRsZ2AeZAE/0tR8p6N
         siHMVk23EXrd3Z300Y1Gxzgbz/oNeNYanlh4o9+kR9PJ+vgodZlrQJX/ZHCE78hjnsDF
         PHb1JEKDe7nwvKyKgzGWGio3wnnZA+cwkn6SEpdtNmCWcuBbvHsYtmbjUoubTiWb+Bd3
         6dbg==
X-Gm-Message-State: AJIora9NUfV0mv7et7CyPzdTgqzXTT2U4w0NKPtFCCvRAKWwuL8aoWaa
        9SUnm66nf4tXXQWuhGYGT9ieO/hnP1k=
X-Google-Smtp-Source: AGRyM1v7+arUsCiTxTfFP752umsiIAjlqHdgaQkDCbh2z72wAFXPgXQtmkWuosoSMVe15wlybmrO4w==
X-Received: by 2002:a17:903:52:b0:16d:22e6:ed2b with SMTP id l18-20020a170903005200b0016d22e6ed2bmr1884316pla.109.1658470368474;
        Thu, 21 Jul 2022 23:12:48 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id v2-20020a1709029a0200b0016d2db82962sm2736683plp.16.2022.07.21.23.12.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jul 2022 23:12:47 -0700 (PDT)
From:   "tenglong.tl" <dyroneteng@gmail.com>
X-Google-Original-From: "tenglong.tl" <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@jeffhostetler.com,
        git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH 2/2] tr2: shows scope unconditionally in addition to key-value pair
Date:   Fri, 22 Jul 2022 14:12:40 +0800
Message-Id: <20220722061240.9348-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.37.1.1.g8cbb44ffc4.dirty
In-Reply-To: <xmqqh73ajteh.fsf@gitster.g>
References: <xmqqh73ajteh.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Everything in these examples use concrete values and follow the real
> syntax (e.g. param is enclosed in double-quotes and so is its value
> core.abbrev; even though core.abbrev is not the only param that can
> be reported by a def-param event, it is used as a concrete example.
> The same story goes for value).  The new "scope" thing stands out
> like a sore thumb.  I think the above should read more like
>
> 	"event":"def_param",
> 	...
> 	"scope":"global",
> 	"param":"core.abbrev",
> 	"value":"7"
>
> or something.  Pick your favourite value for scope.
>
> Other than that, these two patches make quite a lot of sense.

Yes. I think you are right, in this context, we should obey the same syntax
and will fix in next patch.

Thanks.
