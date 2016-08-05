Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6670E2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 12:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935000AbcHEMxm (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 08:53:42 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35164 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759617AbcHEMxl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2016 08:53:41 -0400
Received: by mail-wm0-f66.google.com with SMTP id i5so3669170wmg.2
        for <git@vger.kernel.org>; Fri, 05 Aug 2016 05:53:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NWbdZlOhzMuIi4FGxknKNmH1dw25amMgtJVptTrDidk=;
        b=P/zD9pMM0GL1W3KOeHVyqU5tgu6RMb4kRADstsDo+Bnri6njipemBxLmxsycD/3Dpe
         vBDo0EeWHNxuKIVlxoWKFrQoYv35kmVsjPvWYOV8urBMW6yC4eO0F7r1hGv/V9juJDpY
         +pt/E9q8qVJsVmXBDlMX7iUCWMdzt+V52wLMO3WlDgdkIx+elhBH5RfEhf3n121oAd/9
         9Y3vc63IFfS4ZzR+0r2retOytQLmDXHDNTrtwrLEgAjIkIvqBluzrihzsn8XKemMGIE1
         HpZtIvo1MfMa9ALYpYBKMB7i3yVGs4XrPMDzrzVZlCgSxNhLWHGde1CMW7uKACBOUpfj
         tH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NWbdZlOhzMuIi4FGxknKNmH1dw25amMgtJVptTrDidk=;
        b=RQGLEnRDcZRRFWvbPU0Mj8Tcn385VciBjKK4CjXXSyqXMigGL0dE02BudL8FexeEU0
         ksyrg6lFXTL1fWaDalO2VHIOkLs1nvvCukZbF5KVC2+0OUz9DstvMwdeM9HXU8Py2jMQ
         DRSS5J/4SB+LFwkF3lbDcmJ+J2L+wvB6eKUOcPWhx2j9DnMg6nX1cRadvHubACU2h10Z
         BzesVpi3R6wddD/Cz9NAYSMO6OMbakXD1a1oHEGwQ/3gAd0N3UiHRzDPvNn1TAttga5h
         EsvJCniBpZaAVOkPfC+J0OUygzEnkxqnL/71wuUk1EVP50rNhjLGfREzk0ss3nMYKHvy
         vLjg==
X-Gm-Message-State: AEkoousWpL0PC4ZuxQLOyFtDfq7EfN09LjAATLE3LaY+s75OejIdMHK4C9DZbIFEozHM7A==
X-Received: by 10.28.22.70 with SMTP id 67mr3538165wmw.52.1470401620519;
        Fri, 05 Aug 2016 05:53:40 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id d8sm8554528wmi.0.2016.08.05.05.53.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Aug 2016 05:53:39 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 11/12] convert: add filter.<driver>.process option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160803224619.bwtbvmslhuicx2qi@sigill.intra.peff.net>
Date:	Fri, 5 Aug 2016 14:53:38 +0200
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jnareb@gmail.com, tboegi@web.de, mlbright@gmail.com, e@80x24.org
Content-Transfer-Encoding: 8BIT
Message-Id: <C3718D5C-4E98-45AF-8105-BAF77142CDD0@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com> <20160803164225.46355-1-larsxschneider@gmail.com> <20160803164225.46355-12-larsxschneider@gmail.com> <xmqqtwf19263.fsf@gitster.mtv.corp.google.com> <0E3FC781-1B2C-4341-9B7B-D9D836596A35@gmail.com> <20160803224619.bwtbvmslhuicx2qi@sigill.intra.peff.net>
To:	Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 04 Aug 2016, at 00:46, Jeff King <peff@peff.net> wrote:
> 
> On Wed, Aug 03, 2016 at 11:48:00PM +0200, Lars Schneider wrote:
> 
>> OK. Is this the v2 discussion you are referring to?
>> http://public-inbox.org/git/1461972887-22100-1-git-send-email-sbeller%40google.com/
>> 
>> What format do you suggest?
>> 
>> packet:          git< git-filter-protocol\n
>> packet:          git< version=2\n
>> packet:          git< capability=clean\n
>> packet:          git< capability=smudge\n
>> packet:          git< 0000
>> 
>> or
>> 
>> packet:          git< git-filter-protocol\n
>> packet:          git< version=2\n
>> packet:          git< capability\n
>> packet:          git< clean\n
>> packet:          git< smudge\n
>> packet:          git< 0000
>> 
>> or  ... ?
>> 
>> I would prefer the first one, I think.
> 
> How about:
> 
>  version=2
>  clean=true
>  smudge=true
>  0000
> 
> ? Then we do not have to care about multiple "capability" keys (so
> something naively parsing this could just store them in a string list,
> for example).

Alright. I will go with this solution.

Thanks,
Lars

