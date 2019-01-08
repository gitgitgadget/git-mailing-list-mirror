Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30EEA1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 23:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfAHX1R (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 18:27:17 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42954 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbfAHX1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 18:27:16 -0500
Received: by mail-lf1-f68.google.com with SMTP id l10so4227799lfh.9
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 15:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=XErxDhoR4Ck4IxT1m0HR4XzeS1uFRWHjZCfS+E8Pc04=;
        b=NcDZWvRxzJZ0MDoPS4DqviuF+mEZ627PTzOGr9ui9XRy0dnaNVXxOwZoHGxbR8arXf
         wbu94/2AmH/i5EHsEhAv1KAQoEhA74efzp7GBf4Ciev90g5JKvE3Cj/fLkJhpYB+hF7X
         FW306BZbWxBOIb6zBiVgygwUWlj7TdwGd66yJh9boizCmp4wjGuok5a3bRJRnMX930S1
         Vjvr/qpT8D+kxRGr3l0OPUEGTOLe0eFArk/ua+sYjQ6VQd4KFelDWWliAOH8U+krHzCm
         N5AERT/UeOhP1uKfsXYze4fDBWcajrEHFcvV2oFCxZgrmmhWw7ARydO5k/Vq0ihHO6mv
         UOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=XErxDhoR4Ck4IxT1m0HR4XzeS1uFRWHjZCfS+E8Pc04=;
        b=pI5+3yA1S/S6Y06pJhkMZw5MPDEaXXymKOpJRqsf15JU/HpPLvZRuiNqpF4LeRefE7
         YOzZuZK3ZIrIAGgIR0FTbZbF5IRumR+ucej/2vsmOMDjKEAGkj1Zpc4Z+H6tIICaG4Y3
         ayYBIIcWivOrTgPNH4gCtXzOtHGMlqAS5Xgszu+gcxndl09vCX14kp46wmYKpXR51VaA
         JTTfXM0GActvrNVCQb1QXqFXDG5sxxvnqmjVDzoWAWcXd05sSLDCl6V8LVcSD8Rfyo7A
         M+0+bH5vmHnL/sKRbN04cvwunSbXErTqiPeuYDa6LatuwLqi0TPfeRgqBku0769AP440
         822w==
X-Gm-Message-State: AJcUukewbd4WyxzjGGNofitsPLqUbqSbQdiUu5hW6qO9DQO3+JMy7fDl
        PSuDcrUFcAadyNBgSVwCRWnZxnGV3i4dkWLgt+Evww==
X-Google-Smtp-Source: ALg8bN6DNx05u1TRZG2CnChn/BQb7ec4i14+iPWAzkEApLt2rsEiyp993/fta9qaJG8/sKDVYZZu/kCFD4z7CTT+K8c=
X-Received: by 2002:a19:94d5:: with SMTP id o82mr1997470lfk.155.1546990033971;
 Tue, 08 Jan 2019 15:27:13 -0800 (PST)
MIME-Version: 1.0
References: <reply-to=20181127045301.103807-1-masayasuzuki@google.com>
 <20181229211915.161686-1-masayasuzuki@google.com> <20181229211915.161686-2-masayasuzuki@google.com>
 <20190107223324.GB54613@google.com>
In-Reply-To: <20190107223324.GB54613@google.com>
From:   Masaya Suzuki <masayasuzuki@google.com>
Date:   Tue, 8 Jan 2019 15:27:02 -0800
Message-ID: <CAJB1erXk8xTCw0McdD-J=kz3s4fnpmhEEUBdzgTbMgQ-ry0wLw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Use packet_reader instead of packet_read_line
To:     Josh Steadmon <steadmon@google.com>,
        Masaya Suzuki <masayasuzuki@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 7, 2019 at 2:33 PM Josh Steadmon <steadmon@google.com> wrote:
>
> On 2018.12.29 13:19, Masaya Suzuki wrote:
> > By using and sharing a packet_reader while handling a Git pack protocol
> > request, the same reader option is used throughout the code. This makes
> > it easy to set a reader option to the request parsing code.
> >
> > Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
> > ---
> >  builtin/archive.c      | 19 ++++++-------
> >  builtin/receive-pack.c | 60 +++++++++++++++++++++--------------------
> >  fetch-pack.c           | 61 +++++++++++++++++++++++-------------------
> >  remote-curl.c          | 22 ++++++++++-----
> >  send-pack.c            | 37 ++++++++++++-------------
> >  upload-pack.c          | 38 +++++++++++++-------------
> >  6 files changed, 129 insertions(+), 108 deletions(-)
> >
> > diff --git a/builtin/archive.c b/builtin/archive.c
> > index d2455237c..2fe1f05ca 100644
> > --- a/builtin/archive.c
> > +++ b/builtin/archive.c
> > @@ -27,10 +27,10 @@ static int run_remote_archiver(int argc, const char **argv,
> >                              const char *remote, const char *exec,
> >                              const char *name_hint)
> >  {
> > -     char *buf;
> >       int fd[2], i, rv;
> >       struct transport *transport;
> >       struct remote *_remote;
> > +     struct packet_reader reader;
> >
> >       _remote = remote_get(remote);
> >       if (!_remote->url[0])
> > @@ -53,18 +53,19 @@ static int run_remote_archiver(int argc, const char **argv,
> >               packet_write_fmt(fd[1], "argument %s\n", argv[i]);
> >       packet_flush(fd[1]);
> >
> > -     buf = packet_read_line(fd[0], NULL);
> > -     if (!buf)
> > +     packet_reader_init(&reader, fd[0], NULL, 0, PACKET_READ_CHOMP_NEWLINE);
> > +
> > +     if (packet_reader_read(&reader) != PACKET_READ_NORMAL)
>
> packet_read_line() can also return NULL if the packet is zero-length, so
> you may want to add a "|| reader.pktlen <= 0" to the condition here (and
> in other places where we were checking that packet_read_line() != NULL)
> to make sure the behavior doesn't change. See discussion on my previous
> attempt[1] to refactor this in builtin/archive.c.
>
> [1]: https://public-inbox.org/git/20180912053519.31085-1-steadmon@google.com/

That is interesting. In Documentation/technical/protocol-common.txt,
it says "Implementations SHOULD NOT send an empty pkt-line ("0004").".
The existing code won't distinguish "0000" and "0004", while "0004" is
actually not a valid pkt-line. I'll make this patch with no behavior
change, but I think we can make that behavior change to stop accepting
0004 as 0000, and remove the pktlen checks.
