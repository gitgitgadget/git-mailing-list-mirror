Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 340F51F461
	for <e@80x24.org>; Wed,  4 Sep 2019 11:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbfIDLJr (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 07:09:47 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:33166 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfIDLJq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 07:09:46 -0400
Received: by mail-pl1-f171.google.com with SMTP id t11so3339412plo.0
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 04:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LXMkwj3WXhrSi4gRQDxybbNuMjTaisCqmVYhyh+A/iU=;
        b=WFbsgMrfFBFg7hBSIBAlFam2hghVis2WLqlp1P6slx9gIcjw01cwPrH6v9ZTZ6a9tI
         YD5njB2rGnlwArPuJf++NHsKd8D8gpKbD/FGm10ldQEt+deo6rYkAy+jvz9sa0Z79m+l
         LyPVPBBuBqrVvIu0FplWZ1vuRh2GQH3B09yxrm7kt/KYcgRMbrwFaRe9gr1XSgeLJ8qf
         UFtEC8B6Sk7Cstpz/gdM6UJxE6w+uWyY4QNCaBoAYcWzZhCeB12Y2Ce3Iqk6Tt1SVyxA
         Aoh7aWik2ijQJXk38cS1mUxOU3f7jNV+TDDmMJUDprSbA7ZSmxlA+bVo2BLPrONOzsLh
         zUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LXMkwj3WXhrSi4gRQDxybbNuMjTaisCqmVYhyh+A/iU=;
        b=FoUo8BqSww3VOFPucTgSaYXImrhOwYm+sSuGaOkF13zsZ90lyMBrWYIYtcBVohrky0
         HCqQi/ocMBXUN3XmbGulWqsLWJKyUFw9Dr0zh425cBfrHLGr/k2n5YunfYkJnW5pB9hV
         S/QgIbNL3bhOeDw6IAJpnCuFPxfvBd35a+LAGHYarsNvAacn2gIfm1WRza8FM8fdU7XJ
         Vcsti/AQuyXoVO2qOoRNB/SmwDG2UpMgTlyLlaoQypX1D+RS23VxREcQdGzH661usS6K
         lt2PEkdCGISoGC0bvCckSex/VUo/Nq9/cBx3vYQzYx91kQQMr3MF216wY1reU7jk8HFJ
         7aYg==
X-Gm-Message-State: APjAAAWIbpGY+VstSl0CWDc2625uWVO84xbW0ZiiTzBnLsLgIY+AxqWa
        i7kFboh/LgfGiyNmoWtMqDcIeI5oExg=
X-Google-Smtp-Source: APXvYqzlg0t0QEknAbd14CGDBdn61XmQ2hmu7GnJuWgtMSWA3z3ic2nH1m+YmSCxwBoJbWUNimtJ2g==
X-Received: by 2002:a17:902:9895:: with SMTP id s21mr39691922plp.255.1567595385742;
        Wed, 04 Sep 2019 04:09:45 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:646:280:1b30::6486])
        by smtp.gmail.com with ESMTPSA id c1sm24775440pfd.117.2019.09.04.04.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 04:09:44 -0700 (PDT)
Date:   Wed, 4 Sep 2019 04:09:42 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/2] cleanup compat/ sources using spatch
Message-ID: <cover.1567595331.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sources under compat/ were excluded from cleanup using spatch since some
of them were taken from an upstream and we didn't want to modify them so
that merging in future updates would be simpler. However, most of the
files in compat/ were created by us so it should be safe to apply
cleanup to those files.


Denton Liu (2):
  mingw: apply array.cocci rule
  compat/*.[ch]: remove extern from function declarations using spatch

 compat/mingw.c         | 4 ++--
 compat/mingw.h         | 6 +++---
 compat/win32/pthread.h | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.23.0.248.g3a9dd8fb08

