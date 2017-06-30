Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3D64201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 14:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbdF3OxA (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 10:53:00 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34018 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751710AbdF3Ow6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 10:52:58 -0400
Received: by mail-pf0-f194.google.com with SMTP id c24so2762514pfe.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 07:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AvfLwQHUr7wbgFs8K8I6ZvMcwf2SnOfItWyU3eChs9s=;
        b=I/z9KPGPA/eRlJCF5p0QE2b8DAcBn4+u0lx+jgiKmMqh0s9ormzfYzX7Ir1TefJSBj
         b6xhmorwO3ln7WJfZ7/x+1VSASywbBExHsQBrghvEYzjAos9P2WxQ58HUpQwj3eeVJoO
         1dJa9hwrP21N+BGnbKmCBQXErPQMZRkZ2IA86k3+QPjz5/jlTplKI+NOYogJt/ImnWXu
         b0FLx+pxpZUTANJMd3XhQHn8oVOQs93u/c+49WYRL3gdX/s4dW/grsWra6b/I2MbtkgU
         qGm+Wne0C6BRNWwVFVoVxsRTvdPOxEfdMr6TjO9yu3EcPVhuz9kkrb+2mtSfwJvbRznA
         usaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AvfLwQHUr7wbgFs8K8I6ZvMcwf2SnOfItWyU3eChs9s=;
        b=qXDYJMJ2hlld2s5CAycYfHpM+d0kjG3/EdTmUgQVWxrqXhdjCi06Og3cGCxfJI/h9z
         Q3zLKJ3FsMQR3aQCuCx/fIfGhCHKLClOO97MdcSZ8XU5Ou4BTyefImIcdqUePo8Zfo69
         xHMDWVRJwfKjFWfpuOQ06cXq2cJVUoeNLkEZg4bhOD4OJTeeAi/XL+miTdkQLgtqHkks
         PnAk2GqL3J9HN6qKxgmGCiz7C3WuIEyYb+027HpGiSbZ7dHokbQsl9iwqwcWud5iq1kF
         5rzsm9i8lurJ7NqCSUuY9sprGbNY1FanxetLkua/1UyiZuOPCaa7IAJkLfW6fG1GwMA+
         o3xw==
X-Gm-Message-State: AKS2vOx5TaagpEMaMwQfdg0J3XNjgC7DsykdC2qrv+14DCO1xGR376iH
        L9NE46+zs24OqQ==
X-Received: by 10.98.212.91 with SMTP id u27mr23206531pfl.157.1498834378127;
        Fri, 30 Jun 2017 07:52:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:54f:b41d:dd9d:3de0])
        by smtp.gmail.com with ESMTPSA id b7sm15577484pgr.11.2017.06.30.07.52.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 07:52:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] commit-template: distinguish status information unconditionally
References: <1498792731.2063.5.camel@gmail.com>
        <20170630121221.3327-1-kaarticsivaraam91196@gmail.com>
        <20170630121221.3327-2-kaarticsivaraam91196@gmail.com>
Date:   Fri, 30 Jun 2017 07:52:54 -0700
In-Reply-To: <20170630121221.3327-2-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Fri, 30 Jun 2017 17:42:21 +0530")
Message-ID: <xmqqa84pttmh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, both looks good.  Will queue.
