Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2434020899
	for <e@80x24.org>; Fri, 11 Aug 2017 19:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753715AbdHKTCq (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 15:02:46 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:33299 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753581AbdHKTCp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 15:02:45 -0400
Received: by mail-qt0-f172.google.com with SMTP id a18so26267358qta.0
        for <git@vger.kernel.org>; Fri, 11 Aug 2017 12:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oCPhJgMUvEEgG4H+U37ChGpJpVOrYjw9h2o7oGu9jv4=;
        b=ZLTMT9FbxZbGqM9yNCgkCKANA8HYA28EZHw4oqd9o8XuG3RGAr+0DtMeOyzeLCMK5I
         NeTWF3uVN7nliOHAWO4Z+VXmDiE9BItGRdkNEriM1a83/7AV7yCmkjl+bXHw97uTnPeN
         3x8Ek4+9YD1VQMrgwvdtPHGdEj11psR0BH1TqKFl3pUxzDrQlWp07OVMk8TXDnAYuK5r
         cbGcVPbP1U56N66IUS+FH0qSEhynBRlel+Rv0Ieg3QVJz4gOTNPXyLlwRYOfPT+YPSXl
         BNOlkfTzALDnSuiLauLTRGwLUjqQKqAB+LozdPIdd5YyLln2F30cWb7YL7kqnnhmSzSq
         X+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oCPhJgMUvEEgG4H+U37ChGpJpVOrYjw9h2o7oGu9jv4=;
        b=W5u70eAD+ZMup9giLLyxjs2CT8Vz5jKgkb0Q4idxOmBqRfBVEK5XWlU4vxgumwcDLE
         dvVzMD59+naOGQczUKe/hi9eP07lAM3nYZryb3DGp772tYW2NZ1TUjKi+JIPBkNNnUDJ
         Ow77oQAM2CB6dqSv5q21+olJZaBdZUU+gX0kYmEbuwGhC7UNyaDi/iZIDpni+XPibgYd
         lnp0W0tCqbPBLQktnG9yNPg+IbJQsFDYbk4tKteU9LfIhrE/3bAAY0wLnNVSvS+bJMOK
         wNpGe33PwZ3xmr/p0mAVaPue+VFiH6XMySFNdHlA7L0Cmh+YwaHR3Qkv5UtBqVFhOhp3
         q2UA==
X-Gm-Message-State: AHYfb5gDPxQbfYj7Eeef0cmWC62WdUXq+7XJCvarE+pVrc/vIQcXtnTr
        JlTURLROSbbSe6FZQ405h5L6aebp/Q==
X-Received: by 10.200.10.199 with SMTP id g7mr21749445qti.13.1502478164487;
 Fri, 11 Aug 2017 12:02:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Fri, 11 Aug 2017 12:02:43 -0700 (PDT)
In-Reply-To: <20170811090615.ds3qlgudhdyxggpv@sigill.intra.peff.net>
References: <20170810080325.tehbbgajm4cgn2ku@sigill.intra.peff.net>
 <CAGZ79kabhz-FWNyjB6KjF4qpGfSqONBNVBcVd=+J=5XT+emz-A@mail.gmail.com>
 <20170810183713.z75bwk5eeavi6z22@sigill.intra.peff.net> <CAP8UFD2kWW41NDHVKjzdL2O2=QAeEtzKEPdJW3zR-zoeTiJPgw@mail.gmail.com>
 <CAGZ79kYeNb3sN4b8xZvYAjQOXWKP9oi+dNsJmS8fyz+iUH9p8A@mail.gmail.com>
 <CAP8UFD08oyY9eK-0Ydm2qh2etvc2_QGc0ujNswGUgUumwhy4+w@mail.gmail.com>
 <20170810211039.okpwglvcmkngzri2@sigill.intra.peff.net> <98b14604-33f1-6d91-8c9e-ddfa0c5cb0e7@ramsayjones.plus.com>
 <20170810231038.4s2btsotoq76atuu@sigill.intra.peff.net> <CAP8UFD3RWByUBZf=E_EBCW2Zk7voogfB+Qpsx4U2YNq0T0Hqag@mail.gmail.com>
 <20170811090615.ds3qlgudhdyxggpv@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 11 Aug 2017 21:02:43 +0200
Message-ID: <CAP8UFD0ngR7gpu=r3ba9JLK-Bnz+uQEt2T9HXNKw=XKKUhBesw@mail.gmail.com>
Subject: Re: [PATCH 4/5] interpret-trailers: add an option to normalize output
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2017 at 11:06 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Aug 11, 2017 at 09:02:24AM +0200, Christian Couder wrote:
>
>> > But I really don't want callers to think of it as "unfold". I want it to
>> > be "turn this into something I can parse simply". Hence if we were to
>> > find another case where the output is irregular, I'd feel comfortable
>> > calling that a bug and fixing it (one that I suspect but haven't tested
>> > is that alternate separators probably should all be converted to
>> > colons).
>>
>> Though "fixing" this after a release has been made might introduce a
>> regression for people who would already use the option on trailers
>> with different separators. That's also why I don't like --normalize.
>> We just don't know if we will need to "fix" it a lot to make sure
>> scripts using it will work in all cases.
>>
>> If we use --no-fold or --oneline instead, we don't promise too much
>> from this option, so users cannot say that they expect it to work for
>> them in all cases.
>
> But promising a normalized form is exactly what I want from the option.
>
> That said, I'm OK to promise that via "--parse", and call this --unfold,
> if you really feel strongly.

Yeah, I think promising these kind of things via an higher level
option that is a shorthand for a mix of other basic options is much
better especially if it's clearly documented that the option mix could
change in case of bugs or improvements.

This way people who want something stable, know that they should use
their own mix of basic options. And those who are ok with something
not as stable as long as it evolves towards a specific goal, know that
they should use the higher level option.
