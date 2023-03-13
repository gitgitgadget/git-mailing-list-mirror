Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A465C61DA4
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 22:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCMWEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 18:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjCMWEr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 18:04:47 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214737F00E
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 15:04:07 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id a2so14561467plm.4
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 15:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678745046;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxD1ew5cXyrTwymjR3HEOf/rCw7cPAoatqMgMsbIk/s=;
        b=htRxoeYTT+B4Za7HBiMTsNtgW8MymtvxfdlRhShLNqFRfewei4tQtz0uNRb1uuDC2X
         M84xQfkw9q15K5I1AGbJBF2Po7Bw2k4SSL+Lo1OqV1jZidZvYze/cXzdDpuJH0+e2Apx
         QeEcK4Hl0t98oulHTwIB0RorHzetbnnJ5aq1/dcnOIb00pxHV/O8rIyZOV9fZlxf/saA
         Y2Vh2ULMy+Qzi1d3iqkm/lmWvMVcdTZm9EuqgV+HZHGHn2Gr+aaG0dr5Ra1N87A4Tzrx
         Q2fvie8QS71EQood9XhuAp2ieuksaxUpCi9g5rQs3INpGDk+BXzhnVDSV/TBr3poXFL4
         vf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678745046;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NxD1ew5cXyrTwymjR3HEOf/rCw7cPAoatqMgMsbIk/s=;
        b=ozp7P3gksJIR82OzJ60OGtVNHqLS24fUTWj9GyVuTmenJlenA8NZF8pic1oboAv/FW
         9bkjCLyf4sg6009mcZYn7LbBB+2jc7D6wAJUA0WFrnpD7iXH/RIKkPoQA57yShX7X1FQ
         2+xIm3Op10q39Sr5eMsB3zvl4WqEC841zG/awzTrNcAosMjIqCOZZRSufHKpjMSoc8bN
         4/anZM+9xy54opBxAIk1cJ9JIpJ89+8VbIo2c6EJuNjP5QFRX0i5cp7CW9KpdGjYjMQE
         tHayyqr208mILN3JipZrWaFf2rUk7Y3D50LVnq163wVZkxX0g4HV/4F21ZZy2+OsrF2T
         pwgg==
X-Gm-Message-State: AO0yUKUt3OzdxnoxREgaweqGrHO+tZ7WrUe6ardZkiMl52By8/gQXAhm
        jji/RxIR3AYFviVDBm+tsWQlEGvj0sw=
X-Google-Smtp-Source: AK7set93jcjs5nf5gaMzraYq8BnQYHR1873JkC1+Sx4vEc9sakKYOM7uvpzl2XEH12nDoZlqJMJK8w==
X-Received: by 2002:a17:90b:3810:b0:237:62f7:3106 with SMTP id mq16-20020a17090b381000b0023762f73106mr37719631pjb.17.1678745046180;
        Mon, 13 Mar 2023 15:04:06 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id e22-20020a17090a119600b0023d386e4806sm7817pja.57.2023.03.13.15.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 15:04:05 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: public-inbox.org/git to be downgraded
References: <20230313215704.M573757@dcvr>
Date:   Mon, 13 Mar 2023 15:04:05 -0700
In-Reply-To: <20230313215704.M573757@dcvr> (Eric Wong's message of "Mon, 13
        Mar 2023 21:57:04 +0000")
Message-ID: <xmqqcz5cs3ze.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> [1] https://80x24.org/lore/ dogfoods for lore.kernel.org and has
>     the git.git coderepo wired up for blob construction if you
>     follow diff hunk header links @ https://80x24.org/lore/git/
>
>     There's more stuff coming to dogfood with coderepo
>     integration, too; but no guarantees it'll stay up since my
>     SSD has a lot of wear on it, already.

Are you taking donations?

Also, is there a plan to add that custom gmane:<number> query to
lore archive?  That is one and only thing I still sometimes go to
public-inbox.org/git

Thanks.
