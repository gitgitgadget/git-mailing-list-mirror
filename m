Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDC291F404
	for <e@80x24.org>; Fri, 23 Mar 2018 21:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbeCWVSX (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 17:18:23 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:33023 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbeCWVSU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 17:18:20 -0400
Received: by mail-qt0-f178.google.com with SMTP id i8so14041648qtj.0
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 14:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=f4PmmYq77LPcSUlDNgMigoqLbXf7uSA9CeiKbip8qdU=;
        b=n8twPx7cvGYxIIlwSuy6sS4vW3J6EmgBhQ7NeiHleJarWdN/YEYh8B7BPLbc1PAzjT
         CueHbf1sVAKW8qvEuXkZ/N4afHkJV9Ud9pLQ5DnJZzUyLC3WeVavQUOffiK8IToWnAx+
         O1yhhry38O1H+0vSAHgnnx82z1dvmQvWWzzpqmdi1YJD+sP6nfxOYJ1A8AJtGahtbZy2
         H/D+ARzrBIaENwmnbIVNuDtp2zw9Me9dyzL3vKQa/k4INYhAo6ooS/ue+uqZR+4TBVkv
         jSHmP2Md0s38YX2qg52qZkj9SifCCJfZ18Yd2lpqxokKN6G09tWpqYGY9Nq004R4u+3r
         ufJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=f4PmmYq77LPcSUlDNgMigoqLbXf7uSA9CeiKbip8qdU=;
        b=ZI/BYQhzsGkxHzR6Cjdb+8pgjepIviiSBXekSj/ek1vYqq4wwxjq5wu9smnrpZruWu
         xpjTFBbR107Z/sbMbxDfRp9dhYYSHQF2DYo5cB1uRPmNDpNen6/DOyeUZYwBU44xfanW
         2nZwATX6X/Kogd2QAvEHeOuB4EPmSyPNHAE7pz8QVHiZmEyvIlYMW3LifTTwrM5RmE+q
         9rpuju0mi4loujWenEW2PIdpSbheMLgSFnRdtm8jDuPQwvIK1WLI0xrNCdXlsnnBBBiL
         D73DvJ1wLX5Q4Ze/wFg6RvBqqB+jyDSsKR8GNrMyAn856NrhCg3NSZLSgIQnTP1puCj0
         6bOg==
X-Gm-Message-State: AElRT7GU821iUc+igE3TDnixJh3KfxzS2/geClUsDBlfpYWhEpHQLIru
        TVwHL3cQs+CkebEoXnduYGGBtuEXuWkb07oMeNM=
X-Google-Smtp-Source: AG47ELtKJ4OfNdh1J1/uAZZ4Lgi63poL6CfZWCn++D+3XPdMCw/AR5m93Ej1iqzQlCYlvMpHRzk5efQiCc1fpZGp49Y=
X-Received: by 10.200.69.131 with SMTP id l3mr44639700qtn.50.1521839899782;
 Fri, 23 Mar 2018 14:18:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Fri, 23 Mar 2018 14:18:19 -0700 (PDT)
In-Reply-To: <xmqqbmfeik0i.fsf@gitster-ct.c.googlers.com>
References: <cover.1521779249.git.wink@saville.com> <ed4cfdc9f31b920eae5055c3b080e2ca5b2f6e42.1521779249.git.wink@saville.com>
 <CAPig+cQG16AhLPMeOFAw1GF81oXivFSDHvQ5B8kX20YGAT_BxQ@mail.gmail.com> <xmqqbmfeik0i.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 23 Mar 2018 17:18:19 -0400
X-Google-Sender-Auth: LwJopMeyY2MWMQYF3hB0jAo0NVI
Message-ID: <CAPig+cT=0-+zgyGP7NEL3FFrc9bTDe9JLugoBqiFo5BtJq=2PQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4] rebase: Update invocation of rebase dot-sourced scripts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Wink Saville <wink@saville.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 5:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> (despite the run-on sentence in the first paragraph and the apparent
>> incorrect explanation of top-level "return" misbehavior -- the in-code
>> comment says top-level "return" was essentially a no-op in broken
>> shells, whereas he said it exited the shell).
>
> My bad, almost entirely.  Sorry.

No apology necessary. That minor error aside, your proposed commit
message gave just the right amount of detail for a person (me) not at
all familiar with the topic to be able to understand it fully and
intuit the patch content before even reading the patch proper. That's
a good commit message.
