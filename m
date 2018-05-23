Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D7A31F42D
	for <e@80x24.org>; Wed, 23 May 2018 23:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935087AbeEWXd6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 19:33:58 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35793 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935022AbeEWXd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 19:33:57 -0400
Received: by mail-wm0-f47.google.com with SMTP id o78-v6so179657wmg.0
        for <git@vger.kernel.org>; Wed, 23 May 2018 16:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0bh5iWA5UBBQWcYTsTXzuAaTsdC5F5qEdnewzFM8elc=;
        b=GtX9AMV1yn/YkANW6BOgWFXBPkSu/gnIk8t0harDdw/t0oii6x1l3w4+KGOdaoife+
         Gj+tCgbDkd/7OMFi+Rfmo/UxvaUWUiYy89gsWBx6O8XUINcUYKHiEuBq0eSK8xjUIcRH
         hHM3Sl16dmqN/ZlKHsdBrf8yQb9c7wMux3Oa1YaRtmEwE6U67vJBsEAeEdKhBrz3Mo0x
         EP9rDE/PeL13l/t/p9HUoEwGHA9yCUqYWMuzY2gjwmtqiry5acIVn0afi7QIKaRPu41t
         aojhhqi8eeAjMMUgkjtV4zWGHAMr3tpREV/yahbsgjxmz5lCuKeZmGuGcmHUtvVuC9ZC
         edVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0bh5iWA5UBBQWcYTsTXzuAaTsdC5F5qEdnewzFM8elc=;
        b=jEP2LoId2pMTr4pHrdj1gbq/Je/hlg/P/PTz+Ch7+/0H4baTYhDDTH1Ku0SZu3gkpD
         EajVqLuMSECveOtAUvkiZx8T0QWS3VtE/jZwuABg/WHP+/g3OyLBV4EsetxPzai9aYL1
         DAhUjYZplWMRpu0ous7gfS5m5wvl2d2i8ubfYSnFHUuxq21GrhwuOUyeIGdqGwBx6UAY
         1HezO1KnR2UJYSlmsJ/4sZlR8UBeVAvKBcHnaUxgnelPxFNHU4LHqr9VRPndok+oYmH9
         Z90iSZu5+DaSgVMx5vQSl0D4APBMxvCkNi9YntGW2CAFJ6CEJPKQ/tvxIo1aVtDnGHx1
         8X3Q==
X-Gm-Message-State: ALKqPwffrK0Vnqkt+MjP36w3qJP3LpSETsZus4g/qYYlbPjnOumvhqNl
        vZy0oGzz0YjJG/vBDrFq/+g=
X-Google-Smtp-Source: AB8JxZqbbWhEm9f/lUweKyahQemRxbuH3XoPVFWZEkopJbD4qHEIG/TBAJS2IcvrxjSZ1AlA5NXS2Q==
X-Received: by 2002:a1c:1f13:: with SMTP id f19-v6mr5011043wmf.73.1527118435405;
        Wed, 23 May 2018 16:33:55 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h188-v6sm3505396wmf.8.2018.05.23.16.33.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 May 2018 16:33:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: should config options be treated as case-sensitive?
References: <alpine.LFD.2.21.1805220353370.989@localhost.localdomain>
        <87h8mz99d2.fsf@evledraar.gmail.com>
        <xmqqo9h7w2y2.fsf@gitster-ct.c.googlers.com>
        <alpine.LFD.2.21.1805230354270.16358@localhost.localdomain>
        <xmqqd0xmvjcq.fsf@gitster-ct.c.googlers.com>
        <alpine.LFD.2.21.1805230503500.18721@localhost.localdomain>
Date:   Thu, 24 May 2018 08:33:52 +0900
In-Reply-To: <alpine.LFD.2.21.1805230503500.18721@localhost.localdomain>
        (Robert P. J. Day's message of "Wed, 23 May 2018 05:04:21 -0400
        (EDT)")
Message-ID: <xmqq8t8aueu7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

>> Unfortunately, that line of thinking leads us to madness, as you are
>> exhibiting the typical symptom of "my today's immediate itch is the
>> most important one in the world"-itis....
>
>   fair enough, point taken.

FWIW, everybody suffers from it, including me.

I was trying to come up with an update, and here is an attempted
rewrite of the earlier section.  I am not sure if this is a good
direction to go in, but if so, we'd need to reduce the duplicated
info from the Syntax section that immediately follows.

 Documentation/config.txt | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git i/Documentation/config.txt w/Documentation/config.txt
index 84e2891aed..5b79411b4b 100644
--- i/Documentation/config.txt
+++ w/Documentation/config.txt
@@ -9,13 +9,21 @@ fallback values for the `.git/config` file. The file `/etc/gitconfig`
 can be used to store a system-wide default configuration.
 
 The configuration variables are used by both the Git plumbing
-and the porcelains. The variables are divided into sections, wherein
-the fully qualified variable name of the variable itself is the last
-dot-separated segment and the section name is everything before the last
-dot. The variable names are case-insensitive, allow only alphanumeric
-characters and `-`, and must start with an alphabetic character.  Some
-variables may appear multiple times; we say then that the variable is
-multivalued.
+and the porcelains. The variables are divided into sections, and some
+sections can have subsections.  In a variable name that is fully
+spelled out, the part up to the first dot is the section, the part
+after the last dot is the variable.  If these two dots are not the
+same, what's in the middle is the subsection.
+
+The section and the variable names are case-insensitive, allow only
+alphanumeric characters and `-`, and must start with an alphabetic
+character.  Often multi-word variable names are spelled in CamelCase
+by convention for extra readability.
+
+Some variables may appear multiple times and their effects accumulate;
+we say then that such a variable is multivalued.  For other variables, 
+when they appear more than once, the last one takes effect.
+
 
 Syntax
 ~~~~~~
