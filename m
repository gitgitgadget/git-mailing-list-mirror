Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21FF92021E
	for <e@80x24.org>; Fri, 11 Nov 2016 09:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935890AbcKKJkV (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 04:40:21 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38637 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934434AbcKKJkR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 04:40:17 -0500
Received: by mail-wm0-f51.google.com with SMTP id f82so81467941wmf.1
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 01:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WZWYOjdOm0yCqxN1g8/20lkt31YQi9COMWIKK1NZX1I=;
        b=kTyY5QcSn5YYgTnV+1dY2GsA7YnR+swCiH5+oRmDl+2z9Ef65x3fH9Hmccf2TQMCFy
         qONMGfWhfaZ/m9UCoC3SZ6JN0W9s/tV/TyLzP1bU6D398QoQoUukfxkB17P17sEfywO9
         UU8Si6sUP4oG5oBHJEvIuMuXJMH1AYp4w69lU+fC12kxLDenDiClOqBPWdk6HuiXHvIR
         soYXu+q7hn+rnomb1KMbnmHO4OLXqnj8CGLG30oD00e8F/I1fish+YBGR0qxTFrvHDq4
         1oATtURjDtYJatvfekuOEjFRmNjic9MVA7hutUHfGDwlRUNbFH02eY6yWky0GSPJ6suU
         NrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WZWYOjdOm0yCqxN1g8/20lkt31YQi9COMWIKK1NZX1I=;
        b=XfP0aXLoR/qgIei03HtPMCQzXEJOYrdNcjjAuu1qevZwzPRFyc+IUTcX1HFiHQX722
         z6zPBNUGn2Kboeuy/xbpLB1gQs8nQTVox9j5KFLsKO7r+ZZMpe46RpYgyw+neb6pEtiA
         7xFrpFA5JPMygWFYJuUAibufALiT92aXZQOhcT38bnfer6rdEXggxhi+tvwJIagWdEtP
         t6DTkM4Ht6Yc12OobcABTCd6OMruS3TgdxjblcgshtipDXbcM8rfetgvz4kQUYKMKoZL
         Ub91uBkevQcPJDpLjfcknNEzZ/LKmx9CVjme6FwC2ggHNBJ9nnMGkjC9TBqie2KHQ4JC
         NVkg==
X-Gm-Message-State: ABUngvfhr5WWgyfKi2LxDcf/kgnKjL3CDR2fSDStn5Q2oxXPVkU6qijJSVOItPG3Ai3jEg==
X-Received: by 10.28.156.10 with SMTP id f10mr29201908wme.63.1478857215900;
        Fri, 11 Nov 2016 01:40:15 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB4736.dip0.t-ipconnect.de. [93.219.71.54])
        by smtp.gmail.com with ESMTPSA id yj10sm10250421wjb.3.2016.11.11.01.40.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Nov 2016 01:40:15 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [RFC] Add way to make Git credentials accessible from clean/smudge filter
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20161111093122.osbdwmze5x5t742v@sigill.intra.peff.net>
Date:   Fri, 11 Nov 2016 10:40:14 +0100
Cc:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        git <git@vger.kernel.org>, me@ttaylorr.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4060C484-B42E-42AB-BB42-4753373F0E7F@gmail.com>
References: <4C8C5650-7221-4F62-A9CC-81AE01EF6DC7@gmail.com> <vpqoa1n1qom.fsf@anie.imag.fr> <20161110160809.2gvf67rlnvounulf@sigill.intra.peff.net> <77603924-3552-4146-9C9E-A106CFA96D7A@gmail.com> <20161111093122.osbdwmze5x5t742v@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 11 Nov 2016, at 10:31, Jeff King <peff@peff.net> wrote:

> On Fri, Nov 11, 2016 at 10:28:56AM +0100, Lars Schneider wrote:
>=20
>>> Yeah, that is the solution I was going to suggest. The credentials =
are
>>> totally orthogonal to the filters, and I would rather not shove them
>>> into the protocol. It's an extra process, but with the new multi-use
>>> smudge filter, it's one per git invocation, not one per file.
>>=20
>> The trouble with "git credential" is that it works only if the =
credential=20
>> helper is setup correctly. Although I assume that most people have =
setup this,=20
>> I have also worked with a number of people who prefer to enter their =
passwords=20
>> every time Git makes a network connection.
>=20
> Are you sure about that? If I do:
>=20
>  echo url=3Dhttps://example.com/repo.git |
>  git credential fill
>=20
> I get prompted for a username and password.

Hm.. either I don't understand you or I expressed myself unclear.=20

Let's say a user runs:

$ git clone https://myrepo.git

If no credential helper is setup, then Git asks the user for =
credentials.
Afterwards Git starts downloading stuff. At some point Git will run my
smudge filter on some files and in my case the smudge filter needs the
Git credentials. AFAIK, the smudge filter has no way to get the =
credentials=20
from Git at this point - not even by invoking "git credential".=20
Is this correct?

- Lars=
