Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BE051F858
	for <e@80x24.org>; Sun, 31 Jul 2016 21:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbcGaVpN (ORCPT <rfc822;e@80x24.org>);
	Sun, 31 Jul 2016 17:45:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36501 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbcGaVpL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2016 17:45:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id x83so23740542wma.3
        for <git@vger.kernel.org>; Sun, 31 Jul 2016 14:45:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kiXCoq+qK+d02i2JS310EJJu/JkUIzMV/UKEKZc3rBU=;
        b=p2YL/kIqmS1v0lHG1DocQYfRNhLSW8wQGd4ho+nR1fh+XonCows6DrDzC1YMlISId9
         9ItAZST3AlNGAqladiqKxdyTbwKJtswpvXymMiLrEWzrNl8C9njnAi6O0fwg8ZVnLp8K
         JmWVWJECfOgEpNelXLyuZx8/eccR/DGX2RAOYr6l3t8rCzbcKVKhErEwHkAvLKcctpNV
         Ax/rimOOlSBOBoNH+cRIyk8bRkueeMyQ2r/72zW4dT5zKLZi7Rq00i3cPy722LtPBw1M
         EJe5A25+HtPyuYHui5vVDbPrUf5mbQnyOmBV3NvTqaSBBFrYemki2SBAnIfQXeJdQQxV
         4fEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kiXCoq+qK+d02i2JS310EJJu/JkUIzMV/UKEKZc3rBU=;
        b=ecE2Ba/W5t16PkxxPj+Vkr7IWR3cEuB/6QVNYodsGbvmwATDHNrtd6NN0Nwl7VuhOQ
         /D8b2APfKcqMHVZCgc1V8c6CV5Xp9IOnAEsYZFG7bD5oHnpgJB9atSlZ0ZD7tEBrPoJ7
         L/GpPBtik+WVZoMUA0vETinAj0RJb94Aryt7IsWWJ5U+tSVFJj/aChW+hK7cF6r7M3qx
         VD4bvwdK1w5LGSfLr3UysEBR7dJqt1Ub2dvxokoFURJld49aR2HMgtDNZYS3PL3AW9Ia
         3w67joq9RBREA6IlOb/tx6W3PdsX18oLW8aUBYY56m3MzRZPralTCocqpgRKGk0SkDRs
         cj4Q==
X-Gm-Message-State: AEkoouu2xQVA8CFDtJQx6KhMkfBC49D3lBh6FQYK/3QY2WoNdC9L8Vt+IO1/m7Pashak/w==
X-Received: by 10.194.146.165 with SMTP id td5mr52447673wjb.160.1470001509862;
        Sun, 31 Jul 2016 14:45:09 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4D55.dip0.t-ipconnect.de. [93.219.77.85])
        by smtp.gmail.com with ESMTPSA id x6sm27330673wjk.26.2016.07.31.14.45.08
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jul 2016 14:45:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 03/10] pkt-line: add packet_flush_gentle()
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <63231F5B-959F-4A9D-89B9-E4A42AF34AB1@web.de>
Date:	Sun, 31 Jul 2016 23:45:08 +0200
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"jnareb@gmail.com" <jnareb@gmail.com>,
	"mlbright@gmail.com" <mlbright@gmail.com>,
	"e@80x24.org" <e@80x24.org>, "peff@peff.net" <peff@peff.net>
Content-Transfer-Encoding: 8BIT
Message-Id: <8FC2D283-AF8D-4643-834E-3D1927C558C0@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/> <20160729233801.82844-1-larsxschneider@gmail.com> <20160729233801.82844-4-larsxschneider@gmail.com> <63231F5B-959F-4A9D-89B9-E4A42AF34AB1@web.de>
To:	=?utf-8?Q?Torstem_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 31 Jul 2016, at 22:36, Torstem Bögershausen <tboegi@web.de> wrote:
> 
> 
> 
>> Am 29.07.2016 um 20:37 schrieb larsxschneider@gmail.com:
>> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> packet_flush() would die in case of a write error even though for some callers
>> an error would be acceptable.
> What happens if there is a write error ?
> Basically the protocol is out of synch.
> Lenght information is mixed up with payload, or the other way
> around.
> It may be, that the consequences of a write error are acceptable,
> because a filter is allowed to fail.
> What is not acceptable is a "broken" protocol.
> The consequence schould be to close the fd and tear down all
> resources. connected to it.
> In our case to terminate the external filter daemon in some way,
> and to never use this instance again.

Correct! That is exactly what is happening in kill_protocol2_filter()
here:


+static int apply_protocol2_filter(const char *path, const char *src, size_t len,
+						int fd, struct strbuf *dst, const char *cmd,
+						const int wanted_capability)
+{
...
+	if (ret) {
+		strbuf_swap(dst, &nbuf);
+	} else {
+		if (!filter_result || strcmp(filter_result, "reject")) {
+			// Something went wrong with the protocol filter. Force shutdown!
+			error("external filter '%s' failed", cmd);
+			kill_protocol2_filter(&cmd_process_map, entry);
+		}
+	}
+	strbuf_release(&nbuf);
+	return ret;
+}

More context:
https://github.com/larsxschneider/git/blob/e128326070847ac596e8bb21adebc8abab2003fc/convert.c#L821

- Lars


> 
> 
>> Add packet_flush_gentle() which writes a pkt-line
>> flush packet and returns `0` for success and `1` for failure.
>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> pkt-line.c | 6 ++++++
>> pkt-line.h | 1 +
>> 2 files changed, 7 insertions(+)
>> 
>> diff --git a/pkt-line.c b/pkt-line.c
>> index 6fae508..1728690 100644
>> --- a/pkt-line.c
>> +++ b/pkt-line.c
>> @@ -91,6 +91,12 @@ void packet_flush(int fd)
>> write_or_die(fd, "0000", 4);
>> }
>> 
>> +int packet_flush_gentle(int fd)
>> +{
>> +    packet_trace("0000", 4, 1);
>> +    return !write_or_whine_pipe(fd, "0000", 4, "flush packet");
>> +}
>> +
>> void packet_buf_flush(struct strbuf *buf)
>> {
>> packet_trace("0000", 4, 1);
>> diff --git a/pkt-line.h b/pkt-line.h
>> index 02dcced..3953c98 100644
>> --- a/pkt-line.h
>> +++ b/pkt-line.h
>> @@ -23,6 +23,7 @@ void packet_flush(int fd);
>> void packet_write(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
>> void packet_buf_flush(struct strbuf *buf);
>> void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
>> +int packet_flush_gentle(int fd);
>> int direct_packet_write(int fd, char *buf, size_t size, int gentle);
>> int direct_packet_write_data(int fd, const char *buf, size_t size, int gentle);
>> 
>> -- 
>> 2.9.0
>> 

