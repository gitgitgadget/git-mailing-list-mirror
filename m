Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08BE8207EC
	for <e@80x24.org>; Wed,  5 Oct 2016 09:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754611AbcJEJnq (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 05:43:46 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:32852 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752185AbcJEJno (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 05:43:44 -0400
Received: by mail-it0-f66.google.com with SMTP id o21so3315247itb.0
        for <git@vger.kernel.org>; Wed, 05 Oct 2016 02:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mmtKzeu/aPEsQvATAbd4aUi0NrusgFzt+bqwzjmrgAM=;
        b=CsmmXRC+6ArKVIfSrqo7tSHDgxWCWqRgY9/L0w6xImLKuvWbf09z3DrH8LbtlDfKTV
         7+LlHYIoH7X1ChFFsJoFW0ANmPYcwcK6Knm+SDAmlnWS93UKbULh5PJ0P3W1ghFoR/f5
         pdlU+OeNADBfebPVfQ3m5N0VL/G+vDrHayLC3tmyCokNnOxj+/nkNN791f/1HnscGpxb
         Q7qRtXMT5bJ3HJHCBC24Iu7D9WWj7n6O/mqBXmalE5PaMbTr9I3jH0DwFUMxuB6JUosI
         iy9lpo7CPRVSHYXqeVyHboJZLypCymoO9ATbktfTkjsptJa8gmpfkRg8Mxn265DVQqYo
         daIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mmtKzeu/aPEsQvATAbd4aUi0NrusgFzt+bqwzjmrgAM=;
        b=ap+Qxlrne0+J3oj6Anr1wBAOAVQwCSvXpHFWLW/fUU3IOrkqNs0QGLgKD9intNVHSD
         8X7YojOta+8PjEa6VKBI6K4s01gjvxppEpT5MewNuulNTgxIAX4tmfRNbblO74Qs442G
         YwsFSxGT9N8IWffN2wP8Cl/QbwVXv5RkeUDrKUiVPPSynFPwf1cFI98FPzhsOAWwcXAF
         b0c55SA9zf7VcObNyD7zPMgnIeHxdiS8lcF6Fx/XnSOgHc8CNSKQNRgTEYep6pyPnDST
         /jPr+plp3f0OpWAtcs/DSSo5axryZydZW8jq0HHCbRcDDa6QlrLWCyMvibqpIThXd8TC
         +Cyg==
X-Gm-Message-State: AA6/9RkLFHgtY/Vkwgvppp2Tlh8ZRNy4/Ix+kz4xe60cMvJ0mhvF9tMg4hjX+/5N7jcrbufhGttzzj33Q7f0mA==
X-Received: by 10.107.202.4 with SMTP id a4mr9110953iog.19.1475660624007; Wed,
 05 Oct 2016 02:43:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.21.6 with HTTP; Wed, 5 Oct 2016 02:43:13 -0700 (PDT)
In-Reply-To: <xmqqd1jgw0nx.fsf@gitster.mtv.corp.google.com>
References: <20160928114348.1470-1-pclouds@gmail.com> <20160928114348.1470-2-pclouds@gmail.com>
 <xmqqzimrj03j.fsf@gitster.mtv.corp.google.com> <CACsJy8D28iq3r3O_uzjyyJT--KQunAySRgUthF3FMrb1VM6XKw@mail.gmail.com>
 <xmqqd1jgw0nx.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 5 Oct 2016 16:43:13 +0700
Message-ID: <CACsJy8D7c8Z_ugasn_scf391+C6GxJp1CYwHY4ndvVtLiJzxnQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] Resurrect "diff-lib.c: adjust position of i-t-a
 entries in diff"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 4, 2016 at 11:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> We don't use it internally _yet_. I need to go through all the
>> external diff code and see --shift-ita should be there. The end goal
>> is still changing the default behavior and getting rid of --shift-ita,
>
> I do not agree with that endgame, and quite honestly I do not want
> to waste time reviewing such a series.

I do not believe current "diff" behavior wrt. i-t-a entries is right
either. There's no point in pursuing this series then. Feel free to
revert 3f6d56d (commit: ignore intent-to-add entries instead of
refusing - 2012-02-07) and bring back the old i-t-a behavior. All the
problems would go away.
-- 
Duy
