Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 140CE2018A
	for <e@80x24.org>; Wed, 29 Jun 2016 04:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbcF2EL1 (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 00:11:27 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:34920 "EHLO
	mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbcF2EL1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jun 2016 00:11:27 -0400
Received: by mail-it0-f46.google.com with SMTP id g127so107922895ith.0
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 21:10:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5UpndyYqQivYAjziWSH+aWFcPhQBcgkl0jhpKyjZyEw=;
        b=Ryjji8SuIbuiFjDwH5XIvDxP4DS9idQvdMHn7IHM1Zz5BHOdvwevelj/FU7I8NMl6s
         amjSRrcb74Hf4vVbOZ5EpeOQM0JiTWwxVkpTFXkgkLE4Rtpg129Az9pzV+bo58NGtvzb
         XRG3NOX2JmLbsc3MdxJPpftausq02wvSAZAZJGLQVC876srg4dgspyv6cujNb4JLWlZE
         H/24M3EqNXCxgtJpGzwuUCSxypQPP5sxErGRCU+OueYbZ244Sd/wTDhJ29agwF2nZ0KC
         MuATlXvKBz0DDTGYTvdU4i5Jl9mbmROjA6urrYe+4OpKMgumSNF/heHVDQ7/DH5aKM3S
         eFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5UpndyYqQivYAjziWSH+aWFcPhQBcgkl0jhpKyjZyEw=;
        b=EVZwQgmHVsW+eFn41W3kI7au5u9xcFYI/QNPLSptWznICFd7zWviy5NtQjY9kn+r6/
         uKc0U1M3HgmdDM2KidX+qfZdMgsB52rNFSAuY36InBNay4sBHwe6ZuWtG9UJ/uzFT8qg
         sN/r0NeCe9MB9LFp52z424Bn+MAzleJ9K6QqiBxllshZQAvb/CYMNCvMWHyYfygg0eOz
         tGEi/tjAUcYk0yVftsg0iTLYOO9sp+70LtvsyOyiFdmCVkf0vPXacy8GlJDzFi1QtXpS
         ua76uya3hpjeukr4/6DlDUOuDbRx4gUMlITC6zPTwovES74m3oJuFTAqME2jlBzwP+bH
         NRmw==
X-Gm-Message-State: ALyK8tLJezyONamvgXtrWuOc++dyATwDHll3wa7M2/j4ozHa0oeIHLpXkaCGv5iNUAJC4mA00OMOtVrReAFMTg==
X-Received: by 10.36.80.139 with SMTP id m133mr7801878itb.63.1467173406242;
 Tue, 28 Jun 2016 21:10:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Tue, 28 Jun 2016 21:09:36 -0700 (PDT)
In-Reply-To: <20160628202809.GA21002@sigill.intra.peff.net>
References: <20160626070617.30211-1-pclouds@gmail.com> <20160628172641.26381-1-pclouds@gmail.com>
 <20160628202809.GA21002@sigill.intra.peff.net>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 29 Jun 2016 06:09:36 +0200
Message-ID: <CACsJy8B_Lojr1FScTruPaFsftfhAoGSBnXmC4NjycdVf84JT9w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Config conditional include
To:	Jeff King <peff@peff.net>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 28, 2016 at 10:28 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 28, 2016 at 07:26:39PM +0200, Nguyễn Thái Ngọc Duy wrote:
>
>> There's a surprise about core.ignorecase. We are matching paths, so we
>> should match case-insensitively if core.ignorecase tells us so. And it
>> gets a bit tricky if core.ignorecase is defined in the same config
>> file. I don't think we have ever told the user that keys are processed
>> from top down. We do now.
>
> Hrm. I'm not excited about introducing ordering issues into the config
> parsing. But I think it's actually even more complicated than that.
>
> core.ignorecase is generally about the working tree, not the git
> repository directory, which may reside on another filesystem entirely
> (though I would not be surprised if we've blurred that line already).
>
> I wonder if it would be that bad to just punt on the issue, and say that
> these include-match globs are always case-insensitive, or something.
> True, that does not allow one to distinguish between config for "foo"
> and "Foo" directories, but I find it unlikely anybody would ever want
> to. And if we define it that way from day one, then nobody expects it to
> work.

You already opened a path for this with your gitdir/regexp suggestion:
we could support case-sensitive match with "gitdir:" then
case-insensitive match with "gitdir/i:". Everybody is happy.
-- 
Duy
