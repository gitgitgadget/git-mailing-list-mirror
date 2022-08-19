Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5D1C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 16:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353709AbiHSQq0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353910AbiHSQp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 12:45:27 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAFF113693
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:11:35 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-3375488624aso104475187b3.3
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=8tN6LfAQkID5Js/s3G3/AnX8b8xE9jokcCvn9pbnjVQ=;
        b=fFvdabB8DWm67aaA2MfHcmzrYBYqbjISBqiosQnehZk5LazB9j0Bd/xrG57wci8bNh
         1L5hEbXpbX2f36/RTVbDJtKelIM0SPLQ1NaVLw9CQ2f0w46dnvCRIMc0x1oP7tBOkMmy
         PMUZz1MLtLuQKAwhf7iVhxFjKdwTDsPxri5pueVTQGsjtma+JlHHyYf3VswqEySjTOHw
         O4x1nUhZHlDufljgxzcPiV7iRCHU59AnjFYBm0UPWBaBUbV2sJPg95mHLXUdCvW6ubxA
         AcMHOE/SLtebm05WKdxGVjNBF4Mw75bphnOiMW/eAZ+l4SYCy1c/51A5c4xILWxwEOIM
         MKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=8tN6LfAQkID5Js/s3G3/AnX8b8xE9jokcCvn9pbnjVQ=;
        b=qs2XwbzRkml7M2KIMv3RybKQM9iy7Z5s0eZxtC1oOHxqkfpfGJR/IVA2WBTbtjcmZC
         vVAf8ft2ZTFejdUFwerMwCzcO7RmYpZsJ5Mu+8d/I4SxJkk2NIHdrSRsEYdHb7NzLe2v
         IQ/2dShB1FBwYGguJKLsywXen5yhQdfMof5fbQ+1RqM448BDXlw84kgXoMMYuxjt6uOc
         wTrNzZLCSFyrb6M3NtEF2x9yaGw6r9m/8pMUOgJ+7+w0Ture2R7AU1p6EVpto3YODq3L
         KaAU5EGt2XpytjXUwU78ItDU/pZaz3auPspfi1BUoJwcjnUJSfgsfbQrehiVSSnkPQ6V
         W6bQ==
X-Gm-Message-State: ACgBeo1NxPVZNIw3KgBWcDvTm0S/QSKfVTdrFUIf8pyfsvthZF/iBtT/
        jSEF1fknsUewnvVoX1tvzVATuG0wMOMn4w1goyXcTzKIKyY=
X-Google-Smtp-Source: AA6agR7FMA366HKJL/9pYhzdkb88OdmGQsURO1/ZkUay9UmxkurJ8Wjl3LSfeXWhbMgSquOAD8Pfy4K/uKrbSt/HoRY=
X-Received: by 2002:a25:da50:0:b0:693:74f2:21ca with SMTP id
 n77-20020a25da50000000b0069374f221camr7087632ybf.567.1660925453781; Fri, 19
 Aug 2022 09:10:53 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Heller <christian.heller63@gmail.com>
Date:   Fri, 19 Aug 2022 12:10:43 -0400
Message-ID: <CAOu2uD_CaVxxEtZhe4197ERDFASckUBtK_NyhmwQXr=5_reSXw@mail.gmail.com>
Subject: git diff --functional-changes ?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Feature request

I recently ran GNU indent on a larger C project which made all diffs
horribly noisy.
Is there an option for git diff to ignore changes due to the placement
of curly braces '{', '}' ?
Equally helpful would be an option to ignore changes to comments.

Something like:
- delete all comments
- re-normalize line-breaks and indentation
- show only 'functional' changes

Regards,
Chris
