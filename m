Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A50CB20191
	for <e@80x24.org>; Thu,  4 Aug 2016 00:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933154AbcHDAzm (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 20:55:42 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33181 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbcHDAzk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 20:55:40 -0400
Received: by mail-wm0-f66.google.com with SMTP id o80so39043054wme.0
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 17:55:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=0KJTwxNzRhfboLjifLgmP7I6PpQ9LZWrfE4TNDCq87g=;
        b=qHL4CtHW0NGv5m9z6gu0TNubufiCqMCGxOu+VXQxra/R/le3CJNv+A0p/owvYUzbk6
         D4/NGIJ4PJHoSZWQCIjAq/ELDBf2qU6gi/68yUW2i1gcbN/2cpqDfWG8aWEIZ6sTLKxQ
         d6wioDnO8HyM7mJ+ly02allhTGiIfUfGAQX8IPI5wAGfhoCqQFKVMvGvZpK68q7lz688
         7FNXmJrYQdskMooR7Y2rhH8DaIzxSH2ZwkNzgM7eT8/p1yzcU2J9k+weVl9JVfRvONit
         9Vbk7oo3CME9PlavwxStrElfFMmu/kygq12cpT+62svSBm7FxurjBT9+mGmL0eLWmhxx
         B6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=0KJTwxNzRhfboLjifLgmP7I6PpQ9LZWrfE4TNDCq87g=;
        b=C2ANSFlBmLU6x+6p89UmZyEmIiWLcy63owwqOSRbL4yam5Mm9AuaRPHIp84YQ7anVh
         L7kVRNJT8Eqk1lTRHZWvqu22LUdlZewpNhxZJsLll2BbmhaVbXxtMLCIKCreWmgetR09
         rHhLVi46HlaC4G57B5gHmqC9VBrEmoGy5ifEYJOWtlkov7p6oPiSf0Wq31tzu7KXXVFS
         OVZlGA65lr150pl/bUCriotpT8Qn3NZ+l7pZ6dCeOYSe+CY5AFI7d3l3o+cLOLFCOuEp
         kzSgl2mSTAZQPn3lTucZ5rL/cdh3/QlREbht5NS9xJwkxqy5HyI5WWqBjcI8dBem1M57
         p37Q==
X-Gm-Message-State: AEkoousvqvrciCLIgH8c0/if1cSkv8CCQqWc/ERGiYIUWh1SdH6jDq1lLGu41m1dcwqMxw==
X-Received: by 10.28.40.212 with SMTP id o203mr66508835wmo.72.1470271353234;
        Wed, 03 Aug 2016 17:42:33 -0700 (PDT)
Received: from [192.168.1.26] (adbx179.neoplus.adsl.tpnet.pl. [79.184.23.179])
        by smtp.googlemail.com with ESMTPSA id bw9sm10109214wjc.33.2016.08.03.17.42.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Aug 2016 17:42:32 -0700 (PDT)
Subject: Re: [PATCH v3 10/10] convert: add filter.<driver>.process option
To:	Lars Schneider <larsxschneider@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160729233801.82844-11-larsxschneider@gmail.com>
 <2f4743d1-3c93-406d-8b44-da0eb075e65c@gmail.com>
 <5180D54D-92C4-4875-AEB3-801663D70A8B@gmail.com>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Martin-Louis Bright <mlbright@gmail.com>,
	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <744bcf80-5d7e-d149-59a3-e12dd40cbea1@gmail.com>
Date:	Thu, 4 Aug 2016 02:42:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <5180D54D-92C4-4875-AEB3-801663D70A8B@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

[Some of those answers might have been invalidated by v4]

W dniu 01.08.2016 o 19:55, Lars Schneider pisze:
>> On 01 Aug 2016, at 00:19, Jakub Narębski <jnareb@gmail.com> wrote:
>> W dniu 30.07.2016 o 01:38, larsxschneider@gmail.com pisze:
>> [...]

>>> +static int multi_packet_read(int fd_in, struct strbuf *sb, size_t expected_bytes, int is_stream)
>>
>> About name of this function: `multi_packet_read` is fine, though I wonder
>> if `packet_read_in_full` with nearly the same parameters as `packet_read`,
>> or `packet_read_till_flush`, or `read_in_full_packetized` would be better.
> 
> I like `multi_packet_read` and will rename!
 
Errr... what? multi_packet_read() is the current name...
 
>> Also, the problem is that while we know that what packet_read() stores
>> would fit in memory (in size_t), it is not true for reading whole file,
>> which might be very large - for example huge graphical assets like raw
>> images or raw videos, or virtual machine images.  Isn't that the goal
>> of git-LFS solutions, which need this feature?  Shouldn't we have then
>> both `multi_packet_read_to_fd` and `multi_packet_read_to_buf`,
>> or whatever?
> 
> Git LFS works well with the current clean/smudge mechanism that uses the
> same on in memory buffers. I understand your concern but I think this
> improvement is out of scope for this patch series.

True.  

BTW. this means that it cannot share code with fetch / push codebase,
where Git spools from pkt-line to packfile on disk.


>> Also, total_bytes_read could overflow size_t, but then we would have
>> problems storing the result in strbuf.
> 
> Would that check be ok?
> 
> 		if (total_bytes_read > SIZE_MAX - bytes_read)
> 			return 1;  // `total_bytes_read` would overflow and is not representable

Well, if current code doesn't have such check, then I think it would
be all right to not have it either.

Note that we do not use C++ comments.
 
 

>>> +
>>> +	if (is_stream)
>>> +		strbuf_grow(sb, LARGE_PACKET_MAX);           // allocate space for at least one packet
>>> +	else
>>> +		strbuf_grow(sb, st_add(expected_bytes, 1));  // add one extra byte for the packet flush
>>> +
>>> +	do {
>>> +		bytes_read = packet_read(
>>> +			fd_in, NULL, NULL,
>>> +			sb->buf + total_bytes_read, sb->len - total_bytes_read - 1,
>>> +			PACKET_READ_GENTLE_ON_EOF
>>> +		);
>>> +		if (bytes_read < 0)
>>> +			return 1;  // unexpected EOF
>>
>> Don't we usually return negative numbers on error?  Ah, I see that the
>> return is a bool, which allows to use boolean expression with 'return'.
>> But I am still unsure if it is good API, this return value.
> 
> According to Peff zero for success is the usual style:
> http://public-inbox.org/git/20160728133523.GB21311%40sigill.intra.peff.net/

The usual case is 0 for success, but -1 (and not 1) for error.
But I agree with Peff that keeping existing API is better. 

>>> +	);
>>> +	strbuf_setlen(sb, total_bytes_read);
>>> +	return (is_stream ? 0 : expected_bytes != total_bytes_read);
>>> +}
>>> +
>>> +static int multi_packet_write_from_fd(const int fd_in, const int fd_out)
>>
>> Is it equivalent of copy_fd() function, but where destination uses pkt-line
>> and we need to pack data into pkt-lines?
> 
> Correct!

