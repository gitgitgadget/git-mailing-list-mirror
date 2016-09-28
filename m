Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0545220986
	for <e@80x24.org>; Wed, 28 Sep 2016 04:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbcI1Eq0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 00:46:26 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33357 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbcI1EqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 00:46:25 -0400
Received: by mail-qt0-f193.google.com with SMTP id z36so1014049qtc.0
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 21:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nuTP1e9FUvALwgIpvbHWGboY9+oQsFSG/FoZdwev0V0=;
        b=dwLmsRv/WTfF0fWvQZvl2Kg2q5yQ4hfSbdLrHFussFcsoGYtAfuekpS4shF+9FVZ6T
         R4rrHu63pfzCBdV8zV3RDm2mq3jPMrWx7YG5aJwNlFU3nYwO+ZnzGTxd6+iFBAaGCgjx
         mRhkmU7b+BlVeCjTUL5+q07KEoj5xueaYiNWuvw3Eimsh43ZJbtiNmsyN8mVwvAEwMi1
         308biR2vcet7UHGl8zP3Nwl+EJR3IsWw3elZdnwbvd3TSMVotQd8kxl1uaOmWJaYcOF8
         WC83dGlM5v4+5WZOiRJW8qnrdR0DCCSEMv4YZ1CAXaYWkgzDeLGg2J8UrDQt+gr87SBR
         Kimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nuTP1e9FUvALwgIpvbHWGboY9+oQsFSG/FoZdwev0V0=;
        b=NoaSaUrlNseYL2cF+iGIv55c1pUk/TgdCLa5Zr32lMuFUTrVwnVWGd8PlU87fVYrAc
         NVSzbRnPVY72GRoQnRqd4E59Tj1YexJMAnHQnyLkDGTPvDabL1n9KGWfedrU2KxuMmCz
         w4eMbubk/7DhJUrCaNpoQH7L4y7RziPA2fmrjUW1VjVFLaOT8Ge3HnZHwsAfysEptIGV
         Ju7tUEII1P0pB3rHhbhNsjkf9MlIce7K8Jixz8ARdlqqAEkDj/kV8ZghGF77fIvmUEnq
         3HxAenxjUg8OcPKxUAE17bvwaWoRrQfB1Rl5L5D3igIBMd8b5CTbj/YUJ4CF3d8MWRn5
         4eNQ==
X-Gm-Message-State: AA6/9RlPQfndJTmHAXP4mKZKWOcnNJjw6WoQj1tlYJ7HqcR5160CpMFL/FcOEZNnItt2XA==
X-Received: by 10.237.57.136 with SMTP id m8mr5198339qte.12.1475037984409;
        Tue, 27 Sep 2016 21:46:24 -0700 (PDT)
Received: from kwern-HP-Pavilion-dv5-Notebook-PC (ool-457850cc.dyn.optonline.net. [69.120.80.204])
        by smtp.gmail.com with ESMTPSA id v10sm3052438qkg.20.2016.09.27.21.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2016 21:46:23 -0700 (PDT)
From:   Kevin Wern <kevin.m.wern@gmail.com>
X-Google-Original-From: Kevin Wern <kwern@kwern-HP-Pavilion-dv5-Notebook-PC>
Date:   Wed, 28 Sep 2016 00:46:22 -0400
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kevin Wern <kevin.m.wern@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 10/11] run command: add RUN_COMMAND_NO_STDOUT
Message-ID: <20160928044622.GE3762@kwern-HP-Pavilion-dv5-Notebook-PC>
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
 <1473984742-12516-11-git-send-email-kevin.m.wern@gmail.com>
 <xmqq37kzigvf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq37kzigvf.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 16, 2016 at 04:07:00PM -0700, Junio C Hamano wrote:
> Kevin Wern <kevin.m.wern@gmail.com> writes:
> 
> > Add option RUN_COMMAND_NO_STDOUT, which sets no_stdout on a child
> > process.
> >
> > This will be used by git clone when calling index-pack on a downloaded
> > packfile.
> 
> If it is just one caller, would't it make more sense for that caller
> set no_stdout explicitly itself?

I based the calling code in do_index_pack on dissociate_from_references, which
uses run_command_v_opt, so it never occured to me to do that. I thought it was
just good, uniform style and encapsulation. Like how transport's methods and
internals aren't really intended to be changed or accessed--unless it's through
the APIs we create.

However, I don't feel very strongly about this, so I'm okay with this change.
