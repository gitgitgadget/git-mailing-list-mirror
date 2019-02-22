Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCD7720248
	for <e@80x24.org>; Fri, 22 Feb 2019 19:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfBVTi6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 14:38:58 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:55760 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfBVTi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 14:38:58 -0500
Received: by mail-wm1-f41.google.com with SMTP id q187so2984311wme.5
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 11:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=2glbLW0/+95Et+032jNUjOE8HOjL5PL0DcUkTKpplDQ=;
        b=O75SwwydtNRxcfblh2ABR9LOH2cKV8g2lOvBaLAG5uNd5R+PfNsGsXg7tz68t8pzMF
         QoGL5/hw6f7UczHDZbaqd0HjZGOOSsOuwsLzucCSg0RtKb4VMSOkv6cyPg6s0xXhZyE8
         QCufKVePc6UyOk20SBv9SXE9DTwFYnvq6uqHaBF0SVgq/rCMIgCaudZgNfrfLrVkQvbj
         VytaqYqYvM+Id+J/qxSCYLqhpGoR51CopJlviM1oyyuZk6zxvIKDrRbvTwiVbmX0TyNA
         uW/IAGAX9bF/ZytyTildsIOGooqjwaZqMLPi7FUqEmJqr6KAWeGgGChV79+Nqldv7fBQ
         Dq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=2glbLW0/+95Et+032jNUjOE8HOjL5PL0DcUkTKpplDQ=;
        b=Oc4hdEeXmtfc0Yko8/HlHjiU+87uLVI3GJZ31FWcJrSSzs7xLdb4Ixb59+x89/DpuY
         o/U0JBf/3ypt7Vktkw+67/GZF9zzCDnn/em+fk6FDY4bkE+lCKvruFn4HD8Z3z/DuqBh
         t8Wfig2AtwLDGiJtU1IZQI1Vr1GuIWNIa6iCE2mr2j5VIpbesF0OsRxO0GR8QgEaZmzn
         Ne8pY64WrdRtPama7EfGS2+7RKi5JGRgLGUh2Vjjt4Yc2538y81iysEzj+xge8/UGIo3
         23Cs0Ci/8QC2RrEKZ3Cf0FVeP4zdXiVQhMuyjBb4n1JxOL95muEiowawpSN3UFI6Npo0
         zvgw==
X-Gm-Message-State: AHQUAuZgVq/OaPxsq8eLnlTyVjddN5rZyvavuOkMxQ9hmOyWPXttARnd
        8RQocdzXPhPzm62V7zWWwe8=
X-Google-Smtp-Source: AHgI3IbqaLRhKVogA7WBuoyecTfBcgsqyH59hdmFC1SyoTGmraxpMRvYAlrZ1bZj4+vdUuxDd3ausA==
X-Received: by 2002:a1c:2d4:: with SMTP id 203mr3440607wmc.20.1550864335389;
        Fri, 22 Feb 2019 11:38:55 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i13sm2766228wrm.86.2019.02.22.11.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 11:38:54 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>, git <git@vger.kernel.org>
Subject: Re: git format-patch can clobber existing patch
References: <CAHMHMxVdpOnTkf9RHzCa+YjjvpqJApsSE03Jjyb_VbJp_4q-jw@mail.gmail.com>
        <CAHMHMxUfjnNXFikVD=rys_t5BUho=7uRw4LsXgAphFwSf3xOnw@mail.gmail.com>
        <xmqqpnrksobq.fsf@gitster-ct.c.googlers.com>
        <20190222001145.GD488342@genre.crustytoothpaste.net>
Date:   Fri, 22 Feb 2019 11:38:54 -0800
In-Reply-To: <20190222001145.GD488342@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 22 Feb 2019 00:11:46 +0000")
Message-ID: <xmqqva1bpq9d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Thu, Feb 21, 2019 at 03:40:09PM -0800, Junio C Hamano wrote:
>> Σταύρος Ντέντος  <stdedos@gmail.com> writes:
>> > Would it make sense / be easy enough to have some clobbering check / flag?
>> 
>> Given that use of '-o' to redirect to a fresh/new directory would
>> reduce the risk of such clobbering, and use of '-v' to force
>> different filenames would reduce the risk of such clobbering,
>> it seems to me that aborting the operation when we fail to open
>> the output, without any option to override and allow clobbering,
>> would make sense.  If existing files record 4 patch series
>> 0001-x.patch, 0002-y.patch, 0003-z.patch, and 0004-w.patch, and you
>> generate with "format-patch --allow-clobbering" a three-patch series,
>> it would overwrite 0001 thru 0003 but will not remove 0004, so the
>> end result will still be confusing.
>
> I think a flag for this would be useful. For people that store tarballs
> (or pristine-tar files) and patches in their repository, overwriting the
> existing files is definitely desired.
>
> My personal preference is that the flag be --no-clobber, but I can see
> arguments for the other side as well.

That's actually simpler, which is good, as we do not have to worry
about adjusting the existing tests that rely on the clobbering
behaviour ;-).

I'll find time before I leave for my offline week, but this
obviously will not be merged before the upcoming release.

Thanks.  I think I've mostly outlined a three-patch series to do
this ready.







