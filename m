Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2102C20281
	for <e@80x24.org>; Thu, 21 Sep 2017 03:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751396AbdIUD5l (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 23:57:41 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35499 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbdIUD5k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 23:57:40 -0400
Received: by mail-pg0-f65.google.com with SMTP id j16so2753685pga.2
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 20:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MlimdzXNHrE3O6Rgfo4nCB88hNP+hI7WndoYiBBgLbk=;
        b=DvOKSFMinkM9ZYWJOfS7FFaUpnpkfs720wE+pCVgDRpPECd0tGINPTJCYkXgCjQGK9
         lNAT0xHqE0EXpd33bK8n4g065XriJAY51EJdfZuJChqtY1esjUbvut+fd6O43tRuOw+2
         JxuMbdVond2rYYmV5Mm8wIoL62GeaILX70jPothWZUmAk16U9ap42REUVFMFY927sJfB
         BO0L1FsCEBOBrgQTutjRUgL8A/ICEzLOIjNRMPSfrAnaBRx9eqmzaxZEQGhTE3HHSSha
         b30RxIlxSTcVhL3bP6WebG2nANy5+y3gokyry51/9WI2WItG8lpx4AH/zIWL/zm2//Z4
         Ie5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MlimdzXNHrE3O6Rgfo4nCB88hNP+hI7WndoYiBBgLbk=;
        b=B6N0ZYW/efbCHBKgIn8rG0lDNLqu7TnZ17kjj6JyYdiSz0Jwp4QClow9uJ7CNff8xL
         4jDckFtm3K5FLF9rU8Z5FCQXRowFe/BQTVoCoIPDJsAOuL/Xejr30SI2cIilAWbzuZDM
         sg5Bi3hu6DmecHo3cyCUQN38VdZifqUmWw0UtvNMVU6PRLMsTw628QCpo0ZJcEyEzHGp
         p7+l048n1aVyCcgrjUjIiycrne7tk5qPxRXtoJU+UBpJeC57VcU2W2KkEI6EMBO9JYKD
         zAYpTNsgnlZPjOX5NoB8gwlYdj0KGlikeHG+Q8aiIQ6ZBQuJzCSTUGhsbYEvcwoygMPX
         OA4g==
X-Gm-Message-State: AHPjjUh8blBUUA+Y2Vog7EHgS6d40qsg4x/M8Ybr+5/eAur/vsm+y70o
        cf1ZZyhOmRXnnR6QPzYfk1JqidwJVQ4U2nU8Ygc=
X-Google-Smtp-Source: AOwi7QAhzqeMOR5BcMfeE+kXyyQnNwUYSMw5hsBVwz1qmrZQZDVJe7hFPA4lU10JT2j7eL+dO5XyUvBGZrvA2K5lZ0U=
X-Received: by 10.98.157.201 with SMTP id a70mr4290105pfk.122.1505966260020;
 Wed, 20 Sep 2017 20:57:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.142.73 with HTTP; Wed, 20 Sep 2017 20:57:39 -0700 (PDT)
In-Reply-To: <20170920203659.xqy76bg5nfabvbfx@sigill.intra.peff.net>
References: <1505936846-2195-4-git-send-email-martin.agren@gmail.com>
 <20170920202552.kkwhigmv7lq6cj3y@sigill.intra.peff.net> <20170920203659.xqy76bg5nfabvbfx@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 21 Sep 2017 05:57:39 +0200
Message-ID: <CAN0heSoWnUXSjP1HtRTKpBiOc9JNzZN_+m1O3_Wn+rE43MpPhg@mail.gmail.com>
Subject: Re: [PATCH] revision: replace "struct cmdline_pathspec" with argv_array
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20 September 2017 at 22:36, Jeff King <peff@peff.net> wrote:
> On Wed, Sep 20, 2017 at 04:25:52PM -0400, Jeff King wrote:
>
>> Isn't this whole thing just an argv_array, and this is argv_array_pushv?
>> We even NULL-terminate it manually later on!
>>
>> So rather than increasing the line count by adding
>> free_cmdline_pathspec, I think we could actually _reduce_ it by
>> converting to an argv array, as below. And then adding in your free
>> would be one extra line.
>
> Here it is with a commit message, and that final free added.
>
> Sorry for stealing your patch, but I didn't want to suggest "couldn't
> you replace this with argv_array" without actually seeing if it was
> possible. At which point the patch was pretty much done.

No need to be sorry. I wasn't aware of the argv_array thing, thanks for
seeing the bigger picture. I haven't looked into the details, or your
and Jonathan's discussion, but just from a cursory look this looks way
better. It reuses existing infrastructure, and then this:

>  revision.c | 39 +++++++++++----------------------------
>  1 file changed, 11 insertions(+), 28 deletions(-)

Martin
