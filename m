Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 587DF1FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 12:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933416AbcK2MrK (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 07:47:10 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34001 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757573AbcK2MrF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 07:47:05 -0500
Received: by mail-qk0-f171.google.com with SMTP id q130so172774391qke.1
        for <git@vger.kernel.org>; Tue, 29 Nov 2016 04:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9KHZPhs9evBrPO80/KHwawZU/ujx34inqe6f4bYYXsg=;
        b=L8qAwYW3T9G0n8Unf5+tbPq07pOwUqHSMDeznkiWMJA8iWR52LhjOBdpMragSBSde5
         0pioUote5FYg0EJC829MZNn2U7r/aNO4ESOD22uiHzrAy79SQC1CmsiiXuvTXNNvQYsB
         G3VUD18OzU6oLNdy/9j0q9SJKThCIyv+LSw7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9KHZPhs9evBrPO80/KHwawZU/ujx34inqe6f4bYYXsg=;
        b=LjbbBOfp2jK3m18183KuygwDzd6NOs45ESgx5SiReFZF7DeQIsZ/t1fEUEfGu9Kvj+
         u0YEPifs59j04Zjn9FDOkhXtA9k0XEbVGKpHGPpftJXttP37J8vYqQCSiFqKbBm+AiU5
         PVRsqYp53ePqlSEtIbFdDCJSozhg0TcTkJmiIg5j24vfTMMh9gB+Xsl03qNay+gwkjg8
         fChfT8QvWvnCkV6eqDx0TgVlaxoqmqoiTGKc/zkKyjE7UUMjg6xxqOotoYi7WPLrGpZN
         AcOEdMMrYY9ZR8xAgy3tl2KUwcJEfCXPT5blituSzxy8kqpDVs3cdeVo5J+v2Mfro/3O
         vdaQ==
X-Gm-Message-State: AKaTC02/P2dpzottd1lkBjNKYwzZTu/Ab48K8+HrE2ROel2ZZLfdUY+DaUTc0VeiJ6kxlVQlV25co1rjTL1B1w==
X-Received: by 10.55.101.133 with SMTP id z127mr23098567qkb.285.1480423624554;
 Tue, 29 Nov 2016 04:47:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.47.111 with HTTP; Tue, 29 Nov 2016 04:47:04 -0800 (PST)
In-Reply-To: <xmqqeg1vjug2.fsf@gitster.mtv.corp.google.com>
References: <1480325598-12344-1-git-send-email-viniciusalexandre@gmail.com> <xmqqeg1vjug2.fsf@gitster.mtv.corp.google.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Tue, 29 Nov 2016 12:47:04 +0000
Message-ID: <CAE5ih78+br88ST3Hkiw744V62AZ9iYWZ4nD5EYjewfmQRWvsiw@mail.gmail.com>
Subject: Re: [PATCH] allow git-p4 to create shelved changelists
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Vinicius Kursancew <viniciusalexandre@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28 November 2016 at 19:06, Junio C Hamano <gitster@pobox.com> wrote:
> Vinicius Kursancew <viniciusalexandre@gmail.com> writes:
>
>> This patch adds a "--shelve" option to the submit subcommand, it will
>> save the changes to a perforce shelve instead of commiting them.

Looks good to me, thanks!

Works a treat.

Ack.

>>
>> Vinicius Kursancew (1):
>>   git-p4: allow submit to create shelved changelists.
>>
>>  Documentation/git-p4.txt |  5 +++++
>>  git-p4.py                | 36 ++++++++++++++++++++++--------------
>>  t/t9807-git-p4-submit.sh | 31 +++++++++++++++++++++++++++++++
>>  3 files changed, 58 insertions(+), 14 deletions(-)
>
> Thanks, but I am a wrong person to review this change, so I'll
> summon two people who appear in "git shortlog --since=18.months"
> output to help review it.
>
>
