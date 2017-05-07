Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF3D11F71C
	for <e@80x24.org>; Sun,  7 May 2017 22:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754427AbdEGWfA (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 18:35:00 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36389 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752548AbdEGWe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 18:34:59 -0400
Received: by mail-pg0-f65.google.com with SMTP id 64so370026pgb.3
        for <git@vger.kernel.org>; Sun, 07 May 2017 15:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LL1HsmbdXk4KeEI6voBB9jg+wZCEHHydL4bskOxj3FQ=;
        b=LEBWt3L4yQH6/eRBsY6GZzcmaX00B4b3kFYw6lvwygvxQAe/57rB0g7enhaBuFuptr
         6kbUOqtFSeOtLJ+SSihzugiohfvv2y371tCyhz1T3RnQbZp14xG33ualnGqqw3uX/bRO
         6QRrduL//qqc1IiCLLeDEUy4O9LgEtaQxEAhtxvM5DkTWcbHpCFxHGWQqMeaCNa2Sbri
         GkxJAk/Jt6ntgGS8baUmwbAGJyiuEfa3RMg5wGSiIiYvaxycFpfLNN3Kj1D2+2FX+GxY
         mzFzxNFx2qXBDcJr4cHPxDpRAs11aIRFt8QD/BeyotFjrlMiYUpQblklWhBTm4ClbRbU
         rGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LL1HsmbdXk4KeEI6voBB9jg+wZCEHHydL4bskOxj3FQ=;
        b=MjSvOsORLYKabsfi54oOe2Antv+6uSAl9tkcYAiaz8Ir5GdPe+SMRJahogo9tsEypk
         OGt4MsbMbdZCK0rhYqyJZ+80jFffMpXGL3X3D5u+Yxxc2zKYOwukWmEa0QW91fPMozqS
         oU2n+A9ewlasTzPm7zyacyfnxLAvOOpxk4QenxCa1qSLkewVgdE9tvTz4oQCoVVyjBhZ
         7p2HHq9lyHOOLNfqh0NAaFMTfaN6Xl9B+Uf3mbi7rvrUH9hDr2jbq8n+Rk+Cyqz5FVcS
         DHKPdEelxDw4NsHu9Zci2Uo4NBG/N7qKxzkMbEunesXrVmSHrgyEPkHR/QOtNVpMtzkA
         hzAQ==
X-Gm-Message-State: AN3rC/7iC4ORoRTp1dY7b/qRA0kY4Ie+hq6ckeEU7nYRoqHNwOiqaBU1
        pKAyrtaZgopf9FjUQTE=
X-Received: by 10.99.188.2 with SMTP id q2mr12301251pge.72.1494134979167;
        Sat, 06 May 2017 22:29:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3011:642f:81a0:efbd])
        by smtp.gmail.com with ESMTPSA id h15sm8394104pfk.120.2017.05.06.22.29.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 06 May 2017 22:29:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] Abide by our own rules regarding line endings
References: <cover.1493728172.git.johannes.schindelin@gmx.de>
        <xmqqpofp9p1r.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1705041129170.4905@virtualbox>
        <xmqq60hgacjp.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1705042038150.4905@virtualbox>
Date:   Sun, 07 May 2017 14:29:37 +0900
In-Reply-To: <alpine.DEB.2.21.1.1705042038150.4905@virtualbox> (Johannes
        Schindelin's message of "Thu, 4 May 2017 20:48:10 +0200 (CEST)")
Message-ID: <xmqqd1bldyke.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Let me repeat myself:

Don't. Instead, read through what you are responding to the end
before start typing a byte.  In case you didn't do that, in the end
I agree with the direction of the series ;-).
