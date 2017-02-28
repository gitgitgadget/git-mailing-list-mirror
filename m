Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 392E3201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 18:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbdB1Stu (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 13:49:50 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34759 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbdB1Stq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 13:49:46 -0500
Received: by mail-pg0-f43.google.com with SMTP id p5so8808270pga.1
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 10:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Ff31Gnx1yrM35gTSxTJYpOa1tfVp60QrGuIjE3CwSLA=;
        b=WlNL0aMrmZFZw+fuqfGWGbtasjg5awbnjAWrCtaRN4IVrUl/0USNKEydQ8vG0CrpDM
         wjbJ1sy2jP6cM65yndIFbu7S6jVki1W5Rk7G0CcCSUvgsiIw8A1qP1vHTQVxdhi9G+e6
         M1ifhz+Cfk3GGPbyq+PaBrist7Cr5LvGnYFiBzPV0/VVeQvp3w2jixOPKQAu0gseXacH
         J9LufxD4qIP7bjOSZ8Hw0xLJTsTqReMwjbUwjA/V+RILEiseL9WNHwl801Rwl8G8t+u2
         b8tm76QP5HZ6R/On1m51WrKYaRmgdCoF4xA+V2BxAAPNWz2u5meDiysRiTR4Cgq812vY
         P/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Ff31Gnx1yrM35gTSxTJYpOa1tfVp60QrGuIjE3CwSLA=;
        b=Xq+17XIX8tAk9A0wcebE5dsqNd+lRQVSBLKV8b87yD++WksG/7JUhhA3ueobfPvIhs
         YkosWziBgLytVV/PqQWaxZHF4V9ZBuTwhpsEgftBhadVdqVOFRn3Y7A7F3P/I3PMlHtX
         gh3xYQQTfbhwMgyNaiL3EEdVY8cs+Jw3poxFDX/zsdl6/noolGQ7x4IndeULeB6hUsyS
         jWw2W2m/YaJ2emWWB/Va9oVByA0zeasSq8RI+Agtcq0O+lLFRdMRQHzGsxwVVrm1qauT
         zwBd2WVoSEeH/dswuVMMyl9J/7ZLxH5HMq2xVxWT002KCiiBRiyl+d+U5345N+zdWyp9
         Wjng==
X-Gm-Message-State: AMke39n0vtZRQslXfvGwEw6Whcfd42diLUjsq+kKZW5PkkscV+iql7rjfcCPrfFzeZy+eQ==
X-Received: by 10.99.113.11 with SMTP id m11mr3837238pgc.142.1488303758617;
        Tue, 28 Feb 2017 09:42:38 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:e0d7:55f8:67f2:62dd])
        by smtp.gmail.com with ESMTPSA id y67sm5476815pfa.96.2017.02.28.09.42.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Feb 2017 09:42:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adrian Dudau <Adrian.Dudau@enea.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: format-patch subject-prefix gets truncated when using the --numbered flag
References: <1488297556.2955.11.camel@enea.com>
Date:   Tue, 28 Feb 2017 09:42:37 -0800
In-Reply-To: <1488297556.2955.11.camel@enea.com> (Adrian Dudau's message of
        "Tue, 28 Feb 2017 15:59:16 +0000")
Message-ID: <xmqqinnuky9e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adrian Dudau <Adrian.Dudau@enea.com> writes:

> I noticed that the --subject-prefix string gets truncated sometimes,
> but only when using the --numbered flat. Here's an example:
>
> addu@sestofb11:/data/fb/addu/git$ export longm="very very very very
> very very very very very very very very very very long prefix"

This looks like "dr, my arm hurts when I twist it this way---don't
do that then" ;-).  Truncation is designed and intended to preserve
space for the real title of commit.

Having said that...

> This is happening on the latest master branch, so I dug through the
> code and tracked the issue to this piece of code in log-tree.c:
>
>         if (opt->total > 0) {
>                 static char buffer[64];
>                 snprintf(buffer, sizeof(buffer),
>                          "Subject: [%s%s%0*d/%d] ",
>                          opt->subject_prefix,
>                          *opt->subject_prefix ? " " : "",
>                          digits_in_number(opt->total),
>                          opt->nr, opt->total);
>                 subject = buffer;
>         } else if (opt->total == 0 && opt->subject_prefix && *opt-
>>subject_prefix) {
>                 static char buffer[256];
>                 snprintf(buffer, sizeof(buffer),
>                          "Subject: [%s] ",
>                          opt->subject_prefix);
>                 subject = buffer;
>         } else {
>                 subject = "Subject: ";
>         }
>
> Apparently the size of the "buffer" var is different in the two
> situations. Anybody knows if this is by design or just an old
> oversight?

I think this is just an old oversight.  The latter should have been
even shorter than the former one (or the former should be longer
than the latter) to account for the width of the counter e.g. 01/27.
