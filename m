Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DA5320188
	for <e@80x24.org>; Mon,  8 May 2017 02:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbdEHCDB (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 22:03:01 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35042 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbdEHCDA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 22:03:00 -0400
Received: by mail-pg0-f68.google.com with SMTP id i63so8411833pgd.2
        for <git@vger.kernel.org>; Sun, 07 May 2017 19:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=XCBegB3OfCk2VwSYfxlVLn+W2lBEoKWc22POdmh9qJ8=;
        b=C/+YlHO00LTOkyJy3BPjV8nS+TN6O+YujI60sLNfhrF13dW8SJouYdlToI0Mlx38pJ
         faAATEaSKcASgFIhMirMer+8fGl17EA14G6Knc2E8GqJM5Xbetxa8a9PPl10sBhU6XLH
         jV61XAllarUyEETqCrNJ3DG2eGFXKovDp8NVJPyo7wpsiLmGwJD+xitjpI/LMWhAzYwH
         uZFYtCZ9axIvzAEdj34ywiIR2T42olAcg0TGY40MQeF7IyUq8DhV/xo+7y9rPAHb9+/+
         7YLCWmQh+U2NvH0T6sG55NG+SQ6QoF0lmKs9BzDeaGMWLJkMrqyDlVN0iYoqqqPTjptp
         Tzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=XCBegB3OfCk2VwSYfxlVLn+W2lBEoKWc22POdmh9qJ8=;
        b=tfhj/Ux9EMc1kG0s7kBvAUZojb88A9WPV+3RopVgGbW9rsRfj4BBR6mdJJthwoBGxp
         A1Z7AkP4tj3xiJSrEiTGU8pEP7tUIfg+zYXiMLL3RMl3u92ysBHO9svZATNN/MAV0wuO
         x2ZFtaJ9kwcNnpG3fwgBpaR1G+Qcl2wih8ZxwM6RD3T1CT2szb3j7hHTMDTrhzP+pQlk
         wUeVKGi4YPKeUUwYU47ENNC/qlBiRM7km01SWpI2Bv/qbzKuRfG9BygCcJH/Qh7oEzfG
         V4XY0CIN7uXtgCpM2YwB9Gdq1z/8gTAR9vcUJBEeuiZSfgluIUHG0BSxsKBntuhVVFS+
         A2tA==
X-Gm-Message-State: AN3rC/64jqlxCkXiSiu3yogflKD8fxuddM7Pk2ZwxqDzcmRlhDiHYB+L
        6y0Lyq7+beoSrQ==
X-Received: by 10.84.229.75 with SMTP id d11mr78883930pln.66.1494208980022;
        Sun, 07 May 2017 19:03:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3011:642f:81a0:efbd])
        by smtp.gmail.com with ESMTPSA id r131sm16886541pgr.67.2017.05.07.19.02.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 19:02:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Michael J Gruber <git@grubix.eu>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] tests: fix tests broken under GETTEXT_POISON=YesPlease
References: <20170505154053.58128-1-larsxschneider@gmail.com>
        <20170505181932.14317-1-avarab@gmail.com>
Date:   Mon, 08 May 2017 11:02:58 +0900
In-Reply-To: <20170505181932.14317-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 5 May 2017 18:19:32 +0000")
Message-ID: <xmqq8tm8aywd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Junio: I think between Travis now testing for this & the scary i18n
> reflog regression (not that poison caught that, but that was lack of
> testing, poisoining catches that class of issue) it makes sense to
> discard my patch for removing GETTEXT_POISON & queue this up instead.

Let's queue this and then the travis patches on top.  Thanks.
