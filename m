Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 346041F516
	for <e@80x24.org>; Fri, 22 Jun 2018 17:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932819AbeFVRM3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 13:12:29 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:33360 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754335AbeFVRM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 13:12:28 -0400
Received: by mail-qt0-f201.google.com with SMTP id o68-v6so5860121qte.0
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 10:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=yp27lHsoGbPw65DN+4WdkIrHAtsbpW68QvXn9ohwYdo=;
        b=iSyxAn/bh/hNfjDj6cs8sEOSA54FA0hWBdPajwWDnBhZHdoSW9b8S+ZfZdPizzUzg+
         UB6ubOOdIdWtyQ1S+JPsDpNMbS4Nk+8FfNqu1fbtWqY6d4V8+VAbeyeKyS5ZS2MSvYsj
         w7N83b8Inm2AS/sPJJSmWVNv2PUbyPnG/IuBGq+VpZAaRxipq775vh9fFxwNmlM+LAu8
         0HEJr2P02ysimiSRC3VgnatuAFzOdGnCNFXGMukrDp3kcrsOyiPslXbOVgCdE5yXVHxP
         VZahjMxvy7wPy0zkFuGxeAzEoIXPhaEPNMHkCfBDZcUyHoEy3dKX45+wd7VWT18aCHMy
         4dkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=yp27lHsoGbPw65DN+4WdkIrHAtsbpW68QvXn9ohwYdo=;
        b=ppI/8UhgtWg59XesJ4c/eGgX4WN1B2iQpvKfzcZXQvo6QF5O4JjLjBoeKxBwEACCco
         xz6S8tkU9UbDOdXf0mKQIk5/cRPiWYiDdQ5anp70Wbkiyah0591L7YSoY5hOIloh+VZG
         aj/Ur9nL70q98UMmjh2YkoqxS1gP4ydPKR0rGLCVUsyS3f0UE6qN6pnH/U0S7fStpwWH
         2USBhgv9IJcEgepARv0sj8bR+VEcn3/bc1+VGA23SEDrWs3V4lWGwvE2FUSKwSRm2HAO
         huleikvPLaZc9S+xFjbIJinfleic1XXrtaBtITVnsQ1SHF0bNdByFzY+XCq02YpiCrIW
         HFwA==
X-Gm-Message-State: APt69E39ArhfSJAXDi4z2thBmWfT/TVrqUpTRwuqGBLDKVBeDzZnHyP1
        KJl48Rd1DtKQMIem2tbP8Q5YvXPTXDSzdN0wX+PQ
X-Google-Smtp-Source: AAOMgpfwJIrjeqltLDknZ0RJRrqrIK1HrMVSnzuynYMt84cPWkRfZYNrZVgQ1SRR1PZd5jPsy9BdFAIUOHZYRxFGhuj8
MIME-Version: 1.0
X-Received: by 2002:a0c:fa91:: with SMTP id o17-v6mr1303187qvn.20.1529687547611;
 Fri, 22 Jun 2018 10:12:27 -0700 (PDT)
Date:   Fri, 22 Jun 2018 10:12:23 -0700
In-Reply-To: <4e7600f1-6dd0-3b21-5f5d-26af2b3c0b1a@gmail.com>
Message-Id: <20180622171223.261859-1-jonathantanmy@google.com>
References: <4e7600f1-6dd0-3b21-5f5d-26af2b3c0b1a@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.347.g0da03f3a46.dirty
Subject: Re: The state of the object store series
From:   Jonathan Tan <jonathantanmy@google.com>
To:     stolee@gmail.com
Cc:     sbeller@google.com, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I'm waiting for sb/object-store-lookup to be in 'next' before I re-roll 
> that branch. If you're not in a rush to send this series, perhaps wait 
> for the next version here.

Did you mean another branch? I'm looking at
https://github.com/gitster/git right now, and I see
sb/object-store{,-alloc,-grafts,-replace} but not
sb/object-store-lookup.

(I'm asking this because I'm trying to wrap my head around the
interconnectedness of all our patches.)
