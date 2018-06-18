Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C02B1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 21:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935873AbeFRVHh (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 17:07:37 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:37098 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935743AbeFRVHg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 17:07:36 -0400
Received: by mail-qk0-f202.google.com with SMTP id w74-v6so15905471qka.4
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 14:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=EOGggs49WTVuINImdWI+C1BgWnPxT5aCobd8SHXy9Tg=;
        b=QGOxTUXpi2RebyuiQxYr3BYmDmsepvplRMzyztSzF+x9/YBvS5eHwdvT4GTm66yYy9
         /x9yhqhiAmyr2uVjPtI9RyPXVT5uknZTblNIaqqNYo3QBU8A4A9CQVWlxASPNSd3xviJ
         WH4V2xCAjMRfYjT6ymlJtU3xZhSc5ME4w+KOZzfAJXtY/8TQZ2KnY04SrhsebK+Y4Oc/
         OVLNfBSWxazl4D7R/F95Y75NrFfs2YnK9pdBjZ3BkmtYHzJYEG17/mM6d60olZh3OnvI
         26E0LfUgjWvbbgMw4PFhb9tY7eh/W8mH4vfoRlYa/3VOD9qeapHr54Gw/Kzyce2dTvxd
         RRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=EOGggs49WTVuINImdWI+C1BgWnPxT5aCobd8SHXy9Tg=;
        b=ZRIP1lufr5NhESTaZkxZoVjK9Kt2mzsckKRvmoHTq9p5vm97yc6R9XTsts0FLC0g0f
         5EKdaDQw35nDfrrHyT4o1z39PKbLkpY/o9C2P7ATpCRq528vnBhKh+Vx5FIRk2uO6Gny
         ghrbjxFgchVqFdw9zoMOj1sop8IchOzMjPo6ZkZXlSDQ1i8za0hhm6NR7+Y7VrxubipB
         5KIRGlIoT1p7+eRg5vJiH583RA/AlB6YBDnbU7+HJC0gaOMUon5pZizHpPidgedDWh4S
         jcUlYCKWG2OS/Me33ILrrNOMVkm1sX12OlOHaty7vh/oOrMjOYwtqbz+66aT1LRkAOl0
         KXSQ==
X-Gm-Message-State: APt69E2j4Ymoktlajza43sWyJl6IwA/urbhaGhrbY0FjWgDlblIAbrnU
        kHBkLwvgvDuXMtVwwb+keQh+imI40LqHOs0QMsA6
X-Google-Smtp-Source: ADUXVKILJws6Ziy3a6xPv/rN+LOrrmJ3MbhzKRjwX5WZsSjUdT0LNV0DpiujPwSxTkFbo7TsQmOqUU3v68diQfdb8qA4
MIME-Version: 1.0
X-Received: by 2002:ac8:4508:: with SMTP id q8-v6mr7781469qtn.39.1529356056039;
 Mon, 18 Jun 2018 14:07:36 -0700 (PDT)
Date:   Mon, 18 Jun 2018 14:07:31 -0700
In-Reply-To: <xmqq1sd3yii2.fsf@gitster-ct.c.googlers.com>
Message-Id: <20180618210731.152140-1-jonathantanmy@google.com>
References: <xmqq1sd3yii2.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.18.0.rc2.347.g0da03f3a46.dirty
Subject: Re: [PATCH v2 2/2] fetch: send "refs/tags/" prefix upon CLI refspecs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, bmwill@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > When performing tag following, in addition to using the server's
> > "include-tag" capability to send tag objects (and emulating it if the
> > server does not support that capability), "git fetch" relies upon the
> > presence of refs/tags/* entries in the initial ref advertisement to
> > locally create refs pointing to the aforementioned tag objects. When
> > using protocol v2, refs/tags/* entries in the initial ref advertisement
> > may be suppressed by a ref-prefix argument, leading to the tag object
> > being downloaded, but the ref not being created.
> 
> I wonder if it is reasonable to define the protocol v2 semantics of
> "include-tag" request a bit differently.
> 
> Unlike v0 protocol where the client iterates though the advertised
> refs and see if objects at the tip of them, even if they weren't
> what the client initially wanted to fetch, to find these unsolicited
> followed tag objects, allow the server to say, "I've included some
> objects you did not explicitly ask for, and here are the refs/tags/*
> names you should place on them", somewhat similar to the way how the
> ref-in-want thing would work (i.e. the client does not really ask
> for just objects and decides what name to place on them---instead it
> lets the server to make part of the decision).
> 
> Wouldn't that allow us not having to advertise the whole tags
> namespace only to implement the tag following?

Yes, it would, but as far as I can tell, it would add an extra burden on
the server to walk all refs requested in the ls-refs call (in order to
determine which tags to send back in the response). Also, this walk must
be done before any negotiation (since this is a ls-refs call), so the
walk is done all the way to the commits without any parents (and so an
overestimate of tags might be sent).

It might be better to have this functionality with ref-in-want, not only
because of its conceptual similarity, but because ref-in-want provides a
way for us to send refs at packfile generation time. So it is more
efficient (since the server has to iterate through all the refs anyway
to include objects for include-tag, it can probably just remember which
refs caused objects to be added and return them), and also, the list of
tags will not include any tags that point to non-sent objects.

So my current inclination is to let v2 "include-tag" have the same
semantics as v0 "include-tag", and only provide automatic sending of the
ref itself when we have ref-in-want.
