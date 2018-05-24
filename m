Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA84E1F42D
	for <e@80x24.org>; Thu, 24 May 2018 23:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966970AbeEXXau (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 19:30:50 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33678 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965649AbeEXXat (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 19:30:49 -0400
Received: by mail-pl0-f66.google.com with SMTP id n10-v6so1971982plp.0
        for <git@vger.kernel.org>; Thu, 24 May 2018 16:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lll+y1SZmkSCmtcb4R1Z2TKX+TIc+/yy5xaYfDN8RGQ=;
        b=az9zUECZe7bWKJYBQvc+nkvHCWdhojmYLM4RHhgWlj0ZejH5mxymR1aBCODRX+qQle
         IU52K+TXGs8G6pADvojh1O7+ZRvIK2W/7FtSHRMxPx4G9tOdcGp9Yybg9vEvXBHBxcyB
         F0IPo38HcW2v3roLAXiuXhmbHkzeigHHSWPtc3ni7NLbSA46RbAUyYDSrafBwtSlZDQs
         LiXjMtQ5wpHLzEpxTfakoehRQCsexj+Xw9W36yIcSH6em3R6fx4QoEILuqIUeTTHPGma
         m6hb/PJM36YSvFgQf7fBBu2DsUUUnKwz+cDph+Q+I0bIKbD9CrmitE3YrjBw/PXNGFgN
         Nt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lll+y1SZmkSCmtcb4R1Z2TKX+TIc+/yy5xaYfDN8RGQ=;
        b=qL9HhyB7FdrZA77w3QKzcFBK6SK9Csk4m6RfaGPiJFCRzB1nLoI1RVvxHI8Djtb0CZ
         lNvCg9Qj4z5D3zT3Wb1/PGRgSOXwGlM6lmfb4ygVm8oPDC171cbR40073eU7GOOY6m7c
         WlHvok3d4WvYoejen3QktYKYIpB3w60EkynIMS1YB2lSmvOMNKoV/nIVCago3xX+nKFq
         eiMMUznbmRTmx+st81uftAPAz2PJOqRc4ipWe6u8p0DuNSZgpsLCIMdus2bY4azyO/je
         JLCG185EaTeilIADCZ16JyLr5iOq+Fh/AXZWa8GQg05kMaN3htzAln9aeeM+ckxI8drf
         7KfQ==
X-Gm-Message-State: ALKqPwffg6X7fLJbk6tf7ooZyvd1uR/q/5X/sUtwstPKl2A4e/ulstQz
        jRkKNrbj2+0Z8I5kiadCRSGkpw==
X-Google-Smtp-Source: AB8JxZqIZMoIWkc0sxATaj91OxwvE85NyjRoKlLbNglYRVXFNtpmKYgb7A2JEjgwKzPQG+aycl4E4Q==
X-Received: by 2002:a17:902:42e4:: with SMTP id h91-v6mr35306pld.27.1527204648511;
        Thu, 24 May 2018 16:30:48 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id z131-v6sm33029546pgz.86.2018.05.24.16.30.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 16:30:47 -0700 (PDT)
Date:   Thu, 24 May 2018 16:30:46 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH] submodule: do not pass null OID to setup_revisions
Message-Id: <20180524163046.e0d892430657b025db82c762@google.com>
In-Reply-To: <CAGZ79kbB-8dbO5QjpG-G+9uRpa1m-_oypfw=kRFu__Ws7FV0Xg@mail.gmail.com>
References: <20180524204729.19896-1-jonathantanmy@google.com>
        <CAGZ79kbB-8dbO5QjpG-G+9uRpa1m-_oypfw=kRFu__Ws7FV0Xg@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 24 May 2018 16:07:49 -0700
Stefan Beller <sbeller@google.com> wrote:

> Hi Jonathan,
> 
> On Thu, May 24, 2018 at 1:47 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> > If "git pull --recurse-submodules --rebase" is invoked when the current
> > branch and its corresponding remote-tracking branch have no merge base,
> > a "bad object" fatal error occurs. This issue was introduced with commit
> > a6d7eb2c7a ("pull: optionally rebase submodules (remote submodule
> > changes only)", 2017-06-23), which also introduced this feature.
> 
> Ok, what should happen instead?

Just for there not to be this "bad object" error.

> > This is because cmd_pull() in builtin/pull.c thus invokes
> > submodule_touches_in_range() with a null OID as the first parameter.
> > Ensure that this case works, and document what happens in this case.
> 
> By documenting you mean adding a test, i.e. documenting it for the
> developers, not the users.

I also updated the submodule.h file, but yes, it is for the developers.
I'll change the commit message to make this more clear if I need a
reroll.

> I inserted a test_pause here and inspect child:
> * the submodule is the same as in parent, so this patch is
>   just testing it works with submodules the same?
> * No, the submodule is not cloned into the child
>   at all. So we do not know what do do with the submodule.

Yes, this test doesn't do much. I just wanted to make sure that
submodule_touches_in_range() could be called without encountering this
unrelated error.

(Incidentally, we might want to add tests for the "cannot rebase with
locally recorded submodule modifications", but I haven't looked into
that.)

> However this patch is about making sure the superproject
> works out well, without this patch we'd have
> $ git -C child pull --recurse-submodules --rebase
> fatal: bad object 0000000000000000000000000000000000000000
> which is to be avoided.
> 
> Yes I think this is the best way to fix the issue, I thought for some time that
> could first check if submodules are initialzed or active, but these
> are checks are done afterwards, so this is ok.
> 
> Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks!
