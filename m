Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2685F20951
	for <e@80x24.org>; Fri, 17 Mar 2017 23:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbdCQX0f (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 19:26:35 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33630 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbdCQX0e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 19:26:34 -0400
Received: by mail-pf0-f175.google.com with SMTP id e129so4693347pfh.0
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 16:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AEF9UZCVdHLwMKg9ahOh+2eAvlibtVjvTjxkcj1zWHI=;
        b=h7GoVEdlb1RRCbuG8KXHnLr8TOK0t7YcLh1NsC+tt3lbMoxzV/AJj2n9l5LTKNTmDc
         Ahn1c9nFsu30q83KlKi/RyFm20H5JXnSKbDtqIn5z/4LnGCSNJWSIhos+wnOKHbFsvgH
         yZMJdGxQYoIWBLwRmGa7sWRtK1Pwc+bpm/DKLsDTrRJ6BgpmVYHRbN+xKVGJPzAFXcZN
         mNdAvAhY0Yji4IzQIsaM+2E5lG5pzY8X+NkYqBiJGyBJdZ1PnHJD6pO0pa2a+/+PdDRf
         GusjlT5eQHFBZk0sHeS0t6blZUXN+mOylHaKqok35WCmzE6RPSfnVwsLx86417e17qsa
         qSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AEF9UZCVdHLwMKg9ahOh+2eAvlibtVjvTjxkcj1zWHI=;
        b=LYMabxLk6zTYF4yUXSGNgYDBc+hWzjusatv9wsgYz5HO9usGr3nJZyzBus0+tg0WMb
         CSHMA/zF3lM5sUVdgdnr5x4bDOB2ceXqPWIkrbrYTMOoMU2tlUH0x/Naa26wYuDGAc3X
         r6xJKRKXZk6nRtdj+KzHPytK/4mLR+gwLZymzwKvo91pI6aFj+0Rm4qqzi4u7JEo2LRi
         THT7WkZJvjC+XOajRIj6A2iJmUFm9dmfoui/up0J2VGWMBl+m3RU8bX0WrHZy2ZoqLyV
         ewvnOrG9HtNyv5m35vyRUcFjOFMKXTSolMi/WSXfeap8Wm9R32NcMuNBfcjk2+qMNDGP
         v6cQ==
X-Gm-Message-State: AFeK/H3LFPWo5/DVqwhjC/AP4ZHywICkyMpo4yct3fdg7YZzZn3WRxH1XB3dQCZn0DBbsiaOIGbbKVh47rUeC4jA
X-Received: by 10.98.112.134 with SMTP id l128mr19895567pfc.81.1489793101118;
 Fri, 17 Mar 2017 16:25:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Fri, 17 Mar 2017 16:25:00 -0700 (PDT)
In-Reply-To: <20170317222849.GD63813@google.com>
References: <20170313214341.172676-1-bmwill@google.com> <20170316222952.53801-1-bmwill@google.com>
 <20170316222952.53801-8-bmwill@google.com> <CAGZ79ka-rQ3YtdduAMYf-XYitKMfX2iEVh4wfR1vD6RzqhHDzw@mail.gmail.com>
 <20170317222849.GD63813@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 17 Mar 2017 16:25:00 -0700
Message-ID: <CAGZ79kbMpMjX166nhitTpLuYH+pDN74zSVAGisQhQKLTfUzZTQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] submodule init: initialize active submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> Here we also need to have
>>
>>   git_config(submodule_config, NULL);
>>
>> such that is_submodule_initialized works correctly,
>> I would assume?
>
> No I don't think so.  is_submodule_initialized doesn't need them to be
> overlayed, it just needs the .gitmodules mappings.

ok, thanks! I assumed it would need it later on, when e.g. looking at
"submodule.active" from the config.

Thanks,
Stefan
