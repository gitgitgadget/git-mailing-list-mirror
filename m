Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38B3B20288
	for <e@80x24.org>; Thu, 20 Jul 2017 00:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933516AbdGTAG0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 20:06:26 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34670 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932173AbdGTAG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 20:06:26 -0400
Received: by mail-pg0-f45.google.com with SMTP id 123so6794085pgj.1
        for <git@vger.kernel.org>; Wed, 19 Jul 2017 17:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0yqEhDB2Q5BpePlrG96yQpNSYdOJkxqpPOm6IWMlpUQ=;
        b=iH9rdCXSt/gf0TujHw9sNe+3GbkNgQyXGzRvKm2r0KO6hvmn/cWUmD+3tropCMlTGZ
         nlRgSRAEaAvuoauo5qSCqojbZ6cjeqkdaxpn1TonLIDh1F+axlA72NpZHGCpROuAGJZn
         SB+bn1wTklQ4yTbxtNvU6YPkZovP24v88VyvI/5ps/0/l0czUvMz9spNoMxGUxDYeMeK
         EhLKqHk90yYHp7W79Mifw5HODuo2lpe9d4yE2rN1WyIKolo41FAhTqK3iYeDiVsRpbBX
         KYiaU+bgNTZA7gJWdVCsGen56YzCAbf+3jOhhk+z/2VsJUKicwxoUNr5lbjYeBBWFRR4
         snbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0yqEhDB2Q5BpePlrG96yQpNSYdOJkxqpPOm6IWMlpUQ=;
        b=DPej3bR7yTRcQkmjC8TzD2iJFWghlpcZZlDCEkwTmg3F7sfvm/WojD5uaukIErI50V
         PBilVWtygNmOTlB6jYYgiILM3RuKmKkye5cnR4wW+eNNOkCWSqVZ6KjcfFn3cx49/Phy
         JSFoHcq9Yw05lpL7GWYgV7sC+lAR0MZual7mCZYsJks0O/9oRAtTijMhRrEoTI0KXCRC
         UKHRJHtR6LOBHphMXXaTo812U3f049473949+zvVkN/qQfSFrsPVa3DteaJjLNR2iaS8
         +JZrvq5pJGMOCIs7LRdarg7AcT2mJ9F1pc8DRfLefR8AciY9wkL/DSnUWREtxO+I7zu+
         /GeQ==
X-Gm-Message-State: AIVw1101FN3NC3CHjD4ho9LjR1RZNBkfyNkaHLu10IoT0CejnXzaFGr9
        AUBmfdI2o3wxojp2US0llgFNSHn0BbYB
X-Received: by 10.99.105.200 with SMTP id e191mr1814962pgc.215.1500509185504;
 Wed, 19 Jul 2017 17:06:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Wed, 19 Jul 2017 17:06:24 -0700 (PDT)
In-Reply-To: <20170719165622.78e463fd@twelve2.svl.corp.google.com>
References: <cover.1499800530.git.jonathantanmy@google.com>
 <523f64e1395124a02316071329bedf9884757479.1499800530.git.jonathantanmy@google.com>
 <CAGZ79kZ9Ewxv=8fnRZZaQjpyAdv8df81a9aLRkJzEt5ZU0VcTA@mail.gmail.com> <20170719165622.78e463fd@twelve2.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 19 Jul 2017 17:06:24 -0700
Message-ID: <CAGZ79kYCr_Ozt3sa5FffgY-kzwAnGc2rTFEQ1AzeruURXQsYmA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] sha1-array: support appending unsigned char hash
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 19, 2017 at 4:56 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Tue, 11 Jul 2017 15:06:11 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
>> On Tue, Jul 11, 2017 at 12:48 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
>> > In a subsequent patch, sha1_file will need to append object names in the
>> > form of "unsigned char *" to oid arrays. Teach sha1-array support for
>> > that.
>> >
>> > Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>>
>> This breaks the oid/sha1 barrier?
>
> Not sure what you mean by this. This patch is meant to be a change to
> make "unsigned char *"-using code able to create/modify oid arrays,
> while we migrate away from "unsigned char *" - I don't know of any
> barrier.

In my mind we have 2 states:
* the current state where we have "char *sha1"
* the future in which we have "struct object_id oid"

In both realms you can do things (and the current code
base has examples for both), but these 2 are connected
via only a couple well defined functions (sha1_to_hex,
oid_to_sha1) during the conversion phase.

So with that mindset I was slightly irritated to see a function
that uses both realms so interchangeably.

Revisiting that it is actually not that bad, but also a good
idea to have in the transition phase.

Sorry for the noise,
Stefan
