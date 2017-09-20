Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4045620A29
	for <e@80x24.org>; Wed, 20 Sep 2017 20:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751587AbdITUJI (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 16:09:08 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:57246 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbdITUJH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 16:09:07 -0400
Received: by mail-lf0-f46.google.com with SMTP id a18so3799361lfl.13
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 13:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1I1WZdqj0GEz4ThsIPx81QG20lh0HAVrqiR5Fop+PUM=;
        b=HoSVLPLkoMXdU5G5mrri+oaW/8F7/uBaPqB9x2uXwg2HskRwNqXrLxGXwl7xxq8cnQ
         IqbRdqyr9uhZdjkGWW9qX32WEtY+xlLDIe3Su7XJljLMU1et1/oCT0SomfKRNeBd7hj+
         vKaJMsaolI9nldXfqnxhKBxvT93WgU3FreqmC49LWm7gx2JxnYY/fMCm/MNeesxmbG8T
         ACOcer6A64vnT6Y54BhNW9TtBHX7Vx0Ep+DRQ/oqpyv+TXWctIPBWweEp/o4l0yD8OLq
         l2ydUnaEYh6UmyT03AzdCwbK0qrWShVqJZi6QBzsGruOVYdB4362ErYHkTzbbOpKnx4U
         qXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1I1WZdqj0GEz4ThsIPx81QG20lh0HAVrqiR5Fop+PUM=;
        b=kDQ8VGNXKTOq7nt6s9Fkov+4BjcMYX0MyVivfnfqdxTgRL1mYRYOtPIaEMtjuZoEkb
         X08l3atgO5Xn6UD8TBxZVLcRxnpNGkLQp+kcxMmBzHHubkICcuQnF/eTly7+8mkr23TV
         I7GxKLOlFHC1lT/q92eleKvrahMsvwolq+ouEdST3gIePunDb83Wodk0fQNDVqt012DT
         btfAqKiOISQUBhqU3dwpRA/G2gbvV++NYLDGV5+saVNd1OE/WfCgBVCqPBDIRiooaaoF
         FpRSoWK4i3OmXcPut2QjEQQNB8aZqIB0QK7AjyO52rir2jsiVVYvlKg8GpPKs0hq7Jut
         dhKQ==
X-Gm-Message-State: AHPjjUguxURxjV3kzFMS9d1UknKZhRAbqy1qJyvYxn/uhH6YT9NkwbLu
        nQBxZnxaconEJBfqY/o/KPvf2LbYRF3RlfSkwlA=
X-Google-Smtp-Source: AOwi7QDuBUulLEV7IF4WYIIVEG5yCsgatPV0yz1GmloayLyIwOOLHoW8KU+7J7zoHE/dBYGzGDtJ4SnUF3ZraRRWCxA=
X-Received: by 10.46.14.10 with SMTP id 10mr2679067ljo.11.1505938145739; Wed,
 20 Sep 2017 13:09:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.209.85 with HTTP; Wed, 20 Sep 2017 13:09:04 -0700 (PDT)
In-Reply-To: <xmqq7ewzwuo6.fsf@gitster.mtv.corp.google.com>
References: <CAC7pkbQhwLFQQjqBwaW=0j4iKFcLdKDucCMck-PsSAeCs0rqpw@mail.gmail.com>
 <CAGZ79kZLvAgSgckQ7Doo_E7aY+L6xtv2Kq0xbO6GSZL5ZAb7TQ@mail.gmail.com>
 <CAC7pkbQwn8pvLLCtjsEkKo7PJozycdDbnq2XLWbmOm_KHEjU-w@mail.gmail.com>
 <1505440235.1862.9.camel@gmail.com> <CAC7pkbREUZxG0drWVpV43TFv7AVi2agJkRtXZgNsLErk3iBc-w@mail.gmail.com>
 <xmqq7ewzwuo6.fsf@gitster.mtv.corp.google.com>
From:   Joseph Dunne <jdunne525@gmail.com>
Date:   Wed, 20 Sep 2017 15:09:04 -0500
Message-ID: <CAC7pkbTU9Ts01p8kDJXqzk2yy=8Y-8dmkGhAkJ96m4D5zCzdRQ@mail.gmail.com>
Subject: Re: commit-msg hook does not run on merge with --no-ff option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For anyone who stumbles upon this in the future, I found a very simple
workaround to force the commit hooks (including commit-msg) to run
following a merge operation:  Simply create a post-merge hook which
triggers an amended commit with no changes.

post-merge hook:

#!/bin/bash
git commit --amend -C HEAD

On Fri, Sep 15, 2017 at 3:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Joseph Dunne <jdunne525@gmail.com> writes:
>
>> Valid point.  The way my project is set up I always get a conflict on
>> merge operations, so technically all my merges (except fast forward
>> merges) end with a git-commit, which of course runs the commit-msg
>> hook.  It seems everything is working as designed.  Shame there isn't
>> a merge-msg hook.
>>
>> It seems I have no choice but to work around this issue.  Thanks for your help.
>
> I think Stefan wanted to say in his message upthread that with an
> update still in flight you may not need a workaround.
