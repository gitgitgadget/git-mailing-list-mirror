Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CCED201C8
	for <e@80x24.org>; Wed, 15 Nov 2017 21:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756429AbdKOVJ1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 16:09:27 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:52912 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbdKOVJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 16:09:25 -0500
Received: by mail-qt0-f170.google.com with SMTP id 31so37642944qtz.9
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 13:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5sLnrYSS37GlmvctFCfo6jRAOrtarWeE1MCnLTgO0pk=;
        b=FjHtomnfcx9J8OImI5fgNNGoPxD0oYOlBRHnvEXiGSCWVjuQ/nydoYshp9pD193zgd
         +SjN3TeH5Co681CPWnnkhtXVxNh6OeuxAV23PIAQPrSAn2ZMSTLZ+e9jlGzLMblgpJks
         RDfpRNWCxRS/TMZfSE4EQBS/YEYDJjVju7MC3JsEF8phl8oKKtaGb8E9+j872pqD1lCe
         CDlP0mnvaBi7DY8Dj4hY1VZnSq0vG39912Co7/+TgglrXcK/hmU21321J1VKJtTnWp68
         7fkn1tHYSO/PgeNunfmZ9CjDTmFVOBuhtNhsaRIGg3XUifa8oeWD1Jox0TVewpJsWiKx
         Lo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5sLnrYSS37GlmvctFCfo6jRAOrtarWeE1MCnLTgO0pk=;
        b=Ei8cqppCYQBtR6gZIVLZealnQ8+8WOAfAvMXp8Fj8w2XqFQk0Ok6IuVPUr1TGxuF90
         H65M27vBXKLFf5ysSp150XrdkhyHYBBl1ucyBbjDSXbsWDkPsVrNIUi5jmd3TSMGGNNG
         So/bKDwx3ctKiNxBhZOgYap74nkfttywRGjscQAGrCrFvcP3ANHMPsdWB4dvzPHbW6nb
         jmckLK0x4LJuduoPpaz+GyJmzhHIGgYwyNWTgiCVHiMVhZPH+QhLBDCCXgbM3e5GCz52
         O5/K/iEcbCELlP3o5GBPQrs6Bxhje6ed52FMxidrAZrYEjSvXNqN+DxEcT6jftbEqCzm
         16eg==
X-Gm-Message-State: AJaThX5NysDOfPNxlznfHJxm7032ctLLZZsWWhE2XLUg/TkDwfUfre+R
        IZW0BsGu0m4gsm0iw55Uz0Y=
X-Google-Smtp-Source: AGs4zMaSEZ8rI9gv3DJEVTit+Sz8NaOPYqxgmGm+kybhxW31aym26DuiktpNo6R+1BJ82/t3v0q59A==
X-Received: by 10.200.51.107 with SMTP id u40mr25506645qta.152.1510780164623;
        Wed, 15 Nov 2017 13:09:24 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id y30sm14575744qtd.48.2017.11.15.13.09.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Nov 2017 13:09:23 -0800 (PST)
Date:   Wed, 15 Nov 2017 16:09:20 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Johan Herland <johan@herland.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Santiago Torres <santiago@nyu.edu>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] notes: send "Automatic notes merge failed" messages to
 stderr
Message-ID: <20171115210920.GH5144@zaya.teonanacatl.net>
References: <CALKQrgc427=JNkkH+k+EohgKYuJSBPbDNR3uUcmGuf_ZyQ0X4Q@mail.gmail.com>
 <20171114161752.13204-1-tmz@pobox.com>
 <CALKQrgfs9QNg9AcQ_CGq43XkSpAAgS4L0KokpCj2qnhPa9+-=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CALKQrgfs9QNg9AcQ_CGq43XkSpAAgS4L0KokpCj2qnhPa9+-=w@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johan Herland wrote:
> On Tue, Nov 14, 2017 at 5:17 PM, Todd Zullinger <tmz@pobox.com> wrote:
>> All other error messages from notes use stderr.  Do the same when 
>> alerting users of an unresolved notes merge.
>>
>> Fix the output redirection in t3310 and t3320 as well.  Previously, the 
>> tests directed output to a file, but stderr was either not captured or 
>> not sent to the file due to the order of the redirection operators.
>>
>> Signed-off-by: Todd Zullinger <tmz@pobox.com>
>
> Looks good to me.

Thanks Johan.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Deliberation, n. The act of examining one's bread to determine which
side it is buttered on.
    -- Ambrose Bierce, "The Devil's Dictionary"

