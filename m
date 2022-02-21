Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78598C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 17:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238878AbiBURfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 12:35:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbiBURfL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 12:35:11 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B82C1B7AF
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 09:34:47 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id z16so9501693pfh.3
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 09:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=03IgFXe+3mwg2i+pDaXj+NHxZQBvizI/y+l2tw/lNlg=;
        b=puj3GdpddDAh0JMv7W8pDQqwuvU86SrLJQyLmA0uZ00zaZQyqn+5XI+9EYE4uMIy2Q
         kDJfPH7BONT2cViokhy9w+mgkVQ1frAJrp28B2yeUTk28tuESLbRzk8mLwMzSNqcV327
         Q8A1YF74qbu5Vp9xZGVhAmWZUR9TS6Li8oiqhB9iVfxLzpTXhXoKtFfhiB7U061bjAxl
         Iltl7HwW3zfm3wp8zLnXaZlBhUwbXwFwnCpF3Bhxm3A4/5NT3LrEYKiNNj/RTqNhFv7c
         yPlv7OnDxPMPpDHrH0iVsCGMg6XodKf8DygSThHR9m8Kj/ex+VppgC+zPoW1p2BAAP0a
         t/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=03IgFXe+3mwg2i+pDaXj+NHxZQBvizI/y+l2tw/lNlg=;
        b=3pBvN2T6RwEdbOmsZcc+LQWZ/AB7v1hyyv/eGMxaY+JSCiiiegguySKxOthAsYuD2O
         6BWxlHnZXI6doixoOi+8DNhf2FOnWAlUnuQrMdWH5Z5rdSjL4SNfpbUj1E8AGEzXts65
         ofxBPTp9v6Vv7cPl4/5ZumLvu/zZnRIrw72RVxYur75TzJom02zhTZSFD+1+UGTlZAl+
         ckopZus0x+V21qljQvNdZ84PGu6YoiAosmCO0fQ2xKrhBcYAD8urkNsvCmYZtogW5VZe
         H6f7D2uCBvzfSxulDqyuOSAbWdSSScvMO05t4OecywivhhPVl/ZKkxEajJosu93QSNgo
         16LQ==
X-Gm-Message-State: AOAM530Eqsbt5ADj3HS5+s9ngDjwGniq0hEAZQyonGGBcjUWWcvlkolo
        uGULdw+/lWohhMUgd4phcBvesiz4yMl0LQ==
X-Google-Smtp-Source: ABdhPJyXwDVKnnPHB/hnCD+5gb+l17NgW4L6S1yLxrmWHAuhiBiV/BTa8qdt4H+z4Z584qQOSmeIqA==
X-Received: by 2002:a63:4a22:0:b0:372:9a9f:d4ac with SMTP id x34-20020a634a22000000b003729a9fd4acmr16975089pga.331.1645464886280;
        Mon, 21 Feb 2022 09:34:46 -0800 (PST)
Received: from localhost.localdomain ([202.142.96.14])
        by smtp.gmail.com with ESMTPSA id l12sm14499517pfc.182.2022.02.21.09.34.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Feb 2022 09:34:45 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] add usage-strings ci check and amend remaining usage strings
Date:   Mon, 21 Feb 2022 23:03:57 +0530
Message-Id: <20220221173357.8622-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <220221.86tucsb4oy.gmgdl@evledraar.gmail.com>
References: <220221.86tucsb4oy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:

> Sorry about leaving this patch submission hanging. I read this at the
> time, but forgot to find time to loop back to it.

No worries. Thanks for reviewing :)

> But in this case there's really a much easier way to do this, to just
> extend something like this:
> ...
> See b6c2a0d45d4 (parse-options: make sure argh string does not have SP
> or _, 2014-03-23) for the existing code shown in the context where we
> already check "argh" like that, i.e. we're just missing a test for
> "help".
>
> Obviously such a function would need to hardcode some of the logic you
> added in your shellscript. E.g. this fires on a string ending in "...",
> but yours doesn't.

Thank you so much for the suggestion. Didn't aware of it before. I will
try to implement the logic in parse-options.c` (as you suggested).

> That should be fairly easy to do though, and if not we could always just
> dump these to stderr or something if a
> git_env_bool("GIT_TEST_PARSE_OPTIONS_DUMP_FIELD_HELP", 0) was true, and
> do the testing itself in t0012-help.sh.

Okay but if the logic can't be implented in the `parse-options.c` file
(most probably I will be able to implement the logic), would you allow me
to try the `coccinelle script` method you mentioned?

Thanks :)
