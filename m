Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDCD41F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 09:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbeKTULt (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 15:11:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54788 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKTULt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 15:11:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id r63-v6so1439435wma.4
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 01:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=oxAY/hlKoMjQT0peXlWZXQbFNRe/osmvLBiWOnyD/fQ=;
        b=Kh82XLyC7PBOGh3UFeMar5E+1iOl9KCptdxVjlpDPYTz8uBYbADshyaA+7DoV+ZkPa
         Wbrbovt2W79XiULoE5+3XP5JkkZJSXF2P69FAyk2RgP1u9mugqMcA2u6Hyu9pRZDmaDc
         QXwQlyu4LEoH3LMg83m7HD/iTK7sUt6khHgPp6HQoq1wACHOkaadqbbDeZgFUznmKgfS
         MwIf7lMQrvP9CLOrqcgIerIM/elk9qQO3S/C3wGJqzEG+JHpllntIfy20CxyCrLwqS49
         RzoFP6cmBQGf5bVKbpWt6Zd86wIkloHB9sFPS2UTVQRE5iVs8sulgGzOcesicZl8Waip
         80bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=oxAY/hlKoMjQT0peXlWZXQbFNRe/osmvLBiWOnyD/fQ=;
        b=Kp5JEmhT73yWJ4yM0uSI5DfU8btP1qasDR0R1feu9jtXZ9p+6uzHjXwiCTtH9Rl5uZ
         XKqEYnaKbD4+ayLp4Z153yH/dJPtCPNgAos2jSMm578CTOFTH7dJ0+IsMq0a/hwSbcyd
         p0C/kV4smmY0J+G+++umi8ytJNw2ljubF5fLEDoesSJkTI5/da3aBXz2pamdHILOz0eF
         rwrzPtheKbEBjXPM8m9x7L2j30WQygmVujsoml8/yadR5VsJNz5H6GuPm+z/PxU7Smb/
         GZmF3mbVhbMq7CtDRhm+G9ctjF4Wwwoc8Rt9uXwYns+Y4FOUJ2rR65zBG6N5Ni2n867U
         LX3Q==
X-Gm-Message-State: AGRZ1gJ8AOP2dHowHXLIM9oi8jm9UJFu7G0o2TovQ0zUfRA1rMAnP6GE
        RRkWffWz+kx8PGRfKsnkgxsCMpWB2g0=
X-Google-Smtp-Source: AJdET5eFyskBoLZIdi4P/6SXOCp7GLxb+q59PIXnB/Jml4SN0EL+iccSyd/6LZgcZelfLMd3e92GaQ==
X-Received: by 2002:a1c:545e:: with SMTP id p30-v6mr1523924wmi.69.1542707013395;
        Tue, 20 Nov 2018 01:43:33 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id z15sm8043662wru.42.2018.11.20.01.43.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 01:43:32 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     sxenos@google.com, git@vger.kernel.org, sbeller@google.com,
        gitster@pobox.com, jonathantanmy@google.com, stolee@gmail.com,
        carl@ecbaldwin.net, dborowitz@google.com
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
References: <20181115005546.212538-1-sxenos@google.com> <87r2fm1hey.fsf@evledraar.gmail.com> <20181120011841.GB62243@google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181120011841.GB62243@google.com>
Date:   Tue, 20 Nov 2018 10:43:31 +0100
Message-ID: <87r2fgyth8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 20 2018, Jonathan Nieder wrote:

> Ævar Arnfjörð Bjarmason wrote:
>> On Thu, Nov 15 2018, sxenos@google.com wrote:
>
>>> +Parent-type
>>> +-----------
>>> +The “parent-type” field in the commit header identifies a commit as a
>>> +meta-commit and indicates the meaning for each of its parents. It is never
>>> +present for normal commits.
> [...]
>> I think it's worth pointing out for those that are rusty on commit
>> object details (but I checked) is that the reason for it not being:
>>
>>     tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
>>     parent aa7ce55545bf2c14bef48db91af1a74e2347539a
>>     parent-type content
>>     parent d64309ee51d0af12723b6cb027fc9f195b15a5e9
>>     parent-type obsolete
>>     parent 7e1bbcd3a0fa854a7a9eac9bf1eea6465de98136
>>     parent-type origin
>>     author Stefan Xenos <sxenos@gmail.com> 1540841596 -0700
>>     committer Stefan Xenos <sxenos@gmail.com> 1540841596 -0700
>>
>> Which would be easier to read, is that we're very sensitive to the order
>> of the first few fields (tree -> parent -> author -> committer) and fsck
>> will error out if we interjected a new field.
>
> By the way, in the spirit of limiting the initial scope, I wonder
> whether the parent-type fields can be stored in the commit message
> initially.
>
> Elsewhere in this thread it was mentioned that the parent-type is a
> field to allow tools like "git fsck" to understand the meaning of
> these parent relationships (for example, to forbid a commit
> referencing a meta-commit).  The same could be done using special
> commit message text, though.
>
> The advantage of such an approach would be that we could experiment
> without changing the official object format at all.  If experiments
> revealed a different set of information to store, we could update the
> format without having to maintain the memory of the older format in
> "git fsck"'s understanding of commit object fields.  So even though I
> think that in the end we would want to put this information in the
> commit object header, I'm tempted to suspect that the benefits of
> putting it in the commit message to start outweigh the costs (in
> particular, of having to migrate to another format later).

I think it sounds better to just make it, in the header:

    x-evolve-pt content
    x-evolve-pt obsolete
    x-evolve-pt origin

Where "pt = parent-type", we could of course spell that out too, but in
this case it's "x-evolve-pt" is the exact same number of bytes as
"parent-type", so nobody can object that it takes more space:)

We'd then carry some documentation where we say everything except "x-*-"
is reserved, and that we'd like to know about new "*" there before it's
used, so it can be documented.

Putting it in the commit message just sounds like a hack around not
having namespaced headers. If we'd like to keep this then tools would
need to parse both (potentially unpacking a lot of the commit message
object, it can be quite big in some cases...).
