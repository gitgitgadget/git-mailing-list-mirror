Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE11B1F667
	for <e@80x24.org>; Tue, 22 Aug 2017 23:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbdHVXg4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 19:36:56 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:35700 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752452AbdHVXgz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 19:36:55 -0400
Received: by mail-yw0-f178.google.com with SMTP id s187so1047870ywf.2
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 16:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LFcz3JaBMB3jeo5XkpIjuAC+CbQN+fXZiwdb1Kt8z88=;
        b=YluEWXJyjRetT/ZPvwxrNaP1CfmO9lkbSFz3WmjrLLtCkPsavlFUCqT+EK//srhCBQ
         iyf/dlwQ/+omVA/MqsT/8OQpqgNbjy9HrnIfWTIOSsaKuqUSsDdyXyAApghO9RmCFErm
         sYsckNAUUhEBQOOnknPlxJNrBjsW27jo9Y1yf0pH+EyUTKk0oKUS3m/P7vO9BAsSnThF
         d/Omc6C6hrYwZB2YVNeBpOel2rnAoCuyFma3eS9BFO+GXafggFdSMf7DBrOVHO9i/Ob/
         ZZcLzk1jy5LATEEWD6kXn1YemCIrAyqqbCR7+P/EiyX263lBwmvBuXH3fboW/ecPbdZB
         jUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LFcz3JaBMB3jeo5XkpIjuAC+CbQN+fXZiwdb1Kt8z88=;
        b=Le1TIJwCnKe7HnT5PZ2OIN8bHwWkyiFYX1wYoO0B/gLoocYLwGcgJoOOUe5tCkEbwf
         4VNHWQjSpT05hGt8QQ5Mz7zI8c56cN3AXYf7kH+HVzlOQS4gIRMpgVp7Uew39HHHUbce
         01rfB8wQm0K8mRv0bc4HQCUZ65/Lr+pt/Epg0dx2+eHCg6uwL3cWB7De/2c4pa+Dg028
         Vhsnx54DSJYviwKq5XSMBeaQ3elLBujjPFT9JIwa2IXN0aSw2DAcmXFVBQmOxX68FTKr
         hsnF9AoxbBpZpF/1PcTgTPo5VfiB2gPS8lLOq2vqD2tttcNa9mJniDrIZOdAUlI8fYIC
         zGUw==
X-Gm-Message-State: AHYfb5ggF/taqe0NVE0ww/BgUlQcRL7t8n9wzfrHiFJZJNMtu+YDrwZ+
        juytQQ/0eboZbm9TBy5Ok1zZDCoJSJJBFQ4=
X-Received: by 10.129.93.194 with SMTP id r185mr635166ywb.33.1503445014852;
 Tue, 22 Aug 2017 16:36:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.170.41 with HTTP; Tue, 22 Aug 2017 16:36:54 -0700 (PDT)
In-Reply-To: <CA+P7+xpCJ8jwBQp9Ze=J955CaxnbVPc69ThXht2e=6TUMBq_UQ@mail.gmail.com>
References: <CA+P7+xrtZYUjPcVMkA+x8B57w+LxjjU8YSKcE77DrWne7449rg@mail.gmail.com>
 <CAGZ79kZW_+GEKyP4+8agZ7nyjGEZ9p5d3N99W6sC3GTY_4Cm-g@mail.gmail.com> <CA+P7+xpCJ8jwBQp9Ze=J955CaxnbVPc69ThXht2e=6TUMBq_UQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 22 Aug 2017 16:36:54 -0700
Message-ID: <CAGZ79kbYWJmru_o48+8iH4_MVEtODFuicRY=23+BM+_q2ZJsaw@mail.gmail.com>
Subject: Re: git send-email Cc with cruft not working as expected
To:     Jacob Keller <jacob.keller@gmail.com>, johan@kernel.org,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+cc people from that thread

On Tue, Aug 22, 2017 at 4:30 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Tue, Aug 22, 2017 at 4:18 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Tue, Aug 22, 2017 at 4:15 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>>> Hi,
>>>
>>> I recently found an issue with git-send-email where it does not
>>> properly remove the cruft of an email address when sending using a Cc:
>>> line.
>>>
>>> The specific example is with a commit containing the following Cc line,
>>>
>>> Cc: stable@vger.kernel.org # 4.10+
>>
>> Please see and discuss at
>> https://public-inbox.org/git/20170216174924.GB2625@localhost/
>
> I read that thread, and it addressed the problem of
>
> Cc: <stable@vger.kernel.org> # 4.10+
>
> but did not fix this case without the <> around the email address.
>
> Additionally I just discovered that the behavior here changes pretty
> drastically if you have Email::Validate installed, now it splits the
> address into multiple things:
>
> stable@vger.kernel.org, #, 4.10+
>
> Thanks,
> Jake
