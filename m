Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E21A1FF32
	for <e@80x24.org>; Thu, 12 Oct 2017 03:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752360AbdJLDGB (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 23:06:01 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:52732 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbdJLDGA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 23:06:00 -0400
Received: by mail-pf0-f171.google.com with SMTP id e64so3013370pfk.9
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 20:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ivy45B3TjZplW1XlH77gVAWETzHLioff52+N3nzCkQY=;
        b=kx9Fs1/qLIuBhGDCf7X/OiKLMAkNUuMCi4+UqFSTxhmByBNEGcrhzeigY6DuTxKS/1
         SZzHlEX3Qr0r4uZVzijDSFqQsYqGvDri5Z3WuxXyQJExFToZmaXUYVgbynUQ9BngE5VG
         it+tkveouvWfxpUtDyXCTencbD7uvzmaZt/1U2uqcstkjRjl4mx9SdG/mxDL7Y/TV5Wu
         OnRO8b1uqE+gpGD81tlgVOAnRArobFePZsB1yhhN+T43NPgUwV4H4Ngae3J8ZSiYumds
         vBPLAzYRadBn3ibWpyPEFj2phYFQQTV/NUWIVbDD/+DdsVR5dUR68O2vUbN1+MyTqqIQ
         Hxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ivy45B3TjZplW1XlH77gVAWETzHLioff52+N3nzCkQY=;
        b=fW2UJETo028XKmPKlDS5hFuBO0n79a2Y4dQgE0IpHnHCYawBsiLpaJVM0/BGa9LPWR
         EWeDrw9DWDXQY/Iqn2UaWee7/02Zb9wiRtiYRpSVl9JBtJ6AvR/O5SQO2sHuqijhwunf
         h89Su/jfXmOq478Pbu1Yqt6ifK++LLdHKrGgc2srkbrZTS9FNSw7pka7SLKNB2THfKvK
         0OrTiDCB9ZA4Fr5l4+8NgwNTgmZTL3r1Vw66cYXCdI/Gfyrz50+7lpw9eA8cXOEf6+/+
         SZ8WJqJUokcPCfe20h42XZZ5aSCluzEVrUMxAlra8Qx2e2sjUrt5OR3zMEGzFkaCcMYa
         2GRQ==
X-Gm-Message-State: AMCzsaWbvIJEsR++UrWwnkIqIugU0PlX9rCkCbPMcpIYlGruUE6FxMn/
        V8ephBbZGNsz9EniuVdS3dQ=
X-Google-Smtp-Source: AOwi7QCA3pAxh5FC3/Mlmq5Aakuu7IcoVKdckcuMJonevu+0LEiRHkYBtKxr5jbntj3bqI44p3bjLQ==
X-Received: by 10.99.43.201 with SMTP id r192mr910872pgr.58.1507777559760;
        Wed, 11 Oct 2017 20:05:59 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:9e:660c:b9bb:a349])
        by smtp.gmail.com with ESMTPSA id z73sm20696620pgz.46.2017.10.11.20.05.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 11 Oct 2017 20:05:58 -0700 (PDT)
Date:   Wed, 11 Oct 2017 20:05:43 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ayush Goel <ayushgoel111@gmail.com>
Cc:     Jeff King <peff@peff.net>, Santiago Torres <santiago@nyu.edu>,
        git@vger.kernel.org
Subject: Re: Unable to use --patch with git add
Message-ID: <20171012030543.GA155740@aiede.mtv.corp.google.com>
References: <CAEBs8jLnU44n2fhE8tGommqfEpFPdd0FLUtmeZXZ+qhB1RV6XQ@mail.gmail.com>
 <20171011174952.almye3qa2tmyrmol@LykOS.localdomain>
 <CAEBs8jKAsb3B-6WJ=ptL2AsGvDRFVPYLCsztpdTN6KCBLOo1XA@mail.gmail.com>
 <20171011180015.mqn5xkj5z4yjdrhm@sigill.intra.peff.net>
 <CAEBs8jLyvyE+t=9mDHkD0nUY2SBYymg44BeQbUF0Li4CSZhMWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEBs8jLyvyE+t=9mDHkD0nUY2SBYymg44BeQbUF0Li4CSZhMWg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ayush,

Ayush Goel wrote:

> Thank you for your mail. It works :)
>
> For future reference, is there a page for known issues of git?

We usually try not to have known issues that would require such a
warning for long.  And when we fail, reminders like yours are very
welcome, though a search through the mailing list archive for an
existing thread to reply to instead of starting a new one is always
welcome.

Sorry for the trouble.

Sincerely,
Jonathan
