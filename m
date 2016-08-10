Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 344C31FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 18:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932727AbcHJSHX (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:07:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35870 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889AbcHJSHT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:07:19 -0400
Received: by mail-wm0-f67.google.com with SMTP id i138so11048705wmf.3
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 11:07:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Xw5jHL1KpxRxe5sSfLQQtlcl3neRCiMR+Gnc6TT9GJA=;
        b=HvSx/G5BN3dGwe2WKi/30nIWIL7jGv/gtN27qESE88OLgrRwsegeKR/tYtGxyCANpW
         LmJJsznK1luPuDYtX5RY5/oyHLT8hCzpdQn3q6tyytR1iTyXxXHHCN/pJip/1BtHd87K
         xe0/M7wiZ1+l1b+54feDwi0ERDZ+rvQK18+m7GmEjN1XUsxQcPBSorXjhJmQDf80FsmQ
         Y2Vd0hTUlgCIKaqk4D0/w2fntpjKUBsCaH8BypAunPGae7lv/ZtY0v66zM+mxGruh1Ce
         yjI8xSI95syVb1SV4719/qVYL0Lm22IQ9KnA+okKEf9K85cv5QnBnlRMPoDKb2N/8bdE
         TDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Xw5jHL1KpxRxe5sSfLQQtlcl3neRCiMR+Gnc6TT9GJA=;
        b=DQPjPum+1pWbZRlYXUM1GXvzidr+br+5Ibn88EnrTvF3/+h+4dn7QnNPFXMaYK/1N6
         tThJyLAHq1Q5Ksiu5uVxGULDYuKjSAyeYx7Dt99UC2vMngcqel6E+mD54NA6B16aO8IF
         OdswpvCUubbLlR729WpH8BfTW/fxiyVt89/sZPocYSiwsUbvw0RXzDfcka5zYpIF4K7D
         v1j5hcZl7WchvU6X1pTtnui33BN5fCq5IXMCE3m7xvvAjh+rR1Wiu8G7cOQrDXZJmilt
         EZiKzY/Va8WST1DVnyfF7l/bzUCpHlFw8X4gJ+AC0PngB64NFE3yyD0+VoRL+TPbq67Q
         yJ7Q==
X-Gm-Message-State: AEkoouuE+12XSW8TEqEeyFAoJHqEqJnXSsa37VvYCA7lcyxIYJ/kU3vIK047r2l/8vpJ6g==
X-Received: by 10.28.71.197 with SMTP id m66mr4773167wmi.26.1470851604226;
        Wed, 10 Aug 2016 10:53:24 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id a184sm5980451wmh.1.2016.08.10.10.53.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 10:53:23 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 05/15] pkt-line: add packet_write_gently_fmt()
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqpopg5yqf.fsf@gitster.mtv.corp.google.com>
Date:	Wed, 10 Aug 2016 19:53:22 +0200
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org, jnareb@gmail.com,
	mlbright@gmail.com, e@80x24.org, Johannes.Schindelin@gmx.de,
	ben@wijen.net
Content-Transfer-Encoding: 7bit
Message-Id: <2B2AC073-95AD-42E9-AD3A-23E8E13C66DE@gmail.com>
References: <20160803164225.46355-1-larsxschneider@gmail.com/> <20160810130411.12419-1-larsxschneider@gmail.com> <20160810130411.12419-6-larsxschneider@gmail.com> <20160810134346.6nmf2sudwh56nq76@sigill.intra.peff.net> <xmqqpopg5yqf.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 10 Aug 2016, at 19:18, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Jeff King <peff@peff.net> writes:
> 
>> On Wed, Aug 10, 2016 at 03:04:01PM +0200, larsxschneider@gmail.com wrote:
>> 
>>> +int packet_write_gently_fmt(int fd, const char *fmt, ...)
>>> +{
>>> +	static struct strbuf buf = STRBUF_INIT;
>>> +	va_list args;
>>> +
>>> +	strbuf_reset(&buf);
>>> +	va_start(args, fmt);
>>> +	format_packet(1, &buf, fmt, args);
>>> +	va_end(args);
>>> +	packet_trace(buf.buf + 4, buf.len - 4, 1);
>>> +	return (write_in_full(fd, buf.buf, buf.len) == buf.len ? 0 : -1);
>>> +}
>> 
>> Could the end of this function just be:
>> 
>>  return packet_write_gently(fd, buf.buf, buf.len);
>> 
>> ? I guess we'd prefer to avoid that, because it incurs an extra
>> memmove() of the data.
>> 
>> Similarly, I'd think this could share code with the non-gentle form
>> (which should be able to just call this and die() if returns an error).
>> Though sometimes the va_list transformation makes that awkward.
> 
> Yes.

Peff just posted that he tried the shared code idea but the result
ended up ugly.


> Also regarding the naming, please have "_gently" at the end; that is
> how all other function families with _gently variant are named, I
> think.

OK, I will rename them.

Thanks,
Lars
