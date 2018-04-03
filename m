Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B89AC1F424
	for <e@80x24.org>; Tue,  3 Apr 2018 08:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755117AbeDCIpJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 04:45:09 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:39335 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754961AbeDCIpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 04:45:09 -0400
Received: by mail-qk0-f178.google.com with SMTP id j73so17773347qke.6
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 01:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=TBMFIiHdh1VYQ/2nRRICzRB5+zneHxNxhfiBtN1goZQ=;
        b=kni6VnRZA/oBlW+gGn9w7c0fMn+gV+beNJPMquW5MGn8RJIbdmjCLm9khWectBMuz8
         EzKgo+gq9ApsBYcGxaq27UZJK/9KXg/iA9P7ev1jKKDsCJOLC8KgY+3Dm573W5cyQoyk
         dVj2Lu0RsrZxioIQzLMzsJ4sh22AdNs+R+COiQMsL6jD8vhfahPF9ciwXqM8O8LYdJGm
         /ommgNbvaxRfKy9XPM6oBnyTtXqjZX6OjvrV+2mgtt7NTZ2cLaAkeJIoZGELXl0nXSEt
         +BRFPALVWes58oViSzb+jzWVsAZ6egms39HCSotICtBTdPN5JgOpiKcgTqlpIUOVxdWk
         Jysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=TBMFIiHdh1VYQ/2nRRICzRB5+zneHxNxhfiBtN1goZQ=;
        b=VHYSsvpjc9vOe0FbXclLsGnoDocGUUzBnn9kFGnkLwaVuAFOO4RMQiZMwDP3jRtkF0
         zuvFVNXiFpooDPIB2ywZ+LNcChA52FBaEVM8qcOGxh9IhXni90vEi8gA+6LzYkkf5W6+
         mmDCwAZZZDrMHjiyqoPaTl+AcXLGE6edB8n8krAnnBGb4C6DvHtGMKRF3j7sxNzXOcBW
         IKA2eQgRkAkg0gceCNEA9w4Y8YAc802cX1dH32XogVnl/WYhZ082chu3nLrXPhMj0FMz
         OJmWDumVs4enH8GjhqDZyRNg4D2bBBE8+WzSdm0Cs6GHOQZ7ygVef1n78SuvER02NeW9
         GWWQ==
X-Gm-Message-State: ALQs6tBVc7w7hjlS/6VjdgUTOJI6OlHbTn/ByiaZI3ijMcg798139+Jb
        fSUwPXODHFg1Gpghvy3viZkclCX8j9YpcR4NFVg=
X-Google-Smtp-Source: AIpwx48K8+ppY3il7WbBbI5Nem+3TE/l3GeCMqV3h8Z3bC9bLlYpfirpz37kuGLJnFeae1doF+UYbgziKXel8bYUdKM=
X-Received: by 10.55.182.70 with SMTP id g67mr16970067qkf.314.1522745108334;
 Tue, 03 Apr 2018 01:45:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Tue, 3 Apr 2018 01:45:07 -0700 (PDT)
In-Reply-To: <0156c688-2c81-1de8-f550-efb517b7707d@frm2.tum.de>
References: <dfb01281-2ffb-a0ac-a44d-74ccd304a7ea@frm2.tum.de>
 <CAPig+cRTf+WHaSJsLhbPuG0fwd6zkTP_zhwLhB14GdC81xiHRQ@mail.gmail.com>
 <cdec466c-ecc9-b1d7-c637-04e63552c759@frm2.tum.de> <CAPig+cSsTPKoLfcxrgD4+NhXa5AeWynxumo8Zed_PH-q3U163w@mail.gmail.com>
 <0156c688-2c81-1de8-f550-efb517b7707d@frm2.tum.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 3 Apr 2018 04:45:07 -0400
X-Google-Sender-Auth: 86-1d9boUnZxG1FW_0SDemX2fyE
Message-ID: <CAPig+cTvVwLDW+6rHNZbUwWwYUGBRioA6B+jM832JpUYAoPVWw@mail.gmail.com>
Subject: Re: Test t2028 failes
To:     =?UTF-8?B?SmVucyBLcsO8Z2Vy?= <Jens.Krueger@frm2.tum.de>
Cc:     Eric Sunshine <sunshine@sunshineco.us>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 3, 2018 at 4:38 AM, Jens Kr=C3=BCger <Jens.Krueger@frm2.tum.de>=
 wrote:
> Am 03.04.2018 um 10:16 schrieb Eric Sunshine:
>> Using the "out" file you attached, can you show the output of these
>> commands?
>>      grep "^worktree.*/destination" out
>>      echo $?
>>      grep "^worktree.*/source" out
>>      echo $?
>> I'd expect the first $? to report 0 and the second 1 in a working
>> installation.
>
> Both of them return 0, but I guess I found the problem. The second
> 'grep' call returned the following output:
>
> worktree /home/jkrueger/sources/git/t/trash directory.t2028-worktree-move
> worktree /home/jkrueger/sources/git/t/trash
> directory.t2028-worktree-move/elsewhere
> worktree /home/jkrueger/sources/git/t/trash
> directory.t2028-worktree-move/some-dir/destination
>
> If I move my checkout into another directory not containing 'source' in
> the path it will work.

Okay, thanks for diagnosing the problem. We can fix the test by
tightening the regex to also anchor with '$' so that it won't be
fooled like that.
