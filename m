Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3750E2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 13:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759715AbcHENUO (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 09:20:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35097 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759711AbcHENUN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2016 09:20:13 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so3763943wmg.2
        for <git@vger.kernel.org>; Fri, 05 Aug 2016 06:20:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rOhi8hNnc/fx91kY1jlzJNuazCIhGcGAs841DAhYiDo=;
        b=irWDB4YYXZeNyaZa4zW6SupzT6SJst02BBfKKDdm5gEx3zUxXwQiAOYZZDjnmWF+4o
         IALlvp9EgCiFncU8+nbaaXQGpkSfXdVfsODo/oQ5Wk7Vo/JDOvocxtNBPdo8YuZCPxJw
         0ZpuUrf/pbaf4MIZtipcgZd8xaf2XMnpaWlYVj4/ZLJG7pUWTXq8mVRJ0txntHYYF72M
         71d5s5SLC3hoBGklkRPopMkQoj4HdfulTMRSz77bq+2VuH8tYQAYtYrPtsRtbvV+EOy0
         PRvsNZMTMkZV9eb8vtg0d3YLteg+1yeA4ECm5EassqRBW2VAABXLfrKJx8FjtSpUB23O
         hbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rOhi8hNnc/fx91kY1jlzJNuazCIhGcGAs841DAhYiDo=;
        b=PpC05GVhyCnhuO+av4iy58JAAf09rRJdR60Bn2kv5BfT9vV3FG82xWDtPbpenxt8dr
         UfRDl5nWiAy8eycFh5zDcs0/peVaR89+9GI1i9E3FDHpUTyFnBySCtdQh8d5b044POcR
         VnDrz7Ko8P/UFKIiDXtRutgWo13ZP2itY+vRMp4FY8/jblvmjZVsRADqyEYJSIz0YXev
         vDkuyDum7vQkoc+EagFnv1J64+pHB25PJ7SRinSR6lRmOQH2i624uxU7fnZEjahHNUpH
         V0kLe7zQqrDkeX0HR28jrI8SnDTQFu4GqIBnFjZ6eEYkDHXwLo3do+aVtoi96Y8qhkMI
         VC9Q==
X-Gm-Message-State: AEkoouvUt57biD1VeVkfPhZrnA2pXmjUOZLXU/GZCRJiNEwqNhiY26xsrXzYaXNdQfXY7g==
X-Received: by 10.28.18.149 with SMTP id 143mr3515642wms.28.1470403211563;
        Fri, 05 Aug 2016 06:20:11 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id x133sm8630136wmf.16.2016.08.05.06.20.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Aug 2016 06:20:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 10/10] convert: add filter.<driver>.process option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <0b7d7d96-dfdc-54a4-2c24-2aead6743ae1@gmail.com>
Date:	Fri, 5 Aug 2016 15:20:09 +0200
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Martin-Louis Bright <mlbright@gmail.com>,
	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>
Content-Transfer-Encoding: 8BIT
Message-Id: <DDF7BA11-A9BC-4DEE-B305-8AD12F5BC599@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/> <20160729233801.82844-1-larsxschneider@gmail.com> <20160729233801.82844-11-larsxschneider@gmail.com> <2f4743d1-3c93-406d-8b44-da0eb075e65c@gmail.com> <9DDA993E-2AFD-4C69-8E22-58601EEC8A40@gmail.com> <0b7d7d96-dfdc-54a4-2c24-2aead6743ae1@gmail.com>
To:	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 04 Aug 2016, at 12:18, Jakub Narębski <jnareb@gmail.com> wrote:
> 
> ...
>>>> +
>>>> +	sigchain_push(SIGPIPE, SIG_IGN);
>>> 
>>> Hmmm... ignoring SIGPIPE was good for one-shot filters.  Is it still
>>> O.K. for per-command persistent ones?
>> 
>> Very good question. You are right... we don't want to ignore any errors
>> during the protocol... I will remove it.
> 
> I was actually just wondering.
> 
> Actually the default behavior if SIGPIPE is not ignored (or if the
> SIGPIPE signal is not blocked / masked out) is to *terminate* the
> writing program, which we do not want.
> 
> The correct solution is to check for error during write, and check
> if errno is set to EPIPE.  This means that reader (filter driver
> process) has closed pipe, usually due to crash, and we need to handle
> that sanely, either restarting or quitting while providing sane
> information about error to the user.
> 
> Well, we might want to set a signal handler for SIGPIPE, not just
> simply ignore it (especially for streaming case; stop streaming
> if filter driver crashed); though signal handlers are quite limited
> about what might be done in them.  But that's for the future.
> 
> 
> Read from closed pipe returns EOF; write to closed pipe results in
> SIGPIPE and returns -1 (setting errno to EPIPE).

OK, I think I understand. I will address that in the next round.


>>> ...
>>> Or maybe extract writing the header for a file into a separate function?
>>> This one gets a bit long...
>> 
>> Maybe... but I think that would make it harder to understand the protocol. I
>> think I would prefer to have all the communication in one function layer.
> 
> I don't understand your reasoning here ("make it harder to understand the
> protocol").  If you choose good names for function writing header, then
> the main function would be the high-level view of protocol, e.g.
> 
>   git> <command>
>   git> <header>
>   git> <contents>
>   git> <flush>
> 
>   git< <command accepted>
>   git< <contents>
>   git< <flush>
>   git< <sent status>
> 

OK, I will move the header into a separate function.


>>>> ...
>>>> +		cat ../test.o >test.r &&
>>> 
>>> Err, the above is just copying file, isn't it?
>>> Maybe it was copied from other tests, I have not checked.
>> 
>> It was created in the "setup" test.
> 
> What I meant here (among other things) is that you uselessly use
> 'cat' to copy files:
> 
>    +		cp ../test.o test.r &&

Ah right. No idea why I did that. I'll use cp, of course :-)


>>>> +		echo "test22" >test2.r &&
>>>> +		mkdir testsubdir &&
>>>> +		echo "test333" >testsubdir/test3.r &&
>>> 
>>> All right, we test text file, we test binary file (I assume), we test
>>> file in a subdirectory.  What about testing empty file?  Or large file
>>> which would not fit in the stdin/stdout buffer (as EXPENSIVE test)?
>> 
>> No binary file. The main reason for this test is to check multiple files.
>> I'll add a empty file. A large file is tested in the next test.
> 
> I assume that this large file is binary file; what matters is that it
> includes NUL character ("\0"), i.e. zero byte, checking that there is
> no error that would terminate it at NUL.

Good idea! I will add a small test file with \0 bytes in between to test binaries.


Thanks,
Lars