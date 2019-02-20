Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42E9B1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 18:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfBTSHA (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 13:07:00 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39020 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfBTSHA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 13:07:00 -0500
Received: by mail-pf1-f196.google.com with SMTP id i20so1860060pfo.6
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 10:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exactasystems-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=thnTxFgTOmJPPK2R1yCKo96qXY/m0+oHxkkCKFAI824=;
        b=kEC6Mnn2rrwHTsYSXPpp4npYTKbaMWgbH8T/EXSDMHogBnT6NE8diI7xzG9I3QP+pP
         nYme6s79GR3tErmAOuvM4e+A75r7H73jA2wKRaI0lzeIZRaZca0UDRN8EWEgYtc4dUdW
         y08cpEWcHHJF8VNLh9DbcittELIXdZEv3G78qXSAxmXrG3m/xx3xGkdCDzDvbZhuAjJO
         lQWPUJXOizP8fXfvp9u13p7ojM5iYuergInp/bhZfTb5QuRA59/ekPHOfaXUuj0ut8IN
         wdGGuMqxzZjcuU9PHFd3JIT0RfgNMQbyKLTip+00RQKt8vEK9pvUMSBhBsuVOWvirt5l
         TJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=thnTxFgTOmJPPK2R1yCKo96qXY/m0+oHxkkCKFAI824=;
        b=sJt71FgP5fD9tbJ5YSoRc2PlwT2/aCOGTUMKJxfLKaAI3GZizBceUoTeKabfAUYCwI
         CfnMZ9FD2gw7ZrK3AJTZDe5zbqgq8K806Z7CZNGCfOc6DBTsSh18Bw5GyX8kmBu3VkjJ
         9EmsKCJkbvOELU/RaiBbkiKzuMPtF3V0axnAMG04jNucP3/dXN+TSiyKfzRHRc7i4NfJ
         o9uToVquczKJu5ICnaKbOEtT+R19v+PFOUJwrMHhyGl6fAwxt/frA1pRji4Kixbp7WD6
         C2bXipnajM91yazaAvNo5YbL+P/sni9Ngrw2BD0jTuH6tUcdif1t5jdmCT1mVobcS3gN
         +UQA==
X-Gm-Message-State: AHQUAuZi5Z9kide8JNDQktX5KVQ/c+E2jaSfZJ5ZN+PqKNWQDCdpW0TZ
        9aKs1adGBSLUA532Y+2cF1tgy9O5bPhwbg3WD89QIMEv
X-Google-Smtp-Source: AHgI3IaJU77jgvSXz7/LgFA21eugjTcqv2kV4UezK4QU+AVUGsjgJWd40UtsH6MffLq0YFHEptn+MALMUrRm5GOpT54=
X-Received: by 2002:a63:e309:: with SMTP id f9mr30151348pgh.280.1550686019683;
 Wed, 20 Feb 2019 10:06:59 -0800 (PST)
MIME-Version: 1.0
References: <CAApa7v-F7Y_WR11V-3jc-R4Y1qSv5PPof6GWvJuF_XMeTcC2zw@mail.gmail.com>
 <CACsJy8AS5eNO6gACGtRZq=qdQGkQ3jmQPVivPG+=du9u9hKYcg@mail.gmail.com>
In-Reply-To: <CACsJy8AS5eNO6gACGtRZq=qdQGkQ3jmQPVivPG+=du9u9hKYcg@mail.gmail.com>
From:   Joe Enzminger <joe.enzminger@exactasystems.com>
Date:   Wed, 20 Feb 2019 12:06:49 -0600
Message-ID: <CAApa7v_noujdWcogGNJUS7ZJRzPRxK5PPv53tST-0JoEk8+9Mw@mail.gmail.com>
Subject: Re: Feature Request git clone shallow-include
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That is correct.  What you suggest is actually what I tried (using
sha-1 syntax).  For my purposes, excluding the tag's parent's but
including the tag is sufficient, but if is fairly straightforward to
extend support to the other use cases I'm sure someone would find is
useful.

Joe


On Tue, Feb 19, 2019 at 7:22 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Wed, Feb 20, 2019 at 7:07 AM Joe Enzminger
> <joe.enzminger@exactasystems.com> wrote:
> >
> > Currently, git clone supports shallow-exclude=<tag-name>.  The client
> > will clone up to, but not including, the commit with the tag.
> >
> > It would be useful to have the ability to include the commit with the
> > tag.  The suggestion would be to add a "shallow-include" options to
> > clone to support this behavior.
>
> So exclude the tag's parents and everything before, but keep the tag, correct?
>
> I think if we support --shallow-exclude=<tag>^ then it should work the
> way you want (if the tag is a normal merge you may need to add
> --shallow-exclude=<tag>^2 as well). And you can do even fancier thing
> like --shallow-exclude=<tag>~3 (i.e. exclude the  grand grand parent
> of the tag, but keep the tag and grand parents). We will need to
> restrict extended SHA-1 syntax to a safe subset of course.
>
> > I have tried to use shallow-exclude with a follow on git fetch
> > --deepen=1, but it always returns "fatal: error in object; unshallow
> > <sha1>"
> --
> Duy
