Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D4FC54EAA
	for <git@archiver.kernel.org>; Mon, 30 Jan 2023 23:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjA3X1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Jan 2023 18:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjA3X1I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2023 18:27:08 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFC9AD04
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 15:27:07 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id p24so13294172plw.11
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 15:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=beTUphaZ6jUKZbRWx62oWO1TfX74ri+OYVrafA2k67o=;
        b=JgbhKLzNV4arU4se4cuwjgCFV4jVWaENF2jqCbNAOAU38SzUQEQFiuyKX+16Sr11dV
         PQIY417CTGtqUZWxXvODGxSCqW81t6Z8K+cZwIxTbFww1itvJjSVOEyfm/MQPEf+bq7C
         /R90WqCBWvNORog2ktlAMW7406piRKiduKe+xs9kZ4476fxDtDovFtTyF+fCZt+wAi2B
         TtegXkiqb3XJP0AEqGL8sF5fvw8XidwDP1XU80FUe1y+6ttlGlmGdLZHrzJ6croOTcbJ
         SjFFZ+WxD1miQKcUI7KTZrI56E9CIbJ2k+abVHjxf90t9a2nHF9Dqdf2Q0XadcDlpS8+
         3ojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beTUphaZ6jUKZbRWx62oWO1TfX74ri+OYVrafA2k67o=;
        b=MNMjRRckt2EGVu4/qhtnd45YWtf9gYs7uF6WGLJyAFz2ILPI/pAgADJydaK/eYGaO+
         Lh1xjoAtLEH/BT398LjyOQ6L+aFklYNRZNn+23OIV6i/zAefz9gyKBof81VBT+1X80K2
         dVTey0xjAQtDTKf6sV/wOGD30xvVTaSgoCyIua6mvgBDit90x1jYAg+P6aCVI3qHD+az
         D6kkwhcHUl94pN3G+FUuPAluTPjO/4zXZsDcNMlByTJm900dlIpCXQmaYMgMIJgd7sJf
         JLG3eFuLmUcKbhB9Fge9hWfxetBW+Q9PwoE+Q7nNW2GPz5mPAeqJPNMlpKEl9cE3TvtI
         z5YA==
X-Gm-Message-State: AO0yUKWDoALoHMRczPiI2AsiGH5KrasaC+nqs9PNfqI71S3U6RGT5UUc
        j4OmZu5rOkzCXXoZYrQvxh2upkxjTtE=
X-Google-Smtp-Source: AK7set/+h8AX5oc9Lp+zADQE0/2vdzdpCWudiz308xIyYCpy2uznk9wtrpgNFXZdb/mHWHWKjGwtwQ==
X-Received: by 2002:a17:903:2445:b0:196:5b76:8e6e with SMTP id l5-20020a170903244500b001965b768e6emr16782758pls.1.1675121226904;
        Mon, 30 Jan 2023 15:27:06 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902d48500b00190c6518e30sm8264083plg.243.2023.01.30.15.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 15:27:06 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2023, #07; Mon, 30)
References: <xmqqedrb1uvy.fsf@gitster.g>
Date:   Mon, 30 Jan 2023 15:27:06 -0800
In-Reply-To: <xmqqedrb1uvy.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        30 Jan 2023 15:10:25 -0800")
Message-ID: <xmqqa61z1u45.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Subject: Re: What's cooking in git.git (Jan 2023, #07; Mon, 30)

Sorry, but this is the 8th issue of the month, not the 7th.
