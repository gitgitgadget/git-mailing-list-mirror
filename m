Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 074341F404
	for <e@80x24.org>; Tue, 13 Mar 2018 19:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbeCMT0Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 15:26:25 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33871 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbeCMT0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 15:26:24 -0400
Received: by mail-pf0-f174.google.com with SMTP id j20so325005pfi.1
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 12:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zzq/WApIUAD+0QbgLnR3vmcyHdPM1cdI/rbtxORBOEI=;
        b=aw2nbwBztyUtzbXthsjLTTRMAn0s7SRe8hx6vCriQaCWymPOXGq4P0OgDkTgC877LA
         z2uysEwdzSRDfLXx+TajV+c/hH+eBTD/Adn4Bx8C/cyGtxIGmHJjzUGbs7NfHDQk41Ia
         EBnv1a/1XO2lIHDbudm2lP4I+edlYnZJer78O7shKQ3Sg9jG9ryyW/8q/yhyJ4Zg1WRT
         RcJ/crAhDfyw7y8vkdCoA7wTmSOshxiqthROgrGVwsCOWLPGKhy1m5XY0pJJvUIHdqCQ
         R1CMtsNgmEpaBZ0IqhX61WukAsZVATBfPK4KzaeohQB/AGyVi9yPmp/4nCQrgnYh0Aj6
         WDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zzq/WApIUAD+0QbgLnR3vmcyHdPM1cdI/rbtxORBOEI=;
        b=qPkbDNgH4LsUavUm1uh7ZgOMLaSmRIqEdrRTUApHuvcDpcbjTT0x2mHtBFY+W5SJtO
         wZ7H7dwlpMt+tZmUN9pwYc/aC50cdW33l3atIhQS7XalBlQSXLyhVOW2w59lS369XIJi
         IhcWcBWwJ5FsR4L7XgGhVb7IGAU43YVVx3uVnGPJbaCSkx/loYK1NGAiEOQBC17aQgql
         mVNTM9t3iNPt6EiYGVZdMi11Bt9XgV4esQ/gae6Rrg9LZuS1w85Ji4y0rExfI1nIn5l5
         dxLLJlGWXfXXmT2y/I2TDo2Zo2XZI8KHw6m2Zisd1NS0loYDdGgKCsC9wG/B1Ogdi40k
         iPLg==
X-Gm-Message-State: AElRT7Fx4OBlWREtd6leFRB8DvhmWoNSYSUp/mn+Zxz3S/hWP5bJoLBT
        qz0IY3BtKvp9IyVrIFq6Qn7H7u4Nrw0Ay3+lTc8=
X-Google-Smtp-Source: AG47ELvXN80didrsdP6Daa1si5WUnVa3qns5OTiYpIRv7c0Iqmwg6pVOhk6VM65j+NSRNHHg3KKFBHciTY7UGeyDjqQ=
X-Received: by 10.101.88.4 with SMTP id g4mr51252pgr.146.1520969183754; Tue,
 13 Mar 2018 12:26:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.191.144 with HTTP; Tue, 13 Mar 2018 12:26:23 -0700 (PDT)
In-Reply-To: <CAL21BmkmXKzdwYHu1pNxuHhaxqei4ekVbutbuv2jmv6=GgcG_A@mail.gmail.com>
References: <CAL21BmkmXKzdwYHu1pNxuHhaxqei4ekVbutbuv2jmv6=GgcG_A@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 13 Mar 2018 20:26:23 +0100
Message-ID: <CAN0heSp-Vsvr95zc3J0iokRMJt74pxFH7OsoiR_3gnkMxpAAKw@mail.gmail.com>
Subject: Re: [RFC 0/4] ref-filter: remove printing from formatting logic
To:     =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Olga

On 13 March 2018 at 11:25, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=B5=D0=
=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
> The main idea of the patch is, if you want to format the output by
> ref-filter, you should have an ability to work with errors by yourself
> if you want to.
> So I decided not to touch signature of show_ref_array_item(), but to
> move all printing (I mean errors) to it. So that we could invoke
> format_ref_array_item() and be sure that we cold handle errors by
> ourselves.
>
> The patch is not finished, but I decided to show it to you. There are
> still many places where we could die in the middle of formatting
> process. But, if you like the general idea, I will finish and re-send
> it.
>
> Another question is about verify_ref_format(). Do we need to allow its
> users also to manage errors by themselves? I left the old scenario,
> printing everything in verify_ref_format() and die. If you have better
> ideas, please share them.

I think it is a good idea to stop die-ing in "libgit". This seems like a
good way of achieving that, or isolating the issue. Do you have any
particular use-case for this, i.e., are you setting up the stage for a
patch "5" where you add a new user of one of these?

I do wonder whether a helper function to call strbuf_addstr() and return
-1 would be a good idea though. I mentioned it in patch 2, then with
patches 3 and 4, it started to seem like a reasonably good idea. It
would be a shame if this sort of "boilerplate" for handling errors could
have an impact on code clarity / obviousness.

Another issue is whether passing NULL for an error-strbuf should be a
way of saying "I don't care; die() so I do not have to". Well, right now
I guess passing NULL would indeed terminate the program. ;-) Such a
construct might be another reason for providing error_strbuf_addstr()...
Of course, it also means we keep die-ing in libgit..

I feel I'm just talking out loud. Maybe you find my input useful.

Martin
