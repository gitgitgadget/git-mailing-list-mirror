Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9900D20195
	for <e@80x24.org>; Sat, 16 Jul 2016 05:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbcGPFb5 (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 01:31:57 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:35080 "EHLO
	mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbcGPFbz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Jul 2016 01:31:55 -0400
Received: by mail-it0-f49.google.com with SMTP id u186so34762478ita.0
        for <git@vger.kernel.org>; Fri, 15 Jul 2016 22:31:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NA2LNGDIuD4UPvcRLxB7H3r7o0uwKATAlPvLHJmzGDo=;
        b=CnYgn9yKosIUZ7rKMgsq/5J6hHPnqcoOzW6Lfa7aUccSZ/it6xKa4aX63kO5gY5nHa
         Cu3hUh4CBKEeHIlC5rZHeYPrCreHGr2ifJHzDPN76OczRA9OrW6Mb8qF8FiYk9eTCkkE
         vEYTkWFEz6jkAaiqOJNxQNCQIWt0R/RIg/9Rv7NnXFlJQ/DzNTvX2TxtQqqAQYPDh1g2
         VZCICi/Sz7sJXTEei3gM4EeAGz9sJuqTs4yQz3a5fnus4iTiB+0sKmGM9CcWbLItkFC1
         5xlBDnTzU0IHd9qhFmYa/c8eR3MgA2Mu9kEAqFWaIT3pmsQCnx+NOzaOimrCNpzw6YeD
         8oBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NA2LNGDIuD4UPvcRLxB7H3r7o0uwKATAlPvLHJmzGDo=;
        b=A4+eFSVTd+vIuKZ5feNvwSv36of65+hwOXGdZv6Peunit5t8Kh1hluSIBrB4nY/4br
         /b/Xs1DgJK5RKJyW1gs3zXBii00XWxsBxo94HLwvheeyvixH4OFYwGWU11g7yGKTg966
         3jrXDdDxQJfUo2W9IDylmZM91jYrUp64H/kWHsQvbgj76bLhyo/mloIukqipPC81CSTi
         fxqHtrXrneASuVBLlYXIcFql91PmguIjVnp65Zd1c2bV6CRp4cOu+nSzary3vn1OlT4l
         xcHPkjIZkRUdKxNts/+r4/I33bz3x/FuuLvGfTSPjK8nzRalmMhwRo6ix0q/nafcz3Hm
         zosw==
X-Gm-Message-State: ALyK8tK5Thxxr/8VlJnke3viBA03nLoDYkMj/Q5vGLJgjF8CpFl0fZ0v735OZEdCX3sw9MEG6SpOI6nOp8ryRw==
X-Received: by 10.36.81.15 with SMTP id s15mr26378264ita.57.1468647114972;
 Fri, 15 Jul 2016 22:31:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Fri, 15 Jul 2016 22:31:25 -0700 (PDT)
In-Reply-To: <20160715212843.GA5131@dcvr.yhbt.net>
References: <CAP8UFD1BnnRqsv8zrcDDby=KqQ3UCDVdHWTycfDNTeyfLArn5g@mail.gmail.com>
 <2C31984D-310C-4E8C-927B-6D98B7D7570B@gmail.com> <loom.20160715T181543-821@post.gmane.org>
 <20160715194752.f10351ae84346bd533495496@domain007.com> <20160715212843.GA5131@dcvr.yhbt.net>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 16 Jul 2016 07:31:25 +0200
Message-ID: <CACsJy8AZak5LyLhLz-6YX0vB8uevKt--Fe9EAMAe1_=14JaaVQ@mail.gmail.com>
Subject: Re: Plugin mechanism(s) for Git?
To:	Eric Wong <e@80x24.org>
Cc:	Konstantin Khomoutov <kostix+git@007spb.ru>,
	Ben Peart <peartben@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Turner <novalis@novalis.org>,
	Joey Hess <joey@kitenet.net>,
	Ronnie Sahlberg <rsahlberg@google.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 15, 2016 at 11:28 PM, Eric Wong <e@80x24.org> wrote:
> Konstantin Khomoutov <kostix+git@007spb.ru> wrote:
>> Ben Peart <peartben@gmail.com> wrote:
>> > > Lars Schneider wrote:
>> > >
>> > > We could dynamically load libraries but this would force us to
>> > > freeze the ABI as mentioned by Duy:
>> > > http://article.gmane.org/gmane.comp.version-control.git/298463
>> > >
>> >
>> > I wouldn’t be too quick to dismiss dynamically loaded libraries as
>> > there are some distinct advantages over the other patterns especially
>> > performance and simplicity.  I realize it requires us to version the
>> > ABI but there are established patterns to manage this.  It also isn’t
>> > that much different than us having to freeze or version the protocol
>> > for communicating with a remote-helper.
>
> (re-adding dropped CCs)
>
> The critical difference is protocols can be tested and debugged
> in a language/tool-independent way.

Not using dynamic libraries also makes it possible for other git
reimplementations to reuse the same plugins.
-- 
Duy
