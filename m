Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7522F1F406
	for <e@80x24.org>; Fri, 22 Dec 2017 18:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756550AbdLVSRv (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 13:17:51 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:36265 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756039AbdLVSRu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 13:17:50 -0500
Received: by mail-qt0-f182.google.com with SMTP id a16so37261161qtj.3
        for <git@vger.kernel.org>; Fri, 22 Dec 2017 10:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vmt85SninNrAEX407xIg/h4/iJQ2dnPOhTZG3tYpews=;
        b=QMKvvSa21G1H0joEk72wm/AJ/akP5lW6HtAa/q6zqA8S3eHRGhxkbQslJu8ysc2bpD
         4v1TyP+Ghk+1sosP2J0sSOrCXM3glySULLQNHBzXBMwzKQEmELGp0198J4C12Gn0+yrn
         C2rnYStT8MLc8fxfCcY0ynMlF7PWZQc7Bu8aHmJNZe1pwtVNBEQ/6ENhBBgHJqw5PKr9
         wBs/5s8vQEFIafgD3hVHAylJhKhD351Hjly0YQP7o+wTjjblPucUCgG7wm1AVRtkLdRP
         Q7yy98z6zxonzTrWQ6T2DldzSE04IGlaAnqyLA40nP7xa5vy8b5B03FrlpLfNiUR0h+6
         DT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vmt85SninNrAEX407xIg/h4/iJQ2dnPOhTZG3tYpews=;
        b=n9noeBvSkJ6dSllWioVcjIJyGYtCIIl3O4IHrdPpiY9WmG5Ib16EIjqq6H4pE8IfGK
         E/gryukOGYap4f4w4KKwn77WC6i3FvuykaOV7TaruJQOE7VLUk3ks1lWOfIO/jIXA+Eh
         fn6YGBFAd3iBE/MBFzrCLPBgy3rZesoscwPQQwmpb7h8jJhC/s6+nYUA1XSwAHq7CgYg
         cCu7vrbWMC7+HlxsicYJut1lYpQUVEDZVGd4IYS/LN1NePOVR+h5ycxZ5oHVA5jEg50F
         zWb9iMn5aWmNGBN2wq12yTmOMIXfhHCGiBe1GYvnQGZdkOB4uUUDHJBcADctKR3jAwm5
         kOrg==
X-Gm-Message-State: AKGB3mJ/ple1n9ThlHP9aFZwTg46rg0eYZELUM6VaJde05sNVNDw7jae
        qVa+kY0DJIh4oHcD6mPtoXkx427Dlz+z0+SfCsdDcQ==
X-Google-Smtp-Source: ACJfBot1yXAgbb3LUTBLXhBbi3tLMyeJl2UWgqVWyu6i6bi9HirPXPJPgKc9gyHMQhloJr0BbO6q8QMMAPbJYunEPAI=
X-Received: by 10.200.35.215 with SMTP id r23mr19922794qtr.174.1513966670121;
 Fri, 22 Dec 2017 10:17:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Fri, 22 Dec 2017 10:17:49 -0800 (PST)
In-Reply-To: <xmqq7etetyqo.fsf@gitster.mtv.corp.google.com>
References: <39238da4-c2b8-050d-51e3-675f5515776e@jeffhostetler.com>
 <20171220222416.130872-1-sbeller@google.com> <xmqq7etetyqo.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 22 Dec 2017 10:17:49 -0800
Message-ID: <CAGZ79kZ9rWYwzrG+fJu2neYVfHSgoR5TrkSmNf_EJeUm46QUvg@mail.gmail.com>
Subject: Re: [PATCH] t/helper/test-lazy-name-hash: fix compilation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Heh; I do not think there particularly is much difference between
> stricter flags and DEVELOPER flags, but I would rather not lose the
> removal of duplicated 'today' I did while I queued the previous one
> ;-)


I did not realize it was queued anywhere, please ignore then.
