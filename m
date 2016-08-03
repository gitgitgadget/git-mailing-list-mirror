Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83DE71F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 22:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932848AbcHCWBi (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 18:01:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35609 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932562AbcHCWBh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2016 18:01:37 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so38330278wmg.2
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 15:01:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2gpv+1+J7iy1yUHYYtpNkZJ2fCA0GPD46o8SvbhISig=;
        b=sfGOPlYnYsHUTzsR4CsjdRqlUP8T39XNimZ9MoEV/6pxk3+gSNKlybdi/+OPA1ZQ2F
         R5qiF+f4ctvt7texDTypoqWfLEKNi/dwBofs6HXybuuDVhVz3oj8Nfa2w5g4YX+6IX//
         3FYf1tdy+Z2aUmxoq6Rx7vL0g8RUQm2l8KderGZlyvn4HdA0XCH/J6dnj9da7nrmHO2O
         8co30a7FSP9ii5i5dbexdqK5n/9zoNaWD3H02lbfF38bG3qPanTgBavYuHJbPStFkKy1
         PA1BFlThhdmgzNX8OJP8pLgpTPdBTZkBEGQFpfUS0BYwaKnx23u3jYyiYxxFXmZaWZmH
         EUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2gpv+1+J7iy1yUHYYtpNkZJ2fCA0GPD46o8SvbhISig=;
        b=anB//1MeP5VVCbB4bNYdZ/VNU7DT09VoOlvWF5t9EVTX4GHyQAmyntSgqvGGthL7nm
         33607kafoxs/s2RsmBX0+Ql4HnRD8oNIx0AlrrFcX+RTNfbr24JFASE8w35rdv+aIcmu
         C77kbtJj7Yw97a0dcLaUpEqvkDa4zoiXzEsGfIcrM4qf7KFOs7r/uyYHpv8zOQA87qqc
         +Nsy4Tj+dIII7A92yumJA5Z0PFDu/XQyVNePZZFnj3tNvZojr9so7b+Bq4i4kCM5r806
         8DUfkwhOPIaD7kbaCRfrj1I/Ua79yBoS8gYqO45r+4Bfm9n/Kmi9K3dYJvXfimGjEH2V
         EuEw==
X-Gm-Message-State: AEkoouuUnaqvkfeS6cDDDDxIz5lNH8jqpTW224oVMZhqYjvT5LqdarSji+nhRC+EunByAw==
X-Received: by 10.28.35.86 with SMTP id j83mr65756202wmj.18.1470261695726;
        Wed, 03 Aug 2016 15:01:35 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB674A.dip0.t-ipconnect.de. [93.219.103.74])
        by smtp.gmail.com with ESMTPSA id v189sm427979wmv.12.2016.08.03.15.01.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 15:01:35 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 11/12] convert: add filter.<driver>.process option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAPc5daWH1z3am2hV_U1dE5WA7R+xrOFxgrxV4CN-vhz6uHz8Hw@mail.gmail.com>
Date:	Thu, 4 Aug 2016 00:01:34 +0200
Cc:	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	=?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com, Eric Wong <e@80x24.org>,
	Jeff King <peff@peff.net>
Content-Transfer-Encoding: 8BIT
Message-Id: <87BF726E-E91C-4A6A-82D3-1842F806BE98@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com> <20160803164225.46355-1-larsxschneider@gmail.com> <20160803164225.46355-12-larsxschneider@gmail.com> <xmqq8twd8uld.fsf@gitster.mtv.corp.google.com> <564CA3AD-EA8E-46D3-9564-BF468CAF32B0@gmail.com> <CAPc5daWH1z3am2hV_U1dE5WA7R+xrOFxgrxV4CN-vhz6uHz8Hw@mail.gmail.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 03 Aug 2016, at 23:43, Junio C Hamano <gitster@pobox.com> wrote:
> 
> On Wed, Aug 3, 2016 at 2:37 PM, Lars Schneider <larsxschneider@gmail.com> wrote:
>>> 
>>> I think this was already pointed out in the previous review by Peff,
>>> but a variable "ret" that says "0 is bad" somehow makes it hard to
>>> follow the code.  Perhaps rename it to "int error", flip the meaning,
>>> and if the caller wants this function to return non-zero on success
>>> flip the polarity in the return statement itself, i.e. "return !errors",
>>> may make it easier to follow?
>> 
>> This follows the existing filter function. Please see Peff's later
>> reply here:
> 
> Which I did before mentioning "pointed out in his review".
> 
>> That's why I kept it the way it is. If you prefer the "!errors" approach
>> then I will change that.
> 
> I am not suggesting to change the RETURN VALUE from this function.
> That is why I mentioned "return !errors" to flip the polarity at the end.
> Inside the function, "ret" variable _forces_ the readers to think "this
> function unlike the others signal an error with 0" constantly while
> reading it, and one possible approach to reduce the mental burden
> is to replace "ret" variable with "errors" variable, which is clear to
> anybody that it would be non-zero when we saw error(s).
> 
> Oh, I am not suggesting to _count_ the number of errors by
> mentioning a possible variable name "errors"; the only reason
> why I mentioned that name is because "error" is already
> taken, and "seen_error" is a bit too long.

Agreed. I got that you didn't suggest to change the return value :-)
In order to be consistent I would also adjust the error handling in
the existing apply_filter() function that I renamed to 
apply_single_file_filter() in 11/12. OK?

Thanks,
Lars 

