Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DCF420372
	for <e@80x24.org>; Fri,  6 Oct 2017 19:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752494AbdJFTmO (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 15:42:14 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:55622 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752390AbdJFTmN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 15:42:13 -0400
Received: by mail-pf0-f176.google.com with SMTP id 17so1679538pfn.12
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 12:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZApzSLoeS4PGX1sH95e3PQCGmnlCcBX8ohCXzwquBbU=;
        b=BeZHevrBkimB+8CCWOGDIn5LlDNnc+4uwsW/bhWuP7n9Ieu26cJvX2mR4OjGRoZgQr
         pob+Jr2GufK3tJJeOk0YC2UvbURm5JpnigFiqk0GSrQdLTUGnd31qSDaZeCeXZBSwMRe
         ORnj7tB8z0exNjs/5qS8skgJwyweUSZ8tYHGRzAaHhYokQzsBg3/MQ3/n3jc/WSxwnnQ
         CyWBBhKTmZCEAkF2dsK6loQXtmFqJnc1MoGi8oZ2sU1C50wuiFPI+xYdPpSlHRncrWFl
         PVON8EmnfTeU+YfZlPeGxbFYBETpLcP+VkLWhPy862DGu2KSLrB4/SrXj5E8vQ2OIoBk
         sQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZApzSLoeS4PGX1sH95e3PQCGmnlCcBX8ohCXzwquBbU=;
        b=BrCkHS8AFVB6E84Z8VIfb0JsnpxQUyeoy8JbJqhpRogjzJ5yGzSGJszoRPTQOyXDDq
         vYX7dRDG6iFIcN+mtUONTrOnh4haw7X27dF65+WK3jVgLz48RO8V5FuGfdsWH4KV+Ogn
         6GWtJR8lhJQtsLpfDsQaZ+YgH9gicUqkp2jJ+CV6gO1+vRONl/PbyiOf6+HebTIHPTFo
         Fq+bckvfImsrzXDUfNQRYH8pc3aa4bFX8AiW6mgFCnknMaaRDHfpO86tRCr996YVWlNE
         5h/eXGPvUcKwH8ceeJpC3hrk52jk0RDQchG8LP7my4xeb2gETKbyNsKWLoeuADdsmLL9
         AiFQ==
X-Gm-Message-State: AMCzsaVj0kFrZZ6aXLE5b0AiCXgWvE8JMMgSKeeUomTqgyVJocFP/1R9
        x4vYaIcRSdKtGNT+LBBENwnA6AslHlf9jbBdW6w=
X-Google-Smtp-Source: AOwi7QDFmTNywrSx0jceb8H1YDhq2ZQ502HueqTv/mmMbQSDDzvHoOBdr4Buc2V0G4g3s83ZMQ9l6Ug7MaV2v2tb9aA=
X-Received: by 10.101.80.140 with SMTP id r12mr2835986pgp.267.1507318932684;
 Fri, 06 Oct 2017 12:42:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.156.137 with HTTP; Fri, 6 Oct 2017 12:42:11 -0700 (PDT)
In-Reply-To: <xmqqr2ugv5om.fsf@gitster.mtv.corp.google.com>
References: <20170926235627.79606-1-bmwill@google.com> <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-4-bmwill@google.com> <20171006090907.gbsgygulzj3bgqrg@ruderich.org>
 <xmqq4lrcwr5c.fsf@gitster.mtv.corp.google.com> <CAN0heSrWekXdzqzhL3Lk37YOGPHUdKCDU85t3hJgqK7PSVBZ_g@mail.gmail.com>
 <xmqqr2ugv5om.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 6 Oct 2017 21:42:11 +0200
Message-ID: <CAN0heSo28RYmZKxY4UXq9ewVgYGJCXGf-6KSzkOB-enZppv5qg@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] protocol: introduce protocol extention mechanisms
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Simon Ruderich <simon@ruderich.org>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        bturner@atlassian.com, Jeff Hostetler <git@jeffhostetler.com>,
        jonathantanmy@google.com, Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 October 2017 at 14:09, Junio C Hamano <gitster@pobox.com> wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
>> Maybe I'm missing something Git-specific, but isn't the only thing that
>> needs to be done now, to document/specify that 1) the client should send
>> its list ordered by preference, 2) how preference is signalled, and 3)
>> that the server gets to choose?
>
> I think Simon's reminder of Stefan's was about specifying something
> different from (1) above---it was just a list of good ones (as
> opposed to ones to be avoided).  I was suggesting to tweak that to
> match what you wrote above.

I replied to your mail, but also to the general notion of "we need a
carefully designed configuration and fall-back strategy before we can
include this series" which I sensed (and which I hope I didn't just
misrepresent). I didn't make it very clear exactly what I was replying
to, sorry about that.

Note that my 1-3 above are not about "configuration", which I interpret
as "how does the user tell Git how to select a protocol version?", but
about the protocol, i.e., "how do the client and server agree on which
version to use?".

>> Why would a server operator with only v0 and v1 at their disposal want
>> to choose v0 instead of v1, considering that -- as far as I understand
>> -- they are in fact the same?
>
> Because we may later discover some reason we not yet know that makes
> v$n+1 unsuitable after we introduce it, and we need to avoid it by
> preferring v$n instead?

For n in general, I agree completely. For n=3D0, and in particular for a
Git which only knows v0 and v1, I'm not so sure. If v1 has a problem
which v0 doesn't, then to the best of my understanding, that problem
would be in this series, i.e., in the version-negotiation. And to
minimize risk in that area, we'd want to make this series more complex?
That might be the correct thing to do -- certainly, if we botch this
series totally, then we might be in big trouble going forward --, but
it's not at all obvious to me. Nor is it obvious to me that such an
escape-hatch needs to be a multi-choice, prioritized configuration.

If a fall-back mechanism to v0 is wanted on the first Git server with
v1/v0, the simplest approach might be to make the server respect
protocol.version (possibly with a default of 1!?).

I might be naive in thinking that protocol.version could be removed or
redefined at our discretion just because it's marked as "experimental".

Martin
