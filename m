Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039E8CDB46E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 17:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379554AbjJLRNS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344032AbjJLRNR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 13:13:17 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FFEC6
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 10:13:16 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3247cefa13aso1090504f8f.1
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 10:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697130794; x=1697735594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dvidYIOPKeSsgE0GeDN7NQDll+y47doClzXJ8pE/m4k=;
        b=mzBqgx05EvlO3x8tDFq5Y71Zbe/7AGRLAw4r+p+Ubt4/ci9iVOnyqzTRxjiYtT25Zg
         K/xpH66g5j2hgZakj4zfSJJbC/TtnJvG3KcLG4G7RENDkaoympJnp8v9lSO9CdqbPtvH
         cJmK7E2hVkrEtTxSazeJ3MsqACJFNUCxSd09KulIPq3Tpsuiyc6VMPEJF6dOi73qAraJ
         g1BRoPvzh7aGLGM3aPr1aA009knFDOraylExfBJ8V5B388htkx4TYpcnXeWojiY+ddVW
         kCj9N5pPwW3QqRd8LxsMBUSRrg2SH++c4wSG29i2giGvdMBjlATLw4/35HrzQo/SWGmr
         YZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697130794; x=1697735594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvidYIOPKeSsgE0GeDN7NQDll+y47doClzXJ8pE/m4k=;
        b=ppGuEJ/HMX8RXfSh8bstSvjyx3GPv/AB8CxapxXJ9Ce6at+SzoB0jU2hYQ5X9zVnBm
         5WYqJ+9rm1c2F5oIkRAjyAc58DvqDpusmeVT4PtXYdIT2kZqe1CcG+UIpqk2pZNcYfxu
         Hmd0hKv488eLYZ0+0mUpEPHN0BvwwrkBAtgNzYVjDpd+XwKR/3q85kzw91S6Sv2Dp6g+
         xYDrtqDZXW9mX7v8czIwR8OV8I52eCSaG/OZEokuygUqlMAJt661rf8RqkoHoQI/k2qL
         /qvLIBBuSph6tHkPkBS/dvikz/4skBELr9ls8kM0F+LI1A0+QGxhbw1m3e3d7Zk36Jvl
         HEYw==
X-Gm-Message-State: AOJu0YyVs2+wz+WUtr2BE/EfPhRAcn+2GD2cosA84mSDl08TMI1XRpB9
        +ZseM4xEn7muEl7UVdobDnbud80h772y
X-Google-Smtp-Source: AGHT+IHQX4wfO3uFXlZqebZ7n2NqUacyelrexwHTELyQkIDLPwOBv9s1vQ5Jq2diPrBP+G0Z36LCUA==
X-Received: by 2002:a05:6000:10c2:b0:321:68af:947 with SMTP id b2-20020a05600010c200b0032168af0947mr19913940wrx.8.1697130794207;
        Thu, 12 Oct 2023 10:13:14 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine ([105.163.2.146])
        by smtp.gmail.com with ESMTPSA id d9-20020a5d6dc9000000b00327b5ca093dsm18729428wrz.117.2023.10.12.10.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:13:13 -0700 (PDT)
Date:   Thu, 12 Oct 2023 20:13:10 +0300
From:   Dorcas Litunya <anonolitunya@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [Outreachy]Introduction and Problem while installing Git
Message-ID: <ZSgpJgnaieu6kO0+@dorcaslitunya-virtual-machine>
References: <ZSeYzdx07Cj67lR4@dorcaslitunya-virtual-machine>
 <4c5fef38-a671-dd6b-4b10-a531e1ae254a@emailplus.org>
 <xmqqmswnhkxt.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmswnhkxt.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 12, 2023 at 09:20:14AM -0700, Junio C Hamano wrote:
> Benson Muite <benson_muite@emailplus.org> writes:
> 
> > On 10/12/23 09:57, Dorcas Litunya wrote:
> >> Hello everyone,
> >> My name is Dorcas Litunya. I am excited to contribute to the git
> >> community, I am a first time contributor through the Outreachy program.
> >> I am excited to learn and grow through this project. I am currently
> >> installing Git and I have been faced with this error once I run the make
> >> command:
> >> In file included from http.c:2:
> >> git-curl-compat.h:3:10: fatal error: curl/curl.h: No such file or directory
> >>     3 | #include <curl/curl.h>
> >>       |          ^~~~~~~~~~~~~
> > You will need to have curl libraries and development headers.
> > https://curl.se/libcurl/
> > You maybe able to get these from a package manager, for example on Ubuntu
> > sudo apt-get install curl-dev
> > Fedora
> > sudo dnf install libcurl-devel
> 
> Thanks for helping.  Perhaps reading the INSTALL file at the top of
> the working tree would worth the time?
Thanks Junio. I did follow it eventually. I got stuck here since the
instructions to install some libraries was at the towards the middle and
end of the INSTALL file while the
instruction to run the make command was at the top of the file, and it
seemed a bit easy as the file had just said "it should work
normally"(without pointing out the libraries needed) was what kinda got
me lost, but I eventually found my solutions as I read through the doc. But yes,I will now try to read and search entire docs as all the good stuff might be at the bottom.
:-)
> 
