Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76D4D1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 22:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbeJWHQh (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 03:16:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33838 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeJWHQh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 03:16:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id g12-v6so19706745pgs.1
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 15:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f5XlILaNe/kVNxXSqAlQaiL+/0QHl3fZBVixgWtzb4I=;
        b=JEXYQqAMpkc4uK/If0y7XdP4gnCjyTCqIwQvNSbrdW91op4Xu4gNF7lUGaWNAlRW7q
         z3g1MNEM0JEuORL7GLF+w2nzjVvMn+kYw/WU6593m+7E2zSEZ9UkRGfAzmOjN6Vb3ULh
         npJiVXREzAWA7SaUMrL+MLfsfflgtrl3NjkSMeUjmVOBbsBhg6YOqNivjNEJCq/28P1N
         YaFdkio6Jl+v/sGRi9EsrUNlYZeLEpkDKP5WnrkaTAjPcYbCbf+bz242nEz7pSa1IgDZ
         EffiokbB0z1sVKGo9WHoKSHbVIItrwG+GckDw3zhF9H8xpVoTQ4NO9/rjlW2BOqOb/nd
         Pivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=f5XlILaNe/kVNxXSqAlQaiL+/0QHl3fZBVixgWtzb4I=;
        b=sUaUNvPRn7QnzwGZmqq4LPeBupiXeHprH6Xo9wM8sJbxNMocdFCbItfVFtfiJstKZL
         zHUab3c91FlzbH0vkGQSWnpNMvI1X0faJFHQyMs7W+n+BR1CYdm6ycexVsan//5JLO3A
         s8PwpqU/nn1F0eFbHsb4jfYED9Y/YDS/zAEbVNtDNvHf3uSMD68VR0h0p9Ltx9hXzYzf
         +pdtl2oygR23NZKuGhIQLk9g2ycmbnv5n+7aufuftcTwwlkEDq6BKvALhw52oTCsC5kJ
         f6HHAYwXB2BTg0lvhtCIzE3NrvI10uirA+eBHrULe+KpYiOTQxpt10OH7JPNKkjCzivW
         YtWA==
X-Gm-Message-State: ABuFfogpOaehJ7MLOZA1NS868iAyRkhmf0rWRhpWLXDGz9a4PDTVD4zL
        ygYVG7Kb8optzNcVz11SkSotQQ==
X-Google-Smtp-Source: ACcGV617EDlTkxkbxQ/eYCPna83dBO8mxoHDdCpzcDYW/W1+cVnx3EVwTf2Z0gVV2OiXMhjWAm4buQ==
X-Received: by 2002:a62:12c9:: with SMTP id 70-v6mr47745587pfs.140.1540248965134;
        Mon, 22 Oct 2018 15:56:05 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id y24-v6sm36910365pfn.123.2018.10.22.15.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 15:56:04 -0700 (PDT)
Date:   Mon, 22 Oct 2018 15:55:59 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] protocol: advertise multiple supported versions
Message-ID: <20181022225559.GD233961@google.com>
Mail-Followup-To: Stefan Beller <sbeller@google.com>,
        git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1538516853.git.steadmon@google.com>
 <cover.1539305180.git.steadmon@google.com>
 <70986cec32880db16568d85c351b33e9a8e16f1c.1539305180.git.steadmon@google.com>
 <CAGZ79kbuVRAceWF5cb4JAk=ss_4sEKthwxMG2wM+gLWbUdcTVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbuVRAceWF5cb4JAk=ss_4sEKthwxMG2wM+gLWbUdcTVQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.10.12 15:30, Stefan Beller wrote:
> On Thu, Oct 11, 2018 at 6:02 PM <steadmon@google.com> wrote:
> >
> > From: Josh Steadmon <steadmon@google.com>
> >
> > Currently the client advertises that it supports the wire protocol
> > version set in the protocol.version config. However, not all services
> > support the same set of protocol versions. When connecting to
> > git-receive-pack, the client automatically downgrades to v0 if
> > config.protocol is set to v2, but this check is not performed for other
> > services.
> >
> > This patch creates a protocol version registry. Individual commands
> > register all the protocol versions they support prior to communicating
> > with a server. Versions should be listed in preference order; the
> > version specified in protocol.version will automatically be moved to the
> > front of the registry.
> >
> > The protocol version registry is passed to remote helpers via the
> > GIT_PROTOCOL environment variable.
> >
> > Clients now advertise the full list of registered versions. Servers
> > select the first recognized version from this advertisement.
> 
> I like this patch from the users point of view (i.e. inside fetch/push etc),
> and I need to through the details in connect/protocol as that seems
> to be a lot of new code, but hides the complexity very well.
> 
> > +       register_allowed_protocol_version(protocol_v2);
> > +       register_allowed_protocol_version(protocol_v1);
> > +       register_allowed_protocol_version(protocol_v0);
> 
> Would it make sense to have a
> 
>     register_allowed_protocol_versions(protocol_v2, protocol_v1,
> protocol_v0, NULL);
> 
> similar to argv_array_pushl  or would that be overengineered?

