Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80E901F6C1
	for <e@80x24.org>; Fri, 26 Aug 2016 06:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754853AbcHZGcD (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 02:32:03 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33647 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751321AbcHZGcB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 02:32:01 -0400
Received: by mail-qt0-f193.google.com with SMTP id j37so2604345qta.0
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 23:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KgCf4bM0JCF22yYPkLHNSx66VmSbWT2HfsdJuL0fFMw=;
        b=ZG8RcDyo0uUGqdcVVrUEqtois+JZ6/tGYu/K2qXWIz5srWbLcxWz9KEDidjUmj7WRf
         srkwF8OEyAErOhUe3yVN0Kek7yhzPLhLlla8l/mNrsqTwQgtL4wqnKUiH7NwD2Pfd92x
         88n/hwMtXRifcHCQortiTPgSpw8uLrERy6BlTHvcXZX1jnduo4779mxCxyxTlFMlOSgc
         aFt8J2Rb9I1xdGksT6LdJQU9jJs30+NlHd5j1XYILCthtmH5fpJrLgtUdbaTHIBNw8Eh
         ITdqkfMsd4YiIn6hdyK2zqKvu+7o+ENDhgg5RgZDc0TVVRmWvAMr+b+y/58r6f+ZENHS
         q2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KgCf4bM0JCF22yYPkLHNSx66VmSbWT2HfsdJuL0fFMw=;
        b=jNM73IbvPWXMC4c6mdin+jXbwUnCr+7imYAhh6RZkPeOT/2Qn+IDopkKmteQUPtQCw
         pHvnSg05dyApRoKX+yoqcIx/j0qxInaI4oaD50DRY98QBm6OqYrU5M2HFapw17rEpgug
         262zDi46jmqQQSC3m6XdCdah3xnsRYNq38MEJlX5aHlRgD7XfbgCwpFg+vb387d+XU8U
         I5mahsF0ZDxAjfTQUpny/ywUBVxG90/CwZ16BrhNXGKsjyIiHV5oWRDCH/fwfjbVlusg
         ZavQmfY8dGEM+4ZHJOybejADssVmZSQ7BzwIca89EMahgpXhi/z2eGPPrLRZZyZ/rpHQ
         BCNA==
X-Gm-Message-State: AE9vXwNDReUefTMCIJMGZBJXZrInsl2O2EqYcTcjyLMm4NpRhinM2uF6mLxvW0udgy+f8VXP1n7xFSW4pYnarg==
X-Received: by 10.200.48.146 with SMTP id v18mr1457590qta.107.1472193120143;
 Thu, 25 Aug 2016 23:32:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.42.82 with HTTP; Thu, 25 Aug 2016 23:31:29 -0700 (PDT)
In-Reply-To: <CAFaJEqs7vE4knXXOdKk+PxY2DZs=7BHGUJY_0a_aKF1ngnX+Lg@mail.gmail.com>
References: <20160822173528.755-1-oystwa@gmail.com> <20160824180730.mqlvhkthg4imd2vy@sigill.intra.peff.net>
 <CAFaJEqvm9Xj34t+F=KMtwRDEYhwHZ7=MRwsZ22-Gt_UPd4r72A@mail.gmail.com>
 <20160824183358.ahxcgcrg7jo2rygp@sigill.intra.peff.net> <CAOLa=ZSVgm_J9n9wBp_cPWF4kWtvq_8DMLWGoYTSVetOpEJnAQ@mail.gmail.com>
 <CAFaJEqs7vE4knXXOdKk+PxY2DZs=7BHGUJY_0a_aKF1ngnX+Lg@mail.gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Fri, 26 Aug 2016 12:01:29 +0530
Message-ID: <CAOLa=ZTY0fM_Z_t8nk+je4fao8ydF1dAXmG7RzgmJyoQUj7kSg@mail.gmail.com>
Subject: Re: [PATCH v2] for-each-ref: add %(upstream:gone) to mark missing refs
To:     =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

>> On Thu, Aug 25, 2016 at 12:03 AM, Jeff King <peff@peff.net> wrote:
>>>
>>> Ah, right. I was feeling like this was all vaguely familiar. I think
>>> it would be better to push forward kn/ref-filter-branch-list.
>>> According to the last "what's cooking", I think that topic is waiting
>>> on more review. If you're willing and able to do so, that would be a
>>> big help.
>>>
>>
>> It's been waiting for review for a _long_ time now.
>>
>
> To be perfectly honest my C skills and familiarity with the git source
> code is not much to speak of. I very much want to take a close look but
> I cannot promise anything worth your time...
>
> But if I do find something I'd like to point out should I just reply
> directly to the e-mails containing the patches as one usually does even
> though they're months old at this point?
>

Not that your review would be absolute but it definitely would be a start.

Replying directly to the patches is the way to go I feel.

-- 
Regards,
Karthik Nayak
