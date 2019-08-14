Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 154201F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 21:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfHNVUn (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 17:20:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37739 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfHNVUm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 17:20:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id z11so440776wrt.4
        for <git@vger.kernel.org>; Wed, 14 Aug 2019 14:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pga9OhYXFPepdn09cleGnhVBnP9JISrmPPv3eCeJMgw=;
        b=RbJhug1HJTVMCswkYDf7O/VshoVitqzWjAH/YqW6+7pFTOZsK6KEdJv59Qhd2hDrqa
         zl/7pH8vxgAVWxGDQRpSLDYG+i06p8j9YB5oVVNlXJQw+dTu57l59jxkG/LGCA8vjXWU
         xcAV4JM/Q55j7vzPph5LrO1WxgZJ+mYIBP4Tcp1zqMack+oP3V/9pLm7iB7q4lLeVf4j
         yOtSL6raEMAtu3sILBc4xz9GkyTsHI4sqWEwaOtxd9piCykFp7K+1clr1g7U4j3aWOsm
         aHOkLV8pssagBmL6eRpZTI5Pbu8W7D3vfvnDC0Ms/bjDyc8m0DSky3EuxCx01VQuSSO1
         HGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pga9OhYXFPepdn09cleGnhVBnP9JISrmPPv3eCeJMgw=;
        b=onpXkClIZ5y8nh4A7pMjyNduizDxR6dbtJYiDOB7qKSPtpQEJWcB2nE3ytSSXGoRj8
         31MATChFg5CFLpEZ6/Sc5JLh8OZQhGui9tdrK8wZsJKzxLhLBjK1CMj6+LPXmNaoEKL+
         CxQIdn7ogFbkqWjQ8K1HMxLu0SJI5Fb4xpF8zdnn2ThuZmOUwWVhbjdDT9tTCBWaipdi
         C0CP8omFrvleonmMh2pOOxTfJh8lQG8HcrDH9OjDWw1jPt2rJKMDDcyXQrQlZKBZ9OJH
         w+sDLwDr9pxtGXduMf27SnqVsuV+LdXnhMLHmrE+pwn+vwX5TxQ/Pyji0pjoXXgq6l7s
         UB+A==
X-Gm-Message-State: APjAAAX8SObylOisGfrPTk93gY63TENdoKc4ysAqVE1zwRJp7NVg3xeW
        c4yr3zvrCtjCyiAhsPEQ/skM7AZo
X-Google-Smtp-Source: APXvYqyYW5lh5b22DqIEuQueH+xnR4q4g1I+WajzvVAmZyFzALowd28Z2NTfOCTlUYSmGyPd4B/QIQ==
X-Received: by 2002:a5d:4083:: with SMTP id o3mr1700613wrp.150.1565817640519;
        Wed, 14 Aug 2019 14:20:40 -0700 (PDT)
Received: from szeder.dev (x4db5324e.dyn.telefonica.de. [77.181.50.78])
        by smtp.gmail.com with ESMTPSA id q20sm2113028wrc.79.2019.08.14.14.20.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 14:20:39 -0700 (PDT)
Date:   Wed, 14 Aug 2019 23:20:36 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: minor interactive rebase regression: HEAD points to wrong commit
 while rewording
Message-ID: <20190814212036.GQ20404@szeder.dev>
References: <20190812175046.GM20404@szeder.dev>
 <2a7d69a9-cb3e-eb84-188f-5713876f6d78@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a7d69a9-cb3e-eb84-188f-5713876f6d78@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 12, 2019 at 09:28:52PM +0100, Phillip Wood wrote:
> >Save the updated commit message, and after the editor opens up the
> >third commit's log message, check again where HEAD is pointing to now:
> >
> >   ~/tmp/reword (master +|REBASE-i 2/3)$ head -n1 .git/COMMIT_EDITMSG
> >   third
> >   ~/tmp/reword (master +|REBASE-i 2/3)$ git log --oneline -1
> >   c3db735 (HEAD) second - updated
> 
> As second has been updated the sequencer cannot fast-forward to third so it
> cherry-picks third and then passes --edit when it runs 'git commit' to
> commit the cherry-pick. HEAD is updated once the reworded commit has been
> created.
> 
> I think the scripted rebase always ran cherry-pick and then ran 'commit
> --amend' afterwards if the commit was being reworded. The C implementation
> is more efficient as it avoids creating an redundant commit but has the side
> effect that HEAD is not updated before the reword which was surprising here.

I'm not sure about this more efficient thing.  I mean, 'git rebase' is
about to launch the editor to let the user type something...  Compared
to that the time spent in creating an extra commit object is surely
negligible.

