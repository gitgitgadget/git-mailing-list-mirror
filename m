Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38A79203BD
	for <e@80x24.org>; Thu, 14 Jul 2016 22:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbcGNWvR (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 18:51:17 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:33438 "EHLO
	mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbcGNWvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 18:51:16 -0400
Received: by mail-it0-f47.google.com with SMTP id f6so5632211ith.0
        for <git@vger.kernel.org>; Thu, 14 Jul 2016 15:51:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YqFg7yXN1vaeTNKSUathSxS12kzWdU07anVj+YRXVXI=;
        b=cMFwoEcU/ITeIM89TYU3KzHOJjxcegZwTMM6PpgdpcaWVwYkNcWD1zSlhdEl6wp6Bd
         EeJUFPnrCfb0hkY4g9xyRbd7+PA30F85uYV8aEbnL1gXbNhp6tLh9rh6SRILa54OmUU+
         d7l6o1luKvm0JHgtZPg47ST/ceAOx4FQ/z5vpm2wwzr9Ke6x9x4tNVs/zBa/fieJvnPC
         bJXsql+CYsTjFiY3AC4XZ3RJaaQ3kOPMNKFiVcWT7MsKm22ILnZ6+uWXfZkpaQc4lPVb
         eUQGFpa/n298sUKjXWD2KFPrfN+OxAxEs3S8OF0xlmhRE/xMN3mPOT/Uk1U9ljGUqSW+
         5MIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YqFg7yXN1vaeTNKSUathSxS12kzWdU07anVj+YRXVXI=;
        b=cfr5ZqysKvWYHXjA33HzfvBTYtBWEuvyfxDhrrgnxfJqHLthcpQ7vuL56za6l7NBEI
         /fYObUQXV+3DIXpZembYMTQM4hE2WZ8hlpL+Sq7Ic1/OQVtyHqNsItv40tQF3gVrSl3f
         9Wm+Pa4M1ZQ5lCcAqFtWiKI8g9a4TRqYbUZrk1jYKmcCtayMtyBj/2OhhrqEAlW28Hac
         lXoipQ/oVi0CdiacXb94mDBpqqLCCPGX+RDFeMsl/MpTnK2ODQywWiF5gGB16zeqdzpu
         36vTbMpohinz+PR+02/bTGckvBHPUTRf2gLw43z9TEhPMtN+ePSAOSSey2A1/1Qxgfvj
         sx6w==
X-Gm-Message-State: ALyK8tKYf0a1oleTuEJam19M6zoyInRZ/twRZLki+bkU980TlWtG2enu14WnsAM6TDNU5ZcGDTHJ4B2JA0FmfWW5
X-Received: by 10.36.228.138 with SMTP id o132mr26263723ith.49.1468536675243;
 Thu, 14 Jul 2016 15:51:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 14 Jul 2016 15:51:14 -0700 (PDT)
In-Reply-To: <20160714224617.GA22386@sigill.intra.peff.net>
References: <20160714214948.27432-1-sbeller@google.com> <20160714214948.27432-2-sbeller@google.com>
 <20160714224617.GA22386@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 14 Jul 2016 15:51:14 -0700
Message-ID: <CAGZ79kZ=5Jt3p5zUvve2Vy8+esWq5S8X0heGv5Unmtt_KQb8_A@mail.gmail.com>
Subject: Re: [PATCH 1/4] push options: {pre,post}-receive hook learns about
 push options
To:	Jeff King <peff@peff.net>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Dan Wang <dwwang@google.com>, Eric Wong <e@80x24.org>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 3:46 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jul 14, 2016 at 02:49:45PM -0700, Stefan Beller wrote:
>
>> We limit the push options for now
>> * to not exceed an arbitrary count, and
>> * to not exceed an arbitrary size.
>>
>> This serves two purposes:
>> * DoS protection (i.e. one connection can add no more than 32kB
>>   now)
>> * We need to figure out how to handle large (>64kB). Jeff wrote:
>>   > Yes, but people are also happy when they can use a flexible and
>>   > standardized tool to do a thing. I'd be more frustrated when I found out
>>   > that Git's data-pushing protocol has arbitrary limitations (like, say, I
>>   > can't push a data item larger than a single 64K pkt-line), which would
>>   > easily just work with something like HTTP POSTs.
>>   So to keep a way open in the future to deal with large pay loads,
>>   the size is restricted for now.
>
> Should this bit get dropped from the commit message?
>
> -Peff

Right. :/
