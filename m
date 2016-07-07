Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAC0C2070D
	for <e@80x24.org>; Thu,  7 Jul 2016 17:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbcGGQ74 (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 12:59:56 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:37212 "EHLO
	mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482AbcGGQ7z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 12:59:55 -0400
Received: by mail-it0-f43.google.com with SMTP id f6so24384992ith.0
        for <git@vger.kernel.org>; Thu, 07 Jul 2016 09:59:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n1TT7lO0GdffYHTJa62k76CGErlZkRnxwAK1/F8vsVg=;
        b=b9XZF4yV51fQL6ltxXNwnnH4BGaeoSH35IymXLfSo87ZQtK9VBnpuQv1+jqmH/QEMD
         3tZ5VzPkiTgPAMergemT0pMkQc8H5OSWJlBGOUYhn17ZSZu8O76OUIfGye9GWmF5zdEM
         CNDPXs1FS4IbdGbRZjXNG3wF9UJPI4xxBBVRuY9bgfyzJqE6/OLTRP3ZHWiOuzNBqnUp
         I7WXha/0Iy2GmTConXeVgD0paChPQNwXcMLek9zxh/PWF0KhmNQS1q5qbaWxib/G/TTN
         Itjw6tTAxcg91MdVAKiCP6SFokWOjxhQLSoV15V+5QzFd8RGg/93XKNAXN/3PFgFACj8
         J76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n1TT7lO0GdffYHTJa62k76CGErlZkRnxwAK1/F8vsVg=;
        b=d2MV3xUVbHdF3dA/i032MvXMvMwml2TYT+4JUxYnCafJtcx7Jx15yAaGnL8gpiQBRU
         I6so4CMCSUKh+r701Jg/AmXg81B2ocXKrtCMlT572Rz/KvwuNDCgDOqsaf9fdRnO9tkW
         /HXNils91guUV+I8UlsDnbz2GFdQrRkvZnvdMd0sm7F3Xhp8nv89KUUvybV/6mZElEHv
         w7iuPzMjJRv4RBmnPS1jV8/+3oAXL+vU+vKm1H1N5UEx3P3j/N6q89jSuF0LRUM8K6ru
         ijnwvXF2LVKZqzQehU9IAVGvPVIElJZowjc6PHDpBqWeTTxwNwyqWrlwE/8ogK4sv478
         ZwIw==
X-Gm-Message-State: ALyK8tJRtmmbJnYzo7YPslrF1XrQsh7XnAE65QoeltUUgWimI83qX/B/v20tVHpfMBVDf7X2FAK/U9lasvF8Eq/W
X-Received: by 10.36.95.146 with SMTP id r140mr4029787itb.49.1467910793926;
 Thu, 07 Jul 2016 09:59:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Thu, 7 Jul 2016 09:59:53 -0700 (PDT)
In-Reply-To: <CA+z9LHJmjz2DWgRAJaO29YyeEcxpSuDSFPnCJPRTnHoVMisOvQ@mail.gmail.com>
References: <CA+z9LHJmjz2DWgRAJaO29YyeEcxpSuDSFPnCJPRTnHoVMisOvQ@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 7 Jul 2016 09:59:53 -0700
Message-ID: <CAGZ79kb+Bns=Hh0zK5EJgmV60dRED21M+AgPu+hx-KyL4JXZ6g@mail.gmail.com>
Subject: Re: bug: depth 1 and recursive update of submodules broke in 2.9.0
To:	Stephanos <spapanik21@gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

See the discussion and bug fix at
http://thread.gmane.org/gmane.comp.version-control.git/297687/focus=297719

This is a known regression in 2.9.0 and the fix is in the master branch already.
(I think Junio will also roll it into 2.9.1)
