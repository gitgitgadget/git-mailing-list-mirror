Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B549A200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 22:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754899AbcL0WOt (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 17:14:49 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35704 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754730AbcL0WOq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 17:14:46 -0500
Received: by mail-wm0-f66.google.com with SMTP id l2so33611153wml.2
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 14:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ZPXekJ7VS72MkfNfHld1+v45eGgoV9FwtDRMzjSUgig=;
        b=fvYZDJqx7R40J4CidI6FnTifV4J3dhb3xmhOAHIMAjOgIFJ/5nbBiPvhXNj8nrun1o
         hzJlr8iQJ2D04pP0CRt84kFWFMtFy+ApA+P4lOHHOl0A1meIHeNQYf+y6D2CtyVIvo3c
         9NDfuy7JWOVmKOpfEXqg7pNbJY31Ly1iFlR0issJMBNP17zs6rbkHcSvkm3JGweeXuhS
         MuZtyW9PZPmscA2vMa2qjGc1SNKfk8aifgGlQv3xaIi2WMJLZW6D7HhIgEwpLtgTwz5H
         KXVf3TZYT4cvanbW1kWLI+pdJEjfp+SP49V0rjXbHTYcPU1N9vCV+ebZwF1KVHzTCwOI
         Qajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=ZPXekJ7VS72MkfNfHld1+v45eGgoV9FwtDRMzjSUgig=;
        b=g9mnexIPT/bA23nkFq3o3fccFCYhmg02EqwpAjTPzJqPhiHq/dUaiYodvTfaQgHDP8
         lHcIjnESYlXU5eBGf7SlEuu2vqpunoXDpBrgdpV8uI4A0Ldw7temCcKNJTWbv7RX4fa/
         0l9q87RUyfjiQnw9i0OFVvOnMjCZW+A2f9UUSe+rUEvaR/HaNBS42FIUIuLdmx3dgzv7
         Vo7+qZFNjZmBmspVrbyUIBcGAJlwit6p9p9Cn2owLlUwzajCLoS3FWb6z+++MFOkgd1A
         29OYkp6y0G0Ik7JIXugry3tQnTj2P04e9juzcDGzKE40CVuxDAUoBsAatxpIIGweNYLw
         72Mg==
X-Gm-Message-State: AIkVDXJ4MXdb/cBTCkw467vaj+5zWuJSuXNukAE27J07bPSZV9f8YNnK+oCdbTDJ47bFkw==
X-Received: by 10.28.229.144 with SMTP id c138mr24005475wmh.23.1482876884853;
        Tue, 27 Dec 2016 14:14:44 -0800 (PST)
Received: from [192.168.5.102] ([87.116.180.175])
        by smtp.gmail.com with ESMTPSA id w197sm57831372wmd.11.2016.12.27.14.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 14:14:44 -0800 (PST)
Subject: Re: git-apply: warn/fail on *changed* end of line (eol) *only*?
To:     Junio C Hamano <gitster@pobox.com>
References: <ac97f925-d930-0592-0a2a-66c9218b1417@gmail.com>
 <xmqqvau7cqy1.fsf@gitster.mtv.corp.google.com>
 <xmqq8tr1cmf9.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
Newsgroups: gmane.comp.version-control.git
From:   Igor Djordjevic BugA <igor.d.djordjevic@gmail.com>
Message-ID: <00a4a54c-bc8e-9fef-0f70-232c85b0139b@gmail.com>
Date:   Tue, 27 Dec 2016 23:14:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqq8tr1cmf9.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/12/2016 18:27, Junio C Hamano wrote:

> To see the problem with "check existing lines", it probably is
> easier to extend the above example to start from a file with one
> more line, like this:
>
>     1 <CRLF>
>     3 <CRLF>
>     4 <LF>
>     5 <CRLF>
>
> and extend all the example patches to remove "4 <LF>" line as well,
> where they remove "3 <CRLF>", making the first example patch like
> so:
>
>      1 <CRLF>
>     -3 <CRLF>
>     -4 <LF>
>     +three <CRLF>
>      5 <CRLF>
>
> Now, if you take "three <CRLF>" to be replacing "3 <CRLF>", then you
> may feel that not warning on the CRLF would be the right thing, but
> there is no reason (other than the fact you, a human, understand
> what 'three' means) to choose "3 <CRLF>" over "4 <LF>" as the
> original.  If you take "three <CRLF>" to be replacing "4 <LF>", you
> would need to warn.

Hmm, but why do you keep insisting on knowing what the lines are about,
and still making a 'per line' end of line comparison? Besides, your
example falls within the (only?) special case I mentioned as the one Git
probably shouldn`t be acting upon, as both <LF> and <CRLF> are present
among the the old hunk lines already (lines starting with '-').

The logic should be simple, what I tried to describe in the previous
message:

  1. Examine all '-' lines line endings.

  1.1. If not all line endings are the same (like in your example, no
       matter the line content), do nothing.
	
  1.2. If all line endings _are_ the same within the old hunk ('-'
       lines), check if any of the '+' lines (new hunk) has a different
       line ending (still no matter the line content).
	
  1.2.1. If no different line endings among '+' lines in comparison to
         unique line ending found in '-' lines, do nothing.

  1.2.2. If _any_ of the '+' lines _has_ a different line ending in
         comparison to unique line ending found in '-' lines, then do
         warn/fail.
		
This even might seem as the most sensible approach, no matter the
overall project end of line setting, which is exactly why I find it
interesting - it seems to 'just work', being beginner friendly _and_
also watching your back on unexpected end of line changes.

> A totally uninteresting special case is when the original is all
> <CRLF>, but in that case, as you already said in the original
> message, the project wants <CRLF> and you can configure it as such.
> Then <CR> in the line-end <CRLF> won't be mistaken as if it is a
> whitespace character <CR> at the end of a line terminated with <LF>.

But this is exactly the most confusing case, especially for beginners,
where project configuration is incorrect, and you get warned about
'whitespace errors' where all line endings (old/new) are in fact still
the same (confusing).

Yet worse, you don`t get warned of different line endings being applied,
as these are considered 'correct' due to current (incorrect) setting, no
matter the whole file is actually different, which you don`t get warned
about in the first place, and you may discover the file line ending
breakage only when other contributors start complaining.

Also, would it be sensible to account for a possible file inside the
project having different line endings than project in general...? This
would help there as well, without unintentionally breaking the file.

Regards, BugA

P.S. I guess you don`t need me to tell you that, but please feel free
to drop out of this discussion at your own discretion, even though I
enjoy sharing thoughts (and learning new stuff!), I do kind of feel I`m
wasting your time for something that might not be that important, if at
all, otherwise someone would have probably addressed it so far :/
