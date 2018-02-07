Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C3DA1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 19:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754108AbeBGTXw (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 14:23:52 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55420 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753995AbeBGTXv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 14:23:51 -0500
Received: by mail-wm0-f65.google.com with SMTP id 143so5193411wma.5
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 11:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Mepra+7A55MFV99AyRDLQf+uIHw45tHvG5VdSQO3Sx0=;
        b=G8LRLWHEaIEseHbjOEATJbcfv1MGa5i+URERZg+BkNp29289lqWIYaochxqXz++KSz
         gVz3fckL6R+SoNhc2A0/qO/vyaEtmgscACrDu9NjatONZ2/iyX8ZCDWR0bKhkHIbxML/
         lDyS3UMyUxXzI9gqxbDxTFLX9TLHgTC7iOjKJ4eTCKFNKHxidmkatZdBgCtasF9Ho3Aj
         /idLRts3FgDO+hsATZ3+yO40wbKAm6PLo09xDMbKJzwbPxlzksh57103xmDdJqu92mzB
         RbAF/IXGP6oZuRpn7wP7jyMlNjbRgG8990Np9AwDOf1ceREsqtEkJl31UGImwDEXirtG
         WzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Mepra+7A55MFV99AyRDLQf+uIHw45tHvG5VdSQO3Sx0=;
        b=gmJR/jk05YH53J2eEZmqfeudIW+csKHP0bOAH3IC8HF0k+vI4at4ROnIxWCowO8OgB
         K/zmsporAn7+1IwNk36lRm4FzsEJoDAm25O5cGaJ2i8Uh9GFuDeoDCTTp5bN9FycDzHa
         KjHF256zpHJGoyczM5kHB3Ka6vbCVL7JmSutYngfcrJFiiKj3d92wFkF/aWVpi+ztuX3
         iS6JKMb35FgiW3CxVTqrfAmysR95rC0oqaIPhX/BfKMxTKSWxDVyhcK1/fETAC1B0L8Q
         4bHVrdtVru2LVCcFAWGE3lvE6KJr25V7VBAZrmIOiJ87oFcRfZ7Gba+/ilG89XBDe527
         YTnw==
X-Gm-Message-State: APf1xPDFKyR7uFoWeojJcwt9khV46oUNIM6aX1bLq5T8dKZYU5kCzLKY
        tFw04sruyKM1zXS0IbbwSjI=
X-Google-Smtp-Source: AH8x224rpXw86Xv9/6BdH7lSKdE1GDrc4YgYL+n+O+lkKn22fcAcP3xcBMSeTt+LItjmVCmzRhbjnw==
X-Received: by 10.28.192.24 with SMTP id q24mr5908153wmf.96.1518031430136;
        Wed, 07 Feb 2018 11:23:50 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o13sm2905587wrc.62.2018.02.07.11.23.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Feb 2018 11:23:49 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 00/41] Automate updating git-completion.bash a bit
References: <20180131110547.20577-1-pclouds@gmail.com>
Date:   Wed, 07 Feb 2018 11:23:48 -0800
In-Reply-To: <20180131110547.20577-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 31 Jan 2018 18:05:06 +0700")
Message-ID: <xmqqr2pw7ge3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> I posted a proof of concept a while back [1]. This is the full version.
>
> This series lets "git" binary help git-completion.bash to complete
> --<stuff> so that when a new option is added, we don't have to update
> git-completion.bash manually too (people often forget it). As a side
> effect, about 180 more options are now completable.
>
> parse-options is updated to allow developers to flag certain options
> not to be completable if they want finer control over it.  But by
> default, new non-hidden options are completable. Negative forms must
> be handled manually. That's for the next step.

Everybody seems to be in favour of the approach taken by this
series.  Is it in a good enough shape that we can merge it to 'next'
and then go incremental from now on?  Or do we want to keep it in
'pu' to give easier access to volunteer guinea pigs and wait until
the way to handle '--no-foo' options are figured out?
