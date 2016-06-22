Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A2C220189
	for <e@80x24.org>; Wed, 22 Jun 2016 18:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbcFVSlm (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 14:41:42 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33974 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbcFVSll (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 14:41:41 -0400
Received: by mail-it0-f67.google.com with SMTP id f6so8318475ith.1
        for <git@vger.kernel.org>; Wed, 22 Jun 2016 11:41:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nv/LBeli+kWxS0TOKIe+VaGWXA1Qz08X/sfDN8wGVok=;
        b=GyGnPwIXEqmcS4IC1o5831F0FEV0l3kZ8FWbPq3p5VL/F9gBhPTw+maAd6c72IWM82
         lH68bpxDHrInCrv1BlBl5SnrKHTayWcai9bfRz51iuE2rmUE7QbeqVaV4CTbMiZle1lc
         xj6HQvjIBQD+ROiv23tuyuhw7+woqPT1Vf1kFTdNE5cz+aUVLk7tQqS2g46iSVUm8UaF
         PBmDkm5RuIXiscU4O173mZbEB8Yw1E164vDRgLL0yWQVeygvwU+9po8SYzjsUen+swbu
         1hHceiUret+PS0uAsqlLqhbluiicqUE6TnkgAk4ht04WZEnHCwEDkj1wSdlgmKhHTyzu
         6a8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nv/LBeli+kWxS0TOKIe+VaGWXA1Qz08X/sfDN8wGVok=;
        b=mTyO6jNmeSjzrL4eW5EKlnppwxxOfpX/oqASmW+RR17ELRuvzaD+NBiMB06Pe1SnVy
         Q2N0PXibSJBrZS+wQ62HK04/CWMVNcNWwlDVF6QCdkAIpB8MStPUjSJKns9D5h+g09Hk
         GHzDvLsXbCPruIN4XHeTSMorNIyRkbp254ekjiw7JzMlCj68QcpKVY756QJ0TSltIWo+
         2iTqwfkJ5oXQDaCvpII/mGoTGdGpTVrhb8D+4BZBk2eShFPxmi/36zHutjFX8LrTX15Q
         tPo4mOx4T4wyUum3MjOK8TwsOMq72OABt5HwRY5kOT8kC0DArNt6Sxh3m4W3/86tZsyl
         WlxA==
X-Gm-Message-State: ALyK8tLyF9trZjcI9Xq4Rq8NR5OhmjxqT1o16WJoNp2TQRLM7HeYBB4Zq087jBl74WRXEeaUlYL9bj6v3NADBg==
X-Received: by 10.36.123.199 with SMTP id q190mr16868633itc.42.1466620900238;
 Wed, 22 Jun 2016 11:41:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Wed, 22 Jun 2016 11:41:10 -0700 (PDT)
In-Reply-To: <CAPc5daWEoK4Gp138VPstqwCAX+2K=_gSW98brHjmJYNWK4dkZw@mail.gmail.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
 <1454724190-14063-1-git-send-email-pclouds@gmail.com> <xmqq4m8rz9qr.fsf@gitster.mtv.corp.google.com>
 <CACsJy8CSVvZfwjG+zAEpG6tAWYAWVkrkz4RP32Hrr9O1A_8ZMg@mail.gmail.com>
 <CACsJy8BQxAkpoT7GVNgtM-0n1pMZeV5TRCiSn6TsYeATWeU=EA@mail.gmail.com> <CAPc5daWEoK4Gp138VPstqwCAX+2K=_gSW98brHjmJYNWK4dkZw@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 22 Jun 2016 20:41:10 +0200
Message-ID: <CACsJy8BMCjjX7_d73LX8+SiYWA4UUFyU3GGzxSVXMK4xubsKNg@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] Fix icase grep on non-ascii
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 22, 2016 at 8:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Wed, Jun 22, 2016 at 11:29 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>
>> Can any shell wizards explain this to me? With this code
>>
>> BS=\\
>> echo ${BS}${BS}
>>
>> Debian's dash returns a single backslash while bash returns two
>> backslashes. Section 2.2.1 [1] does not say anything about one
>> backslash (hidden behind a variable!) after escaping the following one
>> and still eats the one after that..
>>
>> [1] http://pubs.opengroup.org/onlinepubs/009604499/utilities/xcu_chap02.html
>
> I am not a wizard, but is the difference between the shell syntax, or just their
> implementation of builtin-echo?  IOW, how do these three compare?
>
> printf "%s\n" "${BS}${BS}"
> echo "${BS}${BS}"
> echo ${BS}$BS}

Great! printf shows two backslashes while both echo'es show one.
printf "\\\\" behaves like echo though. Doesn't matter, at least I
should be able to make the tests work on Debian dash.
-- 
Duy
