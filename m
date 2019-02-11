Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DF751F453
	for <e@80x24.org>; Mon, 11 Feb 2019 18:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732778AbfBKSx2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 13:53:28 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:40479 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbfBKSx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 13:53:28 -0500
Received: by mail-qt1-f202.google.com with SMTP id 42so13755158qtr.7
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 10:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2MNqxeyz/GKz9vBjVX7vToWftGSF8NzyqraCkW9Izew=;
        b=lN3J9KIU4ppqahnpeIdvmpmbZzAxxYy0CnfzjQt1W4WE9dR+x9XFk6h4UA/iZa0bNs
         uN+IT93VbkbSZpkfmYTOdiTuFoYkddFtfHZPmInBEMdzXUJewMSBXfyb7OeEYaRfeVAR
         a6/LzDbwlhKpgZv1futGO33q24/zKqY2AHlTLPnn/YD4Xzmau803SqG3sph3wuwoy153
         Jy6cSEL0gumL6QPsX2fxOzoejerPF4tTA+wScivsm+S6wbHSaSXPnxrf++jH5PMCBC2+
         XE7Z51RRNXbqgED94RMOFkmKZOHX3ygKFCm8CcNV1O5uGLe++vQMqCO4YeTUgO+cfMFd
         0Y7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2MNqxeyz/GKz9vBjVX7vToWftGSF8NzyqraCkW9Izew=;
        b=g9Hty9f57kBCXBEffppl/gBNFA63NA5qBLqOEHXkAlPa0/SqGJSNIgUr3P0eNyI+RK
         p90qDm8+3eAKqAp9UNGrMPDsPB9K1s1fnSWl7wB5fxR9XgcQJ8gLvad1S4Q+7845a3Va
         D3q/pjzbum4qyuRdfLUyf/HrzY7YeeiWAo8/fLiCQx62FsjJ5WXUVxjXYJ9/3KOkw81d
         s/KSvX3so34xAn3HX6binOy/7KUrWAqFdxOu0Gdl3SP5S2OjG+LLCkGLq7AHWFSTQXtQ
         blNbmxW3WEP2tXuJISesNYIl08d4c9f0+8a61MRq+WhOMVbEUczedOB/rq1oO3FfYrIP
         jQsg==
X-Gm-Message-State: AHQUAuYHGXM7I9XcmHboPTat9hm9DWh0wBDP5UyYz3hxN/m8pWwfgsnU
        ut9NA9Cd6LHdD+PRtWEBox5plN+YzeyupjyODiSV
X-Google-Smtp-Source: AHgI3IZYoGb9V2NtKsZoQ/ub9vxxr9OyHyrYqvzmb16SwTeQ6D2nvKJxvciF+Z2F3qrhSYFLKCnp19IfQka+U4MI+VRa
X-Received: by 2002:a05:620a:14ad:: with SMTP id x13mr10764437qkj.34.1549911207222;
 Mon, 11 Feb 2019 10:53:27 -0800 (PST)
