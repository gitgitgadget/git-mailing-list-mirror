Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 199701F404
	for <e@80x24.org>; Wed,  7 Mar 2018 22:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754921AbeCGWMn (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 17:12:43 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:38425 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754955AbeCGWMl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 17:12:41 -0500
Received: by mail-wr0-f175.google.com with SMTP id n7so3733994wrn.5
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 14:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Y6f1IwRHCgj0lrtUW0hRS9pD3npRhnzzhSchXHrPFVY=;
        b=skuqH6/wrlsBLqnWtIl3g0MVnaxnGjals2aSxypz42+0WraCwstHHChpjr3Ea/+z1B
         XetwCZyYHvhU2GEp05cJ5JfTNjK4oNjIn7FE+rcpvd0hTFtpUxe5neWTfMSRMLMplBZn
         W2nViEffVemSmtS9hyMsowv2SRq14wofwbmSIs+fSVtgHhwdwhm5AsJpqzq02kjJKRWs
         AymB/aZ9VatYTbnJnP+xVEC6ovyetHQDkYY1oe3YMFmDVR4MFhw0r4kEZyGJnmgTkeg4
         2hHAoQbNdrVeZLd+UEjUngzW6Qer+7Czc4WiYYCyfNYGlRRWBxHDnjsVlxPGIBoYhrEf
         roNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Y6f1IwRHCgj0lrtUW0hRS9pD3npRhnzzhSchXHrPFVY=;
        b=RbtnjiYMAQBY4jsWEoMvH4iDiehHkXVXKdlpOaNwW2drZcJaZtDhb5Y879eGKM94tK
         zq0Y+h951jO6yLZdghunVFAMcny4kKo7OgzzFl0VzYA2EAcCtIQr0XPmL6DW6u7jKx9w
         1BpUBumtdhnnbTSRGYLi+gULkpypfxG929zeRsvR85vaZAzlT3XLXDiYw2nKEwHaN4la
         YKm9nNFZRP5fMdltYbfjN5suro63CzUGuagyaLuIdcFxKwoCnRcZRQoYPvklj2p6UndP
         MbKxVBpdRQkoRo8U0OiFwdqyAkr6vOOcc4knmFNCZbz4emDxNvq39HO6Pe8F/LXUqWQO
         MACg==
X-Gm-Message-State: APf1xPAeeRQ1LV2ajoPlklc2QvrbV5ooy4B1VJNYJdZ2c7pRd4q6IdZk
        5BkCZkY6Y4C4VopHkCJ6EBc=
X-Google-Smtp-Source: AG47ELv1JP+CeCgE0JMfbdEJx4DRnkRgtfrD3Rdp9pir3FxGK4qlN33PYLQ0m0l0oj44Pc9Hv3AHbw==
X-Received: by 10.223.187.68 with SMTP id x4mr19284596wrg.80.1520460760613;
        Wed, 07 Mar 2018 14:12:40 -0800 (PST)
Received: from [10.6.133.146] (135.red-80-28-119.staticip.rima-tde.net. [80.28.119.135])
        by smtp.gmail.com with ESMTPSA id m129sm12598516wma.44.2018.03.07.14.12.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Mar 2018 14:12:40 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v10 7/9] convert: check for detectable errors in UTF encodings
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqr2ovzmwo.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 7 Mar 2018 23:12:38 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        git <git@vger.kernel.org>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, sunshine@sunshineco.com,
        peff@peff.net, ramsay@ramsayjones.plus.com,
        Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: 7bit
Message-Id: <B001E8E2-9C98-4136-87A3-4425C50E90DB@gmail.com>
References: <20180307173026.30058-1-lars.schneider@autodesk.com> <20180307173026.30058-8-lars.schneider@autodesk.com> <xmqqr2ovzmwo.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 07 Mar 2018, at 20:49, Junio C Hamano <gitster@pobox.com> wrote:
> 
> lars.schneider@autodesk.com writes:
> 
>> +static int validate_encoding(const char *path, const char *enc,
>> +		      const char *data, size_t len, int die_on_error)
>> +{
>> +	/* We only check for UTF here as UTF?? can be an alias for UTF-?? */
>> +	if (startscase_with(enc, "UTF")) {
>> +		/*
>> +		 * Check for detectable errors in UTF encodings
>> +		 */
>> +		if (has_prohibited_utf_bom(enc, data, len)) {
>> +			const char *error_msg = _(
>> +				"BOM is prohibited in '%s' if encoded as %s");
>> +			/*
>> +			 * This advice is shown for UTF-??BE and UTF-??LE encodings.
>> +			 * We cut off the last two characters of the encoding name
>> +			 # to generate the encoding name suitable for BOMs.
>> +			 */
> 
> Yuck.  The code pretends to abstract away the details in a helper
> has_prohibited_x() yet the caller still knows quite a lot.

True, but has_prohibited_x() cannot create a proper error/advise
message unless we give it more parameters (e.g. path name).
Therefore, I don't see a better way right now.


>> +			const char *advise_msg = _(
>> +				"The file '%s' contains a byte order "
>> +				"mark (BOM). Please use %s as "
>> +				"working-tree-encoding.");
>> +			char *upper_enc = xstrdup_toupper(enc);
>> +			upper_enc[strlen(upper_enc)-2] = '\0';
>> +			advise(advise_msg, path, upper_enc);
>> +			free(upper_enc);
> 
> I think this up-casing is more problematic than without, not from
> the point of view of the internal code, but from the point of view
> of the end user experience.  When the user writes utf16le or
> utf-16le and the data does not trigger the BOM check, we are likely
> to successfully convert it.  I do not see the merit of suggesting
> UTF16 or UTF-16 in such a case, over telling them to just drop the
> byte-order suffix from the encoding names (i.e. utf16 or utf-16).
> 
> If you are trying to force/nudge people in the direction of
> canonical way of spelling things (which may not be a bad idea), then
> "utf16le" as the original input would want to result in "UTF-16"
> with dash in the advise, no?

Correct. In the error messages I kept the encoding name "as-is" and
only in the advise message I used the uppercase variant to steer
people into the canonical direction. My initial reason for this was
that in is_missing_required_utf_bom() we add "BE/LE" to the encoding
in the advise message. Let's say the user used "Utf-16" as encoding.
 Should "BE/LE" be upper case or lower case? To avoid that question 
I made it always upper case.

I also would have liked to advise "UTF-16" instead of "UTF16" as
you suggested. However, that required a few more lines and I wanted
to keep the change to a minimum. I feel this could be added in a
follow up patch.


> On the other hand, if we are not enforcing such a policy decision
> but merely explaining a way to work around this check, then it may
> be better to give a variant with the smaller difference from the
> original (i.e. without up-casing).

See example mentioned above: "Utf-16". How would you handle that?


Thanks,
Lars

