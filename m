Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9FCE1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 14:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbeH3TAj (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 15:00:39 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:42400 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbeH3TAi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 15:00:38 -0400
Received: by mail-lf1-f47.google.com with SMTP id z11-v6so7434963lff.9
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 07:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc;
        bh=Or5l6zZ+YPrd2xqo/FGuMqsAFEJC5NskV82nXpRrFtM=;
        b=U3iB+L/Khmtp1s+91lm+3ab2ZjU/KxYOiUezY073nHHf/U6UpDsrSMHqDQ0i1ZzV6W
         8WVIRXbwKLhSfZ3OVCtSgMi2lDqwIm7PMB4YIc3G5IBZrjwjUNbdTBHTvkiV/8rrLOqd
         9DiyNWgDpgXTw4gVs23ryHdGzTeYmBRKm95T62LDlM8FucvSJBOYAqdgtjWbrHGMMqeW
         iMD5KwGgJPDyKljDxuC8uoAEHjnYh7I92k8rjeRbipWVgRBw8KT+QGRsusRFy6oj46aS
         BbpNVJ0GNSfq/MX7usSkxZuLQ5AT2h9nuYOR9MiPGOKk65hm6Y0Uk98pJIx3Q+PUk0SF
         tlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc;
        bh=Or5l6zZ+YPrd2xqo/FGuMqsAFEJC5NskV82nXpRrFtM=;
        b=o6fGqFnRuamDD9+qCspTs7qNzIGCRWaxDaeYVrxFpm2+i0MHTC9l5esFGKclZWNcup
         a9xcg7Lswxx57SeXSnzWM+aafv4G52oFGxKr5fUQJh81BqDLnQBkdqL5I0uHzmjOozvC
         PsE3peAgotKF7pS6jjCeymiMDMzAzQ4y6C0DfU0h4Q0oqh0ls3yQ/Fxuc2L6TzunNeVt
         oUlzw0Gtjp7SZV6+PUy5jjR52qjjVpa3JJ0WQB2kfXluc5CUo10vrZkV+Y2sFJ38noid
         0BHhlsSCvpQR3802T04VyeOl2I6KVJzcJn9o5UIdvzT10szaKzZoyL+nn4rwjoC4136Y
         yAbA==
X-Gm-Message-State: APzg51D1PB52bhuZXmojlGz605tINGeEzoYLyKShu9JIttLs0lqqurrt
        tFzsBTBiBlqUlntN3gxQe53cfwa/qzyvdlip8TyUOQ==
X-Google-Smtp-Source: ANB0VdaYsG7BiLT4fAZu9ljGH1xZiFSVC7s5zw/n/bHEBZ1/k06UNOeZZaW4b8g/5TzF7+/o5L32Xn2zWXC8nSCJZB8=
X-Received: by 2002:a19:2c8e:: with SMTP id s136-v6mr1816412lfs.78.1535641084142;
 Thu, 30 Aug 2018 07:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd499APYCH2r2=+M_AGKUzN0GDmrwDty4wK=Xy-utCdMrd56w@mail.gmail.com>
 <20180830045407.GB140348@aiede.svl.corp.google.com>
In-Reply-To: <20180830045407.GB140348@aiede.svl.corp.google.com>
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Thu, 30 Aug 2018 09:57:52 -0500
X-Google-Sender-Auth: Uc2ggJZgpoUyvMSZ6XuoKD-pXyc
Message-ID: <CAHd499BCk4Q4oPY=CXK=YrUbNUbz4J_KoeQngfz=92Qfc6q=eA@mail.gmail.com>
Subject: Re: Automatic core.autocrlf?
To:     jrnieder@gmail.com
Cc:     Git <git@vger.kernel.org>, tboegi@web.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 11:54 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi,
>
> Robert Dailey wrote:
>
> > Is there an 'auto' setting for the 'core.autocrlf' config? Reason I
> > ask is, I want that setting to be 'input' on linux but 'true' on
> > Windows.
>
> Others are exploring your question about the configuration language,
> but I want to emphasize some other ramifications.
>
> Why do we still have 'core.autocrlf'?  Do 'core.eol' and related
> settings take care of that need, or is autocrlf still needed?  If
> core.eol etc do not take care of this need, what should we do to get
> them to?
>
> Thanks, after having run into a few too many autocrlf-related messes,
> Jonathan

From my perspective, the confusion is due to the evolution of the
feature. There's multiple ways to control EOL handling but most of it
is legacy/backward compatibility, I think. core.autocrlf is a
fall-back for repos that do not have a .gitattributes. Because
.gitattributes is optional by design, I'm not sure if getting rid of
the config options is a good idea. But your point did make me think
about how `core.autocrlf = true` should probably be a system config
default for the Git for Windows project. The default for that value
should be platform-defined. That would make it automatically work the
way I want, and might solve a lot of the issues where people are
committing CRLF into repositories on Windows.
