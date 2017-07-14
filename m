Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5818620357
	for <e@80x24.org>; Fri, 14 Jul 2017 13:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754115AbdGNNb3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 09:31:29 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35344 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753635AbdGNNb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 09:31:28 -0400
Received: by mail-pf0-f193.google.com with SMTP id q85so11035735pfq.2
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 06:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=YdB/EJULo3LEC76G8oB8jUgzKUMAPbpI6Sot43WLFkU=;
        b=VADAMZ8r6WOMloWZAziVpnYyF9saO7VUZk4CvT3v2m1rJqk7toN86ZFy7L/3/GkI/v
         WPhtrZGmwwDviwAGEdJX9LeNZyT0T2z915Nc0u3jHTfbaYuQQ1Rm8kw8PcNk8C4yDVFS
         BCXJgejnI97QVLkZwnNq6pwzidQ6OXaMSPgjEsyU99sdqHYhk41EDHXUIF9tJK/jpAir
         oZ7hnMoVoHT/doFtll7Ak9cTGqcwaT8B98HVF9jQrxzKUk7q16QUvJbnWKw/BMk19BXq
         AU/jrdkRTpTAUKGc5K4XwUlghEQJT81l+5Uh41oRBaO6d96CtbB7XuTpPWQfUhGgMpBu
         GtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=YdB/EJULo3LEC76G8oB8jUgzKUMAPbpI6Sot43WLFkU=;
        b=kPbQFR7J+eiMoWjBqg9pdym5061cv1xak114z7KH5zZVk/v2bavssCLEoK9cv7Fy71
         K3hZV5ryXxqRQESvY9/jfRqZuYQ2X3Y/absqj20HEZRL/kzCfmS/LS8sfhZbayyWRjlu
         q6BgScotdqYCbyBHEu0KO0y9cFrK0YglhnbbATBWFFCr/wmS8QDbIOyE20/QSZHLlM25
         SDnzKr3umFrG+JLVypRX0ZMoYvd6BZz1YbWmhVlxmjzGqjRIIUnKUCUN9PlbxsWfxIjc
         ISfa7GxUOrkkLCzlElwzA8sYcwHqoE9ZR+a68hAvp0Dlefy2gCDnXzvQyLHqKhat+MM0
         ynXg==
X-Gm-Message-State: AIVw112PFGoqU7puW6BQdOS/Wo3duvfzVroRTaQtRjxqM8YHj2k9gWgw
        aG1qekL4AZgtAA==
X-Received: by 10.101.83.135 with SMTP id x7mr15395562pgq.63.1500039087710;
        Fri, 14 Jul 2017 06:31:27 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id r62sm21941296pfl.45.2017.07.14.06.31.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jul 2017 06:31:27 -0700 (PDT)
Message-ID: <1500039101.1939.3.camel@gmail.com>
Subject: Re: [PATCH] commit & merge: modularize the empty message validator
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, me@ikke.info
Date:   Fri, 14 Jul 2017 19:01:41 +0530
In-Reply-To: <xmqqr2xkxlpo.fsf@gitster.mtv.corp.google.com>
References: <20170706044640.GA11020@alpha.vpn.ikke.info>
         <20170711141254.7747-1-kaarticsivaraam91196@gmail.com>
         <xmqq8tju3eqp.fsf@gitster.mtv.corp.google.com>
         <1499950837.2427.1.camel@gmail.com>
         <xmqqr2xkxlpo.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-07-13 at 10:58 -0700, Junio C Hamano wrote:
> I think many people know about and do use the "delete all lines"
> (i.e. ":1,$d" in vi, or \M-< \C-SPC \M-> \C-w in Emacs) to abort out
> of a commit or a merge.  I just do not think it is likely for them
> to leave Sign-off lines and remove everything else, which is more
> work than to delete everything, hence my reaction.
> 
Thanks! Didn't know this before.

