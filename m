Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF04A1F71B
	for <e@80x24.org>; Fri, 29 Jul 2016 10:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbcG2KiK (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 06:38:10 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35615 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbcG2KiH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2016 06:38:07 -0400
Received: by mail-wm0-f66.google.com with SMTP id i5so15114417wmg.2
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 03:38:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mDe743RHmPRDm+wR/5vBP9AG8+sNu4hXTceSL0wSP9M=;
        b=w1wG/0W8wq9YWTIm1dyYvcI47QdGkY8NECwVZM3c7+34Kq/Xd45XdZhn5WrpYQBm0P
         HrhmSekmkfvKRW7OxA56GprPMTFo2GaV/X7mRjmOKpVo3rK/fnN6w8ogv8xexIy+1lHE
         eNKBiieqWf+k5e/VZKmyqCJs30n2i80kEi/8xu5QPpPE88v1IJ2Dsnkp6mpUqeq1WgkC
         s8SavH8xIuq8K8u+T/oFjM9fI8rZX9MTr5Hd39xFHzQOAvypIE6b9/76CHAOVuXKDlie
         3o6VGvLZoTdj/bjqRut1mNBsqSxa9GwYU53bbAjiTdD07Kf0zQsRFAMSRYtow1pmdmTQ
         SgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mDe743RHmPRDm+wR/5vBP9AG8+sNu4hXTceSL0wSP9M=;
        b=Bt81wAcmeEeI2rG89EwNaOBddRsWdqLEd5l5fWcSaigpKoEzgZAFucR16edCr1WPgW
         fVUXWGp9C4K1A3gH4YkuA8Y3ICthk4BkT9UHiWie/hSaG+ZlQof4wy44JiOsABkDB/uZ
         Qf+FcRnHHAuhSBnrlOT+V2Li0rfEumxY9dUdW/XqmR4o4a8+NutHqqty9KinQ6XRo4lW
         sjOM419CfyK9D6o9LIDM2+nGrMWgc3T2TBhToA4oIMnU7KYH68hszFgD7KdlJHzrbU9q
         aAMllzFUXaQMyhxw6l44WIYYmRRBiPipagZWVL0O6ADtLEHdE1llQQteiD0MaBocXhP9
         4Mwg==
X-Gm-Message-State: AEkooutjEf1F+ywnH0F6IYDiQLSn6dMhcrD/fc8skluf5PfeaHxtEC+yAlF74l7fgDhUTw==
X-Received: by 10.28.109.197 with SMTP id b66mr410248wmi.68.1469788684766;
        Fri, 29 Jul 2016 03:38:04 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id f3sm15932310wjh.2.2016.07.29.03.38.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jul 2016 03:38:04 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 5/5] convert: add filter.<driver>.process option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160727094102.GA31374@starla>
Date:	Fri, 29 Jul 2016 12:38:02 +0200
Cc:	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com,
	jnareb@gmail.com, tboegi@web.de, mlbright@gmail.com,
	remi.galan-alfonso@ensimag.grenoble-inp.fr, pclouds@gmail.com,
	ramsay@ramsayjones.plus.com, peff@peff.net
Content-Transfer-Encoding: 8BIT
Message-Id: <64C7D52F-9030-460C-8F61-4076F5C1DDF6@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com> <20160727000605.49982-1-larsxschneider@gmail.com> <20160727000605.49982-6-larsxschneider@gmail.com> <20160727094102.GA31374@starla>
To:	Eric Wong <e@80x24.org>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 27 Jul 2016, at 11:41, Eric Wong <e@80x24.org> wrote:
> 
> larsxschneider@gmail.com wrote:
>> +static off_t multi_packet_read(struct strbuf *sb, const int fd, const size_t size)
> 
> I'm no expert in C, but this might be const-correctness taken
> too far.  I think basing this on the read(2) prototype is less
> surprising:
> 
>   static ssize_t multi_packet_read(int fd, struct strbuf *sb, size_t size)

Hm... ok. I like `const` because I think it is usually easier to read/understand
functions that do not change their input variables. This way I can communicate
my intention to future people modifying this function!

If this is frowned upon in the Git community then I will add a comment to the
CodingGuidelines and remove the const :)

I agree with your reordering of the parameters, though!

