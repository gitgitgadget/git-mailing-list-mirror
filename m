Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B025201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 21:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753119AbdF3V7S (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 17:59:18 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33569 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753012AbdF3V7R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 17:59:17 -0400
Received: by mail-pf0-f174.google.com with SMTP id e7so73083827pfk.0
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 14:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6JL52FIqaBanp9b3HI7W3ugIA8W+O6cQ/FQJIdQIGG4=;
        b=lxUj0Tq6rHIdBD33V4O2zCDImwm/ReCVqqFd849xx6rc6T5pAy66khrDzs82a1grlS
         lTTpBwD/MAKX2+EEtnBBRLmMSDe7mm68zy8vCbNnqRpEC3Vm8HSyIZNekiem28M1dNAm
         80lOZleWzZoj4ednN9WQAeCdzaPhSw1PZaFNitiVgd8s1DOBg8WLgvAuSPbUnFWXhybC
         tm077vO5/8Kd5Kdyro9iw9HDd6dmJEJDTzws9MmCTgtWisyvfk+hiT4I5KKNUgOdvEmJ
         yICkVynhb1n6QaBCQeWgu/VU/Qx0pLtuf2HJGNVllV1wHfgQFmhVxKq3ufNgs0F1lYbI
         R6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6JL52FIqaBanp9b3HI7W3ugIA8W+O6cQ/FQJIdQIGG4=;
        b=QhVKgNxVm3I51IuGWjAR9emtmmywsOd62+wpUeGiJAww2qkxFcMxxjwvafs3sKClqQ
         BQwhWtPrJupWaXNRsj6cICGukiL1wUeonB56xrgYwOLPodaGfVvPdhTkBFGBkwpWzOtt
         xicRS8niYIfMZ4uC29bYBYmPFPRyzFC3PV04cZ9yq4DgeO7RcULLnCRL3LtnfCseeoK9
         OdYpcoKqTdzFCWXJXbPZEIllFeG+GRXSmnsAHnBiJcvIrMGGzorKpiVBR6zNWsZsB7BN
         RFTLQGAJdAebSVKrTjyODveIBxkVpqaIWJGnkdk9wBxTyAFiufI4Ybx88uKr81QnsGjm
         OxOA==
X-Gm-Message-State: AKS2vOydq99Qm/rp2z2SK9hf8JAercjJAS+7DID1R+UVYE9VGZhMX+vk
        XCL/tsentmzmPjXODAmSfw==
X-Received: by 10.98.135.140 with SMTP id i134mr24227804pfe.237.1498859956784;
        Fri, 30 Jun 2017 14:59:16 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:381d:de0c:a296:77d9])
        by smtp.gmail.com with ESMTPSA id q29sm10239319pfg.11.2017.06.30.14.59.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 14:59:16 -0700 (PDT)
Date:   Fri, 30 Jun 2017 14:59:12 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Noel Grandin <noel@peralex.com>
Cc:     git@vger.kernel.org
Subject: Re: speeding up git pull from a busy gerrit instance over a slow
 link?
Message-ID: <20170630145912.1047890d@twelve2.svl.corp.google.com>
In-Reply-To: <19ee7852-efcc-66d0-24ad-3462a4d5eaf6@peralex.com>
References: <19ee7852-efcc-66d0-24ad-3462a4d5eaf6@peralex.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 30 Jun 2017 14:28:15 +0200
Noel Grandin <noel@peralex.com> wrote:

> ---------------------
> snippet of packet trace
> -------------------
> 
> 14:20:45.705091 pkt-line.c:80           packet:        fetch< c5b026801c729ab37e2af6a610f31ca2e28b51fe 
> refs/changes/99/29099/2
> 14:20:45.705093 pkt-line.c:80           packet:        fetch< 931e2c40aeb4cf4591ae9fcfea1b352b966f0a32 
> refs/changes/99/29199/1

Out of curiosity, what is the timestamp difference between the first and
last GIT_TRACE_PACKET log message containing "refs/changes"?

This is an issue for the Android repository too (which also uses
Gerrit). I have some work in progress to avoid the extra refs from being
sent [1], but haven't been working on it recently.

[1] https://public-inbox.org/git/cover.1491851452.git.jonathantanmy@google.com/
