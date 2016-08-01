Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C61531F855
	for <e@80x24.org>; Mon,  1 Aug 2016 12:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308AbcHAMOH (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 08:14:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35700 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287AbcHAMOE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2016 08:14:04 -0400
Received: by mail-wm0-f67.google.com with SMTP id i5so25901685wmg.2
        for <git@vger.kernel.org>; Mon, 01 Aug 2016 05:14:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hqSZqZEDX+dB7Dk4xSJyzMaDF1isKFM3fkP9dFI87is=;
        b=CG+hLlMdWAbnKsLLBBejE40ose2GSn8+Kt58hgm8FqT5AhuS/jXutwAvlDBb/HDWUd
         aQIMOMOWer28GykfFd+9hgeEVzc5l3f1jHbnydwaXmSDwYi9DcQ8zbe7s+YOkUKGY3q5
         M297h8qeGzrVW9+n9exVZgrHiVmLbzwISwq+jW74sFCCNt6sgif/5UeACBSNgKcM8tQZ
         mJ52FfKYW9MzIoPun14adhkO0M/CYIiVEnaV5FgUeNJuABRgY4Db17NDh2XIO4E5Dso1
         aupiztV/uZD/B53xOHGxos8SBaXO3Y4+q0sIn8CwWE+hdQaK1zrXNO3dO8lNV8bNBH5f
         X3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hqSZqZEDX+dB7Dk4xSJyzMaDF1isKFM3fkP9dFI87is=;
        b=hXth+cmTpGs2DYi75XFKZLrywKWs6GvoPT5zkTbaXsNMUxlJRtD+Gy015xSmcU4Fw+
         DDNt3DYxPNN5oUf55Lx+QCYbHNjaRYMcYkZaZWjONcdfZ9Ep05Ymxjs7hW3WGqIo8HW7
         lp40SCdY1botzlu+uq236pudP624r1+lJ269eLr2nZyQol2GPllrqsn79enDi9/WBbAf
         3V+why4cvREZpA4ZmCIwZ7Vya06Hu4asl/caxPsSDMFkrIejJgYbUclMovhgBAQSFOx6
         zqSVkwzi4z6SeFujs1cLCLa4Qh6HWZWjx1Oa4piofpCdUsPjitKOBdUfzdh1v37bVrKV
         JaOQ==
X-Gm-Message-State: AEkoouuet47268VgmDTLw3G+86XK19puF4rlHKTOZ3puOSDm0UKcNMGZixz5V1ih4atKrg==
X-Received: by 10.194.184.148 with SMTP id eu20mr50322511wjc.137.1470052859503;
        Mon, 01 Aug 2016 05:00:59 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id w129sm16710066wmd.9.2016.08.01.05.00.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Aug 2016 05:00:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 02/10] pkt-line: add direct_packet_write() and direct_packet_write_data()
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <58e4737b-6e0e-565c-2468-05c705dea426@gmail.com>
Date:	Mon, 1 Aug 2016 14:00:53 +0200
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, tboegi@web.de,
	mlbright@gmail.com, Eric Wong <e@80x24.org>,
	Jeff King <peff@peff.net>
Content-Transfer-Encoding: 8BIT
Message-Id: <64783AA5-D579-4783-88E7-E0B3BDE5FDEB@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/> <20160729233801.82844-1-larsxschneider@gmail.com> <20160729233801.82844-3-larsxschneider@gmail.com> <58e4737b-6e0e-565c-2468-05c705dea426@gmail.com>
To:	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 30 Jul 2016, at 12:49, Jakub Narębski <jnareb@gmail.com> wrote:
> 
> W dniu 30.07.2016 o 01:37, larsxschneider@gmail.com pisze:
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> Sometimes pkt-line data is already available in a buffer and it would
>> be a waste of resources to write the packet using packet_write() which
>> would copy the existing buffer into a strbuf before writing it.
>> 
>> If the caller has control over the buffer creation then the
>> PKTLINE_DATA_START macro can be used to skip the header and write
>> directly into the data section of a pkt-line (PKTLINE_DATA_LEN bytes
>> would be the maximum). direct_packet_write() would take this buffer,
>> adjust the pkt-line header and write it.
>> 
>> If the caller has no control over the buffer creation then
>> direct_packet_write_data() can be used. This function creates a pkt-line
>> header. Afterwards the header and the data buffer are written using two
>> consecutive write calls.
> 
> I don't quite understand what do you mean by "caller has control
> over the buffer creation".  Do you mean that caller either can write
> over the buffer, or cannot overwrite the buffer?  Or do you mean that
> caller either can allocate buffer to hold header, or is getting
> only the data?

How about this:

[...]

If the caller creates the buffer then a proper pkt-line buffer with header
and data section can be created. The PKTLINE_DATA_START macro can be used 
to skip the header section and write directly to the data section (PKTLINE_DATA_LEN 
bytes would be the maximum). direct_packet_write() would take this buffer, 
fill the pkt-line header section with the appropriate data length value and 
write the entire buffer.

If the caller does not create the buffer, and consequently cannot leave room
for the pkt-line header, then direct_packet_write_data() can be used. This 
function creates an extra buffer for the pkt-line header and afterwards writes
the header buffer and the data buffer with two consecutive write calls.

---
Is that more clear?

