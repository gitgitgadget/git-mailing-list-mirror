Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D3192018F
	for <e@80x24.org>; Wed, 13 Jul 2016 15:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbcGMP6k (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 11:58:40 -0400
Received: from [209.85.223.196] ([209.85.223.196]:34355 "EHLO
	mail-io0-f196.google.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750990AbcGMP6i convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 11:58:38 -0400
Received: by mail-io0-f196.google.com with SMTP id g86so3181171ioj.1
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 08:58:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0AxUkwwJBxXhYCA4f/EsS6/YzT5wCFd/Qabttzl2n0M=;
        b=fcxSjq56AC4cVbUb5+VhhHzGms2IeVwqgJeUNFCEl1VhcDiRvdQkSAbQw38Gcb0dEq
         D8BJeXnz4SQngBhjR2CFTaJG3yB6T2EDpCao3vbH5ZkZEbKmz247WZZOg4wN3VVs+2yz
         j6OK6MKh7kAlT+vWYkCZ4PPHTFNx/its3wW2XHBRFEQkgV20kKTpkXM3X4ztxCHwbo4X
         TbmAnnxklmswH65cbrwpDEnfgIgDPjEQIDL/YDtxknxNgXhgJMgyEIJOQNfgiIIF9t84
         B+5ouav8Ph/qLHQzLWNGnr+Hrsqcl/DfHu0BjCi8ZaWpSrWsGj+K4koEB3kA/HIiZnQG
         w71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0AxUkwwJBxXhYCA4f/EsS6/YzT5wCFd/Qabttzl2n0M=;
        b=Wjb4fAgHf3LZmyHZx7NUouJUFasV/xfyzw3QqSTebFuvvTjr1gU4kekQib4YAwWqh8
         Vbw40phrXx8YwmjnzXxWwmQDTmNi8Hm/in9o3Z9jjQwHkmcgItvyR1jiHUdwISjY0HF8
         LHXD4XcD5Y24hLPU7FkK+m4hquwZqkmWAzmrLJIb5tBDd8//aCDvNpM/vBQPDGM1wrOs
         3QWT+PHlDgDZubxSu0QOqn21FXD2LtY00MgfWjEtGx7n6b47VA3fk5WfBwA1ySYQChPv
         9fEeBObzWb/hoRRGfpcHMY0F5vd6EexN8nC9pvdA6YnyMz1E2CPHJHGowt/G334HQdcv
         ndIQ==
X-Gm-Message-State: ALyK8tLfinURaprivIUZfFTgKYBBhsIOmrLjP0P8Oe0fi9RSx/7onUVlV051jCWmRr+d4s22cno2pknt/I8zoA==
X-Received: by 10.107.22.6 with SMTP id 6mr9569059iow.128.1468425464869; Wed,
 13 Jul 2016 08:57:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Wed, 13 Jul 2016 08:57:14 -0700 (PDT)
In-Reply-To: <vpqa8hmroji.fsf@anie.imag.fr>
References: <20160628172641.26381-3-pclouds@gmail.com> <20160712164216.24072-1-pclouds@gmail.com>
 <vpqa8hmroji.fsf@anie.imag.fr>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 13 Jul 2016 17:57:14 +0200
Message-ID: <CACsJy8DrPPfvp3C=tBL0qBmAwdEAZtXrxPLNW3HgcgJGO1u3QA@mail.gmail.com>
Subject: Re: [PATCH v3] config: add conditional include
To:	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 13, 2016 at 9:21 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Nguyễn Thái Ngọc Duy <pclouds@gmail.com> writes:
>
>> +`gitdir`::
>> +     The environment variable `GIT_DIR` must match the following
>> +     pattern for files to be included. The pattern can contain
>> +     standard globbing wildcards and two additional ones, `**/` and
>> +     `/**`, that can match multiple path components. Please refer
>> +     to linkgit:gitignore[5] for details. For convenience:
>
> It's unclear to me whether the whole content of GIT_DIR must match, or
> whether the pattern should be included (or a be prefix) of $GIT_DIR.
> From this text, I read it as "the whole content", but ...
>
>> +     ; include for all repositories inside /path/to/group
>> +     [include "gitdir:/path/to/group/"]
>> +             path = /path/to/foo.inc
>> +
>> +     ; include for all repositories inside $HOME/to/group
>> +     [include "gitdir:~/to/group/"]
>> +             path = /path/to/foo.inc
>
> ... here it seems it only has to be a prefix.

I should have written "with two additional ones... and a few
exceptions"., One of the bullet point below would say the trailing
slash is rewritten to "/**" so it becomes prefix match. If it proves
confusing, I will probably just get rid of that.
-- 
Duy
