Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB43F20988
	for <e@80x24.org>; Mon, 17 Oct 2016 09:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933583AbcJQJNC (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 05:13:02 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:35437 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932822AbcJQJNB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 05:13:01 -0400
Received: by mail-it0-f53.google.com with SMTP id 4so44643241itv.0
        for <git@vger.kernel.org>; Mon, 17 Oct 2016 02:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PiAYkc+qC7QAXCbS3gGyWpsVvbzuuEqTIiZFLKbJRa0=;
        b=CiorsdEdMD65WOLoImXU6KNhkhuh0xx2320po61pI3tteSs4/ptSEjqf1NVmz5WKtP
         b81ZfFx0lEIP2BnvMazEzGY28fiAUTikRde2M8+fIsAd1kf1bsr2euKhkG0Jx1rRxZnL
         NKFuKyMLGyZHq5Fvq9DDSJSjqozu2PRl4eXsv1dMzItdqqGorbUA8A8Scxc4fiBTn9e6
         xGnm+JbdR4vTpanX2awU5yrjUeh9P6Iihftj7IXV5f2uICQwTFJ34h3yQH/qMCAhEOJO
         3tArh+pALmjnGn54Jnz9fWE+XTdPUW+8fsIGHcrNceU1I6UuQQdS+eV2667eJf0dywHZ
         NEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PiAYkc+qC7QAXCbS3gGyWpsVvbzuuEqTIiZFLKbJRa0=;
        b=K/WMAWNK+yLe6z9gnyuEld5fkJmY0tW0P92ca3Jxf2hPWxCjOFG5ermyOlUDZIXsu/
         Xe6UmmiTyNxvqJoL1X4jUjIQPqc/4pPEIsMZrfWZWNBSxDWofX9w+2CHPMAtAp+1nfH8
         Pj2r7fOrCEtxJx69/2rj/sJpnUozE3DKZQ3V939J9rwLvnYKeAVeKVpkN4cxR/zkczg8
         rWJYeTg9YlTXMi5Rw4tVCbvoCUtkVDrhUAvjvSQZ2ldoxOvbg4LUIDrdqXA1fOK5v2J4
         0zs259eeHx0MZZhxNRT8cyjd9AIs8ZDXc0v3H8LQoWJAoc+Z5CHmpCQ0GVCuxZR+49fE
         LG8Q==
X-Gm-Message-State: AA6/9RmlHLkIJ5z1uf1qvn8RWc5puwxEqPKAgVZQTMP6qrkuVy0JF7KAAnCVt94LiGN+MoSQq87pN5sqr0cxbg==
X-Received: by 10.36.76.15 with SMTP id a15mr8296130itb.74.1476695579802; Mon,
 17 Oct 2016 02:12:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Mon, 17 Oct 2016 02:12:28 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1610171056170.197091@virtualbox>
References: <C83BE22D-EAC8-49E2-AEE3-22D4A99AE205@gmail.com>
 <CAGZ79kZ6KaQ5gjGiEFQ-pRJCDAyS0oH=_4dK0nCU9hx8wZwdfw@mail.gmail.com> <alpine.DEB.2.20.1610171056170.197091@virtualbox>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 17 Oct 2016 16:12:28 +0700
Message-ID: <CACsJy8BBLcZvB1FswcEKS1KgvjMjo_uaVqOTgjmMJkjnmoye+w@mail.gmail.com>
Subject: Re: [RFC] Case insensitive Git attributes
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 17, 2016 at 3:57 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Stefan,
>
> On Sun, 16 Oct 2016, Stefan Beller wrote:
>
>> Conceptually I would prefer if we had a single switch that indicates a
>> case insensitive FS.
>
> AFAIU Lars' use case is where the FS is *case sensitive*, but he still
> needs the .gitattributes to be *case insensitive* because that file
> originates from a developer with such a file system.
>
> Otherwise he would simply tack onto the core.ignoreCase flag.

That sounds to me like setting core.ignoreCase to true (on all devs'
repo) would "solve" this. Yes core.ignoreCase may introduce some side
effects when used on case-sensitive filesystems, so we probably want
something in the same spirit but limited to .gitattributes and
.gitignore only.
-- 
Duy
