Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA75520373
	for <e@80x24.org>; Tue, 14 Mar 2017 00:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753594AbdCNAo1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 20:44:27 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33320 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752140AbdCNAoY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 20:44:24 -0400
Received: by mail-pg0-f43.google.com with SMTP id 25so73948590pgy.0
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 17:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pMx7Pq2TDGyT+I8yu+VWadIaTLp+ahW97zr49enyrDc=;
        b=YFnmBWsBNpOKCPsvvbXyviwLQQ0dbyM8NCHN6Y1+prMBGb0v9uhdgKF6Io7TuwWdFP
         zNz8OXME1e7YE0R/bXjTeAbO1w8G1SUlN84f+6xeqRHxLo1jYBHli9f3QNgbST1KNsl4
         qz6slhG+cuS4jbMtwMj4df4p3xkS0p1bXMywN09XJcXP+HeTYI5Wo9zJChvq2YBS7Jrv
         MdaQz0u4AbVf06cEIdxDJQy8+Uv8xuweBW7xpwyxldbj18V+cYluNKgqIxRwB4CQgeJl
         FK3eF8VlP2JvXiMV/zCYyWFjKTU6i5JOPcMc/rqfJRwGQEdSvCAwPVkRcgoLs2ftFcVk
         BO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pMx7Pq2TDGyT+I8yu+VWadIaTLp+ahW97zr49enyrDc=;
        b=UbsKKTA4iFwJPO/BnardayghtD/Yr2i98otE6mcsLwLp6j+Du65ImX/vJEdJVEdQUf
         s3OEtTYPN8cKZgoar/gCZlKm3cHgKZbZ/GhTgmcyNEOPsOS8ldxg3qXYPtBePCgXTdT4
         qkKFRFrCgjh+MOIr3xAhGQjlNtC8sOpbb9662Ozidpwu54iynLk2tnG7DwWRxxnjeN10
         cKHWQ7wwR46povD1ss+m2031G7J3/rbtgMognlu33IuhGILlQI/52BgN4jDPvud+tXA3
         bZjqgHUAtu2suaQK4WcI09Cq6VTQ+mOqOitbFFLgWQltpvIKTOXB1Xt6QZnTM70kmUTe
         Lw5g==
X-Gm-Message-State: AMke39ldH2F4pCU6TSwc9sYEMF0RKf+VzMoNa/TUiJf3aVwfGG3MmCOFR1aFR8yRwESYWvyo
X-Received: by 10.84.224.3 with SMTP id r3mr51173708plj.6.1489452262588;
        Mon, 13 Mar 2017 17:44:22 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:ac5e:90c6:a609:7ab8])
        by smtp.gmail.com with ESMTPSA id u69sm34667408pfg.121.2017.03.13.17.44.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 17:44:21 -0700 (PDT)
Date:   Mon, 13 Mar 2017 17:44:20 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Devin Lehmacher <lehmacdj@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [GSoC][PATCH/RFC v3 3/3] credential-cache: only use user_socket
 if a socket
Message-ID: <20170314004420.GC66601@google.com>
References: <xmqqa88orgjd.fsf@gitster.mtv.corp.google.com>
 <20170314003246.71586-1-lehmacdj@gmail.com>
 <20170314003246.71586-4-lehmacdj@gmail.com>
 <2ACF39EA-B76A-462E-993C-ACBB143A1581@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ACF39EA-B76A-462E-993C-ACBB143A1581@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/13, Devin Lehmacher wrote:
> > +static int is_socket(char *path) {
> > +	struct stat sb;
> > +	int ret = lstat(path, &sb);
> > +	return ret && S_IFSOCK(sb.st_mode);
> > +}
> 
> This patch won’t even compile. S_IFSOCK(sb.st_mode) should have been S_IFSOCK & sb.st_mode.
> 
> (I guess I should have compiled first)
> 
> After making that change this patch compiles (currently running tests).

Best practice for submitting patches would be to ensure that each patch
compiles without errors (with the DEVELOPER=1 flag set) and that the
entire test suite passes with no errors; this is to maintain
bisect-ability.  Only after you've done this should you send your
patches to the mailing list.

-- 
Brandon Williams
