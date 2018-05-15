Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D79B61F406
	for <e@80x24.org>; Tue, 15 May 2018 18:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752929AbeEOSD5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 14:03:57 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:50404 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752686AbeEOSD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 14:03:56 -0400
Received: by mail-wm0-f49.google.com with SMTP id t11-v6so2605088wmt.0
        for <git@vger.kernel.org>; Tue, 15 May 2018 11:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=zXhcQ9bZjX/nZ0a2aThC3QMp2X32leU9R5FIhqTe5M4=;
        b=VS0k1W1z/arkJJlGwoTTIZpLhKSpQDf3yT5aQnN6MK8BouzAOoNegxPR0RE7ADi2wD
         XMHsT9SsEO6TORVlI683T+N+i7zoBo1jvuK+RM2Y+9hC2BRb2OsAU/nMQr29WhxDQEU5
         GhroHP7XV+n9/vdqiiBgiRi3bJejKq3LK4lZe80RJpq3udXETMdEZtSCD2mcjNuhuTmJ
         D9vzEL4CxLBMlkV/s68GFzJHjpbWooN9nVQy6Emgb0LdBuLtFVtQxu7eB9jLV6USs3wM
         /0wKQTHTxiHGTB9CS1VNxGTPf+fM0gFumlEz4b7rQV7CIBql5MmsJzAUOxw8o98Ym05Z
         6EAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zXhcQ9bZjX/nZ0a2aThC3QMp2X32leU9R5FIhqTe5M4=;
        b=Y2FWA13XOivosbVMUWKDOQr6q06+k/54x1uRiWY+pfC6O5fXJqs4TFqXJo/rX/Gum5
         DEKTY5uMaqApMt/cyrE3ChJ59iGlm/YEWvvoOdM5IqYU3lExXBLdzTMl5fAC7ozFVJFE
         6XnfzdBMDhnqVly0/SOXVdhwxQ6CbHpHycw1moOq5aRHCWVDvBLzvbN/AS4YwSEeDwCW
         CWZb5brAMsESg/+6yfLZumeV80fG9tbQe+7UdmnTAQ8wLCuXC7drd7nWOElm7xBYMtyd
         Q00NMxXMlHbj2A8KiT4QGl8vflcjP9xJf/QHIZumnYt9LK7SWVPBXuGpJqY24DPiChZe
         hmhQ==
X-Gm-Message-State: ALKqPweDs0+VXYjAMZ1Vw5fmOepr/EVqbFTRvAUBJn73qJWLEAODDbDg
        4ZAC7jrPBq/lSBY4
X-Google-Smtp-Source: AB8JxZr6AS3CELgZlocWcZsvSY6BUAKjwVRigLVFJ9yoSRn24fjo/AfMZIMhpAdS5KlTgAOCWXJZgQ==
X-Received: by 2002:a1c:8a03:: with SMTP id m3-v6mr7963568wmd.135.1526407435384;
        Tue, 15 May 2018 11:03:55 -0700 (PDT)
Received: from [192.168.25.100] (ip-176-198-222-196.hsi05.unitymediagroup.de. [176.198.222.196])
        by smtp.googlemail.com with ESMTPSA id x65-v6sm1392767wme.31.2018.05.15.11.03.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 May 2018 11:03:54 -0700 (PDT)
Subject: Re: git diff: meaning of ^M at line ends ?
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
References: <6c23ed9e-4a14-12e4-20ca-3ac6f80cf9ec@googlemail.com>
 <8d7e4807-9a79-e357-8265-95f22ab716e0@web.de>
From:   =?UTF-8?Q?Frank_Sch=c3=a4fer?= <fschaefer.oss@googlemail.com>
Message-ID: <ec5c536a-708a-1fd2-6ee2-98271b90b0fb@googlemail.com>
Date:   Tue, 15 May 2018 20:04:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <8d7e4807-9a79-e357-8265-95f22ab716e0@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.05.2018 um 20:13 schrieb Torsten Bögershausen:
> ^M is the representation of a "Carriage Return" or CR.
> Under Linux/Unix/Mac OS X a line is terminated with a single
> "line feed", LF.
>
> Windows typically uses CRLF at the end of the line.
> "git diff" uses the LF to detect the end of line,
> leaving the CR alone.
>
> Nothing to worry about.
Thanks, I already suspected something like that.
Has this behavior been changed/added recently ?
I didn't observe it before, although the project I'm currently looking
into has always been using CR+LF...

Why does the ^M only show up in '+' lines ?
When changing the line end from CR+LF to LF, the diff looks like this:

-blahblah
+blahblah

But I would expect it to be

-blahblah^M
+blahblah


Regards,
Frank

> If you want, you can commit those files with
> CRLF in the working tree, and LF in the repo.
>
> More information may be found here:
>
> https://git-scm.com/docs/gitattributes
>
> (Or ask more questions here, if needed)

