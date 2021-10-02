Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F9DC433F5
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 21:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 972D961247
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 21:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbhJBVfG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 17:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbhJBVfF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 17:35:05 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0F8C061714
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 14:33:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v18so47475041edc.11
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 14:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wot/qJK/VbkFYgea46684B06rZ8/8kRLCUri0L7G1U0=;
        b=J3gP+7/kT5/F/Dhpo0m7/43SGcN6IH8cCaORjRl4Q/hGwSCpIfji94XYRjPhrttf9V
         MOV/dhYmFWbfPEtgLUxibNO1eS/1JHwRj4AONnLEUlQ9HC1jYLAyNvSH1xbzkjyPWL/D
         vTpTVgYh9P6KIjq6cxfdYq4bQkpyAe+Efhh9A4kFtHUoK3Fyk6A0fxO1/QVSme/JZHm9
         g6s+GxvReOnlkrFHqvA35+v+eEac2HJhTgoH0+IiJGg4njkTQ9UG89k6A7341Nv5/RdT
         qzbEpat2LIrHu14IjlMu4D6yAAN279+FyDYLvRJxy1wUkDy2rKShzHFHgWQ2IwAPo5hK
         Mejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wot/qJK/VbkFYgea46684B06rZ8/8kRLCUri0L7G1U0=;
        b=K+vw2gHYUN5lRF9PbgxowTcnomO3pQbyMIXrdm1EaV6f8CjFh3HI4RmwIL9UK4HcjH
         wmI+mN0NmMYu9xu1nJfd7rSxidQXHUVd9RYepBduhQho1yXImOhJsJ+vVFzvZWMri1wC
         6qza2s6JciM52saHDUYSRBRdSV7+HF/3+VCN3RJfzjLzZpOZm1YoJyux4FBdsX1kPsek
         X4k25ZPGhZii+mKuARAin7oC3vMMCoDtN1NacmIRLUoElh7eZMa8F022Vr6f+QaXipwC
         E6q/dSLh4DDgm0hrDWpVbY5D6bEZ//Gbp7RlC1U39sHyPF+jDvkJz2qYnxR0fQMhSHMy
         fNvw==
X-Gm-Message-State: AOAM531C89TCuVMkKm224s4+LW9vUTzzaPBZE4fz/HRtOkBQCZRNvIki
        Z5fd8REHtOsIlr7ayIUkLeZ0ay2an/4=
X-Google-Smtp-Source: ABdhPJy8YxpuvlBFV+k0wxdEUVeT0tR2kxvniWdZIrop0a0Nh4iuE36qvIvmrIPKao6HY2Z7LT9tsQ==
X-Received: by 2002:a17:906:5282:: with SMTP id c2mr6706854ejm.162.1633210397461;
        Sat, 02 Oct 2021 14:33:17 -0700 (PDT)
Received: from gmail.com (77.119.208.5.wireless.dyn.drei.com. [77.119.208.5])
        by smtp.gmail.com with ESMTPSA id o4sm2561418edq.38.2021.10.02.14.33.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 14:33:17 -0700 (PDT)
Date:   Sat, 2 Oct 2021 23:33:14 +0200
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation/git-status: document porcelain status
 T (typechange)
Message-ID: <20211002213314.kvc27qsbi7q42n6s@gmail.com>
References: <20211002213046.725892-1-aclopte@gmail.com>
 <20211002213046.725892-2-aclopte@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211002213046.725892-2-aclopte@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In case anyone is curious and lazy, here is a script that generates all
possible status letters containing T:

#!/bin/sh

set -e

_T() {
	touch file-1.T
	git add file-1.T
	git commit -q -m add
	rm file-1.T
	ln -s /dev/null file-1.T
}

MT() {
	touch file-1MT
	git add file-1MT
	git commit -q -m add
	echo modify > file-1MT
	git add file-1MT
	ln -sf /dev/null file-1MT
}

TM() {
	ln -sf /dev/null file-1TM
	git add file-1TM
	git commit -q -m add
	rm file-1TM
	touch file-1TM
	git add file-1TM
	echo modify > file-1TM
}

TT() {
	touch file-1TT
	git add file-1TT
	git commit -q -m add
	ln -sf /dev/null file-1TT
	git add file-1TT
	rm file-1TT
	touch file-1TT
}

TD() {
	touch file-1TD
	git add file-1TD
	git commit -q -m add
	ln -sf /dev/null file-1TD
	git add file-1TD
	rm file-1TD
}

AT() {
	touch file-1AT
	git add file-1AT
	git commit -q -m add
	ln -sf /dev/null file-1AT
}

RT() {
	touch file-2RT
	git add file-2RT
	git commit -q -m add
	git mv file-2RT new-file-2RT
	ln -sf /dev/null new-file-2RT
}

T_() {
	touch file-1T.
	git add file-1T.
	git commit -q -m add
	ln -sf /dev/null file-1T.
	git add file-1T.
}

cd "$(mktemp -d)"
git init -q
git commit -q --allow-empty -m initial\ commit

for state in _T MT TM TT TD AT RT T_
do
	git reset -q --hard :/initial.commit
	"$state"
	git status --porcelain=2
done
