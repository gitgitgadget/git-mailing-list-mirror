Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 115D91F404
	for <e@80x24.org>; Tue,  6 Mar 2018 17:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753344AbeCFRDg (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 12:03:36 -0500
Received: from mail-pl0-f45.google.com ([209.85.160.45]:35810 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752055AbeCFRDf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 12:03:35 -0500
Received: by mail-pl0-f45.google.com with SMTP id w22-v6so999083pll.2
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 09:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iiYbTR/RZLgNVCfSU4/SLP3wHGggAr7hTruoGOG+y28=;
        b=ISQQbSW8GG6NHvskV+RFfLyTmixYOv0Zls8nPBPyy+0Ib+S2Qxj44VlkFd1L2H3r6p
         grvAD3e9TX4hWpgsFyy9BB5vqLPk82gka+bsDwiPPSWp51HhoNzw5Lm4ygWJD9arWgAJ
         Lhsp4v+PuhEvIy16mIKRLugAWzPIs6X85Mnx7lf76vUaZ77jI/oS4fhhRUxH4FE6dm8T
         UgR4mqo2Rt8bEx+OqjTG3oL8j0IdaC+BCv0icwnwF1/7KmK4ROt/ZdzVwRSP2YpTtHJo
         xAoW/7enQAcu1pcYvoHf2IY5rio7BhWQKTT/KYsIpKrd9w0iYqKaCceaoM372yJwLvoe
         4hKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iiYbTR/RZLgNVCfSU4/SLP3wHGggAr7hTruoGOG+y28=;
        b=btbw3rqI1aI3rR7S8bloiQ1sMEntd7Ao9LZUhaM3hTUmfydEMYPLdVBQ5wx95hfQdf
         hx2MslK6xHQBbkGdm/VHLTWKLOzTnJsIoMNNG3ykzVDuhtYFS1nZ8XL4+wBAyFNeaSrS
         o3eFEcOgt0XKiB3QLFBwjFa7NksnrlpZXkh2XATiQjMZS3rkFELHepUHjgC2fZoe/Lbg
         +GDr8+j0g9oKbz0n+ChSsz+gtdeppIeyfmVjz4iC2LwWRXckEcPBHurh+jaCUHYh6vBp
         lwlNKEPXZ48ezUojOxt8wF4/2ubN+liLV2ZcHhwFD8xahya8JoEOGrbpNaeSgvqiPl3L
         4XWA==
X-Gm-Message-State: APf1xPC8XrYek8deRvbKkkNfiHjVXauJjwz5DlNZUSfN6+s5m5J5Mpzb
        xGa2Sn6GMRJMGwXENIdKhx4=
X-Google-Smtp-Source: AG47ELsLpPhW+GCnauvc7XxWv8NFzK3rc6sYAIteW30tPQwb1C+u1OyejzVi5yNNPuuabXzBJjEdUA==
X-Received: by 2002:a17:902:b2c6:: with SMTP id x6-v6mr17215660plw.285.1520355814987;
        Tue, 06 Mar 2018 09:03:34 -0800 (PST)
Received: from neu8r3hm32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id a6sm10586919pgq.82.2018.03.06.09.03.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Mar 2018 09:03:34 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v9 6/8] convert: check for detectable errors in UTF encodings
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqvaea6lpn.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 6 Mar 2018 18:03:29 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        git <git@vger.kernel.org>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>, ramsay@ramsayjones.plus.com,
        Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: 7bit
Message-Id: <A4240C40-A3DF-45DB-88A6-125FB2D3CE15@gmail.com>
References: <20180304201418.60958-1-lars.schneider@autodesk.com> <20180304201418.60958-7-lars.schneider@autodesk.com> <xmqqfu5e8a53.fsf@gitster-ct.c.googlers.com> <55633B6F-EB6E-42D6-8E58-79158A99774A@gmail.com> <xmqqvaea6lpn.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 06 Mar 2018, at 02:23, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>>> On 05 Mar 2018, at 22:50, Junio C Hamano <gitster@pobox.com> wrote:
>>> 
>>> lars.schneider@autodesk.com writes:
>>> 
>>>> +static int validate_encoding(const char *path, const char *enc,
>>>> +		      const char *data, size_t len, int die_on_error)
>>>> +{
>>>> +	if (!memcmp("UTF-", enc, 4)) {
>>> 
>>> Does the caller already know that enc is sufficiently long that
>>> using memcmp is safe?
>> 
>> No :-(
>> 
>> Would you be willing to squash that in?
>> 
>>    if (strlen(enc) > 4 && !memcmp("UTF-", enc, 4)) {
>> 
>> I deliberately used "> 4" as plain "UTF-" is not even valid.
> 
> I'd rather not.  The code does not have to even look at 6th and
> later bytes in the enc[] even if it wanted to reject "UTF-" followed
> by nothing, but use of strlen() forces it to look at everything.
> 
> Stepping back, shouldn't
> 
> 	if (starts_with(enc, "UTF-") 
> 
> be sufficient?  If you really care about the case where "UTF-" alone
> comes here, you could write
> 
> 	if (starts_with(enc, "UTF-") && enc[4])
> 
> but I do not think "&& enc[4]" is even needed.  The functions called
> from this block would not consider "UTF-" alone as something valid
> anyway, so with that "&& enf[4]" we would be piling more code only
> for invalid/rare case.

Agreed, "if (starts_with(enc, "UTF-"))" is sufficient. Can you squash
that in? Thanks for pointing me to starts_with() as I forgot about this
function!

- Lars
