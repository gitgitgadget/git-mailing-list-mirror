Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB8481F404
	for <e@80x24.org>; Sun, 25 Mar 2018 18:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754000AbeCYSmd (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 14:42:33 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52620 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753993AbeCYSma (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 14:42:30 -0400
Received: by mail-wm0-f68.google.com with SMTP id l9so11597475wmh.2
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 11:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=jAESmczH3tUTe6ucJU6sGwJ3qDJUQz2O8e/IR5foojw=;
        b=aAlUDxREvBrpJZ5M9GCsx2L3eeg5zXKRvrTZbfQ2EjafUJIkK30gFGvaUyU30EMIjD
         rLY09eaOd2WNrmT/R+2ODGvO8byV2hE3d/Xcta1LXrpJ/5MHpTT61roc4yi7XQfdFtHT
         AeD9T+7025N+J1SHtOCVa9MeH0mYEkUVeipVGKrwYI1HzulI6btB9TkyhwbyfnbCKxKj
         LK1Up/mfls5l8zeBYQyuCb6bUwPoyfX7kRATQaLAfK1or244q7QMkreZPBLz3D1oMMD1
         uE/jYdGUcymGtKaBQm0K7vLTggej2RurrgLR5+5zEcKtB58vj5GETGdF/9XTMlD8AlGb
         K1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=jAESmczH3tUTe6ucJU6sGwJ3qDJUQz2O8e/IR5foojw=;
        b=BZMxBAjoPzGdI2NpxoHHco0f18j/oI4jNqgOL0Wn1f0Et4JFmBEkVyt1XGo/94RbcO
         dKuVEYWbPw4AjAlYJeMClQBwvJBm5OtjOiUDpsCf2WQbfSkQSt0Wel5uWBdt/Z0UTYRM
         ou8C6aO0JIHpTfT0mWhFcbxjE6usck/+ws1+Cy0zaBkcxj03+G4GU0xpO54xOHTYbb26
         ZLkx3HiZcUCViNPLhUXqWeRk8q62438FBQtyzeHWNA6RIll12kWsojVWq6k8pYHhCBxO
         GBS+brQRkT3k0fl0YerS/+/khgzyzitCCJIKq3xu6dRmY6IPBBaG0xcJ4XIoLECTPiTf
         rIRA==
X-Gm-Message-State: AElRT7HEqLBlxjFRzxt3dfimiZHIvmIzM68Tgx6/Tj7enXZQhIc8d+VV
        6jmWltahSYz2RZ+gvtG/tZo=
X-Google-Smtp-Source: AG47ELt4pda756khXrqKwjSmlwdBwfXt2u4CZsrvNt+skaY6+hX341ppM0lsNdW15lKwRT23jhpm5A==
X-Received: by 10.80.240.211 with SMTP id a19mr6939044edm.77.1522003348917;
        Sun, 25 Mar 2018 11:42:28 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id s10sm9231455edc.63.2018.03.25.11.42.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 11:42:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Takuto Ikuta <tikuta@chromium.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.17.0-rc1
References: <xmqqtvt9nr7p.fsf@gitster-ct.c.googlers.com> <87k1u2y8pg.fsf@evledraar.gmail.com> <e2d0a2e2-44a1-9aa6-9c52-e341b44c18f4@gmail.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <e2d0a2e2-44a1-9aa6-9c52-e341b44c18f4@gmail.com>
Date:   Sun, 25 Mar 2018 20:42:27 +0200
Message-ID: <87a7uwxai4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 25 2018, Derrick Stolee wrote:

> On 3/23/2018 1:59 PM, Ævar Arnfjörð Bjarmason wrote:
>> On Wed, Mar 21 2018, Junio C. Hamano wrote:
>>
>>> A release candidate Git v2.17.0-rc1 is now available for testing
>>> at the usual places.  It is comprised of 493 non-merge commits
>>> since v2.16.0, contributed by 62 people, 19 of which are new faces.
>> I have this deployed on some tens of K machines who all use git in one
>> way or another (from automated pulls, to users interactively), and rc0
>> before that, with a few patches on top from me + Takato + Duy + Derrick
>> since rc0 was released (and since today based on top of rc1). No issues
>> so far.
>>
>> The specific in-house version I have is at:
>> https://github.com/git/git/compare/v2.17.0-rc1...bookingcom:booking-git-v2018-03-23-1
>
> Thanks for testing the commit-graph feature, Ævar! I'm guessing you
> have some mechanisms to ensure the 'git commit-graph write' command is
> run on these machines and 'core.commitGraph' is set to true in the
> config? I would love to hear how this benefits your org.

I haven't deployed any actual use of it at a wider scale, but I've done
some ad-hoc benchmarking with our internal version which has your
patches, and the results are very promising so far on the isolated test
cases where it helps (that you know about, e.g. rev-list --all).

So sorry, I don't have any meaningful testing of this, I just wanted an
easy way to ad-hoc test it & make sure it doesn't break other stuff for
now.

I also threw out most of the manual git maintenance stuff we had and
just rely on gc --auto now, so as soon as you have something to
integrate with that, along with those perf changes Peff suggested I'm
much more likely to play with it in some real way.
