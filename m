Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93400207BC
	for <e@80x24.org>; Wed, 19 Apr 2017 01:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933088AbdDSBf4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 21:35:56 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35990 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933085AbdDSBfz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 21:35:55 -0400
Received: by mail-pg0-f68.google.com with SMTP id 34so1606529pgx.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 18:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=98pxlq0VsADEEGAvelOuoA38ZSRyS7AYhcxOAs/VvdY=;
        b=SCUF89sJDoFMm5umBoli3o6aOBE15HcgXIx89DFjaqN5UQ33kdu3FLwR+LFU+Y3oPW
         yn4gdAwLA8tNX1/L8kGvi3+ZEiHtuVOJd/ySVlTWZHmlx7sCvIGpCb14Ed9j6xGnhHl8
         odrux8cYRqKAoEKecVi/iWZ7HGRpXOijah1eIkqfZUp7wULmQXlFW3wtuEKSAwbb8LrU
         /c2lBhcDWgTTCveVxKkENzT5pLKa4yrFmhZ//v055mwWZqFNtJ7KR318F6vbuhYRfaBV
         v3HSARkUQwNjs/PNfBAnzD8PJJZoNUUyPnY208L7XB/+aEuRQ7ezgBtyz+ppQRGnAvmZ
         z1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=98pxlq0VsADEEGAvelOuoA38ZSRyS7AYhcxOAs/VvdY=;
        b=ItxU/VHJhCohFjAx78csDERRjdUuUXI8ufXifPTR1BdmcRN9jHBIiuR9JiVhriLz3E
         twZYyd2QdnryT6W7ZmP28LhM2QY4RqfnBbzMhrfV0VC3scn0wbLgbVBFtD4ylLQLVU51
         RI4QDS00CDcxfL7K2ZNOPvZw96C+r7xrgKnotpD6Cgsnoz43B0M7V2BgT1ackTTHyxs9
         /HlBRpXsX2RCHucoHIQUbF8j5vOR7genbp9zTYxLgqosrUpbovJaiBCJBv7F3jpmqYAD
         DiPog4SbUE8xQOsLMPAPZDaAYCUeFefkpxAdk2W5qGI/CTi7k47AbgzJLmDKtQTfV+ax
         XdAw==
X-Gm-Message-State: AN3rC/5L/EAC7qM7KG2WkRr71apwrjXsiwG/iW8Iej+wqR0nzeh1c88y
        ATtZShc8lmAS8NVwHzI=
X-Received: by 10.84.151.70 with SMTP id i64mr510421pli.151.1492565754542;
        Tue, 18 Apr 2017 18:35:54 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:b1:d67a:b688:bae6])
        by smtp.gmail.com with ESMTPSA id 129sm752028pgj.23.2017.04.18.18.35.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Apr 2017 18:35:54 -0700 (PDT)
Date:   Tue, 18 Apr 2017 18:35:52 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, l.s.r@web.de
Subject: Re: [PATCH v3 2/2] xgethostname: handle long hostnames
Message-ID: <20170419013552.GB28740@aiede.svl.corp.google.com>
References: <20170418215743.18406-1-dturner@twosigma.com>
 <20170418215743.18406-3-dturner@twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170418215743.18406-3-dturner@twosigma.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

David Turner wrote:

> If the full hostname doesn't fit in the buffer supplied to
> gethostname, POSIX does not specify whether the buffer will be
> null-terminated, so to be safe, we should do it ourselves.  Introduce
> new function, xgethostname, which ensures that there is always a \0
> at the end of the buffer.

I think we should detect the error instead of truncating the hostname.
That (on top of your patch) would look like the following.

Thoughts?
Jonathan

diff --git i/wrapper.c w/wrapper.c
index d837417709..e218bd3bef 100644
--- i/wrapper.c
+++ w/wrapper.c
@@ -660,11 +660,13 @@ int xgethostname(char *buf, size_t len)
 {
 	/*
 	 * If the full hostname doesn't fit in buf, POSIX does not
-	 * specify whether the buffer will be null-terminated, so to
-	 * be safe, do it ourselves.
+	 * guarantee that an error will be returned. Check for ourselves
+	 * to be safe.
 	 */
 	int ret = gethostname(buf, len);
-	if (!ret)
-		buf[len - 1] = 0;
+	if (!ret && !memchr(buf, 0, len)) {
+		errno = ENAMETOOLONG;
+		return -1;
+	}
 	return ret;
 }
