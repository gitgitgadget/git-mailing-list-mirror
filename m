Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3B0A20986
	for <e@80x24.org>; Tue, 27 Sep 2016 17:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753345AbcI0RXV (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 13:23:21 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37894 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbcI0RXU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 13:23:20 -0400
Received: by mail-wm0-f48.google.com with SMTP id l132so24790405wmf.1
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=moD6dC+NoywNreddQxOYr+ctrsnL3nlqqSIjjRQZ4No=;
        b=SaofBDarymrzZYRwsCheredqKfaCRv9fq+veq2hUDaSEPSGh+7xz6ncD0gfpza5Ldx
         cDQwtnBntEGDTyEpL4hKk/gKs+bUpiEH/IM9vtXew2JIRNM2Vsy1xj1mqyPn6i9nkURb
         dRKxh8OZa86PPPj8HaiD7eMrxvscgyDrGScj2qqsOfe5ylP8xV6iZ7WljTf+0xV0F8O7
         Z6WBA8BqAlvYNZGsTXHcdvMyiamQvkOHjNGWvlDaFRzi7qpQqfuvUFbvAn66LdJHpYXa
         eiJyX6QN9nIeSz9/i/cOWIhKASGvZACOmXUW9u06LwFkfS+aNAXKdSjFNWyrjO0gorWa
         17vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=moD6dC+NoywNreddQxOYr+ctrsnL3nlqqSIjjRQZ4No=;
        b=cJ2Qw3rn7ZQwM4FVNpoyxMmDJTT3SOVo2iRL12XJ3DJY/aqxAkX73U6MxvjBjtx9Iv
         +d6ryNAGSufuiYxXjiF0AVdN202LIUews4LC8tJ+lCdsm6JjWg0eFiz9I2umj45oAWh+
         1Q4or6w3T5oVjgboByce5l5YfeUBphDArplK6qV6GSGTDFH9t2L41dgASWe8GkOjSURP
         Zm3IJ6E3Cu1u7JxyyLyjSUJqMZ716R+ZKGo+XvXhl9JiahvZfZWf2CFkE8wPmu9wXdmx
         SbUvdW3J3NcEMFl6M0PTFMJ0XqyjHLwK8PTVDsIJ/aHR6TUdB0rxOeuK602bEADH7BbT
         sbuQ==
X-Gm-Message-State: AA6/9RkQHS0pgYiImyUoQ5390+4Zau9hZJjXVFdHqnYDN/Sr/iDQ6thvk/ExdNkD5WV1xx87IlErNsDQOEGWNA==
X-Received: by 10.28.154.142 with SMTP id c136mr4196313wme.102.1474996999023;
 Tue, 27 Sep 2016 10:23:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.148.198 with HTTP; Tue, 27 Sep 2016 10:23:18 -0700 (PDT)
In-Reply-To: <xmqqd1jpqp7p.fsf@gitster.mtv.corp.google.com>
References: <1462458182-4488-1-git-send-email-orgads@gmail.com>
 <xmqqwpn8bes0.fsf@gitster.mtv.corp.google.com> <CAGHpTBLdy9R7xvfcFWoMkvGNJjY-wM5=HfWxs8XF_yh-+2Rc3w@mail.gmail.com>
 <CAGHpTBLgwyw_iYK927Yed+XG9ti+tKboz07-FVYWox9WoQkjOg@mail.gmail.com>
 <CAGHpTB+Fnu4x1bV9TSNo8pYdOzJzRsXA9r3CwxVz64mjW_qsGw@mail.gmail.com>
 <xmqqmviupcpx.fsf@gitster.mtv.corp.google.com> <CAGHpTBLPvQDD4hhMKiOFdhxug-joi-38mNozuzm3=EJCnS9UEA@mail.gmail.com>
 <xmqqd1jpqp7p.fsf@gitster.mtv.corp.google.com>
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Tue, 27 Sep 2016 20:23:18 +0300
Message-ID: <CAGHpTB+XOxMh=o_dKGx-j2P15zsmcMn0MB7BuKFksOn4O_FXYw@mail.gmail.com>
Subject: Re: [PATCH] git-gui: Do not reset author details on amend
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Pat Thoyts <patthoyts@users.sourceforge.net>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 27, 2016 at 7:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Orgad Shaneh <orgads@gmail.com> writes:
>
>> On Tue, Sep 27, 2016 at 12:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Orgad Shaneh <orgads@gmail.com> writes:
>>>
>> I actually see that there is a problem with it:
>> https://github.com/git-for-windows/git/issues/761
>>
>> I'll try to revise it and resubmit.
>
> Are you by chance volunteering to be git-gui maintainer?

No way, sorry. I don't speak TCL at all. Every change is a true pain... ;)

- Orgad
