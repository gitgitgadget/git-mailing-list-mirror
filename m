Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502BEC4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 00:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbiLTAvC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 19:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiLTAvB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 19:51:01 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BB9F591
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:51:00 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 65so7462992pfx.9
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnwtpgiJYNg0vDvXfIVbsTiDRsXANF9tQ4hI4RkLV/8=;
        b=paTmfHhlmaP7UmvARz3ujIzJMz3F5KS+0qJ+m5yfyFSnSrQ+P+ms1iJ9uDv+qApNLv
         BThzpU8b6SWVioIYonzTh91L5eLj30dERwuqflvxwUkcHQZdp2GfUSNi4/dHJ92vYTFm
         MJs4r+JZdbCM7uJm7ntWwdJzbpZQtdJjATg06IH5utA1tG69cKhZdnrW1/MqOLgomkes
         NjQsuzc0e6ig0cSsNlc0bFqQO/1/N/EbePc0UFJcNYXzb7RsSqMHirTYBICdB+7WC+19
         Md74GKuDTXUmvCnIbindFAKk1bbpjoc0FMqymSglkwITH28WA7ACRAmzWPBEID0lDsce
         RyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VnwtpgiJYNg0vDvXfIVbsTiDRsXANF9tQ4hI4RkLV/8=;
        b=mvKUseTwG3oztdxDuKMGmSay3nnA/+CXil6MyWwlWW9AkYSI4Um6FaRHhj6dbpp1t5
         24crO8HbM7hOwMSKkBp0z8MXRnzaScpHEmSb+LCeKqKaYxYubvUub6pmSzRckKEW5Qei
         Hk70Y600072rFx6s3WTB+1Ycd1oQ4rPKAwjYYQW2ntzE+6FEpxtnoVwb1w3qZ0xIjMXN
         1IJQIOdgK0ktLCTjqMWV7/J3LzM+rT6X7/HW047pinZuZxEmWM+vrHZrwAJPy2ia3goL
         5W63D5sf+c0eDZqkNgN/HS9oouNJYCmjsfRXV07/eYHN9mlpkNTh8uoYIY2R2aVKy7vb
         4IUA==
X-Gm-Message-State: AFqh2ko262qyE66bgF2G1mmSWN7cx/AdzfSJz0saAK5fU5XvusmTmx3S
        eg1b6axwZBQCgyOJbzUdDsU=
X-Google-Smtp-Source: AMrXdXulA5TSKSPE5CzDT+f2CDjR0uGlxxMUki6WWOgEl9kbKf0KYv5he185Bc5mDUzsubKFHICHHw==
X-Received: by 2002:a62:1cd6:0:b0:56c:318a:f83b with SMTP id c205-20020a621cd6000000b0056c318af83bmr13854416pfc.13.1671497460036;
        Mon, 19 Dec 2022 16:51:00 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d64-20020a621d43000000b0057682f44f8bsm7231772pfd.220.2022.12.19.16.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 16:50:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Rose via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH] Remove redundant double exclamation points
References: <pull.1401.git.git.1671459163559.gitgitgadget@gmail.com>
        <221219.868rj3za6s.gmgdl@evledraar.gmail.com>
Date:   Tue, 20 Dec 2022 09:50:59 +0900
In-Reply-To: <221219.868rj3za6s.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 19 Dec 2022 16:19:23 +0100")
Message-ID: <xmqqzgbizymk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I think you're therefore introducing a bug here, this may work on your
> platform, but we have no guarantee that it'll work elsewhere.

Thanks, well analysed.