Speaking of coding style... convert.c is already big and gets only bigger 
with this patch (1720 lines). Would it make sense to add a new file 
"convert-pipe-protocol.c"
or something for my additions?


> Also what Jeff said about off_t vs size_t, but my previous
> emails may have confused you w.r.t. off_t usage...
> 
>> +static int multi_packet_write(const char *src, size_t len, const int in, const int out)
> 
> Same comment about over const ints above.
> len can probably be off_t based on what is below; but you need
> to process the loop in ssize_t-friendly chunks.

I think I would prefer to keep it an size_t because that is the
type we get from Git initially. The code will be more clear in v3.


> 
>> +{
>> +	int ret = 1;
>> +	char header[4];
>> +	char buffer[8192];
>> +	off_t bytes_to_write;
> 
> What Jeff said, this should be ssize_t to match read(2) and xread

Agreed.


> 
>> +	while (ret) {
>> +		if (in >= 0) {
>> +			bytes_to_write = xread(in, buffer, sizeof(buffer));
>> +			if (bytes_to_write < 0)
>> +				ret &= 0;
>> +			src = buffer;
>> +		} else {
>> +			bytes_to_write = len > LARGE_PACKET_MAX - 4 ? LARGE_PACKET_MAX - 4 : len;
>> +			len -= bytes_to_write;
>> +		}
>> +		if (!bytes_to_write)
>> +			break;
> 
> The whole ret &= .. style error handling is hard-to-follow and
> here, a source of bugs.  I think the expected convention on
> hitting errors is:
> 
> 	1) stop whatever you're doing
> 	2) cleanup
> 	3) propagate the error to callers
> 
> "goto" is an acceptable way of accomplishing this.
> 
> For example, byte_to_write may still be negative at this point
> (and interpreted as a really big number when cast to unsigned
> size_t) and src/buffer could be stack garbage.

I changed the implementation here so that the &= style
is not necessary anymore. However, I will look into "goto"
for the other areas!


>> +		set_packet_header(header, bytes_to_write + 4);
>> +		ret &= write_in_full(out, &header, sizeof(header)) == sizeof(header);
>> +		ret &= write_in_full(out, src, bytes_to_write) == bytes_to_write;
>> +	}
>> +	ret &= write_in_full(out, "0000", 4) == 4;
>> +	return ret;
>> +}
>> +
> 
>> +static int apply_protocol_filter(const char *path, const char *src, size_t len,
>> +						int fd, struct strbuf *dst, const char *cmd,
>> +						const char *filter_type)
>> +{
> 
> <snip>
> 
>> +	if (fd >= 0 && !src) {
>> +		ret &= fstat(fd, &file_stat) != -1;
>> +		len = file_stat.st_size;
> 
> Same truncation bug I noticed earlier; what I originally meant
> is the `len' arg probably ought to be off_t, here, not size_t.
> 32-bit x86 Linux systems have 32-bit size_t (unsigned), but
> large file support means off_t is 64-bits (signed).

OK. Would it be OK to keep size_t for this patch series?


> Also, is it worth continuing this function if fstat fails?

No :-)


>> +	}
>> +
>> +	sigchain_push(SIGPIPE, SIG_IGN);
>> +
>> +	packet_write(process->in, "%s\n", filter_type);
>> +	packet_write(process->in, "%s\n", path);
>> +	packet_write(process->in, "%zu\n", len);
> 
> I'm not sure if "%zu" is portable since we don't do C99 (yet?)
> For 64-bit signed off_t, you can probably do:
> 
> 	packet_write(process->in, "%"PRIuMAX"\n", (uintmax_t)len);
> 
> Since we don't have PRIiMAX or intmax_t, here, and a negative
> len would be a bug (probably from failed fstat) anyways.

OK. "%zu" is not used in the entire code base. I will go with
your suggestion!


>> +	ret &= multi_packet_write(src, len, fd, process->in);
> 
> multi_packet_write will probably fail if fstat failed above...

Yes. The error handling is bogus... I thought bitwise "and" would
act the same way as logical "and" (a bit embarrassing to admit that...).


> 
>> +	strbuf = packet_read_line(process->out, NULL);
> 
> And this may just block or timeout if multi_packet_write failed.

True, but unless there is anything easy to do I would leave that.
Or do you think it is really necessary to introduce "select" and
friends?


Thanks a lot for your review,
Lars