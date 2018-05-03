Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15E48200B9
	for <e@80x24.org>; Thu,  3 May 2018 01:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbeECBWE (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 21:22:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55005 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbeECBWE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 21:22:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id f6so25681534wmc.4
        for <git@vger.kernel.org>; Wed, 02 May 2018 18:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WE4Ig4taUwfHAriF4zJY2z0sIR2z+XwOgnvU1M9ApHs=;
        b=A0ZZ4SxP238luwIaSQnUuzUYLoG0yVP8smZcpw8Jn4AxClpnwr6eZbqxLDhuTu/DMu
         BGf4jrqFzfGibe0FqS/w0rZaiyBqA7cYPK7DO2V49xFRlEl16DGuQcAOO6UjzepDQFeZ
         0zNnCE6p8djELcJkczWJhXbCGnSo3B/RQ+XWoL5C3e6wEQYQliSEWaC8Vz3l7EcimUYR
         lPg8N4rLt5ZcsQveuS9pokOUdbmOlcteJsQp0g4Z3IN1UXhy69Q7K2u2XaBqohk1Slme
         gTzo5+QbsCk6rJB2LVmqSM6vbbVlweK5mlVSDQK1Y0AiIplJr4HS+pudfN/kvOZPuXJM
         jaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WE4Ig4taUwfHAriF4zJY2z0sIR2z+XwOgnvU1M9ApHs=;
        b=qZjTdW8NT5tPaN5FJI9QlKdyHMRnIE0n1z7NN61koKjFhoEf0YVjZHdcVghfTmiVaN
         ItoRNEBUp82jkM42Tr7yOgOcQwNRhRTMipVryyjbfL6THkN6hQgAGfszTQNq6wq24w+l
         PdrAyZ6BZ6TNr4U7spAkv5pJSz/s0U+Rma4Apc2uEUXLO9cLNJZIji4iThEJXrhYiVfd
         UIdb3z1j+mlLA1QbWV366qS1qE50/krnCv7hSIQC9nrZJd738PlWwCo5jFfbOX6nmw7S
         N/YjW++RdM33qiiVPVI2V/GN6i8PynigS+E353Te4a0zB9pDJB83wTNI6LH7Nwus85jn
         LaLA==
X-Gm-Message-State: ALQs6tBvAr/lMJw2JGpkNq54mgyS1UfY38aD1KXLljIvX4iq+wX6nVzO
        ZOQJuxUupSCv8IRIzNTGrz286veh
X-Google-Smtp-Source: AB8JxZpZi/vgu9O2TH0+PSjeaiyoDNeC7vZwWiQ1a/kezcbX+mSb2uEofVtopJQVlFkS0hlitrlS0g==
X-Received: by 10.28.69.132 with SMTP id l4mr13340052wmi.142.1525310522631;
        Wed, 02 May 2018 18:22:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l37-v6sm22979412wrl.83.2018.05.02.18.22.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 May 2018 18:22:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jason Pyeron" <jpyeron@pdinc.us>
Cc:     <git@vger.kernel.org>
Subject: Re: Blame / annotate with mixed mac line endings?
References: <B8114616E07247C7A78F1DFF91E16A63@ad.pdinc.us>
Date:   Thu, 03 May 2018 10:22:01 +0900
In-Reply-To: <B8114616E07247C7A78F1DFF91E16A63@ad.pdinc.us> (Jason Pyeron's
        message of "Wed, 2 May 2018 19:57:28 -0400")
Message-ID: <xmqqh8npv8hy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jason Pyeron" <jpyeron@pdinc.us> writes:

> Any way to hit git with a stick to treat lone CR as a line break for blame/annotate?

I highly suspect that you would get more help from those whose love
is Git if your inquiry were about a way to ask Git politely to do
what you want to achieve, rather than hitting it with a stick ;-)

Perhaps define a textconv filter to fix the incorrect line endings?
That way, you do not have to rewrite the history only to run blame,
but can pretend as if the contents were all using consistent line
endings (either LF or CRLF) retroactively.

