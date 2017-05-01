Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 423471F829
	for <e@80x24.org>; Mon,  1 May 2017 01:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S642169AbdEAByY (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 21:54:24 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34136 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S638403AbdEAByW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 21:54:22 -0400
Received: by mail-pf0-f195.google.com with SMTP id g23so26111344pfj.1
        for <git@vger.kernel.org>; Sun, 30 Apr 2017 18:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gNZ9z+EOua0//qPhx4XP654HTxsVIePCcCsON40MTYk=;
        b=impvXen0FbIH8MtG5jKoxD+WwCtX0mrlzKUwDpNbMvLHOsvEZMzYFZmA4t16PZAhq9
         pHbyRoFbXpbrh/bBpQIA9Dd/e03oXgtMD3hbu0LmRimI8PCLOKXXBGYVJoyyUi7lfWXv
         i+laAOsdj6ywniAzlgj0VFEIV7HVeh/oS0/U2365aXEc7U/eJfynxqRRh5PSGTAZ+LeC
         b6EI01JssOin98KBj/pHHs0f1xrXF7/m3PUTyQUXA6JcuBxywclwR/f9BzpLMYhs0NAO
         iExZlvUVJa80Dq12LzQ4ibPbdfZ4NRv0pbufN8TifEHsV/hTbRyncBmn7eN5rHA2PHM9
         l3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gNZ9z+EOua0//qPhx4XP654HTxsVIePCcCsON40MTYk=;
        b=R6yIrNPuAXAk3eQEDcZfw4BNv5GvU3kDtCTmUS4jaqzYChSPvT/egQddYyohh+C+yU
         Lff4lnQ37fLlocLssb2HshBAXk21f4/yPfFNLOHzaAe6zgP8c16xtWJ21IggJME1PxoV
         mf+4I3L88vZHDpNmdV66bHIvbsN/BDppN5XBYgbum7bFjdscF0qEbLwoHDbmNQP1jran
         c03oi8svj3jMMiiYHbIm9RFIB4qdJu0RW71mNPeGVPlmfeFw3h/6BftoDlNftVuCu3yr
         3Gpw5wqgE+pGJT+9hPuN85bn2y1Gj+PyfbKlByyNfV4W73QRmyF0wB9DYC9SQg7X3xH5
         xoHg==
X-Gm-Message-State: AN3rC/62Z44yY2havE8s/gw3P/xjeXw2G+3jtECS6zKrDu/Ejdg22e3g
        n4ppCBpGZS7DQg==
X-Received: by 10.84.218.71 with SMTP id f7mr6467335plm.135.1493603661944;
        Sun, 30 Apr 2017 18:54:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:216d:aa3e:248d:bf63])
        by smtp.gmail.com with ESMTPSA id t2sm19920099pfl.34.2017.04.30.18.54.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 30 Apr 2017 18:54:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     xiaoqiang zhao <zxq_yx_007@163.com>
Cc:     git@vger.kernel.org, viktorin@rehivetech.com, mst@kernel.org,
        pbonzini@redhat.com, mina86@mina86.com, artagnon@gmail.com
Subject: Re: [PATCH] send-email: new option to walkaround email server limits
References: <20170429122632.7122-1-zxq_yx_007@163.com>
Date:   Sun, 30 Apr 2017 18:54:20 -0700
In-Reply-To: <20170429122632.7122-1-zxq_yx_007@163.com> (xiaoqiang zhao's
        message of "Sat, 29 Apr 2017 20:26:32 +0800")
Message-ID: <xmqqo9vdiboz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

xiaoqiang zhao <zxq_yx_007@163.com> writes:

> Some email server(e.g. smtp.163.com) limits a fixed number emails to be send per
> session(connection) and this will lead to a send faliure.

That sounds painful.

> With --split <num> option, a auto reconnection will occur when number of sended
> email reaches <num> and the problem is solved.

Two nits (other than s/sended/sent/ and s/$send_count/$num_sent/):

 - "--split" sounds as if you are splitting a single large message
   into multiple pieces, which of course is not what is going on
   here.  We need to find a better name for the option.  Perhaps
   "--batch-size=<num>", "--max-messages-per-connection=<num>" or
   something?

 - The code seems to do the "logging out and the logging back in"
   dance without any delay in between.  Is it something we want to
   consider to add a small (possibly configurable) delay in between?

Thanks.
