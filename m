Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AE291F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 22:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932959AbcHCWPv (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 18:15:51 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38592 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932932AbcHCWPu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 18:15:50 -0400
Received: by mail-wm0-f48.google.com with SMTP id o80so355818806wme.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 15:15:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=76mcyacS5rQocAL0VX5Uzl4BfUsGgCLXAmT9iSg/GBM=;
        b=Q5dfoOywpIwjrpbelPQlYlJbOzKDoou4NkvKjnNGCdrtkk+jXKpzHHn2qjWVtLQecL
         LKpu6qFGk/nfMwMgx2wNriMeOjMOnfKpIoYeCpTRq92uDSvUf2rPIiwnDgHJ9MX93ozC
         gzsbCreTIscDhC72veo4kl33UaiUg6DktQbcORxVymTyxF2bSpnJPG3JLKN7M2OXg2Kj
         RSbclkS/95jxvRYZX5tWhyYQCcxeBp3t0jPH5ksWipRJ0XG0E+fAipxWp4twxy6Pmek/
         SapBl3uPsHXXMw1AarofZRxIVd0SswLYInUX8RSiTTVexdyB3BHvEBhKoLQIzI/BzeQG
         GJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=76mcyacS5rQocAL0VX5Uzl4BfUsGgCLXAmT9iSg/GBM=;
        b=MMeQdNQI0YnjEqnEip5IlPlbd7YXTXQah2wODFc6gvV00rX/F/WJKaOjStIZKMIOwZ
         NoRpUlMsEL1Au9rr07ILGVvgXKdbTxKVQxGtXpDa06x2hnLZZ9r92KVm5PHwPR6cx1ce
         HUvy4wHjggsCB3zAOF15J2MwY2HwT/1IAVMKccsRF8aL/aAHQxyo2an8bI1sXA3Q2E5G
         QwRJkR+6zcgdi/PpKmZrswhdDqJTthY8izOaaMFbcWoj4FW6loZuHs7mxZ/Q3xwdOX1t
         A/9ky50EWdGmyuUipu1eDSQvqqlAHfkrQOuL513zGy6ostuVZr2cBVE3OWSaNUb0bNf1
         nAgg==
X-Gm-Message-State: AEkoousXh3MM+81gGNERox8SjahCy8YhzpwyOnc+JnToFFRPkGl4BnZW2LNE9J3BzHWLSA==
X-Received: by 10.194.110.229 with SMTP id id5mr69963664wjb.23.1470262548833;
        Wed, 03 Aug 2016 15:15:48 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB674A.dip0.t-ipconnect.de. [93.219.103.74])
        by smtp.gmail.com with ESMTPSA id bj8sm9648975wjc.49.2016.08.03.15.15.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 15:15:47 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 07/12] run-command: add clean_on_exit_handler
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160803212433.zzdino3ivyem5a2v@sigill.intra.peff.net>
Date:	Thu, 4 Aug 2016 00:15:46 +0200
Cc:	git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	tboegi@web.de, mlbright@gmail.com, e@80x24.org
Content-Transfer-Encoding: 7bit
Message-Id: <826967FE-BFF8-4387-83F7-AE7036D97FEC@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com> <20160803164225.46355-1-larsxschneider@gmail.com> <20160803164225.46355-8-larsxschneider@gmail.com> <20160803212433.zzdino3ivyem5a2v@sigill.intra.peff.net>
To:	Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 03 Aug 2016, at 23:24, Jeff King <peff@peff.net> wrote:
> 
> On Wed, Aug 03, 2016 at 06:42:20PM +0200, larsxschneider@gmail.com wrote:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> Some commands might need to perform cleanup tasks on exit. Let's give
>> them an interface for doing this.
>> 
>> Please note, that the cleanup callback is not executed if Git dies of a
>> signal. The reason is that only "async-signal-safe" functions would be
>> allowed to be call in that case. Since we cannot control what functions
>> the callback will use, we will not support the case. See 507d7804 for
>> more details.
> 
> I'm not clear on why we want this cleanup filter. It looks like you use
> it in the final patch to send an explicit shutdown to any filters we
> start. But I see two issues with that:
> 
>  1. This shutdown may come at any time, and you have no idea what state
>     the protocol conversation with the filter is in. You could be in
>     the middle of sending another pkt-line, or in a sequence of non-command
>     pkt-lines where "shutdown" is not recognized.

Maybe I am missing something, but I don't think that can happen because 
the cleanup callback is *only* executed if Git exits normally without error. 
In that case we would be in a sane protocol state, no?


>  2. If your protocol does bad things when it is cut off in the middle
>     without an explicit shutdown, then it's a bad protocol. As you
>     note, this patch doesn't cover signal death, nor could it ever
>     cover something like "kill -9", or a bug which prevented git from
>     saying "shutdown".
> 
>     You're much better off to design the protocol so that a premature
>     EOF is detected as an error.  For example, if we're feeding file
>     data to the filter, and we're worried it might be writing it to
>     a data store (like LFS), we would not want it to see EOF and say
>     "well, I guess I got all the data; time to store this!". Instead,
>     it should know how many bytes are coming, or should have some kind
>     of framing so that the sender says "and now you have seen all the
>     bytes" (like a pkt-line flush).
> 
>     AFAIK, your protocol _does_ do those things sensibly, so this
>     explicit shutdown isn't really accomplishing anything.

Thanks. The shutdown command is not intended to be a mechanism to tell
the filter that everything went well. At this point - as you mentioned -
the filter already received all data in the right way. The shutdown
command is intended to give the filter some time to perform some post
processing before Git returns.

See here for some brainstorming how this feature could be useful
in filters similar to Git LFS:
https://github.com/github/git-lfs/issues/1401#issuecomment-236133991

- Lars

