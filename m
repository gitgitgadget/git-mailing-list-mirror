Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29795203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 17:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755979AbcG0Rbb (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 13:31:31 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36799 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbcG0Rba convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2016 13:31:30 -0400
Received: by mail-wm0-f67.google.com with SMTP id x83so7464847wma.3
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 10:31:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eHqfRvDm9myHSbqFMi2p6GN/oKli4E0muLTh+/QffK0=;
        b=DbC+rswIBihboh0romn6haVCYxnOXiZghzh46oY2pc0MS0gESYy6lfEioNmRTQBjbc
         WtUOPMMlG57i2htann6gaSAwh485CVecRhlXL3faqsARJ+N0MZAqOtZToSfmWHJCJOOo
         2GBD1br4t0FvryIn4WNAMMzlg6lpxrf8Tso+VFlIS51mqmX305e/2m5BUcG96HlM8E+V
         Y5pi6ZGvtBb2OhhfP2HM+NaLx2OOQco+unI9+3brP1qp6Ild1fXYe8DVbiMeZFeWP/OV
         ReNbqQmPeHARe3rxqZoIuaduL99XlaAHPpwKxLGHlzuoSl7dpQ3dhHhD2nCsxnF5R65p
         mN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eHqfRvDm9myHSbqFMi2p6GN/oKli4E0muLTh+/QffK0=;
        b=cdsmJLyNq1zojw1+zMJqe88ct5IQt4LJsVW6V3qkmCImNbd5YHTL6IzkYu1Nis768f
         VVBOn98irJXfbnPcNpxW4t8hQsiB/T8vIbiBBSkPmnc2mx5+t59nrimg0Go0LHKTiArx
         o6cY5iPjBE1sopcFUImXsTbt/81gNuF/5EVGebIffYMfUKJlBVRbLc9oe8shvJtvbFK4
         khp7wSPqnmCwLNl3fyIYZyaYruUsxwYHR9pTNPPKcNoloOoa0XFD7gFSMEoy5o/WzZsC
         iUBhVJ4vQUihPcBit/THWVt2gRIeNo5Vbhqa4AfMkkI4rJWIo089QFrwoGFpglezRQfB
         eaYA==
X-Gm-Message-State: ALyK8tLxM8YdKJAbN9HgrHPjuzEQQ6dHKfvq7lkZGwFL8IvCNZxquiKaqEsWs/I9GnKtTg==
X-Received: by 10.28.30.1 with SMTP id e1mr55911235wme.77.1469640688806;
        Wed, 27 Jul 2016 10:31:28 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id hb8sm7396909wjd.13.2016.07.27.10.31.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Jul 2016 10:31:28 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 5/5] convert: add filter.<driver>.process option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160727013251.GA12159@sigill.intra.peff.net>
Date:	Wed, 27 Jul 2016 19:31:26 +0200
Cc:	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com,
	jnareb@gmail.com, tboegi@web.de, mlbright@gmail.com,
	remi.galan-alfonso@ensimag.grenoble-inp.fr, pclouds@gmail.com,
	e@80x24.org, ramsay@ramsayjones.plus.com
