Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D7A51F803
	for <e@80x24.org>; Tue,  8 Jan 2019 18:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbfAHS15 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 13:27:57 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40090 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbfAHS15 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 13:27:57 -0500
Received: by mail-qt1-f194.google.com with SMTP id k12so5463036qtf.7
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 10:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=HxI0hGWqY2Do+GrlMaf3yXU66XTOte3kO5+BRPMISAs=;
        b=I6q9cx/qILGiBck2no2RWG9onKarnFJEMAs94iZMYbd98ME/tUwUoOZWKAyVehXxgg
         VZ7Fcd3FZcp+ThnIfbqzQNw8u181TQa1ONSY4EjYemGfBXjJZv/DiheSVBIu5J0XKL8i
         MdNXC6JpS5c3TC+ATzWcilAqVqDgro4JS1vj4tI7sX1q1STFMhuMaiTj1dcQifLbDyOV
         uIYerjki7qksqCjS+H5xgO4jtXbnijJWjSm/rfDSjBmN9LddtYXronkhi2557VQYoKoF
         dFKN3SdLPSzEQ6iSUULzsKMLc7cii6gsYL29nLAShRY0XCyq89g3CFoeeh94/bGAcN8x
         oc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HxI0hGWqY2Do+GrlMaf3yXU66XTOte3kO5+BRPMISAs=;
        b=tVLMv+4Gd1IxY7VW7qvWe0OCENqv4xHaZJfm+VVqLuYa0Q71CN8Fhir9J7xq9Fl09v
         su4tQSzQGCTY+HMY/wIn2ateDQhFi57n1Ejf/S3bGM80E9XbQJI5g3nj+EsQ57plY7ND
         5N4UAzGrCQlYpT641HlNXJ0qVwTsjUZL0VvAnfd91T1foh5c9rygg4PoVYlQlsYfHJWu
         o639WjcIJB84eDlru/hululGegnS0q/A+lPcT8V1kG3mr93p7r/3lOsDBnoOPkotNwqO
         LBdlb8qx+0/qdlWGgCk92BrxYSQR6aCU/K37XHA2rp41h1UlkHWNMYeMk8IWHiTfuQsv
         ohlw==
X-Gm-Message-State: AJcUukenvBKSsYg+liRGbk4+7wWn7CzEFY5wCDF3pTzGwlZYvBGA1D9n
        YLfefpySd5MuuGLQcpT3Z1I=
X-Google-Smtp-Source: ALg8bN6nRpY7Yzd+4y2rYZHpkPYQ1zY6dm5qqlUTVB1xaHflS+GWGqT9yZltVuW415aMznTFbXmwmw==
X-Received: by 2002:a0c:fd8a:: with SMTP id p10mr2800337qvr.48.1546972076161;
        Tue, 08 Jan 2019 10:27:56 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:6dcd:1b4c:550f:6a75? ([2001:4898:8010:2:5701:1b4c:550f:6a75])
        by smtp.gmail.com with ESMTPSA id u45sm37941549qtk.33.2019.01.08.10.27.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 10:27:55 -0800 (PST)
Subject: Re: [PATCH 0/11] jk/loose-object-cache sha1/object_id fixups
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
 <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
 <20190107083150.GC21362@sigill.intra.peff.net>
 <b0049722-d019-fd5d-d93d-7b7363b4f244@web.de>
 <xmqqy37v59qz.fsf@gitster-ct.c.googlers.com>
 <20190108180522.GA4610@sigill.intra.peff.net>
 <xmqqmuob58gu.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <27ac5d02-e2a5-9d1d-9974-8ca740efa978@gmail.com>
Date:   Tue, 8 Jan 2019 13:27:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <xmqqmuob58gu.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/8/2019 1:07 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
>> Yeah, they should. I think one of them will need René's patch, which
>> changes the body of quick_has_loose(). I can roll it as a separate topic
>> if that's easier (or just wait a week or so until René's cleanups
>> graduate).
> Nah, what I got is already good to work with.  Both series are
> straight-forward and I do not expect them needing long fermentation.

I'm just chiming in to say that this series was a very satisfying read, 
and the changes were clear-cut and mechanical.

Thanks!
-Stolee
