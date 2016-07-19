Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B9751FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 17:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647AbcGSR1q (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 13:27:46 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:33978 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752961AbcGSR1p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 13:27:45 -0400
Received: by mail-io0-f178.google.com with SMTP id q83so25351024iod.1
        for <git@vger.kernel.org>; Tue, 19 Jul 2016 10:27:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iyfU/+DjbcInHJgEsKvxgmp0CT/sDnEGSD6YVockSUk=;
        b=vAfREDOu9KdeXQ0sgd4kthCjo+Nmosg3U4dZwN+xbmk7kLmgxPEIek4jPrOWFVVgOM
         JmvO+Huc4pSP4xbPBS7FJlTsjXCWhJ2Z8cMTGB/9BVyFflkH0zTOkqJZB/3XhRmm8oeb
         Ckxs/IPeoZTw88IBGJq1ncBEfgdH7xaoUvy+uEPw23BNxP95MiTT3qSLmpHoLB8dFtDF
         cUUv+hszVHW1k8CAmvqpjWgIPj6Vipaz6kXVlH5fKZoHmcQaNrQWZtlzH+DWYmlOVT/x
         fzba+VB35kvhgoChBQCLdcUbd3hCcdASm/5h7Kazb01ahrWglGXnLVaI8PDlPJ4nxpgU
         yQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iyfU/+DjbcInHJgEsKvxgmp0CT/sDnEGSD6YVockSUk=;
        b=LtbnOs/YdCLDpAuXvF6P7GjUN6oBheD1W20ir+mmBpDZton0deob4WIasHd2QD32is
         0VeP6lUpdxPGnbsSoiULyUMek/ISQ9EbaUJcDEZICMA0rMVRjIvlOh9w+V9FYSWFC46x
         I8f8yLwE/O6frvYlEFnbcMbF3IR24RNaD7gdZklfZp/aExlNJL2DZwogJTrRQsGIUjeP
         C+BSkMHgubdqG6Xy5OKcx43UoXc7JxFtwfXxadWyoAxXiY7XqnmCK0QgsHS8IKd3tYFz
         m73qe3XhwgzOy/98GX8RO/W4Jd5wILkfnh0d7o43Q08pD0MmMH8PtgHA8soQ9HXPL6ec
         ekAg==
X-Gm-Message-State: ALyK8tKFC04HjfsSMxDzrL60XrwgI+CkM1hGe5l2Ul5xQ4yRuUKhXW58XR+unHyrK6Ppy2o0+/s8hC5MAEptYw==
X-Received: by 10.107.159.147 with SMTP id i141mr11738797ioe.29.1468949251771;
 Tue, 19 Jul 2016 10:27:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Tue, 19 Jul 2016 10:27:02 -0700 (PDT)
In-Reply-To: <xmqqk2ghh80x.fsf@gitster.mtv.corp.google.com>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
 <20160716201313.GA298717@vauxhall.crustytoothpaste.net> <alpine.DEB.2.20.1607170949360.28832@virtualbox>
 <20160717142157.GA6644@vauxhall.crustytoothpaste.net> <CACsJy8AH9Q6rOgvcWGsLGPaP96koGA=k0PYgXP6F3RZ=XAwaSw@mail.gmail.com>
 <CACsJy8CR_fkYL5UYbV1MqiTSe3gTqWfOrA1NOHTw09vZn7Y-Aw@mail.gmail.com> <xmqqk2ghh80x.fsf@gitster.mtv.corp.google.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 19 Jul 2016 19:27:02 +0200
Message-ID: <CACsJy8DyybW5kTWZ2nJ4GN=S46M9rU0EapOrR6PjSV=b1ZFrBw@mail.gmail.com>
Subject: Re: Git and SHA-1 security (again)
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Herczeg Zsolt <zsolt94@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 19, 2016 at 7:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> Post-shower thoughts. In a tree object, a submodule entry consists of
>> perm (S_IFGITLINK), hash (which is the external hash) and path. We
>> could fill the "hash" part with all zero (invalid, signature of new
>> submodule hash format), then append "/<hashtype>:<external hash>" to
>> the "path" part. This way we don't have to update tree object or index
>> format. And I suspect the "path" part is available everywhere we need
>> to handle submodules already, so extracting the external hash should
>> be possible...
>
> Even though that single operation might be possible, do not go
> there.  A "pathname" identifies a "path", not its contents, and
> "appending crap after path" breaks the data model badly.  Also other
> things like merge, checkout and diff would break by butchering
> ordering the entries in tree objects.

I thought about that but I thought all those operations required
special treatment for submodules anyway. But I forgot about d/f
conflicts so yeah it's a bad idea. We still have some invalid "mode"
combination that can be used as S_IFGITLINK2, then we can have
variable length hash field in the entry.
-- 
Duy
