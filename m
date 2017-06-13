Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1E2C1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 13:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752756AbdFMNGb (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 09:06:31 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36222 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752456AbdFMNGb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 09:06:31 -0400
Received: by mail-pg0-f41.google.com with SMTP id a70so60524924pge.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 06:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=V2O75GTIpkRh2M+uzvlBpa656o9QaG/ia10ydHBo2jQ=;
        b=Q7aIx3/IzK6tBkWouUjwBHpk4YS+x06qdFPHXkGBKFzAFcv10jImYQklYk+E/CcEt8
         mJ0g5pgqiNJ/wqA8iN4PCgWaFnxcSnnTMuAji6AawZQM7F3iXWdm/A0oIdt4ho4I5f4l
         v504Iz7WJmsrJUm2DvllqR2paftiaSFKleZLK1M1AwoX9NmwCysvGf0OgRSC16gK5quP
         5J4TdZAmbcog4n8gKZwv9Hc22exnKvmldjPiHlLOabmPeb5e0f6cJWuu7vCV7VFcUqr4
         njJqlY0vrtNH2ZY/c5AUuf4J7R9hlyXRfsyDuvHxb6yelhgmdvOgXG1w/BRRaFjjlw1G
         aD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=V2O75GTIpkRh2M+uzvlBpa656o9QaG/ia10ydHBo2jQ=;
        b=b6JYnlS5eYO9oJOa0At83LmnWSHS33PMAe44nxtZP+EHxirwdElvegq0Dc4+my5kwH
         HPRwrSRFDv4Y3pouyl3TWkVZiRVR2JWd2XOkoAL358V3/kin9KRLt3giIljt2aZ5sV03
         4+vgzXc23gZuqBoxV25BoC4+QS4Eai4NEexD1MXXFr/uPtfsBHxeNb3OupNmHgDzJUxD
         0ipDiaSRghkWqOUKkrPCwRMLkeOrRvFju5RHPXm4hQmAHR5a0NjRbe10MI6vnw7mMgWO
         5HRyl+JrLbCOrpcj7XwBuKNUJ6BlcRYX4Rdveke1C3YNgKZPcR1u9tjKbO4LqylLc0MU
         19Kg==
X-Gm-Message-State: AODbwcAclAHzhQoocdpWqg9a6lJCN34mKJtFyVCklPLkOXaDtLQ0QAFX
        jh4GNdNkAs63oA==
X-Received: by 10.99.127.89 with SMTP id p25mr47310860pgn.120.1497359190382;
        Tue, 13 Jun 2017 06:06:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id c27sm26802083pfj.107.2017.06.13.06.06.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 06:06:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     liam Beguin <liambeguin@gmail.com>
Cc:     Konstantin Khomoutov <kostix+git@007spb.ru>,
        Jeff King <peff@peff.net>, Samuel Lijin <sxlijin@gmail.com>,
        Houston Fortney <houstonfortney@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Feature Request: Show status of the stash in git status command
References: <CA+B9myHRahTd+FDgzK5AhXW+hq_Y_czMX9X6MXYBcr9WSPeiDw@mail.gmail.com>
        <20170610082534.6437ifexzly4oqg6@sigill.intra.peff.net>
        <CAJZjrdXCHVKQOxR=+z5cOkieKzE-iSMta--kHVjSYXuansb34Q@mail.gmail.com>
        <20170610102217.vxf6tsrdfp6srupr@sigill.intra.peff.net>
        <1c04d689-6796-17d1-e058-18874768c22a@gmail.com>
        <xmqqpoe9p6bn.fsf@gitster.mtv.corp.google.com>
        <2217b9a1-dc8c-635a-649e-eae2dec5aaa5@gmail.com>
        <20170613064142.aww23a75pu3ytym6@tigra>
        <be7311a1-1dfa-2cb6-4426-6771db545892@gmail.com>
Date:   Tue, 13 Jun 2017 06:06:28 -0700
In-Reply-To: <be7311a1-1dfa-2cb6-4426-6771db545892@gmail.com> (liam Beguin's
        message of "Tue, 13 Jun 2017 08:34:17 -0400")
Message-ID: <xmqq4lvk9gvf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

liam Beguin <liambeguin@gmail.com> writes:

>> The fact a stash entry is a merge commit of two synthetic commits is an
>> implementation detail.  It can be very useful at times for power users,
>> but regular Git users need not be concerned with this.
>> 
>> Another fact worth reiterating that what the UI displays to the user is
>> better to match what the user reads in the docs. ;-)
>
> I'll make changes as suggested by Junio. I slightly prefer
> "Your stash has %d entry/entries" over "You have %d stash/stashes" 
> but I'll go with what's used elsewhere in the documentation. 

Yup, I agree that I would definitely call them "stash entries" if I
were writing the documentation today, but lets match the new message
to the existing lingo first and think about renaming "a stash" to "a
stash entry" as a separate step.  The latter would become a larger
change (we'd also need to add an entry to glossary-contents.txt).

Thanks.
