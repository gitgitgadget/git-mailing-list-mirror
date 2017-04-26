Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F8B4207E4
	for <e@80x24.org>; Wed, 26 Apr 2017 03:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1948071AbdDZD7s (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 23:59:48 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33776 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1948068AbdDZD7q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 23:59:46 -0400
Received: by mail-pf0-f196.google.com with SMTP id c198so13806209pfc.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 20:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZYY/X4mP+YLNc0u/ry033exX/azDn2u1VcHFw4dnIiU=;
        b=DrQvQELHY5T2tl/Q5wGmHM+9YaMNFFIC5EmlSOIP7L75eVPo5Dw+bRKYT8wV3VfqYR
         LtEvuQ0MptGQugKAJS7i7rOWNDCdZXnSF4s/eJYqexci6dLtIR4rHOgxpt4VOMFTGT8y
         g77KMnDi4NVLuEr60BjSiSW27zCyAHqwxzFVbjnmuH86h54xmpFnFdfRIjcFsJxta66z
         5HjYVk2Bt4rlJULC4PBhQzkAomHUhiiZ6XL+ZPH5PsD5+3mmjzFT04F5uKGockqn77hQ
         vissaAS2aAIW1CghYMkdSjN74mfU8wFfcN6HOckAnXVfIja8UFPLBAPKHgt2PJIhPzij
         y6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZYY/X4mP+YLNc0u/ry033exX/azDn2u1VcHFw4dnIiU=;
        b=QfucYNpVFNZ+RbjI1gSX4l22U1Hpgw9xniTiltLShgyJSgR/O/YiPrNkdRmVrLWsN0
         QXgjskUCGvM02Y1Av/0C+XLyDK+mAG4GbXokAfFaNupvIUv13wQZcKkC4OjWERJKdHOq
         QdUEDDoznKFtzQE0y1Pb/jjx1InGLqDU6tNfYdRlUhswLK/3Fbf8xp+KKaf7NoXFhwVT
         UuoqyjcplfTyqVDScOSakH18GoGL9DS7MFBZXb+2ShHTeHR9nEftD0mpje8sD74+Jlxa
         CMByyx/+YWVh8upc1lFrKdltM4QDjje0/+HFTcoqsp1/3nIMegQGrNrHPP22OkRTfYkM
         qzng==
X-Gm-Message-State: AN3rC/5GNHSKkBy6AXRO+yTqVcuyF45yNmpAebYAOASn7D0rFzCv/15j
        de0dppbdx47Yp6qEttM=
X-Received: by 10.98.58.149 with SMTP id v21mr31691253pfj.242.1493179185545;
        Tue, 25 Apr 2017 20:59:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3179:d004:20b:b383])
        by smtp.gmail.com with ESMTPSA id n8sm38987762pgd.31.2017.04.25.20.59.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 20:59:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     liam Beguin <liambeguin@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] rebase -i: add config to abbreviate command-names
References: <20170424032347.10878-1-liambeguin@gmail.com>
        <20170425044320.17840-1-liambeguin@gmail.com>
        <alpine.DEB.2.20.1704252148400.3480@virtualbox>
        <1493165607.29673.31.camel@gmail.com>
        <20170426014704.blyczgmbuqd5amys@sigill.intra.peff.net>
Date:   Tue, 25 Apr 2017 20:59:44 -0700
In-Reply-To: <20170426014704.blyczgmbuqd5amys@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 25 Apr 2017 21:47:05 -0400")
Message-ID: <xmqqpofzstsf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think the words "instruction list" may have come from my suggestion. I
> used them because that is the term used in the rebase.instructionFormat
> documentation directly above the option you are adding.
>
> It may be worth a follow-on patch to convert that one to "todo list" if
> that's the preferred name.

Running

$ git grep -i -e 'instruction [ls]' -e 'todo l'

lets us count how we call them, and we can see there is only one
instance of 'instruction list'.

Running the above in v1.7.3 tree shows that it was originally called
'todo list', and we can see that an enhancement of cherry-pick in
cd4093b6 ("Merge branch 'rr/revert-cherry-pick-continue'",
2011-10-05)) started calling this instruction sheet around v1.7.8.

A follow-on patch to unify all three would be nice, indeed.

Thanks.

