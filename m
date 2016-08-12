Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00A3E1F859
	for <e@80x24.org>; Fri, 12 Aug 2016 17:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbcHLRVa convert rfc822-to-8bit (ORCPT
	<rfc822;e@80x24.org>); Fri, 12 Aug 2016 13:21:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33667 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbcHLRV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 13:21:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id o80so4060475wme.0
        for <git@vger.kernel.org>; Fri, 12 Aug 2016 10:21:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZyU8K+AUFHejVaKE4QGcI7pyf9BvtqJl9e2ZhYRRrXc=;
        b=XgM6zTXUfk5qmQ2jP1fmhqS5Gk9pR6wUiWyu8t9lJ+xOw2u82yzGBwLS/1DMIrH4No
         5NmP8YGn6HMBDHdQFOzaCS30BMUwMCWZE4cqmU6iZEsHDJAzHWz9WySu2wA7r3KXp/Xn
         9oSSs4Az8ZZTgXYrxCD5d101XUUcDk35KH8JvBP4EBJ+smjNwdX/6y/RE2kds48Ov1k5
         bZBVaEHTnzt9j66IFdUHMbpHnCNxon+E0myuNy3SmHAF6WXti+59Y6zutrtglGwCuuf+
         TVoOZpOv0P/IxeqCWFYKMKQzFikKbJDJ/UYs99kmBIr4oYeFgBDEsbTbJ3y41so7564C
         qOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZyU8K+AUFHejVaKE4QGcI7pyf9BvtqJl9e2ZhYRRrXc=;
        b=CQthsaXLI5wn8NAmZ5H5GT4sY+/myt+pF9JQ40iFIS6gUx4PB2HvL/ooQB9y8iVhBe
         LbxC5V5VAtTbvRJ2iYrDL5HD9PqvnEOHxu4uvEXRT04/WzchltSmWJoWaIERgN9fLQsR
         6RSqENjA/J9sej1N8waqgT1edLJUf4DeNVyUxoG3kM3/C53Ruov+LRrurr55ZOT4pbWy
         G72DTScFVOua8NoL+o5RuVkNFQB2MCxDY04yhgy36W2xr9VfsnOvMWJ6F+zHcRRui6XN
         O1BFp+AYlIszSNLP6bnRISh9FKkM/hnzUaT3hQpREE7cNFgOQIJh3siz8C7gjqyfZtYg
         m8Jw==
X-Gm-Message-State: AEkoouvGDfgwk0tCWBd8zs9Ozu4S7aVp1EL4H8Qx6EcKBf+y+HFxCMop6OSxY1aeJqv42g==
X-Received: by 10.194.89.73 with SMTP id bm9mr16409019wjb.76.1471022487724;
        Fri, 12 Aug 2016 10:21:27 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id vv2sm8385368wjc.29.2016.08.12.10.21.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Aug 2016 10:21:27 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 14/15] convert: add filter.<driver>.process option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqinv5ykoo.fsf@gitster.mtv.corp.google.com>
Date:	Fri, 12 Aug 2016 19:21:26 +0200
Cc:	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	mlbright@gmail.com, Eric Wong <e@80x24.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, ben@wijen.net
Content-Transfer-Encoding: 8BIT
Message-Id: <EF153355-2DFB-41AE-A298-CCBE69184294@gmail.com>
References: <20160803164225.46355-1-larsxschneider@gmail.com/> <20160810130411.12419-1-larsxschneider@gmail.com> <20160810130411.12419-15-larsxschneider@gmail.com> <CAGZ79kboxgBRHSa2s7CKZ1Uo=13WT=rT8VHCNJNj_Q9jQzZAYw@mail.gmail.com> <20160812163809.3wdkuqegxfjam2yn@sigill.intra.peff.net> <CAGZ79kaRKROUganF838w29rCkJ592sZvu+q9fo+h4a4sPeDXMQ@mail.gmail.com> <52049A60-6CEB-40E5-A013-409CFC20252F@gmail.com> <xmqqinv5ykoo.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 12 Aug 2016, at 19:13, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>>> If we do the success first and then error out halfway, we
>>> still have to clean up, so I do not see how this impacts
>>> implementation?
>> 
>> That is true. The reasoning is that an error in between is somewhat
>> less expected. Therefore additional work is OK.
>> 
>> An error upfront is much more likely because it is also a mechanism
>> for the filter to reject certain files. If the filter is configured
>> as "required=false" then this reject would actually be OK.
> 
> Unless the reasoning is "an error in between is so rare that we are
> OK if the protocol misbehaves and the receiving end omits error
> handing", I am not so sure how "therefore additional work is OK" is
> a reasonable conclusion.

Maybe I need to reword. An error is detected in either way if something
goes wrong. The advantage of the two step status is that if we fail early
then Git does not even need to create structures to read the response.

See Peff's answer here:
http://public-inbox.org/git/20160806121421.bs7n4lhed7phdshb%40sigill.intra.peff.net/
http://public-inbox.org/git/20160805222710.chefh5kiktyzketh%40sigill.intra.peff.net/

Thanks,
Lars