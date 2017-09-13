Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43EEE20286
	for <e@80x24.org>; Wed, 13 Sep 2017 22:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751316AbdIMW1O (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 18:27:14 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:43298 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbdIMW1O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 18:27:14 -0400
Received: by mail-wm0-f49.google.com with SMTP id a137so1311891wma.0
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 15:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QZ/qN9aE89dsBgueyFwSETjhjNHetNPaUjU7W/BQRpw=;
        b=aVVfZ16xdTLSWQjFLc3noECNgCDrGnsbboA5We7WdLe/O4X96ZVs3lI5CIq4d7q4u9
         CCnBO8ulbL1G5pu/zqfgKvtlh2KceWRKfsovNsZ0dTkcApn+cnj3KxZj/q1pBuREkfg9
         KmUDPr3eunYMQBA9/VqDId2OS1E168isdA/v2zvxowGXu0V+xKB3ZeDNdfNieP7dhD6j
         LV+To+1x+jTrFhXSSXfOvvZaKEIhR6EZUSHuWNJk+FQaIOHsJskNpqaB1bFEzFlIRofe
         CiqRSFPdVjcOtqaRSfSrunI85wPg9w+B0Ol66DUl/oZPbW8iSK1tEEZ5UAEckwIA4K1d
         edRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QZ/qN9aE89dsBgueyFwSETjhjNHetNPaUjU7W/BQRpw=;
        b=EHBvGdpR2BhHFGZMg7j7hBGC37OPk4aT6/uC55KMercoA0jXYOacZyHQookhduNaoV
         Pz6sAhlOa7XAPtF8KyLb72ZlcZuq3+dADm9PXy4lwmPYhkmaUK8hYnrQeKPTnnHyxIrm
         SAXwFF+DoCtyTCm8YUTi10dGRfTYKT5wAn+CggKYPEXkvyKaMu9k2pwbECyDDGkyxSJQ
         oi1/W9FBKMLjhq50jWMQ6ZTAIJm4Z41AW0zXXavtKhJ7ixV2GRKG0eQDvLR7XreQqJu0
         eAkOKOXjMKTmczQhzPPPpU42UBzTrNpP0LvzoF55TMe/GVbLDHq5aZKSJ37uhHc6eyc/
         H8/Q==
X-Gm-Message-State: AHPjjUhjD/h7YCOAc1GDtqensNI0T+hifziM59IfiT3LN+ZxxcQy4x6B
        qGMp878U99Hq9n9Gf9nODJXL7J21TRLdzy+whdIGvJfB6n8=
X-Google-Smtp-Source: AOwi7QAopuQewu0whnb0+o2yo7UszqlhYAnjVHIUh2IZjYN15FKlBGPp8U+0KPUHVkHOOqpxSP8QILl/CkBaxqnpKms=
X-Received: by 10.28.236.91 with SMTP id k88mr145160wmh.95.1505341632519; Wed,
 13 Sep 2017 15:27:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.170.68 with HTTP; Wed, 13 Sep 2017 15:27:11 -0700 (PDT)
In-Reply-To: <20170913215448.84674-3-bmwill@google.com>
References: <20170913215448.84674-1-bmwill@google.com> <20170913215448.84674-3-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 13 Sep 2017 15:27:11 -0700
Message-ID: <CAGZ79kaeWsWdhoC7VDy-YkL1wVWqaQ9=TQUti9HfwjbT2poQdw@mail.gmail.com>
Subject: Re: [PATCH 2/8] protocol: introduce protocol extention mechanisms
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, bturner@atlassian.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2017 at 2:54 PM, Brandon Williams <bmwill@google.com> wrote:
> Create protocol.{c,h} and provide functions which future servers and
> clients can use to determine which protocol to use or is being used.
>
> Also introduce the 'GIT_PROTOCOL' environment variable which will be
> used to communicate a colon separated list of keys with optional values
> to a server.  Unknown keys and values must be tolerated.  This mechanism
> is used to communicate which version of the wire protocol a client would
> like to use with a server.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  Documentation/config.txt | 16 +++++++++++
>  Documentation/git.txt    |  5 ++++
>  Makefile                 |  1 +
>  cache.h                  |  7 +++++
>  protocol.c               | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
>  protocol.h               | 15 ++++++++++
>  6 files changed, 116 insertions(+)
>  create mode 100644 protocol.c
>  create mode 100644 protocol.h
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index dc4e3f58a..d5b28a32c 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2517,6 +2517,22 @@ The protocol names currently used by git are:
>      `hg` to allow the `git-remote-hg` helper)
>  --
>
> +protocol.version::

It would be cool to set a set of versions that are good. (I am not sure
if that can be deferred to a later patch.)

  Consider we'd have versions 0,1,2,3,4 in the future:
  In an ideal world the client and server would talk using v4
  as it is the most advanced protocol, right?
  Maybe a security/performance issue is found on the server side
  with say protocol v3. Still no big deal as we are speaking v4.
  But then consider an issue is found on the client side with v4.
  Then the client would happily talk 0..3 while the server would
  love to talk using 0,1,2,4.

The way I think about protocol version negotiation is that
both parties involved have a set of versions that they tolerate
to talk (they might understand more than the tolerated set, but the
user forbade some), and the goal of the negotiation is to find
the highest version number that is part of both the server set
and client set. So quite naturally with this line of thinking the
configuration is to configure a set of versions, which is what
I propose here. Maybe even in the wire format, separated
with colons?

> +       If set, clients will attempt to communicate with a server using
> +       the specified protocol version.  If unset, no attempt will be
> +       made by the client to communicate using a particular protocol
> +       version, this results in protocol version 0 being used.

This sounds as if we're going to be really shy at first and only
users that care will try out new versions at their own risk.
From a users POV this may be frustrating as I would imagine that
people want to run

  git config --global protocol.version 2

to try it out and then realize that some of their hosts do not speak
2, so they have to actually configure it per repo/remote.

> +       Supported versions:

> +* `0` - the original wire protocol.

In the future this may be misleading as it doesn't specify the date of
when it was original. e.g. are capabilities already supported in "original"?

Maybe phrase it as "wire protocol as of v2.14" ? (Though this sounds
as if new capabilities added in the future are not allowed)


> +
> +extern enum protocol_version parse_protocol_version(const char *value);
> +extern enum protocol_version get_protocol_version_config(void);
> +extern enum protocol_version determine_protocol_version_server(void);
> +extern enum protocol_version determine_protocol_version_client(const char *server_response);

Here is a good place to have some comments.