Yes, and we cannot keep the naming convention.  Though maybe mentioning
the equivalence in the comment above function would be good idea...

>>> +	return did_fail;
>>
>> Return true on fail?  Shouldn't we follow example of copy_fd()
>> from copy.c, and return COPY_READ_ERROR, or COPY_WRITE_ERROR,
>> or PKTLINE_WRITE_ERROR?
> 
> OK. How about this?
> 
> static int multi_packet_write_from_fd(const int fd_in, const int fd_out)
> {
> 	int did_fail = 0;
> 	ssize_t bytes_to_write;
> 	while (!did_fail) {
> 		bytes_to_write = xread(fd_in, PKTLINE_DATA_START(packet_buffer), PKTLINE_DATA_MAXLEN);
> 		if (bytes_to_write < 0)
> 			return COPY_READ_ERROR;
> 		if (bytes_to_write == 0)
> 			break;
> 		did_fail |= direct_packet_write(fd_out, packet_buffer, PKTLINE_HEADER_LEN + bytes_to_write, 1);
> 	}
> 	if (!did_fail)
> 		did_fail = packet_flush_gently(fd_out);
> 	return (did_fail ? COPY_WRITE_ERROR : 0);
> }

That's better, I think. 
 
>>> +}
>>> +
>>> +static int multi_packet_write_from_buf(const char *src, size_t len, int fd_out)
>>
>> It is equivalent of write_in_full(), with different order of parameters,
>> but where destination file descriptor expects pkt-line and we need to pack
>> data into pkt-lines?
> 
> True. Do you suggest to reorder parameters? I also would like to rename `src` to `src_in`, OK?

