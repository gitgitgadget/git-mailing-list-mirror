Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32D3F1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 12:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937778AbeFSMhN (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 08:37:13 -0400
Received: from mail-ot0-f177.google.com ([74.125.82.177]:33601 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937707AbeFSMhL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 08:37:11 -0400
Received: by mail-ot0-f177.google.com with SMTP id h6-v6so22376612otj.0
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 05:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ChHjmPShAd/Bd66Y1tgE4cfcF4ZnDDUVeOzSNbciQ2I=;
        b=AVOB5vw4kOV5kSjaasO2W8KS8pxCJ6GismKwoBOAjv+h+LgcCz0WPFAI4vWHn2dc+v
         O34kui6bP7BjEYel18C7B95S0sufvs/5hQ4fY08PO4qSNMaszgjdcC+lJrmJjpb50Iyo
         0PPdvIbPPaKJBWLEg2iigB+i8+nQso/EOa48Q/iuNUuoAjbJpoIpAqr8+Ltku8MJe3Mr
         nrXn73b9D30vT0g841Y5F9T4nFkMrrHCyVkM6FOx5B2Ue86HL1rHiKdu+voF6wotkcI0
         Ah99a+xcoekJ8ynyHH9hlcBRZ+2Qp/iGDyM9azfP7MNkBy/oaWi9DAUyK6p8S1AlpbgS
         cFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ChHjmPShAd/Bd66Y1tgE4cfcF4ZnDDUVeOzSNbciQ2I=;
        b=Q0VJtph8gniM+5C0vb1blirK55teD71S2ewM/uRtx734y2OcyajiAy+EKyhTKjxya9
         59raJmkcnjDnDIhAFX4ZrHVyQWjDmjZXyAmdkDvJ7Vl+lYW9LNAPjxzxOc028KJ2HPm9
         UvYXDJu/VgkUJVdmg7RQJsY7F63GvXMdTzXJmBnqcjd2ZfbSkSrYUnjr4sakXgJqhJ4G
         eT6P4sV+cEWJ6QMJD6snfaRuN3RQMHW9KbJPSHSnjavIOpbTrcof9McUZgLpDacfy1Pi
         kAWf8DKEfy8LAYjYX5VfUewWq1nZ+ZFIPP7DbBLCDF/m+GypMu4KidNce7ZObzsdXWOO
         Hq3A==
X-Gm-Message-State: APt69E2qn2ylp2BZYnNAwBm6CiQvpKz+1WBVbowBVw+VYXea0+HP9z/C
        GtoiRRSFhiwWSuzKEqRfyGRwLGKNQgDVaja8948=
X-Google-Smtp-Source: ADUXVKLKmyinsSPDnb09vF1ToIZRTESya8n5IYAh08pFA53pjue5a6Fzu3LMV2I5bol8liuEMuo80jFlXhtdw6tfvWc=
X-Received: by 2002:a9d:3047:: with SMTP id w7-v6mr9772838otd.281.1529411830918;
 Tue, 19 Jun 2018 05:37:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:754f:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 05:36:50
 -0700 (PDT)
In-Reply-To: <20180618212614.GA2504@sigill.intra.peff.net>
References: <CAENte7iUYcLX1ym1rdiYT2L8yLSWforf8kUvfHKLvhi_GhKQvg@mail.gmail.com>
 <20180614101342.GO38834@genre.crustytoothpaste.net> <20180614151507.GA6933@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1806171335480.77@tvgsbejvaqbjf.bet> <20180618041713.GA31125@sigill.intra.peff.net>
 <xmqqo9g8xf9k.fsf@gitster-ct.c.googlers.com> <20180618212614.GA2504@sigill.intra.peff.net>
From:   Christian Halstrick <christian.halstrick@gmail.com>
Date:   Tue, 19 Jun 2018 14:36:50 +0200
Message-ID: <CAENte7hzJw5VW2JFLV1Pj5v4u52=xL-dvhcfRACYa2eUvQnAVA@mail.gmail.com>
Subject: Re: OAuth2 support in git?
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What is not clear to me is how we can make use of the servers initial
response in
order control which credential helper to call and how to transport the
credentials.

Imagine we try to clone over http. The initial request sent to the server
may not contain a "Authorization: ..." header and the server responds
with Unauthorized.
But the server response contains hints like a "WWW-Authenticate: Basic
realm=..." line
or a "WWW-Authenticate: Bearer realm=..." line which helps choosing the
authentication scheme used next. Maybe the server even responds with both lines
telling I would accept BASIC or BEARER.

I can imagine that we want libcurl to deal with that decisions. But
even then. How
do we make sure the our credential helpers can act return either user/password
or bearer tokens based on the server response? If credential helper
would have access
to the servers response (or only relevant parts of it?) it could
decide whether to
feel responsible for that server or not and what data to return.

And if credential helper could optionally give metadata about the kind
credential they offer
(e.g. "I return user/password" or "I return a bearer token") then core
code could know
where to transport this data. E.g. in a "Authorization: Basic ..." or
a "Authorization: Bearer ..."
field.

Ciao
  Chris
