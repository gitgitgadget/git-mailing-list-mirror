Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 836221F404
	for <e@80x24.org>; Fri,  9 Mar 2018 22:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932712AbeCIW6D (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 17:58:03 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37604 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932405AbeCIW6B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 17:58:01 -0500
Received: by mail-wm0-f68.google.com with SMTP id 139so6558958wmn.2
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 14:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=BqSjwJ/+Jg3V9ZdSfHst7OfE5+Gy18i7zCIF0TDb/hY=;
        b=nqvEtSp6aw5bQR6P4ImlltOMih8xo/rbH/lZ15N5SuvEC+GNB0GVRLo1vPjUDEVSOO
         dlgZPojO6GEocOVGqRghUvY7yx9Cyzc9Xe6ug2UcxKl76J6ohpJ/4Wkespd1Sfm2ZDM3
         MDrhb/YCn5ur9Q0KMzBjh4VWGLAWlV+iuq5R8lUpbs2+R8LrHPjIz3IhxmKqqKpc1Y/c
         4Z6+u4mtDzsdF6v+8E+kHBp1gk1tZPa7S6N9nt+B9AltMF83830JJRPCyftTiGI1Wwea
         l/2WiawgYCXd3BEnnBYEuA+bOyZevQNa1/syxAR+KrqjbQU/nOiY07x8LJfK0AkruNaB
         /X2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=BqSjwJ/+Jg3V9ZdSfHst7OfE5+Gy18i7zCIF0TDb/hY=;
        b=Z+vQo3AsIhYaaYMzAvtZqhnzBH0afzbXhQNwZhbosWIuVVZM0XJ9tggCURoKndtCA3
         BlPwBhLMcbf/fx7xsZAIdhdyJ5Cx52K5hfZpWVFwBDPuOPNHLueCF5QMAchUBIQOGxkL
         r6GSTCOg1wbcNE8rmjjLHwsjaC/1IGQbyK5l+zqNed0mpNQUMiCF1lrDFDtqjW45W9VF
         rH7ycV0Edrf+0PGNTuxuX8TT4sJl5EuYRyfSiL6zKT1DK0rh2360IKQMuMiVydUm55LS
         fcC9ZjkUVuBENrXGZyKP1XR/B/Pqke5rBYKNJj/BU2Gjy4GCQQyGGh/8O2GmVR5XyE67
         KpEA==
X-Gm-Message-State: AElRT7E/dTOoyEDd5X2O+AlCZ9Rjl9Itj000ufxZ9hf282OqmdJ/T7ew
        5licPlh4XkGPZ8SCXOG7JwNIszIj
X-Google-Smtp-Source: AG47ELsolnSWvjYPMUQUqYF1pV9hoiCePd5uwHK+Bn4RY6kPKy/843Uf/iXt7ftZISEuWt9lOQF5Tg==
X-Received: by 10.28.53.6 with SMTP id c6mr333230wma.18.1520636280058;
        Fri, 09 Mar 2018 14:58:00 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a1sm2884406wra.41.2018.03.09.14.57.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Mar 2018 14:57:59 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eddy =?utf-8?Q?Petri=C8=99or?= <eddy.petrisor@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Is context/directory sensitive config possible or even a god idea?
References: <CAK0XTWfraH5B+1VkNPqrquLDWac=hB0dAASYXzZbG7oCb4hkkA@mail.gmail.com>
Date:   Fri, 09 Mar 2018 14:57:59 -0800
In-Reply-To: <CAK0XTWfraH5B+1VkNPqrquLDWac=hB0dAASYXzZbG7oCb4hkkA@mail.gmail.com>
        ("Eddy =?utf-8?Q?Petri=C8=99or=22's?= message of "Sat, 10 Mar 2018 00:33:35
 +0200")
Message-ID: <xmqqfu585020.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eddy Petrișor <eddy.petrisor@gmail.com> writes:

> When I saw he include.path feature ...

Do you mean includeIf.<condition>.path?
