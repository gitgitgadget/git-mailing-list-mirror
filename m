Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2117320179
	for <e@80x24.org>; Fri, 17 Jun 2016 13:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847AbcFQNK5 (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 09:10:57 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34196 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbcFQNK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 09:10:56 -0400
Received: by mail-yw0-f193.google.com with SMTP id b75so8764359ywe.1
        for <git@vger.kernel.org>; Fri, 17 Jun 2016 06:10:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZcWBznAN5UW5ItRY3oVscLc35hsoWRj2Fvj/R3rTFQI=;
        b=jkZD32ozOFjthI/OIa2BFeiEDRBlVXsWhVieeIp4CNy0J0EilF5Ww3s2NlKqhvdiml
         rF3zyp+AIIvOBERCNCxaDxc7hotgszyql6KPnuvjbrF7TVS2AKR+vLFrDy5Qi6e5Gcv8
         bjx4IG3X3uYOCDgLML6wGmy8UOisgP9rzSO5xC0R9/J5MGAjvv7TPbI7uDn/7ceM1UHh
         cTjCijS1WxPmJXls9mesc7aAkiO1kB8QvDnY6qiAOL1+D5S+SIrKNocmfZLE9RST2/3I
         p9khCpQnzto5MfKqyVxkmz1P8zOnw7xmMVko5+05YcmwdBGTp1Xf5W4m7vV+dmtkw41X
         N9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZcWBznAN5UW5ItRY3oVscLc35hsoWRj2Fvj/R3rTFQI=;
        b=FT2w+NUsrmO0MotAll6a0mV7TCB21vLXwi5TUcEcd4f5ylhXH0jZy54ml+uFpQ6l/5
         h1ZfoS1lblvZkXQf+AmSXX4iXSntwZstZcRRqNtJnfgSsl50wX5jRtZgRrARucwBxeQY
         wSAZJPDWDM7hBwu3/7+QPFzwq2NORxkY4u9udEe0YRPDn2fjXWhs9uTUs7V2RJNgOAzV
         kfwphSiTRhcWmEFUUoyAWD2ophNfJdIdhT5X5KngEf0ByI7qbKO+lpHo5K+2npPdqtqM
         G1R/SOND/SAfk7jChMgBoFf7seMrSCKLE+Is9U8i/1QRifIHAWisP8ghUql2lioVIhXL
         8iDA==
X-Gm-Message-State: ALyK8tL3OIJStQeMrNhgbvvg35+4C4kfXm3IA3KF7C7JqkpOKpqcSTaE4TE/ANIltBWWGZOrkHl8JCUQMaTc4w==
X-Received: by 10.13.254.130 with SMTP id o124mr1136350ywf.30.1466169055281;
 Fri, 17 Jun 2016 06:10:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.116.193 with HTTP; Fri, 17 Jun 2016 06:10:54 -0700 (PDT)
In-Reply-To: <CAP8UFD1Fi53am5O+RBS4XfHOEF1rdYiNSbWBvhaAUv_9fgJ3Zg@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160615140026.10519-1-pranit.bauva@gmail.com> <20160615140026.10519-7-pranit.bauva@gmail.com>
 <CAPig+cQV3FTGJBvS0Kuc3CNPiwZMZtApT6r8+Ojhw3y7O2VTiw@mail.gmail.com>
 <CAFZEwPNpeD3+6kzY7HDH_ZXcL-Nu0B7jGeM5GMjH7PT0eSTLBw@mail.gmail.com> <CAP8UFD1Fi53am5O+RBS4XfHOEF1rdYiNSbWBvhaAUv_9fgJ3Zg@mail.gmail.com>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Fri, 17 Jun 2016 18:40:54 +0530
Message-ID: <CAFZEwPNnHC=ii=qkR1-i+FM5oPw9JRS5MYOfaEvpsKUO5vwyQw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] bisect--helper: `bisect_write` shell function in C
To:	Christian Couder <christian.couder@gmail.com>
Cc:	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey Christian,

On Fri, Jun 17, 2016 at 2:08 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Thu, Jun 16, 2016 at 9:01 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Hey Eric,
>>
>> On Fri, Jun 17, 2016 at 12:25 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Wed, Jun 15, 2016 at 10:00 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>>>
>>>> Note: bisect_write() uses two variables namely TERM_GOOD and TERM_BAD
>>>> from the global shell script thus we need to pass it to the subcommand
>>>> using the arguments. After the whole conversion, we can remove the extra
>>>> arguments and make the method use the two variables from the global scope
>>>> within the C code.
>>>
>>> You could do this now rather than waiting for later. Instead of
>>> passing these arguments to bisect_write(), create global variables in
>>> this patch and assign them in the BISECT_WRITE case of
>>> cmd_bisect__helper() before calling bisect_write().
>>>
>>> Not necessarily worth a re-roll, but would save you the effort of
>>> having to explain it here and then change it in some later patch.
>>
>> I have actually done it in my next conversion which is converting
>> check_and_set_terms()[1] which also sets those variables to some value
>> so its more appropriate there.
>
> My opinion about this is that using global variables would go against
> a possible future libification of the bisect functionality and might
> be less safe than just adding 2 parameters to a small number of
> functions.
>
> If we think that 2 parameters are too much or that there could be more
> parameters to pass like this, we could just pass a pointer to a
> 'struct bisect_state' or something like that ;-)

I had in mind something about 'struct bisect_state'.

Regards,
Pranit Bauva
