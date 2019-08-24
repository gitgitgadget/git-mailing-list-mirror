Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2620B1F461
	for <e@80x24.org>; Sat, 24 Aug 2019 09:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfHXJEu (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 05:04:50 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39646 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfHXJEu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 05:04:50 -0400
Received: by mail-io1-f65.google.com with SMTP id l7so25797963ioj.6
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 02:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=vzDLrI/HM6Ds3kTdCmyiVW9XfWTZi/hCTSaxoIHTov8=;
        b=RnuZIdDQg5yi9PV3+/PLgDv4j5YsTITDfXeH/GAyrNtX8p7N/fqYVX2lWsL+43isKn
         pN+TERq0vHu/j7LWAwp4WmW7WBpONvc/DfA7kaSJsQgfdO4I8OAZgvQwR5uXusepoWXX
         pLRn+3U3656MuxtM/kqT1ITpD9I1sF+L3GKKoFAbNVdkPL4EW21Na7RIHra4iSKBBOmQ
         byYOPoARpcb+W93tmUDy424agiNjp1ezfX62CWt94ZjMSxshnTEdYDayMyC4YW92vjCO
         yXFAZqZkaIoXStqKUQRj0M3HmGcw47cXd3QOicALGkIzPYl9cMXQiSyFIXJVXDG+xeOr
         Zxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vzDLrI/HM6Ds3kTdCmyiVW9XfWTZi/hCTSaxoIHTov8=;
        b=f4CbOY/g1N6OCnuj+1thAvAGAdnAGGO81Y8OceGsHOrS7ExB8T+4QTtpdbk9hsp02t
         u5DEHiKHhPIDLequhc+AjySr05/jUd8cK8Q9oFyzgFF/p+U/HlNytO7suA2eOSpXmf4m
         SyezeO6iFpzN0KTUUQuTkDHobduXI7rL1QfXTG5lpO4czFzjEkTHcwRvQSAyp8KAa1kF
         ylVjBLnZ3BnT2/X49H0dYucmZWnjgopr3l8jMP2HGw6ObrS9BIR/m2YAQbvp38TFNwVO
         GCDCNEE84tI7rDgtdzvsIKJ4qsM4OjkvIhROsa9sw5f2yH2zy5wgcmPuh32wX9PItbUI
         4uxw==
X-Gm-Message-State: APjAAAW0jDz3y/4nT6q+RGbKB014T0ZyoNRZWj1TjClm2muwPKyJ9VNu
        GbZAXubiKsrVRtNg4Rd7YkE/H1hC
X-Google-Smtp-Source: APXvYqyymjAaco0jqtPJYAL1pbL5aaCorFKE8qZE3ADAhShn1PlLvggulaCdw271NwQ/qhZUhoupWQ==
X-Received: by 2002:a02:b713:: with SMTP id g19mr8944638jam.77.1566637488922;
        Sat, 24 Aug 2019 02:04:48 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id i10sm650887ioq.51.2019.08.24.02.04.47
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 02:04:48 -0700 (PDT)
Date:   Sat, 24 Aug 2019 05:04:46 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/2] completion: complete --skip for cherry-pick and revert
Message-ID: <cover.1566637431.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, the completion script would not complete `--skip` for
cherry-pick and revert, even though it is a valid option while that
operation is in progress. Add that missing completion.


Denton Liu (2):
  completion: merge options for cherry-pick and revert
  completion: add --skip for cherry-pick and revert

 contrib/completion/git-completion.bash | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

-- 
2.23.0.248.g3a9dd8fb08

