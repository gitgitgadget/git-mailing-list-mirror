Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E8E91F667
	for <e@80x24.org>; Tue, 22 Aug 2017 23:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752620AbdHVXbH (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 19:31:07 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35076 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbdHVXbG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 19:31:06 -0400
Received: by mail-wm0-f54.google.com with SMTP id r187so4127672wma.0
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 16:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Jt+pvOrTisrgRxC6s0HaOTvSQBy+CHLKgimiq2yrHKc=;
        b=k3UPkX5ZlkBHee+9Jbs62hxxL7SBAH/ls4Cw91a34Qocq8BKwmddzxwhHtTmprFo6T
         cuyfmXFrPEELbxJSKuSlYgIrxJmel/rVHnBMi5ou4qwEXsgYbz7sSYMKsDSxvH+khGEf
         iFWtalYzsQ78TX+Dc/K9c/dsOXurr+FtSnm0gtNzJDO93BoIRW+mvubO2GXE2qjMcJqK
         5SCd+Dc8egDF7mstNLFSVyLvdVXm/4cIdRd8kuGohaBy4dUiMRaZASXU1/z+SAARIF33
         Tp1NK1WRVvGwCqiOLq90lsOiuUS/JLorc6+wE1g+Qjn+x1Y/M3ph/Qza/NmlzCAFVKl/
         JYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Jt+pvOrTisrgRxC6s0HaOTvSQBy+CHLKgimiq2yrHKc=;
        b=Q4G9goUY/b0kktGVD5wVNm78p9QC3K+FieAswCSXT7bYlfx5qjkFtewu2qptL6PPUT
         QJTp5m8WsuVdB5i5QWHLkMzeOMOcnW9fxs5oOvBrm95TcasdNhAaxWuV/f73LgQLIuVu
         3F+6S5dAIkX7sIl8bdUN2vhUt0Y+m7YGcfUEVokBRNWVzmvh+pkYZBYoexrq1X0qyV47
         URb1XP1D0+H1imENAukXWGFtYS+TXssMn6Ce1T3k071zxGwwOasM4HJmba/t+6QXwF9T
         98teszmjgXD7K3ESdFUmiMmktM2BXNN9vCjfX2cqVo2ZmQ47tmv3qtATH/o3gBcH6N4U
         hROw==
X-Gm-Message-State: AHYfb5iTYOK1cZ/Oq9L7D5aPk7hxIOiF7hrYXMpyft2nLwhofORBGUl+
        D0kQU5dfwxXUMagQhvWNw4gfh6L9pjqw
X-Received: by 10.80.163.135 with SMTP id s7mr1372639edb.18.1503444665291;
 Tue, 22 Aug 2017 16:31:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.182.5 with HTTP; Tue, 22 Aug 2017 16:30:44 -0700 (PDT)
In-Reply-To: <CAGZ79kZW_+GEKyP4+8agZ7nyjGEZ9p5d3N99W6sC3GTY_4Cm-g@mail.gmail.com>
References: <CA+P7+xrtZYUjPcVMkA+x8B57w+LxjjU8YSKcE77DrWne7449rg@mail.gmail.com>
 <CAGZ79kZW_+GEKyP4+8agZ7nyjGEZ9p5d3N99W6sC3GTY_4Cm-g@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 22 Aug 2017 16:30:44 -0700
Message-ID: <CA+P7+xpCJ8jwBQp9Ze=J955CaxnbVPc69ThXht2e=6TUMBq_UQ@mail.gmail.com>
Subject: Re: git send-email Cc with cruft not working as expected
To:     Stefan Beller <sbeller@google.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 22, 2017 at 4:18 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Aug 22, 2017 at 4:15 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> Hi,
>>
>> I recently found an issue with git-send-email where it does not
>> properly remove the cruft of an email address when sending using a Cc:
>> line.
>>
>> The specific example is with a commit containing the following Cc line,
>>
>> Cc: stable@vger.kernel.org # 4.10+
>
> Please see and discuss at
> https://public-inbox.org/git/20170216174924.GB2625@localhost/

I read that thread, and it addressed the problem of

Cc: <stable@vger.kernel.org> # 4.10+

but did not fix this case without the <> around the email address.

Additionally I just discovered that the behavior here changes pretty
drastically if you have Email::Validate installed, now it splits the
address into multiple things:

stable@vger.kernel.org, #, 4.10+

Thanks,
Jake
