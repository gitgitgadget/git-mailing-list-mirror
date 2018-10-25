Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53D8F1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 06:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeJYOyL (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 10:54:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52016 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbeJYOyL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 10:54:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id 143-v6so242683wmf.1
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 23:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=heX5SnSLAtJLLKaQTtILO9RIjDCep95y10GcLB1bSE8=;
        b=NSGaA+z0K1EcHb7btNfPFTtxBCxuqHOrifpUdsUCiNA/4/NHFNhHVV+r8qNCJOcFMF
         IqV+A9aG8O8/efpeRTmo5KG0zHnYjNSgdgQO6HHZuA2gqJNF7Lpa7J+/0t90tTlZ4qDV
         JU/uLGAY6L8yqCfbOqGQgraDJZ/sQbNMwEs5JendK8qa0XsNOiRZo+e94VB23/j+W8fx
         SS/QSRoTVQ97WMBr4RaXqbqKt8Km49LViQbgB3ikYrL6tL69J0L48J0YfbqG7U4x5MNl
         b1rVQkuYsTRLvpIAGJr7VTxWRi/ersQ5ys0O/9JtvnpUxKc0ZHJHAlzhzfq1HI6fxZQS
         qEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=heX5SnSLAtJLLKaQTtILO9RIjDCep95y10GcLB1bSE8=;
        b=iOPQ1oY4+hBaISad5tSqN6kbpGGhucVa4zpY+DnJfljzF6nh2iQ83+sUP6/ogq8ORQ
         HTr4W1WWfF+PMy5t28GnBWMfHftB3C30fR6LRl8+Xy5lQwlLr57M61ZY2tdlIJ/Dztvd
         olWEyU+4iHra/iKqura9ZhhB1pZ/rDSxjtsCrJ9b1b104GLo29ym7oMASe1GMvihBQQ1
         5YuWEkD4yuquQMq2sd2qBBVRRyAwjonK9xFuuS/8qimO0ysd1lmlAe/9QCm0394Vgs2z
         gHss38ZvwCPpE3Ovez3VKZQueLv59X5EMyyBfay/tDEN9wgGGWXgvcxgj20TNyraS8E3
         1JNg==
X-Gm-Message-State: AGRZ1gJ8XCvwf8mY33I26DwRCVTPYzZCf8SfhcDGxPOv5MetV7CLCKkd
        iXk3gJ4y2SSbWuu22beOEeY=
X-Google-Smtp-Source: AJdET5cg9c6G5a5knx6vcMa/8yRzsD5g8UEw4oNI43kYJXjV7mTz0Q8Lahn/vbXZA5XwebSfDm+OLw==
X-Received: by 2002:a1c:ab54:: with SMTP id u81-v6mr366637wme.45.1540448572555;
        Wed, 24 Oct 2018 23:22:52 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h64-v6sm194511wmh.27.2018.10.24.23.22.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 23:22:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, alban.gruin@gmail.com
Subject: Re: [PATCH] sequencer: cleanup for gcc 8.2.1 warning
References: <20181025001406.6729-1-carenas@gmail.com>
        <xmqqlg6mk2pd.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 25 Oct 2018 15:22:51 +0900
In-Reply-To: <xmqqlg6mk2pd.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 25 Oct 2018 14:36:14 +0900")
Message-ID: <xmqq8t2mk0jo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I'd have to say that the ability to create an empty file is more
> important in the longer term.  Can't the workaround be done to
> write_file() instead?  I actually do not mind if the solution were
> to introduce a newhelper "write_empty_file()", but the way it is
> written in the code before this patch, i.e.
>
> 	write_file(FILENAME, "")
>
> is so obvious a way to create an empty file, so if we do not have to
> resort to such a hackery to special case an empty file, that would
> be preferrable.

It turns out that we have dealt with this before.

The trick employed by 7d7d6802 ("silence a bunch of
format-zero-length warnings", 2014-05-04) is still a caller side
workaround, but to do

	-	status_printf_ln(s, GIT_COLOR_NORMAL, "");
	+	status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");

to the function whose third parameter is printf format.

I do not know if it is a good idea to define a macro

	#define	EMPTY_CONTENTS	"%s", ""

in git-compat-util.h and then replace all the occurrences of "%s", ""
in the source code with it.  That way, we'd be able to create an
empty file with

	write_file(FILENAME, EMPTY_CONTENTS);

and write out an empty line with

	status_printf_ln(s, GIT_COLOR_NORMAL, EMPTY_CONTENTS);

and they would read naturally.  But may be it is a bit too cute an
idea?  I dunno.


	
