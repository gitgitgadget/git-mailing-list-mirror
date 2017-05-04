Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5865D207D6
	for <e@80x24.org>; Thu,  4 May 2017 15:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751022AbdEDPFG (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 11:05:06 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36640 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbdEDPE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 11:04:28 -0400
Received: by mail-pg0-f65.google.com with SMTP id v1so2633978pgv.3
        for <git@vger.kernel.org>; Thu, 04 May 2017 08:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9gI4ekGYvauvNJHN7p7ETar6xRBh+zIaSCzBVnmrc+Q=;
        b=F9szFh+uWPC8YOZcuJ6g5m+LjYVEkRfFF2UWLe2UqXb2KqVkH/lEJNX0a/VhfrBP5a
         yS+2/rp1/ul0zuB8v4wCxHhvFfLgFJfjt05/J58XtH2iSeiKaPbLcbMseCJ9ATvIG98l
         qsJdV/RphsmY5WaWdWkO7Df6OG05WG28X7fs84TS4vabtfid4ITz7lCmj1UeP6qzZFaH
         44dVq04O9gZgLj6ZvKQj+3dmzDrnDUaYKqh2YEA//AO2dJNCTxn9V6bEtVi3d/nUfiG5
         YF38v6ozbKEGpFNOWPfQcTBr76qTYuuF0UDVEeCf0zGptsBWxzON9CJqjZyn7c/rgW+N
         5kNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9gI4ekGYvauvNJHN7p7ETar6xRBh+zIaSCzBVnmrc+Q=;
        b=YnOd7lV9qX/xR6MQh/VRReqApxz4BXJJ1vKzRvWxQDZU/AGxhOz7fbMW+Rft2GzYwH
         y9CLTAEZZWxIVkj57c05wReNmehv53uZQ3j8M/TxTcAt8q9DmvRXvLGP4TfBLmteEKq2
         M1dlc9FH2UxZM4A/0TGo2nEDNF2NUEb4djZA9W5ZfhpXe68hRkkmGFFUhui2Fc3HcCkn
         0tY0GN6xAKQPeAqbOiYsWBSOqgRP0WT9j52Uu39kjPwwSLrLMmhetN6JCNlJv+Wai5ka
         2GcemRwf2V+vQKKoEGMDu0Vu6N/Xax5nBGHXOhHpFhGNRoffo59h+Wvikq457z5KDJHg
         Zwig==
X-Gm-Message-State: AN3rC/47ljLyz0dLvWikWeH6YU+atnug9WLtjsn9Wt0Ly5f9f6PJTH3m
        e0L+jw8l43Kbow==
X-Received: by 10.84.193.129 with SMTP id f1mr57763604pld.97.1493910268045;
        Thu, 04 May 2017 08:04:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:21be:aa3e:8063:4b3])
        by smtp.gmail.com with ESMTPSA id 202sm4406209pfy.83.2017.05.04.08.04.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 04 May 2017 08:04:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] Abide by our own rules regarding line endings
References: <cover.1493728172.git.johannes.schindelin@gmx.de>
        <xmqqpofp9p1r.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1705041129170.4905@virtualbox>
Date:   Thu, 04 May 2017 08:04:26 -0700
In-Reply-To: <alpine.DEB.2.21.1.1705041129170.4905@virtualbox> (Johannes
        Schindelin's message of "Thu, 4 May 2017 11:47:03 +0200 (CEST)")
Message-ID: <xmqq60hgacjp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Well, a couple of comments about your comment:
>
> - we say "shell scripts", but we're sloppy there: they are "Unix shell
>   scripts", as they are executed by Unix shells. As such, it is pretty
>   obvious that they favor Unix line endings, right? And that they do not
>   really handle anything else well, right?

Not really.  I would expect that

	cat A B C

with CRLF line endings (i.e. "cat A B C<CR><LF>") on platforms whose
eol convention is LF to barf due to the missing file whose name is
"C<CR>", while on platforms whose eol convention is CRLF, I do
expect the contents of file C comes at the end of the output.

> - You try to say that it is not okay for shell scripts to be checked
>   out as LF-only when the platform convention for *text* files is CR/LF,
>   right? 

I didn't try to and I didn't say that, I hope.  I think it is not OK
for shell scripts to be checked out with <CR><LF> when the platform
convention for text is <LF>, though.  It may be possible for an
implementation on CRLF platform to tolerate missing <CR> (i.e. a
file in LF convention--instead of treating a lone <LF> as a non-eol
but just a regular "funny" byte, treat it as a normal eol), but that
would be a quality-of-implementation thing.  So when the platform
convention for text files is <CR><LF>, I would have thought that it
was more natural to check out shell scripts as such.

However, I did not think things through when I said "I am not sure
if it is OK for shell scripts not to honor the platform convention,
though."  In a sense, the "cat A B C" example does not have to worry
about the platform convention issue very much.  In real scripts, we
have things like a string literal that spans lines (i.e. do we have
a LF, or a CRLF pair, in between these two lines?) and here
documents (ditto).  To handle these "correctly" while treating shell
scripts mere "text" files, a shell implementation on CRLF platform
has to accept CRLF, pretend as if it saw only LF, do all the
processing as if the eol convention were LF, and convert LF in the
output from the script to CRLF.  I think that is _too_ much to ask
for an implementation, and such an attempt would get corner cases
wrong.  IOW, I was not sure if it is OK for scripts not to honor the
platorm convention when I wrote the message you are responding to,
but I think it probably is not just OK but is the simplest/cleanest
for shell implementations not to honor the platform convention and
instead pretend that they always live in LF-only world.

And all of the above ultimately does not matter.  If the shell you
have on Windows cannot take CRLF files, then our shell script must
be checked out as LF files even on Windows.  My "I am not sure" was
mostly from not knowing how ingrained that "cannot take CRLF files"
was (i.e. I didn't know if there may be some knobs similar to
core.crlf we have that you can toggle for your shell to honor the
platform convention).


