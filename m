Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ECB8211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 17:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbeL0RLC (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 12:11:02 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43328 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbeL0RLC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 12:11:02 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so9360823pfk.10
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 09:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CPJh8cfhLMWgDc3pueT4zGtaiXXiJFkPsrAT88+Q9iY=;
        b=tnWXFf7P1t6XfGGVG2qOVOEkFmtlNxuifSJEQhpVQSm87/tg5ly/RyrqG6AI7hJXD4
         awao3DjQo6aHvJvp3iJ/a/a+NDJAHihHlvTwEXc9ZS4zt9B2kBd1i5F0jTV85mJYvNVP
         y1ZKID2bzWJK2dmZEmjPNwIdBIhCdIa03wKvxVlAdwvIGYqBzyTDOvH5LZKMp2NanPPe
         u3E1p0Xrg5ROpiEVvgk8aS0QGzaeaW+ol32fvScHXDFhHHWd5dDUHQSjv+MOGW7gBPSt
         8gvSd1zM8i3XD82ygRc1xf4vv0Tzmd40/4fMRwfhebIMj04Eb31vRjba41wf4BZ4M2cB
         MOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CPJh8cfhLMWgDc3pueT4zGtaiXXiJFkPsrAT88+Q9iY=;
        b=rbLFmWSi0KM3QZ+aqxsELpRJuFIXwWemLJNUn41BFZOBdDP4uLdGJZF23raIge5Dpe
         8oS2p9oxFCsmKWuIDGkm1LoUNTEgelB50PPwMcklkpN1PNvKkmncRRCCp8LvDfV1E4yQ
         REJ5KT/J7oBZm522xunAi1R76GAfQBynrYZQO7a8TzdGdAtFmXQIUfr707wYafBzIH9C
         y2sM/VJ1eVM0DYagpHceFHdex44QU1Y2T3tgobbeInvnVP8sqJPc9tOBZpXn5C6oZtCZ
         uq/MoE4HEwhas6zXw+vptm515aZEnN9i3ybsmRiN8MO/34oGkc7/e2uEY9CNp1zd5EUf
         4mWQ==
X-Gm-Message-State: AA+aEWYgD6RMVSA13jgjZlSjcxOfpRwYNOkFYDqsQAIa9daeQAYvx8Ia
        QpZoKLdShqUq/kq+ISZpQ6wG+6b6
X-Google-Smtp-Source: AFSGD/XwHpzPbphIZKA16DJzfuAEfj1xzupv432mOzRCQ5mA66esh1+xuwPHBJQunICCJLcAx5lOOw==
X-Received: by 2002:a62:4641:: with SMTP id t62mr24617107pfa.141.1545930661242;
        Thu, 27 Dec 2018 09:11:01 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id e131sm39746543pfg.75.2018.12.27.09.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 09:11:00 -0800 (PST)
Date:   Thu, 27 Dec 2018 09:10:58 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 8/8] tests: mark tests broken under
 GIT_TEST_PROTOCOL_VERSION=2
Message-ID: <20181227171058.GA146609@google.com>
References: <20181213155817.27666-9-avarab@gmail.com>
 <87pnu51kac.fsf@evledraar.gmail.com>
 <20181214101232.GC13465@sigill.intra.peff.net>
 <87o99o1iot.fsf@evledraar.gmail.com>
 <20181217195713.GA10673@sigill.intra.peff.net>
 <20181217231452.GA13835@google.com>
 <20181218123646.GA30471@sigill.intra.peff.net>
 <87d0pzf0as.fsf@evledraar.gmail.com>
 <xmqqlg4cq6kd.fsf@gitster-ct.c.googlers.com>
 <87va3fdxcd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87va3fdxcd.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:
> On Wed, Dec 26 2018, Junio C Hamano wrote:

>> Hmph.  The other overzealous thing you could do is to strenthen A
>> and "fix" the security issue in v2?  Which letter comes before A in
>> the alphabet? ;-)

Yes, agreed.  This is what I was hinting at in [1] with "it's a plain
bug".

> Sure, but that being useful is predicated on this supposed security
> mechanism being useful and not just security-through-obscurity, as noted
> in side-threads I don't think we have a convincing argument either way
> (and the one we do have is more on the "it's not secure" side).
>
> Of course we had that with v1 all along, but now that v2 is in released
> versions and in this insecure mode, we have a reason to closely look at
> whether we need to be issuing security releases, or doubling down on the
> "SECURITY" wording in git-fetch and then not carrying the mode forward.

Just for the record, as I've already said, I would be strongly against
removing this feature.  I know of multiple populations that make use
of it, and removing it would not serve them well.

Changing defaults and documentation is a separate story.

Sincerely,
Jonathan

[1] https://public-inbox.org/git/20181217231452.GA13835@google.com/
