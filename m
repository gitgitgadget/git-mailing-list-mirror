Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 006821F453
	for <e@80x24.org>; Fri, 22 Feb 2019 09:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfBVJgM (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 04:36:12 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39374 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfBVJgM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 04:36:12 -0500
Received: by mail-it1-f194.google.com with SMTP id l15so2241211iti.4
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 01:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GTYlQz426BhqDG1loqUj0GxiNMfd+R70eytGLzq1zJs=;
        b=TTc28uufKLeXBEcRclMZBXqxtcx15F9LMnaUM8piULPCURCdFmn3Y/ojhOLhxVn9Q4
         j39uw8T6JSCZoacXmTvv/9rr5ox2y/Q8lmRwd7KA47eQYAL6na1ui5rT7ASgCWzrDi3w
         H0OJzXz/N7To8fJ4iw4E2Api0U5H90JZKy9J1YozzvIwd91FOm5yxRhMIfVcytCPi5cW
         oqx8jkEMTv3L7acTV4uiOdjRveorOL/fstnn0YoLn9u6qMemc/vJ4bTWkQw6RG7bk8OP
         87UrCIUTDf/HRFxuUhx9PEpEpuh2LulWaJXleElFwPSJ6F1baKJoaWIs6USfbfVJICZo
         +FSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GTYlQz426BhqDG1loqUj0GxiNMfd+R70eytGLzq1zJs=;
        b=X9kf9foSLRedBAYAYZqjyQBE03iY+8HLkap32oAh1bbn94B696wHtFzSxsNZK8/HGg
         0Oyj2c/mMjYxWL+Z1fiu7FfMHMGiDZrq0H34TtU09968P8FGeq6ZoUKA0+crwDJt8oBW
         9Kem1EncMzpc4pnJZmw6/V0nxqYMEpjacrQBL71EBXGunizN8vW2SFR/+lxL9L+yYVR2
         TpgdWfHcmFjOEfeRq+oJTeRxXUTh5OoSzNQ1GIy2HZl1UQtWTy0Rp7uNm+3oWMrdO3GU
         6ziCZkiNZFxeH+evGy5hHClxtPlpkdDHQII6vvCyqvp/qQjsrjyfMbJMmZUnSgwmYXSD
         AGvQ==
X-Gm-Message-State: AHQUAuZSusr2qgLJ/n6M+z2aYnZcPfwgLd+47kahAl2oLg/fLRrCF19O
        d//s3nrZVGU97mtQcATNo2n4gLv21WdD+sDsuAPlJg==
X-Google-Smtp-Source: AHgI3IZT1HTK1rRGHU87uhT431FobmXUDd83HOz79XffYusYdr42Y7cm25FdAvPwscfYjvgVnejbkFvpRJ5ijejyGlM=
X-Received: by 2002:a24:7542:: with SMTP id y63mr275906itc.70.1550828171118;
 Fri, 22 Feb 2019 01:36:11 -0800 (PST)
MIME-Version: 1.0
References: <20190216114938.18843-1-pclouds@gmail.com> <20190216114938.18843-2-pclouds@gmail.com>
 <87wolzo7a1.fsf@evledraar.gmail.com> <CACsJy8CR7VGp7htC_wKC9BUCaQsmkp5Zd4+M7bddPL-jKyfDMQ@mail.gmail.com>
 <xmqq8syb3b3j.fsf@gitster-ct.c.googlers.com> <87h8cy6cme.fsf@evledraar.booking.com>
 <CACsJy8B15hORnaOdYW8TNE3Gniv9NBJopyLYmHR5iF0U3beq6g@mail.gmail.com> <xmqqo976ultb.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo976ultb.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 22 Feb 2019 16:35:44 +0700
Message-ID: <CACsJy8CB=P9T0XJMWQetExgwDyFN78nuJZq8FtmzG+V1fBY4ig@mail.gmail.com>
Subject: Re: [PATCH 1/1] Introduce "precious" file concept
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Per Lundberg <per.lundberg@hibox.tv>,
        Steffen Jost <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Clemens Buchacher <drizzd@gmx.net>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 5:39 AM Junio C Hamano <gitster@pobox.com> wrote:
> > So now you would need to
> > add more or less the same set of ignore rules in .gitattributes to
> > mark them trashable, and gitignore/gitattributes rules are not exactly
> > compatible, you can't just blindly copy them over. Every time you add
> > one more .gitignore rule, there's a good chance you need to add a
> > similar rule for trashable attribute.
>
> I am not sure why you would even need to _duplicate_.
>
> Are you saying for each and every rule that specify "ignored and
> expendable" in .gitignore there always will be "ignored but
> precious" exception that match the pattern?  Given that we have been
> OK for so long without even needing "precious", I find it somewhat
> unrealistic to assume so.

If all ignored files are now redefined as precious and we mark them
expendable with trashable attribute, then we need to duplicate most of
the rules. The "precious" attribute of course does not have this
problem since precious-and-ignored files should be rare.
-- 
Duy