> 
>> 
>> Both functions have a gentle parameter that indicates if Git should die
>> in case of a write error (gentle set to 0) or return with a error (gentle
>> set to 1).
> 
> So they are *_maybe_gently(), isn't it ;-)?  Are there any existing
> functions in Git codebase that take 'gently' / 'strict' / 'die_on_error'
> parameter?

Yes, git grep "gentle" reveals:

wrapper.c:static int memory_limit_check(size_t size, int gentle)
object.c:int type_from_string_gently(const char *str, ssize_t len, int gentle)


>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> pkt-line.c | 30 ++++++++++++++++++++++++++++++
>> pkt-line.h |  5 +++++
>> 2 files changed, 35 insertions(+)
>> 
>> diff --git a/pkt-line.c b/pkt-line.c
>> index 445b8e1..6fae508 100644
>> --- a/pkt-line.c
>> +++ b/pkt-line.c
>> @@ -135,6 +135,36 @@ void packet_write(int fd, const char *fmt, ...)
>> 	write_or_die(fd, buf.buf, buf.len);
>> }
>> 
>> +int direct_packet_write(int fd, char *buf, size_t size, int gentle)
>> +{
>> +	int ret = 0;
>> +	packet_trace(buf + 4, size - 4, 1);
>> +	set_packet_header(buf, size);
>> +	if (gentle)
>> +		ret = !write_or_whine_pipe(fd, buf, size, "pkt-line");
>> +	else
>> +		write_or_die(fd, buf, size);
> 
> Hmmm... in gently case we get the information in the warning that
> it is about "pkt-line", which is missing from !gently case.  But
> it is probably not important.
> 
>> +	return ret;
>> +}
> 
> Nice clean function, thanks to extracting set_packet_header().
> 
>> +
>> +int direct_packet_write_data(int fd, const char *buf, size_t size, int gentle)
> 
> I would name the parameter 'data', rather than 'buf'; IMVHO it
> better describes it.

Agreed!

> 
>> +{
>> +	int ret = 0;
>> +	char hdr[4];
>> +	set_packet_header(hdr, sizeof(hdr) + size);
>> +	packet_trace(buf, size, 1);
>> +	if (gentle) {
>> +		ret = (
>> +			!write_or_whine_pipe(fd, hdr, sizeof(hdr), "pkt-line header") ||
> 
> You can write '4' here, no need for sizeof(hdr)... though compiler would
> optimize it away.

Right, it would be optimized. However, I don't like the 4 there either. OK to use a macro
instead? PKTLINE_HEADER_LEN ?


>> +			!write_or_whine_pipe(fd, buf, size, "pkt-line data")
>> +		);
> 
> Do we want to try to write "pkt-line data" if "pkt-line header" failed?
> If not, perhaps De Morgan-ize it
> 
>  +		ret = !(
>  +			write_or_whine_pipe(fd, hdr, sizeof(hdr), "pkt-line header") &&
>  +			write_or_whine_pipe(fd, buf, size, "pkt-line data")
>  +		);


Original:
		ret = (
			!write_or_whine_pipe(fd, hdr, sizeof(hdr), "pkt-line header") ||
			!write_or_whine_pipe(fd, data, size, "pkt-line data")
		);

Well, if the first write call fails (return == 0), then it is negated and evaluates to true.
I would think the second call is not evaluated, then?!

CPP reference:
"For the built-in logical OR operator, the result is true if either the first or the second 
operand (or both) is true. If the firstoperand is true, the second operand is not evaluated."
http://en.cppreference.com/w/cpp/language/operator_logical

Should I make this more explicit with a if clause?
 

>> +	} else {
>> +		write_or_die(fd, hdr, sizeof(hdr));
>> +		write_or_die(fd, buf, size);
> 
> I guess these two writes (here and in 'gently' case) are unavoidable...

I think so, too.


> 
>> +	}
>> +	return ret;
>> +}
>> +
>> void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
>> {
>> 	va_list args;
>> diff --git a/pkt-line.h b/pkt-line.h
>> index 3cb9d91..02dcced 100644
>> --- a/pkt-line.h
>> +++ b/pkt-line.h
>> @@ -23,6 +23,8 @@ void packet_flush(int fd);
>> void packet_write(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
>> void packet_buf_flush(struct strbuf *buf);
>> void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
>> +int direct_packet_write(int fd, char *buf, size_t size, int gentle);
>> +int direct_packet_write_data(int fd, const char *buf, size_t size, int gentle);
>> 
>> /*
>>  * Read a packetized line into the buffer, which must be at least size bytes
>> @@ -77,6 +79,9 @@ char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
>> 
>> #define DEFAULT_PACKET_MAX 1000
>> #define LARGE_PACKET_MAX 65520
>> +#define PKTLINE_HEADER_LEN 4
>> +#define PKTLINE_DATA_START(pkt) ((pkt) + PKTLINE_HEADER_LEN)
>> +#define PKTLINE_DATA_LEN (LARGE_PACKET_MAX - PKTLINE_HEADER_LEN)
> 
> Those are not used in direct_packet_write() and direct_packet_write_data();
> but they would make them more verbose and less readable.

Good point, I should use them to check for the maximal packet length!

Thanks,
Lars

> 
>> extern char packet_buffer[LARGE_PACKET_MAX];
>> 
>> #endif
>> 
> 