Well, no need to reorder parameters.  Better keep it the same as for
other function.  'src' is input ('source'), 'src_in' is tautologic.

>> NOTE: function description comments?
> 
> What do you mean here?

Sorry for being so cryptic.  What I meant is to think about adding comments
describing new functions just above them.
 
>>  Namely:
>>
>> - for git -> filter:
>>    * read from fd,      write pkt-line to fd  (off_t)
>>    * read from str+len, write pkt-line to fd  (size_t, ssize_t)
>> - for filter -> git:
>>    * read pkt-line from fd, write to fd       (off_t)
> 
> This one does not exist.

Right, because filter output goes to Git via strbuf.
 
>>    * read pkt-line from fd, write to str+len  (size_t, ssize_t)
[...]

>>> +	struct child_process process;
>>> +};
>>> +
>>> +static int cmd_process_map_initialized = 0;
>>> +static struct hashmap cmd_process_map;
>>
>> Reading Documentation/technical/api-hashmap.txt I see that:
>>
>>  `tablesize` is the allocated size of the hash table. A non-0 value indicates
>>  that the hashmap is initialized.
>>
>> So cmd_process_map_initialized is not really needed, is it?
> 
> I copied that from config.c:
> https://github.com/git/git/blob/f8f7adce9fc50a11a764d57815602dcb818d1816/config.c#L1425-L1428
> 
> `git grep "tablesize"` reveals that the check for `tablesize` is only used
> in hashmap.c ... so what approach should we use?

Well, git code is not always the best example... 

>>> +static int apply_protocol2_filter(const char *path, const char *src, size_t len,
>>> +						int fd, struct strbuf *dst, const char *cmd,
>>> +						const int wanted_capability)
>>
[...]

>> This is equivalent to
>>
>>   static int apply_filter(const char *path, const char *src, size_t len, int fd,
>>                           struct strbuf *dst, const char *cmd)
>>
>> Could we have extended that one instead?
> 
> Initially I had one function but that got kind of long ... I prefer two for now.

All right, we could always refactor to avoid code duplication later. 
 

>>> +
>>> +	fflush(NULL);
>>
>> This is the same as in apply_filter(), but I wonder what it is for.
> 
> "If the stream argument is NULL, fflush() flushes all
>  open output streams."
> 
> http://man7.org/linux/man-pages/man3/fflush.3.html

What I wanted to ask was not "what it does?",
but "why we need to flush here?".
 
>> This is very similar to apply_filter(), but the latter uses start_async()
>> from "run-command.h", with filter_buffer_or_fd() as asynchronous process,
>> which gets passed command to run in struct filter_params.  In this
>> function start_protocol2_filter() runs start_command(), synchronous API.
>>
>> Why the difference?
> 
> The protocol V2 requires a sequential processing of the packets. See
> discussion with Junio here:
> http://public-inbox.org/git/xmqqbn1th5qn.fsf%40gitster.mtv.corp.google.com/

I don't know what you want to refer to.  The linked email explains
why we fork/start_async() Git process, and the answer was to support
streaming.

There isn't anything there about why protocol v2 requires sequential /
synchronous processing of file output, that is write file contents in
full, then read, instead of having child write, and Git read and ready
to read (so filter driver can start writing immediately, and do not need
to wait for the other ed to stop writing / finish file).

Best regards,
-- 
Jakub Narębski

