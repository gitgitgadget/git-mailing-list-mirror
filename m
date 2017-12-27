Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B127A1F404
	for <e@80x24.org>; Wed, 27 Dec 2017 19:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbdL0T1x (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 14:27:53 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:37137 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbdL0T1w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 14:27:52 -0500
Received: by mail-qt0-f182.google.com with SMTP id f2so48944585qtj.4
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 11:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0Ibws1GZW3CxK8mw3rOpBrfOV+V+W4dWA6G9TwbWrZ4=;
        b=GEB46gvzaWPUuLBY7nnvuaEffhO95jva130IshrQ6hygTw1gP0WzKA26emKs+XTfSz
         BfdH0QHZHo6HVEhAnfisy/1j3RIO4xKPnGRSiDnA1DaicSfzlKyw41MKa+Xs4mzPkx1M
         1s4pIJSUT+CkpbarJTvVZxmejm5Ya8TWotbLByhx7oGVhdYu3RINY/n7RYRpgHDIDl26
         LSznHZhKJCojH5oWa6GZwh0nKTnPomDJ5Ob4p0zBuw7fPGamxQ28g+iFCZfxBDhAuLEG
         5tIif1q/VqBgipl2eu7UmVvLRkz37RBDTs95a3w2B46POvZLI8er/UQXYKaywEodwcIG
         7Sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0Ibws1GZW3CxK8mw3rOpBrfOV+V+W4dWA6G9TwbWrZ4=;
        b=uf10vC5RFCflsFcbhETjUFi6pBYm68D1rzYA2bIjn2HecXpwsjcw2/D5McC4BoGsOK
         vZCRC/XuNe5JbLqqSM+HA7Qn7yYOcHT/6ueURw5MwM7iPEKJr3VW2HymtCUtrSoY0012
         OPnjHcMiTcCXMCBOEYyXAGO1lhrJuLEti6mPks/6Ljnbzg3+nFXYSQl2dvgxWfj4IFPp
         2DuXLMzqnOAZ4XQyTQgnTG+y5co23WkrO9wvBPWWWiERrYjLbbLA0LnTD77/36vKsRNt
         Frnl421BD2G4H819AqxBIeCOaggzBrokuXqLdqG6vMreC2wAtPfkLJ0epbsQbK9B+pYF
         Jlog==
X-Gm-Message-State: AKGB3mKPhgblstG6jLkbGUx5grnxUpn+fxLOkfmkmRIlp9CdmH8iYPWB
        IVmYuhe4u2kx1T9ZN4rurO6jrbjOIea6C3M4TdLBqg==
X-Google-Smtp-Source: ACJfBotHDmDhBA7vmRGuDlpfsw2ZDWKa4pcbSz4VF8RJ50BR3sn9R9+l7+NOdZ7fpwH4BCiDBaLLPIs7jonUaalUmsw=
X-Received: by 10.200.36.22 with SMTP id c22mr40049970qtc.207.1514402871655;
 Wed, 27 Dec 2017 11:27:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Wed, 27 Dec 2017 11:27:50 -0800 (PST)
In-Reply-To: <xmqq7etesgju.fsf@gitster.mtv.corp.google.com>
References: <20171219222636.216001-1-sbeller@google.com> <20171219222636.216001-3-sbeller@google.com>
 <xmqq7etesgju.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 27 Dec 2017 11:27:50 -0800
Message-ID: <CAGZ79kaPYsR2PBVz-XN3u0eDgrdh=tuqdMhqTkS0VnrDkn7dTA@mail.gmail.com>
Subject: Re: [PATCH 2/5] t/lib-submodule-update.sh: Fix test ignoring ignored
 files in submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 22, 2017 at 11:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> It turns out that this buggy test passed due to the buggy implementation,
>> which will soon be corrected.  Let's fix the test first.
>
> Please clarify "buggy test".  Without the original discussion (I am
> imagining there is something that happened on the list recently),
> here is my guess:
>
>     We tried to make sure that an ignored file is $distimmed by
>     $gostak, but forgot to tell the exclude mechanism that the path
>     'sub1'ignored' we use for the test is actually ignored, so the
>     fact that the file was not $distimmed when $gostak did its thing
>     meant nothing---mark any path whose name is 'ignored' as ignored
>     to really test the condition we want to test.
>
> but I do not exactly know what verb to replace $distim and what noun
> to replace $gostak above ;-)

Just rewrote that commit message without distims and gostaking.

> Also, wouldn't this expose a bug in the implementation if that is
> the case?

Yes it is, which will be fixed. The bug is:

If the submodule HEAD is at the superprojects recorded object
name, we don't bother looking into the submodule at all, neither for
deleting untracked files, nor resetting changed tracked files.

Thanks,

Stefan
