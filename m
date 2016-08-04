Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A097E20226
	for <e@80x24.org>; Thu,  4 Aug 2016 10:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758219AbcHDKTd (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 06:19:33 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37376 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933019AbcHDKT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 06:19:29 -0400
Received: by mail-wm0-f46.google.com with SMTP id i5so371952333wmg.0
        for <git@vger.kernel.org>; Thu, 04 Aug 2016 03:18:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=frSpL7/hGuFFqwWBDi/q9mZAOSzXmd0EIEubb6plz3U=;
        b=DQxZwog6is9W/1ql2+QXxqScLS6azUH1FFBUcV9rqPQulixv0l/qovM0fCpQE+ryQD
         KGWJ058UG9ImG5nHRMiDtYBzJK4XeOfTSoOCmnIp7WUp6pCOOzqUM3SFJJ8g0cykQX4u
         X1SCH52bk91FfP6AaXNszeQaDYqDijbC39OXioAZF0afX57racZyrU3qePboXVUXpD9Y
         ptwp5b2kBOZVoGLb2Nst0k2qM1wBThVa5rfvF4VLyUTMzpRGA3AH/B+0OMEw8bZADiaH
         KDyQuBrEwfD6jVvsStESwbwyFQzel1Yd1cIFpw1Z2MQ/UCtgAvxVpjHhgBQRyiJF8lMO
         4pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=frSpL7/hGuFFqwWBDi/q9mZAOSzXmd0EIEubb6plz3U=;
        b=J1XAMAtz4vqafgRKkPK7epsSEtcoC8ZLn1MyIZDRaRyilQ0P/+srbNqJJWIKT0PUk8
         6/WS1r2YsmkLH32PzYqq/31rK+K5xWZgyAcYC7TOGL2HibpfdurIw+L7/pVfxUzBj7jy
         VVpQddiQCFgFJIfWXW8xIfB5PsldkqBueE1XJqsSbUoAsd1dCsVib9Osi3eAHHHoprSi
         BACbCDrS5W2ZIIjsvDJd597jqaZ0neN4sArLpLZqbPOds8VThZ/IEBnGboHnTPY2FEQ5
         XshssP3V+ZnWUM6jfMlzCgcUDukPywchHLJ/A/irc+bdg0jYdZrhDXXiEfUTbp+bJgeZ
         XgqQ==
X-Gm-Message-State: AEkoousyC/ICOTsu7lDCQ3qult5QofwmKrFRXeYxVj9MQCu4SymdfEizEHH8Pv7g/gniHg==
X-Received: by 10.28.154.208 with SMTP id c199mr30606553wme.102.1470305937176;
        Thu, 04 Aug 2016 03:18:57 -0700 (PDT)
Received: from [192.168.1.26] (adbx179.neoplus.adsl.tpnet.pl. [79.184.23.179])
        by smtp.googlemail.com with ESMTPSA id yz6sm12097567wjb.35.2016.08.04.03.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Aug 2016 03:18:56 -0700 (PDT)
Subject: Re: [PATCH v3 10/10] convert: add filter.<driver>.process option
To:	Lars Schneider <larsxschneider@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160729233801.82844-11-larsxschneider@gmail.com>
 <2f4743d1-3c93-406d-8b44-da0eb075e65c@gmail.com>
 <9DDA993E-2AFD-4C69-8E22-58601EEC8A40@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Martin-Louis Bright <mlbright@gmail.com>,
	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <0b7d7d96-dfdc-54a4-2c24-2aead6743ae1@gmail.com>
Date:	Thu, 4 Aug 2016 12:18:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <9DDA993E-2AFD-4C69-8E22-58601EEC8A40@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

[Some of this answer might have been invalidated by v4;
 I might be away from computer for a few days, so I won't be reviewing]

W dniu 03.08.2016 o 15:10, Lars Schneider pisze:
> On 01 Aug 2016, at 00:19, Jakub Narębski <jnareb@gmail.com> wrote:
>> W dniu 30.07.2016 o 01:38, larsxschneider@gmail.com pisze:
[...]
 
>> Could this whole "send single file" be put in a separate function?
>> Or is it not worth it?
> 
> This function would have almost the same signature as apply_protocol2_filter
> and therefore I would say it's not worth it since the function is not
> crazy long.
 
All right.  Though I would say that if it makes the function more
readable, then it might be worth it.

[...]
>>> +
>>> +	sigchain_push(SIGPIPE, SIG_IGN);
>>
>> Hmmm... ignoring SIGPIPE was good for one-shot filters.  Is it still
>> O.K. for per-command persistent ones?
> 
> Very good question. You are right... we don't want to ignore any errors
> during the protocol... I will remove it.

I was actually just wondering.

Actually the default behavior if SIGPIPE is not ignored (or if the
SIGPIPE signal is not blocked / masked out) is to *terminate* the
writing program, which we do not want.

The correct solution is to check for error during write, and check
if errno is set to EPIPE.  This means that reader (filter driver
process) has closed pipe, usually due to crash, and we need to handle
that sanely, either restarting or quitting while providing sane
information about error to the user.

Well, we might want to set a signal handler for SIGPIPE, not just
simply ignore it (especially for streaming case; stop streaming
if filter driver crashed); though signal handlers are quite limited
about what might be done in them.  But that's for the future.


Read from closed pipe returns EOF; write to closed pipe results in
SIGPIPE and returns -1 (setting errno to EPIPE).
 
>>
>>> +
>>> +	packet_buf_write(&nbuf, "%s\n", filter_type);
>>> +	ret &= !direct_packet_write(process->in, nbuf.buf, nbuf.len, 1);
>>> +
>>> +	if (ret) {
>>> +		strbuf_reset(&nbuf);
>>> +		packet_buf_write(&nbuf, "filename=%s\n", path);
>>> +		ret = !direct_packet_write(process->in, nbuf.buf, nbuf.len, 1);
>>> +	}
>>
>> Perhaps a better solution would be
>>
>>        if (err)
>>        	goto fin_error;
>>
>> rather than this.
> 
> OK, I change it to goto error handling style.

Well, at least try it and check if it makes code more readable.
 
>>> +	if (ret) {
>>> +		strbuf_reset(&nbuf);
>>> +		packet_buf_write(&nbuf, "size=%"PRIuMAX"\n", (uintmax_t)len);
>>> +		ret = !direct_packet_write(process->in, nbuf.buf, nbuf.len, 1);
>>> +	}
>>
>> Or maybe extract writing the header for a file into a separate function?
>> This one gets a bit long...
> 
> Maybe... but I think that would make it harder to understand the protocol. I
> think I would prefer to have all the communication in one function layer.

I don't understand your reasoning here ("make it harder to understand the
protocol").  If you choose good names for function writing header, then
the main function would be the high-level view of protocol, e.g.

   git> <command>
   git> <header>
   git> <contents>
   git> <flush>

   git< <command accepted>
   git< <contents>
   git< <flush>
   git< <sent status>
 
[...]
>>> +
>>> +	if (ret) {
>>> +		filter_result = packet_read_line(process->out, NULL);
>>> +		ret = !strcmp(filter_result, "success");
>>> +	}
>>> +
>>> +	sigchain_pop(SIGPIPE);
>>> +
>>> +	if (ret) {
>>> +		strbuf_swap(dst, &nbuf);
>>> +	} else {
>>> +		if (!filter_result || strcmp(filter_result, "reject")) {
>>> +			// Something went wrong with the protocol filter. Force shutdown!

Don't use C++ one-line comments (that's C99-ism).

>>> +			error("external filter '%s' failed", cmd);
>>> +			kill_protocol2_filter(&cmd_process_map, entry);
>>> +		}
>>> +	}
>>
>> So if Git gets finish signal "success" from filter, it accepts the output.
>> If Git gets finish signal "reject" from filter, it restarts filter (and
>> reject the output - user can retry the command himself / herself).
>> If Git gets any other finish signal, for example "error" (but this is not
>> standarized), then it rejects the output, keeping the unfiltered result,
>> but keeps filtering.
>>
>> I think it is not described in this detail in the documentation of the
>> new protocol.
> 
> Agreed, will add!

That would be nice.

>>> -	return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);
>>> +	if (!ca.drv->clean && ca.drv->process)
>>> +		return apply_protocol2_filter(
>>> +			path, NULL, 0, -1, NULL, ca.drv->process, FILTER_CAPABILITIES_CLEAN
>>> +		);
>>> +	else
>>> +		return apply_filter(path, NULL, 0, -1, NULL, ca.drv->clean);
>>
>> Could we augment apply_filter() instead, so that the invocation is
>>
>>        return apply_filter(path, NULL, 0, -1, NULL, ca.drv, FILTER_CLEAN);
>>
>> Though I am not sure if moving this conditional to apply_filter would
>> be a good idea; maybe wrapper around augmented apply_filter_do()?
> 
> Yes, a wrapper makes it way cleaner!

That's good, because we have quite a few of those constructs. 
And I think the compiler would inline it, so there is no penalty.

>>> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
[...]
>>> +		git branch empty &&
>>> +
>>> +		cat ../test.o >test.r &&
>>
>> Err, the above is just copying file, isn't it?
>> Maybe it was copied from other tests, I have not checked.
> 
> It was created in the "setup" test.
 
What I meant here (among other things) is that you uselessly use
'cat' to copy files:

    +		cp ../test.o test.r &&
 
>>> +		echo "test22" >test2.r &&
>>> +		mkdir testsubdir &&
>>> +		echo "test333" >testsubdir/test3.r &&
>>
>> All right, we test text file, we test binary file (I assume), we test
>> file in a subdirectory.  What about testing empty file?  Or large file
>> which would not fit in the stdin/stdout buffer (as EXPENSIVE test)?
> 
> No binary file. The main reason for this test is to check multiple files.
> I'll add a empty file. A large file is tested in the next test.

I assume that this large file is binary file; what matters is that it
includes NUL character ("\0"), i.e. zero byte, checking that there is
no error that would terminate it at NUL.

I'll end here for now.

-- 
Jakub Narębski

