Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DAAA1F803
	for <e@80x24.org>; Mon,  7 Jan 2019 23:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfAGXN3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 18:13:29 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169]:38658 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfAGXN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 18:13:28 -0500
Received: by mail-pg1-f169.google.com with SMTP id g189so816970pgc.5
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 15:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TxGQxKEWRySHGIDRtIMKFAt9a2l9PJUfIsPWixzCyq0=;
        b=Q1X9grXGlJFbPbZ7udYTjstqcf++GKBYVUAHfvbj1vqU0DunyuzKvjh8UFVFnnrj0L
         gPzaNlEpfts8rovoBI/u0r2TP4b3Wf68y66o2/vSllXl/v3WM8cy7pJnv+qKTnc0L43K
         adzBxFTgNWN1wz43t+qnQM1SXWsRnWDgGEe9KcD/1KsMPRGqtvHbgNO0rX4fvyWaI0AI
         tnygBc63o6sV727PRZtd4/XAy0JJ2sT7Rux2Ltqz81DbPSGGe4boRg+rf7VZDdSbEMXd
         Z/vQmGPsytb67dwrGRx5NTU6xIdVr6qO8BT82nw+ZhPhekWmGSSGRDHZBsqcvCBxVBTg
         3a1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TxGQxKEWRySHGIDRtIMKFAt9a2l9PJUfIsPWixzCyq0=;
        b=aEnZCzr6fEZYa1gnuXDmhwGBosVmaKgkknRft2Bbgroj9zecA4igOcDwQTZB51EjHF
         rSpvLkvre61rkkjoV0JbM1AHxuLtDG2V7J9wpXeXd65cdI/xB3G38RPSMugnrvEJDFrH
         6LL8fWvgRGIJMczLJzq0R12Mt0sNVYMhmvZVa9JwI6lWACSTU+F1s+SMbiCRYYsSE2d/
         LXeVsx6e8+XPgHBSimSNFi9PQ4zQqmH2VIJ1mCGibYXcb4KOQ5M1y3qlc4q01hrwJhMG
         wcfcaJ7IMtWabg2ySuLqCN6SkBrRFxWoXAOSRczMzksM6FvKBoOUY3UTvZOxSq06EBep
         hieQ==
X-Gm-Message-State: AA+aEWazY7sY5FDNaif0Co6c71hl9mknrOpGq0omKGWcEOld+ESfGo2t
        hP0TylWXcomDx+W6BFmGReTliHsM
X-Google-Smtp-Source: AFSGD/WEPvvwc/op2kkpVK6M8jGnli/W57W1E5NWsTDvQuXxFQcMvMWXP1c8UmGnILKZ1G4fPHMHVQ==
X-Received: by 2002:a62:3305:: with SMTP id z5mr65888773pfz.112.1546902807891;
        Mon, 07 Jan 2019 15:13:27 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id k24sm103588575pfj.13.2019.01.07.15.13.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 15:13:27 -0800 (PST)
Date:   Mon, 7 Jan 2019 15:13:25 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     paduarte <pantonio260@gmail.com>
Cc:     git@vger.kernel.org, users@cvs2svn.tigris.org
Subject: Re: cvs2git failed in pass2 ...
Message-ID: <20190107231325.GC192553@google.com>
References: <1329828722466-7304605.post@n2.nabble.com>
 <1329837442995-7305031.post@n2.nabble.com>
 <1546873568530-0.post@n2.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546873568530-0.post@n2.nabble.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+users@cvs2svn.tigris.org
paduarte wrote:

Hi,

> How did the complete command work?
>
> cvs2git  --encoding=ascii --encoding=utf8 --encoding=utf16 --encoding=latin
>
> or
>
> cvs2git --encoding=ascii --encoding=utf8 --encoding=utf16 --encoding=latin
> *+ parameters of git*
>
> ?

Cc-ing the cvs2git users list, who may be able to help you.

Thanks and hope that helps,
Jonathan

> Tks
> :)
