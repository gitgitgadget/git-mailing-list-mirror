Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C78E2082F
	for <e@80x24.org>; Sun, 25 Jun 2017 22:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751376AbdFYWRP (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Jun 2017 18:17:15 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34183 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbdFYWRO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2017 18:17:14 -0400
Received: by mail-pg0-f66.google.com with SMTP id j186so13115732pge.1
        for <git@vger.kernel.org>; Sun, 25 Jun 2017 15:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SA+aC49xhIsBOrc7kdN2U0LLklk4BGFZBw43a7tFP5s=;
        b=b+hyZnAO9cRW3107shxVVweiS6qKEJXCc0ifmkkKpU4i/KkHNRKCqA6cnH8uHnErOD
         HT0DNMFZedn31I1TucAzAARcZ1Q0Owbw8rH89MRmSpsfWX00KRMelg3pzQveO3i0qhmD
         TAVupwEF0O2oRModK8ZHz00W0nNt1f9VLTe2O7653AsgV1gDG6uW2MLoGL0jbv8s2q9I
         7ToFLiOX3tehNC8zif5hrrvt++U60QxZubwPbDkGJqwIxCzDyzp0mdWI73HR9qmvwW9+
         zVErH9J58FnfluWbxKt6orZcjLKvaJuCn+adpvCCkdOxC4B8mPnA4PlsmAZFFp+94kyM
         k8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SA+aC49xhIsBOrc7kdN2U0LLklk4BGFZBw43a7tFP5s=;
        b=mCv75dvNNpYS4BXEN2Jg75GWBtHkd4XzhjjkzikTfaQN6oNnvZ0MEC7Z+u920TldMG
         uBDcWHsOc/GQ49hVwbdWXAdAEsYgAKcf7kZ0khcurtvy8CpZeWamY/Jck1CRtzX5s6bt
         K6zPGzMSeGcWpdfJM7p4zJEKkFAPrEZDQZyEiFiIg3Y+RE51JVyd0tSl4NckYMXcmUJz
         Mpsh/8PKSRyEpS8HBRgUG3LfinUnqRPdF1lTLkc5zBYQk25je48KxLy9vBMN7nAWzfPi
         9infbzHcI8t3B7HtU/4omBZAtz0AfVjnS4suUiH9qjc46NQECrqrEvePltYaweyHa9Pe
         U5mQ==
X-Gm-Message-State: AKS2vOxSCzCX2MTkr4MiizpKFT1SNbwIhXClIwL1lOumXded8fBs8tYA
        n7GYeUOajdGnpw==
X-Received: by 10.98.139.11 with SMTP id j11mr18833826pfe.18.1498429033982;
        Sun, 25 Jun 2017 15:17:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:644d:1257:a024:dc49])
        by smtp.gmail.com with ESMTPSA id u2sm24094708pgn.28.2017.06.25.15.17.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 25 Jun 2017 15:17:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: Re: [PATCH v6 3/6] t0021: write "OUT" only on success
References: <20170625182125.6741-1-larsxschneider@gmail.com>
        <20170625182125.6741-4-larsxschneider@gmail.com>
Date:   Sun, 25 Jun 2017 15:17:12 -0700
In-Reply-To: <20170625182125.6741-4-larsxschneider@gmail.com> (Lars
        Schneider's message of "Sun, 25 Jun 2017 20:21:22 +0200")
Message-ID: <xmqqlgof7lw7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> "rot13-filter.pl" used to write "OUT <size>" to the debug log even in case of
> an abort or error. Fix this by writing "OUT <size>" to the debug log only in
> the successful case if output is actually written.

Again, use of "Fix this" without clarifying what the problem is.  Is
this change needed because the size may not be known when the new
filter protocol is in use, or something?



`
