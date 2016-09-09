Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D51991F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 19:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbcIITMB (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 15:12:01 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33573 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbcIITMA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 15:12:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id b187so3998680wme.0
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 12:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=KX7UX6mUbD3fXDp17Pa8dQ+3QxRZV9sMHu3CUEPM+z4=;
        b=tLesOOwV8lVihexPhHB0yLe593Bs3qoRO8X85AgPPYRb08j69bQbLe7FnwS4/RuUSV
         ToWOJe3v8USHmyrXNgjjyJt6D2W+M1Fq6gd28XTTa1I0iuuf1GqyxXVk0GOEaGMMx9Sn
         XZPF2Q70cf5AknPveZaBb0jFi8vt62jCNhxZMRXh6bQmnfkCjw1H6EujiP0izCmWn6us
         jf7rTMHxBWGluX5/+pLjMxIwRSlrm8zArzO/DXRTIZ9dbW5mnZOl8J0hWvGs/t+qRx00
         dkYVbC445MDkwaEyxI/5e8NLuEdZ5qgLkYgqVL+joi0LmuQhhT4vnct05jJjAn+U+dWt
         KIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=KX7UX6mUbD3fXDp17Pa8dQ+3QxRZV9sMHu3CUEPM+z4=;
        b=Cj73bcL6lVh0zbNpe1vAtBsBdXfLArLRinadx0a8xSnmwqlEdNOeHTOZnx6el4VMxH
         HnK2k3W/pfaF5vSKhyYIgd6DS0X1thOVOU+15NcEAcDGBseu0due/xoURPEHEeWSQkTH
         lvBxT3Vf6QrkrBLmBqO8+MpzT/A7kLDLjBINM20M6uUek9RUrfXCo0G0JNZa5mPrDJzV
         b7GZoncH/uuFyusToj5/JpfxmgUvutm14S5fK09naM/sG6ZNwPC3ZOVbHMVIYyhglqz2
         gC4rNZHkXKeOCAGDtKoBnYMz8vacm+9Yar4+AJ1F/6Hg7vEQzteCQEk56IfZvZU3+ZSC
         ilIg==
X-Gm-Message-State: AE9vXwM7YJYzVioOp+iDyP660CNpD+YEt0zQbM/K900sS2BbV95hbSb1oMvfi3uzUR9NLw==
X-Received: by 10.194.223.40 with SMTP id qr8mr5299453wjc.16.1473448318935;
        Fri, 09 Sep 2016 12:11:58 -0700 (PDT)
Received: from [192.168.1.26] (adby20.neoplus.adsl.tpnet.pl. [79.184.24.20])
        by smtp.googlemail.com with ESMTPSA id 17sm4745679wmf.6.2016.09.09.12.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Sep 2016 12:11:58 -0700 (PDT)
Subject: Re: [PATCH 22/22] sequencer: refactor write_message()
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <cb4253698ae3eca066c031e0aec4e83ede1fa3e5.1472457609.git.johannes.schindelin@gmx.de>
 <4c0ee8f6-1302-1dcc-602d-7a84150ec39d@gmail.com>
 <alpine.DEB.2.20.1609011619220.129229@virtualbox>
 <dbc1b08c-a151-29ab-a5a2-45343ca556d6@gmail.com>
 <alpine.DEB.2.20.1609091639430.129229@virtualbox>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <2e15ae99-59cf-7fac-517b-30b59d6d574d@gmail.com>
Date:   Fri, 9 Sep 2016 21:11:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1609091639430.129229@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

W dniu 09.09.2016 o 16:40, Johannes Schindelin napisał:
> On Fri, 2 Sep 2016, Jakub Narębski wrote:
>> W dniu 01.09.2016 o 16:20, Johannes Schindelin pisze:
>>> On Thu, 1 Sep 2016, Jakub Narębski wrote: 
>>>> W dniu 29.08.2016 o 10:06, Johannes Schindelin pisze:
>>
>>>>>  	if (commit_lock_file(&msg_file) < 0)
>>>>>  		return error(_("Error wrapping up %s."), filename);
>>>>
>>>> Another "while at it"... though the one that can be safely postponed
>>>> (well, the make message easier to understand part, not the quote
>>>> filename part):
>>>>
>>>>   		return error(_("Error wrapping up writing to '%s'."), filename);
>>>
>>> As I inherited this message, I'll keep it.
>>
>> Well, please then add quotes while at it, at least, for consistency
>>
>>   		return error(_("Error wrapping up '%s'."), filename);
> 
> I may do that as a final patch, once all the other concerns are addressed.
> I really do not want to change the error message during the conversion.

Is not wanting to change error messages during conversion because of
your use of Scientist tool to catch errors in conversion process?, as
you wrote in
  https://blogs.msdn.microsoft.com/visualstudioalm/2016/09/03/whats-new-in-git-for-windows-2-10/

BTW. could you tell us what were those three regression caught by the
cross-validation?

Best,
-- 
Jakub Narębski
