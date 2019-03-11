Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42C4820248
	for <e@80x24.org>; Mon, 11 Mar 2019 21:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfCKVPO convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 11 Mar 2019 17:15:14 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:36473 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfCKVPO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 17:15:14 -0400
Received: by mail-wm1-f49.google.com with SMTP id e16so426770wme.1
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 14:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3MU/SzfFawSkMO+w0UH10vzUkl4jQxz5mWsqHkQ2jrc=;
        b=lndla9AtU8Q9o0OQ4I54OYvFNGjkjgPY3cyRANN9rgEHuaCNtGCTZ6r+VvJRY7cwUv
         Lz3qGofEF/1yQL07JxCJiyMVvFIzokqnVlp6sAaecaYK2OBL1co6dFIHuNVxRTMpPkex
         81NiYUMmjHGqaSf0h04xbG0LW76vrjcHquF5Alo2dNVeLmhNBh5Zpn2StewwfnPWJvO/
         gQ8lBbiEpwdftInp2slSjhVHwIrs4csJrk9RcJNQ/C07AntCYbEZ0/xEB72Cn4QlklnX
         8MwVFtni/vgfyEm3YOkEgQ1hMh3HDLF5uPl/TfuSsmijqAugxaMr8AnyPZu6uvnXqkeR
         a76w==
X-Gm-Message-State: APjAAAXBPZo7sFrBe/wG5vphSlEfyqOmTRoWT0qI55v28aAyMbwvSmts
        7ZOTAHv0MhNARjWXnTjhfheQILqmXQ9pNMjNd067t/Im
X-Google-Smtp-Source: APXvYqxvympZnmQsclvyVmQSSKKyLmRHrClNOTAUtMAUOYAsxZ0QmyT1OZqAER5eo7LRcI6hYZ6+/R4S09FEGcmiUCA=
X-Received: by 2002:a1c:cecd:: with SMTP id e196mr84831wmg.31.1552338912086;
 Mon, 11 Mar 2019 14:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8nnFYt0raL+twrG_v8XZn_FDJWyM=tH=QL13Z70_bHRiQ@mail.gmail.com>
In-Reply-To: <CAH8yC8nnFYt0raL+twrG_v8XZn_FDJWyM=tH=QL13Z70_bHRiQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 11 Mar 2019 17:15:01 -0400
Message-ID: <CAPig+cTCOfDCv=L3EWUqgVZx1VCdqt5ZjmSQMwHLX=R4C4hgTA@mail.gmail.com>
Subject: Re: Solaris and sed: Too many commands, last: s/\n//
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[cc:+Ævar]

On Mon, Mar 11, 2019 at 4:32 PM Jeffrey Walton <noloader@gmail.com> wrote:
> I enabled self tests for Solaris. Solaris has some anemic utilities so
> I put /usr/gnu/bin first on-path.

The first question is if you are really running GNU 'sed'? My guess is
"no, it's still picking up Solaris's 'sed'".

> gmake -C templates  SHELL_PATH='/bin/bash' PERL_PATH='/usr/bin/perl'
> sed: Too many commands, last: s/\n//
> --- chainlint/arithmetic-expansion.expect       2019-02-24

Ævar had taken a stab at getting this to work on Solaris back in
September 2018. He did fix one or two issues, but the one you report
here was not addressed. He ultimately abandoned the attempt, I think,
after Junio's reminder that the project had long ago declared
Solaris's tools as a lost cause. See the relevant messages:

http://public-inbox.org/git/87bm9cs5y6.fsf@evledraar.gmail.com/
http://public-inbox.org/git/CAPig+cRrwW662Hzp8V1sH51x8qYxPyqG=VHpOkfd-=RwUSSZbw@mail.gmail.com
http://public-inbox.org/git/877ek0rymz.fsf@evledraar.gmail.com
http://public-inbox.org/git/xmqqzhwv51wy.fsf@gitster-ct.c.googlers.com

> Solaris in a VM sucks. I can provide SSH access to the hardware if
> anyone is interested. It is just an Solaris i86pc on an older Ivy
> Bridge.

I wouldn't mind taking a look at it, though I don't promise anything,
and I suspect the only way forward is by ensuring that the GNU or XPG
tools are used instead of the Solaris ones.