Content-Transfer-Encoding: 8BIT
Message-Id: <5FE50D2C-5D97-4523-9BE2-88745B3F83EA@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com> <20160727000605.49982-1-larsxschneider@gmail.com> <20160727000605.49982-6-larsxschneider@gmail.com> <20160727013251.GA12159@sigill.intra.peff.net>
To:	Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 27 Jul 2016, at 03:32, Jeff King <peff@peff.net> wrote:
> 
> On Wed, Jul 27, 2016 at 02:06:05AM +0200, larsxschneider@gmail.com wrote:
> 
>> +static off_t multi_packet_read(struct strbuf *sb, const int fd, const size_t size)
>> +{
>> +	off_t bytes_read;
>> +	off_t total_bytes_read = 0;
> 
> I haven't looked carefully at the whole patch yet, but there seems to be
> some type issues here. off_t is a good type for storing the whole size
> of a file (which may be larger than the amount of memory we can
> allocate). But size_t is the right size for an in-memory object.
> 
> This function takes a size_t size, which makes sense if it is meant to
> read everything into a strbuf.
> 
> So I think our total_bytes_read would probably want to be a size_t here,
> too, because it cannot possibly grow larger than that (and that is
> enforced by the loop below). Otherwise you get weirdness like "sb->buf +
> total_bytes_ref" possibly overflowing memory.

OK


>> +	strbuf_grow(sb, size + 1);	// we need one extra byte for the packet flush
> 
> What happens if size is the maximum for size_t here (i.e., 4GB-1 on a
> 32-bit system)?

Would that be an acceptable solution?

if (size + 1 > SIZE_MAX)
	return die("unrepresentable length for filter buffer");

Can you point me to an example in the Git source how this kind of thing should
be handled?


>> +	do {
>> +		bytes_read = packet_read(
>> +			fd, NULL, NULL,
>> +			sb->buf + total_bytes_read, sb->len - total_bytes_read - 1,
>> +			PACKET_READ_GENTLE_ON_EOF
>> +		);
> 
> packet_read() actually returns an int, and may return "-1" on EOF (and
> int is fine because we know that we are constrained to 16-bit values
> by the pkt-line definition). You read it into an "off_t". I _think_ that
> is OK, because I believe POSIX says off_t must be signed. But probably
> "int" is the more correct type here.

OK


>> +		total_bytes_read += bytes_read;
> 
> If you do get "-1", I think you need to detect it here before adjusting
> total_bytes_read.

Correct!


>> +	while (
>> +		bytes_read > 0 && 					// the last packet was no flush
>> +		sb->len - total_bytes_read - 1 > 0 	// we still have space left in the buffer
>> +	);
> 
> And I'm not sure if you need to distinguish between "0" and "-1" when
> checking byte_read here.

We want to finish reading in both cases, no?


> 
>> +	strbuf_setlen(sb, total_bytes_read);
> 
> Passing an off_t to something expecting a size_t, which can involve
> truncation (though I think in practice you really are limited to
> size_t).

OK


>> +static int multi_packet_write(const char *src, size_t len, const int in, const int out)
>> +{
>> +	int ret = 1;
>> +	char header[4];
>> +	char buffer[8192];
>> +	off_t bytes_to_write;
>> +	while (ret) {
>> +		if (in >= 0) {
>> +			bytes_to_write = xread(in, buffer, sizeof(buffer));
> 
> Likewise here, xread() is returning ssize_t. Again, OK if we can assume
> off_t is signed, but it probably makes sense to use the correct type (we
> also know it cannot be larger than 8K, of course).

OK


> Why 8K? The pkt-line format naturally restricts us to just under 64K, so
> why not take advantage of that and minimize the framing overhead for
> large data?

I took inspiration from here for 8K MAX_IO_SIZE:
https://github.com/git/git/blob/master/copy.c#L6

Is this read limit correct? Should I read 8 times to fill a pkt-line?


>> +			if (bytes_to_write < 0)
>> +				ret &= 0;
> 
> I think "&= 0" is unusual for our codebase? Would just writing "= 0" be
> more clear?

Yes!


> We do sometimes do "ret |= something()" but that is in cases where
> "ret" is zero for success, and non-zero (usually -1) otherwise. Perhaps
> your function's error-reporting is inverted from our usual style?

I thought it makes the code easier to read and the filter doesn't care
at what point the error happens anyways. The filter either succeeds
or fails. What style would you suggest?


>> +		set_packet_header(header, bytes_to_write + 4);
>> +		ret &= write_in_full(out, &header, sizeof(header)) == sizeof(header);
>> +		ret &= write_in_full(out, src, bytes_to_write) == bytes_to_write;
>> +	}
> 
> If you look at format_packet(), it pulls a slight trick: we have a
> buffer 4 bytes larger than we need, format into "buf + 4", and then
> write the final size at the beginning. That lets us write() it all in
> one go.
> 
> At first I thought this function was simply reinventing packet_write(),
> but I guess you are trying to avoid the extra copy of the data (once
> into the buffer from xread, and then again via format_packet just to add
> the extra bytes at the beginning).

Yes, that was my intention.


> I agree with what Junio said elsewhere, that there may be a way to make
> the pkt-line code handle this zero-copy situation better. Perhaps
> something like:
> 
>  struct pktline {
> 	/* first 4 bytes are reserved for length header */
> 	char buf[LARGE_PACKET_MAX];
>  };
>  #define PKTLINE_DATA_START(pkt) ((pkt)->buf + 4)
>  #define PKTLINE_DATA_LEN (LARGE_PACKET_MAX - 4)
> 
>  ...
>  struct pktline pkt;
>  ssize_t len = xread(fd, PKTLINE_DATA_START(&pkt), PKTLINE_DATA_LEN);
>  packet_send(&pkt, len);
> 
> Then packet_send() knows that the first 4 bytes are reserved for it. I
> suspect that the strbuf used by format_packet() could get away with
> using such a "struct pktline" too, though in practice I doubt there's
> any real efficiency to be gained (we generally reuse the same strbuf
> over and over, so it will grow once to 64K and get reused).

OK, I will try that.


>> +	ret &= write_in_full(out, "0000", 4) == 4;
> 
> packet_flush() ?
> 
> I know the packet functions are keen on write_or_die() versus
> write_in_full().  That is perhaps something that should be fixed.

Yes, the write_or_die calls were the reason for the manual packet flush. 
I will propose a change for these functions to accommodate non "required"
filters as it is OK when they fail. 


> This was just supposed to be a short note about off_t before eating
> dinner (oops), so I didn't read past here.

Thank you :-)

- Lars