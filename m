Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B199C20C11
	for <e@80x24.org>; Thu, 30 Nov 2017 14:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752831AbdK3OnB (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 09:43:01 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:33617 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752202AbdK3OnA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 09:43:00 -0500
Received: by mail-wr0-f177.google.com with SMTP id v22so6845687wrb.0
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 06:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RJyEkgQyeczzwVuXKnK+Pmpb+E6X27/qbixEtHo7vjs=;
        b=Y+BEj26rZWKRXbCs2BMS+RypkUUS07pz1yy9yRfPH5IoosxyPKufdlaJH5Dho65X6s
         /u3vVHDtJzHKHcUf6NYd3+Oa5mHQ3sTqehO2SQjRJaCuveZZWfR5zr7/S3uot7mNX/L6
         7vWF9WbotfAzQRyuEm2Iw/Oq9OJsL6+oT/A4vlTZcxWsmPEKFcWqoFr1G4PDfH9yZaiO
         IaDtjAtRbSUDpIaiXKnm3qc4BEGF/3X319xCIMp4Mj2NJMl5l/AFU5y/gh5gj0pL5H7H
         f+Kxi5suZjUHSoc6gx1S8Zgjq9Xrw/KhptFJketUr21mY8l9eIzXw5W7wbKh654MPbm9
         P2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RJyEkgQyeczzwVuXKnK+Pmpb+E6X27/qbixEtHo7vjs=;
        b=Ts0vq1cN7+IqCAvLLYm9MdHnz8r6MW1rKs3nBERrjJxr4oDTqGK0Zk/pBf3uarsIuA
         ex3HGXqQX202UPXOSjqxkNhtLqHmSEqUquVqKD4IVMQypXpgLinHkpqz1wt301b6o84z
         EeEwJ2jfZjLslAYEZeerFpQpQJiefdN0faX3d3DV9rKFAOyemdlgH57WKUhplbx+lq3U
         gv8i/VZIgLdfyv2nx/ZHc3pjVE8Gz9mirTuD1+0WhzmiK/Qc10ivxfRGE+CXOgxvSMa/
         LOb8+vzhkTy07ia1Xgn5GAnan/N7tw5x4Lt9PL6DSLOHb9iddeWtfdjtOWbj4iz9+/4S
         PkWA==
X-Gm-Message-State: AJaThX4yrb2x3ZRTdPotmDXLw2Q7zqfGLbmtetvCOvZ8QpNYZHZuQPs2
        H0A+hyorBJiIyEprHK3wVBw=
X-Google-Smtp-Source: AGs4zMaqtCJsJPYBjCikJzkkUYVRo0/jAi/ak/XYvZ1Z7VVfDQjgJ1rFk/Y1bGAuuhWkYomH5CdpsQ==
X-Received: by 10.223.199.70 with SMTP id b6mr2171501wrh.25.1512052979170;
        Thu, 30 Nov 2017 06:42:59 -0800 (PST)
Received: from laptop ([213.123.51.170])
        by smtp.gmail.com with ESMTPSA id c54sm6520564wra.84.2017.11.30.06.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2017 06:42:58 -0800 (PST)
Date:   Thu, 30 Nov 2017 14:42:57 +0000
From:   Thomas Adam <thomas@xteddy.org>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Thomas Adam <thomas@xteddy.org>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>, sunshine@sunshineco.com,
        kaartic.sivaraam@gmail.com, sandals@crustytoothpaste.net,
        peff@peff.net
Subject: Re: [PATCH v4 0/2] launch_editor(): indicate that Git waits for user
 input
Message-ID: <20171130144255.5w72jcpz4a5igiro@laptop>
References: <20171129143752.60553-1-lars.schneider@autodesk.com>
 <20171129183514.wze5trxjfgqxqs7z@laptop.local>
 <C91E8F24-DD13-4FEC-BAB3-A8B8F2DBBA8D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C91E8F24-DD13-4FEC-BAB3-A8B8F2DBBA8D@gmail.com>
User-Agent: NeoMutt/20171013-21-a9a9c7-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 30, 2017 at 02:55:35PM +0100, Lars Schneider wrote:
> 
> > On 29 Nov 2017, at 19:35, Thomas Adam <thomas@xteddy.org> wrote:
> > 
> > On Wed, Nov 29, 2017 at 03:37:50PM +0100, lars.schneider@autodesk.com wrote:
> >> +		if (print_waiting_for_editor) {
> >> +			fprintf(stderr, _("hint: Waiting for your editor input..."));
> >> 			fflush(stderr);
> > 
> > Just FYI, stderr is typically unbuffered on most systems I've used, and
> > although the call to fflush() is harmless, I suspect it's not having any
> > effect.  That said, there's plenty of other places in Git which seems to think
> > fflush()ing stderr actually does something.
> 
> I agree with the "unbuffered" statement. I am surprised that you expect fflush()
> to do nothing in that situation... but I am no expert in that area. Can you
> point me to some documentation?

Because stderr is unbuffered, it will get printed immediately.

> In any way, would all this be a problem here? The worst that could happen would
> be that the user would not see the message, right?

Correct -- I only bring this up because your interdiff showed you added the
fflush() call and I was merely pointing that out.  I don't expect you to
change it.

> Are you aware of stderr usage in Git that could cause more trouble?

No.  It'll all be fine.

-- Thomas Adam