Date:   Mon, 11 Feb 2019 10:53:23 -0800
In-Reply-To: <CANq=j3u-zdb_FvNJGPCmygNMScseav63GhVvBX3NcVS4f7TejA@mail.gmail.com>
Message-Id: <20190211185323.75409-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CANq=j3u-zdb_FvNJGPCmygNMScseav63GhVvBX3NcVS4f7TejA@mail.gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH v6 1/1] protocol: advertise multiple supported versions
From:   Jonathan Tan <jonathantanmy@google.com>
To:     steadmon@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > > +void get_client_protocol_version_advertisement(struct strbuf *advert)
> > > +{
> > > +   int i, tmp_nr = nr_allowed_versions;
> > > +   enum protocol_version *tmp_allowed_versions, config_version;
> > > +   strbuf_reset(advert);
> > > +
> > > +   version_registration_locked = 1;
> > > +
> > > +   config_version = get_protocol_version_config();
> > > +   if (config_version == protocol_v0) {
> > > +           strbuf_addstr(advert, "version=0");
> > > +           return;
> > > +   }
> >
> > Why is protocol v0 special-cased like this?
> 
> To semi-preserve the existing behavior that no version negotiation would
> happen when the config specifies version 0. Now we'll send out a version
> advertisement where we wouldn't have before, but we only advertise v0 so
> that no negotiation can happen.

Ah, I see.

This might be an argument for deciding that the protocol versions are
strictly orderable. I don't recall any discussions around this, but it
makes sense to me that someone specifying version 1 would be OK with
version 0 but not version 2, and someone specifying version 2 would be
OK with any of 0, 1, and 2. So I'm OK with making it effectively
strictly orderable by introducing the concept of a maximum.

And if we have this concept of a maximum, then we can have the
no-negotiation-if-v0-configured behavior without any special cases.

> > > +   if (tmp_nr > 0) {
> > > +           ALLOC_ARRAY(tmp_allowed_versions, tmp_nr);
> > > +           copy_array(tmp_allowed_versions, allowed_versions, tmp_nr,
> > > +                      sizeof(enum protocol_version));
> > > +   } else {
> > > +           ALLOC_ARRAY(tmp_allowed_versions, 1);
> > > +           tmp_nr = 1;
> > > +           tmp_allowed_versions[0] = config_version;
> >
> > In this "else" block, wouldn't this mean that if we forget to declare
> > any versions, we might send an unsupported version to the server? I
> > didn't check this, but it might happen if we invoked
> > transport_fetch_refs() without going through any of the builtins (which
> > might happen in the case of a lazy fetch in a partial clone).
> 
> Hmm yeah. I changed the else{} here to die if we haven't registered any
> versions prior to creating the advertisement string. t0410 case 9 and
> t5702 case 20 both fail, and both are lazy fetches in partial clones.
> 
> In this case, defaulting to the version in the config works, because
> fetching is valid for all protocol versions. But if we ever add some
> version X where fetching hasn't been implemented this would break.
> 
> Should we change the else{} case here to be a BUG() and then fix
> fetch-object to register its supported versions?

Yes, I think so.

> > > diff --git a/protocol.h b/protocol.h
> > > index 2ad35e433c..88330fd0ee 100644
> > > --- a/protocol.h
> > > +++ b/protocol.h
> > > @@ -14,7 +14,24 @@ enum protocol_version {
> > >   * 'protocol.version' config.  If unconfigured, a value of 'protocol_v0' is
> > >   * returned.
> > >   */
> > > -extern enum protocol_version get_protocol_version_config(void);
> > > +enum protocol_version get_protocol_version_config(void);
> > > +
> > > +/*
> > > + * Register an allowable protocol version for a given operation. Registration
> > > + * must occur before attempting to advertise a version to a server process.
> > > + */
> > > +void register_allowed_protocol_version(enum protocol_version version);
> >
> > I think the allowed protocol versions have to be transport-scoped. A
> > single builtin command may invoke multiple remote commands (as will be
> > the case if a lazy fetch in a partial clone is ever required).
> 
> Wouldn't it need to be per-transport per-command then? For example, if
> we ever added a hypothetical git-fetch-then-rebase-then-push builtin, we
> couldn't use the same version advertisement for the fetch and the push,
> even if they're still using the same transport. Or would we have to use
> separate transport objects for the fetch and the push in such a
> situation?

If we make each implementation of the vtable function read the config
and compute its own list of allowed protocols (is this what you mean by
"make each vtable entry declare its versions" below?), then we still
leave open the possibility of using the same transport object for fetch
and push.

> If we do move the version list into the transport, what would be the
> right way to register the allowed versions? Maybe we would make each
> vtable entry declare its versions?

This makes sense to me. I think that the implementations of
transport_vtable.connect might need to take in a list of versions, but
fetch and push can probably read the config by themselves so the API
does not need to change.
