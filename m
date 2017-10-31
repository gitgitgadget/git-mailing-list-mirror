Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAE1420437
	for <e@80x24.org>; Tue, 31 Oct 2017 21:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753861AbdJaVoC (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 17:44:02 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:43098 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753854AbdJaVoB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 17:44:01 -0400
Received: by mail-qk0-f177.google.com with SMTP id w134so567497qkb.0
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 14:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C8cWA067tQ1UMaRDHUegod8RnUMfA6+LvnYg1ss6p9Q=;
        b=ejHMGnXT6/WiHlF8zVHC4V2op2ZN9SqztdzycMSSoo7d05f6qOfJEwwokLFFFIFPyb
         +SdMBHRkzeNxbUSqznI8PY9J88uhItJXIcy6w28TU/vAz8I7vdPdDrc7jGkvRIfBoXHR
         nOmat5E5zGYVs9u+3vnTO9YYt097Ic/zTBUlAaK7kkQJNowM1eMV9lpOWSHN4LwST6IO
         e6LpTqETxZOsOy+9FuM3sO1iDFm2rMaqiH8h6U+oMprycqGamm36jhJBqcnJ1f7rbS21
         B70cpV1Fg9c4M+U69ordJnBT6P2McxoVGR3GgFXugKqkrMtbkz7srq1qhj+1a13nikMv
         Zofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C8cWA067tQ1UMaRDHUegod8RnUMfA6+LvnYg1ss6p9Q=;
        b=C16s1B/6zDqnR+5rrp3nZdJ7LRkVV4T+cvJPCG5+zD1fbexPFTo3ItP35EDVNAAAi/
         5D790v0CwKOcoBZkuLAZph7IeZurIWLK/aljXz1hvEhtHLiajrnSfLgG3REYZ13q7m54
         JJCWcpTAKfBMjRfa0C0ZcqnumbaTkwwRh83p97Dh1b+3arOPrVI9DmpaJdPOPzsJw4NM
         Rx/F+WYe0MtJucayaZuClNEvzMMtyyVUbfwOrPaomjar1sy+oPgqYA8pTFGBZLnLWGgz
         XR1AZVaCwPATGugf5LLFo382x92Kw8SLzF7eVxqAM7H/CaA4RzzVq6Jr8nNV9SWGLXI8
         nezw==
X-Gm-Message-State: AMCzsaXZYwRrfkJO7LwtiF19LvMlDUtbCbSvNs3xgH7abBsgG2oZGawk
        VdA+VXYvcW82o2bVepDmIoeuigIiPUPih4o0yT0IEg==
X-Google-Smtp-Source: ABhQp+SwgYO67zB2mt/xIo8bhPDbVP0wFTUT5Hxg2TLW1WPvkU/kEToqR8iSmwlrhF/FexVJOURn72452unKBRS7xZQ=
X-Received: by 10.55.175.132 with SMTP id y126mr5212909qke.45.1509486240924;
 Tue, 31 Oct 2017 14:44:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Tue, 31 Oct 2017 14:44:00 -0700 (PDT)
In-Reply-To: <20171031181911.42687-8-bmwill@google.com>
References: <20171030194646.27473-1-bmwill@google.com> <20171031181911.42687-1-bmwill@google.com>
 <20171031181911.42687-8-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 31 Oct 2017 14:44:00 -0700
Message-ID: <CAGZ79kbgeVhi46vU9YzSyuvgFLFCZddFatUaopJDG=o=cU6dcw@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] diff: remove DIFF_OPT_CLR macro
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 31, 2017 at 11:19 AM, Brandon Williams <bmwill@google.com> wrote:
> Remove the `DIFF_OPT_SET` macro and instead set the flags directly.

 _CLR here
