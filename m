Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B8382018E
	for <e@80x24.org>; Fri,  5 Aug 2016 13:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161222AbcHENIh (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 09:08:37 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36737 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161167AbcHENIg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 09:08:36 -0400
Received: by mail-wm0-f67.google.com with SMTP id x83so3703423wma.3
        for <git@vger.kernel.org>; Fri, 05 Aug 2016 06:08:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ErVU6Rgfusk/pNp98DCVaLoE2nIIwHBHEwBPGUMidis=;
        b=QS9Tcvc0Zqqfrkg906YOWeCLYcywcdV1xlwPsE5juWQOOCE0JmC2Mr9Ava2tJLpPaE
         iRId6g8i2z0rh+bQg/W3wZGGAqgJQuDiV0dQ5FMSZmKjkjN2o6JCW+qQPCMMc6LzqosS
         Z0LuDmLsS5FBIDWYecRuW9f7QLHBim+mFSbK8SpkGAtb+sZaH83iOl/N8W512fApbJlZ
         M4HdsFhfuEqYS7NtVxW6D0K1+BGLr6MvEnvNFaBcFuyce6MHkmIpOvpHM1BHOQSbOUZj
         LHf4kr6L4aehKWn11R0/Jot074UDTjvGTE1DRtFnhTKCgxdy/w3sibZbAxf1Ih+UpaXN
         PMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ErVU6Rgfusk/pNp98DCVaLoE2nIIwHBHEwBPGUMidis=;
        b=QBMceeE8jesEwnyKgKYJLtUXZdlHywuO6Fo4rADcAOd4eODX18Fm9+CrBnbFSAoTbH
         pOp6IQqtoxbTZ7as8aRvBM7+13coW9fN+FVfpsCKaQiLBTt6f2n6IFmZFj4w0ifJ1cnP
         FQ6cnbc62aceavggjCd4FeJJa48TKAqPwd/PvuOZun+6a1BbsHAw2m030K1pD9sS/Xu5
         36f2lOwTkaSD5xOSepDchXIj2yXqt03PfujIG2zWJ8Ldea2j7X++U1FZ9cgeoUoijnAt
         pBVczxiW1DBR1dlPkMXPk8QXXI2gVkpfsVh6tHXAFnQIfNe1jL3us94hwLMVR/EwyUXx
         lF8A==
X-Gm-Message-State: AEkooutj0DocDtKmtYYuQ834hdi/oYrEiKq3eJnRC3255dbJKBRcvEzxfhAjzKRn/5V3/A==
X-Received: by 10.28.221.8 with SMTP id u8mr3269513wmg.61.1470402514962;
        Fri, 05 Aug 2016 06:08:34 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id k3sm17801960wjf.7.2016.08.05.06.08.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Aug 2016 06:08:34 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 07/12] run-command: add clean_on_exit_handler
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160803231506.h5mo5lah2pgwdvip@sigill.intra.peff.net>
Date:	Fri, 5 Aug 2016 15:08:33 +0200
Cc:	git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	tboegi@web.de, mlbright@gmail.com, e@80x24.org
Content-Transfer-Encoding: 7bit
Message-Id: <6C522B0F-F8F7-4B51-8BF0-67D9EDC97B3B@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com> <20160803164225.46355-1-larsxschneider@gmail.com> <20160803164225.46355-8-larsxschneider@gmail.com> <20160803212433.zzdino3ivyem5a2v@sigill.intra.peff.net> <826967FE-BFF8-4387-83F7-AE7036D97FEC@gmail.com> <20160803225313.pk3tfe5ovz4y3i7l@sigill.intra.peff.net> <74C2CEA6-EAAB-406F-8B37-969654955413@gmail.com> <20160803231506.h5mo5lah2pgwdvip@sigill.intra.peff.net>
To:	Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 04 Aug 2016, at 01:15, Jeff King <peff@peff.net> wrote:
> 
> On Thu, Aug 04, 2016 at 01:09:57AM +0200, Lars Schneider wrote:
> 
>>> Or better yet, do not require a shutdown at all. The filter sees EOF and
>>> knows there is nothing more to do. If we are in the middle of an
>>> operation, then it knows git died. If not, then presumably git had
>>> nothing else to say (and really, it is not the filter's business if git
>>> saw an error or not).
>> 
>> EOF? The filter is supposed to process multiple files. How would one EOF
>> indicate that we are done?
> 
> I think we may be talking about two different EOFs.
> 
> Git sends a file in pkt-line format, and the flush marks EOF for that
> file. But the filter keeps running, waiting for more input. This can
> happen multiple times.

Correct.

> Eventually git calls close() on the descriptor, and the filter sees the
> "real" EOF (i.e., read() returns 0). That is the signal that git is
> done.

Right.

> 
>>> I'm not sure if calling that "shutdown" makes sense, though. It's almost
>>> more of a checkpoint (and I wonder if git would ever want to
>>> "checkpoint" without hanging up the connection).
>> 
>> OK, I agree that the naming might not be ideal. But "checkpoint" does not
>> convey that it is only executed once after all blobs are filtered?!
> 
> Does the filter need to care? It's told to do any deferred work, and to
> report back when it's done. The fact that git is calling it before it
> decides to exit is not the filter's business (and you can imagine for
> something like fast-import, it might want to feed files to something
> like LFS, too; it already checkpoints occasionally to avoid lost work,
> and would presumably want to ask LFS to checkpoint, too).
> 
>> I understand that Git might not want to wait for the filter...
> 
> If git _doesn't_ want to wait for the filter, I don't think you need a
> checkpoint at all.

True. However, I wonder if it could be useful if the filter is allowed
to do some finishing work *before* Git returns to the user.


> The filter just does its deferred work when it sees
> git hang up the connection (i.e., the "real" EOF from above).

Yeah it could do that. But then the filter cannot do things like
modifying the index after the fact... however, that might be considered
nasty by the Git community anyways... I am thinking about dropping
this patch in the next roll as it is not strictly necessary for my
current use case.

Thanks,
Lars
