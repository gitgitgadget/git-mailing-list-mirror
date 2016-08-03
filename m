Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BD681F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 23:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932977AbcHCXKH (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 19:10:07 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35679 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932914AbcHCXKG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2016 19:10:06 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so38597159wmg.2
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 16:10:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=s2OnK+i+BsPE8Q2Ozbo3U+uOrwvNG1WgDQdUSUw1NPc=;
        b=IjamZR/BawdEPoFX7pYvITCZBOI8eCwDm9c3ZXtdwbKzeTxch7OA9I/OSQnuNFZrSq
         DGKPevqfnMHXC7XafbhC2tO1ioYPSZjOE+9oQGb4b0rJucuA92YJgW/y6t4QRehf29b9
         +/Hn8WD5G3JZnGTc67fUlUYVJ6j89UjHataTtYVeQ3s7j//KN01/CZQpylWuI27H5U8p
         CEQb7U/zlKShpwCT0Dsw4ZVX3x44zkO2Ppvp6O5I8FKXXML3knw0hR9nAfnzS5OnAZtC
         3iBm5vWjBGokyuBVUV1DiQTPJJGQ97UiANflh6kE8zMw+P+wxzvh+0SCAHSKLdbg1W5s
         XXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=s2OnK+i+BsPE8Q2Ozbo3U+uOrwvNG1WgDQdUSUw1NPc=;
        b=IMouoPaSQoZ5+wiH19n9SBDpeIscZJkwqrAMs/UlPjBsUllnJiL+HTT7Bb5ZdymI90
         HgXCX6Rz8+PXTpX8NNo5fI/fwX/ITbdSV82NQSo8p61HSCPoVAqrLTMD13LASPYeNOt5
         zyFAjnvOMfCHXmy76Grzm8fqX/fOY3Yq15kZBev7n43mXJN/SNiM9LHhfcE0K4ciT7hI
         PS1Tv/9QmI/TpLcUgtCYlRiAIVnyD33YXAh792WftB4UrzUt8L/B6PTIo5mORvFsMjSI
         LSrcXSZSZy2YsLtxETwsuC5XZ/fMDbgI8SpPEjrGSRV9iDrKNKF9E70HjWzI5pkmg+vO
         MEdg==
X-Gm-Message-State: AEkoous9NG5WQvBB87uwIhQmri8yvXiWZ5X6I9OLM2yHXFszzisWYvrn2w6+BdaKWv7C7A==
X-Received: by 10.194.115.4 with SMTP id jk4mr70130016wjb.109.1470265799090;
        Wed, 03 Aug 2016 16:09:59 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB674A.dip0.t-ipconnect.de. [93.219.103.74])
        by smtp.gmail.com with ESMTPSA id k3sm9855158wjf.7.2016.08.03.16.09.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 16:09:58 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 07/12] run-command: add clean_on_exit_handler
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160803225313.pk3tfe5ovz4y3i7l@sigill.intra.peff.net>
Date:	Thu, 4 Aug 2016 01:09:57 +0200
Cc:	git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	tboegi@web.de, mlbright@gmail.com, e@80x24.org
Content-Transfer-Encoding: 8BIT
Message-Id: <74C2CEA6-EAAB-406F-8B37-969654955413@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com> <20160803164225.46355-1-larsxschneider@gmail.com> <20160803164225.46355-8-larsxschneider@gmail.com> <20160803212433.zzdino3ivyem5a2v@sigill.intra.peff.net> <826967FE-BFF8-4387-83F7-AE7036D97FEC@gmail.com> <20160803225313.pk3tfe5ovz4y3i7l@sigill.intra.peff.net>
To:	Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 04 Aug 2016, at 00:53, Jeff King <peff@peff.net> wrote:
> 
> On Thu, Aug 04, 2016 at 12:15:46AM +0200, Lars Schneider wrote:
> 
>>> I'm not clear on why we want this cleanup filter. It looks like you use
>>> it in the final patch to send an explicit shutdown to any filters we
>>> start. But I see two issues with that:
>>> 
>>> 1. This shutdown may come at any time, and you have no idea what state
>>>    the protocol conversation with the filter is in. You could be in
>>>    the middle of sending another pkt-line, or in a sequence of non-command
>>>    pkt-lines where "shutdown" is not recognized.
>> 
>> Maybe I am missing something, but I don't think that can happen because 
>> the cleanup callback is *only* executed if Git exits normally without error. 
>> In that case we would be in a sane protocol state, no?
> 
> OK, then maybe I am doubly missing the point. I thought this cleanup was
> here to hit the case where we call die() and git exits unexpectedly.
> 
> If you only want to cover the "we are done, no errors, goodbye" case,
> then why don't you just write shutdown when we're done?

I think I tried that at some point but the filter code is called from
multiple places and therefore I looked into atexit() (via run-command)
and it seemed easier. Do you have a place in mind where you would call 
the shutdown after all blobs are processed explicitly?


> I realize you may have multiple filters, but I don't think it should be
> run-command's job to iterate over them. You are presumably keeping a
> list of active filters, and should have a function to iterate over that.

Yes, that would be easy.


> Or better yet, do not require a shutdown at all. The filter sees EOF and
> knows there is nothing more to do. If we are in the middle of an
> operation, then it knows git died. If not, then presumably git had
> nothing else to say (and really, it is not the filter's business if git
> saw an error or not).

EOF? The filter is supposed to process multiple files. How would one EOF
indicate that we are done?


> Though...
> 
>> Thanks. The shutdown command is not intended to be a mechanism to tell
>> the filter that everything went well. At this point - as you mentioned -
>> the filter already received all data in the right way. The shutdown
>> command is intended to give the filter some time to perform some post
>> processing before Git returns.
>> 
>> See here for some brainstorming how this feature could be useful
>> in filters similar to Git LFS:
>> https://github.com/github/git-lfs/issues/1401#issuecomment-236133991
> 
> OK, so it is not really "tell the filter to shutdown" but "I am done
> with you, filter, but I will wait for you to tell me you are all done,
> so that I can tell the user".

Correct!


> I'm not sure if calling that "shutdown" makes sense, though. It's almost
> more of a checkpoint (and I wonder if git would ever want to
> "checkpoint" without hanging up the connection).

OK, I agree that the naming might not be ideal. But "checkpoint" does not
convey that it is only executed once after all blobs are filtered?!

I understand that Git might not want to wait for the filter...

- Lars