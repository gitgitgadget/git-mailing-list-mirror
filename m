Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33052202AC
	for <e@80x24.org>; Tue, 11 Jul 2017 13:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755575AbdGKNKF (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 09:10:05 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34426 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754931AbdGKNKE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 09:10:04 -0400
Received: by mail-pf0-f194.google.com with SMTP id c24so18976996pfe.1
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 06:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=KFcpDTH+SJsLeW2m1MZBBk/ULAmkSuwVpV668/Uj+34=;
        b=itRp26XnMODVr+6MVVE1yfAbsDbs3DfA2r1k40d5D8Od1bMrRGhEBz2VvQSbR7NqaP
         VCGb3Upv/StxKzWuJZtziYRmIvv8VljCku1McNi56a2R9U2gkaoftJOXuR8cbfN6fNWS
         b0AYFb3YDiGOuvPbQx98ZK7JvJf4VfWFSlh1hwi3SNd6f/eYGONrZB3NS+Pq++7BWhMI
         IojP3xMJDEG5x9oo7K5nC3/USALjDZbvMXwzUA4XmwnFC8X2HfE/FMSwXZH7iiFFyfz6
         ONXi8LDcvEKTCsa6B8p+abE4Zae0Uk40TVBLDV/cbZ4owD95aha/aX19Kl5Qe+/m4oyB
         dSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=KFcpDTH+SJsLeW2m1MZBBk/ULAmkSuwVpV668/Uj+34=;
        b=NkfFL71R9OjgyRRXDdzydQhOYWvLhZAUbsYUGL6BT2EclSFu8AcaGfUzrcDGR2mRi0
         HloeKokAar42UL4Mo0cQx3QMNUjruH/GlsqzxgIRKgvp7C0pPiBqgRTxLOx6f2XE6JB8
         1p5/ABbgSmiL/qnVlY2IpI5OLL60LaLUS0Gq8oI7K1YKD7MwqHxc5bFRD/iz4gJKdcDc
         G3jSMi1C8X4Ii4um2H2AMsXkELGo76afa+XyXbzV0b9koZ7Vbl1/zjV09GEaXetu4MYO
         gE7kIpWG8N7ZybUNDEs8KPDANBAB9pyxJ3aefTbtdMj7W/44HypTPhCB9ZnLAHtbzWEO
         Pn9g==
X-Gm-Message-State: AIVw111buR9BQWGkq/mEFUTpNYoV/VIJKUo/6flw8aR0wPDpOMZ9a6AR
        gis90U7sy4ZBaGbbCGk=
X-Received: by 10.98.223.141 with SMTP id d13mr50371841pfl.179.1499778603927;
        Tue, 11 Jul 2017 06:10:03 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id t26sm31744535pfe.88.2017.07.11.06.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 06:10:03 -0700 (PDT)
Message-ID: <1499778613.1740.1.camel@gmail.com>
Subject: Re: [PATCH 3/4] hook: add signature using "interpret-trailers"
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>, gitster@pobox.com
Cc:     git@vger.kernel.org
Date:   Tue, 11 Jul 2017 18:40:13 +0530
In-Reply-To: <2e957be5-980b-1d7b-812f-bf18d12313d6@ramsayjones.plus.com>
References: <xmqqinj4ayqb.fsf@gitster.mtv.corp.google.com>
         <20170710141744.8541-1-kaarticsivaraam91196@gmail.com>
         <20170710141744.8541-3-kaarticsivaraam91196@gmail.com>
         <2e957be5-980b-1d7b-812f-bf18d12313d6@ramsayjones.plus.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2017-07-10 at 16:13 +0100, Ramsay Jones wrote:
> 
> Again, s/signature/sign-off/g, or similar (including subject line).
> 
Thanks! Forgot that in the course of splitting the patches and
modifying them.
