Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64380201A7
	for <e@80x24.org>; Tue, 16 May 2017 02:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750759AbdEPCpB (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 22:45:01 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35470 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbdEPCpA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 22:45:00 -0400
Received: by mail-wm0-f52.google.com with SMTP id b84so111453011wmh.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 19:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iJr/Id60RNN4Gei/NTdjoF14JZAMsSY6XsOB8b9FBXs=;
        b=EhUT2bjWXbve0tH4up6Q0QHDGFNb6ia8ZTHwwKiIbeU1iy4Xbk9fHkElJps/vB5QrM
         Z80GlctP9+iG/GhhvQP0roloVfDCw3FQ1E2WIy5iseai0MCttda67yuDftQLSB6YLoIc
         DZPDa5ijvCp+2uWQV61nynENfligRkpoKVlIipV1f/9QaXPsZFCQAr1sHC6w0f6fwJ6O
         Sz5ftFg/XprqCkEKwO7Ng1uSpofGb9pMR4+EfK0cbULewpXDsq5UyhBspArwl2RlDXJh
         GPocQzX60huzTQLMOfbHPnOpVyu/oBZZKo68+vZBO2Ow2hBIbbsOM+PkpUdZD/TdKeyT
         C0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iJr/Id60RNN4Gei/NTdjoF14JZAMsSY6XsOB8b9FBXs=;
        b=nA82DY4b26f8VORuPQYg6deYUs+k+8va0YxKw/U7gJ7kYv3QI4PXEx87UfBvE2vdnI
         1U3suiERiKmmPXCYFuKimz9bSz+sRze//TKSJGCxWu3NDA5HPZNUAGlzAqRzDPMNsZTe
         aIeFYTQI1hUIcfDAZa/dhkOmadmLvWW5xfJsrzMdPNxs84NDLjk1sIJRqX7r5y79mdBC
         arg01lOhePOePrVmNGAoMRNYSlPld+qbdEwr4Zn9VfS7Iwc2112SWNOxjXMUtX+/nMZd
         7CiS5AmHYV8CCXjAOhHVDlLYIa7lGdMlSvwtntwCeCd11X6GS2mwlEj2dtuOJP9RlKT7
         TFjw==
X-Gm-Message-State: AODbwcCbdE3XJCVYcnPVnPmriS3lSa1GRJAcWsxpq/JowlMZqvvY6sm2
        dZVAg2qf5sjx3xSup00avU17kev1ug==
X-Received: by 10.223.163.215 with SMTP id m23mr6871624wrb.100.1494902699516;
 Mon, 15 May 2017 19:44:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.132.34 with HTTP; Mon, 15 May 2017 19:44:58 -0700 (PDT)
In-Reply-To: <xmqqefvp6458.fsf@gitster.mtv.corp.google.com>
References: <20170505052729.7576-1-whydoubt@gmail.com> <20170514031513.9042-1-whydoubt@gmail.com>
 <xmqq7f1iv5fn.fsf@gitster.mtv.corp.google.com> <CAPX7N=4jidx5pr3BfFoTL27gbHDT6sdm1q2Z2YxfjsBuN01XaQ@mail.gmail.com>
 <xmqqefvp6458.fsf@gitster.mtv.corp.google.com>
From:   Jeffrey Smith <whydoubt@gmail.com>
Date:   Mon, 15 May 2017 21:44:58 -0500
Message-ID: <CAPX7N=5=M=wjTbKQoctndqrHxYSb86bEwej8ofoOovsYHWFkKA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/22] Add blame to libgit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hm, I really thought I had split some of those out.  Patches 4, 5, 17, and 19
could all be reasonably split into rename vs move patches.  Patch 18 only
does moving.

I do not see much benefit to splitting up the 'move xyz to scoreboard'
subset (6-12) that way as moving an item to scoreboard is already causing
each use to change (from xyz to sb->xyz).

On Mon, May 15, 2017 at 7:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeffrey Smith <whydoubt@gmail.com> writes:
>
>> On Mon, May 15, 2017 at 4:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Jeff Smith <whydoubt@gmail.com> writes:
>>>
>>>> Rather than duplicate large portions of builtin/blame.c in cgit, it
>>>> would be better to shift its core functionality into libgit.a.  The
>>>> functionality left in builtin/blame.c mostly relates to terminal
>>>> presentation.
>>>
>>> As I said in my review of 04/22, it is a bit hard/tedious to sift
>>> the changes to refactoring that actually changes code and pure
>>> renaming and movement of lines across files with the current
>>> sequence of the series, so it is very possible that I may have
>>> missed something, but from a cursory read through the series, from
>>> the comparison between master and the result of applying all
>>> patches, and inspection of the resulting builtin/blame.c file, I
>>> think what this series does is very sensible in general.  blame.h
>>> does not seem to expose anything that is not needed, which is a good
>>> sign.
>>>
>> I did try to keep any unnecessary changes out of the big movement
>> patches (17-19).  Would you prefer I break down 19 further?  I had
>> been holding back because of the added churn that would introduce from
>> lots of changing function visibility in blame.h and blame.c.
>
> To be honest, the "rename symbols while moving" done starting around
> 04/22 made the series too noisy to read and I had hard time
> reviewing the later ones like 17-19.  I think they share exactly the
> same issue as 04/22, e.g. 17/22 renames origin_decref to
> blame_origin_decref while moving the function and some of its
> callers across files.
>
>>
>> (And if gmail would quit trying to make my messages 'rich text' --
>> a.k.a. HTML -- that would be great...)
>>
>>
