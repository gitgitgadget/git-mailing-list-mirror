Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A30111FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 20:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752700AbcLIUaq (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 15:30:46 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33390 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752102AbcLIUap (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 15:30:45 -0500
Received: by mail-pg0-f47.google.com with SMTP id 3so11236805pgd.0
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 12:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pHUyTNSVDmx5+C4l/zviKUk96DrVqQ83UYP+JP7gLKo=;
        b=Ax0erogJ6sB2SPIkQ15JK/mYjMlXlcLt8F+KPJSidJZAQSg3wC18X63RlUnTaGUFDC
         0ut8YOSIKIALGqK+PS5+m9nfFluBeKTO+ixRUAh+NkoocMm3EgP7Aak8OsLAAOilFCaw
         29ba9mN8xkPCSiDof5f0b6AxBATWqL/2P9DO4TLlumnGLVP9LeGEZ/EC5wGYFgUURZ4o
         JT6mZADjvClW/jVc0SG59Wh/q8bQjwHkePmL600kx69t9k4AuHJVYj3UeoXQTIv5H9ex
         8wOxJFqKEi4eT/T+pycBsXiQ4QiBRVFlZpfkEM99dH3IEUMkFzaT4BpxRfYdohGOCQ/Z
         8ZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pHUyTNSVDmx5+C4l/zviKUk96DrVqQ83UYP+JP7gLKo=;
        b=d22UI0q8HQrYAGU6l2PwhI+s5elTlc93f+gtPkG1BilPzT1TpXYKySucGNzTISD9lv
         jVIkNZtUiDL6vOPgfwohByUEyiIfJNrQrby6a78ZY5ZSV8uKY6AgKiLECF0yMuoexkWm
         33Hs+1eDO8zbQinRdrcZERmKbzSNagFiGKFzGPfwoLwcmmMfrxuMbDx6cY2YRWpgbXYP
         6Uz3AZCKAL1peamTVx7bn1EsCshaZGO8XLJXurJDAJTQuMV69WfVLcIIwEi4crBZVsfD
         isgG5AEXpRD29yFHCSmDEXp4b7LbOawqcMIukbOZWzmEfJn3/5CeGrgbsUAN2Ca+z+zN
         bB7w==
X-Gm-Message-State: AKaTC00Gl9WebWrsaCzsjc7uCPr6KWh7tPUs5MkWmVGUTU8EP5bCCevZTmmi+FM6IGj49JtM
X-Received: by 10.99.146.13 with SMTP id o13mr86299870pgd.3.1481315444900;
        Fri, 09 Dec 2016 12:30:44 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b541:bdf2:ef3a:110f])
        by smtp.gmail.com with ESMTPSA id r2sm59483426pfi.67.2016.12.09.12.30.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Dec 2016 12:30:43 -0800 (PST)
Date:   Fri, 9 Dec 2016 12:30:42 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/16] pathspec: create strip submodule slash helpers
Message-ID: <20161209203042.GE88637@google.com>
References: <CACsJy8AX6C8Tux9_8ZynBMNS2EW2pKQOGK8k0hVmbWvbZ8pa=Q@mail.gmail.com>
 <1481311118-174146-1-git-send-email-bmwill@google.com>
 <CAGZ79kYVumubF58fdwejE2hvCLfgdVqTxn_w=S-CBFY-NdgqQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYVumubF58fdwejE2hvCLfgdVqTxn_w=S-CBFY-NdgqQg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/09, Stefan Beller wrote:
> On Fri, Dec 9, 2016 at 11:18 AM, Brandon Williams <bmwill@google.com> wrote:
> > Factor out the logic responsible for stripping the trailing slash on
> > pathspecs referencing submodules into its own function.
> >
> > Change-Id: Icad62647c04b4195309def0e3db416203d14f9e4
> 
> I think we should come up with a solution to wipe out change ids
> before sending emails. ;)

Darn! Yeah maybe a hook or something :D

-- 
Brandon Williams
