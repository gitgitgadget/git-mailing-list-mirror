Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1A8D1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 23:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431AbcHJXQC (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 19:16:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33964 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbcHJXQC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 19:16:02 -0400
Received: by mail-wm0-f67.google.com with SMTP id q128so12457049wma.1
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 16:16:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+BVjIW4lHRnzonmPd1YqBq3k1SERd77sYhH50ABQdGA=;
        b=tcuPDaNHN8ZCqKRGwdbAhnB2LOQEkneiah/At+eSUPuHP+RiIulxmD19sZq0M+hlnQ
         QjvqbBnvz4aIBuHbk+X4Edh908gS0yvi+Tpq6FZwOZBAfdG1DHkfifHKneUux/0vNezB
         0LUKBFZFlCr2mkxAofc6TcQgJ4nq/WV49GYlp+BcQnO2i8gRVSx4SkwBv/QwN2NawoHQ
         QB2OeD4pADdPP7jbtIHDiQbvG5PzcTdk2GhPuk9RsVPhHL2TyBdlRg/ttd5ao0SA0OwE
         YN0QfFbzHeYpnROYDzgPmwQqHtNq6pk/oA5BXKpQBkhJLTEJ6hLbSbnMtqheb2xUvWmJ
         50AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+BVjIW4lHRnzonmPd1YqBq3k1SERd77sYhH50ABQdGA=;
        b=a87EFHZQ5q9uCKQFOAaL/6Gre+wH9f/byEH5D8ZcVIUGdPEVSHXnQcEfkCYeqlsQUI
         EBq9EBYz69eHbkwzPwWt/Id2Hwy2Au/745bEfJglNLb0YeB4ra3bF7/laFWLUcd7j5mj
         vUprADA00L9rpsZGp0vcsvvoyF06aqt6xiJN0HrOWpXS7WOdLtgmhusQ635BL27Pz/5j
         yErJ7WwhKk3tah+6xOC8dHYg2ryX2wU8zZE6n881hfwNZkL+Gt9Xy/TjwsZMC9cL27yF
         mixpSJkOP4JkmaADttFHrlSkVnixxpI8AwD7V2Dqtlsk3n1st1zUg2HsMTl04s8qY0bb
         ORRw==
X-Gm-Message-State: AEkoouuI3XqFHFtgg7OTKIku6IREc9LRPzT0kBkKb9b14CKrtNlaNPCsmSO7Sd6/4cvmZQ==
X-Received: by 10.28.41.131 with SMTP id p125mr3382325wmp.15.1470838203474;
        Wed, 10 Aug 2016 07:10:03 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id o4sm43234540wjd.15.2016.08.10.07.10.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 07:10:03 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 05/15] pkt-line: add packet_write_gently_fmt()
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160810134346.6nmf2sudwh56nq76@sigill.intra.peff.net>
Date:	Wed, 10 Aug 2016 16:10:02 +0200
Cc:	git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	mlbright@gmail.com, e@80x24.org, Johannes.Schindelin@gmx.de,
	ben@wijen.net
Content-Transfer-Encoding: 7bit
Message-Id: <E6D0E830-764D-42E5-9F69-340F718B98B2@gmail.com>
References: <20160803164225.46355-1-larsxschneider@gmail.com/> <20160810130411.12419-1-larsxschneider@gmail.com> <20160810130411.12419-6-larsxschneider@gmail.com> <20160810134346.6nmf2sudwh56nq76@sigill.intra.peff.net>
To:	Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 10 Aug 2016, at 15:43, Jeff King <peff@peff.net> wrote:
> 
> On Wed, Aug 10, 2016 at 03:04:01PM +0200, larsxschneider@gmail.com wrote:
> 
>> +int packet_write_gently_fmt(int fd, const char *fmt, ...)
>> +{
>> +	static struct strbuf buf = STRBUF_INIT;
>> +	va_list args;
>> +
>> +	strbuf_reset(&buf);
>> +	va_start(args, fmt);
>> +	format_packet(1, &buf, fmt, args);
>> +	va_end(args);
>> +	packet_trace(buf.buf + 4, buf.len - 4, 1);
>> +	return (write_in_full(fd, buf.buf, buf.len) == buf.len ? 0 : -1);
>> +}
> 
> Could the end of this function just be:
> 
>  return packet_write_gently(fd, buf.buf, buf.len);
> 
> ? I guess we'd prefer to avoid that, because it incurs an extra
> memmove() of the data.

I don't think the memmove would be that expensive. However, format_packet()
already creates the packet_header and packet_write_gently would do the same
again, no?


> Similarly, I'd think this could share code with the non-gentle form
> (which should be able to just call this and die() if returns an error).
> Though sometimes the va_list transformation makes that awkward.

Yeah, the code duplication annoyed me, too. va_list was the reason I did it
that way. Do you think that is something that needs to be addressed in the
series?

Thanks,
Lars
