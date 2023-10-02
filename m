Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BCFE784BD
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 15:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbjJBPPV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 11:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237774AbjJBPPU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 11:15:20 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D96B8
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 08:15:17 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-419787a43ebso26494221cf.1
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 08:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696259716; x=1696864516; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mquz/Sn+AwnFRs4k8+kD2bR0NPntbe0cwo41mPERFq8=;
        b=aZ5aYftGaGrQ0ycmH1rXaEvTASfDIfnI3T3kfPnpLLxNyE/GEIsEeB7BW/d4Hco6bE
         +3nLzlCjpKrKz3bGDaT/ENFjEwi3nuaS6IlcrDct+JmojH1cmbh2Io9lpW2nFyeOVIcN
         7Aho9acSjOA9ukqoa6V3M5s98mz/jyKoJLPjGyPQwsBAZXbVikUsR81tEtD5yYpeTxFj
         HbshtJimOWzMARL72+egHATgwDcpQMs6Hp99IKvV1GtYpDhNBurzGt0Uq9iEG9v2sExn
         uFBvgib051OH2jmstSdYNGQ9+TvSlkoA5EV6IKw/c56CadhCkAjg5X9cjlgM2AXevkFk
         Jz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696259716; x=1696864516;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mquz/Sn+AwnFRs4k8+kD2bR0NPntbe0cwo41mPERFq8=;
        b=Gj6fUqmujPInTNx/JDh4TYBjygKn5ZyFRIrGlgYiRuojwTzOv9Uwal8m9ScylfIn8n
         AezZtlHUYR+k41XLhdEAMAPvHtC2+Jds9ggWthZPJP9BlWcd1Op4LlDXCj1RJ7LYG2f1
         Q5ef8dyWJAkikoEtvb0OrKo8ElLXe318TWwOrqY2NH+lO7y/KfpY27xb8+L7aimDCvuG
         brZml348LJ29fsUJwNgzl62ScLDlY/zn03y4I/zn8zX3m2b6J19pwAfU9WVXLgzh3nM8
         uKW2YeCcZCaBgThnUEO81Cli9V3u5ReHetSMwiqgVeMuvxgwNDbmlkir8+85NgDt8FSv
         z+sg==
X-Gm-Message-State: AOJu0YwjSjrcMQtdITHCBz+U5JrL8i0eyxf1BVcqQ7TTlpvlv8nLwBdH
        QJxILf3nYp4cl5GzEiMEJZx1caxgLbUOoKSvzEFV4w==
X-Google-Smtp-Source: AGHT+IGPNi9TS4ffYOocVYPKZMYm36zDppPdIDvz9wBvUG0dqRs3D69PzlDo+IorWm/IFzx+OSnOqA==
X-Received: by 2002:a05:622a:509:b0:418:164f:2365 with SMTP id l9-20020a05622a050900b00418164f2365mr15757049qtx.62.1696259716536;
        Mon, 02 Oct 2023 08:15:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b10-20020ac86bca000000b004198ac8be74sm1576072qtt.65.2023.10.02.08.15.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:15:15 -0700 (PDT)
Date:   Mon, 2 Oct 2023 11:15:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: Notes from the Git Contributor's Summit, 2023
Message-ID: <ZRregi3JJXFs4Msb@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was great to see folks virtually last week at the Contributor's
Summit!

I took a couple of days off at the end of last week, but polished up the
notes we took during the Contributor's Summit to share with the list.

The notes are available (as read-only) in Google Docs, too, for folks
who prefer to view them there are the following link:

    https://docs.google.com/document/d/1GKoYtVhpdr_N2BAonYsxVTpPToP1CgCS9um0K7Gx9gQ

At the Contributor's Summit, we discussed the following topics:

  - Welcome / Conservancy Update (Taylor Blau)
  - Next-gen reference backends (Patrick Steinhardt)
  - Libification Goals and Progress (Emily Shaffer)
  - Designing a Makefile for multiple libraries (Calvin Wan)
  - Scaling Git from a forge's perspective (Taylor Blau)
  - Replacing git LFS using multiple promisor remotes (Christian Couder)
  - Clarifying backwards compatibility and when we break it (Emily Shaffer)
  - Authentication to new hosts without setup (M Hickford)
  - Update on jj, including at Google (Martin von Zweigbergk)
  - Code churn and cleanups (Calvin Wan)
  - Project management practices (Emily Shaffer)
  - Improving new contrib onboarding (Jonathan Nieder)

The list of all topics proposed (and the number of votes they received)
are here:

    https://docs.google.com/spreadsheets/d/1EnhmTeEqRBlEI2pMAO3oZ4rO1xEwBzYp2vS4CMtvge8

I'll send the broken-out notes for each topic in a response to this
message for posterity, and so folks can continue the discussion on the
list.

Like last year, if you have any feedback on how the Contributor's Summit
went (especially as it relates to the virtual format we had this year),
please feel free to share it with me here, or off-list.

I hope to see everybody in person next year!

Thanks,
Taylor
