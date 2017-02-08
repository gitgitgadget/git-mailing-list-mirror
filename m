Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31A5F1FC46
	for <e@80x24.org>; Wed,  8 Feb 2017 06:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753575AbdBHGXy (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 01:23:54 -0500
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33496 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752604AbdBHGXx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 01:23:53 -0500
Received: by mail-oi0-f53.google.com with SMTP id w204so76824428oiw.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 22:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=By+wL1VZgmSjCCbfEyCgm/qhPvLHhTX6jfb8/TXtT38=;
        b=YVdV6bRQTbzMUUFna5xPD+3F2AVbCZ0qg8TPc8OkQvolrPXbW8+FidZHvFjfoDDZxY
         LstUKsDfZ/xThcI/Fwa/uZdS9k5GOaUX5UmlZUAcVTM27kqZgPTJXELDIUx3V+CeLAXV
         Zm+qPMfNvlaHvda9//0sjdl2tBGo79qYpmJnWuWxkBubseu414UkFUP1Zgr8iAwvfZbk
         2IyKzZ9TPLif6c+vo4RGe1yqTay708qp00ky9IHoJjaZ862cA6WsdqVThqbrnIF3YAg6
         Pg9YdFB+0u0OZGAO8Is1LcNr7k5HPoO1+wzQRF6jDV1PVOG8Y2DgQp5SxVzu3Ezt3xdf
         A7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=By+wL1VZgmSjCCbfEyCgm/qhPvLHhTX6jfb8/TXtT38=;
        b=iJkPbk4Expoef0Bx4SzsUS8j721YpFYQb32/sCrw45HwJbRCv+jGqebKRdv8zYsES3
         JucrCr6tpxX1bn/7bmlfMSBexEajG0brV4bw8GHVC7Tp/DqWyNl8tT8Xkcj08nu8A/kv
         JRM36JqIUp2/n0FsLmJ5h0ZdKbxAwH9JDRM1hWb7IgliqhEixZ5sGyuaIofMYsUNC2rU
         Z26MXe9zYSghuOXGmTAKiRQ+tV80VsDWPBrbXxG0JcOybhqwMi1vdXymOaEU34czdxHb
         QtJNcpLK/4YmCFLOEALEgXTXKYZTPpL4dsQ5+Rn9bEDN2ulOizuYKiu6PvHpZ5FU2Lf3
         fGIA==
X-Gm-Message-State: AMke39myqYGBdTGrKy5mJO5TFJFDFklvrQ/O5woMODYvvy1A69M8Eb/u5Roxk1a1lqc9szOPzoaco6IMyRiKBg==
X-Received: by 10.202.60.67 with SMTP id j64mr10252380oia.124.1486534421947;
 Tue, 07 Feb 2017 22:13:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Tue, 7 Feb 2017 22:13:11 -0800 (PST)
In-Reply-To: <CA+P7+xoZHOtURfbBbHHTpC3DsGxaGOVToqmW5wTg2EniRpL-Cg@mail.gmail.com>
References: <CANOj2JG5VuDtS30PfOrZ=4q8pTv_frY7=p+0g=UW3yV6ev+1KQ@mail.gmail.com>
 <CABURp0qbKMfngfsC5pQeO+qyRPxa21vi090hMWDtLd+BBH_3Jg@mail.gmail.com>
 <CAJZjrdWbqvBRtyyfhgAt1E9ZdTUaz+Zpk7iGasNoeSuFJbsKog@mail.gmail.com> <CA+P7+xoZHOtURfbBbHHTpC3DsGxaGOVToqmW5wTg2EniRpL-Cg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 8 Feb 2017 13:13:11 +0700
Message-ID: <CACsJy8CWJvwSnmdpMg=atu+M8=4ksrTAYTgZyF5U7JnOCnPAkg@mail.gmail.com>
Subject: Re: Request re git status
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Samuel Lijin <sxlijin@gmail.com>, Phil Hord <phil.hord@gmail.com>,
        Ron Pero <rpero@magnadev.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 8, 2017 at 2:18 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> Personally, I think that the fact that Git forces the user to think
> about it in terms of "oh I have to fetch" instead of that happening
> automatically, it helps teach the model to the user. If it happened in
> the background then the user might not be confronted with the
> distributed nature of the tool.

I agree. But I think there is some room for improvement. Do we know
when the last fetch of the relevant upstream is? If we do, and if it's
been "a while" (configurable), then we should make a note suggesting
fetching again in git-status.

This is not exactly my own idea. Gentoo's portage (i.e. friends with
apt-get, yum... if you're not familiar) also has this explicit "fetch"
operation, which is called sync. If you haven't sync'd in a while and
try to install new package, you get a friendly message (that helps me
a couple times).
-- 
Duy