Hmm, well it wouldn't be quite as clean as the argv_* versions, since we
can't take the pointer of an enum value, so we don't have a good
stop-value for the va_list. I suppose we could use
protocol_unknown_version, but that seems unintuitive to me. We could
also pass in an explicit argument count, but... ugh.

Am I missing some other way to do this cleanly? I'll admit I'm not very
familiar with va_lists.

> > @@ -1085,10 +1085,9 @@ static struct child_process *git_connect_git(int fd[2], char *hostandport,
> >                     target_host, 0);
> >
> >         /* If using a new version put that stuff here after a second null byte */
> > -       if (version > 0) {
> > +       if (strcmp(version_advert->buf, "version=0")) {
> >                 strbuf_addch(&request, '\0');
> > -               strbuf_addf(&request, "version=%d%c",
> > -                           version, '\0');
> > +               strbuf_addf(&request, "%s%c", version_advert->buf, '\0');
> 
> It's a bit unfortunate to pass around the string, but reading through
> the following
> lines seems like it is easiest.
> 
> 
> > @@ -1226,16 +1226,10 @@ struct child_process *git_connect(int fd[2], const char *url,
> >  {
> >         char *hostandport, *path;
> >         struct child_process *conn;
> > +       struct strbuf version_advert = STRBUF_INIT;
> >         enum protocol protocol;
> > -       enum protocol_version version = get_protocol_version_config();
> >
> > -       /*
> > -        * NEEDSWORK: If we are trying to use protocol v2 and we are planning
> > -        * to perform a push, then fallback to v0 since the client doesn't know
> > -        * how to push yet using v2.
> > -        */
> > -       if (version == protocol_v2 && !strcmp("git-receive-pack", prog))
> > -               version = protocol_v0;
> > +       get_client_protocol_version_advertisement(&version_advert);
> 
> Nice to have this special casing gone!
> 
> > diff --git a/protocol.c b/protocol.c
> > index 5e636785d1..f788269c47 100644
> > +
> > +static const char protocol_v0_string[] = "0";
> > +static const char protocol_v1_string[] = "1";
> > +static const char protocol_v2_string[] = "2";
> > +
> ...
> > +/* Return the text representation of a wire protocol version. */
> > +static const char *format_protocol_version(enum protocol_version version)
> > +{
> > +       switch (version) {
> > +       case protocol_v0:
> > +               return protocol_v0_string;
> > +       case protocol_v1:
> > +               return protocol_v1_string;
> > +       case protocol_v2:
> > +               return protocol_v2_string;
> > +       case protocol_unknown_version:
> > +               die(_("Unrecognized protocol version"));
> > +       }
> > +       die(_("Unrecognized protocol_version"));
> > +}
> 
> Up to now we have the textual representation that can easily
> be constructed from protocol_version by using e.g.
>     sprintf(buf, "%d", version);
> which is why I initially thought this could be worded way
> shorter, but I guess this is more future proof?

Yeah, my understanding is that we don't want to assume that version
identifiers will always be simple integers. We could get away with
sprintf() for now, but I figured I didn't want to cause future pain
if/when the version identifiers become complex.

> > +
> >  enum protocol_version get_protocol_version_config(void)
> >  {
> >         const char *value;
> > @@ -30,6 +55,79 @@ enum protocol_version get_protocol_version_config(void)
> >         return protocol_v0;
> >  }
> >
> > +void register_allowed_protocol_version(enum protocol_version version)
> > +{
> > +       if (have_advertised_versions_already)
> > +               error(_("attempting to register an allowed protocol version after advertisement"));
> 
> This would be a
>     BUG(...)
> instead?

Ack, will fix in the next version.
