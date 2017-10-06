Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CCAC20373
	for <e@80x24.org>; Fri,  6 Oct 2017 19:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752970AbdJFTYF (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 15:24:05 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:53755 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752958AbdJFTYE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 15:24:04 -0400
Received: by mail-pf0-f179.google.com with SMTP id n73so3324370pfg.10
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 12:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xo+6wGhruGN0k/IUTdICf5fsofh3iW4R3CJjcAlm5pI=;
        b=EKTsO34Uu62yOlhf7hBI02TY95VpSCFx9/QYBvWuVjI9qFqP2+cHanHPyVW2qpvI3j
         zh/7SVnIkr9i9mjYiVQi9uj5TbWzNTTRS4FuKRoRqTCpOq9XvlOvf3qPGr/20LIZXjeA
         YnW4gwTwn5HVNOKw/DWO6B/1WyffogwvYEBuiNQEmjSAOtb6wd8mzg7IlP/5RUgdTEHz
         FnnptGVa9zceG7oDjxTIf24tydM5ABfIkBrRRtOY59UtKCaLN4SAZm3eGMDdCkI7MFa+
         VJAAyM7mAx4mTblHw5YlsLtHqzUSVGe4yD46FxoOSa1wPxmkrmMlWn6VK8X0EVTZ6Hm5
         nQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xo+6wGhruGN0k/IUTdICf5fsofh3iW4R3CJjcAlm5pI=;
        b=q1EsFS40VZul+QDwzGcdu8TMpfAplBj4Qk2wjG9kDaCbot3o9TP3cZlmjPXxDiFmOh
         e9iJiUYiVqE2tdZQji8fq1jRLW4hgcHIsYFjjLfcuxPxhe4ROUvMZVFKV7735tcHHlvU
         LdAlqg09TPp8DmzvjB4hzdLl33PnoYRnPfbJUUBtyZotAdskeq6m2lcVWGimHxYHcNZn
         b/8yBzQMOSe+/L9ZiCaR6sKfxaIj/oNVLSDjaWboHzxb29ZPF771KrwksBPgG4zkV/fA
         2uueZsfyJgY2BbiUtsDS9iwRF/IkxJQ8jiJCP6Edq/+zXAxpUWjxF+4PzTbVitY0zmyB
         TW8g==
X-Gm-Message-State: AMCzsaUJwTSwnAphdjCirGa9rQYg/nYEk7ULje2ov68TJg3zBX2WK3Xa
        lZmY8B+7Xd/u+zoay458a14=
X-Google-Smtp-Source: AOwi7QClbkXaJ8hCSMjrG73wUWUSr8/XwFQ3lseHrnshAvRD5guV4A+JW0kNdrm4DR2yF8vSiVgwXw==
X-Received: by 10.99.108.66 with SMTP id h63mr2875494pgc.211.1507317843282;
        Fri, 06 Oct 2017 12:24:03 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:78c3:3d0d:a9b5:4320])
        by smtp.gmail.com with ESMTPSA id r18sm4177509pge.2.2017.10.06.12.24.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 12:24:02 -0700 (PDT)
Date:   Fri, 6 Oct 2017 12:23:59 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: is there a truly compelling rationale for .git/info/exclude?
Message-ID: <20171006192359.GW19555@aiede.mtv.corp.google.com>
References: <20171006061434.Horde.16MqZ-fejqXm6BLpL7prK1K@crashcourse.ca>
 <xmqqmv54v5h6.fsf@gitster.mtv.corp.google.com>
 <alpine.LFD.2.21.1710061337300.14079@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1710061337300.14079@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Robert P. J. Day wrote:
> On Fri, 6 Oct 2017, Junio C Hamano wrote:

>> Don't waste time by seeking a "compelling" reason.  A mere "this is
>> the most expedite way to gain convenience" back when something was
>> introduced could be an answer, and it is way too late to complain
>> about such a choice anyway.
>
>   perfectly respectable answer ... it tells me that, between
> .gitignore files and core.excludesFile, there's not much left for
> .git/info/exclude to do, except in weird circumstances.

I use .git/info/exclude in what I don't consider to be weird
circumstances.

But I am not motivated to say more than that without knowing what my
answer is going to be used for.  E.g. is there a part of the
gitignore(5) man page where such an explanation would make it less
confusing and more useful?

Thanks,
Jonathan
