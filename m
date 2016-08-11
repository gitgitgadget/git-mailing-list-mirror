Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C89D720193
	for <e@80x24.org>; Thu, 11 Aug 2016 17:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504AbcHKRtH (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 13:49:07 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36198 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbcHKRtG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 13:49:06 -0400
Received: by mail-wm0-f66.google.com with SMTP id i138so538130wmf.3
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 10:49:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=peHT6kQsThE7oYaUSSa60UGyN6/lFCpkkt4DKnagHHU=;
        b=U3DNUEHoPBzkTg78614nsd7G6D50irJ1EjswfUzi5pFBOG2XUbZJmWYviCaNO6pUgk
         7wiWYE2iH9dDJb07ccPtDtqtw2oNouHzwoqEc69qnkdIMILZzBl2bTr2e32BOA8x1xTt
         26WmenwoZyh7v6WN0rW3nce2bXhqPg74uXYPvZ4ubBVdia8MNF5N1rg2B6x9j2YfGjdg
         ycDeudAOyj25zyXwZUGBNRmKrJH46IWPLNQ+nHug3R8kcQWfCs9NVNEVPHSdw5Wir2b/
         rTwA1DNPApFbw9Wz099fBbyClCu9nikoHjMz5iXvIPOGERcWDtUftUDP+ZKxFMCXafYr
         +x1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=peHT6kQsThE7oYaUSSa60UGyN6/lFCpkkt4DKnagHHU=;
        b=X53Ea7/BTQcywIhOoBe2z5td8CEjmODv2xko3KIaWTZwPNhvaThRaz2t5b9OWfxxuX
         L30oo+Wix2YmEBkjmR4qiKuu4OXRcg6BTSBQ0WYpy73KtZVcG8RkIHbmqvVEB8tntviW
         kfcaKdZqusWqc0R9X/neRm4AH+tzVjxLIEbfMkN2Ged9G5wwHdkIGnQXHQIeVK9VZmmx
         WEkEjAe1Rd7P80xy6Pf7sMZaTxFtVFXHGjyhm/6CIwhZoGzP9Hr6ay0K7JT04FRF/pWz
         PCKhuINWOrqDWjrbLPivkfYsGEKOV4hJGgHGtk9vUE1H+Gaiz4T5ZvWlyMaOU/3AGX/l
         AozA==
X-Gm-Message-State: AEkooutkNYfEkRA8hgtJmgDKlmS8/ctFaGLgjiPeX34g1ZFAw5BuHfc73GwDel7tX9RwCvb6HSn2NBT6UJiBFQ==
X-Received: by 10.28.167.80 with SMTP id q77mr11281119wme.62.1470937744530;
 Thu, 11 Aug 2016 10:49:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Thu, 11 Aug 2016 10:49:03 -0700 (PDT)
In-Reply-To: <126f7789-c2c8-669f-2210-eb6864f8f6da@atlas-elektronik.com>
References: <20160811085253.19086-1-chriscool@tuxfamily.org> <126f7789-c2c8-669f-2210-eb6864f8f6da@atlas-elektronik.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Thu, 11 Aug 2016 19:49:03 +0200
Message-ID: <CAP8UFD0msQJT2YaQHtHKwhbGo4ujO6ectfKuKKed_yda909TiA@mail.gmail.com>
Subject: Re: [PATCH v11 28/40] builtin/apply: rename option parsing functions
To:	stefan.naewe@atlas-elektronik.com
Cc:	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>, "l.s.r@web.de" <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 11, 2016 at 10:58 AM,  <stefan.naewe@atlas-elektronik.com> wrote:
> Am 11.08.2016 um 10:52 schrieb Christian Couder:
>> As these functions are going to be part of the libified
>> apply api, let's give them a name that is more specific
>
> s/api/API/
>
> ;-)

Ooops.
Anyway as this is patch 28/40 and the other problem you found is in
40/40, I will just resend patches from 28/40 to 40/40 in v12 (so only
the last 13 patches, that I will call part 3 of the whole series).

Thanks.
