Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADD191F731
	for <e@80x24.org>; Thu,  1 Aug 2019 01:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbfHABOv (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 21:14:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35570 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729274AbfHABOv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 21:14:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id s1so26706157pgr.2
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 18:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lUFc6IHR5wG1OpKJQUIv4/wg1m89+bmxvrybLblnCjE=;
        b=sJxyvGa+Mjw5P75pcLnDIfQYHt8fSiOhMTr0XOtjpsX0C3DjCpkgRsJ2wYOWFSN3Hk
         ZJLtlOJZHIVxJ+wSxWY+9AQ/AkxHf/3fr9MFXgScKV8BD8VR+B2MdCjrEQU17Xsw6xn1
         JAjVppqK7nSSeOkGPRdH70xfYuKMFVzOejTpQm1pFMxbaamNXzEa4evPpemMhq5P5Qmg
         3ABpQRGxuqNhdVYocNgiWc7ec9++3vu8zqMEYiaIMfsPVQewZJ3iWy7kahrFFR0aO5jL
         IzFWOyGp1piV4mPdktJqjg9KihPa+r0FISH/c1owRe0kgs5hOU+15RC7My/j663L6CRu
         5gvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lUFc6IHR5wG1OpKJQUIv4/wg1m89+bmxvrybLblnCjE=;
        b=UTKqT2qUps6ga7wcw470FL28MstyuQ+rLkSK3udo/eRNfYI8rjMY3ZAO21ZIuFRtxA
         Xnl9yJtXvGXsTJpomd50yp7Ha9E05s1rUdatn59GX5si3orTfI/V1QyCOpTqeM50j20N
         UQpCcqHLTmxefgrcM35iXQe6pEQfEEWa8hJVPfzLo0B1rEUI+fgXYNZFQxfpMOARi6FQ
         CNSLJyrmNtXd0WGNi01Ap7K+IFBPrE7HPComCWhzN8YI2OqieekkNcULOMdKdlkzBWMC
         91v91AAQUx7Pz2AtDqA2nhupZsYmyuDQSoORKhaZPglcJwKppl+dp9/ssCZn5SQylWZs
         O+eg==
X-Gm-Message-State: APjAAAU8yv3lCdC2xKCuj6WagVGVu7iql12eFTTPGfO0JIFXMRhm27wi
        QDQtC3dxlka/Pthp2oJl3pY=
X-Google-Smtp-Source: APXvYqwvdbAcDi5Hlagqdp5G+d1kuQgK6I/wb23rsAYrZdejLo7rgG9S28xXFv94XC2vNCmSfpWC2w==
X-Received: by 2002:a62:63c7:: with SMTP id x190mr48501782pfb.181.1564622090673;
        Wed, 31 Jul 2019 18:14:50 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id o128sm75419409pfb.42.2019.07.31.18.14.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 18:14:50 -0700 (PDT)
Date:   Wed, 31 Jul 2019 18:14:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com,
        Ariadne Conill <ariadne@dereferenced.org>
Subject: Re: Git for Windows v2.23.0-rc0, was Re: [ANNOUNCE] Git v2.23.0-rc0
Message-ID: <20190801011448.GB176307@google.com>
References: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1907311440130.21907@tvgsbejvaqbjf.bet>
 <20190731231848.GC1933@sigill.intra.peff.net>
 <20190801002125.GA176307@google.com>
 <20190801010022.GA6553@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801010022.GA6553@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> This seems OK to me, though I kind of wonder if anybody really wants
> "auto".

Sure.  It's just the usual way of handling the lack of support for an
"unset" directive in git's config syntax (for example, if a script
author wants to test the default behavior).

Thanks,
Jonathan
