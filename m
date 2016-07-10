Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E45C32018E
	for <e@80x24.org>; Sun, 10 Jul 2016 21:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757287AbcGJVw6 (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 17:52:58 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:36822 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757237AbcGJVw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 17:52:58 -0400
Received: by mail-yw0-f177.google.com with SMTP id b72so78202117ywa.3
        for <git@vger.kernel.org>; Sun, 10 Jul 2016 14:52:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=VBPIzSmv9JNnFg4o6nMMsxAQfDSbhxo4TpgiDXB+5Zo=;
        b=tJcnA0MYJDILGEYqxb+MUq9F/AZFVOzNgZOp3zmMJ/MixkhzBLBXcwlRczx5aoJq+k
         kFndDD/SRPl4ktzbK8kSyIT0pmn37ijVob30lb3Lb65dKfK0rotShcjxxf4Nga3EFbSF
         w2OO67VjwU8h6AUJldMzP4uVmGAA6GwcnZidS7zAvbUXXnAjImq3MQJ1ljDHEaoAM6nL
         2yjzw31t6J4IGV51u7YGSszKfzPc/CBu6Zi9smRDiNawJLTpqhLmDrxT5gFyI2u4Ze3/
         UAqMFPz+quZDA5doQV+HmZbtafOMsiZxZiGzaG1dboGGRcnK4V9tcCBxOFx6HBmBMO2u
         w2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=VBPIzSmv9JNnFg4o6nMMsxAQfDSbhxo4TpgiDXB+5Zo=;
        b=jCyugmrDmk8sG2pmJHK3hPd96iabIQAHoSEWCJFJxLotp60JWjKf77DzmRdROaZszl
         Em9x7JxabuadidDqZbs2CeKWhqZtXWVoaIvHYm/+uVFXI/tB23p0LMdnBLLHqO+xODJz
         1O8BwE/GBlHN8j5zUjK+s9IR/1vKcBViMlgXi+N2d1szH9rqFunJr/vo2JT3cn/8CaeR
         SLvwZhPzw+Yuu6obNcm0EJ2XoR2zMNOczGWV1TQTz4oAe2kjwZrDVdZs/uFlMN9n9m+5
         XDwUHsNQctkX8oWWSpSbPhsZvhUNRlEe+9rbPu+BoLpuiRHmODMnikYSqpcwsX1/cZO0
         L5+Q==
X-Gm-Message-State: ALyK8tJBMB1ZZ/l0hpu4vyIvIbAYS0BRiCr2NhmPO8CIvlUT63BNTEG42GgoXaGDOXDXk24uAw7MnmNU5ZSloA==
X-Received: by 10.13.250.194 with SMTP id k185mr12621323ywf.317.1468187577175;
 Sun, 10 Jul 2016 14:52:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.240.66 with HTTP; Sun, 10 Jul 2016 14:52:37 -0700 (PDT)
In-Reply-To: <CA+55aFx=qT9mNo1MDkQuzB=V7=STSc_Knmj=6589qi=tSZs1ag@mail.gmail.com>
References: <CA+55aFz=sZnABJr6F2yF_xvx6J6fZod6BbiL2OwszEnjjn-dEw@mail.gmail.com>
 <87eg712v5o.fsf@linux-m68k.org> <CA+55aFyJP8FLaBtsMekzQDsCjDbFPa-qUZNHZNpvva2vZTRGgQ@mail.gmail.com>
 <CA+55aFymKO5Bi2qZ-zaiZKQAk7RxusEMJ9Y0Gw6ywdznK+TaRQ@mail.gmail.com>
 <CA+55aFwvZqqSkphgL+UBqfXnSGAFEzmqyH83OMGnpco3ZVZUnA@mail.gmail.com> <CA+55aFx=qT9mNo1MDkQuzB=V7=STSc_Knmj=6589qi=tSZs1ag@mail.gmail.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Sun, 10 Jul 2016 14:52:37 -0700
X-Google-Sender-Auth: 3x2E1PAYARu8AniBEExTOzchdMA
Message-ID: <CAPc5daUAfFJisFySuX1XgoufkaX7sSeSpW+vJ1ZG7Fia=Z9DLw@mail.gmail.com>
Subject: Re: Odd git overrflow bug?
To:	Linus Torvalds <torvalds@linux-foundation.org>
Cc:	Andreas Schwab <schwab@linux-m68k.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 10, 2016 at 2:29 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sun, Jul 10, 2016 at 2:21 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I'm not sure why it doesn't happen in current git master, because that
>> function is the same, and the logic around expand_tabs_in_log looks
>> similar too.
>
> Ahh. Commit 43ec55091553 ("bisect: always call setup_revisions after
> init_revisions") is in master, but not in v2.9.0

Yes, leaving it in 'master' a while and then merging it down to
'maint' for v2.9.x series
is the plan as usual. Thanks for noticing and following up.
