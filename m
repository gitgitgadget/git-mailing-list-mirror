Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25D8F1F45F
	for <e@80x24.org>; Mon,  6 May 2019 19:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfEFT2F (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 15:28:05 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:32845 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfEFT2F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 15:28:05 -0400
Received: by mail-yw1-f73.google.com with SMTP id c4so27281521ywd.0
        for <git@vger.kernel.org>; Mon, 06 May 2019 12:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rRbtEhTMVAjZ8jwEYcAsPBoAS3X7ZHTyKdmsHm1B6OE=;
        b=H6WSI7PMWj7VrZXfl9hvNms70sTenLOII7y+G8QjxrOor5hhmw8+neUpJFT10x8yjm
         ba27T+4RDc7OeOkr+0ZVTUT56uDMjsZbckIhkdCtsodt0IPCPK+bo4AjYYBYz/R81Vmc
         6LiDX/I4oQIiVYsT4Y3KY1Wt7jL+VrTr/sx7IJUCjR+flQwR9crIzpcUOFKlak+AaD2F
         nKzSC6exI9I3DoA7nVhy3cr5k9ST8R5568mKY/61iWSv1w1lsGPxEesR5cXekyacNzVp
         cWxZXxW6LqdfYduusc5Nsp5i2PdncdBSWIFTUMSr9wxxGRR+pOFzjzy2fN31DmXvtAyr
         YEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rRbtEhTMVAjZ8jwEYcAsPBoAS3X7ZHTyKdmsHm1B6OE=;
        b=s8P2q9d+bhv+LxBrG0J7uS0vr3tQOoYYBoR3YSt8L6/yknjRHK1CXnCCvISDwSyToG
         a0tJi1UMXZC3tYzEiDlyqqUbrGHeR4F+CdYZ4HgclBO+trcr91ubnMuYcflw4yQpwDnQ
         tkgHM1/34ieoLIjgoO4zmTrwM2T8htAaasXizcO4Y6YfAlAPeeLgHKYcB4kZKUjgqbXU
         y2ikmQpa6+4sjk9jsHGHjWoKeYWkuxU3aKa64YkQXlZbhDnprOD77Esg44OeK7FNSR08
         JD3lJqlP7EK7Kc3skLZpXjxnU3mJLuUQQd9rcS5Iqbc4d8RNVRrS59b/6weNvInT3cQb
         hhoA==
X-Gm-Message-State: APjAAAV5TowSuYFhrsF7WHxwIS3Mqr7NKE6r5P3RC8EuTt3zfttorje6
        yvTBEgchJEkSe+slSArMDZkqOsz/o+m2Jal/HDEI
X-Google-Smtp-Source: APXvYqyzkEYocm/EZrYoDMbf0mUSZ6LF6eGl7ULZl1HeaZclulbNYjbmjYQBIxLgNWmG22vIkgoRPjAnX6bZBfC0E37R
X-Received: by 2002:a25:6893:: with SMTP id d141mr16928020ybc.441.1557170884076;
 Mon, 06 May 2019 12:28:04 -0700 (PDT)
Date:   Mon,  6 May 2019 12:28:00 -0700
In-Reply-To: <CAMfpvhKYRVwTVNLfRJYcjhHtg=FNLNPbnw8xtY93nJu228v6=g@mail.gmail.com>
Message-Id: <20190506192800.213716-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAMfpvhKYRVwTVNLfRJYcjhHtg=FNLNPbnw8xtY93nJu228v6=g@mail.gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: Re: Proposal: object negotiation for partial clones
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matvore@google.com
Cc:     git@vger.kernel.org, jrn@google.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I'm considering implementing a feature in the Git protocol which would
> enable efficient and accurate object negotiation when the client is a
> partial clone. I'd like to refine and get some validation of my
> approach before I start to write any code, so I've written a proposal
> for anyone interested to review. Your comments would be appreciated.

Thanks. Let me try to summarize: The issue is that, during a fetch,
normally the client can say "have" to inform the server that it has a
commit and all its referenced objects (barring shallow lines), but we
can't do the same if the client is a partial clone (because having a
commit doesn't necessarily mean that we have all referenced objects).
And not doing this means that the server sends a lot of unnecessary
objects in the sent packfile. The solution is to do the fetch in 2
parts: one to get the list of objects that would be sent, and after the
client filters that, one to get the objects themselves.

It was unclear to me whether this is meant for (1) fetches directly
initiated by the user that fetch commits (e.g. "git fetch origin",
reusing the configured "core.partialclonefilter") and/or for (2) lazy
fetching of missing objects. My assumption is that this is only for (2).

My main question is: we can get the same list of objects (in the form of
tree objects) if we fetch with "blob:none" filter. Admittedly, we will
get extra data (file names, etc.) - if the extra bandwidth saving is
necessary, this should be called out. (And some of the savings will be
offset by the fact that we will actually need some of those tree
objects.)

Assuming that we do need that bandwidth saving, here's my review of that
document.

The document describes the 1st request exactly as I envision - a
specific parameter sent by the client, and the server responds with a
list of object names.

For the 2nd request, the document describes it as repeating the original
query of the 1st request while also giving the full list of objects
wanted as "choose-refs". I'm still not convinced that repeating the
original query is necessary - I would just give the list of objects as
wants. The rationale given for repeating the original query is:

> The original query is helpful because it means the server only needs
> to do a single reachability check, rather than many separate ones.

But this omits the fact that, if doing it the document's way, the server
needs to perform an object walk in addition to the "single reachability
check", and it is not true that if doing it my way, "many separate ones"
need to be done because the server can check reachability of all objects
at once.

Also, my way means that supporting the 2nd request does not require any
code or protocol change - it already works today. Assuming we follow my
approach, the discussion thus lies in supporting the 1st request.

Some more thoughts:

- Changes in server and client scalability: Currently, the server checks
  reachability of all wants, then enumerates, then sends all objects.
  With this change, the server checks reachability of all wants, then
  enumerates, then sends an object list, then checks reachability of all
  objects in the filtered list, then sends some objects. There is
  additional overhead in the extra reachability check and lists of
  objects being sent twice (once by server and once by client), but
  sending fewer objects means that I/O (server, network, client) and
  disk space usage (client) is reduced.

- Usefulness outside partial clone: If the user ever wants a list of
  objects referenced by an object but without their file names, the user
  could use this, but I can't think of such a scenario.
