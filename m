Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72E9B1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934215AbcHJTqM (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:46:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36289 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932616AbcHJTqK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2016 15:46:10 -0400
Received: by mail-wm0-f68.google.com with SMTP id i138so11560146wmf.3
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 12:46:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VYIGYj3L1dmi7ZbW8t1cTOtkcp4nNO26zuoR3VehANI=;
        b=ZuBG1VheXZH4yCkoxsyuWrKXu3grNT8yFq2zxeCE/uim74gUnsgD7+ionREbtwrxmi
         FyhXJKIW46uiVuJdT+yN17i9paTffM8V4rnKD0yQw2K9EgJW9IAx39bMnLPzY+I7Vtt9
         QUsqYXF8w/NWQkwDacaHT7/Qu6IkrRCgo0RQ6HAZobHOF2n3XNW7KuCOVEYvd7K7bd2O
         a9muL3UJs24fhf9u29uTkJ/BbtEUC68ShTxYZouykv/GxlXx+zQBIxq+tECz1ag3TfTf
         tDvRc9nJAoC0Jf6DfBn5c20umQGnop8iA5/eZ7OIjwzTe8t7387dplgkuC1OJQtNaTXF
         Csrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VYIGYj3L1dmi7ZbW8t1cTOtkcp4nNO26zuoR3VehANI=;
        b=S8MfaOT9I888nz8rpg3nRt8SYLNn4+YjxYs2HXUXU745rJ+a9nbpbaT4HvPyi8ulsF
         ngVXtjvdOD4nm002rT8URxsCPv4QYVJH7UyOYIBOwbwxsG0zNa3E6bJmDbsNuMGYsP6z
         H4ndHGDQW4eNqbmOVJo3cGZubZevmrhFFj8xwCYfZ/DEn4UVAeGQhCA9WrCYHWP/VhzU
         TexQ90siTsAwK5siScg13Bb1bfrd100cr/YnZY9lqyBT2PiAIqR/I5yxSbB+FoiNNQVn
         5Akp5U+pCpx/cz6MYbDeI1T8IuNn1iUXkWOVavyFSQkJ4v0snHJaa+rYZjVzXtOrhKS1
         OMDg==
X-Gm-Message-State: AEkooutEhtjzU+u1cCshDXhTK+Md5TQCByTMUx6Is5LQyk3pI+mryc4rn05/i7rclU1+7w==
X-Received: by 10.28.183.134 with SMTP id h128mr3448174wmf.7.1470836208569;
        Wed, 10 Aug 2016 06:36:48 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id l1sm15850686wjk.45.2016.08.10.06.36.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 06:36:47 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 04/15] pkt-line: add packet_write_gently()
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160810132814.gqnipsdwyzjmuqjy@sigill.intra.peff.net>
Date:	Wed, 10 Aug 2016 15:36:45 +0200
Cc:	git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	mlbright@gmail.com, e@80x24.org, Johannes.Schindelin@gmx.de,
	ben@wijen.net
Content-Transfer-Encoding: 8BIT
Message-Id: <434CB5D7-3FC0-4398-9028-135701121E55@gmail.com>
References: <20160803164225.46355-1-larsxschneider@gmail.com/> <20160810130411.12419-1-larsxschneider@gmail.com> <20160810130411.12419-5-larsxschneider@gmail.com> <20160810132814.gqnipsdwyzjmuqjy@sigill.intra.peff.net>
To:	Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 10 Aug 2016, at 15:28, Jeff King <peff@peff.net> wrote:
> 
> On Wed, Aug 10, 2016 at 03:04:00PM +0200, larsxschneider@gmail.com wrote:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> packet_write() has two shortcomings. First, it uses format_packet() which
>> lets the caller only send string data via "%s". That means it cannot be
>> used for arbitrary data that may contain NULs. Second, it will always
>> die on error.
>> 
>> Add packet_write_gently() which writes arbitrary data and returns `0` for
>> success and `-1` for an error.
> 
> So now we have packet_write() and packet_write_gently(), but they differ
> in more than just whether they are gentle. That seems like a weird
> interface.
> 
> Should we either be picking a new name (e.g., packet_write_mem() or
> something), or migrating packet_write() to packet_write_fmt()?

Done in "[PATCH v5 08/15] pkt-line: rename packet_write() to packet_write_fmt()"


>> diff --git a/pkt-line.c b/pkt-line.c
>> index e6b8410..4f25748 100644
>> --- a/pkt-line.c
>> +++ b/pkt-line.c
>> @@ -3,6 +3,7 @@
>> #include "run-command.h"
>> 
>> char packet_buffer[LARGE_PACKET_MAX];
>> +char packet_write_buffer[LARGE_PACKET_MAX];
> 
> Should this be static? I.e., are random other bits of the code allowed
> to write into it (I guess not because it's not declared in pkt-line.h).

static is better!


>> +int packet_write_gently(const int fd_out, const char *buf, size_t size)
>> +{
>> +	if (size > PKTLINE_DATA_MAXLEN)
>> +		return -1;
>> +	packet_trace(buf, size, 1);
>> +	memmove(packet_write_buffer + 4, buf, size);
> 
> It looks like this iteration drops the idea of callers using a
> LARGE_PACKET_MAX buffer and only filling it at "buf+4" with
> PKTLINE_DATA_MAXLEN bytes (which is fine).
> 
> I wonder if we still need PKTLINE_DATA_MAXLEN, or of it is just
> obscuring things. The magic number "4" still appears separately here,
> and it actually makes it harder to see that things are correct.  I.e.,
> doing:
> 
>  if (size > sizeof(packet_write_buffer) - 4)
> 	return -1;
>  memmove(packet_write_buffer + 4, buf, size);
> 
> is more obviously correct, because you do not have to wonder about the
> relationship between the size of your buffer and the macro.
> 
> It might still be worth having PKTLINE_DATA_MAXLEN public, though, if
> callers use it to size their input to packet_write_gently().

I agree. In a later patch I am using PKTLINE_DATA_MAXLEN inside pkt-line.c,
too. I will change it to your suggestion.

For now I would remove PKTLINE_DATA_MAXLEN because it should be an implementation
detail of pkt-line.c (plus it is not used by anyone).

Thanks,
Lars