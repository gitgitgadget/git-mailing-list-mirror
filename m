Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D13A2018A
	for <e@80x24.org>; Tue, 28 Jun 2016 13:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbcF1NXI (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 09:23:08 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35219 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbcF1NXF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2016 09:23:05 -0400
Received: by mail-wm0-f54.google.com with SMTP id v199so139704869wmv.0
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 06:23:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rLBNZSZr+tefGYySXW+5oh1MrvvyxaX6lkE8h/uq+rQ=;
        b=uwUEmgNO5YPlFjYXAPZrMAR6/NrQExfsktCYhFWnu/v2oqOl4+xnxA5tLezEN8QquG
         Wo1KFx+sVL5pyyc2LUMV7v5l7doTsdkDemae1tbNZtONQkiPT7e12qmJrANJOgWP0dP9
         pndwdW/RQWFtAGwmtwq9qhZ43to8krY8XwIRHM0PMmUcCnGHyHVjMl3Pk3TmA/iLu1Yq
         NaoK+ht0kJpFCf9gaXCYaH7TX7N9xeM/WHcmiwy9wEokbJwTBZ3guoo8fRAmjl93Nwn/
         XdcmTYLOtVzI2ClZNFCfKCfKOESEyHP99eiY1tVEmA4cGtKgNn+/YOZbJL+ctnnJ2FH1
         ZKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rLBNZSZr+tefGYySXW+5oh1MrvvyxaX6lkE8h/uq+rQ=;
        b=Wfq7P1M9ehRJmBGaEChGHyIVt584PftrlinLRK8gQUX1fUNqIfFiEDDZ1WnOT2zDWf
         HTGVMWJWt8wzH0VX8i0Luu1iV943INtbcRAbVCImB+Dv1QHRC7fMgJV/ixy4byDunCkQ
         YCovqCw2KnlnDBKVWXXZ4swF5yr6OGqDC8T7wxOsltFFPVv94unW2gLXzi9NyzTxEMMC
         laJ2nXW0LKGynviQuOsgqIV5MU3ZPOesqVKiMm4LXrPVA95TICyLVOljUjbAQYVT4WuF
         bPd7ZLlp4eUV+tSOUL331+9JUSEtWam3kn/cx2dgt3GKVWdeyf6dkOMkQSgYVG/4mL0C
         JXnA==
X-Gm-Message-State: ALyK8tLwVXWitpLTmmLjWI2TW3kQm6VGvDKcQjON3UP4/FxBt/11q/cDVbUeX5ESOji/jw==
X-Received: by 10.194.222.137 with SMTP id qm9mr3490815wjc.80.1467120183959;
        Tue, 28 Jun 2016 06:23:03 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id r130sm5020140wmf.20.2016.06.28.06.23.01
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jun 2016 06:23:03 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC] Native access to Git LFS cache
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqmvm6bom5.fsf@gitster.mtv.corp.google.com>
Date:	Tue, 28 Jun 2016 15:22:59 +0200
Cc:	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Jeff King <peff@peff.net>
Content-Transfer-Encoding: 8BIT
Message-Id: <9603B6F9-3BEF-4779-84C3-6DC61D7FBC46@gmail.com>
References: <1467005913-6503-1-git-send-email-larsxschneider@gmail.com> <xmqqmvm6bom5.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 27 Jun 2016, at 18:09, Junio C Hamano <gitster@pobox.com> wrote:
> 
> larsxschneider@gmail.com writes:
> 
>> Unfortunately that fix helps only with cloning. Any local Git operation
>> that invokes the clean/smudge filter (e.g. switching branches) is still
>> slow.
> 
> Do you know where the slowness comes from?  Does Joey's new
> clean/smudge interface help GitLFS?

I am pretty sure the startup time of the external clean/smudge process
causes the slowness and consequently I don't think Joey's patch would help. 
The following tests makes me believe that:

I ran the same test as in my original email using the repo with 15,000 
LFS files. Instead of the LFS binary I use the fast and simple shell 
built-in `true` command:

$ git -c filter.lfs.smudge=true -c filter.lfs.clean=true clone https://github.com/larsxschneider/lfstest-manyfiles.git
$ cd lfstest-manyfiles/
$ time git -c filter.lfs.smudge=true -c filter.lfs.clean=true checkout removed-files

real	0m47.030s
user	0m29.521s
sys	0m16.993s

It still takes 47 seconds to switch the branch. Does this test prove my
point or do you see a flaw in the test?


> You are not likely to get anything that knows that a blob object may
> be named as anything other than SHA-1("blob <len>" + <contents>) to
> Git core.  The remote-object-store idea that was floated by Peff and
> Christian started running with at least maintains that object naming
> property and has a better chance of interacting better with the core,
> but LFS, Annex or anything that would not preserve the object naming
> would not.
> 
> Personally, I view a surrogate blob left by LFS in the tree object
> and filtered via clean/smudge a "smarter" kind of symbolic link that
> points outside what Git controls.  The area outside what Git
> controls is left to be managed by whatever the add-on does; Git
> shouldn't even be aware of how they are structured and/or managed.

I understand and somewhat anticipated your point of view. I will try
to find a less intrusive solution.

@Christian/Peff: 
Is there a place to look for more info about your remote-object-store idea? 

Thanks,
Lars