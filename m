Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8B751F859
	for <e@80x24.org>; Fri, 12 Aug 2016 17:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720AbcHLRJD convert rfc822-to-8bit (ORCPT
	<rfc822;e@80x24.org>); Fri, 12 Aug 2016 13:09:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36475 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696AbcHLRJA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 13:09:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id i138so3973805wmf.3
        for <git@vger.kernel.org>; Fri, 12 Aug 2016 10:08:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+BX+u4yaHSDBpDaYD6KdY6ym4wx/RfevO7zlDr17bv8=;
        b=KJ+htsB5jiRe7XiOG6cErVrD28EQdVOBm9nYU7gLsao8FDkLRUPUoC+fTQeuTqm8a8
         ACfwAirUFdu6iEnpQNXarqZksBvRD/nC17ETKfVO501cPLw6hVrpfPMEbKMgBhaDh/d5
         E90zWjxt+Tvikwraexit2TBiC7RvJQw0FH7pH9qtDUzsMbSaJA6+c5gjxJ255/813sFM
         csnskHqLXmKOrKRr9sheFX/mI/sF29Hvby0Zo5fODPNBc4PdxxvEIG8eTvdA5L2IyUNs
         wb4DkhJh3AFJmmjBLToAwVlmRoiKSP9uv7It4CNT3ZGAj8QsnLmN+ESQ96mMVddlgAK9
         4odQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+BX+u4yaHSDBpDaYD6KdY6ym4wx/RfevO7zlDr17bv8=;
        b=Dk9uU2LKvs0/741jAM+bzm7O1UBk6+9176U4msjCrMU+mzB9Tz8zlbul14Qg8hKDG3
         CGK38n/XfgHPCOFdCREdM72OaWtobTktlz1o9WFSKJfnX5ejD02vmsNYvghgVEOLLBnr
         EEMZLziJrPPbHhf2yPgaViz3tHhzG+wh98kDpkEz7tWGH2Qn68Xb3lqqOQNzOSirS1J/
         jQ1ZEz279PVnIroGUXtZkh1ich84SV3SoZJQ/HDYx2RlCARt0lwyPUc4ebABfrnJ6c5I
         KWp0R3lDUsWAwP68nIoEjI5Wn3mvw4de2ua3A6AK6YFiC9KcOMqOjqq25APlsFYLxqhA
         Sv6A==
X-Gm-Message-State: AEkoouspvejwjqMBY1PhrVTos17sSMx8NmUjRFPFmukvrJie1p/r5V/UFKAyFpGLrGO3Jg==
X-Received: by 10.194.87.194 with SMTP id ba2mr18638849wjb.100.1471021732562;
        Fri, 12 Aug 2016 10:08:52 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id jq5sm8362632wjc.20.2016.08.12.10.08.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Aug 2016 10:08:52 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 14/15] convert: add filter.<driver>.process option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAGZ79kaRKROUganF838w29rCkJ592sZvu+q9fo+h4a4sPeDXMQ@mail.gmail.com>
Date:	Fri, 12 Aug 2016 19:08:51 +0200
Cc:	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	mlbright@gmail.com, Eric Wong <e@80x24.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, ben@wijen.net
Content-Transfer-Encoding: 8BIT
Message-Id: <52049A60-6CEB-40E5-A013-409CFC20252F@gmail.com>
References: <20160803164225.46355-1-larsxschneider@gmail.com/> <20160810130411.12419-1-larsxschneider@gmail.com> <20160810130411.12419-15-larsxschneider@gmail.com> <CAGZ79kboxgBRHSa2s7CKZ1Uo=13WT=rT8VHCNJNj_Q9jQzZAYw@mail.gmail.com> <20160812163809.3wdkuqegxfjam2yn@sigill.intra.peff.net> <CAGZ79kaRKROUganF838w29rCkJ592sZvu+q9fo+h4a4sPeDXMQ@mail.gmail.com>
To:	Stefan Beller <sbeller@google.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 12 Aug 2016, at 18:48, Stefan Beller <sbeller@google.com> wrote:
> 
> On Fri, Aug 12, 2016 at 9:38 AM, Jeff King <peff@peff.net> wrote:
>> On Fri, Aug 12, 2016 at 09:33:18AM -0700, Stefan Beller wrote:
>> 
>>>> If the result content is empty then the filter is expected to respond
>>>> with a success status and an empty list.
>>>> ------------------------
>>>> packet:          git< status=success\n
>>>> packet:          git< 0000
>>>> packet:          git< 0000  # empty content!
>>>> packet:          git< 0000  # empty list!
>>>> ------------------------
>>> 
>>> Why do we need the last flush packet? We'd expect as many successes
>>> as we send out contents? Do we plan on interleaving operation, i.e.
>>> Git sends out 10 files but the filter process is not as fast as Git sending
>>> out and the answers trickle in slowly?
>> 
>> There was prior discussion in the thread, but basically, it is there to
>> be able to signal an error that is encountered midway through sending
>> the file (i.e., to say "status=error"). If you do not have a final
>> flush, then you would send nothing, and the receiver would be left
>> wondering if you were successful, or if it simply did not get your error
>> report yet.
> 
>    I did not follow the prior discussion, so I approached this review with
>    no prior knowledge from prior reviews, but instead read through and
>    was asking a lot of questions that came up immediately. In case my
>    questions are too dumb just omit them, but I thought they were good
>    material to answer in a commit message ("Why did we do it this way
>    and not differently").

Thanks! That's very helpful and I will address your questions in the commit
message as anyone looking at this commit in the future will have no prior 
knowledge, too.


> Thanks for the explanation. So this is similar as the situation below
> that we wait for the flush and then an error/success report?

Correct. If we would just process the status packet then we wouldn't
even need to wait for the flush. I added flush because that allows us
to send an arbitrary list of key=value pairs in the future.


>>>> If the filter experiences an error during processing, then it can
>>>> send the status "error". Depending on the `filter.<driver>.required`
>>>> flag Git will interpret that as error but it will not stop or restart
>>>> the filter process.
>>>> ------------------------
>>>> packet:          git< status=success\n
>>> 
>>> So the first success is meaningless essentially?
>>> Would it make sense to move the sucess behind the content sending
>>> in all cases?
>> 
>> No, the first success says "good so far, here's the file content". The
>> second says "I succeeded in sending you the file content".
>> 
>> You _can_ drop the first one, but it may be more convenient for the
>> receiver to know up-front that there was a failure.
> 
> 
> If there was a failure upfront, it would become
> 
> packet:          git< 0000
> # no content is encapsulated here
> packet:          git< 0000
> packet:          git< status=error\n
> packet:          git< 0000

No, a failure upfront would look like this (see documentation):

------------------------
packet:          git< status=error\n
packet:          git< 0000
------------------------

No content and no 2nd key=value pair list is exchanged after an error.



> so from a protocol side I'd claim it doesn't look bad.
> I assume with convenient you mean the implementation
> side of things?
> 
> If we do the success first and then error out halfway, we
> still have to clean up, so I do not see how this impacts
> implementation?

That is true. The reasoning is that an error in between is somewhat
less expected. Therefore additional work is OK.

An error upfront is much more likely because it is also a mechanism
for the filter to reject certain files. If the filter is configured
as "required=false" then this reject would actually be OK.

Thanks,
Lars