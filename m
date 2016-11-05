Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 273192022C
	for <e@80x24.org>; Sat,  5 Nov 2016 20:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756104AbcKEUWB (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Nov 2016 16:22:01 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35198 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755721AbcKEUWB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2016 16:22:01 -0400
Received: by mail-lf0-f44.google.com with SMTP id b14so87207611lfg.2
        for <git@vger.kernel.org>; Sat, 05 Nov 2016 13:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=q3bmT5yO7eTrbxJZRIeW2Mc/FElT7zM2Pc21wouiTGQ=;
        b=ayIX6kaX0AXv96A6qVwqzrzuDygNZ0KyO5nCYxR1VhRpOAXSN8WD3QUI0Je2J/qGhY
         aVH3jiobyDGfqQMZBfNkmrvePAMSZDo/Ou09MxU8OjeLDhGQhy6swIa0z5tCJPtURuB0
         N9CiXbOAGqnprlxexgHXBz2+DvAVn99G1x3/wp7jPdlIicdvyYjFGVbAg7lm20eLYwU/
         dcw8L3daJmOsFHR96HQWzSSixj6mRX3qhI1T43JT+L9JjObtbEXIW3WXCGhCv3+IhuC9
         ZH1xWV6oa1iTIO0Gat+IeTfsqT+cydrr7cZry1nPpd7pgyhHI68WMTBIbeHc7iYxwjGW
         dgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=q3bmT5yO7eTrbxJZRIeW2Mc/FElT7zM2Pc21wouiTGQ=;
        b=bO2y7tTsJUFEw1km3ISt4zDFwUeIp2OIkwnW9zfGK56lI2Ih35uzHc+PsXjv7nr34Q
         ncw7T7Y7a7TGVQ+cZ4jxb+3fSZn3bpHc4aK+FR+SuRXoVT7GiIAb7pgzr9iQu2dnQOf6
         1Icgx9nGK39UulenvDbdgUwDGDdK0ziiPqnjUA4NdnNHPl3XUvcKuc958kJLCH9UUXjS
         VOKzS4kchxudgVYdnXVUGtuiPmTWvbHG2UOxBYNrg50EiKUZjVQTyKd86476PpnguWQ6
         mtRzy+zBb5kbqHACwKOuJcfoyLbigjMjwdwBukqaSxboHjIDfbd3XK3xYUJXIGtNoPhS
         dyKA==
X-Gm-Message-State: ABUngvcaQCOSb8Q7VsI92erq4BFNMMqACe5QbD2IZ2FPMMcsCGTMG8lDV7WSNWC7Xk3cErKuMqwcAfUglLHwEg==
X-Received: by 10.25.72.74 with SMTP id v71mr13040973lfa.130.1478377319082;
 Sat, 05 Nov 2016 13:21:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.163.84 with HTTP; Sat, 5 Nov 2016 13:21:58 -0700 (PDT)
In-Reply-To: <20161105151836.wztypzrdywyltvrc@x>
References: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com> <CAP8UFD2+A0MUKazAfSwCvv61TJRPuoOzH5EkqcrBOUi4TcuoDw@mail.gmail.com>
 <xmqq1syqedv4.fsf@gitster.mtv.corp.google.com> <CAP8UFD0bqNQZ3nuGUDX0qrSo44hf1NL9LeZB_FQcXg3j0mD38A@mail.gmail.com>
 <CAP8UFD1EZ8HBzLAeyFBFgU7n2uJpswqgEgA4XM1YJuRAG_ZAAQ@mail.gmail.com> <20161105151836.wztypzrdywyltvrc@x>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 5 Nov 2016 21:21:58 +0100
Message-ID: <CAP8UFD3XFHr7POKmZr_6guapC6sme3GvWBV5vPw4XO7FE5HOPw@mail.gmail.com>
Subject: Re: Regarding "git log" on "git series" metadata
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        "Shawn O. Pierce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 5, 2016 at 4:18 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> On Sat, Nov 05, 2016 at 01:45:27PM +0100, Christian Couder wrote:
>> And with what Peff says above it looks like we will need ways
>> configure and tweak commit reachability with gitlink/gitref anyway. So
>> the point of gitref compared to gitlink would be that they just have a
>> different reachability by default. But couldn't that be replaced by a
>> default rule saying that when a gitlink is reached "this way or that
>> way" then the commit reachability should be enforced, and otherwise it
>> should not be?
>
> Any version of git unaware of that rule, though, would consider objects
> only reachable by gitlink as unreachable and delete them, causing data
> loss.  Likewise for a server not aware of that rule.  And a server
> unaware of that rule would not supply those objects to a client pulling
> such a branch.

Yeah, so you would really need an up-to-date server and client to
store the git-series data.
But anyway if we create a gitref object, you would also need
up-to-date servers and clients to make it work.

> So I don't think "gitlink defined as reachable" quite works, unless we
> make some other format-incompatible change that forces clients and
> servers touching that gitlink to know about that reachability rule.  (In
> the absence of a hack such as making the same commit a parent.)

There are other tools that would like to tweak reachability rules for objects.

For example Mike Hommey's git-cinnabar:

  https://public-inbox.org/git/20150331100756.GA13377@glandium.org/

and my current work on external object databases:

  https://public-inbox.org/git/20160628181933.24620-1-chriscool@tuxfamily.org/

would be interested in a way to make some blobs not reachable.

So if we had default rules and a generic way to specify that some
objects are, or are not, reachable, that could be used by many tools,
and the design of these tools would be simplified.

Maybe this could be specified in the attributes files, or in a special
file like for shallow clone.
