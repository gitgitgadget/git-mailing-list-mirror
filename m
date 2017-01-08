Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9484A205C9
	for <e@80x24.org>; Sun,  8 Jan 2017 16:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935465AbdAHQxT (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 11:53:19 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:35598 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752974AbdAHQxR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 11:53:17 -0500
Received: by mail-io0-f194.google.com with SMTP id m98so4725992iod.2
        for <git@vger.kernel.org>; Sun, 08 Jan 2017 08:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ePTg/gG9Ff+MI9FlSfC3Eyq/biKoNlgmiOY8XCQlocs=;
        b=WKQH7I1yQgS6kSfahS9stz4FagUlW7LnvMww1sXPtRESqlnlKCJBmyI5CBFmy8k3+c
         CzwE5pSpo/7YVRf9o9H+ljPa7IsEFkLMmL9d2DUWtPeyh9PbPLnSPWhu4k7XNJg1oMMz
         VWlSqHve0sNVJwosJuEpV6guDqsSZrYWnAneOAI44SGACd3ABhcLeJgw48zxBST//ZWF
         jT1ooeOHlYPclo0nbP5cGzZdk26oF5Uj4z3g8foTla8JZq8+l4GxEBqUjr+0DQJXEu/t
         vevA400eaIWGwK+TOuvNaCz4ZGMteYcOqC2z9kSHSJPXIIGvCG702sdL6IkcQunzCP8i
         G7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ePTg/gG9Ff+MI9FlSfC3Eyq/biKoNlgmiOY8XCQlocs=;
        b=BVmY3YYQebSjF4O4hV8h3Kwfl6PMW9JSN/d2r21mHkgP97KdfDFiv+qzGN6xAEGrns
         kc7RfEfxCafmZ7Hrtdnjth0wNeMOK0EeVaXFTBiolZepYlP/+OM1vEx0+xKeN9yh4Uk8
         085YEdqzJWOkEJo10nlEbO3XyyqdEf40VKrbB7UEXQo0ItbDEmmuPgQrt+p2Ini55NYi
         0xC7owYmWDvVp/g/QGrIT7KvcOmW98HHVpR1PqFQh7ECf0NY/Sgaj36cZBolpdaXCJ03
         1ZDzga2aDWSbMAMY5BXJ56xRxX+uuE8yBZq//ghBEsLoOnyHvPGqOygbM/r7cuqC/6/Y
         dWcQ==
X-Gm-Message-State: AIkVDXIc8tubdUvaEm3QooD3di/NF8rjhgZZgWXm0yUkZW7K938ON9QPVWA0+/fPxO3HUj/geBlb53sVCqEfmg==
X-Received: by 10.107.53.165 with SMTP id k37mr70866571ioo.74.1483894396521;
 Sun, 08 Jan 2017 08:53:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.147 with HTTP; Sun, 8 Jan 2017 08:53:16 -0800 (PST)
In-Reply-To: <xmqqy3ym36y2.fsf@gitster.mtv.corp.google.com>
References: <20161231114412.23439-1-pranit.bauva@gmail.com>
 <CAE5ih7-7e+ZLUbE7iquWV2=qP4ofzAHUC2ZPg3b-ivSpCo4eRw@mail.gmail.com>
 <285ed013-5c59-0b98-7dc0-8f729587a313@kdbg.org> <CAFZEwPNbtamFfFy7vYXurpEWBDmRMyPB9+Ep-hm4uZVMREbq5Q@mail.gmail.com>
 <xmqqy3ym36y2.fsf@gitster.mtv.corp.google.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Sun, 8 Jan 2017 22:23:16 +0530
Message-ID: <CAFZEwPNhfYHLZvdEV0k22dJgJ+zhpSE9k1jUowNiPJFkASMz2w@mail.gmail.com>
Subject: Re: [PATCH] don't use test_must_fail with grep
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Luke Diamand <luke@diamand.org>,
        Git Users <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,

On Sun, Jan 8, 2017 at 2:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I see v3 that has 2>&1 but according to Luke's comment ("the message
> comes from cat"), it shouldn't be there?  I am behind clearing the
> backlog in my mailbox and I could tweak it out from v3 while
> queuing, or I may forget about it after looking at other topics ;-)
> in which case you may want to send v4 with the fix?

Yeah sure! No problem! :)

Regards,
Pranit Bauva
