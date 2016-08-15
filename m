Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID,
	URIBL_RED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E88B1F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 12:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900AbcHOMxu (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 08:53:50 -0400
Received: from mail-ua0-f174.google.com ([209.85.217.174]:33305 "EHLO
	mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbcHOMxt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 08:53:49 -0400
X-Greylist: delayed 1474 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Aug 2016 08:53:49 EDT
Received: by mail-ua0-f174.google.com with SMTP id 74so71648487uau.0
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 05:53:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=rHa0sta1zwIGmOYUHNkaqGSGm0XWzxhuZ2r/4SrB9Ks=;
        b=wvfdNvjyLr1SKy9WY8a0Coy+Cx7WcfLpQjvLZoe2gKa9YAK2w7VR+y/OQB3V3DLKbm
         2gzLwUnGQrUh4gujCtycxkkiDhzacwG7pmuhpC6lEENJAn3QdRV48ITMiBE+9PBhAZ6k
         5GvFGBlXyhxYCR23YFZx65iYLmgunxzXCFLuqtKe1TP4VJ/wOF/w06kpFH1cg+XNlsFK
         lkM+Ol1pAHE53A59C/69XKfaT7bMArXffNFkESbUfD6yj1n4rOtGkASu82pxF/jWEbUA
         v8x6PxWqWEBji19pf9hdqUotAiGjYJBHl6Ss1XC0ZxgJLjY2ETw+AkbLBSZw0K3yb2uZ
         cDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=rHa0sta1zwIGmOYUHNkaqGSGm0XWzxhuZ2r/4SrB9Ks=;
        b=PWlUW6fkmMtKBXm6wtJ0vaMh3IXY4qzEMrrgVgNeHbtS8AtcB9bcImWeKYN/hPBLpR
         mYrqc77MFqRtd7VZV21KLtW9+eIiUvKwN3gpsl6RZJQFfGXDPBdw3wfetru0yBFHRq0K
         4EncUj20z4NWC4xqN3wJwjogaAmYYpCk9W21/fEUdzPtz9UNnA8x44UHVuyYk2rVsoO7
         BM9uwNKingj+n7/WKWUBNX0ibLjYjNYYXk/l5MT5jsVB2pWf8YYCAAHlwpW8I4dicBGb
         Pqf1SqMApGmIDqSuAOD+xUDgds5/WmGMVqrlowJZSUJ6tiDKOXLodMSy6pG93POJe6uW
         Y+gQ==
X-Gm-Message-State: AEkoousgak57C5hK2UfAYpmZDl8FYEr+4WC47Egjuy8E51Dni9ph0ubfOFB8Js9FDYCfiAJyxZxssolRe68utA==
X-Received: by 10.31.229.198 with SMTP id c189mr10087372vkh.18.1471265628455;
 Mon, 15 Aug 2016 05:53:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.69.172 with HTTP; Mon, 15 Aug 2016 05:53:48 -0700 (PDT)
In-Reply-To: <20160815124725.t6bo5fv4lbbnqnfo@sigill.intra.peff.net>
References: <CAB-zwL28qUBO5PrRznH9KmLJZUHO65_J-DxvPP+NHZEuofKh9Q@mail.gmail.com>
 <20160815120441.nwtdqfgcv3ljt4vl@sigill.intra.peff.net> <CAB-zwL2oFMBFjkkoh1EhSD7FCK_1wVV+whu8uxTKTHQKJgNzrQ@mail.gmail.com>
 <20160815124725.t6bo5fv4lbbnqnfo@sigill.intra.peff.net>
From:	Arkady Shapkin <arkady.shapkin@gmail.com>
Date:	Mon, 15 Aug 2016 15:53:48 +0300
X-Google-Sender-Auth: yXz_Scl8zXnMGTK6avTyAvm7Lhs
Message-ID: <CAB-zwL2P08YC=3Ube8mkZ=mB4xpW6TUnG2gEZKtvRU03eE6ALA@mail.gmail.com>
Subject: Re: Git shallow clone branch doesn't work with recursive submodules cloning
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

So it will work only if github update their server configuration
(boringssl submodule on github)?

2016-08-15 15:47 GMT+03:00 Jeff King <peff@peff.net>:
> On Mon, Aug 15, 2016 at 03:29:14PM +0300, Arkady Shapkin wrote:
>
>> Thank you, after updating to "2.9.3.windows.1" options "--recursive
>> --depth 1" now works.
>>
>> But "--recursive --shallow-submodules" and "--recursive
>> --shallow-submodules --depth 1" still doesn't work.
>
> It does "work", but the server hosting your submodule may not be
> configured to allow you to access the reachable-but-non-tip sha1
> directly. So it's not a bug, but rather a configuration issue (and the
> "fix" in v2.9.1 is to be less aggressive about enabling
> shallow-submodules, since the default server configuration does not
> allow it to work well).
>
> More discussion is in:
>
>   http://public-inbox.org/git/OFE09D48F2.D1D14F49-ONC2257FD7.00280736-C2257FD7.0028245A@notes.na.collabserv.com/t/#u
>
> -Peff



-- 
WBR,
Arkady Shapkin aka Dragon
