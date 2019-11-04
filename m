Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C17A1F454
	for <e@80x24.org>; Mon,  4 Nov 2019 19:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfKDTRp (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 14:17:45 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35181 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbfKDTRp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 14:17:45 -0500
Received: by mail-pg1-f194.google.com with SMTP id q22so4410017pgk.2
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 11:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iqhFBCkYg/IFcrVoDfJRhTjxKGHUhc5plLc+uetEHDw=;
        b=mq4a19tdPInxAM/p5Js79xBTfi33TEMUt/cg/9xUIvhEHVJyD7yYP5nUEndM8B17cV
         CYbsUYcK9iLf8ILm6pGSD+vKI5xyYDW0SB7c8VqLdGmcwRlnV1B/XfF1P5JY02kr9cqF
         cmkHhroMIYKfeaBQSyqk+zPsfMxVTha/VR31jmsJkh7F1cU0li/wkcEs4Hjto2e3Rgl8
         /GkA2WGVTuS8MacRXq6uXeQlIq1ummdirZO5RhWRSSdIHVfpMWSf0ppzjEK9GK1YW/74
         toFyY4tBiTNQXn8d8Ij5R3l52uWDwBPQCK4HGbs0fT8+J/xcQhQ+EtlvKNSvXAdrZekY
         n8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iqhFBCkYg/IFcrVoDfJRhTjxKGHUhc5plLc+uetEHDw=;
        b=PHWlHfA82iwbrZ3kiA9KfajcG7H504b2IIvIPvxIz2GvpQ+NL9XQ5Z+ylLvsNtyvOB
         S5+KTxseJiDYPIk+8oWzWBvCnQ2NwIByX24UBjQWvy3D6I+FdTA83eapDUsbKBU6q6ol
         lflQLDlWO1bnuAQbSVxUtj3VoRnO/KOTAWRLjxAo79RYJa6saugLcAKaZT/ScoET2iVx
         iHXoojS3YN/Cp115whp6tBuibW/sVplBM2WPdykQXa+CBh82e7lKU+gDDrHLmkjEGCul
         NvTisaMlxyAhvlu0gughWUt/LuCqN1g66IjpskUWxpJWQvByIjYcaAfAncjRaEpxILUo
         Qq+Q==
X-Gm-Message-State: APjAAAVRSzV8Gzuqf2tAEcQKJYkyjHnLYTI/UNUg1gRqhrh1jnHKUF3n
        l6ROjtn+K7mAckFfwVeX6BE=
X-Google-Smtp-Source: APXvYqxTbtO0cGX2tb4SvEPzQ8iUo/4F6VQk6mzpJoaeRenIpdGH5Q25P5qOJXhO7GD4BGehdm1d1Q==
X-Received: by 2002:a63:7158:: with SMTP id b24mr31589694pgn.153.1572895064682;
        Mon, 04 Nov 2019 11:17:44 -0800 (PST)
Received: from generichostname ([204.14.236.210])
        by smtp.gmail.com with ESMTPSA id h9sm19037714pjh.8.2019.11.04.11.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 11:17:43 -0800 (PST)
Date:   Mon, 4 Nov 2019 14:17:39 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 00/14] t5520: various test cleanup
Message-ID: <20191104191739.GA61441@generichostname>
References: <cover.1571435195.git.liu.denton@gmail.com>
 <cover.1571739459.git.liu.denton@gmail.com>
 <20191024232139.GA76771@generichostname>
 <xmqq5zkdebez.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5zkdebez.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, Oct 25, 2019 at 12:44:52PM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > There haven't been any comments in a couple days so I think this
> > patchset is ready for inclusion.
> 
> It's not like we are in a hurry that we need to fast-forward a topic
> like this one (i.e. general improvement and clean-up, rather than
> fixing regressions introduced in the cycle), so "a couple of days"
> is probably being too impatient.

Since v2.24.0 has been released, would now be a good time to queue this
patchset?

Thanks,

Denton

> 
> We'd prefer a positive ack or two.  
> 
> Thanks.
