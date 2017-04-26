Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D60A3207EB
	for <e@80x24.org>; Wed, 26 Apr 2017 20:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967248AbdDZUba (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:31:30 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35593 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967241AbdDZUbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:31:25 -0400
Received: by mail-pf0-f195.google.com with SMTP id a188so2431204pfa.2
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 13:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JA/k+GZr7u1Gb231u/gVVNqjkEMzQvTKlXVWB0ImIu8=;
        b=U0fWvZBuPZYeC37A/UMCdAx17/AnVBHp3pF7Pkhjz/s4Ofad1KtFDeFcmOha6JK4l5
         n6RIJL/aNPRze9A7sySR7GHtS9Iljjw39K2vIad7uekZ2B+f5Rm2sM6i83grsQLSF629
         ia09Scs2vlzzd5AVTjcI8ps14bEUBkfri/6ndID7iTaw6pCHKWd531fUmVoZQYdpguPc
         FjdHwm4w1D3qG3AJ3YcOSulw5UaSbZZ8SrKShLySEJxlsfKzazbCn/ee5WYZ7mbVkWkW
         rwz4SR+7Qcf+OdOHTv8AfxLbLGytfuXLcMa1mR3hrEHkxLph0M/hGWsaCn7nBQZPK1fD
         sJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JA/k+GZr7u1Gb231u/gVVNqjkEMzQvTKlXVWB0ImIu8=;
        b=gUYPmRpghi6SAvs/iUYglICUlu9NPX35qDHay9u3TebNqP9jtH6dKFdDpdO+T47x9b
         dZUs1YI8jQC/yhbcgURp3qM0ZlIYfQkSWijWXVz56C1D48ZkD9TQkE13uoTWRUYCEUse
         HgRDKRNuUinWOzvS+m6+rOJdtBobN7gXXvl6n5EjBSvZcbsiG5j7ZtRfLl9sEVqxBA4A
         MhSha/ekLBeAfQkKaFB4WaAl2TMCROwgUJ3q1b6F0gT816qU2KyK/0oz/F5JxArVzkz7
         QHMnddg2SCqYK0WRFBO/eSIfUfUc5vgRwrsBEBR3DSEH+3e2wO8Fx3kgrBfgyzacWM+P
         ZVJA==
X-Gm-Message-State: AN3rC/4TxOymrQjjmGqenKYeTOI334nc8j9RLVcfICzjQjrKUKssNqlb
        QD02mMdd572e9Q==
X-Received: by 10.98.149.196 with SMTP id c65mr1842796pfk.37.1493238679955;
        Wed, 26 Apr 2017 13:31:19 -0700 (PDT)
Received: from google.com ([2620:0:1000:1301:a06e:d212:7b5:7817])
        by smtp.gmail.com with ESMTPSA id r90sm253517pfl.120.2017.04.26.13.31.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 13:31:18 -0700 (PDT)
Date:   Wed, 26 Apr 2017 13:31:16 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] sequencer: require trailing NL in footers
Message-ID: <20170426203116.GA37189@google.com>
References: <20170421220155.GA142345@google.com>
 <20170425190651.8910-1-jonathantanmy@google.com>
 <CAGZ79kapU5AL_iPJXCavCKAQ0Fw=pqWZS4F6Vri-Q1M1WMVs_w@mail.gmail.com>
 <f49a858b-26da-7e8c-e0f2-8d66158f016a@google.com>
 <CAGZ79kbhxjO-tFW4_kObTZiauetjsgY1NBSKvo1NV5nKNEy2xA@mail.gmail.com>
 <20170425223056.GA104886@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170425223056.GA104886@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2017 at 03:30:56PM -0700, Brian Norris wrote:
> On Tue, Apr 25, 2017 at 02:56:53PM -0700, Stefan Beller wrote:
> > In that case: Is it needed to hint at how this bug occurred in the wild?
> > (A different Git implementation, which may be fixed now?)
> 
> I might contact the original author

Original author was using 'stgit', FYI.
