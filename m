Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FF4D20372
	for <e@80x24.org>; Fri,  6 Oct 2017 19:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbdJFT0t (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 15:26:49 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:43842 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbdJFT0s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 15:26:48 -0400
Received: by mail-pf0-f178.google.com with SMTP id d2so6813922pfh.0
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 12:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Vujg6MkCQR79qIXk8SrO4ezurCLetua8YBtZWCxnkWg=;
        b=KjdaNDXOmGoUHhnnfMaXB7qAy8fklO+zzCdT5Zd4HmB6WcGbscKK4/wI7+95PHDuUR
         zlGdhzQZci4yfLw+EiLffB5RJrTfIMM+/JHi/xCyok6IgS5+NiG5USZEQR5smsRNs6C/
         q+ZisOXrWqqHg/Tf2ZMfaK7r15rxNs/F3MK8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Vujg6MkCQR79qIXk8SrO4ezurCLetua8YBtZWCxnkWg=;
        b=B4ELPtMWj5w/XlLeFukv9VCG98yCjFegpAxDebgCb+kQCz+azdrI2nMi6F81qSoM5c
         ikIxgGyMzBGVRuIdwtpMd9TbuI9ror/aL26hT8oWzCraaQaRaun3/LArimJX3Rw+xLVp
         GgLCzj32urERBJvxp304hX68KPnY6vxZ0Ea628QW1uPWY44T3w/4wZVMgCYxOLKsFD4B
         oV07aLJFdIWnG53LxNyQAoVU9skTe6WzRMu4Byh9ZTKVe5tAkYldOVXN2eIkoHGExAmt
         PI/vUGgvMSgvULM1c7UIQ2pfaoHkARgubNzZCVFij7YVNxAJ9CRqbtdFyETOFukir+AZ
         GH2Q==
X-Gm-Message-State: AMCzsaXCeBG2fF4tWxbbTr22pTro1slG+pdXBc3kDDM3JhBvnSXVtWGf
        a9DINbJ2Weg2odQ9f8Qzpi/LIQONxNA=
X-Google-Smtp-Source: AOwi7QAVO8EpRtyGZIUEapuvObytxMQUkvggBeV6D+1Av4SzbeSqdMDeLLklex2xAEx9WD8mPrGhhg==
X-Received: by 10.101.73.7 with SMTP id p7mr2919737pgs.106.1507318007795;
        Fri, 06 Oct 2017 12:26:47 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (Guest-GW2.corp.dropbox.com. [205.189.0.166])
        by smtp.gmail.com with ESMTPSA id c7sm4624997pfc.55.2017.10.06.12.26.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 12:26:46 -0700 (PDT)
Date:   Fri, 6 Oct 2017 12:26:41 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
X-X-Sender: alexmv@alexmv-linux
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [RFC] Reporting index properties
In-Reply-To: <xmqqzi95xamw.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.10.1710061225030.18016@alexmv-linux>
References: <alpine.DEB.2.10.1710051625430.812@alexmv-linux> <xmqqzi955cnx.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.10.1710051745060.812@alexmv-linux> <xmqqzi95xamw.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 6 Oct 2017, Junio C Hamano wrote:
> Yes, and I am saying that such logic should not live in standard
> install outside developer tools ;-)

Fair enough.  It seems a little odd to me that git provides logic for
_altering_ those bits, but not to report on the state that can be so
altered.

 - Alex
