Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FAFF1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 18:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935068AbcJTSto (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 14:49:44 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32844 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933863AbcJTStn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 14:49:43 -0400
Received: by mail-lf0-f68.google.com with SMTP id l131so1535230lfl.0
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 11:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ePhBAB3fXPhSo/WUfJbo5pei7i5IxgQ2pZR+6LCH1zs=;
        b=zih1TU95M21LihE80O0Qg1tkKDSyGTW7pOCFEbrXYqpF6y9SZbZt9jErhcntC9CnJp
         IZRCseTSTDgJI4vbpsh6abexaSkFaIXgWj9eF08k7o2rsbGkymvoQm530KW3Ze9hYfQG
         dPmixI/kvPzk7F4X7rSR+YSa8uHeLG+sTGcjpSZ4u+yqE9QIVwRSetVxRJn0/oAJC55b
         DC0IY32i9FRbqUs8mirvtObFzwLoQwmbSzUcK75WEM59I0u0Zko/mfE406hn9Z/KcIzk
         ccXJUGV2DCCf00yNT3MswdLVcnMrbNy2b1bdJSjNGeAFcXmCmDtx+W1NDPl38heQeDtx
         HbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ePhBAB3fXPhSo/WUfJbo5pei7i5IxgQ2pZR+6LCH1zs=;
        b=eynZZ2yfKel892PmduwxvKkRbOui3PsJZJcqfnJm/IO7LWsyvFIiN/pPp/RGbd3w3p
         +CSkEcJMwLIoll1i+OEqVdO5vc5Jp1bgh7RQKEZ4eT4RD/KKBjWDBYiO7Iwcw73pjLgr
         g9TnWIyqo1VyZd+5hb456oDWFwqu3C0hhelFXcVKZBFtbAeZAujKRaGh/3s877+s83o6
         DJyA5HjlWKeg4bBa3zdirfd58rMIUtpSQJe3hGl4d4dMibkum8RuGRcV/VwSQGEUIGqs
         y2/5ALa9Nb2nPPyVCVjsPLNQUzDkF08Zr/QDTWi/zp2maACu3uz+w8Nm/2xvEUihjwG1
         WFVQ==
X-Gm-Message-State: AA6/9RmBEM/HxZ2IHuxqwvlDo8R8vd32kRiAlXnCrT+EWpWPyps4wM2sTqEo829Lg+S+aA==
X-Received: by 10.28.93.134 with SMTP id r128mr1278668wmb.13.1476989381762;
        Thu, 20 Oct 2016 11:49:41 -0700 (PDT)
Received: from [10.42.1.91] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id h10sm80954725wje.48.2016.10.20.11.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Oct 2016 11:49:41 -0700 (PDT)
Message-ID: <1476989380.28685.8.camel@kaarsemaker.net>
Subject: Re: [PATCH] rev-list: use hdr_termination instead of a always using
 a newline
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 20 Oct 2016 20:49:40 +0200
In-Reply-To: <20161020181930.21084-1-jacob.e.keller@intel.com>
References: <20161020181930.21084-1-jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.0-2ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2016-10-20 at 11:19 -0700, Jacob Keller wrote:
> Here's my solution, with an updated test using a helper function based
> on using sed (which I think is more portable than tail -n1 ?). The
> change actually is very simple. I ran the test suite and it appears to
> be not breaking anyone else since the normal case is
> hdr_termination="\n" except in the cases where it needs to be NUL.
> 
> Thanks for the bug report!

I like both improvements, and both 'make test' and gitweb are happy
with this version. Thanks for the quick fix.

D.
